Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18A4485D15
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbiAFAXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343696AbiAFAXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:23:12 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE14C0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:23:01 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d3so805788ilr.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=qM66frqSTNt4dFZB0j1ZH1Mn4CyZd86KqXUvtn5X9jw=;
        b=ZHoFR5/pJxHKNkB/NTxw6M8o1NnM97P8YYxvMXpya6+eu+CN+pA4r70o1kmQM64H2d
         wKX0aCIW5jjx1d89szGGN0ulOXK1nY1CKxl1OooV291oQ5exIFQpvDu37auzZu5CypFS
         EtrBkbupZCxxUFQN9fB8iTW5vxq9f8TwqP6Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=qM66frqSTNt4dFZB0j1ZH1Mn4CyZd86KqXUvtn5X9jw=;
        b=j+nqvGWoGeAMQ++qIF6dllgHfJ0N9Byl8PiLfTCIGYeIxXTcw8Vo7C0FVChzV1bcwA
         eE/m9/aaL4+EhGoLbFVmy2eUMAemtcR8rx5h/+hddzvenPRaeLVEkimHwlKO0NeubWCv
         Udw7hKerWkDZ2u+kFLCn0dMVaiQ2OhGd+K0iQCIcj9iUR/mVVYfzZjWEN8phtLNlqXbT
         ng1Sd7af58/8bjgDKCCJXBQ6r9v50IenFjWJsrjh+0qrMkwKalI8DDJqLEdgTTvAGxl8
         6XXco0XkkGjxaDF9km1y93HKV1Bzl0exLKf7eKuYcnfMY6/5lsdxmq0PKREdhQbCz8Dk
         PpQQ==
X-Gm-Message-State: AOAM5302sGNXuIxTI0+7fMvRjRSyEVGMebX7sNAZLqN9ehOMVrT9V4Rq
        gmAVC3BUAQfphO191kXqIme/eQ==
X-Google-Smtp-Source: ABdhPJzGYqIg1uV2fFiAFp1N6QpUHaJbLKmzuL39SUFpDMurp27BDLYmnVyFZR90KFStJhOOttNnyg==
X-Received: by 2002:a05:6e02:1c2e:: with SMTP id m14mr27941503ilh.121.1641428581210;
        Wed, 05 Jan 2022 16:23:01 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y1sm242320ilv.10.2022.01.05.16.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 16:23:00 -0800 (PST)
Message-ID: <0d850b27-5684-2ecf-fc96-3258c0462d3d@ieee.org>
Date:   Wed, 5 Jan 2022 18:22:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 03/20] bus: mhi: Make mhi_state_str[] array static const
 and move to common.h
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-4-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
In-Reply-To: <20211202113553.238011-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> mhi_state_str[] array could be used by MHI endpoint stack also. So let's
> make the array as "static const" and move it inside the "common.h" header
> so that the endpoint stack could also make use of it. Otherwise, the
> structure definition should be present in both host and endpoint stack and
> that'll result in duplication.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This result in common source code (which is good), but it will be
duplicated in everything that includes this file.

Do you have no common code, available to both the endpoint and host?
You could (in drivers/bus/mhi/common.c, for example).

If you don't, I have a different suggestion, below.  It does
basically the same thing you're doing here, but I much prefer
duplicating an inline function than a data structure.

> ---
>   drivers/bus/mhi/common.h    | 13 ++++++++++++-
>   drivers/bus/mhi/host/init.c | 12 ------------
>   2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index 0f4f3b9f3027..2ea438205617 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -174,7 +174,18 @@ struct mhi_cmd_ctxt {
>   	__u64 wp __packed __aligned(4);
>   };
>   
> -extern const char * const mhi_state_str[MHI_STATE_MAX];
> +static const char * const mhi_state_str[MHI_STATE_MAX] = {
> +	[MHI_STATE_RESET] = "RESET",
> +	[MHI_STATE_READY] = "READY",
> +	[MHI_STATE_M0] = "M0",
> +	[MHI_STATE_M1] = "M1",
> +	[MHI_STATE_M2] = "M2",
> +	[MHI_STATE_M3] = "M3",
> +	[MHI_STATE_M3_FAST] = "M3 FAST",
> +	[MHI_STATE_BHI] = "BHI",
> +	[MHI_STATE_SYS_ERR] = "SYS ERROR",
> +};
> +
>   #define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
>   				  !mhi_state_str[state]) ? \
>   				"INVALID_STATE" : mhi_state_str[state])

You could easily and safely define this as an inline function instead.

#define MHI_STATE_CASE(x)	case MHI_STATE_ ## x: return #x
static inline const char *mhi_state_string(enum mhi_state state)
{
	switch(state) {
	MHI_STATE_CASE(RESET);
	MHI_STATE_CASE(READY);
	MHI_STATE_CASE(M0);
	MHI_STATE_CASE(M1);
	MHI_STATE_CASE(M2);
	MHI_STATE_CASE(M3_FAST);
	MHI_STATE_CASE(BHI);
	MHI_STATE_CASE(SYS_ERR);
	default: return "(unrecognized MHI state)";
	}
}
#undef MHI_STATE_CASE

					-Alex

> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 5aaca6d0f52b..fa904e7468d8 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -44,18 +44,6 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
>   	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
>   };
>   
> -const char * const mhi_state_str[MHI_STATE_MAX] = {
> -	[MHI_STATE_RESET] = "RESET",
> -	[MHI_STATE_READY] = "READY",
> -	[MHI_STATE_M0] = "M0",
> -	[MHI_STATE_M1] = "M1",
> -	[MHI_STATE_M2] = "M2",
> -	[MHI_STATE_M3] = "M3",
> -	[MHI_STATE_M3_FAST] = "M3 FAST",
> -	[MHI_STATE_BHI] = "BHI",
> -	[MHI_STATE_SYS_ERR] = "SYS ERROR",
> -};
> -
>   const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
>   	[MHI_CH_STATE_TYPE_RESET] = "RESET",
>   	[MHI_CH_STATE_TYPE_STOP] = "STOP",
> 

