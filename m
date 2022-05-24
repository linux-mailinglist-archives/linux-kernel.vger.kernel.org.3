Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB6532CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiEXPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiEXPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62A538B094
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653405036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEo1NssAVGQZOfwlIMOHsifxPwTmlidTFKTUs0/1OgM=;
        b=L7dDmUE4h7qchINggUWBPsW/PXLkUMQ+xM/7/SPh349wAzf24VaQVWZw5gbGtoFgPTqrO9
        uut4jyr00R0MGwUmlSful/QZaK9X+w2jYyjx105SLg+00//2HbZ6TYJduPrVK9QTe1XpGb
        qBIcdI++u7p/qMOZpDOBYS6GvRvtieE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-bmIhUIT_NuKIzN2YWpP2Wg-1; Tue, 24 May 2022 11:09:09 -0400
X-MC-Unique: bmIhUIT_NuKIzN2YWpP2Wg-1
Received: by mail-oi1-f198.google.com with SMTP id f2-20020aca3802000000b0032b0a4dc9a8so4164016oia.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XEo1NssAVGQZOfwlIMOHsifxPwTmlidTFKTUs0/1OgM=;
        b=SFtg0TXjwJ5gInr9MLKZ+0dHeYie2pn0BFcrXVql8sl9jxwlGNrtfLCEcRIXzN8nyD
         806686FEu9gc/gPPERDmOqCODPYd6I+1MgL5wyU3BlMw3SK08a/m7FxkonDgCMXFT+cp
         cpEa6Ht39+Ooloy6t6amSC02zCR13Fd4wGkwxfLwWmF6XjUmj22KdNL4XHCNsV21BXua
         S79AXv4t7Thrs57uWK1wLYnc3ZwlZYgC0rf8tpuc4gLGmyTNfx+kvt8tsudB6Kpd6H5c
         oX9/R8BOEoUrEmq0Td2V8MM5cvIfF4jY1Lw5uBT+CgMxvkvowLtN+wIN4cuNGL2vNIlY
         7TNg==
X-Gm-Message-State: AOAM533nMsHcQOBNNIJ1+D5UREJbdfmFOx3D9cuFgG/qfobE/alk10+S
        g4NnVr6Ey/Sb/0SgBxnC+WcIAwJ7MKM/265Hlut4mcNlGvFHcGsTEGGG+InqRtswt8AYpq6gzFL
        2TaqJkd60pJrJoYj37lMwR0k1
X-Received: by 2002:a9d:811:0:b0:60a:b6f2:ab85 with SMTP id 17-20020a9d0811000000b0060ab6f2ab85mr6516333oty.9.1653404948239;
        Tue, 24 May 2022 08:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2Rrz8fDExW7WCjRqyXrFYjg5Q3G0iEtos25IWByh96ynkYINF5ql63GdcjlrT4RcCKJU4fg==
X-Received: by 2002:a9d:811:0:b0:60a:b6f2:ab85 with SMTP id 17-20020a9d0811000000b0060ab6f2ab85mr6516299oty.9.1653404947414;
        Tue, 24 May 2022 08:09:07 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id k17-20020a9d1991000000b0060b0b638583sm3021001otk.13.2022.05.24.08.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 08:09:07 -0700 (PDT)
Subject: Re: [PATCH] ath6kl: Use cc-disable-warning to disable
 -Wdangling-pointer
To:     Nathan Chancellor <nathan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>
References: <20220524145655.869822-1-nathan@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c7a804ed-e00c-8a32-db21-c689312e0073@redhat.com>
Date:   Tue, 24 May 2022 08:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220524145655.869822-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/22 7:56 AM, Nathan Chancellor wrote:
> Clang does not support this option so the build fails:
>
>    error: unknown warning option '-Wno-dangling-pointer' [-Werror,-Wunknown-warning-option]
>
> Use cc-disable-warning so that the option is only added when it is
> supported.
>
> Fixes: bd1d129daa3e ("wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Tom Rix <trix@redhat.com>

Thanks

Tom

> ---
>   drivers/net/wireless/ath/ath6kl/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath6kl/Makefile b/drivers/net/wireless/ath/ath6kl/Makefile
> index 01cc0d50fee6..a75bfa9fd1cf 100644
> --- a/drivers/net/wireless/ath/ath6kl/Makefile
> +++ b/drivers/net/wireless/ath/ath6kl/Makefile
> @@ -38,7 +38,7 @@ ath6kl_core-y += recovery.o
>   
>   # FIXME: temporarily silence -Wdangling-pointer on non W=1+ builds
>   ifndef KBUILD_EXTRA_WARN
> -CFLAGS_htc_mbox.o += -Wno-dangling-pointer
> +CFLAGS_htc_mbox.o += $(call cc-disable-warning, dangling-pointer)
>   endif
>   
>   ath6kl_core-$(CONFIG_NL80211_TESTMODE) += testmode.o
>
> base-commit: 677fb7525331375ba2f90f4bc94a80b9b6e697a3

