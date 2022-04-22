Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B635650C12E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiDVVhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiDVVhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:37:36 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA02EC138
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:36 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id g22so3410657uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7l1siJ5Z2fXTsLPc04ivVbBuS3c9PMnxxuVpF86Xzs=;
        b=IIo57g2PIuT0TvD4bSVMcYrJl+6VE3sP8KhJktIn+xmBDyQuNInfkEWId6ES9YYH/2
         wUd/ofdCTjanaKSZW7IxdjZcO03qfDhbio9LnGBAKEd3/kt4cVXZ8y+l9qx89zQHAkA+
         Z7D7NSyj0670eg9sdw8/y638r/O+DRZSVNCsVTEK2n0iAcJ9RaOs8SkxU29Lj+DgTIUt
         h55VNvhWwv/iXNB06BL8q3GnU5rgWacC1pamJA6tOPHyGog9wh+y66fANtiSw/p3i548
         0GX3wn3gBgdUAIY/0HgbGHzvIISAtuYePXflkG8S7dkrvVX/4HAJyiq/nzCOoVMcc9qj
         4fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7l1siJ5Z2fXTsLPc04ivVbBuS3c9PMnxxuVpF86Xzs=;
        b=EpTKVIzq+5dbwXz2g8tNtBmRIQ9KBw4890pt5+rhIHojVbnwSu0OIc42VQxovffe3g
         CoJGvDO10yQduZmWO0b2F5+S7P85+rU9kAigJu8KctYXKFgzMvXqsYPrY/S6hcKgxGmy
         +d/nZRUrToOAJ9QIHm6JbGpm3sy8RqJZraDlNCqpp/alFRuOTduBxXmWakqwZqiYiLQm
         S2skP0nJzJUchF4Ecs6r67XAqzoBUSQTGbqI/smfKZHJNfgfG1rWk6J7BNdoZKwoStyY
         n5rk/M8Z5d4mSyVTHx6cQrWJq4wJyt1rBinFgmdVKC066SYnj2s+ZzhPZqeEtC/zBn27
         3y6w==
X-Gm-Message-State: AOAM530zvZ2gwCIMH8oUfD5ctZopZGgiX6pY7e4I7a1EuxpNK1Ur46mM
        sVHVXeH4BF2XAMRsaqqtSaOOJdUvcl1OLjY/yOoRyQ==
X-Google-Smtp-Source: ABdhPJxVykdcIn3WVbtHm5IZKYZ2b7ht5iGQlarXHMqHwHtAYcGofKLyCRwTcQILqNllL8yPFcHqRJ/ct594Gx94lpU=
X-Received: by 2002:a9f:356c:0:b0:359:5bee:d1f8 with SMTP id
 o99-20020a9f356c000000b003595beed1f8mr2372276uao.60.1650659560491; Fri, 22
 Apr 2022 13:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220422195516.10769-1-jvgediya@linux.ibm.com> <20220422195516.10769-4-jvgediya@linux.ibm.com>
