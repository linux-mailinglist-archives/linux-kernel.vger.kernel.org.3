Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4565C5095FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiDUEgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDUEgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:36:44 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303912771
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:33:55 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id i27so1759078vkr.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NaD3m0FFo+3HdbSRqIQcjJTsM2LT433BpWcHX1lqVY=;
        b=G6VBySzZ+j1UgjJy1MIdyQsy2GogIefZuA+42NaMjZiVCnQn2fB2ZV7S2GyyqNoj1z
         IlKOWcxCOmCwdmWnaG605E6ocspt2pmTdRGz21s7l0OOGyUbvcAmkuXF0qlARV6QT4fs
         6/W3bI8AmK7MN4pXBbdJOhB2ZgzdUZHY2bW69PIvG+a0vnXgVbmPKz3OTJchiO4kttbc
         IALguwchYa1lF4m86RqH8vF5DfvHjnQruJSAQGE3dGLezEBVfvsUQYwRpR2cp/bFiQSe
         BiU8hv9ysxvY25rFz5XLwNTIlb4MSBW6ctF/OVJfqh1j0Zb3yqyFStHZNSJD0A3qoHYi
         2+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NaD3m0FFo+3HdbSRqIQcjJTsM2LT433BpWcHX1lqVY=;
        b=VThq0bL5ZqSggaY1cw1IGMKxmtIeVnuE+q+rnNaY2RqQEMmCiIgWdicRDNF4IOshUH
         Rs6lNaV0RffFxp9QfsOLpMX5zbYxmOf2ScC9W4saBLpEHgJgvHiYzhHBTzKETcenq2KT
         B9bq38qfP5vRMRi/Xc7bJV4G+BL9egvDilej6WHpjFOXA4FxMO0sjTzRjgevv2iZlCQ9
         GbZGtxdlwgiEE+068IH8dF/92MDCRJQmIWEPHWdpfYJu04GMRszzG7MVPjFTzODrH7hS
         ZduxtiD3wHi8/BysVuVTcTbKLlw6jcvkmJY+0n0/309blZEDb9bml6hI82oJuig+fP9s
         NpIg==
X-Gm-Message-State: AOAM532L3uhXkxU3wWEEJYWZgdjr1qgLF/najOEKkF08CAwN5lwkUNwS
        2gB2kUcbyc+BElyCw6EDeDX5puZm1d3vAb4OA/sJFw==
X-Google-Smtp-Source: ABdhPJz2aVKEpWT0axLPw9Q3y8Srgus56b2bNtZMGaQh7ZeNoiMOZ89rUdAz3ahmu2lwk+s06WB5AwlN6UNFBwjqsFY=
X-Received: by 2002:ac5:c3d0:0:b0:344:44f4:25c3 with SMTP id
 t16-20020ac5c3d0000000b0034444f425c3mr7247079vkk.23.1650515634751; Wed, 20
 Apr 2022 21:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092206.73974-1-jvgediya@linux.ibm.com> <20220413092206.73974-3-jvgediya@linux.ibm.com>
In-Reply-To: <20220413092206.73974-3-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 20 Apr 2022 21:33:43 -0700
Message-ID: <CAAPL-u_xWwjJBoRE8Ce_oRFmmFHQ0DWTNn03zvPxX8HgtTrcWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: demotion: Add new node state N_DEMOTION_TARGETS
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
> Current implementation to find the demotion targets works
> based on node state N_MEMORY, however some systems may have
> dram only memory numa node which are N_MEMORY but not the
> right choices as demotion targets.
>
> Add new state N_DEMOTION_TARGETS, node_states[N_DEMOTION_TARGETS]
> then can be used to hold the list of nodes which can be used
> as demotion targets.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---
>  drivers/base/node.c      | 4 ++++
>  include/linux/nodemask.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ec8bb24a5a22..cd79815b0f7a 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -1038,6 +1038,9 @@ static struct node_attr node_state_attr[] = {
>         [N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
>         [N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
>                                            N_GENERIC_INITIATOR),
> +       [N_DEMOTION_TARGETS] = _NODE_ATTR(has_demotion_targets,
> +                                         N_DEMOTION_TARGETS),

These nodes are demotion targets themselves. It is not the case that
they have demotion targets. Let's rename "has_demotion_targets" to
"demotion_targets"?

> +
>  };
>
>  static struct attribute *node_state_attrs[] = {
> @@ -1050,6 +1053,7 @@ static struct attribute *node_state_attrs[] = {
>         &node_state_attr[N_MEMORY].attr.attr,
>         &node_state_attr[N_CPU].attr.attr,
>         &node_state_attr[N_GENERIC_INITIATOR].attr.attr,
> +       &node_state_attr[N_DEMOTION_TARGETS].attr.attr,
>         NULL
>  };
>
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 567c3ddba2c4..17844300fd57 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -400,6 +400,7 @@ enum node_states {
>         N_MEMORY,               /* The node has memory(regular, high, movable) */
>         N_CPU,          /* The node has one or more cpus */
>         N_GENERIC_INITIATOR,    /* The node has one or more Generic Initiators */
> +       N_DEMOTION_TARGETS,     /* Nodes that should be considered as demotion targets */
>         NR_NODE_STATES
>  };
>
> --
> 2.35.1
>
>
