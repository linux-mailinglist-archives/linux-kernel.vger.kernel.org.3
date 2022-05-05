Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BCD51BC65
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354122AbiEEJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354097AbiEEJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:49:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC841AF04
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:45:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r9so3700202pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xd+tFU4G6DiHT7gIjy4KKIDQKgemXk6bnmPVHdW1sAc=;
        b=qnlHZ+v6nzaiWZnsSkygEbiKNIGLS53iBtlot9+8u+KvtVnyMzeKoOksnY+xVHxKrT
         Lz9CpGjYrEpC/QZm9KT19CItp17cgx9gnp66neRlQzxRR72//DpI7C2PjnWDdxmn6+xL
         VB/f84cTCRcZtYxzRUtQRuth4nPhqyvZpgTlxP3bTcSy6JwuA1TDmdWaBdqfc3WcpXgn
         njlIJ3XWnXC8lRMus63hIKZygsLUiOFbtjF2OFwogfhZtcexsS7PSwgZKTCYHXraU4pA
         JJ5+KORlvZ6bAevhfRsviXyvZxUmJtCleiEb8C0sDrgfGL08z2Zv4uTbc1sNH4wiCMM0
         /ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xd+tFU4G6DiHT7gIjy4KKIDQKgemXk6bnmPVHdW1sAc=;
        b=KTPNLAFQuARXusQ5ifsBvd3bV/v8gnlyhrn5iBVNakDstxoLeKaSSpmXL0Eq4SBATH
         dlR7sD1Imt2SvoaKzOTkzSNLMUOOk/eXjKQc3BUQtVo/w2kgUgNVU3QVi1NU7TnDAycp
         +LDmYoKI9tAZwbMDyxPetytZKKLnQ98/1bqO0H3LR49dv4VDReqyHNtObdjoIImihlSA
         ACAuEf0+v8a7h9ilyDrz+lMSL4l0ilKMk+40QrtyB2G+OzvqOEg+gJYZfQlJSMrpC2Ls
         ceAoKvm1nuso/vMjnrzirkBdkaLoOUp4nZq2bM+qFL24FQ8iULj8NW9vDsQOJB0oe1gO
         DpdA==
X-Gm-Message-State: AOAM532+PjrCqpLIQoi5vXWSLiOyI5FGEPCU6fM3drooP95hK1sbUtb0
        DCbBpjSjKnSOohWk59O5eVAoFQ==
X-Google-Smtp-Source: ABdhPJxhUO8FQ8vO2QKxlT51BGpwvAlvoIbwqpuo53kcnys/cWG/navnqZwc2uKd+K7E2NDJU85rDQ==
X-Received: by 2002:a17:902:a987:b0:158:b020:e5b8 with SMTP id bh7-20020a170902a98700b00158b020e5b8mr26451166plb.103.1651743950207;
        Thu, 05 May 2022 02:45:50 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id f18-20020a63f112000000b003c14af50603sm859049pgi.27.2022.05.05.02.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:45:49 -0700 (PDT)
Date:   Thu, 5 May 2022 15:15:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to
 mismatch
Message-ID: <20220505094547.skkwuthq454ajo7l@vireshk-i7>
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
 <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com>
 <20220505074408.ayzmd5kdbw2fagbq@vireshk-i7>
 <CAKfTPtCuJGsrsBJ2jACr_YeKN3RXNVMkgRgo+cw9t7CAyGwHWQ@mail.gmail.com>
 <20220505082801.oks7ko2sbqazyenn@vireshk-i7>
 <CAKfTPtCfKBiQkghY6gw+sSYYOXFRWMZNXsr64Vn5G-Oo1HF8ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCfKBiQkghY6gw+sSYYOXFRWMZNXsr64Vn5G-Oo1HF8ew@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-22, 11:40, Vincent Guittot wrote:
> On Thu, 5 May 2022 at 10:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 05-05-22, 10:21, Vincent Guittot wrote:
> > > Part of your problem is that cpufreq use khz whereas clock uses hz
> >
> > Not in this case at least as the value mentioned in OPP table DT is in
> > Hz.
> 
> But dev_pm_opp_init_cpufreq_table make it kHz anyway

Yes.

> > > Would it be better to do something like below in cpufreq_generic_get
> > >
> > > (clk_get_rate(policy->clk) + 500) / 1000
> > >
> > > so you round to closest instead of always floor rounding
> >
> > That would be a fine thing to do anyway, though I am not sure if it
> > will fix the problem at hand.
> >
> > If the hardware returns 499,999,499 Hz, we will still have the
> > problem.
> 
> But in this case, cpufreq table should use 499,999Khz IMO.

I did think about it earlier, but then left it.

> We already
> have OPP/cpufreq table being updated at boot with actual value.

I don't think we update the frequency values there yet, but yes one
way to fix it is via DT.

-- 
viresh
