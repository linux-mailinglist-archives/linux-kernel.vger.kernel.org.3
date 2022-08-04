Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11E5895AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 03:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiHDBgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 21:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiHDBgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 21:36:21 -0400
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 18:36:19 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C2D720BD7;
        Wed,  3 Aug 2022 18:36:19 -0700 (PDT)
Received: from [192.168.20.102] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 1C9D514015B;
        Thu,  4 Aug 2022 01:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1659576558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRaqQSwJE0HG3dU4ptJs4IAer95j88GgLQPrsa6QiKQ=;
        b=yqIm8IT+tVTcypMS/waMqRVq2pDNsPD5JJrWicP0sd46VynMJL5Z3Rmt7mxIZYqhn9GJwX
        YZ6AknPi0KgiKLUVYGGi9fzCmn4CUjMig4BdMF3Z8ij8YGd9lCQVsr2PMoqK7je7K6PVtd
        EE7nWOy8JgbrqmshX6Vr4dhH+90anyI=
Message-ID: <f66c2053-74bd-04fb-13e4-8eeb7f426608@postmarketos.org>
Date:   Thu, 4 Aug 2022 04:29:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: qcom: gcc-sdm660: Use floor ops for SDCC1 clock
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714203822.186448-1-marijn.suijten@somainline.org>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20220714203822.186448-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 23:38, Marijn Suijten wrote:
> In commit 3f905469c8ce ("clk: qcom: gcc: Use floor ops for SDCC clocks")
> floor ops were applied to SDCC2 only, but flooring is also required on
> the SDCC1 apps clock which is used by the eMMC card on Sony's Nile
> platform, and otherwise result in the typicial "Card appears
> overclocked" warnings observed on many other platforms before:
> 
>      mmc0: Card appears overclocked; req 52000000 Hz, actual 100000000 Hz
>      mmc0: Card appears overclocked; req 52000000 Hz, actual 100000000 Hz
>      mmc0: Card appears overclocked; req 104000000 Hz, actual 192000000 Hz
> 
> Fixes: f2a76a2955c0 ("clk: qcom: Add Global Clock controller (GCC) driver for SDM660")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>

Tried this on my SDM660 xiaomi-lavender, warnings are gone, thanks!

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
