Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D285095F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384110AbiDUE3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384102AbiDUE3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:29:37 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB812600
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:26:46 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id m19so1385871uao.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxeNHXPH62p1MM3dViS8VMAv5lfRWtwrnUsQzK/+pk0=;
        b=hpb65DWDNKWCr5K1UTnRgPuiUqPq07LZqLpUdOA/e/ZyiGO/WzZgPYchIFpzkCHtCn
         7exSLTGUj9XRy6FwX6tZFQbEnPPFXUhH+fAkKwJTL5JuQl17w+FzTCX684ieIIuz0jMu
         TojJq6o/GFGIC0ewKPSErd/7hlxnMbFe7EnOJnOVmlGOrmSZrAXtyQdnlP8Ldc7+qzo3
         /2vqlHcEq8oFsKzgI5weLRywsxbIjxQZGweg/f0FAQSTgV3Ps9nya9on/achYoLpYk3L
         OGwF4N7IjFeoiQpm6IVAAsznlt0igAZHMTruvifVvuSxMusXbyNwrj5hGQHSHYSt4mp/
         6R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxeNHXPH62p1MM3dViS8VMAv5lfRWtwrnUsQzK/+pk0=;
        b=DJlt8yGq0p+fiXytVNkpA4aVNmuGDDfWbOCkbJIM+/+/LTG7IwvSPSe/IBPnR/CQXp
         7Gm5VePhWGKivy3ORmW7Tq6w5OW1JtSkzriQwQrNmqYQV7AOLAfJwYr907z03gnILISE
         FlHLRD9xSRkZS08yIE3Ko+nqof4m60mqVKZW5pFBXS5UQ4RNy2PQ7ZDRXsnb8wdy7IPz
         TnJ+A0/BX1971jiojiOFY75E+VBvFKvKSr0w5ANg3d7WoGFbcU09y/pV1e5/iqbNzdok
         1YPz8G/RW6QZZATemARK6fmUmgdSK2evq108UdiMJm4apfQ1CfRYetqAqejTpwGegzGL
         /Y+A==
X-Gm-Message-State: AOAM532EdNbuNhz9RNWwLEZc18LTUMwBlh3ccZ5/dfBLVCLhuAPKjHgP
        Yay3jm/h5cLGMosOjDRr6c87TMZzpiqP+koX8QhnFw==
X-Google-Smtp-Source: ABdhPJyJa20VeKV+2tMqRgtLnWi8ys/9cj63Un+814wtWOubHE1RX3ONHhHbtG6SH7drv0LAbkjQ72wOSPnPt/JOmXg=
X-Received: by 2002:a9f:2046:0:b0:35d:bfc:2c9 with SMTP id 64-20020a9f2046000000b0035d0bfc02c9mr6754804uam.119.1650515205811;
 Wed, 20 Apr 2022 21:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092206.73974-1-jvgediya@linux.ibm.com> <20220413092206.73974-4-jvgediya@linux.ibm.com>
In-Reply-To: <20220413092206.73974-4-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 20 Apr 2022 21:26:34 -0700
Message-ID: <CAAPL-u9OHuRWXvc0RAPvEtLQLy0AkLbAwjZtGERhmhn-yFZgrw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: demotion: Add support to set targets from userspace
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>
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

Why should we restrict demotion targets to memory only nodes if they
get set explicitly from user space? For example, if we use NUMA
emulation to test demotion without actual hardware, these emulated
NUMA nodes can have CPUs, but we still want some of them to serve as
demotion targets.

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
