Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93475844E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiG1RXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiG1RXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:23:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93185B79D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:23:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o21so1904086qkm.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1bpeiU6xJe06BhKMBB9TymWuJgsApmhu1bP3WtUTIhI=;
        b=pQcHZGMM8cnpt7ARDuITkHvi77Yt5Zt5QtdeTeHfFp1ZXshN1/OlmE/QHCwGn9LiIC
         TtiCHmD6pv/6lfByvazNLBF4GtYkQGjX0sMu+GEMqTFSfDamNZ3kMGX+Nh6jQWBop6j5
         2qD6m+i9xkBSz86mC5pO/wAHYUtokUDqri3o2wud2JOURD/8DV2iUQWhHHtarF0HKoBI
         OXA/5yWUmtmnJMVF7M41H+zE15BzHpbvvaXD4h0o793q9zohrw9gY9Z+BFJldGP7cOlK
         ExO1s68ZGans3vqRusMj01Q8/dvfO7afHB6GRi3UNq7dxRgwm1mkfqpst8w1OZEbefOJ
         GIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1bpeiU6xJe06BhKMBB9TymWuJgsApmhu1bP3WtUTIhI=;
        b=fN62FefSW87Wwedl8QGiK5YihLXtLiPowf/iuipIUVdurtLorJdK5CHQTuPNDdnEBL
         aOWOp1jM9x5uye/MjqKQX0GBti9kvsuxHXfwi6ZDSd3LAHjAbyBw6MlbmOyYtmtnRwiv
         Bm+5KAczBGqI1kV8HnJsbMPNv0iQeX/HDAAl7p9iqQivB3epTM07lajbA8g3o79EXwm3
         f+EtSFdTVElbfGxHgP42VklOU1dOmuVjfTJlKgp7edSt3sWL7MtM3CMMkLtoH7Zc+DqZ
         +eSa908lfuBO4LUaw+bEB7TDhTVcOio043iUDWtbPFdvxGFPODTTsrABypBRN2s2A98Q
         iuuw==
X-Gm-Message-State: AJIora+0HvD6swelFbGhmE7f5NHyXZpvPwUXEfvaXeexIG2Uhp+B5CUn
        l28RafM7oW+r9hvdTTL3bqc0Jw==
X-Google-Smtp-Source: AGRyM1uOeNQ6O5O6VgA66Jbex+hGdMpMLlFOcjsQPWG4mNYu3adiReX5u8cPXRh948v4hzR2Ui1l/g==
X-Received: by 2002:a05:620a:44d4:b0:6b6:229e:dc5b with SMTP id y20-20020a05620a44d400b006b6229edc5bmr20148181qkp.327.1659028990091;
        Thu, 28 Jul 2022 10:23:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id t7-20020a375f07000000b006af50b6f10csm876959qkb.61.2022.07.28.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:23:09 -0700 (PDT)
Date:   Thu, 28 Jul 2022 13:23:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jvgediya.oss@gmail.com, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v10 1/8] mm/demotion: Add support for explicit memory
 tiers
Message-ID: <YuLF/GG8x5lQvg/f@cmpxchg.org>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
 <20220720025920.1373558-2-aneesh.kumar@linux.ibm.com>
 <87k080wmvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <9e9ba2e4-3a87-3a79-e336-8849dad4856a@linux.ibm.com>
 <87lesfuzhj.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lesfuzhj.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 09:16:08AM +0800, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> > It is an abstract concept that indicates the performance of the
> > device. As we learn more about which device attribute makes more impact in
> > defining hierarchy, performance level will give more weightage to that specific
> > attribute. It could be write latency or bandwidth. For me, distance has a direct
> > linkage to latency because that is how we define numa distance now. Adding
> > abstract to the name is not making it more abstract than perf_level. 
> >
> > I am open to suggestions from others.  Wei Xu has also suggested perf_level name.
> > I can rename this to abstract_distance if that indicates the goal better.
> 
> I'm open to naming.  But I think that it's good to define it at some
> degree instead of completely opaque stuff.  If it's latency based, then
> low value corresponds to high performance.  If it's bandwidth based,
> then low value corresponds to low performance.
> 
> Hi, Wei and Johannes,
> 
> What do you think about this?

I'm also partial to distance. It's a familiar metric in non-uniform
memory for guiding placement decisions, and that is how we continue to
use it here too.

It's historically meant bus latency, but given how the kernel
perceives and acts on the metric IMO the term works just fine to
express differences in bandwidth and chip resonpse times as well.
