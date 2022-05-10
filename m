Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D3521008
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiEJIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiEJIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:54:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2557722523
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:50:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so1582874pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23XI7omNPu4Ww2mwP5OeT/CtOKTWQPLI279EMdZEl8I=;
        b=pAkf0vZXQUl7z39Mvm0va/etmp8fu6PH9u8QnPryN0wiLXCnJABlTzMSyA1vX3ufsd
         1NwpI4qHxfOjcijIcVJhXTnUyNexYug0j+ElYm4cIsoghJ+NFodEYzmqMIg0iwGq2sOh
         IYMUG6mCbzmWSWr8F3zuIh+27WF/B7hQV9+aanx16CvGGbq1sbVmxt2FWWKhkPyBRTMV
         OOSaopJdw6cqzqBOvlc8kWKvGJgjUxBC0+BdcA1Brs2jH982g/uKojUD9UdUhgYG6592
         aS6U2Mze/PcfS32raLNpyKL1T3xq+CMGvh8nDeryMuuriTKiCsqcFlW2+78zx13+QcCl
         baYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23XI7omNPu4Ww2mwP5OeT/CtOKTWQPLI279EMdZEl8I=;
        b=U/HKgV8Z9iDgMcWmhuXKAv60XM1wBeBALXDEg7TmnZM0w4EjSnshdKIb6t4xdnRvD+
         sttEPEza2HS5Ne4Xj7M1Gb09SYDqzQUHu428WLUmsFjBKlBfIKqQdC0fo2CBlehZPYmE
         9JkTJn8aNT/mBZVtQBYiMowmCp7ajzsZp1EvK/iLvr+vjgzpzfru3Lkm2fhauU2KWx1F
         l5PAik+8XtSDQzhM/CZYQoczNRljGCo1+hFM32L0pRWCE2eA1hxZiXtFBT1e+/6ALjcP
         OUm0cRM4jp1JdbsdVcc12XbM5C27ZyelwWW8bz1mPR28TPTSdFNh+qqEkaLbLLU6JD48
         rYfQ==
X-Gm-Message-State: AOAM530hK55naD2VphIrfSxBFCV1faAkuc/w5VSFtNImJbzARWQ4ULLz
        j00nsl0ALIx9AsKATl3s0yK3DnZ0N+IXrQ==
X-Google-Smtp-Source: ABdhPJwXvUI+FMSIeZJnNlTMMqe93GAbMnaxp4pldVeXwi/DjAEPWwiYdnWfkXRdlr5EKGrPbXGY8Q==
X-Received: by 2002:a17:902:8501:b0:15f:173:40e1 with SMTP id bj1-20020a170902850100b0015f017340e1mr12562515plb.74.1652172652504;
        Tue, 10 May 2022 01:50:52 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id q65-20020a17090a4fc700b001daac75511esm1230698pjh.51.2022.05.10.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 01:50:52 -0700 (PDT)
Date:   Tue, 10 May 2022 14:20:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jiabing Wan <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Message-ID: <20220510085050.tza6rjvdkjsrhrjv@vireshk-i7>
References: <20220510080136.11950-1-wanjiabing@vivo.com>
 <20220510081232.4u25qgryszzqblho@vireshk-i7>
 <61a4b23f-9740-6fb4-abd0-640d3353e788@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a4b23f-9740-6fb4-abd0-640d3353e788@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-22, 16:26, Jiabing Wan wrote:
> Hi, Viresh Kumar
> 
> On 2022/5/10 16:12, Viresh Kumar wrote:
> > On 10-05-22, 16:01, Wan Jiabing wrote:
> > > Fix following coccichek error:
> > > ./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
> > > ./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line
> > > 
> > > mutex_lock is acquired but not released before return.
> > > Use 'goto out' to help releasing the mutex_lock.
> > > 
> > > Fixes: c210063b40ac ("cupful: mediatek: Add opp notification support")
> > cupful ??
> 
> Sorry for the typo...

Did you write this line by hand or generate it with Git ? There shouldn't be a
typo here.

> By the way, is this patch correct?
> 
> I am not sure whether it should return with the mutex_lock.
> But IMO, it should release the lock before return.

Yes, we need to release the lock.

-- 
viresh
