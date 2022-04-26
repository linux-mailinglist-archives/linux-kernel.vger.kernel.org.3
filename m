Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD9510234
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352577AbiDZPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352550AbiDZPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:54:18 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD82BB0D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:51:10 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id g20so22902582edw.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3DcH5qmRZJM8zM4oxn8FmbxTfqplHnMNRmIFYowfm8c=;
        b=pn0X8ne+Cr1unwKMgSSCLRbnZKniz1FjgFo60rK+GN/tXwuA1i1POqsEuXa/Vq7un7
         Q70CG7SPxG8eNUybNrtik5TnQfFCO9fmOPOliExXa7nolvSLeEzwYRMF8y5d4cT2Whsp
         gINtTPPfzCl2MpYa/NDIa7o9mMKNi0U55ryYzR5MNmwr34ScoCXJlAXZ3WODUWN3cx13
         e8tkKiz1t0WdbOurfxnXQrbP5QOrG64fOBMdAM3lqF5utQr0nhrV7HhH7IfD0kOnpb0O
         tyJLRka7Yl3txjz1praH6S92MDbOoIfIJrRYR5aLMhY8zUbm+rtmxsNbfLXIkcjc2ljO
         rA3A==
X-Gm-Message-State: AOAM532AI8k2F/RzLCJuK0Is80zTS8h8zmoyZp1sf9VnsjwbxIXYgAV8
        cLIs+RcPnQbRV+VsMWkPbVg=
X-Google-Smtp-Source: ABdhPJwUvw93fjb0RgD6zKtbnHOLJdmZGy55Vj2lG2xTj4WbyEn08sepS7sk68mOF5G+RtGxWEDnKQ==
X-Received: by 2002:a05:6402:27d1:b0:425:ef57:7db2 with SMTP id c17-20020a05640227d100b00425ef577db2mr9627883ede.180.1650988268964;
        Tue, 26 Apr 2022 08:51:08 -0700 (PDT)
Received: from [10.9.0.34] ([46.166.128.205])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00422eedf16b4sm6491110edz.60.2022.04.26.08.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:51:08 -0700 (PDT)
Message-ID: <91238500-61a6-1e2e-1dc2-931c0a23cca8@linux.com>
Date:   Tue, 26 Apr 2022 18:51:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        luto@kernel.org, will@kernel.org
References: <20220425115603.781311-1-mark.rutland@arm.com>
 <202204251551.0CFE01DF4@keescook>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <202204251551.0CFE01DF4@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2022 01:54, Kees Cook wrote:
> On Mon, Apr 25, 2022 at 12:55:55PM +0100, Mark Rutland wrote:
>> This series reworks the stackleak code. The first patch fixes some
>> latent issues on arm64, and the subsequent patches improve the code to
>> improve clarity and permit better code generation.
> 
> This looks nice; thanks! I'll put this through build testing and get it
> applied shortly...
> 
>> While the improvement is small, I think the improvement to clarity and
>> code generation is a win regardless.
> 
> Agreed. I also want to manually inspect the resulting memory just to
> make sure things didn't accidentally regress. There's also an LKDTM test
> for basic functionality.

Hi Mark and Kees!

Glad to see this patch series.

I've looked at it briefly. Mark, I see your questions in the patches that I can 
answer.

Please give me some time, I'm going to work on your patch series next week. I'll 
return with review and testing.

Thanks!
Alexander
