Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB171595677
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiHPJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiHPJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D337185
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:52:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x10so9860513ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Zo8H3uzErLP1wNsnlXwUezo5M3r0n38M91eeu4OULT8=;
        b=jYUghN9OlERJWRrLTTvraX96AytkJohc0st+7N7n7OB4ZSPw8KZwEmt2cFt0sxN3Tk
         PGpXWGU/W/VXC2vX9FtohU70nERi3HQZPDO5ttWiI+7lZuCvZiNJ8KkssrR55EBvxTvN
         WyumD4f2peQ9blnK5oI0sH9qiHpPEQXlG0YKYhkbTRy3lkPgZhq7aFhIr+S8BA5YAQI1
         BQ7ie9FMwQ7JCMwe1Rgb/uGycDcD72o+idkASf6Yxl/sz/zUvkKik3IEvp1bIRhzAzOl
         pLfa9syB+HQCp5lGEVj1hJfg2FNfAq6GBQt4eek0mX77L/9olL5guGe+TeR24sozxguA
         O3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Zo8H3uzErLP1wNsnlXwUezo5M3r0n38M91eeu4OULT8=;
        b=jtv8JlvBDPQTnvqOMeqWH20xel52jrVfJCPXyiw5SAjuGkS8jGdG4tou9iKcNj4LFF
         ZGA53EaPn4ni/ZMOgoIJlYW6XG5cKptNLnNvS9R53pSc0LMlIdbl/bhYW0gjZZyoQGwX
         iSdFoZgBH98JYEoIpsNhHNgxXjGz/ZruR5UQcIqfV/Do/+OdoMMpaA7mwM859+jq6n7X
         t5lduFhcu7DOoDslFDl0tSQ+T3ku2oogqmNTmOkCWlz/nsCEkbVRTNJyJxju7yFKvo9b
         PtIOBBeqs8EcOrlR5DXIwxc4ny0jmUtmZZ8DLbOkMb9i5YVSkwK93ccZKvQyAeXbh8XS
         pC9A==
X-Gm-Message-State: ACgBeo2TBJ88QmYXgmomb23jKX0Yukgudkg07hB652UdY006BBX1Uo81
        GL9Cm9Dqsve4J/YtEyNEIEvWhw==
X-Google-Smtp-Source: AA6agR6+SnVBnZcM+MorC2B6pGea+5Cy8dza4nJPUFRgbZ+cRDJR1xIU0DuzrV6wJ5MeUlQmtuJ8xA==
X-Received: by 2002:a05:651c:2212:b0:25e:cc38:a1dc with SMTP id y18-20020a05651c221200b0025ecc38a1dcmr6509948ljq.359.1660636323001;
        Tue, 16 Aug 2022 00:52:03 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id p4-20020a19f004000000b0048a98b7bad3sm1302318lfc.197.2022.08.16.00.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:52:02 -0700 (PDT)
Message-ID: <a11bc22e-a10e-7d15-72d2-6af1d4790695@linaro.org>
Date:   Tue, 16 Aug 2022 10:52:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 15:30, Tom Fitzhenry wrote:
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Pine64 PinePhonePro";
> +	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		mmc0 = &sdio0;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdhci;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwrbtn_pin>;
> +
> +		power {

Still wrong. Do not ignore comments and test your DTS with dtbs_check.

Best regards,
Krzysztof
