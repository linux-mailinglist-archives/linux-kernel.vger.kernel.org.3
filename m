Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2122D53CC21
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbiFCPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245403AbiFCPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB16506C1;
        Fri,  3 Jun 2022 08:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0FE66186D;
        Fri,  3 Jun 2022 15:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD19C385B8;
        Fri,  3 Jun 2022 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654269294;
        bh=kCDqKxgSBW1zW4hSfO+3ZljVtjIYIRBqdB6IPefPA2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GOfyERozHdsiH3+V20TajRS8VF+rK3pLspYPXYlV/wXnoOuBYCgvA5j6gRtfucZz5
         5KNnZLXdh/CkU9CySG++EblXbebLNNLKOV8exqcXG1s6dMYhCEG9A3Ym6FJZKcBsMd
         ElTzgdH7DMmopE0HAyhuGmyl3tHBlggJ0sZtmemeDT4vt0E/wfTSr1uX3Uq5P6a1Pi
         qaygK9qyntxv2KPdHyxmTThxj+h/0sQQHfWoE1/Oqev1rDSgI3l2X3JBatFKiA9ZqZ
         L5C6thelnCEVAdfrDUf6RbqMeByJEU5C6Ot9yLL2JekOf/GWf+7X++aM+YoXh1t07g
         Hm2Dq9kp3Fnqg==
Date:   Fri, 3 Jun 2022 16:23:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Add support for ToF sensor on Yoshino platform
Message-ID: <20220603162351.69056bdf@jic23-huawei>
In-Reply-To: <20220523175344.5845-1-markuss.broks@gmail.com>
References: <20220523175344.5845-1-markuss.broks@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 20:53:39 +0300
Markuss Broks <markuss.broks@gmail.com> wrote:

> This series adds support for the ToF proximity sensor installed on
> Yoshino devices. As part of this series, support handling the reset
> GPIO and VDD supply by the VL53L0X driver. Also stop hardcoding the
> interrupt type, since on Yoshino devices it seems that edge triggering
> doesn't work properly.
> 
> Tested on Sony Xperia XZ1 (poplar).
> 
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Patches 1-4 applied to the togreg branch of iio.git.

Note I plan to rebase that tree after the char-misc (and hence IIO tree)
has been merged with mainline, so for now it is only pushed out as testing
so that 0-day can see if it can find anything we missed.

Thanks,

Jonathan

> 
> v2:
> - Fix a nasty issue: turns out grouping the pinctrl makes it not apply,
> which was the main cause of edge interrupts not working correctly and
> having to use level interrupts, which caused a large amount of false
> detections.
> - handle the irq type more gracefully: if it's not provided, default
> to falling edge, but if it's provided, then use the provided one.
> v3:
> - add irq.h header (forgot to commit)
> - reword commit message (already initialized -> pre-initialized)
> v4:
> - reorder powering on and power off action (Jonathan)
> - sort pinctrls by GPIO number (Konrad)
> v5:
> - "This patch adds..." -> "Add ..." (Krzysztof)
> 
> Markuss Broks (5):
>   dt-bindings: proximity: vl53l0x: Document optional supply and GPIO
>     properties
>   proximity: vl53l0x: Get interrupt type from DT
>   proximity: vl53l0x: Handle the VDD regulator
>   proximity: vl53l0x: Handle the reset GPIO
>   arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support
> 
>  .../bindings/iio/proximity/st,vl53l0x.yaml    |  5 ++
>  .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 34 +++++++++++++
>  drivers/iio/proximity/vl53l0x-i2c.c           | 50 ++++++++++++++++++-
>  3 files changed, 88 insertions(+), 1 deletion(-)
> 

