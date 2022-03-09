Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC654D2F68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiCIMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiCIMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:49:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FF63F30F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:48:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q20so1305963wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dEkbfPIsKnwjaI2kDEzkTmYsVV370wWk1OOrQivXzv8=;
        b=lmDyPs4TomAqORCQt7bvXiRJDosW/4o6zJlrE9aG5ioQzf3RA5iQgiysLYQfXySlh7
         TO3Mjd19IHNJY9tk4efQ1cCJehYDz5yeswxyImceL5S/9pnp40r+LVCmbrh7BquzLlIE
         LneAAXcFUXd9sz02HSXI4wlQuzKlJiPhuLEUr6Mu0E30g0Ys1GAL6k6fCrlGVzr7SRW/
         F+pRs8MJCsLMydsBs95kyUZH74cgp/T94SqezuHiI8Fm/AVFiwwGVyaerX3K1AjVdUQQ
         F+3GEiH5mG6aKIVU1hisGiauer0W926KzgjkO8rl1U8atUHqbV/GVrzHRPHoG0yg1y3F
         6CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dEkbfPIsKnwjaI2kDEzkTmYsVV370wWk1OOrQivXzv8=;
        b=mwXWho+lyxy175Pt6+QevsdmEYmvuYBaWRacQ4dnEuAwE3Eumu/mvU7wihIiC2l+9T
         CYB88x0/TX3oCKIruvN4g+TjPSADUAMiXdmoDQyWK0a/jT8q7r4IvkpXFHsvu7WSh1Cf
         e+0WswYZwIHHRsIgWhyvAqimz2EZKe+oTcpDNjweTeQTJcpYAHUUIJbjqWnERD07Dg9+
         qrivpj3GhOPzlmYUSeNPGfyE8kn83qdmg+CCNTMgbDeTaoM+ajmGpv5PD+zCBNNUaXHj
         P9a+WPMfHZTmbVNtLMM8imZRgvorigwdjZGkRbOAAcwV01qzWz5lG2d9ByjT8ST+5GsK
         Vu1A==
X-Gm-Message-State: AOAM5334XRPrJN4RHkEVJYNou4u553FArh6wRtAV8vFBNfkIPSi8K4iw
        bHEyRffx9SbJzSNnhoLSu7M=
X-Google-Smtp-Source: ABdhPJykQjSaVV6GH2izGx0H3jrk4OebEHXamou2u5NeTdSiw3QwRx7HVt6vqj4BZUYMgSFXBRupng==
X-Received: by 2002:a1c:acc6:0:b0:380:e35f:ff1f with SMTP id v189-20020a1cacc6000000b00380e35fff1fmr7476109wme.52.1646830104358;
        Wed, 09 Mar 2022 04:48:24 -0800 (PST)
Received: from [192.168.1.99] (31-34-241-225.abo.bbox.fr. [31.34.241.225])
        by smtp.gmail.com with ESMTPSA id o12-20020adfa10c000000b001efb97fae48sm1658108wro.80.2022.03.09.04.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:48:24 -0800 (PST)
Message-ID: <465ffdb2-06fe-c35d-c37e-6fa19b0c84b1@gmail.com>
Date:   Wed, 9 Mar 2022 13:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] arm64: kasan: fix include error in MTE functions
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, andreyknvl@google.com,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, paul.semel@datadoghq.com
References: <bacb5387-2992-97e4-0c48-1ed925905bee@gmail.com>
 <20220309113935.GA352@willie-the-truck>
From:   Paul Semel <semelpaul@gmail.com>
In-Reply-To: <20220309113935.GA352@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 12:39, Will Deacon wrote:> Do you know where this issue was 
introduced? I can't tell whether this patch
> is a fix for 5.17, or something needed only for 5.18 (and if so, which tree
> introduced the problem).

This seems to have been introduced by 
2cb34276427a093e2d7cc6ea63ac447bad1ff4c1 if I am not mistaking. In which 
case, I guess this is a fix for 5.17.

Thanks,

-- 
Paul Semel
