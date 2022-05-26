Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17D95348DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346195AbiEZCZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiEZCZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:25:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9731BCEAD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:25:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so3246664pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EEnCAXzIKzBX8a+ZY+aJ2FVWSHOtVfgunLZbATQpn20=;
        b=W10EKExlpftJBTnBqjNUAtnsiAUfHnABsGE5AlTLAqMh7GqgMpzzub0qFeCKCVsYBI
         KeJESH3gU6ZRM3zCCloADhZvmBC34vbmJ1A0ux21YgEfEkXyTPMQiAj1FRTZH0dQdDs1
         Ekim+iwvxZin/MBLGykjoLbPHkGMRd+BmiMjRBL1XO9K9+EB0QkJGrGDG0O4InCtmhGP
         QtBOPPy1De6lyX/UaZGqAJMFyrpJCiwVTX5Dc+V8HtvDLPtGlskIVhgqJ70ddvHTgkSa
         zPy1N0vo40lEGaTADUjAp14MDRtNNTIx0XqsyM0IFtrQDE3o5cVsJMRTNTRLKtcEkA/F
         ox6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EEnCAXzIKzBX8a+ZY+aJ2FVWSHOtVfgunLZbATQpn20=;
        b=R95/jD0ct3xX0z0lc8FHbKNWFdlfZsFY7xvjdGWTazVwr64Gv6LdP2dnpIPix24a5N
         IYNChktg7rRZ9IiBQrEFUUlc9sVUOmnslVEuzkrzCe0FvVMcEcJFLJJEoDcpJsFrnvFS
         2Kc4Aoe9JVdESTrqGSgysuDeiL+VnO1KVZnBm9u/3jiJvayk2DCGPQ06bO9fpdLSbaPt
         zejF76WQksUBRKQ0MdZZceZvdc3AU3lvuHH3CtfXJ4JV+/tzHkzw7f/cCv090yIhoC4k
         MpAlNbDkvrXmXcZ2lDw0/3+t9QTkA7SZKsOPh/uPdaN3OkULrB1I/M7dkwCPL7nGMhsJ
         FORQ==
X-Gm-Message-State: AOAM530Z0DTazrKWCPyF9HPibyaZDYhFvUgkr85uP5POM8mJIeSCeIP9
        hOB8TlVsxaQOegh+2GrMuczNjQ==
X-Google-Smtp-Source: ABdhPJwt2BGjxkJfOxtlg5m/+6B4LdTBLKQa+0e8AbzcbMWNE7G8FrsvHIdGFRHX3S0IoeNB39MgNg==
X-Received: by 2002:a17:902:c7cd:b0:161:8b6f:73c3 with SMTP id r13-20020a170902c7cd00b001618b6f73c3mr35562226pla.156.1653531953263;
        Wed, 25 May 2022 19:25:53 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40c:3e14:bb57:48be])
        by smtp.gmail.com with ESMTPSA id j18-20020a170903025200b001624f2b71b4sm101208plh.152.2022.05.25.19.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:25:52 -0700 (PDT)
Date:   Thu, 26 May 2022 10:25:47 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 4/6] mm: docs: document shrinker debugfs
Message-ID: <Yo7lK1wp9fXi4obF@FVFYT0MHHV2J.googleapis.com>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-5-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525202600.2910982-5-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:25:58PM -0700, Roman Gushchin wrote:
> Add a document describing the shrinker debugfs interface.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  .../admin-guide/mm/shrinker_debugfs.rst       | 100 ++++++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/shrinker_debugfs.rst
> 
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index c21b5823f126..1bd11118dfb1 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -36,6 +36,7 @@ the Linux memory management.
>     numa_memory_policy
>     numaperf
>     pagemap
> +   shrinker_debugfs
>     soft-dirty
>     swap_numa
>     transhuge
> diff --git a/Documentation/admin-guide/mm/shrinker_debugfs.rst b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> new file mode 100644
> index 000000000000..2033d696aa59
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/shrinker_debugfs.rst
> @@ -0,0 +1,100 @@
> +.. _shrinker_debugfs:
> +
> +==========================
> +Shrinker Debugfs Interface
> +==========================
> +
> +Shrinker debugfs interface provides a visibility into the kernel memory
> +shrinkers subsystem and allows to get information about individual shrinkers.
> +
> +For each shrinker registered in the system a directory in **<debugfs>/shrinker/**
> +is created. The directory's name is composed from the shrinker's name and an
> +unique id: e.g. *kfree_rcu-0* or *sb-xfs:vda1-36*.
> +
> +Each shrinker directory contains the **count** file, which allows to trigger
> +the *count_objects()* callback for each memcg and numa node (if applicable).
> +
> +Usage:
> +------
> +
> +1. *List registered shrinkers*
> +
> +  ::
> +
> +    $ cd /sys/kernel/debug/shrinker/
> +    $ ls
> +    dqcache-16          sb-hugetlbfs-17  sb-rootfs-2      sb-tmpfs-49
> +    kfree_rcu-0         sb-hugetlbfs-33  sb-securityfs-6  sb-tracefs-13
> +    sb-aio-20           sb-iomem-12      sb-selinuxfs-22  sb-xfs:vda1-36
> +    sb-anon_inodefs-15  sb-mqueue-21     sb-sockfs-8      sb-zsmalloc-19
> +    sb-bdev-3           sb-nsfs-4        sb-sysfs-26      shadow-18
> +    sb-bpf-32           sb-pipefs-14     sb-tmpfs-1       thp_deferred_split-10
> +    sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-27      thp_zero-9
> +    sb-cgroup2-30       sb-proc-39       sb-tmpfs-29      xfs_buf-vda1-37
> +    sb-configfs-23      sb-proc-41       sb-tmpfs-35      xfs_inodegc-vda1-38
> +    sb-dax-11           sb-proc-45       sb-tmpfs-40      zspool-zram0-34
> +    sb-debugfs-7        sb-proc-46       sb-tmpfs-42
> +    sb-devpts-28        sb-proc-47       sb-tmpfs-43
> +    sb-devtmpfs-5       sb-pstore-31     sb-tmpfs-44
> +
> +2. *Get information about a specific shrinker*
> +
> +  ::
> +
> +    $ cd sb-btrfs\:vda2-24/
> +    $ ls
> +    count
> +
> +3. *Count objects*
> +
> +  Each line in the output has the following format::
> +
> +    <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1> ...
> +    <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1> ...
> +    ...
> +
> +  If there are no objects on all numa nodes, a line is omitted. If there
> +  are no objects at all, the output might be empty.

Should we add the following lines into here?

"
If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
printed for all nodes except the first one.
"

Thanks.