In-Reply-To: <20220422195516.10769-4-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 22 Apr 2022 13:32:29 -0700
Message-ID: <CAAPL-u8+LUrw-k_WKs2VESvFMzhNOFrG8X=E58Gvfw4FKvny9w@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drivers/base/node: Add support to write
 node_states[] via sysfs
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        gthelen@google.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:55 PM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>
> Current /sys/devices/system/node/* interface doesn't support
> to write node_states[], however write support is needed in case
> users want to set them manually e.g. when user want to override
> default N_DEMOTION_TARGETS found by the kernel.
>
> Rename existing _NODE_ATTR to _NODE_ATTR_RO and introduce new
> _NODE_ATTR_RW which can be used for node_states[] which can
> be written from sysfs.
>
> It may be necessary to validate written values and take action
> based on them in a state specific way so a callback 'write' is
> introduced in 'struct node_attr'.
>
> A new function demotion_targets_write() is added to validate
> the input nodes for N_DEMOTION_TARGETS which should be subset
> of N_MEMORY and to build new demotion list based on new nodes.
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>

Acked-by: Wei Xu <weixugc@google.com>

> ---
>  drivers/base/node.c | 62 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6eef22e6413e..e03eedbc421b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> +#include <linux/migrate.h>
>
>  static struct bus_type node_subsys = {
>         .name = "node",
> @@ -1013,6 +1014,7 @@ void unregister_one_node(int nid)
>  struct node_attr {
>         struct device_attribute attr;
>         enum node_states state;
> +       int (*write)(nodemask_t nodes);
>  };
>
>  static ssize_t show_node_state(struct device *dev,
> @@ -1024,23 +1026,57 @@ static ssize_t show_node_state(struct device *dev,
>                           nodemask_pr_args(&node_states[na->state]));
>  }
>
> -#define _NODE_ATTR(name, state) \
> -       { __ATTR(name, 0444, show_node_state, NULL), state }
> +static ssize_t store_node_state(struct device *s,
> +                               struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       nodemask_t nodes;
> +       struct node_attr *na = container_of(attr, struct node_attr, attr);
> +
> +       if (nodelist_parse(buf, nodes))
> +               return -EINVAL;
> +
> +       if (na->write) {
> +               if (na->write(nodes))
> +                       return -EINVAL;
> +       } else {
> +               node_states[na->state] = nodes;
> +       }
> +
> +       return count;
> +}
> +
> +static int demotion_targets_write(nodemask_t nodes)
> +{
> +       if (nodes_subset(nodes, node_states[N_MEMORY])) {
> +               node_states[N_DEMOTION_TARGETS] = nodes;
> +               set_migration_target_nodes();
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +#define _NODE_ATTR_RO(name, state) \
> +       { __ATTR(name, 0444, show_node_state, NULL), state, NULL }
> +
> +#define _NODE_ATTR_RW(name, state, write_fn) \
> +       { __ATTR(name, 0644, show_node_state, store_node_state), state, write_fn }
>
>  static struct node_attr node_state_attr[] = {
> -       [N_POSSIBLE] = _NODE_ATTR(possible, N_POSSIBLE),
> -       [N_ONLINE] = _NODE_ATTR(online, N_ONLINE),
> -       [N_NORMAL_MEMORY] = _NODE_ATTR(has_normal_memory, N_NORMAL_MEMORY),
> +       [N_POSSIBLE] = _NODE_ATTR_RO(possible, N_POSSIBLE),
> +       [N_ONLINE] = _NODE_ATTR_RO(online, N_ONLINE),
> +       [N_NORMAL_MEMORY] = _NODE_ATTR_RO(has_normal_memory, N_NORMAL_MEMORY),
>  #ifdef CONFIG_HIGHMEM
> -       [N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
> +       [N_HIGH_MEMORY] = _NODE_ATTR_RO(has_high_memory, N_HIGH_MEMORY),
>  #endif
> -       [N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
> -       [N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
> -       [N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
> -                                          N_GENERIC_INITIATOR),
> -       [N_DEMOTION_TARGETS] = _NODE_ATTR(demotion_targets,
> -                                         N_DEMOTION_TARGETS),
> -
> +       [N_MEMORY] = _NODE_ATTR_RO(has_memory, N_MEMORY),
> +       [N_CPU] = _NODE_ATTR_RO(has_cpu, N_CPU),
> +       [N_GENERIC_INITIATOR] = _NODE_ATTR_RO(has_generic_initiator,
> +                                             N_GENERIC_INITIATOR),
> +       [N_DEMOTION_TARGETS] = _NODE_ATTR_RW(demotion_targets,
> +                                            N_DEMOTION_TARGETS,
> +                                            demotion_targets_write),
>  };
>
>  static struct attribute *node_state_attrs[] = {
> --
> 2.35.1
>
