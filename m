Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2759562A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiHPJ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiHPJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:25:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52B4F657
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:41:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d14so13671432lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Z4YfB/AJeb982Xz2QYWpjFSws7upX3bELQnOSH90aGQ=;
        b=XNiAZ2MhGZde1OxcLeMx6rt6sGhm0MIYRYttklKEzARCVhtOjGTS0I5VuPCcpOoZq4
         AazIXWhkMfjWgm8AzXKS5TOFgz5lSEPLZzZ/BEUT+8Lm5H80GyoGLmJs0BSb4GWCZgoS
         JCqkF8hGO/4+8FfYNJ9xcdWEeGg7O7tBBr24kUBYSb/BPEDblFxPKfK5Gw96lxzkFEzt
         ER3UACt0W0pzppQyL+RJMr5S6YAkykB6raCdrkeY6SWQR/Sers/mv4s67CwuCykj4Tzi
         Mvx2YvrL1HS2p5yB8blMpvmxW38bgtOdagu886tBN0axwkfs/RY5+yT77lu2oY8h6x/u
         AWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Z4YfB/AJeb982Xz2QYWpjFSws7upX3bELQnOSH90aGQ=;
        b=Ip+cEnUu9D4ImL7mDTSvmETbfIFpK2+Vk8rXnASjR3bFfTaFvRRqVJOc9bxRoXd2fC
         Jn69A7a8B3y0AIBZrDckWiJWsAscfwcegiESwVVGKNsKVR4Ipr4AkJvDMzEIMJ4qvaC0
         6CNRpfChrqblL6IsYyRzoBp2a4KmFg4g+D8wevBZ3dzS2ZN+Vr35UamUmNWl4Q+4y5Ny
         GDpVM55+UFnc2EAHJQBZzUBf0jizdFLFzYWlpsMllWfM8lJHeu1g8j8ma9tx8/VaGnW1
         O7T8sWML0+6c0fFpKzWWEwhPhCvxV7IejxFajMBO1Ese+0rZxgk8TdyOlT1rtIx9AxgV
         m9Rg==
X-Gm-Message-State: ACgBeo3t+O9EJZ0wx/h+duW0wZf/DoyrvjSFA0t0uLtfBnSmyE2QJeVY
        z0PEWgvElFHOuO6Nyj3BYw9UFQ==
X-Google-Smtp-Source: AA6agR7yvXIG3FQUMlg6GW8tRa6cjzG0FZZbYwcSTqvWyjhEU2eExfEr5GNYE/fJJDjnTXq1o1QwNw==
X-Received: by 2002:a05:6512:6d3:b0:48a:e68c:15c9 with SMTP id u19-20020a05651206d300b0048ae68c15c9mr7099789lff.488.1660635706920;
        Tue, 16 Aug 2022 00:41:46 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb94f000000b0025d53cbba2bsm1704014ljs.45.2022.08.16.00.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:41:46 -0700 (PDT)
Message-ID: <149eee7b-a9e9-94ad-1ab2-13812b541a8c@linaro.org>
Date:   Tue, 16 Aug 2022 10:41:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-7-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815050815.22340-7-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 08:08, Samuel Holland wrote:
> +
> +	de: display-engine {
> +		compatible = "allwinner,sun20i-d1-display-engine";
> +		allwinner,pipelines = <&mixer0>, <&mixer1>;
> +		status = "disabled";
> +	};
> +
> +	osc24M: osc24M-clk {

lowercase

> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;

This is a property of the board, not SoC.

> +		clock-output-names = "osc24M";
> +		#clock-cells = <0>;
> +	};
> +


Best regards,
Krzysztof
