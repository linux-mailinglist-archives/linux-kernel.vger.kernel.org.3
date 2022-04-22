Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9CA50C1A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiDVWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiDVWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:05:10 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D86286A82
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:47:41 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id v15so8549679vsm.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3kCe45Ef42+zfNVSfY+h/K0JcKt6IAqn76n4Nn+XkE=;
        b=mb19AejvDfB3ESuJOhiW4BkTKZbbNWaGd6wfu+7MnYw+OLby9IybJFzqpp1odbEem3
         bMWRaQg1DoP/9Po2wdWK+wANZh4iSKpO1qBrPQWEZ2uVpHuTakZsXCbo2jAi1z+iGhJb
         daO04fYKaWDNPcINAbXFP8pD9U0yIiXGx4+S73npj26FGgbNmXFLxINHOFVLD3T2/FVf
         E1bblFt+/lbATrvQlJpWygADsNev+J3Fr0DkzvIXCuB1CCsMqenQ4qXMHstdQhq4Tgbh
         i8G8WqGnKNz86nnGh1j5U3bJeXCPF70OVfpbZu0Lzemi4rOo0ycNhSS5nrNkG9xFWfh5
         CqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3kCe45Ef42+zfNVSfY+h/K0JcKt6IAqn76n4Nn+XkE=;
        b=Samn5xrAOiu0YGGSzv/xlEht6WUAR/8j2gdimMizOGBmNEZzGquIShRoxkXp25GacZ
         pWpxm7wieIaDWV4NVP9KGVapxcBgcYNKKrWSd7n2lIQN07W+rdWTkaGyQH2KUv4R+geb
         h6dHoHLf1CSHBtL8t8gNBMxkeII4/xQd83hvaW0UP3IDsYuSySK6NHWor7ZXldG2D5K2
         hP+vZo1cjC/ZTdGrBMEec4hbkBTEBtsseuw1vdK/A3eC32isxJynnITa/gnfgLQbha2k
         t8rtcNugG+9esnsA/ldVmXV+U2OLgFbdDiakjVE0Rjz3H4aoJmMnT1dgNA9A2+N5PT2y
         66pw==
X-Gm-Message-State: AOAM530TQHLkrNHS+DkPh5jnR11Tp3Ly19tVLGkCoImG+yjeuUE1cKVr
        vssnfTTfu99401zYVlxk+LJFal0FftBGgHuaxyg7Kw==
X-Google-Smtp-Source: ABdhPJxws6EyQn1ahxRcbVtZjAtqGKCwsfIlfy1WnOdmIBNZ/V4azk+2v4fsGBIuZ7KJ83jUkePqfpf97tf8Z+Pw3I8=
X-Received: by 2002:a67:ed88:0:b0:328:27d9:1381 with SMTP id
 d8-20020a67ed88000000b0032827d91381mr2135012vsp.12.1650660460274; Fri, 22 Apr
 2022 13:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220422195516.10769-1-jvgediya@linux.ibm.com> <20220422195516.10769-7-jvgediya@linux.ibm.com>
In-Reply-To: <20220422195516.10769-7-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 22 Apr 2022 13:47:29 -0700
Message-ID: <CAAPL-u-SDjKGZDmksgvTKyjm=3h53QzU7nRQUfcGtm1noCLnPg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mm: demotion: expose per-node demotion targets via sysfs
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        gthelen@google.com, dan.j.williams@intel.com
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

On Fri, Apr 22, 2022 at 12:55 PM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>
> Kernel prepares per-node demotion target list based on
> node_states[N_DEMOTION_TARGETS], If enabled through sysfs,
> demotion kicks in during reclaim, and pages get migrated
> according to demotion target list prepared by kernel.
>
> It is helpful to know demotion target list prepared by
> kernel to understand the demotion behaviour, so add
> interface /sys/devices/system/node/nodeX/demotion_targets
> to view per-node demotion targets via sysfs.
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---
>  drivers/base/node.c     | 10 ++++++++++
>  include/linux/migrate.h |  1 +
>  mm/migrate.c            | 17 +++++++++++++++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index e03eedbc421b..92326219aac2 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -561,11 +561,21 @@ static ssize_t node_read_distance(struct device *dev,
>  }
>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>
> +static ssize_t demotion_targets_show(struct device *dev,
> +                                    struct device_attribute *attr, char *buf)
> +{
> +       nodemask_t demotion_targets = node_get_demotion_targets(dev->id);
> +
> +       return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&demotion_targets));
> +}
> +static DEVICE_ATTR_RO(demotion_targets);
> +
>  static struct attribute *node_dev_attrs[] = {
>         &dev_attr_meminfo.attr,
>         &dev_attr_numastat.attr,
>         &dev_attr_distance.attr,
>         &dev_attr_vmstat.attr,
> +       &dev_attr_demotion_targets.attr,
>         NULL
>  };
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 90e75d5a54d6..072019441a24 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -173,6 +173,7 @@ int migrate_vma_setup(struct migrate_vma *args);
>  void migrate_vma_pages(struct migrate_vma *migrate);
>  void migrate_vma_finalize(struct migrate_vma *migrate);
>  int next_demotion_node(int node);
> +nodemask_t node_get_demotion_targets(int node);

I think a stub implementation for !CONFIG_MIGRATION is also needed.

>  #else /* CONFIG_MIGRATION disabled: */
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5b92a09fbe4a..da864831bc0c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2187,6 +2187,23 @@ struct demotion_nodes {
>
>  static struct demotion_nodes *node_demotion __read_mostly;
>
> +nodemask_t node_get_demotion_targets(int node)
> +{
> +       nodemask_t demotion_targets = NODE_MASK_NONE;
> +       unsigned short target_nr;
> +
> +       if (!node_demotion)
> +               return NODE_MASK_NONE;
> +
> +       rcu_read_lock();
> +       target_nr = READ_ONCE(node_demotion[node].nr);
> +       for (int i = 0; i < target_nr; i++)
> +               node_set(READ_ONCE(node_demotion[node].nodes[i]), demotion_targets);
> +       rcu_read_unlock();
> +
> +       return demotion_targets;
> +}
> +
>  /**
>   * next_demotion_node() - Get the next node in the demotion path
>   * @node: The starting node to lookup the next node
> --
> 2.35.1
>
