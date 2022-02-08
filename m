Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9724ADC92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380216AbiBHP0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380168AbiBHP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:26:02 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948EDC0612B9;
        Tue,  8 Feb 2022 07:25:59 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso17936516oop.0;
        Tue, 08 Feb 2022 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v+HG5AG509udiPdf4BbsPVUGkODFt7xt8GFthycqDiw=;
        b=n9OrIeg0JbTsKqYhfSoL7aOmHBxhHJOBZT3Nf+McGU4HY/ifvP7QLdcLGmQJwmjcMq
         etKBJK8lBatTtV6Ahy+4SC5KVAlljP26qriG5qcO4ZqGC9mZz78KBsD8nbjnCMNssWAi
         llLr4bsundwoZvMa2IWwUG28hF3jUWLPqfnn37VMcvq5Oosi+8ElyKHI7Y3Q892qAnDX
         eCRUYX7DH3RM9XBHWJCfw8xy7NIkIp12yLytR0jW6vy2Xi13KJrVKmPIVStlN9g1yfDy
         +zhRxEtvuIEsVSJ9po64vWsTts/bmUV8NDdF93SrlSGS9AfiV65Kaca5pUz9XPGsBTlS
         f9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v+HG5AG509udiPdf4BbsPVUGkODFt7xt8GFthycqDiw=;
        b=hyzYokMoGIMJfLe67pJh7qcQbWt6FLJr/Lz0utovcD2amVrDaSqIUaVRLccEBiMxej
         AxZe/bYMI6RHFnG9lrwVJOhdbzVlTMs7+O2KmKDrWkWNv0ZHu0HKZ/gn5rPs1rDgH3EF
         J7CgkGdsqQScb3/AAW3vxA2spVDj7+P6BPUuSTeIa2picoCQUdf3H46uK/mRQ70vosUz
         2b8avIxfLCnGZHkoU6v8yZir43oeGEQ8OmWDJtb/PkidCeZ0IvwqkCtsVkQ9QnGnjYHJ
         YiWRgdhvCun/m2zk2ALpxAQu19QEpBj9x7ArGQrmgdzu5X+Ug24hkZ1k2BuT6bOptTO9
         j5Wg==
X-Gm-Message-State: AOAM533E2GC3zFRRIcUWAVVDdSyLU4T+BauFd5dn+LmyI8bEyZDuCkGj
        Ko17EVyYiCzpvDc3YQXU3yISOTR80IzzMg==
X-Google-Smtp-Source: ABdhPJxp0s0F3y7NWA4W6wkqFG5FSCdF/0he8UTd6McrYoTifTToLYQCwsCH3TksFjauFdFLaC46YQ==
X-Received: by 2002:a05:6870:3655:: with SMTP id v21mr523749oak.302.1644333958441;
        Tue, 08 Feb 2022 07:25:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1sm4725791oab.16.2022.02.08.07.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:25:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <106b27d7-6845-ed3c-411e-9ef5aee7f224@roeck-us.net>
Date:   Tue, 8 Feb 2022 07:25:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] usb: typec: tcpm: add interface for passing
 supported_pd_rev from tcpc_dev
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
 <20220208112226.9108-1-potin.lai@quantatw.com>
 <20220208112226.9108-2-potin.lai@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220208112226.9108-2-potin.lai@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 03:22, Potin Lai wrote:
> Current TCPM allways assume using PD_MAX_REV for negotiation,
> but for some USB controller only support PD 2.0, adding an interface
> for passing supported_pd_rev from tcpc_dev.
> 

The PD revision supported by the usb controller is a constant.
I don't see why this would need a callback function. Other
capabilitied are passed to tcpm using the fwnode pointer.
I don't see why this capability would have to be handled
differently.

Guenter

> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++--
>   include/linux/usb/tcpm.h      |  4 ++++
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 59d4fa2443f2..22e7d226826e 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -571,6 +571,16 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
>   				    port->cc2 == TYPEC_CC_OPEN)));
>   }
>   
> +static u32 tcpm_pd_supported_rev(struct tcpm_port *port)
> +{
> +	u32 rev = PD_MAX_REV;
> +
> +	if (port->tcpc->supported_pd_rev)
> +		rev = port->tcpc->supported_pd_rev(port->tcpc);
> +
> +	return min(rev, PD_MAX_REV);
> +}
> +
>   /*
>    * Logging
>    */
> @@ -3932,7 +3942,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		typec_set_pwr_opmode(port->typec_port, opmode);
>   		port->pwr_opmode = TYPEC_PWR_MODE_USB;
>   		port->caps_count = 0;
> -		port->negotiated_rev = PD_MAX_REV;
> +		port->negotiated_rev = tcpm_pd_supported_rev(port);
>   		port->message_id = 0;
>   		port->rx_msgid = -1;
>   		port->explicit_contract = false;
> @@ -4167,7 +4177,7 @@ static void run_state_machine(struct tcpm_port *port)
>   					      port->cc2 : port->cc1);
>   		typec_set_pwr_opmode(port->typec_port, opmode);
>   		port->pwr_opmode = TYPEC_PWR_MODE_USB;
> -		port->negotiated_rev = PD_MAX_REV;
> +		port->negotiated_rev = tcpm_pd_supported_rev(port);
>   		port->message_id = 0;
>   		port->rx_msgid = -1;
>   		port->explicit_contract = false;
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index bffc8d3e14ad..36282b2a9d9c 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -114,6 +114,9 @@ enum tcpm_transmit_type {
>    *              Optional; The USB Communications Capable bit indicates if port
>    *              partner is capable of communication over the USB data lines
>    *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
> + * @supported_pd_rev:
> + *              Optional; TCPM call this function to get supported PD revesion
> + *              from lower level driver.
>    */
>   struct tcpc_dev {
>   	struct fwnode_handle *fwnode;
> @@ -148,6 +151,7 @@ struct tcpc_dev {
>   						 bool pps_active, u32 requested_vbus_voltage);
>   	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
>   	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
> +	u32 (*supported_pd_rev)(struct tcpc_dev *dev);
>   };
>   
>   struct tcpm_port;

