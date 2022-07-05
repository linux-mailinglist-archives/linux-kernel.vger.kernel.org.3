Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE105677F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiGETlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiGETls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:41:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7071C10E;
        Tue,  5 Jul 2022 12:41:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id f26so510980ejl.4;
        Tue, 05 Jul 2022 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaCa1pHvEpowovin1FoM/a/4D+WGXtSWycYEfFOoJn8=;
        b=E48zrzVo+gN6mpL47FsShaJe4OOP8N0urz7fU3N5XDnh1/1eee50P/6qK0R9qBZpOm
         TDgf4z9e4retyFZOOfUabP3h+tziDdJWJ2A83eb0X/D29VNDiY8tbPRjZCbeOMhhUltf
         IG7ABvHDdejjOKocoDXZ6uiHzC+P0XEFZAkmxzRg/OnnVFG6p4O3Q/xqCMCe841McsTX
         WtiBUpctbW36a8rAWqM+VKnnBwfv+ZA7AInVrLOnsamFe97I1TI2vTJa38O2CE2S9a+D
         wOvI36b/OhvHguk+Ku925sOESa78BJxccZw8D6M7NX8goy6W8Y7TFcvJ1iD+2THk3xIw
         EfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaCa1pHvEpowovin1FoM/a/4D+WGXtSWycYEfFOoJn8=;
        b=37gFVLeEmSni6uWrpZdLXFD/QMTFhQ8ACjt4KMrGtAR4s9F36miDXP/KTXKJpVKxco
         MBqf8mlHd3I7NOg4kgOMjbdG0wssebtjXmVYHobIScek+4iq8tF49c3C5Cd3xywxFP9x
         Fa4dWy0mjFj0XRLJmNXiXXHkLXs2x7LTbwbqugOvd8XF67XmD+PIGNint05G6+WJQwIO
         hhCZKkjS7qFefcwLz7DiX4Y7O6cYVsKpy8lvh+8C8SOkMy97Nhu0SWvll+Q4a4ndpoJ1
         aOfrFNP/XGV3f/vswTueU3eYwoH8fptqBS8Z4fgt5hUpq63+8gKqLVM+VuFWms3bkEhP
         LlTg==
X-Gm-Message-State: AJIora/bR5KCPVZLYYuZ/es8yAualZ20JO2cLquYm4FzbH2RqR8f6RIf
        J04N1uDuxJa7saPg1x3eTeI=
X-Google-Smtp-Source: AGRyM1tP31/iJRcdSA/OIBkPjZrBAQZpMldBKfJr0e8X3l3cfnm6ZyKMwkJzx3sb7RMZzdMNmluOPA==
X-Received: by 2002:a17:906:6a14:b0:72a:b32c:e839 with SMTP id qw20-20020a1709066a1400b0072ab32ce839mr16896534ejc.468.1657050106412;
        Tue, 05 Jul 2022 12:41:46 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm16204874ejd.196.2022.07.05.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:41:45 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@lists.linux.dev, qianfanguijin@163.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>
Subject: Re: [PATCH v5 0/3] ARM: sun8i-r40: CPU improve
Date:   Tue, 05 Jul 2022 21:41:44 +0200
Message-ID: <1753004.3VsfAaAtOV@kista>
In-Reply-To: <20220517013607.2252-1-qianfanguijin@163.com>
References: <20220517013607.2252-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 17. maj 2022 ob 03:36:04 CEST je qianfanguijin@163.com napisal(a):
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> Change history:
> ===============
> v5(2022-05-17):
> - Move opp tables to sun8i-r40-cpu-opp.dtsi
> - cpufreq supports 720M, 912M, 1G, 1.1G, 1.2G
> - Add cooling supports
> 
> v4(2022-05-16):
> - Invert two patches.
> - Drop the cpufreqs that exceeds 1G in opp tables.
> 
> v3:
> - remove "allwinner-r40" compatible from allowlist.
> - split dts in two part.
> 
> Test:
> =====
> 
> cpufreq was tested by tools: https://github.com/ssvb/cpuburn-arm
> 
> 1. cpufreq-ljt-stress-test
> 
> - root@ubuntu:~/cpuburn-arm-master# ./cpufreq-ljt-stress-test
> - CPU stress test, which is doing JPEG decoding by libjpeg-turbo
> - at different cpufreq operating points.
> -
> - Testing CPU 0
> -  1200 MHz ............................................................ OK
> -  1104 MHz ............................................................ OK
> -  1008 MHz ............................................................ OK
> -   912 MHz ............................................................ OK
> -   720 MHz ............................................................ OK
> -
> - Testing CPU 1
> -  1200 MHz ............................................................ OK
> -  1104 MHz ............................................................ OK
> -  1008 MHz ............................................................ OK
> -   912 MHz ............................................................ OK
> -   720 MHz ............................................................ OK
> -
> - Testing CPU 2
> -  1200 MHz ............................................................ OK
> -  1104 MHz ............................................................ OK
> -  1008 MHz ............................................................ OK
> -   912 MHz ............................................................ OK
> -   720 MHz ............................................................ OK
> -
> - Testing CPU 3
> -  1200 MHz ............................................................ OK
> -  1104 MHz ............................................................ OK
> -  1008 MHz ............................................................ OK
> -   912 MHz ............................................................ OK
> -   720 MHz ............................................................ OK
> 
> Overall result : PASSED
> 
> 2. cpu freq slow down when cpuburn-a7.out running
> 
> - temperature: 79213, online: 0-3, freq: 1200000
> - temperature: 79213, online: 0-3, freq: 1200000
> - temperature: 80230, online: 0-3, freq: 1104000
> - temperature: 78874, online: 0-3, freq: 1200000
> - temperature: 80004, online: 0-3, freq: 1104000
> - temperature: 79213, online: 0-3, freq: 1200000
> - temperature: 78196, online: 0-3, freq: 1200000
> - temperature: 79891, online: 0-3, freq: 1200000
> - temperature: 78422, online: 0-3, freq: 1200000
> - temperature: 80343, online: 0-3, freq: 1104000
> - temperature: 80343, online: 0-3, freq: 1104000
> 
> 
> qianfan Zhao (3):
>   ARM: dts: sun8i-r40: Add "cpu-supply" node for sun8i-r40 based board
>   ARM: dts: sun8i-r40: add opp table for cpu
>   ARM: dts: sun8i-r40: Add thermal trip points/cooling maps

Fixed opp table name and applied. Thanks!

Best regards,
Jernej

> 
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  5 ++
>  arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi      | 52 +++++++++++++++++++
>  arch/arm/boot/dts/sun8i-r40-feta40i.dtsi      |  5 ++
>  arch/arm/boot/dts/sun8i-r40.dtsi              | 36 +++++++++++++
>  arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts      |  5 ++
>  .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  5 ++
>  6 files changed, 108 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-r40-cpu-opp.dtsi
> 
> --
> 2.25.1


