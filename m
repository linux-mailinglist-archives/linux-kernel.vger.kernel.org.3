Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F41554728
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbiFVKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbiFVKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08E1133E1C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655892609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EL51tQoyGDSNzBCV0OynXtX3OWuc/Wz1W1rcwLOtDZc=;
        b=gla9ZUP/rtZLlbNqu5VwkFUULmynPRJAFuyVTgJubFkU/8wd/ZGHNEGqxjfAjvW+pUjibK
        hxw9A1EqsBhgfy0UBvI7thlv7E4EAAyMBNpIwokv6RIkfqM4rHhM1h38iUuRPvWBfbQ7XN
        aJlVYTVthomt9QXZvqkp+//DtyAnV4Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-2SRWqD-pMaCfsV5LCRTebw-1; Wed, 22 Jun 2022 06:10:07 -0400
X-MC-Unique: 2SRWqD-pMaCfsV5LCRTebw-1
Received: by mail-ej1-f70.google.com with SMTP id h16-20020a1709070b1000b00713a3941a27so6104964ejl.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EL51tQoyGDSNzBCV0OynXtX3OWuc/Wz1W1rcwLOtDZc=;
        b=UpwfsIROSVYdP1LnQEvT+CNu1xICHq8gZSGUl8ApMPCiYUKvCycp0X+2okgrGi904Y
         /V184cyiZJ6yDghZBkLA6SDqUKrk959HXKwe4i8eIs1RdlpuYVmAfJ61JJy9SL8sEU7H
         pUZhjKJKyJKuWvc9vs2h0a2H/7NPEBGSzGBN5sOnWgGMl4mveN5qS1VlicjHzs99tYmK
         v2CRVeaP0pTlFcD3ydXcQw11ve/CxMgNcEdIoSQdNsBQ9eUWYN+F7cgyzcRzNFTS0dPe
         j9yDT4B8Nbmu0vs82BqIYxSw1L8bSfjQPG3AHIfE5WzXViursSqPZu9gPLGTdyBYNsx1
         aupA==
X-Gm-Message-State: AJIora9ZCmJwZIEDoKzMaK/pauMQ5Xh3CX3+c3BrVCIbhONZiexw1kcK
        wcJ17XZq4CBCjqKWr1SEd0IVtWKp5N3F9dTLNStyG3yuxPEagIe0r48SxkU/b/DzwkH6bg3vz46
        6t9+rXJvERt2kPexg0FtOyBfU
X-Received: by 2002:a05:6402:1f15:b0:435:8a5a:e69c with SMTP id b21-20020a0564021f1500b004358a5ae69cmr3197646edb.90.1655892606641;
        Wed, 22 Jun 2022 03:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0UMOWEPfoROTebLjWH0BLKQh9+SF2AE8Dz8PFcu/m/NUV3mgNWZmeIhlCDpC7QXsqEgQRow==
X-Received: by 2002:a05:6402:1f15:b0:435:8a5a:e69c with SMTP id b21-20020a0564021f1500b004358a5ae69cmr3197622edb.90.1655892606404;
        Wed, 22 Jun 2022 03:10:06 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.135.195])
        by smtp.gmail.com with ESMTPSA id b16-20020a056402351000b0042de8155fa1sm15238719edd.0.2022.06.22.03.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:10:05 -0700 (PDT)
