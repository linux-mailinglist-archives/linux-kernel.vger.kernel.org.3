Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA8543207
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbiFHN5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbiFHN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:57:40 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AB4F45C0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:57:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z10so1524939qta.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yKWpjNlFyucWAt9mqVc0aRQ08bT80cWgGBrBg1EuJ2E=;
        b=TxekB4r16dYUeS0Pbv5Yfw5HVjM/rXjUXlNEKauPmriwFZPOjIcmHkpO1e9zBAPiaE
         dEwLwCxUyTuSCyFSoAhwYHRD0rmBLDC3arxOlbSNTIC/GkCHLIUzbWsAJgxQz39UZUv0
         3PZvIh3yI4WZyQMxbMwOwkqS+EkJuNaYCHhKA/rijb+V9T/6edPd5/9J9BTsRiM22kG+
         9CRe3TZA15IlAQvELgI/Ge9G880M3T/Y83+mN+8D1TNi7+TwrJQdgqesimVIST1inYGw
         Gfou9q3vcw+AlOPH4y4HMR65nrueYHlBwLHdGUNFxpVaG9SnkmC3Czpp6qYrBlu1dDKb
         Npvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKWpjNlFyucWAt9mqVc0aRQ08bT80cWgGBrBg1EuJ2E=;
        b=O9epKd+pbvPeyeRKsQWbCtTuv0hdp0u8V3W7OvPRlT2VYZatOfKP6x6n9otuJGrq6k
         B07e9h5v1TQAcJvDQy1wlbTo/oD11AaPtqhzSeQODQ0Vw1o6zdlNqSBmjjcIGH1vpFTh
         KrqFFcDylYhd68XhOlhDBSR/1tDMozdfv2awviNw2qNXN2NtEKpZgyp58B/s04xF5Tko
         11H5xDwl//0H00fXCzTKhkLFfMWK2ghFXtALmE1x1tUAZbVbtGSlHeyT4Afa5uiXJszV
         1ViXCQrTDgREgSIv11eWFVLIOu2f/lFfTkgI2js51Rxn+zFYPYPXs4AOR0RbKYqcyKSw
         YHwQ==
X-Gm-Message-State: AOAM533YoCOAeLRjDAWm+Ta3rnwkeLEd3oA5X5YdvbM2Rt/1Yk6yjKIH
        M1l9LtEHV+EOn0m/z1qerPSQwA==
X-Google-Smtp-Source: ABdhPJwgRvq7YLEVg9fZVuEUgucmnKBbV/WowGfsVbwQxXnAPSTBkNwab88LnBa9+ttaSV8AJmMADg==
X-Received: by 2002:ac8:7dcb:0:b0:2f3:eb31:1e33 with SMTP id c11-20020ac87dcb000000b002f3eb311e33mr27199280qte.598.1654696658166;
        Wed, 08 Jun 2022 06:57:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id k66-20020a37ba45000000b006a37eb728cfsm16158987qkf.1.2022.06.08.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:57:37 -0700 (PDT)
Date:   Wed, 8 Jun 2022 09:57:37 -0400
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
Subject: Re: [PATCH v5 0/9] mm/demotion: Memory tiers and demotion
Message-ID: <YqCq0cUCnQmS6SV4@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aneesh,

On Fri, Jun 03, 2022 at 07:12:28PM +0530, Aneesh Kumar K.V wrote:
> * The current tier initialization code always initializes
>   each memory-only NUMA node into a lower tier.  But a memory-only
>   NUMA node may have a high performance memory device (e.g. a DRAM
>   device attached via CXL.mem or a DRAM-backed memory-only node on
>   a virtual machine) and should be put into a higher tier.

I have to disagree with this premise. The CXL.mem bus has different
latency and bandwidth characteristics. It's also conceivable that
cheaper and slower DRAM is connected to the CXL bus (think recycling
DDR4 DIMMS after switching to DDR5). DRAM != DRAM.

Our experiments with production workloads show regressions between
15-30% in serviced requests when you don't distinguish toptier DRAM
from lower tier DRAM. While it's fixable with manual tuning, your
patches would bring reintroduce this regression it seems.

Making tiers explicit is a good idea, but can we keep the current
default that CPU-less nodes are of a lower tier than ones with CPU?
I'm having a hard time imagining where this wouldn't be true... Or why
it shouldn't be those esoteric cases that need the manual tuning.
