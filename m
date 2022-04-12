Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEA4FDE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbiDLLgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352856AbiDLLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:35:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528811AF1C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:14:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so13313606ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HSgeYSmWoTB8urz+2j0ITeuhf+Crm+J/7fwK9uhlHHk=;
        b=fT7SCw7VNFb+6UVFgqTXEoZ9drpI5oMjPjHY1QKKIpMzHIIPMh3gGlfPka948WAtIz
         QVmrfzrgvXaSM4v+IQeadpIgelQs53FBQyinrWvzZbYSDec5dBnbR2tdZM2WicrbMg4A
         xQC3Y5pFTY4aV0Z0ugdAR2FO5cEdlrjjl5J2b1+GBzrDNnQR34y0UlvdHpqgWLVFXZG9
         TPYBkIRMYYpFM1PIxdTo2PKPxk0GoTk9wLNF0dcgriMkTBE4O9jnWrH8PNmnMaIhp/Xa
         QITuTf8C6OlC0nHRjrH+C5Mck8luHjFBzeUx/z9c3aR+TkinBhXa4SPbQ29/UxJy0cJ1
         UMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HSgeYSmWoTB8urz+2j0ITeuhf+Crm+J/7fwK9uhlHHk=;
        b=SpTBSy7yrFpXjKoHlz8Dq/0yGO6wERMf1ADLuyIJTFIEvlI+ZkNYSyE25K1NXM53M0
         giVKmT/YH4RM1dSAhX+Zegr1kdej930gKi2WsUVIhCrJgfye66E3XcTa9NSE5YPFUNqD
         g9F37wToOH/wwS9QU+2cTDWWqJIGAIaxgBztuiYWYercoIsmccVAZhBFM0oeIiHjsSJV
         s8rrI1B8/oHhnEt3uhOD45BvNKvx00TWTz0w4ieOjSzzXPMGWw+m8MmKnFcs2d3O4Jck
         SCR0bj7SUP7wl6qld0eeQALkSp+Ge+VtkugbGsLSeEvpje+ousZM0D/m1RYZnqhqJfFJ
         uoDw==
X-Gm-Message-State: AOAM531dIyhtzb89a4j9NJU4iY3OJVAEOvSnwvrvbi81Mxx3C5uFQmiU
        39qoG/3OUGtvfCDv2YxfqRvlLi9JuEjNOrVR
X-Google-Smtp-Source: ABdhPJwdC8sNY9RG8gwiHPtrcpJsAblAVRRXhlJAqVGT6wLUqkjf0DItHobueGFwQAM/ERtI2c8ehw==
X-Received: by 2002:a17:907:961d:b0:6e7:eefa:ddd0 with SMTP id gb29-20020a170907961d00b006e7eefaddd0mr33612459ejc.321.1649758468879;
        Tue, 12 Apr 2022 03:14:28 -0700 (PDT)
Received: from [192.168.1.18] (hst-221-53.medicom.bg. [84.238.221.53])
        by smtp.googlemail.com with ESMTPSA id q7-20020a170906540700b006d5eca5c9cfsm13009524ejo.191.2022.04.12.03.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 03:14:28 -0700 (PDT)
Message-ID: <329f5120-42c5-e5df-a138-c8b634b6a550@linaro.org>
Date:   Tue, 12 Apr 2022 13:14:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] media: venus: do not queue internal buffers from
 previous sequence
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1649747356-3207-1-git-send-email-quic_vgarodia@quicinc.com>
 <1649747356-3207-2-git-send-email-quic_vgarodia@quicinc.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <1649747356-3207-2-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

Thanks for the patch!

On 4/12/22 10:09, Vikash Garodia wrote:
> During reconfig (DRC) event from firmware, it is not guaranteed that
> all the DPB(internal) buffers would be released by the firmware. Some
> buffers might be released gradually while processing frames from the
> new sequence. These buffers now stay idle in the dpblist.
> In subsequent call to queue the DPBs to firmware, these idle buffers
> should not be queued. The fix identifies those buffers and free them.
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 37 ++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 0bca95d..0602f03 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -90,12 +90,31 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_check_codec);
>  
> +static int venus_helper_free_dpb_buf(struct venus_inst *inst, struct intbuf *buf)

This function should return void. Also, venus_helper_ prefix is not
needed since if you follow the helpers.c style the prefix is only used
for exported helper functions.

I guess it could be:

static void free_dpb_buf(struct venus_inst *inst, struct intbuf *buf)

With this fixed:

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> +{
> +	ida_free(&inst->dpb_ids, buf->dpb_out_tag);
> +
> +	list_del_init(&buf->list);
> +	dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> +		       buf->attrs);
> +	kfree(buf);
> +
> +	return 0;
> +}
> +
>  int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
>  {
> -	struct intbuf *buf;
> +	struct intbuf *buf, *next;
> +	unsigned int dpb_size = 0;
>  	int ret = 0;
>  
> -	list_for_each_entry(buf, &inst->dpbbufs, list) {
> +	if (inst->dpb_buftype == HFI_BUFFER_OUTPUT)
> +		dpb_size = inst->output_buf_size;
> +	else if (inst->dpb_buftype == HFI_BUFFER_OUTPUT2)
> +		dpb_size = inst->output2_buf_size;
> +
> +
> +	list_for_each_entry_safe(buf, next, &inst->dpbbufs, list) {
>  		struct hfi_frame_data fdata;
>  
>  		memset(&fdata, 0, sizeof(fdata));
> @@ -106,6 +125,12 @@ int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
>  		if (buf->owned_by == FIRMWARE)
>  			continue;
>  
> +		/* free buffer from previous sequence which was released later */
> +		if (dpb_size > buf->size) {
> +			venus_helper_free_dpb_buf(inst, buf);
> +			continue;
> +		}
> +
>  		fdata.clnt_data = buf->dpb_out_tag;
>  
>  		ret = hfi_session_process_buf(inst, &fdata);
> @@ -127,13 +152,7 @@ int venus_helper_free_dpb_bufs(struct venus_inst *inst)
>  	list_for_each_entry_safe(buf, n, &inst->dpbbufs, list) {
>  		if (buf->owned_by == FIRMWARE)
>  			continue;
> -
> -		ida_free(&inst->dpb_ids, buf->dpb_out_tag);
> -
> -		list_del_init(&buf->list);
> -		dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
> -			       buf->attrs);
> -		kfree(buf);
> +		venus_helper_free_dpb_buf(inst, buf);
>  	}
>  
>  	if (list_empty(&inst->dpbbufs))

-- 
regards,
Stan
