Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AC4D79D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 05:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiCNEHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 00:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiCNEHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 00:07:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8091B3D4B2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 21:05:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id yy13so31134101ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 21:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/dRD6Rx16wawTOdNSffktT1rpicmUquQb1T9PyxOF4=;
        b=wb4nIzqtukyyCxvHVWoD7tabyArPdBqHSjIjuyto7e7a9YSwN9IPnaJS6LvCPN5bA7
         uFS76gDRCoKKfZtaSYroVDWEftiENp2/lvZbu1sCL9/cEh2655ipupwGr2Dt+RHb3XHf
         Sf0ZNda2TL1IDjUb482FzWjmhvTpeXRKAe+8nS5JklYonDdqHClCDoKgk4E+CzqUaTyk
         gBSomrRcipit4Cgt4sB6LSTKJLHKyZHyHuUUTN4J5YrPP4des0NPftjEmdu/R0U1k6W3
         a0SdQsc69w3G9fTN3hfxf7TYsZ3RY5FBp5KKhl9rZVVdsyXO6FycJMdWnl5HxB4CpCmZ
         VbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/dRD6Rx16wawTOdNSffktT1rpicmUquQb1T9PyxOF4=;
        b=J5MNxC5MiZmFTpFsoiJp6R+a0nn2/EX6NKz6yPl92CBKnTIkltrvVVeB0X7rQzlU0T
         8b5mdVMeW7vjWgu3BKH43+foxr/pKqa26GBpp8hUpWa+K5dqm9ya4mvYEvL2v9l8q7m9
         SVRGB7MEUsCurYBg1E6ghZvgD6zmDlOsmGUFqNTkYW3TwzwJw0baeFMS2nAGUpixhfaQ
         woRwgTFuFkpoJbE/i9RyvdMEonqL2cjHFm9Nk3Qe0Yx3orjjNsZizoqvGA861xxS6DfY
         68Quk9y0LT/RvBWc/UGNa+Bic3b6paxCe3UO09XeaQzL5vozVzz7J043Ue13zcXNplW3
         InAA==
X-Gm-Message-State: AOAM533oLWCSu2p9Xb6MPrfWPA6KCsqWqv5AIvzFiNW5J93wDOY/HmeF
        BKZ8WBrJU4qCcMO7/5DCtt5lvw==
X-Google-Smtp-Source: ABdhPJzXaoiudZPg8T4qpbCGaQkpUDn4+26ep+9/b6PevZn1vNxCt7WiyUq5ue2TCGUoaiZlsdEF1g==
X-Received: by 2002:a17:907:3da4:b0:6da:9ec2:c3ff with SMTP id he36-20020a1709073da400b006da9ec2c3ffmr17082654ejc.90.1647230750924;
        Sun, 13 Mar 2022 21:05:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id kq26-20020a170906abda00b006da87077172sm6328735ejb.29.2022.03.13.21.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 21:05:50 -0700 (PDT)
Date:   Mon, 14 Mar 2022 12:05:42 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        german.gomez@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@redhat.com, kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org, yao.jin@linux.intel.com
Subject: Re: [PATCH v2 1/2] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220314040542.GA163961@leoy-ThinkPad-X240s>
References: <20220313114615.GA143848@leoy-ThinkPad-X240s>
 <20220313190619.18914-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313190619.18914-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 07:06:19PM +0000, Ali Saidi wrote:

[...]

> > > > +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> > > > +						union perf_mem_data_src *data_src)
> > > > +{
> > > > +	switch (record->source) {
> > > > +	case ARM_SPE_NV_L1D:
> > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > 
> > > I understand mem_lvl is deprecated but shouldn't we add the level bits here as well for backwards compat?
> > 
> > Thanks for pointing out this.  Yeah, I think German's suggestion is
> > valid, the commit 6ae5fa61d27d ("perf/x86: Fix data source decoding
> > for Skylake") introduces new field 'mem_lvl_num', but it also keeps
> > backwards compatible for the field 'mem_lvl'.
> >
> I thought about that, but then I'm making some assumption about how to fit
> this into the old LVL framework, which is perhaps OK (afaik there are no
> Neoverse systems with more than 3 cache levels). What stopped me was that
> perf_mem__lvl_scnprintf() does the wrong thing when both are set so I
> assumed that setting both was not the right course of action.

Thanks for pointing out this.  I looked at perf_mem__lvl_scnprintf()
and it prints both for fields 'mem_lvl' and 'mem_lvl_num'.  Thus I can
see the output result shows the duplicate info for memory access like
"L1 or L1 hit", "L3 or L3 hit", etc.  This would be a common issue
crossing archs.  Do I miss any other issues?

> > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > > > +		break;
> > > > +	case ARM_SPE_NV_L2:
> > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> > > > +		break;
> > > > +	case ARM_SPE_NV_PEER_CORE:
> > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > 
> > For PEER_CORE data source, we don't know if it's coming from peer
> > core's L1 cache or L2 cache, right?
>
> We don't.
> 
> > If so, do you think if it's possible to retrieve more accurate info
> > from the field "record->type"?
>
> No, we just don't know and it really doesn't matter. The main reason to
> understand the source is to understand the penalty of data coming from
> the source and that it's coming from a core should be sufficient.

Okay, the question is Neoverse has three different data sources
"ARM_SPE_NV_PEER_CORE", "ARM_SPE_NV_LCL_CLSTR" and
"ARM_SPE_NV_PEER_CLSTR", but the patch only uses the same attribution
for all of them.

To be honest, I don't have precise understanding the definition for
these three types, seems to me "ARM_SPE_NV_PEER_CORE" means to fetch
data cache from peer core (like SMT things), "ARM_SPE_NV_LCL_CLSTR"
means cache conherency within the same cluster with SCU,
"ARM_SPE_NV_PEER_CLSTR" means the conherency happens with external bus
(like CCI or CMN).  So I'd like to suggest to consider to extend the
level definitions so can allow us to express the data source for Arm
arch precisely.

It's important to understand current cache level definitions which is
derived from x86 arch and think what's the good way to match and
extend for Arm memory hierarchy.  I will think a bit more for this,
and if have any idea will share back.

Thanks,
Leo
