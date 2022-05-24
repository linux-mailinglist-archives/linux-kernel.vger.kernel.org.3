Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC25320D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiEXCSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEXCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:18:29 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF34249B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:18:28 -0700 (PDT)
Date:   Mon, 23 May 2022 19:18:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653358706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwZ14TNzwV7AXkhhom0Yxn4yVZGwmZFgzOylIxcaHJY=;
        b=qcY/dJXHNat/9ow3RS1PRkbR6hxEA/TvFkiBW40oxpLHUREfSSBG1Rpd2gluT6YRtZghag
        627i6fQ2XINgz2OZnNK8nyr1U51Ympsmi44+U+cm6MvG+4XZHdHMJFvZLccAdFj5IhaEQN
        mI/GrudKvL/oXOJjhmI1KT2Sqge0o00=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 3/6] mm: shrinkers: provide shrinkers with names
Message-ID: <YoxAboVWrONJZumm@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-4-roman.gushchin@linux.dev>
 <Yoq1lRlneWj59Mte@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoq1lRlneWj59Mte@rh>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 08:13:41AM +1000, Dave Chinner wrote:
> On Mon, May 09, 2022 at 11:38:17AM -0700, Roman Gushchin wrote:
> > Currently shrinkers are anonymous objects. For debugging purposes they
> > can be identified by count/scan function names, but it's not always
> > useful: e.g. for superblock's shrinkers it's nice to have at least
> > an idea of to which superblock the shrinker belongs.
> > 
> > This commit adds names to shrinkers. register_shrinker() and
> > prealloc_shrinker() functions are extended to take a format and
> > arguments to master a name.
> > 
> > In some cases it's not possible to determine a good name at the time
> > when a shrinker is allocated. For such cases shrinker_debugfs_rename()
> > is provided.
> > 
> > After this change the shrinker debugfs directory looks like:
> >   $ cd /sys/kernel/debug/shrinker/
> >   $ ls
> >     dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-50
> >     kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
> >     sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
> >     sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
> >     sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
> >     sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
> >     sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
> >     sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-37
> >     sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-38
>                                                             ^^^^^^^^^^^^^^
> 
> These XFS shrinkers are also per-block device like the superblock.
> They need to read like "sb-xfs:vda1-36". and even though it is not
> in this list, the xfs dquot shrinker will need this as well.

Sure, will do in v4. Thanks!

> 
> 
> >     sb-dax-11           sb-proc-45       sb-tmpfs-40      zspool-34
> >     sb-debugfs-7        sb-proc-46       sb-tmpfs-42
> >     sb-devpts-28        sb-proc-47       sb-tmpfs-43
> >     sb-devtmpfs-5       sb-pstore-31     sb-tmpfs-44
> 
> The proc and tmpfs shrinkers have the same problem - what instance
> do they actually refer to?

Any ideas on how to name/identify them?
