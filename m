Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAE14C5A7C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiB0K10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiB0K1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:27:24 -0500
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448681E3CA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:26:48 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id OGlJnnK7L0wirOGlJn9P0g; Sun, 27 Feb 2022 11:26:46 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 27 Feb 2022 11:26:46 +0100
X-ME-IP: 90.126.236.122
Message-ID: <ef21ffe9-0e9f-0526-7cde-a16b219c8aec@wanadoo.fr>
Date:   Sun, 27 Feb 2022 11:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] habanalabs: add an option to delay a device reset
Content-Language: fr
To:     Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
References: <20220227094430.1059796-1-ogabbay@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220227094430.1059796-1-ogabbay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 27/02/2022 à 10:44, Oded Gabbay a écrit :
> From: Tomer Tayar <ttayar@habana.ai>
> 
> Several H/W events can be sent adjacently, even due to a single error.
> If a hard-reset is triggered as part of handling one of these events,
> the following events won't be handled.
> The debug info from these missed events is important, sometimes even
> more important than the one that was handled.
> 
> To allow handling these close events, add an option to delay a device
> reset and use it when resetting due to H/W events.
> 
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>   drivers/misc/habanalabs/common/device.c     | 8 +++++++-
>   drivers/misc/habanalabs/common/habanalabs.h | 4 ++++
>   drivers/misc/habanalabs/gaudi/gaudi.c       | 2 +-
>   3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> index d52381d1fbd2..651326cd22fb 100644
> --- a/drivers/misc/habanalabs/common/device.c
> +++ b/drivers/misc/habanalabs/common/device.c
> @@ -13,6 +13,8 @@
>   #include <linux/pci.h>
>   #include <linux/hwmon.h>
>   
> +#define HL_RESET_DELAY_USEC		10000	/* 10ms */
> +
>   enum hl_device_status hl_device_status(struct hl_device *hdev)
>   {
>   	enum hl_device_status status;
> @@ -980,7 +982,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
>   {
>   	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
>   			reset_upon_device_release = false, schedule_hard_reset = false,
> -			skip_wq_flush = false;
> +			skip_wq_flush, delay_reset;
>   	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
>   	struct hl_ctx *ctx;
>   	int i, rc;
> @@ -994,6 +996,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
>   	from_hard_reset_thread = !!(flags & HL_DRV_RESET_FROM_RESET_THR);
>   	fw_reset = !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
>   	skip_wq_flush = !!(flags & HL_DRV_RESET_DEV_RELEASE);
> +	delay_reset = !!(flags && HL_DRV_RESET_DELAY);

s/&&/&/ ?

CJ

>   
>   	if (!hard_reset && !hdev->asic_prop.supports_soft_reset) {
>   		hard_instead_soft = true;
> @@ -1043,6 +1046,9 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
>   		hdev->reset_info.in_reset = 1;
>   		spin_unlock(&hdev->reset_info.lock);
>   
> +		if (delay_reset)
> +			usleep_range(HL_RESET_DELAY_USEC, HL_RESET_DELAY_USEC << 1);
> +
>   		handle_reset_trigger(hdev, flags);
>   
>   		/* This still allows the completion of some KDMA ops */
> diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
> index cef4717d0916..1edaf6ab67bd 100644
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -142,6 +142,9 @@ enum hl_mmu_page_table_location {
>    *
>    * - HL_DRV_RESET_FW_FATAL_ERR
>    *       Set if reset is due to a fatal error from FW
> + *
> + * - HL_DRV_RESET_DELAY
> + *       Set if a delay should be added before the reset
>    */
>   
>   #define HL_DRV_RESET_HARD		(1 << 0)
> @@ -151,6 +154,7 @@ enum hl_mmu_page_table_location {
>   #define HL_DRV_RESET_DEV_RELEASE	(1 << 4)
>   #define HL_DRV_RESET_BYPASS_REQ_TO_FW	(1 << 5)
>   #define HL_DRV_RESET_FW_FATAL_ERR	(1 << 6)
> +#define HL_DRV_RESET_DELAY		(1 << 7)
>   
>   #define HL_MAX_SOBS_PER_MONITOR	8
>   
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 0eed0efae040..21c2b678ff72 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -8199,7 +8199,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
>   					| HL_DRV_RESET_BYPASS_REQ_TO_FW
>   					| fw_fatal_err_flag);
>   	else if (hdev->hard_reset_on_fw_events)
> -		hl_device_reset(hdev, HL_DRV_RESET_HARD | fw_fatal_err_flag);
> +		hl_device_reset(hdev, HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY | fw_fatal_err_flag);
>   	else
>   		hl_fw_unmask_irq(hdev, event_type);
>   }

