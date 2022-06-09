Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03F5455D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiFIUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiFIUlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:41:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06481156789
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:41:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f13so4584477qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j1i9jnkPCwj7hjptqenXLooIsYDic1cbsYQIxJWV6GE=;
        b=plm4N/skR66NjRrl4/C5+SMQzqXmUlJjH0J0+883ZKmDFiqwT3OV4Bqij/K5nRcp+A
         dz2MWYDobAigEnjXlHJokJEUyQvmd4jMYs+PYbX0a/m0aKggTDxNFx+x0HQ+DHp9e2f3
         N9nwqNbnXW3JjaMj/W8BSt+frvPMh+frOxCYhT0+HkZeApQDxi1nlOtFJFZXF+cIPZWq
         tTgrWbL9cM9qq8SvRBFyzTbIBa9G5/TAJrwRyRTWQuB2Hh6uObVrc3+VokZ/0zYSjB6N
         ivqUGq/Q/gQjLQl9Io1mQ9M83TTOWPYqBe1nF+8fpiC6oExn/9CvbXI0CAWzfb5MckOM
         qDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j1i9jnkPCwj7hjptqenXLooIsYDic1cbsYQIxJWV6GE=;
        b=hr7CxmWBWJY8AzmQSvxl3/xBVP9R1M1OvSbsHvvw56D261BC3T2VnuKJjio/sxazy5
         wnkvStINtVuu8/IqtFCsIi6tVvHWajUmkxlS23yMuC3qlHWX25BPZV4w96Xg+39wPSQN
         p3AXA1jaJMT7vlmdw2Su5tqM/Vvrea8RLxZ6EhFuIR3XYu218P6jBHXFci1Futa2pS2/
         PhJxZXPC6dPE5+ZbRWyE0fQO75x5FG5q+urM9TZayR8MgbNSUS2yX6fdetVhrkhRzPG2
         7y8z1UqmjbbE3P86qMymCgYhFSaYxPVZjWEKThex/4SMJ34R3D8CbO3wzwOtPgJyIzKh
         ZQbw==
X-Gm-Message-State: AOAM5305b2yBrEjh8bXaUxL0v4SuWKQWxmo+bGx3RabwV9xsLQ2U6/G/
        8zaiWBgRlIlNGtVYK3VZ+2TgVg==
X-Google-Smtp-Source: ABdhPJxp1k9zfvxgeMouv0XByvqOJbmu7qh92LB53qmBHvgXvd6f2OhwumIXJZDuQs+MM0CyM9KnDw==
X-Received: by 2002:a05:622a:130a:b0:304:f156:ec9 with SMTP id v10-20020a05622a130a00b00304f1560ec9mr16605646qtk.226.1654807264737;
        Thu, 09 Jun 2022 13:41:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a445100b006a7137330e2sm4554017qkp.132.2022.06.09.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:41:04 -0700 (PDT)
Date:   Thu, 9 Jun 2022 16:41:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Message-ID: <YqJa4N/VlS4zN4vf@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org>
 <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
 <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org>
 <20220609152243.00000332@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609152243.00000332@Huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:22:43PM +0100, Jonathan Cameron wrote:
> I think discussion hinged on it making sense to be able to change
> rank of a tier rather than create a new tier and move things one by one.
> Example was wanting to change the rank of a tier that was created
> either by core code or a subsystem.
> 
> E.g. If GPU driver creates a tier, assumption is all similar GPUs will
> default to the same tier (if hot plugged later for example) as the
> driver subsystem will keep a reference to the created tier.
> Hence if user wants to change the order of that relative to
> other tiers, the option of creating a new tier and moving the
> devices would then require us to have infrastructure to tell the GPU
> driver to now use the new tier for additional devices.

That's an interesting point, thanks for explaining.

But that could still happen when two drivers report the same tier and
one of them is wrong, right? You'd still need to separate out by hand
to adjust rank, as well as handle hotplug events. Driver colllisions
are probable with coarse categories like gpu, dram, pmem.

Would it make more sense to have the platform/devicetree/driver
provide more fine-grained distance values similar to NUMA distances,
and have a driver-scope tunable to override/correct? And then have the
distance value function as the unique tier ID and rank in one.

That would allow device class reassignments, too, and it would work
with driver collisions where simple "tier stickiness" would
not. (Although collisions would be less likely to begin with given a
broader range of possible distance values.)

Going further, it could be useful to separate the business of hardware
properties (and configuring quirks) from the business of configuring
MM policies that should be applied to the resulting tier hierarchy.
They're somewhat orthogonal tuning tasks, and one of them might become
obsolete before the other (if the quality of distance values provided
by drivers improves before the quality of MM heuristics ;). Separating
them might help clarify the interface for both designers and users.

E.g. a memdev class scope with a driver-wide distance value, and a
memdev scope for per-device values that default to "inherit driver
value". The memtier subtree would then have an r/o structure, but
allow tuning per-tier interleaving ratio[1], demotion rules etc.

[1] https://lore.kernel.org/linux-mm/20220607171949.85796-1-hannes@cmpxchg.org/#t
