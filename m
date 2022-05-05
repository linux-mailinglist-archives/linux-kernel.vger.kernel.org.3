Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7404151C395
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381147AbiEEPQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbiEEPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:16:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BAA3B286
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:13:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so4674544plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2wlYERcgnCLAaGqsbd7fOqZETRKFZxGs9XvcdQRYFMs=;
        b=geKVNTNybY/+Px2TIQnqPrDLrg1uBwMBSLGE63bW3i0sNfKa3mK3gWax7DeNsunYtm
         hSOxNTEc26AJDT2ECSyByFzApv+60AcKRxp2wR4PFZej2jd6D9mUAJMo23d5DU11haGO
         UD4iP9anlo0EqdPJigsRRshmq0G2BnYFzeVbOeZNa5uO+m2oafjNk8FdQuXpfgz+zXjy
         5M9dKwvPEaZuitQ3EN+bdVyC9l8ND5rvSg8jB8q0xKmrmDCE6HOnazl4yvEaUAKvCQdN
         b8L4RI6//Pm84428VhysfgaRtAy2xtzY3NyGt1SrjMn3W2zc8dFVlrV6fjNMIa/AeBw7
         +fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2wlYERcgnCLAaGqsbd7fOqZETRKFZxGs9XvcdQRYFMs=;
        b=W4ItBAI0PjZOJEyScz+uFFRQy/Ij6Qtdvfn+wtv1LTsP8l52PlTAr85QgPxXtoEQYq
         PsNSkwjva/b0L1kPdev0jDzZzxeD+rvnxKt+tfYBbsqckKufU+F5DT+IrmwPyNJbKZ1q
         sKGCqzWiZfUjjy2rr2b++HWU2lrY7yaR+BDIU0bNEPqC0JGLS1Qc/GNwePMb6tf/5DNo
         PuQskYz2M9TgboJ4fF4HkHSKngkRVsaKu6CbHcuyq5/EkF114Pk4bRM/LGOzhqvRb3nj
         jxOiKUvSALbJM9gMarre1d+Pcqd3GLrX8RTgVPqEEO84XDDvqqkp6TWvHXJ0OnJzU3qM
         fZug==
X-Gm-Message-State: AOAM533J6AZiaLBGzwNmvJaLpcKPRMGbua3qARPuuRZF0RPBzuvZu9mX
        qmVF3FqpMvh0q4j6jumR1SBDAg==
X-Google-Smtp-Source: ABdhPJzh79O/u5pjw8Y1QV9h1YnDrFnPoODtYCbRorbI8cztRbFTiFVP2Lawy8XaqC/QmEMUvVHglA==
X-Received: by 2002:a17:90a:4898:b0:1d9:50aa:2a62 with SMTP id b24-20020a17090a489800b001d950aa2a62mr6704326pjh.115.1651763580458;
        Thu, 05 May 2022 08:13:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id c17-20020a63ef51000000b003c2f9540127sm1414485pgk.93.2022.05.05.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:12:59 -0700 (PDT)
Date:   Thu, 5 May 2022 23:12:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, acme@kernel.org,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v7 5/5] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220505151250.GC136333@leoy-ThinkPad-X240s>
References: <20220426135937.18497-1-alisaidi@amazon.com>
 <20220426135937.18497-6-alisaidi@amazon.com>
 <458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com>
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 10:58:15AM +0100, German Gomez wrote:

[...]

> > +static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
> > +					       union perf_mem_data_src *data_src)
> > +{
> >  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
> > -		data_src.mem_lvl = PERF_MEM_LVL_L3;
> > +		data_src->mem_lvl = PERF_MEM_LVL_L3;
> 
> Thanks for addressing my previous comment about filling both mem_lvl and mem_lvl_num.
> 
> I wonder if it's also worth updating for the non-Neoverse cores as well while we're at it. I'll let Leo decide since this patchset is only focused on Neoverse.

Thanks for pointing out this.  Yeah, Let's use this patch set for
enabling Neoverse data source.

We can use a new patch to updating cache level for non-Neoverse cores
(it's better also set store cache level as LVL_NA for non-Neoverse cores).

Thanks,
Leo
