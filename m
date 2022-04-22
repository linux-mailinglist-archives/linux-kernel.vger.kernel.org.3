Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6750C1C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiDVWBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiDVWAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:00:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B040E31B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u15so9952957ple.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLxWgfNIqb0f6MOCKWhoyP5UgmjbIvJbEaB9oK2PBEI=;
        b=KmWunHFwmhZ7+/Z0zkVhdm6bYlodk2R4jIYhIdJ6TpI7Ncz4EEZv2P5/ZKRin+K3CY
         LEW2VPEsRB9iu9U1wVrDx7H2ZCsP0X+PwNoiQxWuLBXC9iefYrWR5t7bwmyHfk69wuWW
         4xvMPSD5UpI88QZKV32T0JqeArgRbKqUeVQqJ971ag1+dUKy1Qr5odxP375OcM/gabpc
         ObNCGU3a9bXSrWXKXimjbFYaaWDdU5LDkfqHpHjktW5joHj6DTM2j60L4V+h33qn5D0q
         lEuny2FIILqyXyJ/9I2br9SYrobHi2UnXKujmJFPKRAYYh/ul/5irlOqb7vyELRB8O6u
         eZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLxWgfNIqb0f6MOCKWhoyP5UgmjbIvJbEaB9oK2PBEI=;
        b=lfKgGMjWSwK5ztsYs09ktAi3wdu2yI7vBvafJfP5xU6LAJE3omDas/zoBszEjbEzMA
         dZuuDB3qY+LYW3fLRtz9wMtLyPy81MQHmw22xiS25/SgnVjpFHf06RtZrfZkVJaG4jVU
         mMMxqKgljlGqWWSmQmX2X+C0z62eiwLXwelJ3gIjPENUPfBZEhrSA+bLGlROdDPjr9Pu
         JmnLINYG/Y6ryMkOvESqXVnVxxiwUU8IMTDzROLq5o7dsBDVkWzfrgcI9rfWwhNwkke1
         7iu4B3N8ywrQoV4c4Yk6OSUG6C/UKpu7i7ilngeeWtpXIEW0BtDw1bpmfaSl41ZdQtrU
         jTrw==
X-Gm-Message-State: AOAM533nijcj4ULDs4IieFlbEy6Y6Y3Byz6IWIPNi8KLRsOIN80RPkOU
        PX3LOS6hzTOd1SrotmXiLlH36yDRj4BNA8o6d4UA4QRPJ96sWA==
X-Google-Smtp-Source: ABdhPJxiQkyNiLVcGmbpo7Dg+U6BVB6SXJai1P6lBBfFMBRonhtgSnpYJpjNKAc7LY5s1oAGhuEevZr/abqxUfffNCs=
X-Received: by 2002:a05:6102:3106:b0:32a:18c8:1633 with SMTP id
 e6-20020a056102310600b0032a18c81633mr2070333vsh.51.1650659373899; Fri, 22 Apr
 2022 13:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220422195516.10769-1-jvgediya@linux.ibm.com> <20220422195516.10769-3-jvgediya@linux.ibm.com>
In-Reply-To: <20220422195516.10769-3-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 22 Apr 2022 13:29:22 -0700
Message-ID: <CAAPL-u-LEwVpgx-c_G-tVWsGR+g3vpc=v-jD2OF9_EL5Kpq1nA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm: demotion: Add new node state N_DEMOTION_TARGETS
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
> Some systems(e.g. PowerVM) have DRAM(fast memory) only NUMA node
> which are N_MEMORY as well as slow memory(persistent memory) only
> NUMA node which are also N_MEMORY. As the current demotion target
> finding algorithm works based on N_MEMORY and best distance, it can
> choose DRAM only NUMA node as demotion target instead of persistent
> memory node on such systems. If DRAM only NUMA node is filled with
> demoted pages then at some point new allocations can start falling
> to persistent memory, so basically cold pages are in fast memory
> (due to demotion) and new pages are in slow memory, this is why
> persistent memory nodes should be utilized for demotion and dram node
> should be avoided for demotion so that they can be used for new
> allocations.
>
> Add new state N_DEMOTION_TARGETS, node_states[N_DEMOTION_TARGETS]
> then can be used to hold the list of nodes which can be used
> as demotion targets, later patches in the series builds demotion
> targets based on nodes available in node_states[N_DEMOTION_TARGETS].
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---
>  drivers/base/node.c      | 4 ++++
>  include/linux/nodemask.h | 1 +
>  2 files changed, 5 insertions(+)
>

Acked-by: Wei Xu <weixugc@google.com>

> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ec8bb24a5a22..6eef22e6413e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -1038,6 +1038,9 @@ static struct node_attr node_state_attr[] = {
>         [N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
>         [N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
>                                            N_GENERIC_INITIATOR),
> +       [N_DEMOTION_TARGETS] = _NODE_ATTR(demotion_targets,
> +                                         N_DEMOTION_TARGETS),
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
