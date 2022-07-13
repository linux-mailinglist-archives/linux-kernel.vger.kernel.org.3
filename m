Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51081573DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiGMUqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbiGMUqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BF42B1BE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:46:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so11497220pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=tIHGf4VW/fEwq1AvVsdPyI+0X2e9Ro/7w+8ubGt0XGE=;
        b=j2W7lWqTya69RXYlcCaYeipeFckSMlpZ9ipyhy+uWLZ/3bmkXmSAB5Dh20tJu+ZdGp
         A/pkDtVvYDU0N5C+i7Q29P58If1WjlNhsEr32JwzvYtAd3oLzBEukuUhdrWYRhkbdDlG
         VROAJ2Or7X2i2lsfMMXUcuzsgzCqX4z71UUvFicXdRevXw6MFMeYtKqsUDI+wTTNwR/k
         i2dc4NGZsgyPczNJvya91wm6LY+ulpOV9frcCOtRo2lvYUYSJu+UUEm6q7NjUCDjIi0F
         +6WU9XHcQZ03YMKmgfUYUxPGRPZ4qtZ+hOIpxbotPHLdf/rH7R6ni4iyBiQZaI4a9jsq
         KDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=tIHGf4VW/fEwq1AvVsdPyI+0X2e9Ro/7w+8ubGt0XGE=;
        b=Zn+6jttT7WD2tD2JW9fwzAD1Fa9OW9Z8W5ux1vBZNaeOH2bYe57m0EtjVycjXusOcP
         DD1ESnyBE/Yw0h8FxWo0F/lCALerY9rFQ1q71WTvMw4pePwEzCkm+Zo9pX6GSlED694k
         F3M0fjAv3d11Cn64sqee6/Sqp8U21XzinIYP5aUgDFQsYj9ooOrPexloxudXxwjPOl6I
         XHIuM/UzpZLwhAwoxmwicBKc06NuKBgVNvqQuzoEu/ePoFIp4Wf4unAQfmitg3eAkOUb
         Ac42sQ4Ht3C/lpuN1jUrqtOtttQX6UbSP/XENf6sHnshutP3vu7PbBNyENM9T3IWrWhS
         NOVQ==
X-Gm-Message-State: AJIora+Wuaj0UdoEYkC1ghjX6J9ljVxcL4nSJGFt+pcXVbOwUa9x838J
        qzEEfBLZQGV9fXBRR0UPwZE=
X-Google-Smtp-Source: AGRyM1vS7zvXK/oILf0Xl/3i10B0jjfIBbeBlp28QNm71y+ud7LNyLdNrwNmzh9EkBb8+Pm6R4NJCw==
X-Received: by 2002:a63:8441:0:b0:415:d595:a7d6 with SMTP id k62-20020a638441000000b00415d595a7d6mr4327558pgd.441.1657745179232;
        Wed, 13 Jul 2022 13:46:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11-20020a62ce0b000000b0051b32c2a5a7sm9202756pfg.138.2022.07.13.13.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:46:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
Date:   Wed, 13 Jul 2022 13:46:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.19-rc6
In-Reply-To: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 12:36, Linus Torvalds wrote:
> On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Same problems as every week.
>>
>> Building powerpc:allmodconfig ... failed
> 
> Ok, this has been going on since -rc1, which is much too long.
> 
>>From your patch submission that that was rejected:
> 
>> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
>> 64-bit outline-only KASAN support") which adds support for KASAN. This
>> commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
>> KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
>> compiled which lack the selection of hard-float.
> 
> And considering that neither the ppc people nor the drm people seem
> interested in fixing this, and it doesn't revert cleanly I think the
> sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
> entirely.
> 
> IOW, does something like this (obviously nor a proper patch, but you
> get the idea) fix the ppc build for you?
> 
>    @@ -6,7 +6,7 @@ config DRM_AMD_DC
>            bool "AMD DC - Enable new display engine"
>            default y
>            select SND_HDA_COMPONENT if SND_HDA_CORE
>    -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
> !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>    +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
> KCOV_ENABLE_COMPARISONS)
>            help
>              Choose this option if you want to use the new display engine
>              support for AMDGPU. This adds required support for Vega and
> 

It does, but I can't imagine that the drm or ppc people would be happy
about it.

Guenter
