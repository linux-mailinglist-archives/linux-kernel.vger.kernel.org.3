Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94410514502
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356223AbiD2JFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiD2JFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:05:43 -0400
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4FC44E8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:02:20 -0700 (PDT)
Received: from [2c0f:f720:fe16:700::1] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1nkMVw-000094-MO
        for linux-kernel@vger.kernel.org; Fri, 29 Apr 2022 11:02:12 +0200
Received: from [192.168.42.209]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1nkMVu-0005GJ-RQ
        for linux-kernel@vger.kernel.org; Fri, 29 Apr 2022 11:02:10 +0200
Message-ID: <89e663fd-beea-3d4f-f8e9-5ecee31102eb@uls.co.za>
Date:   Fri, 29 Apr 2022 11:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-GB
To:     LKML <linux-kernel@vger.kernel.org>
From:   Jaco Kroon <jaco@uls.co.za>
Subject: FUSE: serialized readdir
Organization: Ultimate Linux Solutions (Pty) Ltd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

IMPORTANT DISCLAIMER:  Please note that I'm by no means a specialist
when it comes to filesystems, so I may be well off target here.

What we are experiencing:  concurrent readdir() operations on a single
folder is resulting in really, really bad performance for glusterfs
backed FUSE filesystems.  As long as only a single process is iterating
a specific folder (which can trivially contain upwards of 100k files)
then everything is reasonable (not necessarily great, but good enough),
but the moment where concurrent readdir sequences happen, things goes
for a stroll, all but one of the processes ends up in uninterruptable
wait, and basically things just goes downhill until we manage to back
things off and given adequate time it (usually) recovers.

I was hammering the glusterfs project on this, with no joy, and
glusterfs for one is known for "poor readdir performance".  Or
excessively bad "small file performance" (and I highly doubt one can't
get much worse than maildir++ structures in this regard) ... in our case
we can pin our performance issues for this particular filesystem
entirely on readdir().  readdir() performance internal to glusterfs can
probably do with a lot of work too, however, I am starting to think that
this is a death by multiple cuts scenario.  And this email is intended
to get some discussion around one of these potential cuts going.

From reading the code under fs/fuse/ (and having no real clue about the
larger filesystem core code), my understanding is that all readdir()
(and related, eg, getdents64) calls to FUSE filesystems comes through
readdir.c.

The file_operations structure is not particularly well commented, but
filesystems/vfs.rst gives some reasonable explanations.

So fuse sets .iterate_shared, and not .iterate - the latter stating
supports "concurrent dir iterators" - whether this is at folder level or
filesystem level is not explicitly stated, but I'm going to go with
filesystem level since that's as worded literally, and if it was
per-forlder then FUSE could simply have used .iterate rather them
implementing a mutex in private_data.

fuse seems to serialize on a per directory basis, this happens in
fuse_readdir() - where a mutex on struct file* is taken - one process
thus enters the code to first attempt a cached lookup (if permitted) and
then an uncached (which goes out to userspace, blocking all other
readdir()s on the same folder until userspace has responded).

The request going out to userspace (FUSE_READDIRPLUS or simply
FUSE_READDIR) contains the position at which the read needs to happen,
does it thus make sense to serialize readdir()s to one per folder? 
Other than perhaps for cache management?

Is there any way to get rid of this serialization?  Or how can I go
about figuring out the caching sequence stuff, keeping this cache makes
a lot of sense in order to avoid calls out to userspace, but it seems if
multiple threads are doing an "initial" uncached scan things gets really
messy and ends up causing lots of breakage, especially on larger
folders.  Isn't there already a cache at a "higher" layer?  I suspect
the fact that the two readers are unlikely going to be around the same
location w.r.t. doffset (ctx->pos) this results in lines 447 through 450
resetting pos to 0 - ie, start of scan, and thus effectively clobbering
the cash continuously, and restarting reads from userspace from position
0 repeatedly?

Anyway, I honestly don't understand the code in detail, especially the
cached version, wouldn't mind to but at this stage it feels a bit over
my head.  I may very well be very wrong about the above, in which case,
please do point me at something I can look at to better understand how
this works.

Other operations are within acceptable parameters (w.r.t. response
times) and we're otherwise comfortably dealing with around 2.5TB of data
spread over 10m files in total through FUSE.

Other operations too suffer once we get into one of these readdir() loop
problems, and even a simply LOOKUP operation at that point (on an
unrelated folder) can at these times trivially take up to 60 seconds,
normally in the millisecond range.

We are currently running a slightly older kernel, after having given
5.17.1 a shot, we've backed down again to 5.8.14 since we know that
works (5.17.1 was somehow just annoying us, we raised the one issue and
workaround here, and a bugfix was made thanks to the netfilter team, but
other things too just felt off which we couldn't quite pinpoint). 
Looking at the changelog for 5.17.2 through .5 there are a few possible
explanations but none which jumps out to me and screams "this is it". 
We still run 5.17.1 on one of the hosts that's slightly "out of band"
and doesn't affect our critical path, happy to upgrade that to 5.17.5 as
well as to test other patches relating to this.

Kind Regards,
Jaco

