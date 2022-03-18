Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A144DD489
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiCRF7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiCRF7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:59:46 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2232C2E710D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 22:58:28 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef49.dynamic.kabel-deutschland.de [95.90.239.73])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5C8F161E6478B;
        Fri, 18 Mar 2022 06:58:26 +0100 (CET)
Message-ID: <f1ff7e95-c177-09dd-9393-d0156ce81387@molgen.mpg.de>
Date:   Fri, 18 Mar 2022 06:58:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/display: Fixed the unused-but-set-variable
 warning
Content-Language: en-US
To:     Aashish Sharma <shraash@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Wayne Lin <wayne.lin@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
References: <20220317140115.541007-1-shraash@google.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220317140115.541007-1-shraash@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Aashish,


Am 17.03.22 um 15:01 schrieb Aashish Sharma:

Thank you for your patch. If you are going to send a v2, please use 
imperative mood. Maybe:

drm/amd/display: Fix unused-but-set-variable warning


> Fixed this kernel test robot warning:

Maybe:

Fix the kernel test robot warning below:

> drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
> warning: variable 'temp' set but not used [-Wunused-but-set-variable]
> 
> Replaced the assignment to the unused temp variable with READ_ONCE()
> macro to flush the writes.

Replace …

Excuse my ignorance regarding `READ_ONCE()`, but is that the reason you 
remove the volatile qualifier?

Some robots ask in their report to add a Found-by tag. If so, please add 
one.

> Signed-off-by: Aashish Sharma <shraash@google.com>
> ---
>   drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 873ecd04e01d..b7981a781701 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2913,13 +2913,12 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
>   	uint32_t wptr = rb->wrpt;
>   
>   	while (rptr != wptr) {
> -		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
> +		uint64_t *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
>   		//uint64_t volatile *p = (uint64_t volatile *)data;
> -		uint64_t temp;
>   		uint8_t i;
>   
>   		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
> -			temp = *data++;
> +			(void)READ_ONCE(*data++);

Did you verify, that the generated code is the same now, or what the 
differences are. If it’s different from before, you should document in 
the commit message, that it’s wanted, as otherwise, it’s an invasive 
change just to fix a warning.

>   		rptr += DMUB_RB_CMD_SIZE;
>   		if (rptr >= rb->capacity)


Kind regards,

Paul
