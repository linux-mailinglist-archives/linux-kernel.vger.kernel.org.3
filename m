Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA784F0505
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353361AbiDBQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiDBQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:44:20 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8733127589
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:42:28 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso4246130otd.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LxIBYGAnw0G2uTyNe8oc7bEWhXzBTFL31jJUCuZn7Ig=;
        b=Ud7pFw36L7xNhE5Zi5Gc2HHWzUiX54grQmv9viTGoFtw7vSweK2Z/4PZTt2+wi9Q/e
         CpLM/f6QKrhwXxxlP0vBnHb+LUUSnYxLDiLMvAhViF8IFUuJnJCwNyOyfTijV4Uw/dMm
         UigcLdy9E5wI2GKtAtoqgQUFdttuzH7JMfPtryDTYO576ueDsxz/wcaPd+iKwJwNdpOg
         z0j+KzUDVODl9sWRFFsDNgFlycdJ6gTC4Ki/sddE66viVryGpj2+PiCfoOPEBRRi5TuY
         J+RptEc5E9pNC8IjWcTqfkzptcULkwl6WlHhcGytwQasuAeoVd3S3tgUtPcBxYfjgebz
         ekZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LxIBYGAnw0G2uTyNe8oc7bEWhXzBTFL31jJUCuZn7Ig=;
        b=HjBPUViGPj3j7DD0ibN9ehJQ4WkNihrhfR2xZ7LeNdZaBvxrLjrDWbcy24ofQl3JzD
         MGulT8BEJlP0blO+/N7OjVEPTxts+JopZMFkYdpuVeLeTbLgKe1ahrRLTL8l3mQHTdCc
         o7kBKH28MHIwOr1nJ1OFd7vMz7iVMpMUeDMlcaCbz+5N21Dpbcf13Ct/ccJrL6ADcwEs
         f4HbBYGay7h0ReoqLF4s6PTP00PhhnLMenMu9WcfpagNiXxxlGayCKKnEi6RCE8zkf/y
         0NsQCKOxA7v0N5tmx1w8FnpCTUrP0ypU9QnuoOAp62H/jYJsQG/lfDdhSItppzsLK97I
         GFEw==
X-Gm-Message-State: AOAM532nVQDVGc5/CMWZBMvpFjelb0ERIP7Iz8DNdc5YbmjjurhXy1G3
        sWPsCqM7UeNTsECWAU6AgwY=
X-Google-Smtp-Source: ABdhPJxX1JfkTpQWEVQe5XDpoAfaEarTckKHCpsEqTCFXzoIHsXejI5ei7Oj+GSHSDH5/ObNYlzKOA==
X-Received: by 2002:a05:6830:1047:b0:5b2:3173:d781 with SMTP id b7-20020a056830104700b005b23173d781mr9031403otp.178.1648917748252;
        Sat, 02 Apr 2022 09:42:28 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id eq37-20020a056870a92500b000c6699dad62sm2529148oab.41.2022.04.02.09.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:42:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <583569c9-baf0-b478-d14a-4a2beb3708d3@lwfinger.net>
Date:   Sat, 2 Apr 2022 11:42:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/6] staging: r8188eu: remove spaces before tabs
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1648888461.git.remckee0@gmail.com>
 <2fd10f393e3bc7381a85d0bfc1ec04a80af4eabb.1648888462.git.remckee0@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <2fd10f393e3bc7381a85d0bfc1ec04a80af4eabb.1648888462.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/2/22 03:50, Rebecca Mckeever wrote:
> Conform to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: please, no space before tabs
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 832bf25b1a83..8ae25cb4246b 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -548,9 +548,9 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
>   
>   	phtpriv->ht_option = false;
>   	if (pregistrypriv->ht_enable) {
> -		/* 	Added by Albert 2010/06/23 */
> -		/* 	For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
> -		/* 	Especially for Realtek 8192u SoftAP. */
> +		/*	Added by Albert 2010/06/23 */
> +		/*	For the WEP mode, we will use the bg mode to do the connection to avoid some IOT issue. */
> +		/*	Especially for Realtek 8192u SoftAP. */
>   		if ((padapter->securitypriv.dot11PrivacyAlgrthm != _WEP40_) &&
>   		    (padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
>   		    (padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
> @@ -1010,7 +1010,7 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
>   	u8	res = _SUCCESS;
>   
>   	/* if (!pwrctrlpriv->bLeisurePs) */
> -	/* 	return res; */
> +	/*	return res; */
>   
>   	if (enqueue) {
>   		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
> @@ -1151,8 +1151,8 @@ u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
>   	}
>   
>   	pdrvextra_cmd_parm->ec_id = P2P_PROTO_WK_CID;
> -	pdrvextra_cmd_parm->type_size = intCmdType;	/* 	As the command tppe. */
> -	pdrvextra_cmd_parm->pbuf = NULL;		/* 	Must be NULL here */
> +	pdrvextra_cmd_parm->type_size = intCmdType;	/*	As the command tppe. */
> +	pdrvextra_cmd_parm->pbuf = NULL;		/*	Must be NULL here */
>   
>   	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvextra_cmd_parm, GEN_CMD_CODE(_Set_Drv_Extra));
>   
> @@ -1378,8 +1378,8 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
>   		p2p_ps_wk_hdl(padapter, pdrvextra_cmd->type_size);
>   		break;
>   	case P2P_PROTO_WK_CID:
> -		/* 	Commented by Albert 2011/07/01 */
> -		/* 	I used the type_size as the type command */
> +		/*	Commented by Albert 2011/07/01 */
> +		/*	I used the type_size as the type command */
>   		p2p_protocol_wk_hdl(padapter, pdrvextra_cmd->type_size);
>   		break;
>   	case CHECK_HIQ_WK_CID:

Congratulations on a very clear set of patches. Each performs a single change 
exactly as required by the rules.

For all 6,
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,
Larry
