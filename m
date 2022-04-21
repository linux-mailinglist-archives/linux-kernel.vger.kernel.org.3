Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A245096DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384457AbiDUFea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384431AbiDUFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:34:25 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38B11A02
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:31:36 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j16so3580092vsv.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icdX8wVzZo3JrDb0bW5Ie4jOaoMl9IB4oVkMQclNfX4=;
        b=ZZliG6Hy0Gh6X2H7JimBi+en5Jw56OTPLOQy6IvZ6KtDROAMUJPIw9bjV+BqkwQMD0
         C71yEWUDs/cYEAxBXVvwGcWr/5YmdGXVI/B+iIMZMVSClV3BFWB0jI0SURggPt932OYh
         s4/+q3cuylr6r8+gUdHl17pry2+bRT9yiSVTy/AtCvZ9DuVC660SafCwBKdSuuiSK+4k
         eOlSxhMFg9WUmKKCg/e7U3f3ALpWvbrlkBPrQEJlJ5T43WuZZMWxMIJcZewbo/SUN5Qk
         3oX0VZ87W4C4JmUtPzHVH97uoVABDTZsy3y8xC3/J2Xhfq8yDUBvHuXrNVkmvbPgvp5F
         5uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icdX8wVzZo3JrDb0bW5Ie4jOaoMl9IB4oVkMQclNfX4=;
        b=xYcZsyRVjUCp5WIS6BD4XRls1id8A2RGqKDijRYiEdej8+LrYschTUacyPYX0tQuIX
         L4/CvZaULTCJn73xVsfyh3WTgzFMBbI/vjn7r2Z3CoYeG97xrkmZJTkaTNx5F6JJu/2o
         ZkvhB4sjsAHJzYxO4Jz1/wn0guIv7ic97/y9gnFRFOKhjvcYYgaPtSSptnhUagioasVd
         ykXQCdeKbp0l09W4kxSPLtJMizB+zMSpxOicdJnQJ9yilkjLj1fgge/Wvwatl0UjfsjX
         ukYj3i+391lHdNK7bugwUr6rkXxoWsOcEngUZBuzRj7HzJrQS1ML/iJAjDDfrEGZCA08
         QooA==
X-Gm-Message-State: AOAM533YGdKnl3KokBhzl/ULeZMW0PpqYw5ToIPQBVRHFva17xD8BaU4
        ozRCfHWmxZM81XhzS1qQ8R+6gDVpHFuwPFUVLMHEiA==
X-Google-Smtp-Source: ABdhPJzTDcuKT//xSjvoatymxjYhq3UToi+pXXJn5m6ahqjLFsrH45wZDRV5KiEVD4JB+OPltzH6PkDq8rFydfWZpfs=
X-Received: by 2002:a67:fd0b:0:b0:31b:e36d:31b1 with SMTP id
 f11-20020a67fd0b000000b0031be36d31b1mr7580181vsr.44.1650519095393; Wed, 20
 Apr 2022 22:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092206.73974-1-jvgediya@linux.ibm.com> <20220413092206.73974-4-jvgediya@linux.ibm.com>
In-Reply-To: <20220413092206.73974-4-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 20 Apr 2022 22:31:24 -0700
Message-ID: <CAAPL-u-p6hXynK7H3UcjGqrP-P9AAw2sQYGMYNwa75P9eBALXw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: demotion: Add support to set targets from userspace
To:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Greg Thelen <gthelen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 2:22 AM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>
> Add support to set node_states[N_DEMOTION_TARGETS] from
> user space to override the default demotion targets.
>
> Restrict demotion targets to memory only numa nodes
> while setting them from user space.
>
> Demotion targets can be set from userspace using command,
> echo <nodelist> > /sys/kernel/mm/numa/demotion_target
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---
>  .../ABI/testing/sysfs-kernel-mm-numa          | 12 +++++++
>  mm/migrate.c                                  | 35 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> index 77e559d4ed80..10e9e643845c 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> @@ -22,3 +22,15 @@ Description: Enable/disable demoting pages during reclaim
>                 the guarantees of cpusets.  This should not be enabled
>                 on systems which need strict cpuset location
>                 guarantees.
> +
> +What:          /sys/kernel/mm/numa/demotion_target

demotion_target -> demotion_targets?

Also, with the previous change, we already have
/sys/devices/system/node/has_demotion_targets (or demotion_targets as
I have suggested). Wouldn't it be simpler to make that sysfs file
writable instead of adding a parallel interface?

> +Date:          April 2022
> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
> +Description:   Configure demotion target nodes
> +
> +               Page migration during reclaim is intended for systems
> +               with tiered memory configurations. Preferred migration target
> +               nodes can be configured in a system using this interface, based
> +               on which demotion table is prepared in kernel. If demotion is
> +               enabled then pages will be migrated to set demotion targets
> +               during reclaim.
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 516f4e1348c1..4d3d80ca0a7f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2564,12 +2564,47 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
>         return count;
>  }
>
> +
> +static ssize_t numa_demotion_target_show(struct kobject *kobj,
> +                                         struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%*pbl\n",
> +                         nodemask_pr_args(&node_states[N_DEMOTION_TARGETS]));
> +}
> +
> +static ssize_t numa_demotion_target_store(struct kobject *kobj,
> +                                         struct kobj_attribute *attr,
> +                                         const char *nodelist, size_t count)
> +{
> +       nodemask_t nodes;
> +
> +       if (nodelist_parse(nodelist, nodes))
> +               return -EINVAL;
> +
> +       if (!nodes_subset(nodes, node_states[N_MEMORY]))
> +               return -EINVAL;
> +
> +       if (nodes_intersects(nodes, node_states[N_CPU]))
> +               return -EINVAL;
> +
> +       node_states[N_DEMOTION_TARGETS] = nodes;
> +
> +       set_migration_target_nodes();
> +
> +       return count;
> +}
> +
>  static struct kobj_attribute numa_demotion_enabled_attr =
>         __ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
>                numa_demotion_enabled_store);
>
> +static struct kobj_attribute numa_demotion_target_attr =
> +       __ATTR(demotion_target, 0644, numa_demotion_target_show,
> +              numa_demotion_target_store);
> +
>  static struct attribute *numa_attrs[] = {
>         &numa_demotion_enabled_attr.attr,
> +       &numa_demotion_target_attr.attr,
>         NULL,
>  };
>
> --
> 2.35.1
>
>
