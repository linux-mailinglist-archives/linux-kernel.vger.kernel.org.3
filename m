Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39644ECD48
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350828AbiC3Tdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiC3Tds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:33:48 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539A31907;
        Wed, 30 Mar 2022 12:32:02 -0700 (PDT)
Received: from g550jk.localnet (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 61CE3CB4E4;
        Wed, 30 Mar 2022 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1648668720; bh=3DNVwDtsuq84RLI2K9SxbW0zu52l4bles7Y6Cf+v0m0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=paHlFmHyJGZCBHVducC4U0j5/v4wjZzR61VJ7wvflsD+M8R8M52P1jONty71dxzsx
         1UcHeBwl84mKCDmtGC2S3QMrg1a0P3oJMds2C6wmhAboz46tXJ1/UNqIEDcZmyZkHE
         2BAXBDMQ8CZFuqwd1iqRihmhVlTEotap1FGeUNwI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Jack Matthews <jm5112356@gmail.com>
Cc:     jm5112356@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: qcom: pm8226: add node for RTC
Date:   Wed, 30 Mar 2022 21:31:59 +0200
Message-ID: <6933014.lOV4Wx5bFT@g550jk>
In-Reply-To: <20220209165742.652890-1-jm5112356@gmail.com>
References: <20220209052929.651881-1-jm5112356@gmail.com> <20220209165742.652890-1-jm5112356@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 9. Februar 2022 17:57:41 CEST Jack Matthews wrote:
> Add a node for PM8226's real time clock.
> 
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

Also on lg-lenok at least "allow-set-time;" seems to allow writing to the RTC. 
As I'm quite unsure of the reasoning of it normally being read-only and the 
implementation details behind what might restrict this I don't think we can 
safely add this to all pm8226.

Regards
Luca

> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> b/arch/arm/boot/dts/qcom-pm8226.dtsi index 872724490a5d..8ee628ce88a9
> 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -73,6 +73,13 @@ adc-chan@f {
>  			};
>  		};
> 
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 
IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		pm8226_mpps: mpps@a000 {
>  			compatible = "qcom,pm8226-mpp", "qcom,spmi-
mpp";
>  			reg = <0xa000>;




