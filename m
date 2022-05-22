Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3553D53013E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiEVG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiEVG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:28:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462E3F8AE
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:28:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ev18so11338296pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eoHDbjWtl/zpr4ERvZZrGreb74/i9haCCnM5LzNUYAk=;
        b=MnC6wR2iAAMH3qOKoH5nuxxT9XIbSH9f52IAn3EnuXnhlEByJniyImcQFzzGhuTxfd
         UkP+qNe/O58QG40YREBS+AA+IfxVR/o+Ts5G/CBEGvNz9mO0/slb0aZfOnt7NEnFl3e4
         +5NLq47E4XM678ZzL5L+M0mneX+u8chd4vz3l/dNYqyKoryKV6ARCTQhBg9QvyMWydne
         mAgyHNSVOl+PM2t/61b5ft7Olh5QQGSwoBuAQnWedxPDVzyeGs9OMCkkbNWkASQNoIve
         VaJIDU8WTa/CPBLm6vHVYRjaAcvUHbRBTsjywAThgQmAviT3TdEehDCitxSSSrIAfrLg
         hJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eoHDbjWtl/zpr4ERvZZrGreb74/i9haCCnM5LzNUYAk=;
        b=PnA20kXvU/a6QuDQTwLe1i6Fv+XtJK9EENAVMjiHbacxOjdYU3DxXnNx3JIlreZL6p
         NXl5KvIaJpoqMKs4VJ9nHtQLJXbTscJiyXNGHzfA0LcaIMkd5Et4VHfF0LAKNaFJuKjb
         mwxXztTJrtGaP8qUt94nvgu6eT0B2DIFltopSCHlu/EB9NspuapN1DcOn1y3MVLCB74n
         EQo/IVP491sB7z8D0F58E/gvlRpj5480MjwZ65gXp6T9i7jmU48d7TX+OY281OXRib5+
         g3fa3Fg5K68tSTOzBu9bOB8Zg5sORONZ+WobYq/VVprxZh5Xkmn7ZIO3mB2tNA/vd/3L
         RWiw==
X-Gm-Message-State: AOAM531sXGLzRCXWmi+qTWYKVgoW4r8I3xma3tFwZiSlUPHYT2EWFrbz
        jBsR2cuajOyugBP81lkeuSzMgF+G1RdBrUsx
X-Google-Smtp-Source: ABdhPJw9xP241mvQ4Qzw8vGsGIoHqFrE7OAiqRV8u3LipqCdK0o00fgKCh6imlOTQvwTR8DXfyn1JQ==
X-Received: by 2002:a17:90b:250c:b0:1df:453f:561a with SMTP id ns12-20020a17090b250c00b001df453f561amr19848304pjb.35.1653200911851;
        Sat, 21 May 2022 23:28:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902d70c00b001616e19537esm2524718ply.213.2022.05.21.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:28:31 -0700 (PDT)
Date:   Sun, 22 May 2022 14:28:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] perf c2c: Support display for Arm64
Message-ID: <20220522062823.GB715382@leoy-ThinkPad-X240s>
References: <20220508092346.255826-1-leo.yan@linaro.org>
 <d15bb8a2-2203-cabf-69de-627d0a45efdc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15bb8a2-2203-cabf-69de-627d0a45efdc@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, May 19, 2022 at 03:19:09PM +0100, James Clark wrote:

[...]

> Hi Leo,
> 
> I see that the HITM and Store Refs columns (even N/A) are all 0% on Arm.
> Assuming it's a similar example to the x86 one above, does that mean that
> these are always expected to be 0? If so, should they be removed to avoid
> confusion, or is it just a case of the example not producing any non 0
> data for these columns?

On Arm SPE, we need to use 'N/A' for Store Refs, but we doesn't need
HITM.

On x86, we should expect 'N/A' is useless and should be removed.

I will update the view for this.

Thanks for the testing!

Leo
