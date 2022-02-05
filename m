Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E660A4AA8A7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379800AbiBEMQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379941AbiBEMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:16:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86536C0401C2;
        Sat,  5 Feb 2022 04:15:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y5so6525357pfe.4;
        Sat, 05 Feb 2022 04:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YjIO40PnwMmdwtobVmnhEpOTVt8ruZsjPqGNFGyrUvU=;
        b=qQ09SGZqaLCCUs6A683BBcWubgQjLWAIWL4npUJ38bYmrzQ+uT63r5YXMmShJBYGCJ
         QJW2IbNEBjzZfwhoD4sK7vNQBqDG7FdaCqz3XHP0zxLBvayjpZw9Vgcz3CbagP38pIun
         MuBTFLohCNsHtJk1YSpm2rM8MSxnQIqDwB2xAx8EY+ZCeuY+e5TYVVvPGhP4cNQUcyoS
         vWT2dxMFTytMVFOHOV1WjUxX1xwSPkjdjAjkq0G9bAsMpKJKDOa674hUJlqiDxr3ACCq
         EHSVFa/wGCixKRER1U6+sBiA2nvEWEopveZw12EKH3wfBSHhkGskuoEBIN+eWjennILq
         za6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YjIO40PnwMmdwtobVmnhEpOTVt8ruZsjPqGNFGyrUvU=;
        b=APpznsHB3W/upAK7ynmbEHu5M+ggOinIlUKueQ10LVHjRs6Wc1XITIacTzSCWkT7JQ
         toG9Pw1HkMQBb9tlvGl1jeyw5LaIDDNQj3ScXGkeKPR5kSWsGQ4k+jBpJZbBBLC0fOs0
         /1rSJiv4eng42yv8p55Yqn9hc53/yIBV8SoQkiVM2AtoafJ9jFz1Ocm8j20JkegSoE8X
         T3t8zVI07zZzeQZ90jZc/g3wE3lE8mhI0DDS+KxWv1KTHmaUYwN0uqxSq3qiEpQ66H5D
         zTjTbJxTgrwCFV/zQPAIb56pvbbUG/nBtZ3GGs4qCmEp1slX+alajClmH4hJwGB+5F4P
         CZTQ==
X-Gm-Message-State: AOAM531z1NEtNcspZznpGeGSh02jCkdqiOA6BxJPpMRh+D3X1yB1z3Pw
        eympHOZnDEFQwWyiG31qVak=
X-Google-Smtp-Source: ABdhPJxFueF7CYhxt0F4Z55Pjh/MmjMeY7DXLzHMQ/WMZo2WSQcfZDUj0lsCz/HA33kM6rMHkOxXKQ==
X-Received: by 2002:a63:7e1b:: with SMTP id z27mr2717091pgc.345.1644063352024;
        Sat, 05 Feb 2022 04:15:52 -0800 (PST)
Received: from [192.168.1.33] (154.red-83-50-83.dynamicip.rima-tde.net. [83.50.83.154])
        by smtp.gmail.com with ESMTPSA id d15sm5994262pfu.72.2022.02.05.04.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 04:15:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= 
        <philippe.mathieu.daude@gmail.com>
Message-ID: <5567d063-39b3-adfb-6556-d9973fa2074b@amsat.org>
Date:   Sat, 5 Feb 2022 13:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/4] clk: actions: Terminate clk_div_table with
 sentinel element
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
 <20220205005232.772726-2-j.neuschaefer@gmx.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
In-Reply-To: <20220205005232.772726-2-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 01:52, Jonathan Neuschäfer wrote:
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div = 0).
> 
> In owl-s900.s, the { 0, 8 } element was probably meant to be just that,
> so this patch changes { 0, 8 } to { 0, 0 }.
> 
> Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
> Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> 
> v3:
> - Interpret { 0, 8 } as a typo of { 0, 0 }, the sentinel element
> - Add R-b tag
> 
> v2:
> - Add Fixes tags
> ---
>   drivers/clk/actions/owl-s700.c | 1 +
>   drivers/clk/actions/owl-s900.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
> index a2f34d13fb543..617174644f728 100644
> --- a/drivers/clk/actions/owl-s700.c
> +++ b/drivers/clk/actions/owl-s700.c
> @@ -162,6 +162,7 @@ static struct clk_div_table hdmia_div_table[] = {
> 
>   static struct clk_div_table rmii_div_table[] = {
>   	{0, 4},   {1, 10},
> +	{0, 0},

Again, clearer to use:

         { /* sentinel */ }

(without the trailing comma, to enforce this is the last entry).

>   };
> 
>   /* divider clocks */
> diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
> index 790890978424a..63c4097c07ac7 100644
> --- a/drivers/clk/actions/owl-s900.c
> +++ b/drivers/clk/actions/owl-s900.c
> @@ -140,7 +140,7 @@ static struct clk_div_table rmii_ref_div_table[] = {
> 
>   static struct clk_div_table usb3_mac_div_table[] = {
>   	{ 1, 2 }, { 2, 3 }, { 3, 4 },
> -	{ 0, 8 },
> +	{ 0, 0 },
>   };
> 
>   static struct clk_div_table i2s_div_table[] = {
> --
> 2.34.1
> 

