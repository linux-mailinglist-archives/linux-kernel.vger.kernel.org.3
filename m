Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6A55472F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbiFVKDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiFVKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ACF010C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655892170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/eL/PHNNzRBjNtZdC844dkLISla6uJITnCexEQnYOY=;
        b=GzaLaK+YRKWjVc+Jg1nvW/0y3dW3PryjHTAjWFljDCG2peNyHBrjuRpiLUhTXLcPc3vdHu
        lyJN8dArec1JqiZWsixVRqmc7YGYhx8XgcqZQopoog5BpAPqW8Dy3h2uilKNm3VrFXYy6m
        WIvWNvRU9T+mXyrRJOpESaRP+zTCYD4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-DHx3msDYPWKJdvrhPPPT8A-1; Wed, 22 Jun 2022 06:02:49 -0400
X-MC-Unique: DHx3msDYPWKJdvrhPPPT8A-1
Received: by mail-ed1-f69.google.com with SMTP id g7-20020a056402424700b00435ac9c7a8bso1089291edb.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i/eL/PHNNzRBjNtZdC844dkLISla6uJITnCexEQnYOY=;
        b=vuSHts4unmQUprDrgPGoyIB2Cz4K+jguvE5Fv1xbLl2Irp9L/YyniOhfTIWI36Pj+o
         t7CKrHdTuGgC6SXdx20UGICPG5lV48BLDKMLKy6ugZZgqrdmYWJQModak6bnIDaIstoc
         1fkoBaUbi39BlbwcK1U69/EjX2OqUUFmcm1od1eOBlqokudRhu1rQoExwdjW0DminKbG
         JlqTXLJmsf6JvX1oKGuD2Sc8SaA6eR6ObXYeTr893qHERRZJB0QG0OjOzypHtr7KoWSe
         WhBVIxscuRiN+pBQf2V79iY4nbuvk2Qu5JCNyuHgPMjmi+4yYzcsc0e8fC4qDIo33z3i
         4ovw==
X-Gm-Message-State: AJIora+2i+/A0va6tXAnFY3UoD+kmZfPX7IyJyNRISLxtOlBs6FDTgYE
        N+htS9105aSJoRJZeMdk3DwblcWhmzQocWY9nN3iQ9lBWj2mzFZoPKFY1zY7n2rEFO2lLMpy8Rr
        2/vFpdTmOkKug0aXtlH8/jYIv
X-Received: by 2002:a17:906:1003:b0:718:cca8:6cd6 with SMTP id 3-20020a170906100300b00718cca86cd6mr2394618ejm.428.1655892167856;
        Wed, 22 Jun 2022 03:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uyAJHafbjvRgIph1bMmP2S5uZKelMBRwUV8V7g4QloK6ti2Wq2Asn4p0wRL/TQfKhjTYOANA==
X-Received: by 2002:a17:906:1003:b0:718:cca8:6cd6 with SMTP id 3-20020a170906100300b00718cca86cd6mr2394600ejm.428.1655892167660;
        Wed, 22 Jun 2022 03:02:47 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.135.195])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b007052b183d51sm9112972eje.132.2022.06.22.03.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:02:47 -0700 (PDT)
Message-ID: <17d3745b-f86d-a864-2b61-e00cad6414cd@redhat.com>
Date:   Wed, 22 Jun 2022 12:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Remove duplicate
 macro
Content-Language: en-US
To:     Risheng1128 <hi4u29ck02@gmail.com>,
        srinivas.pandruvada@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610172714.27772-1-hi4u29ck02@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220610172714.27772-1-hi4u29ck02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Srinivas, I assume that you will review and pick this one up?

Regards,

Hans

On 6/10/22 19:27, Risheng1128 wrote:
> There are some macros such as `GENMASK` and `GENMASK_ULL` are redefined in
> `include/linux/bits.h`. Simultaneously, the `GENMASK` in
> `include/linux/bits.h` is more secure and prevents the following situation.
> 1. [net: stmmac: Fix misuses of GENMASK macro](https://reurl.cc/loMWvl)
> 2. [clocksource/drivers/npcm: Fix misuse of GENMASK macro](
> https://reurl.cc/b2yr96)
> 
> Therefore, I think these macro could be removed.
> 
> Signed-off-by: Risheng1128 <hi4u29ck02@gmail.com>
> ---
>  tools/power/x86/intel-speed-select/Makefile | 1 +
>  tools/power/x86/intel-speed-select/isst.h   | 7 +------
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/Makefile b/tools/power/x86/intel-speed-select/Makefile
> index 7221f2f55e8b..760d49d61955 100644
> --- a/tools/power/x86/intel-speed-select/Makefile
> +++ b/tools/power/x86/intel-speed-select/Makefile
> @@ -14,6 +14,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS += -r
>  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include -I/usr/include/libnl3
> +override CFLAGS += -I../../../include
>  override LDFLAGS += -lnl-genl-3 -lnl-3
>  
>  ALL_TARGETS := intel-speed-select
> diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
> index 0796d8c6a882..44de990d182e 100644
> --- a/tools/power/x86/intel-speed-select/isst.h
> +++ b/tools/power/x86/intel-speed-select/isst.h
> @@ -27,12 +27,7 @@
>  
>  #include <stdarg.h>
>  #include <sys/ioctl.h>
> -
> -#define BIT(x) (1 << (x))
> -#define BIT_ULL(nr) (1ULL << (nr))
> -#define GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (sizeof(long) * 8 - 1 - (h))))
> -#define GENMASK_ULL(h, l)                                                      \
> -	(((~0ULL) << (l)) & (~0ULL >> (sizeof(long long) * 8 - 1 - (h))))
> +#include <linux/bits.h>
>  
>  #define CONFIG_TDP				0x7f
>  #define CONFIG_TDP_GET_LEVELS_INFO		0x00

