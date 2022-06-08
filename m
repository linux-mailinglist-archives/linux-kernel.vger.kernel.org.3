Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC4543241
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiFHOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiFHOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:11:34 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23524B0F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:11:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id hh4so14938397qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MsrKzGmlT+GrZQQ7Ya99P0bTOg+b9kwYArh2gPCfmw=;
        b=xq48c4rSn5YjeBEU+zUXTOhfccrN9RoH+1hJxeaA7hDjEVMBxv2VQywPQSU1bJ6d2F
         wmLXBgCLArkVz4N68ocUCj+PPdVTwKFr1OQjuTioE2pltWZ0FKm/sTL3G2dPsOdhj/mr
         XaZXcjLR/JQoAi+vZgaIQHXsfSY5nqlSxSk4Ktui2O9SPV/i+nvW/IV/Mo8gpdKwbV4E
         b5WnNXPVPnb3tIF4KoYM4v2NgqOh6OHBR3DnPYBPY0VY2VYU48nXvsUTFQYqV9yf3dBU
         Gbvg2Y0YJz2DnUI9HKkSJ8W7GD3qbW7H4g8dShlgXPSqF+xhs5OhKunus94iOctzi4Ue
         4yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MsrKzGmlT+GrZQQ7Ya99P0bTOg+b9kwYArh2gPCfmw=;
        b=5crpEdOgWPSh281hF8H1IzSQl0vlIKLL3KfjyS2LoluhW9QK2Mx/PxQWvRgQ2sJlsh
         sfKos5OTgUfWdKxvmuTGUK4AW5FgadoAc2AgbvUNwLjo0z8OI0LijVezrB9Vxt608tMm
         JI7tu9RxFWsfNTcPZXwCmLXVjiwon3Fk49eSPDb4YT++U7PCq3AD/XrQmeabo4+fLczj
         CaB0IYZeu5IMezxt4kN0c2N3AiBSeJ4N+6kOfRO8SD5JlS11yjtUHNlVj0A9E6fEv/bY
         cAurBlpoY74MTILRSZj5i+eoFFeDY3cSC6mDE6+SLSaSieqzvjzqV1V3e2ucgaa+Huhz
         SFXA==
X-Gm-Message-State: AOAM531yWqKB//xKU4WgSNosIBdytferW52aVcOE3JyexT+hInRCUljq
        +2HHxF/mt7X4u8S93Az0nKw2jg==
X-Google-Smtp-Source: ABdhPJzVX/WMZrBFCmQAOp0q7xkalLuoT9k/EFAPJpdNC26Z2K6zfyYy2OCUSRgBeucR/BpSktUM4Q==
X-Received: by 2002:a05:622a:1186:b0:305:99b:874f with SMTP id m6-20020a05622a118600b00305099b874fmr429769qtk.305.1654697492181;
        Wed, 08 Jun 2022 07:11:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id o185-20020a375ac2000000b006a36b0d7f27sm15712469qkb.76.2022.06.08.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:11:31 -0700 (PDT)
Date:   Wed, 8 Jun 2022 10:11:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Message-ID: <YqCuE87gCcrnAiXG@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aneesh,

On Fri, Jun 03, 2022 at 07:12:29PM +0530, Aneesh Kumar K.V wrote:
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MEMORY_TIERS_H
> +#define _LINUX_MEMORY_TIERS_H
> +
> +#ifdef CONFIG_TIERED_MEMORY
> +
> +#define MEMORY_TIER_HBM_GPU	0
> +#define MEMORY_TIER_DRAM	1
> +#define MEMORY_TIER_PMEM	2
> +
> +#define MEMORY_RANK_HBM_GPU	300
> +#define MEMORY_RANK_DRAM	200
> +#define MEMORY_RANK_PMEM	100
> +
> +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
> +#define MAX_MEMORY_TIERS  3

I understand the names are somewhat arbitrary, and the tier ID space
can be expanded down the line by bumping MAX_MEMORY_TIERS.

But starting out with a packed ID space can get quite awkward for
users when new tiers - especially intermediate tiers - show up in
existing configurations. I mentioned in the other email that DRAM !=
DRAM, so new tiers seem inevitable already.

It could make sense to start with a bigger address space and spread
out the list of kernel default tiers a bit within it:

MEMORY_TIER_GPU		0
MEMORY_TIER_DRAM	10
MEMORY_TIER_PMEM	20

etc.
