Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805E056C3B2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiGHUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiGHUoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:44:03 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CB9CE3F;
        Fri,  8 Jul 2022 13:44:01 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 373731F6C6;
        Fri,  8 Jul 2022 22:43:57 +0200 (CEST)
Message-ID: <bb78f8fb-d6ea-5c37-0531-8d7584bc897b@somainline.org>
Date:   Fri, 8 Jul 2022 22:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] Add support for Xiaomi Poco F1 EBBG variant
Content-Language: en-US
To:     Joel Selvaraj <jo@jsfamily.in>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.07.2022 13:12, Joel Selvaraj wrote:
> There are two variants of Xiaomi Poco F1.
> - Tianma variant with NOVATEK NT36672A panel + touchscreen manufactured
>   by Tianma
> - EBBG variant with Focaltech FT8719 panel + touchscreen manufactured
>   by EBBG
> 
> The current sdm845-xiaomi-beryllium.dts represents tianma panel variant.
> 
> To add support for the EBBG variant, let's split this into 3 files,
> - sdm845-xiaomi-beryllium-common.dtsi which contains all the common nodes
> - sdm845-xiaomi-beryllium-tianma.dts for the tianma variant
> - sdm845-xiaomi-beryllium-ebbg.dts for the ebbg variant
> 
> Note:
> -----
> Both the panels are already upstreamed and the split is based on them.
> There were patches earlier for both the touchscreens, but they are not
> accepted upstream yet. Once they are accepted, we will add them to
> respective variants.
Hi,

I believe this is not the correct approach. This may work short-term, but
you will have to prepare 2 separate images for the device and mistaking them
may cause irreversible hw damage at worst, or lots of user complaining at best.
Instead, I think it's about time we should look into implementing dynamic panel
detection.

Qualcomm devices do this by parsing the command line [1], as LK/XBL
gives you a nice-ish string to work with that you can simply match
against a label. Other vendors may use custom mechanisms, such as
a resistor / GPIO to determine which panel (or generally hw config),
but implementing this mechanism would make upstreaming of lots of other
devices easier..

This issue concerns many phones (and well, devices in general), as
they are seldom made with only one configuration due to supply chain
strategies.


Konrad

[1] https://github.com/LineageOS/android_kernel_xiaomi_sdm845/blob/lineage-19.1/drivers/gpu/drm/msm/dsi-staging/dsi_display.c
