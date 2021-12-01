Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C339465343
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhLAQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:50:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57522 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbhLAQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:49:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DF75B8203B;
        Wed,  1 Dec 2021 16:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25152C53FCC;
        Wed,  1 Dec 2021 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638377196;
        bh=De0l1TCNnWmOFVACDlWbZQNb96CZZ1WfCc0UphiqXPs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AcTs3bAE3d5ngdNUq/a37qM4Th2Hu9p/OCKJPxJI3xuKljnAPOu5A1u6RsCfl0fcG
         3ZoLAMm2tbTEoF+a9QGHMHMFY8B0TcVVjcyEyxpJFj4OjS3TK6BB9wZqAtRymfpu0+
         WBstzg05f+TdvOdp3taAinF5owBkzWov8UrZ1bXWeH9xIMrtjzsXZ+Ql+T5ty5k1wd
         Z1lN2PsHcqBeVzNoD16T4QvWTVf6dBZwS+WKty79/YDNbBDpL9og/zCQVvKrQ7mS0M
         XivXU0y2pX2X7fh3qyWOZMaBvGQ3nKPSpsyvZeGqyKV3p7pnY21xt4zauEnq7ZFKZ9
         G+Rjx6Swi4rpA==
Message-ID: <b4c43541-ffcd-d43c-3405-86d770905dd2@kernel.org>
Date:   Wed, 1 Dec 2021 18:46:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM8450 interconnect provider
 driver
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072557.3968915-1-vkoul@kernel.org>
 <20211201072557.3968915-3-vkoul@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211201072557.3968915-3-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Thanks for working on this!

On 1.12.21 9:25, Vinod Koul wrote:
> Add driver for the Qualcomm interconnect buses found in SM8450 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> This is based on the downstream driver by
> Vivek Aknurwar <viveka@codeaurora.org>

Maybe CC him too.

> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/interconnect/qcom/Kconfig  |    9 +
>   drivers/interconnect/qcom/Makefile |    2 +
>   drivers/interconnect/qcom/sm8450.c | 1988 ++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/sm8450.h |  169 +++
>   4 files changed, 2168 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/sm8450.c
>   create mode 100644 drivers/interconnect/qcom/sm8450.h
> 
[..]
> +static struct platform_driver qnoc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-sm8450",
> +		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,

We should set this callback only after we enable the client drivers to
request bandwidth. Otherwise some path might get disabled because of no
users. I would suggest to add sync_state after we describe the paths in
DT.

Thanks,
Georgi

