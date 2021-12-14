Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9100473951
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhLNAHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:07:38 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:18966 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhLNAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:07:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1639440457; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HrkidRgCOdsW30/DkJv35RJ0R+GZ61VAFBn0ww2cif0=; b=xWyVsfy5w/U5yQTd5Sf3M4Q+qP17fLsj0/RN6doi4jKWdSMwLod+deihvmn68xD8wk54N0/d
 gyoLlGqMxQCTyUyRXNPzPy1JI4EW/YHxWgHSYav/Rj1n8n6AxKS43AlGIQioKvrU7biycLQN
 paTAyRQAwo/mJZeY/RiIJPtsMos=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61b7e0481ff187c99994806c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Dec 2021 00:07:36
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6968C43616; Tue, 14 Dec 2021 00:07:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.110.114.105] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B793CC4338F;
        Tue, 14 Dec 2021 00:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B793CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [RFC] bus: mhi: core: Load firmware asynchronous
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Richard Hughes <hughsient@gmail.com>
References: <20211210161645.10925-1-linux@weissschuh.net>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <403e93df-5b3c-acb3-2b65-df9a7834a9c5@codeaurora.org>
Date:   Mon, 13 Dec 2021 16:07:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210161645.10925-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/2021 8:16 AM, Thomas Weißschuh wrote:
> This gives userspace the possibility to provide the firehose bootloader
> via the sysfs-firmware-API instead of having to modify the global
> firmware loadpath.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> 
> Please note that this is not tested yet, as I don't have access to a matching
> firmware file.
> This submission is to gather general feedback from the maintainers and then
> Richard will do the actual testing, while I'll do the development.
> 
> This patch is should not have any impact beyond moving from request_firmware()
> to request_firmware_nowait() and the involved code reshuffle.
what are we achieving by moving to async ver of the firmware load ? MHI 
boot flow can not do anything until BHI load is over. Is the intention 
eventually to enable firmware fallback mechanism  and manually load the 
firmware ?

[..]

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
