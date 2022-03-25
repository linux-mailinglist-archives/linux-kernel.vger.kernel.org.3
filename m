Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745D4E7DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiCYTbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiCYTam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:30:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ABF3DE8D2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:26:40 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s25so11570440lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SrJbbfaddWfhMen20qeE+m66y7c5UtFQj6CzeAj6OjI=;
        b=pAIGj8V93uiAJjTlmDfKIrNSPI5B0Swb21IxwxtA2OT1fWA9xoWtkiYuFGd2YtrLzY
         EjVkBD6B6OmrGKVrwniwjA1oOEDGBS2ZdjYabLeHtK2EfbWaVmShnewTbHkTHXrSSYL+
         zsslkO+p6tDLQHUkKUSIEvBJmfH8l56kmYFnCYL+37Ra2wHkcGueG3Y1B2ViljRc+EuM
         LrWrAcCel0AEqINM6IG63ovAPuQyRjmPzK5ZvYVhbdJ8sD2TPyL0OQZO3Ub+DCq6kmvZ
         RY6L2ECQHMrKu293svlvJKkVFag++e46e2Y2UXlaiZ+38x9wz6VkDlGmuYNZuRiOv7Jz
         +kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SrJbbfaddWfhMen20qeE+m66y7c5UtFQj6CzeAj6OjI=;
        b=YJ1nSYa+Yqyyy6OlFs1+hrbhEpQH8fstbbg8gYVbsNzp4SGSMX+0NUpa2L40hKle49
         67vK/gXEDbHOrxK4llAF+RaaLoh2vGfQJHa97zmSqq0W/eoXsfMIxRbVC4/f8N1NK0EW
         /GjHRgKqM4bNgZSqxFsH3a54/996QiLOy8NEdBKlCM/KEtKS1nxtVTVgBXJJRuhep+Ae
         qKEc/LFH8yTfu6+DVNCpMh5X2D6RMd+IqZfluZ5ao5U52/qDp5MZCWZ4ykL5qUn4UGbC
         APxICSxomgmxoXd4vkRtn0WlVa00EUfAA9tdIM5y1xy2k9kVjQcIyGbwspX7EURmwfDf
         zO1w==
X-Gm-Message-State: AOAM5300remxwixRxh148ZBfMv4e5Wiw39yltCoY5TBWyBe7sSyM4a0P
        woTloo95j/9eU+Lm2/jZmJMy3MpStaP/iD9f
X-Google-Smtp-Source: ABdhPJwUgBLSDvNV1NlBzs98fMN9ijZv4koUdOJmoiCaJvLygneQGawLQNsV+XEZue+1J6bM2ic1iw==
X-Received: by 2002:a05:6000:1a8d:b0:204:39fa:d21c with SMTP id f13-20020a0560001a8d00b0020439fad21cmr9858181wry.9.1648229580850;
        Fri, 25 Mar 2022 10:33:00 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:d3b0:47bd:8485:31cd? ([2001:861:44c0:66c0:d3b0:47bd:8485:31cd])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm8544986wmv.31.2022.03.25.10.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:33:00 -0700 (PDT)
Message-ID: <e32a02a0-1f09-3038-81cb-54c632329dfa@baylibre.com>
Date:   Fri, 25 Mar 2022 18:32:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] arm64: meson: add dts bluetooth node for JetHub H1
Content-Language: en-US
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vyacheslav Bocharov <devel@lexina.in>
References: <20220325165501.81551-1-adeep@lexina.in>
 <20220325165501.81551-2-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220325165501.81551-2-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/03/2022 17:54, Vyacheslav Bocharov wrote:
> From: Vyacheslav Bocharov <devel@lexina.in>
> 
> Add bluetooth node for RTL8822CS uart to JetHub H1 dts file.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts  | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> index 6eafb908695f..a5ee7ed17efa 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> @@ -213,6 +213,11 @@ &uart_A {
>   	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
>   	pinctrl-names = "default";
>   	uart-has-rtscts;

Please add a blank here to match other DT files.

> +	bluetooth {
> +		compatible = "realtek,rtl8822cs-bt";
> +		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
> +       };
>   };
>   
>   &uart_C {

