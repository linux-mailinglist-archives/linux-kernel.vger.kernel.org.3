Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71A84D1A99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiCHObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347452AbiCHOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:31:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447094BFE5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:30:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r10so28876809wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=geaTHMvAYk1/YissgcwSeNleJrlCZkBzo6c+Xbda8d0=;
        b=f/22Uo2UMZDBnjqOWCi2bOBAmcduc6oI8wCNn8nOyiNSEklf9C3yW+80xOCzdtF1zQ
         A7LUXcpVoD44ZvduZaRpyjsH/aaWqJ5utkvSmbvxWbs9UFbNjW3jVUvuBWlhp2MmYDwY
         wU41fxK3R1I+ZhV6IwIM5xrQRTIRiRHslzT2OTD9SmkEBoZxXy+ojPZmpqirZW9ZEtvE
         MnXaFP44KqQvw4ZkgfPoqDZFVDCsfKwL9NIZfA4yuqOOAsnP1/Nr7lQE8/ztMlj5aq4/
         uQtTvaVEUqpiaAbMwE+CN8spPaFhcOAiF3Vno84h3LtWwidAR+I0uAHTuIXO36GCsL1O
         VKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=geaTHMvAYk1/YissgcwSeNleJrlCZkBzo6c+Xbda8d0=;
        b=Jv9CiwlcSBNz3R9sXTX7JfQltS1kFAMzUBwEmz2jIvCiW73Z+WYZe9ke1VVrAqX59j
         EagSsAmg2O0hkCtZH2OMrvuZt22fU7KiOynjKlpT9c/i/UK2+0DqUPV8nghmq1ltuTI/
         bx/ojVwyR98QoKDO2FPBkib6ybde9W5/jhe/Smivm4FUlynFfy7OyPaSkQBYtkAxCTfP
         hyBNEFo1siVyPhWNyVhqxEfUkJTJuiqOG1JaHAAkJwHH4t3ALAojwbXrHcQrhzLn6rme
         1xSZ76fo0rshi3vn2hv4WZD+0cw1Jj56y1jQzpUxPwW9hOaONyspnoo0W8gM6Or/n2sp
         IutQ==
X-Gm-Message-State: AOAM532d54sI30D/vC/DnDT8SlNlc4/5XfhWnv3IkpiBUqDcNXu0ZkBQ
        oWde/cVd8P3dUCbLlRFeTQeE9umTAqgxxFuc
X-Google-Smtp-Source: ABdhPJzgWAk6qtNC3DYGawH5hDpXlDToIckxTXQi5GKCVEns2M3AdxWJV5Ngs/dZXBRX9LtTkMSwZg==
X-Received: by 2002:a5d:64ed:0:b0:1f8:683e:5082 with SMTP id g13-20020a5d64ed000000b001f8683e5082mr5764493wri.526.1646749831475;
        Tue, 08 Mar 2022 06:30:31 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d698c000000b001f1d8bb4618sm16488483wru.36.2022.03.08.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:30:30 -0800 (PST)
Date:   Tue, 8 Mar 2022 14:30:29 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configs/debug: set CONFIG_DEBUG_INFO=y properly
Message-ID: <20220308143029.j6wbbnmkmmmhl2jt@maple.lan>
References: <20220301202920.18488-1-quic_qiancai@quicinc.com>
 <20220308104215.q4asb6z3vicq2vja@maple.lan>
 <YidgcE0ypmKWzvai@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YidgcE0ypmKWzvai@qian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:56:00AM -0500, Qian Cai wrote:
> On Tue, Mar 08, 2022 at 10:42:15AM +0000, Daniel Thompson wrote:
> > On Tue, Mar 01, 2022 at 03:29:20PM -0500, Qian Cai wrote:
> > > CONFIG_DEBUG_INFO can't be set by user directly,
> > 
> > What do you mean by "can't be set by user directly"? DEBUG_INFO
> > is fully controlable via menuconfig.
> 
> On linux-next, we no longer able to select DEBUG_INFO directly due to this
> patch:
> 
> https://lore.kernel.org/all/20220125075126.891825-1-keescook@chromium.org/
> 
> Thus, this patch will work on both the mainline and linux-next.

So your patch sounds like it works for linux-next but, as shown in the
example I shared, it does not work on mainline and should not be
included in v5.17-rc7 .


> > Does this change actually work in the kernels it has merged into?
> > 
> > DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT existence is predicated on DEBUG_INFO
> > being set. It makes no sense at all to set the former without the later.
> 
> It works fine here.
> 
> $ git reset --hard v5.17-rc7
> $ rm .config
> $ make ARCH=arm64 defconfig debug.config
> $ grep -i debug_info .config
> CONFIG_DEBUG_INFO=y

That is *not* an example of debug.config working correctly. It is an
example that only works by accident because the arm64 defconfig already
included CONFIG_DEBUG_INFO=y (that's why I explicitly disabled it in my
example demonstrating the problem before I applied debug.config).

However debug.config is not specific to arm64 and, for v5.17-rc7 it is
also not working with the defconfigs for (at least) arm, powerpc, riscv and
x86 (both i386 and x86_64).

I'm still of the view that any change that removes CONFIG_DEBUG_INFO=y
cannot be sensibly applied to kernels that do not include Kees' patch.


Daniel.
