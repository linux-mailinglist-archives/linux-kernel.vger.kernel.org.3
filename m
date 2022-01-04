Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51A1484165
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiADMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiADMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:00:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B9C061761;
        Tue,  4 Jan 2022 04:00:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C256134E;
        Tue,  4 Jan 2022 12:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE13C36AEB;
        Tue,  4 Jan 2022 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641297632;
        bh=+D1vaW9BzD2l5wcPaNuX4xy+vl5pegYNc8G8AMnELFA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J6ZYTOgXQVtI9D7XFtcUm8ZrkL8ysPr4AHaCWiJIZF/dSeZnzh2O0QpkyGf5ilkth
         9QOxgQBB1cvHXYijHiVlWiRUg0pQclNaLbcrh5qRtvt06rW7TDYsXhqmcr5RJ5QYPs
         04ZeTwb/W642OmliJx8QEwafYBsfRG4e869dk1fSCloFUYaNBFoikiJZcz5aLxdRMf
         LfDcs589a89iutODQWS+BT2GFB/tNkmmawahIddNrZa095nfa3knAjj1WZXa0u3JMT
         GVMh8bEd1GDrLUGm8RaRCOD9J3ezrQnhX26I7quzqysjXX2pvvj1ED39XRGUq7OZzW
         IXu1tPOfzqGQw==
Message-ID: <22cf685dbf61e09a4e5e7c3a48d1117a769548a8.camel@kernel.org>
Subject: Re: PROBLEM: SLAB use-after-free with ceph(fs)
From:   Jeff Layton <jlayton@kernel.org>
To:     Bastian Blank <bastian.blank@credativ.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Jan 2022 07:00:31 -0500
In-Reply-To: <YdQYEF9WCTWTAzOp@softhammer.credativ.lan>
References: <YdQYEF9WCTWTAzOp@softhammer.credativ.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-04 at 10:49 +0100, Bastian Blank wrote:
> Moin
> 
> A customer reported panics inside memory management.  Before all
> occurances there are reports about SLAB missmatch in the log.  The
> "crash" tool shows freelist corruption in the memory dump.  This makes
> this problem a use-after-free somewhere inside the ceph module.
> 
> The crashs happen during high load situations, while copying data
> between two cephfs.
> 
> > [152791.777454] ceph:  dropping dirty+flushing - state for 00000000c039d4cc 1099526092092
> > [152791.777457] ------------[ cut here ]------------
> > [152791.777458] cache_from_obj: Wrong slab cache. jbd2_journal_handle but object is from kmalloc-256
> > [152791.777473] WARNING: CPU: 76 PID: 2676615 at mm/slab.h:521 kmem_cache_free+0x260/0x2b0
> […]
> > [152791.777530] CPU: 76 PID: 2676615 Comm: kworker/76:2 Kdump: loaded Not tainted 5.4.0-81-generic #91-Ubuntu
> > [152791.777531] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/28/2021
> > [152791.777540] Workqueue: ceph-msgr ceph_con_workfn [libceph]
> > [152791.777542] RIP: 0010:kmem_cache_free+0x260/0x2b0
> […]
> > [152791.777550] Call Trace:
> > [152791.777562]  ceph_free_cap_flush+0x1d/0x20 [ceph]
> > [152791.777568]  remove_session_caps_cb+0xcf/0x4b0 [ceph]
> > [152791.777573]  ceph_iterate_session_caps+0xc8/0x2a0 [ceph]
> > [152791.777578]  ? wake_up_session_cb+0xe0/0xe0 [ceph]
> > [152791.777583]  remove_session_caps+0x55/0x190 [ceph]
> > [152791.777587]  ? cleanup_session_requests+0x104/0x130 [ceph]
> > [152791.777592]  handle_session+0x4c7/0x5e0 [ceph]
> > [152791.777597]  dispatch+0x279/0x610 [ceph]
> > [152791.777602]  try_read+0x566/0x8c0 [libceph]
> 
> They reported the same in all tested kernels since 5.4, up to 5.15.5 or
> so.  Sadly I have no tests with newer builds available.
> 
> Any ideas how I can debug this further?
> 
> Regards,
> Bastian
> 

At first blush, this looks like the same problem as:

    https://tracker.ceph.com/issues/52283

...but that should have been fixed in v5.14.

Do you have a more complete stack trace, preferably from your v5.15-ish
kernel? Log messages leading up to the WARNING may also be helpful. It
may be best to open a bug at https://tracker.ceph.com.

The log message before the [ cut here ] line, indicates that the client
was trying to drop caps in response to a session message from the MDS or
maybe a map change. Was the mount force-umounted or the client
blacklisted or something?

You may also want to try v5.16-rc8 if you're able to build your own
kernels. There were some patches that went in to improve how the client
handles inodes that become inaccessible.
-- 
Jeff Layton <jlayton@kernel.org>
