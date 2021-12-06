Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF946903E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhLFFqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 00:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbhLFFqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 00:46:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E938EC0613F8;
        Sun,  5 Dec 2021 21:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0D14B80FAB;
        Mon,  6 Dec 2021 05:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD53C341C4;
        Mon,  6 Dec 2021 05:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638769353;
        bh=2cSn8vnSO/HuXvTLIPU/Ro8XxFi/vH5l5wv06esMV4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUB4hrUsFDt4NyWw++p+Y+tkJ2OVtTGp6K8wh2xcGSsLloK2bbUrTZzCuQXUHTocb
         kiTHOBSZkBoIGkUL0B0b9VyBD+q/R+pPeM6IiAzDuz1iYX4bFGymzI2McpZiEgkKa4
         sWmHjUbLCZ0Fou9BoIQxW6m71cI6hwhuMolqYfA0roBLY/PYbqliO3UTNECc+WxI9s
         yvm8WCA0grJmAHC10EyEXwRbUMT13I/LjOLo84I51yggFrVRSeMxFHkfa56g/yTaaE
         qJVrcZKCwth/P+oeAjlnMX3aYnc8rw3AXR/C7/Opasz8hi4AJvmTLZ0MKbJ5WZoBHJ
         GdbFOeNG5Xbug==
Date:   Mon, 6 Dec 2021 11:12:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] arm64: dts: qcom: sm8450: Add reserved memory nodes
Message-ID: <Ya2ixVvjbWf7FibZ@matsya>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-6-vkoul@kernel.org>
 <cb5e360e-de22-0c22-a401-87dd3914e773@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5e360e-de22-0c22-a401-87dd3914e773@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 16:11, Konrad Dybcio wrote:
> 
> On 01.12.2021 08:29, Vinod Koul wrote:
> > Add the reserved memory nodes for SM8450. This is based on the downstream
> > documentation.
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 221 +++++++++++++++++++++++++++
> >  1 file changed, 221 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > index f0b9e80238a2..79aead4cba66 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > @@ -310,6 +310,227 @@ CLUSTER_PD: cpu-cluster0 {
> >  		};
> >  	};
> >  
> > +	reserved_memory: reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		hyp_mem: memory@80000000 {
> > +			no-map;
> > +			reg = <0x0 0x80000000 0x0 0x600000>;
> > +		};
> 
> All nodes in this patch put no-map before reg, which is precisely not the way
> 
> it's done in all other qcom DTs...

True, will update it to be consistent across

> 
> [...]
> 
> 
> > +
> > +		/* uefi region can be reused by apps */
> 
> What apps? Facebook? TikTok? Capitalization makes a difference in this
> 
> specific case..

Am sure facebook might like you comment, but lets fix that up to not
give them such opinion :)

-- 
~Vinod
