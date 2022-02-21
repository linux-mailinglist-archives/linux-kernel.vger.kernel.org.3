Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72754BEBEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiBUUge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:36:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiBUUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:36:32 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A345237D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:36:08 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5F21740041
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645475764;
        bh=U1X8yA1Izrtu66/dEyXiQXCP/Yonm2UMSc/H4P/UzfQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=RgffgGfANB2Q5Y9AqrynMK7Sn7kFtHYKCLzl1PusPvRlWXm5M/DG4RYNW1RnaRk7R
         m4nVh8UBdL+UzfvebqX/H18o+BdhbuqPwvM29/2857Q67tt+0zTggf1AdwR/0YUutT
         e+RUCh2w1J8VrdP6hzTyqkg2ChY9SRwqzcvXlUSOnlds9x6XWmkfIhZjcW0NngijVi
         5WWtEhtwptNwD80oxQUEk1jgvTVSha7KJ7PSXcg6vZ5tlFxqiPag4QCNZuD4PUTIES
         BHsvmbpYS4X0rqKE6BOrdWxIB99I4Od5vMH4yUcQ+K9KHiRHNzGi3mmL17A7TKXjNy
         a1HGb9QABzN+A==
Received: by mail-ed1-f71.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so10726688edw.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U1X8yA1Izrtu66/dEyXiQXCP/Yonm2UMSc/H4P/UzfQ=;
        b=L8ZcptFOSe5FN+6myF1in57D9QqQbu+V06woJAwtPNRK9kriG5bO/ysJgTri/Q9E4a
         /o4mc/42MLaHKHnuKV7/GiIWKvzjzQ9ILlYUUn83/Qeei73wRihsxqjIzw5zXda4b6e0
         koQjDVWy/d/ghkr48qXW9vHN7egmO55ULWmoEeCEkGUv0eI05ICHi/tHTDOQ12SAtdN0
         nlkTIKN81qEGvZRYyzJrM1jHZPHLZ+jrj7rls2dg4YIWCALcgpeC0auMCKqpNKUD6GSZ
         e4J1K0zs3edST+ZlYN51nsDpPu6gNEmSGGk/Oz1PYy/czSiRv+kf2A9AmgDwkdwfL455
         jf+g==
X-Gm-Message-State: AOAM530YEcsyHubQ9qGDy3elMolFwtBtQeP0oWsu6NmhiiyEhB/Bx+V2
        dDAcptDULvWJd+f2rJTdpEUrZfpFNAB189e2VpXve/4XVLgAQwxOfybUeU5M7U+OmLmxSgf71Q1
        Ql4xRtgJGk10EDir6gD5wTNCMwW7fArYqDgC0H06C8g==
X-Received: by 2002:a17:907:2954:b0:6cf:7634:c6b7 with SMTP id et20-20020a170907295400b006cf7634c6b7mr16672981ejc.683.1645475764049;
        Mon, 21 Feb 2022 12:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7JyJzqH58SpigIPgDM+kaxx8HSCtkrYGrEFZflvAXrNDd7Y3eppYCEgvt5S9ho/TzPnIXtQ==
X-Received: by 2002:a17:907:2954:b0:6cf:7634:c6b7 with SMTP id et20-20020a170907295400b006cf7634c6b7mr16672965ejc.683.1645475763784;
        Mon, 21 Feb 2022 12:36:03 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ka26sm992729ejc.170.2022.02.21.12.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:36:03 -0800 (PST)
Message-ID: <eb9d0fa9-78c7-30d9-b9d3-5ab9490cf38d@canonical.com>
Date:   Mon, 21 Feb 2022 21:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/1] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220221194958.117361-1-virag.david003@gmail.com>
 <20220221194958.117361-2-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220221194958.117361-2-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2022 20:49, David Virag wrote:
> Add initial Exynos7885 device tree nodes with dts for the Samsung Galaxy
> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> Currently this includes some clock support, UART support, and I2C nodes.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>

I guess this goes with (from v5):
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Best regards,
Krzysztof
