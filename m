Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE5535D67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350578AbiE0Jas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350230AbiE0Jar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00B8266AE2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653643845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ps73Vyt4yN+27PJzPF0JTccmiXVswx7yZqJIriLMxWk=;
        b=CHS10T2AEDPne/HtUkhr8Rd8UUBrX/xjMG8SXL3rxe8rIgiESMnWcVodxyANIj1qlND0DH
        DbAE3OGA04f8IRhWHZxKM1VkFiVQCWg3SLCC4YGRDjDergxPkD1poXMyUlbP/G7rTRiWvG
        AR47g3RoXjJIfBtovA68lxTYmyqMCVk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-iCDgyNaKOam64PAuHzOeKw-1; Fri, 27 May 2022 05:30:41 -0400
X-MC-Unique: iCDgyNaKOam64PAuHzOeKw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F80B1D32375;
        Fri, 27 May 2022 09:30:40 +0000 (UTC)
Received: from rh (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8E0492C3B;
        Fri, 27 May 2022 09:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1nuWIm-00CFqS-4E; Fri, 27 May 2022 19:30:36 +1000
Date:   Fri, 27 May 2022 19:30:34 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4 3/6] mm: shrinkers: provide shrinkers with names
Message-ID: <YpCaOmL2NfcLEAHi@rh>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-4-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525202600.2910982-4-roman.gushchin@linux.dev>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:25:57PM -0700, Roman Gushchin wrote:
> Currently shrinkers are anonymous objects. For debugging purposes they
> can be identified by count/scan function names, but it's not always
> useful: e.g. for superblock's shrinkers it's nice to have at least
> an idea of to which superblock the shrinker belongs.
> 
> This commit adds names to shrinkers. register_shrinker() and
> prealloc_shrinker() functions are extended to take a format and
> arguments to master a name.
> 
> In some cases it's not possible to determine a good name at the time
> when a shrinker is allocated. For such cases shrinker_debugfs_rename()
> is provided.
> 
> After this change the shrinker debugfs directory looks like:
>   $ cd /sys/kernel/debug/shrinker/
>   $ ls
>     dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-49
>     kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
>     sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
>     sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
>     sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
>     sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
>     sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
>     sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-vda1-37
>     sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-vda1-38

sb-xfs:vda1-36
xfs_buf-vda1-37
xfs_inodegc-vda1-38

That's a parsing nightmare right there. Please use the same format
for everything. You have <subsystem>-<type>:<instance>-<id> for
superblock stuff, but <subsys>_<type>-<instance>-<id> for the XFS
stuff. Make it consistent so we aren't reduced to pulling out our
hair trying to parse this in any useful way:

sb-xfs:vda1-36
xfs-buf:vda1-37
xfs-inodegc:vda1-38

FWIW, how we are supposed to know what actually owns these:

sb-tmpfs-1
sb-tmpfs-27
sb-tmpfs-29
sb-tmpfs-35
sb-tmpfs-49

tmpfs-27 might own all the memory - how do we link that back to a
mount point, container, user, workload, etc?

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com

