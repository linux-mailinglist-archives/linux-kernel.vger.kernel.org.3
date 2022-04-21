Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB350A4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390473AbiDUQIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390456AbiDUQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:08:14 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F00DF4B;
        Thu, 21 Apr 2022 09:05:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d19so3890072qko.3;
        Thu, 21 Apr 2022 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gy5Mr4Xkw0nWQenTM/V7cPlnk9oixh5l2qY9cIcFB80=;
        b=pi/G8voGK0cPNA1b/Rr6VJ7C3dQV99G8Nik/zvxyVOgzREcgQC7MD9xz0EVxLY5j0c
         ivezdbe7qV/+yMxw/e6URTJyULm3pEB8i9twf1fR51s6Ek8wEJJIMn8oblyBRW+hx6hC
         4REzdhy+fKBOq4ZObHV03F2Yk3eZ/D87GD5eTSo7l97UsQfW9Rq+XJg5r8pUG/kupaG6
         jVzWYf6YEY2JDdI0CeThJRlf1eET2WVV5eJi95fUltKNWlcg7FDqM/YSJqaowvofMNN8
         aM3iijCdchGN5LpMTZd8RV3gcW9+EUp66DQAzLyHw4hEHqSbMD3i5TQ5PDNotz/kAQZL
         Nhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Gy5Mr4Xkw0nWQenTM/V7cPlnk9oixh5l2qY9cIcFB80=;
        b=frzcx4WqnoeB4eG4BRIrgaUFraI+r3jeAkaj32LaZINq2CZbjYwxjlDWWkcJ0eth3S
         W783NvyHQB4Fo8WzOjNEGK1UEWw1/ezvFHXtx99QCQXIS9CRiqj7w3WoswwH93HCqiKI
         Q6J1dTG2wHT7KmBqypOy7oZnaK7ItTz13/5kYsjoBPVPEouh5bslA63AlRpLBwFxlcAf
         ZTPNx04XesS7VhXYOtsObJkY0YfiKvmADACbxTOuwec9BNaA6Kgk1mN1a6rGfgSL7sV1
         PneMKFBF4RErdhsBDwxX7fHmz5OXI9E3lYTmUslsKzjeHygsY6VEuEWWFikpJM+AQQMy
         m4hw==
X-Gm-Message-State: AOAM530wg5LgLDnDPi0isMzzNYyMLKBbr1cpPutSmRBWf8u0YJnj18QL
        hWALMOcUo1MlBc/6Ej0WsYNP6TdIGYa5
X-Google-Smtp-Source: ABdhPJz/7u44W+IRgWJVfcUVdJskycBKqQDsrYenXyQ7fjJunRRBNoKajf9zCm0UYnE5z/br/6jnmA==
X-Received: by 2002:a37:9e47:0:b0:69e:a534:24b5 with SMTP id h68-20020a379e47000000b0069ea53424b5mr96977qke.510.1650557123483;
        Thu, 21 Apr 2022 09:05:23 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a06c200b0069ea498aec7sm3078129qky.16.2022.04.21.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:05:23 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:a578:422:b82d:51be])
        by serve.minyard.net (Postfix) with ESMTPSA id 6A697180004;
        Thu, 21 Apr 2022 16:05:22 +0000 (UTC)
Date:   Thu, 21 Apr 2022 11:05:21 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] ipmi: remove unnecessary type castings
Message-ID: <20220421160521.GB426325@minyard.net>
Reply-To: minyard@acm.org
References: <20220421150941.7659-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421150941.7659-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:09:41AM -0700, Yu Zhe wrote:
> remove unnecessary void* type castings.

Thanks, queued for next release.

-corey

> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 6 +++---
>  drivers/char/ipmi/ipmi_ssif.c       | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index c59265146e9c..6e6aee19c39d 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -2296,7 +2296,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
>  	recv_msg->user_msg_data = user_msg_data;
>  
>  	if (supplied_smi)
> -		smi_msg = (struct ipmi_smi_msg *) supplied_smi;
> +		smi_msg = supplied_smi;
>  	else {
>  		smi_msg = ipmi_alloc_smi_msg();
>  		if (smi_msg == NULL) {
> @@ -3989,7 +3989,7 @@ static int handle_ipmb_direct_rcv_rsp(struct ipmi_smi *intf,
>  	struct ipmi_recv_msg *recv_msg;
>  	struct ipmi_ipmb_direct_addr *daddr;
>  
> -	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
> +	recv_msg = msg->user_data;
>  	if (recv_msg == NULL) {
>  		dev_warn(intf->si_dev,
>  			 "IPMI message received with no owner. This could be because of a malformed message, or because of a hardware error.  Contact your hardware vendor for assistance.\n");
> @@ -4407,7 +4407,7 @@ static int handle_bmc_rsp(struct ipmi_smi *intf,
>  	struct ipmi_recv_msg *recv_msg;
>  	struct ipmi_system_interface_addr *smi_addr;
>  
> -	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
> +	recv_msg = msg->user_data;
>  	if (recv_msg == NULL) {
>  		dev_warn(intf->si_dev,
>  			 "IPMI message received with no owner. This could be because of a malformed message, or because of a hardware error.  Contact your hardware vendor for assistance.\n");
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index f199cc194844..e8ee195a33cf 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1053,7 +1053,7 @@ static void start_next_msg(struct ssif_info *ssif_info, unsigned long *flags)
>  static void sender(void                *send_info,
>  		   struct ipmi_smi_msg *msg)
>  {
> -	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
> +	struct ssif_info *ssif_info = send_info;
>  	unsigned long oflags, *flags;
>  
>  	BUG_ON(ssif_info->waiting_msg);
> @@ -1090,7 +1090,7 @@ static int get_smi_info(void *send_info, struct ipmi_smi_info *data)
>   */
>  static void request_events(void *send_info)
>  {
> -	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
> +	struct ssif_info *ssif_info = send_info;
>  	unsigned long oflags, *flags;
>  
>  	if (!ssif_info->has_event_buffer)
> @@ -1107,7 +1107,7 @@ static void request_events(void *send_info)
>   */
>  static void ssif_set_need_watch(void *send_info, unsigned int watch_mask)
>  {
> -	struct ssif_info *ssif_info = (struct ssif_info *) send_info;
> +	struct ssif_info *ssif_info = send_info;
>  	unsigned long oflags, *flags;
>  	long timeout = 0;
>  
> -- 
> 2.25.1
> 
