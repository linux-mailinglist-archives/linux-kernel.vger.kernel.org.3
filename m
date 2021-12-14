Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1247416C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhLNLYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:24:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52028 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhLNLYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:24:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FD1FB81899;
        Tue, 14 Dec 2021 11:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BA0C34601;
        Tue, 14 Dec 2021 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639481081;
        bh=5e9V1KFv9vwJ/bLxG0N2DMFYQkTf8Cdc6F0VtrAo7yI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qS965GiqUc4P0Xpb6CY46Il1L+A2vTt1xZprkHD38mUtgoxRKGezouekl37EL/gco
         Jv+HoqDGtWBF0ROP2Hzskan7ykcPbkiAYHPhKU/NCCJCCm+AnvwaFFhsXSzLfdSwmy
         avUvO9CarQzXq8ve3PN4OB9bbVR6phaCnomooW1buYznpCk3zSsXRtQ8TEAnX0Q121
         Zgfkr106BZx1MSDJZAJ5t+KtZEBPNmn4pvQ8SWfzzl+x4FcLCehR4TP4V0h4VUeFuQ
         dd/pTwJh5USiEiRk4qeL5XVEY7bHi0ltWsNrYoL2icrksigKsC88zt68hMu59A+quS
         Yomr5uwAqj43Q==
Message-ID: <0549abbb-9e75-70e9-399b-1b3f84dc5c20@kernel.org>
Date:   Tue, 14 Dec 2021 13:24:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 RESEND 0/5] Add QCM2290 interconnect support
Content-Language: en-US
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211214093011.19775-1-shawn.guo@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211214093011.19775-1-shawn.guo@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 14.12.21 11:30, Shawn Guo wrote:
> Changes for v3 resend:
> - Rebase on linux-next

Did you try compiling it? There is one more driver where we need to
add the QoS type, otherwise I see this error:

drivers/interconnect/qcom/msm8996.c:1884:3: error: ‘const struct 
qcom_icc_desc’ has no member named ‘is_bimc_node’
  1884 |  .is_bimc_node = true,

Thanks,
Georgi

> - Drop NOC_QOS_MODE_INVALID patch which has been applied by Georgi
> - Pick up Rob's Reviewed-by on the binding patch
> 
> Changes for v3:
> - Update bindings to define child interconnect provider nodes
> 
> Changes for v2:
> - Drop unneeded include of <dt-bindings/clock/qcom,gcc-qcm2290.h> from
>    bindings.
> 
> Shawn Guo (5):
>    interconnect: icc-rpm: Define ICC device type
>    interconnect: icc-rpm: Add QNOC type QoS support
>    interconnect: icc-rpm: Support child NoC device probe
>    dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
>    interconnect: qcom: Add QCM2290 driver support
> 
>   .../bindings/interconnect/qcom,qcm2290.yaml   |  137 ++
>   drivers/interconnect/qcom/Kconfig             |    9 +
>   drivers/interconnect/qcom/Makefile            |    2 +
>   drivers/interconnect/qcom/icc-rpm.c           |   52 +-
>   drivers/interconnect/qcom/icc-rpm.h           |   14 +-
>   drivers/interconnect/qcom/msm8916.c           |    4 +-
>   drivers/interconnect/qcom/msm8939.c           |    5 +-
>   drivers/interconnect/qcom/qcm2290.c           | 1363 +++++++++++++++++
>   drivers/interconnect/qcom/sdm660.c            |    7 +-
>   .../dt-bindings/interconnect/qcom,qcm2290.h   |   94 ++
>   10 files changed, 1676 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
>   create mode 100644 drivers/interconnect/qcom/qcm2290.c
>   create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
> 

