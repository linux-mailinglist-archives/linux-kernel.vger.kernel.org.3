Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4A581939
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbiGZRzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbiGZRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:54:48 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E73120B;
        Tue, 26 Jul 2022 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658858054;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hjtuIhDpaiY9mRneCER7+95fbBeocMXPTWAcisZCV3A=;
    b=HlcrcFgJmMJqXYrJrllcmj7nB/7eQv4KI2QcIYgmCY2a6REsxF2WspvoFl8CDQj6XK
    KvmZ1hR5kDQ2nNFjw8EobutAfuaF90sKTDIzsNvvC8Oqhz4oG4O+SzUFPNNoLk/cTCTR
    qWyzvJpyE7tXawcn471riAs4qmxPzbsUceBGS/p0QEHZX2C/zBreJWY5Kow1TOYc0Vo2
    7XYmxePTBSxxzoiIoEQkZ7ZlC31W3ITLKOPBgOvh5pq3KKBdq3WU3u5oYNjkEdt9f5ZZ
    c11YPjgf2mUTgXUvZDb8d7RFd7cYtEhW1jucC60F2lCy/CZL7RS178G48TeddEvRArPQ
    hwiw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id u1045ey6QHsD3XY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Jul 2022 19:54:13 +0200 (CEST)
Date:   Tue, 26 Jul 2022 19:54:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ARM: qcom_defconfig: enable more Qualcomm drivers
Message-ID: <YuAqOArv4hUdaG6D@gerhold.net>
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
 <20220726150609.140472-2-krzysztof.kozlowski@linaro.org>
 <CAA8EJppMNUV0eEF7BV6=7RgQK_XUEsqcLpmf_zu0XjSRLTLQ6w@mail.gmail.com>
 <a9356472-0fef-d500-837c-ad6d9ed27b94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9356472-0fef-d500-837c-ad6d9ed27b94@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 07:30:12PM +0200, Krzysztof Kozlowski wrote:
> On 26/07/2022 18:49, Dmitry Baryshkov wrote:
> > On Tue, 26 Jul 2022 at 18:06, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Enable Qualcomm drivers:
> >> 1. socinfo driver to provide some basic information about the
> >>    SoC being used.
> >> 2. Remote filesystem memory driver (used in MSM8974).
> >> 3. RPM Power domain (used in MSM8226).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  arch/arm/configs/qcom_defconfig | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> >> index 5cd935ee148a..f02448187eac 100644
> >> --- a/arch/arm/configs/qcom_defconfig
> >> +++ b/arch/arm/configs/qcom_defconfig
> >> @@ -247,12 +247,15 @@ CONFIG_QCOM_COMMAND_DB=y
> >>  CONFIG_QCOM_GSBI=y
> >>  CONFIG_QCOM_OCMEM=y
> >>  CONFIG_QCOM_PM=y
> >> +CONFIG_QCOM_RMTFS_MEM=y
> >> +CONFIG_QCOM_RPMPD=y
> >>  CONFIG_QCOM_SMEM=y
> >>  CONFIG_QCOM_SMD_RPM=y
> >>  CONFIG_QCOM_SMP2P=y
> >>  CONFIG_QCOM_SMSM=y
> >>  CONFIG_QCOM_RPMH=y
> >>  CONFIG_QCOM_RPMHPD=y
> >> +CONFIG_QCOM_SOCINFO=y
> > 
> > please add:
> > CONFIG_QCOM_STATS=y
> 
> I was considering it, but it seems none of ARMv7 DTS use it.
> 

Some MSM8916 boards are used on ARMv7 (due to firmware limitations)
and the msm8916.dtsi has it. :)

Thanks,
Stephan
