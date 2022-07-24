Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4657F2B1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 04:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiGXCiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:38:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2343F18B3A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:38:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l23so14787138ejr.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9zI9fBZxwujK6HOrkcYBco4BzV/k8u6DXtuv9ktQciI=;
        b=Yp0tmsA0Qgu18B4cpMBdnP4DFvvoU787t3cqjpi4dITjh4U1HqUhLA7hcJRXDZ6Dxy
         KjhMC5//RVacmjTYad02NtptqI4ZsUK0vV+H/SsxmvAxDY4R18ZfzpG10MbU5cTZKOvZ
         2K1UDks1Bn/8UwLP6HdAVvTck5ByL8fY2FZiFH/lPU4S7HxjfYhxnB+zC7v5L6sziqGS
         Clut9fh2QPn0MG0lJ8TAF1dx40zs/O/5mxbiYAxUA4EOBjkYoadKiu0yKO8c2Sk/FkJD
         cbWFKb21rVQ447FfVxlIjh10mOnjaw7JbtpMMU7jEDPLQsEbmIfj5+5EnKn40LQXU/Ae
         wzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9zI9fBZxwujK6HOrkcYBco4BzV/k8u6DXtuv9ktQciI=;
        b=ueXcdNxnFogU9Wp5dpz2MjdmME064Vq2TrZE1DgEZVS4cZ4z/VBMq1re1R5DRHScg4
         9/lyG90x25A/08pu/yHniz/lQztseCQXL9MOTpXp9zv4rl9jiPWrtkV1rl+hF+nDK+dv
         83GRQ3BOjm17FCA4hJ8FcLzMFT8VXC7pbOb8plFJDoCvwAaZGxro/Da+N1SDYiYPU+lt
         NNSO48HtveTsTqMbWZjQ6kl4PHbLiYJg5ke4Vf8eCfot6vYftfWfVNUOvM0dINe9WXwY
         DRXENCnYgLowftBVOPHtSHpfEdNLAaRxJsglpklATtfH60E8Buya208ysewVJwHK36SY
         AG8g==
X-Gm-Message-State: AJIora8APNPLLZCVz6706QahTiJ9sU250vGiO4Et0sphdjVatIQrKjI4
        ePyCz2A4GXECn6aFJXvyvAaGnA==
X-Google-Smtp-Source: AGRyM1sU/kaBPW9U0Le4UQnAgfrq9J1IHnM7bIODzZLJDJMqGlniJXVZSfTisN8/kFNKWxPqFHPaqQ==
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id hb35-20020a170907162300b0072b64e3878amr5289467ejc.185.1658630329495;
        Sat, 23 Jul 2022 19:38:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0072b2f95d5d1sm3733919ejb.170.2022.07.23.19.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 19:38:48 -0700 (PDT)
Date:   Sun, 24 Jul 2022 10:38:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chang Rui <changruinj@gmail.com>
Subject: Re: [RFC PATCH v1] perf symbol: Correct address for bss symbols
Message-ID: <20220724023840.GA82137@leoy-ThinkPad-X240s>
References: <20220710012204.2390293-1-leo.yan@linaro.org>
 <CAP-5=fX_fT7e9tqDBKXh_1CQ8w80iOXCGz2kJT_nHpY6wYWqmQ@mail.gmail.com>
 <20220711172706.rtfd6pp2pochmdre@google.com>
 <20220712040538.GB10379@leoy-ThinkPad-X240s>
 <CAFP8O3+dQi8b6C_f9bTb0TFpEmNjsroBv4agUpRKps2p3hpP+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3+dQi8b6C_f9bTb0TFpEmNjsroBv4agUpRKps2p3hpP+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangrui,

On Tue, Jul 12, 2022 at 08:29:52PM -0700, Fangrui Song wrote:

[...]

> > We need to create symbol info for not only .text section but also for
> > .data section and .bss sectionṡ.  So based on the data address, we can
> > know what's the symbol for the data access.
> >
> > But I need to correct the description for "st_value" [1]: In
> > executable and shared object files, st_value holds a virtual address.
> > To make these files' symbols more useful for the dynamic linker, the
> > section offset (file interpretation) gives way to a virtual address
> > (memory interpretation) for which the section number is irrelevant.
> >
> > So perf tool uses the formula "st_value - sh_addr + sh_offset" to
> > convert from the memory address to file address.  But it calculates
> > the wrong file address because "sh_offset" doesn't respect the
> > alignment.
> 
> Thanks for the explanation. I think st_value - p_vaddr + p_offset  may
> be a better formula where p_vaddr/p_offset is from the PT_LOAD program
> header.
> 
> For a SHT_NOBITS section, sh_offset may not be accurate, but PT_LOAD
> has precise information.

Thanks a lot for suggestion, it's very helpful and reasonable for me!

I struggled a bit for considering two things.  One is how to refactor
kernel symbol parsing with PT_LOAD program headers, because the kernel
symbol parsing is relative complex for both kernel symbols and module
symbols, this is why I didn't move furthermore for refactoring kernel
symbol parsing.

The second thing is I observe there have some spurious symbols with
'st_value' are zeros.  So there have an extra fixing for this case.

Welcome comments or suggestions for the new patch set:
https://lore.kernel.org/lkml/20220724022857.2621520-1-leo.yan@linaro.org/T/#t

Thanks,
Leo