Message-ID: <3d69be4a-7856-11a3-fddf-0b8afa645827@redhat.com>
Date:   Wed, 22 Jun 2022 12:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/surface: aggregator: Reserve more event- and
 target-categories
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614194117.4118897-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220614194117.4118897-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/14/22 21:41, Maximilian Luz wrote:
> With the introduction of the Surface Laptop Studio, more event- and
> target categories have been added. Therefore, increase the number of
> reserved events and extend the enum of know target categories to
> accommodate this.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/surface/aggregator/trace.h   | 80 +++++++++++--------
>  include/linux/surface_aggregator/serial_hub.h | 75 +++++++++--------
>  2 files changed, 85 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
> index de64cf169060..cc9e73fbc18e 100644
> --- a/drivers/platform/surface/aggregator/trace.h
> +++ b/drivers/platform/surface/aggregator/trace.h
> @@ -76,7 +76,7 @@ TRACE_DEFINE_ENUM(SSAM_SSH_TC_HID);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_TCH);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_BKL);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_TAM);
> -TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC0);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_UFI);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_USC);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_PEN);
> @@ -85,6 +85,11 @@ TRACE_DEFINE_ENUM(SSAM_SSH_TC_AUD);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_SMC);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_KPD);
>  TRACE_DEFINE_ENUM(SSAM_SSH_TC_REG);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SPT);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SYS);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC1);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SHB);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_POS);
>  
>  #define SSAM_PTR_UID_LEN		9
>  #define SSAM_U8_FIELD_NOT_APPLICABLE	((u16)-1)
> @@ -229,40 +234,45 @@ static inline u32 ssam_trace_get_request_tc(const struct ssh_packet *p)
>  
>  #define ssam_show_ssh_tc(rqid)						\
>  	__print_symbolic(rqid,						\
> -		{ SSAM_SSH_TC_NOT_APPLICABLE,		"N/A" },	\
> -		{ SSAM_SSH_TC_SAM,			"SAM" },	\
> -		{ SSAM_SSH_TC_BAT,			"BAT" },	\
> -		{ SSAM_SSH_TC_TMP,			"TMP" },	\
> -		{ SSAM_SSH_TC_PMC,			"PMC" },	\
> -		{ SSAM_SSH_TC_FAN,			"FAN" },	\
> -		{ SSAM_SSH_TC_PoM,			"PoM" },	\
> -		{ SSAM_SSH_TC_DBG,			"DBG" },	\
> -		{ SSAM_SSH_TC_KBD,			"KBD" },	\
> -		{ SSAM_SSH_TC_FWU,			"FWU" },	\
> -		{ SSAM_SSH_TC_UNI,			"UNI" },	\
> -		{ SSAM_SSH_TC_LPC,			"LPC" },	\
> -		{ SSAM_SSH_TC_TCL,			"TCL" },	\
> -		{ SSAM_SSH_TC_SFL,			"SFL" },	\
> -		{ SSAM_SSH_TC_KIP,			"KIP" },	\
> -		{ SSAM_SSH_TC_EXT,			"EXT" },	\
> -		{ SSAM_SSH_TC_BLD,			"BLD" },	\
> -		{ SSAM_SSH_TC_BAS,			"BAS" },	\
> -		{ SSAM_SSH_TC_SEN,			"SEN" },	\
> -		{ SSAM_SSH_TC_SRQ,			"SRQ" },	\
> -		{ SSAM_SSH_TC_MCU,			"MCU" },	\
> -		{ SSAM_SSH_TC_HID,			"HID" },	\
> -		{ SSAM_SSH_TC_TCH,			"TCH" },	\
> -		{ SSAM_SSH_TC_BKL,			"BKL" },	\
> -		{ SSAM_SSH_TC_TAM,			"TAM" },	\
> -		{ SSAM_SSH_TC_ACC,			"ACC" },	\
> -		{ SSAM_SSH_TC_UFI,			"UFI" },	\
> -		{ SSAM_SSH_TC_USC,			"USC" },	\
> -		{ SSAM_SSH_TC_PEN,			"PEN" },	\
> -		{ SSAM_SSH_TC_VID,			"VID" },	\
> -		{ SSAM_SSH_TC_AUD,			"AUD" },	\
> -		{ SSAM_SSH_TC_SMC,			"SMC" },	\
> -		{ SSAM_SSH_TC_KPD,			"KPD" },	\
> -		{ SSAM_SSH_TC_REG,			"REG" }		\
> +		{ SSAM_SSH_TC_NOT_APPLICABLE,		"N/A"  },	\
> +		{ SSAM_SSH_TC_SAM,			"SAM"  },	\
> +		{ SSAM_SSH_TC_BAT,			"BAT"  },	\
> +		{ SSAM_SSH_TC_TMP,			"TMP"  },	\
> +		{ SSAM_SSH_TC_PMC,			"PMC"  },	\
> +		{ SSAM_SSH_TC_FAN,			"FAN"  },	\
> +		{ SSAM_SSH_TC_PoM,			"PoM"  },	\
> +		{ SSAM_SSH_TC_DBG,			"DBG"  },	\
> +		{ SSAM_SSH_TC_KBD,			"KBD"  },	\
> +		{ SSAM_SSH_TC_FWU,			"FWU"  },	\
> +		{ SSAM_SSH_TC_UNI,			"UNI"  },	\
> +		{ SSAM_SSH_TC_LPC,			"LPC"  },	\
> +		{ SSAM_SSH_TC_TCL,			"TCL"  },	\
> +		{ SSAM_SSH_TC_SFL,			"SFL"  },	\
> +		{ SSAM_SSH_TC_KIP,			"KIP"  },	\
> +		{ SSAM_SSH_TC_EXT,			"EXT"  },	\
> +		{ SSAM_SSH_TC_BLD,			"BLD"  },	\
> +		{ SSAM_SSH_TC_BAS,			"BAS"  },	\
> +		{ SSAM_SSH_TC_SEN,			"SEN"  },	\
> +		{ SSAM_SSH_TC_SRQ,			"SRQ"  },	\
> +		{ SSAM_SSH_TC_MCU,			"MCU"  },	\
> +		{ SSAM_SSH_TC_HID,			"HID"  },	\
> +		{ SSAM_SSH_TC_TCH,			"TCH"  },	\
> +		{ SSAM_SSH_TC_BKL,			"BKL"  },	\
> +		{ SSAM_SSH_TC_TAM,			"TAM"  },	\
> +		{ SSAM_SSH_TC_ACC0,			"ACC0" },	\
> +		{ SSAM_SSH_TC_UFI,			"UFI"  },	\
> +		{ SSAM_SSH_TC_USC,			"USC"  },	\
> +		{ SSAM_SSH_TC_PEN,			"PEN"  },	\
> +		{ SSAM_SSH_TC_VID,			"VID"  },	\
> +		{ SSAM_SSH_TC_AUD,			"AUD"  },	\
> +		{ SSAM_SSH_TC_SMC,			"SMC"  },	\
> +		{ SSAM_SSH_TC_KPD,			"KPD"  },	\
> +		{ SSAM_SSH_TC_REG,			"REG"  },	\
> +		{ SSAM_SSH_TC_SPT,			"SPT"  },	\
> +		{ SSAM_SSH_TC_SYS,			"SYS"  },	\
> +		{ SSAM_SSH_TC_ACC1,			"ACC1" },	\
> +		{ SSAM_SSH_TC_SHB,			"SMB"  },	\
> +		{ SSAM_SSH_TC_POS,			"POS"  }	\
>  	)
>  
>  DECLARE_EVENT_CLASS(ssam_frame_class,
> diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
> index 26b95ec12733..45501b6e54e8 100644
> --- a/include/linux/surface_aggregator/serial_hub.h
> +++ b/include/linux/surface_aggregator/serial_hub.h
> @@ -201,7 +201,7 @@ static inline u16 ssh_crc(const u8 *buf, size_t len)
>   * exception of zero, which is not an event ID. Thus, this is also the
>   * absolute maximum number of event handlers that can be registered.
>   */
> -#define SSH_NUM_EVENTS		34
> +#define SSH_NUM_EVENTS		38
>  
>  /*
>   * SSH_NUM_TARGETS - The number of communication targets used in the protocol.
> @@ -292,40 +292,45 @@ struct ssam_span {
>   * Windows driver.
>   */
>  enum ssam_ssh_tc {
> -				/* Category 0x00 is invalid for EC use. */
> -	SSAM_SSH_TC_SAM = 0x01,	/* Generic system functionality, real-time clock. */
> -	SSAM_SSH_TC_BAT = 0x02,	/* Battery/power subsystem. */
> -	SSAM_SSH_TC_TMP = 0x03,	/* Thermal subsystem. */
> -	SSAM_SSH_TC_PMC = 0x04,
> -	SSAM_SSH_TC_FAN = 0x05,
> -	SSAM_SSH_TC_PoM = 0x06,
> -	SSAM_SSH_TC_DBG = 0x07,
> -	SSAM_SSH_TC_KBD = 0x08,	/* Legacy keyboard (Laptop 1/2). */
> -	SSAM_SSH_TC_FWU = 0x09,
> -	SSAM_SSH_TC_UNI = 0x0a,
> -	SSAM_SSH_TC_LPC = 0x0b,
> -	SSAM_SSH_TC_TCL = 0x0c,
> -	SSAM_SSH_TC_SFL = 0x0d,
> -	SSAM_SSH_TC_KIP = 0x0e,	/* Manages detachable peripherals (Pro X/8 keyboard cover) */
> -	SSAM_SSH_TC_EXT = 0x0f,
> -	SSAM_SSH_TC_BLD = 0x10,
> -	SSAM_SSH_TC_BAS = 0x11,	/* Detachment system (Surface Book 2/3). */
> -	SSAM_SSH_TC_SEN = 0x12,
> -	SSAM_SSH_TC_SRQ = 0x13,
> -	SSAM_SSH_TC_MCU = 0x14,
> -	SSAM_SSH_TC_HID = 0x15,	/* Generic HID input subsystem. */
> -	SSAM_SSH_TC_TCH = 0x16,
> -	SSAM_SSH_TC_BKL = 0x17,
> -	SSAM_SSH_TC_TAM = 0x18,
> -	SSAM_SSH_TC_ACC = 0x19,
> -	SSAM_SSH_TC_UFI = 0x1a,
> -	SSAM_SSH_TC_USC = 0x1b,
> -	SSAM_SSH_TC_PEN = 0x1c,
> -	SSAM_SSH_TC_VID = 0x1d,
> -	SSAM_SSH_TC_AUD = 0x1e,
> -	SSAM_SSH_TC_SMC = 0x1f,
> -	SSAM_SSH_TC_KPD = 0x20,
> -	SSAM_SSH_TC_REG = 0x21,	/* Extended event registry. */
> +				  /* Category 0x00 is invalid for EC use. */
> +	SSAM_SSH_TC_SAM  = 0x01,  /* Generic system functionality, real-time clock. */
> +	SSAM_SSH_TC_BAT  = 0x02,  /* Battery/power subsystem. */
> +	SSAM_SSH_TC_TMP  = 0x03,  /* Thermal subsystem. */
> +	SSAM_SSH_TC_PMC  = 0x04,
> +	SSAM_SSH_TC_FAN  = 0x05,
> +	SSAM_SSH_TC_PoM  = 0x06,
> +	SSAM_SSH_TC_DBG  = 0x07,
> +	SSAM_SSH_TC_KBD  = 0x08,  /* Legacy keyboard (Laptop 1/2). */
> +	SSAM_SSH_TC_FWU  = 0x09,
> +	SSAM_SSH_TC_UNI  = 0x0a,
> +	SSAM_SSH_TC_LPC  = 0x0b,
> +	SSAM_SSH_TC_TCL  = 0x0c,
> +	SSAM_SSH_TC_SFL  = 0x0d,
> +	SSAM_SSH_TC_KIP  = 0x0e,  /* Manages detachable peripherals (Pro X/8 keyboard cover) */
> +	SSAM_SSH_TC_EXT  = 0x0f,
> +	SSAM_SSH_TC_BLD  = 0x10,
> +	SSAM_SSH_TC_BAS  = 0x11,  /* Detachment system (Surface Book 2/3). */
> +	SSAM_SSH_TC_SEN  = 0x12,
> +	SSAM_SSH_TC_SRQ  = 0x13,
> +	SSAM_SSH_TC_MCU  = 0x14,
> +	SSAM_SSH_TC_HID  = 0x15,  /* Generic HID input subsystem. */
> +	SSAM_SSH_TC_TCH  = 0x16,
> +	SSAM_SSH_TC_BKL  = 0x17,
> +	SSAM_SSH_TC_TAM  = 0x18,
> +	SSAM_SSH_TC_ACC0 = 0x19,
> +	SSAM_SSH_TC_UFI  = 0x1a,
> +	SSAM_SSH_TC_USC  = 0x1b,
> +	SSAM_SSH_TC_PEN  = 0x1c,
> +	SSAM_SSH_TC_VID  = 0x1d,
> +	SSAM_SSH_TC_AUD  = 0x1e,
> +	SSAM_SSH_TC_SMC  = 0x1f,
> +	SSAM_SSH_TC_KPD  = 0x20,
> +	SSAM_SSH_TC_REG  = 0x21,  /* Extended event registry. */
> +	SSAM_SSH_TC_SPT  = 0x22,
> +	SSAM_SSH_TC_SYS  = 0x23,
> +	SSAM_SSH_TC_ACC1 = 0x24,
> +	SSAM_SSH_TC_SHB  = 0x25,
> +	SSAM_SSH_TC_POS  = 0x26,  /* For obtaining Laptop Studio screen position. */
>  };
>  
>  

