Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588434E8139
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiCZN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiCZN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:58:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5112BBF942
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 06:57:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id yy13so20367431ejb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lhQ/9h3aosfO3hPFwJIQJoDRXgFc3ALySqBJ9aeA3do=;
        b=jyR0QQpIv1pg8DLBKyUy57SsVcfgSSBWKVzhDzjtO1U+ttf/UmmhpEGrcPwSWnPWUB
         K3CrdQpHrvLgAiaZqPst5VfazuoT4mL+Y3RjAsK4a74bzgj/LuBVvywd5EHRp67tQS7/
         SjdVHJHRnie6Blf/LzHv7mYE1iz6lmsS6mdhCdt8Ez6ewb2KoU18OU7CFWTdJtDQNKDu
         j0QHKVR2Dc02WGDhzmdJzatS8LCIQMPHfnNdkkY+Mh/KtkYpyfBRiiJPXDHnYI4XxesX
         r7lPJ+sitmDjD9+0L4hqyj52EAjO03ozG2/huWdzaV2aCPidPDp/QEGzhTdXPvT/Akay
         5Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhQ/9h3aosfO3hPFwJIQJoDRXgFc3ALySqBJ9aeA3do=;
        b=XHabuc4lRsCWKJYA2VPWgAtYSqveo5onL27hFZIzy0q9EVtk9f6psgeDDXOAj1GgEt
         arNtLKC8d/kvUjrZFyCBP8t/DigBv8JpmjTo+GMjltz4l1n5jWsyPoX+DQcsiywpb1r5
         wJwbldyEma7fW81iI4o8DVpq+qPSUgnw5HjnwlKv5N0F3bY6doafy3TvT3KSs6tTO702
         QkyNAFoKOIOdtyJrg2KudB0aPp8ss/7H2PgmS0U4VEjTtjGNLIYisrxpj6rUQR4ItRsL
         4ZHp6Cewus0IXuMrKN7PUkeTzfHqQ1h//PXNFxYepFGxxEC3537Lj7SiMI975H5ayEyF
         q/KA==
X-Gm-Message-State: AOAM530auNw7hk4xjICFYm0B4JhRf2XFAqdHpMarkWjdOmR5EpYZPr2r
        oL0HFKWlTbwPZHYRBsGZiKMAbA==
X-Google-Smtp-Source: ABdhPJy565DNLBwcL4ofm0QqI01C5J8RZSuRoOAEPeLrdhwPpMVxtyG9K+e/ftRtB2/L3v1kX0iCRg==
X-Received: by 2002:a17:907:3f86:b0:6db:b745:f761 with SMTP id hr6-20020a1709073f8600b006dbb745f761mr16698723ejc.610.1648303021647;
        Sat, 26 Mar 2022 06:57:01 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id bs7-20020a056402304700b004197e5d2350sm4092657edb.54.2022.03.26.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 06:57:01 -0700 (PDT)
Date:   Sat, 26 Mar 2022 21:56:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220326135653.GE20556@leoy-ThinkPad-X240s>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-3-alisaidi@amazon.com>
 <20220326134754.GD20556@leoy-ThinkPad-X240s>
 <Yj8age/PSIouUiKy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj8age/PSIouUiKy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 10:52:01AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Mar 26, 2022 at 09:47:54PM +0800, Leo Yan escreveu:
> > Hi Ali, German,
> > 
> > On Thu, Mar 24, 2022 at 06:33:21PM +0000, Ali Saidi wrote:
> > 
> > [...]
> > 
> > > +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> > > +						union perf_mem_data_src *data_src)
> > >  {
> > > -	union perf_mem_data_src	data_src = { 0 };
> > > +	/*
> > > +	 * Even though four levels of cache hierarchy are possible, no known
> > > +	 * production Neoverse systems currently include more than three levels
> > > +	 * so for the time being we assume three exist. If a production system
> > > +	 * is built with four the this function would have to be changed to
> > > +	 * detect the number of levels for reporting.
> > > +	 */
> > >  
> > > -	if (record->op == ARM_SPE_LD)
> > > -		data_src.mem_op = PERF_MEM_OP_LOAD;
> > > -	else
> > > -		data_src.mem_op = PERF_MEM_OP_STORE;
> > 
> > Firstly, apologize that I didn't give clear idea when Ali sent patch sets
> > v2 and v3.
> 
> Ok, removing this as well.
> 
> Thanks for reviewing.

Thanks a lot, Arnaldo.  Yeah, it's good to give a bit more time to
dismiss the concerns in this patch.

Sorry again for the inconvenience.

Leo
