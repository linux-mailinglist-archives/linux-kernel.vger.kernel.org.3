Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC547473772
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbhLMW2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbhLMW2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:28:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B3C061574;
        Mon, 13 Dec 2021 14:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06ACDB80499;
        Mon, 13 Dec 2021 22:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8D1C34600;
        Mon, 13 Dec 2021 22:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639434530;
        bh=6ZHHElkpTM3plJJ+I8iwEra/ETUWjpU6A2mPMoWT/H0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=glzDrBZ3Vk0WvTyoNLzRduZlDCT6i0QGDRX/AM1/F7UFKcRWeanc1auT1wEWmmomv
         OOeZvjIhbVNm5qM90rmdq8eggRkSRyq/GCC4ZVvUwJRmp9p6P8KmYv6hyouKGyIVdP
         YUaqaroaGCfFOVHoBkG3ZMsAfMx4KqlChkcIoaZXCywfnVSa5qsfKsHOC+Vw0RP7qw
         rxvo7Op+LZzHRnJ1UrYXwehxQWnmbxlf0ufaTO9T2A2ZPFr4GdQb6x1DoOLlrDZYGD
         fdXstLhtlnkcGzNdMKeaiGeA2K/M30VLj216x068TNEVXNer5O+/E90VIINGUkrcPh
         /5yRJ8tXKpwag==
Message-ID: <be465db1-ed27-6111-71fb-9ef86b6ed6c0@kernel.org>
Date:   Tue, 14 Dec 2021 00:28:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/6] Add QCM2290 interconnect support
Content-Language: en-US
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211206075808.18124-1-shawn.guo@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211206075808.18124-1-shawn.guo@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 6.12.21 9:58, Shawn Guo wrote:
> The series begins with a separate cleanup on icc-rpm, followed by a few
> prep changes for QCM2290 support, and then adds bindings and
> interconnect driver for QCM2290 platform.

Thanks for working on this! I have applied patch 1/6. Please rebase the
rest on linux-next.

BR,
Georgi

> Changes for v3:
> - Update bindings to define child interconnect provider nodes
> 
> Changes for v2:
> - Drop unneeded include of <dt-bindings/clock/qcom,gcc-qcm2290.h> from
>    bindings.
> 
> Shawn Guo (6):
>    interconnect: icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
>    interconnect: icc-rpm: Define ICC device type
>    interconnect: icc-rpm: Add QNOC type QoS support
>    interconnect: icc-rpm: Support child NoC device probe
>    dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
>    interconnect: qcom: Add QCM2290 driver support
> 
>   .../bindings/interconnect/qcom,qcm2290.yaml   |  137 ++
>   drivers/interconnect/qcom/Kconfig             |    9 +
>   drivers/interconnect/qcom/Makefile            |    2 +
>   drivers/interconnect/qcom/icc-rpm.c           |   56 +-
>   drivers/interconnect/qcom/icc-rpm.h           |   14 +-
>   drivers/interconnect/qcom/msm8916.c           |    4 +-
>   drivers/interconnect/qcom/msm8939.c           |    5 +-
>   drivers/interconnect/qcom/qcm2290.c           | 1363 +++++++++++++++++
>   drivers/interconnect/qcom/sdm660.c            |    7 +-
>   .../dt-bindings/interconnect/qcom,qcm2290.h   |   94 ++
>   10 files changed, 1678 insertions(+), 13 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
>   create mode 100644 drivers/interconnect/qcom/qcm2290.c
>   create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
> 

