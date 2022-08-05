Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43E58AA2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiHELdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHELdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:33:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDD1A808;
        Fri,  5 Aug 2022 04:33:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d20so2006311pfq.5;
        Fri, 05 Aug 2022 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Ys2cufA0W9YH0DvF/7j4rd5OdjNghGHdGyLEQ6zen2M=;
        b=Y1XJOO3oPDar4WkrbbEK58Ugq5udEKVmoTTmYS0hSiQS6zCc5d6tvrHXoeCTThT/+s
         /5mV0iKl6YsRDK9aCCQ9wq56SOYbbLBsIOMy0+NJ4TANstXCvlbtWj3RWibzADXlL7Yw
         XNEjfeQTKe90bK4bAD25ldm764tt2EbGifBjeDNDCJhQToDRmgtW2vaumdaCRFQ1flR0
         hByvoR6d7JshVF9RrpHVlr0fUuhROsrIBkpzU3DoBBS4GTQU9ToNlL/RNI0n1sMmngEa
         WoQQZN9bT2fJPzGEGkV5ql0OOkHbAnVY1mUkOVAyOWYC835GyW0xlDwdUcwnioZb6h2z
         RJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Ys2cufA0W9YH0DvF/7j4rd5OdjNghGHdGyLEQ6zen2M=;
        b=hRFarF0NXPBLegla9NkgcP8E+RdNRMLPEYGzpwnOJBOmXzTLxDC+jWukD6WsvBL5Yl
         +MX3MqnzGwmC1ugePginr3kFs4bmVguYPnwd8tQSQi6TUF1ZVqrlnpSDpLi6BIkMkOSy
         buPu6j/Nx7Bp51Wpzodcvjm7IXGuWsQpiz6VVPPicWvpYL6q4v5OHs09URAIW2fEASHg
         RbDiN9iap04rFWFQmGgdsN9EQLpEpp+BPK820QkzcKaMnxjkIkpqEfhWh/MtbuYDkbiB
         b59LmM0svwU7cdWhZKdUfxqVRFWsW2VtW+dNNLn8kachbzFEsgIGCwDdMD0sVF3iuykd
         b0ag==
X-Gm-Message-State: ACgBeo3bh7AT1Nz2J6umDS/o3k+sZyuz03fPTez4eiGB8d31tflb4WbF
        fvHIEdvq7PVUq0bg5Sqt0EI=
X-Google-Smtp-Source: AA6agR5NkAma8lVHzVZGAJi/ocnzJItYVC7/k/6atQk36OJq4T/5kZ0UnKJEGiJ8Fuh4uqd+KgVXsg==
X-Received: by 2002:a63:91c3:0:b0:41d:271:4930 with SMTP id l186-20020a6391c3000000b0041d02714930mr2538435pge.341.1659699183078;
        Fri, 05 Aug 2022 04:33:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b0052dde3e965fsm2735168pfb.108.2022.08.05.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:32:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Aug 2022 04:32:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: Re: [PATCH v4 6/7] usb: typec: tcpci: Move function
 "tcpci_to_typec_cc" to common
Message-ID: <20220805113237.GD1011279@roeck-us.net>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
 <20220805071714.150882-7-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071714.150882-7-gene.chen.richtek@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:17:12PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Move transition function "tcpci_to_typec_cc" to common header
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 22 ----------------------
>  include/linux/usb/tcpci.h      | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 8127847..50674ec 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -27,11 +27,6 @@
>  #define	VPPS_VALID_MIN_MV			100
>  #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
>  
> -#define tcpc_presenting_rd(reg, cc) \
> -	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
> -	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
> -	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
> -
>  struct tcpci {
>  	struct device *dev;
>  
> @@ -218,23 +213,6 @@ static int tcpci_start_toggling(struct tcpc_dev *tcpc,
>  			    TCPC_CMD_LOOK4CONNECTION);
>  }
>  
> -static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> -{
> -	switch (cc) {
> -	case 0x1:
> -		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
> -	case 0x2:
> -		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
> -	case 0x3:
> -		if (sink)
> -			return TYPEC_CC_RP_3_0;
> -		fallthrough;
> -	case 0x0:
> -	default:
> -		return TYPEC_CC_OPEN;
> -	}
> -}
> -
>  static int tcpci_get_cc(struct tcpc_dev *tcpc,
>  			enum typec_cc_status *cc1, enum typec_cc_status *cc2)
>  {
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 20c0bed..1765745 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -167,6 +167,11 @@
>  /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
>  #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
>  
> +#define tcpc_presenting_rd(reg, cc) \
> +	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
> +	 (((reg) & (TCPC_ROLE_CTRL_## cc ##_MASK << TCPC_ROLE_CTRL_## cc ##_SHIFT)) == \
> +	  (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_## cc ##_SHIFT)))
> +
>  struct tcpci;
>  
>  /*
> @@ -207,4 +212,21 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci);
>  
>  struct tcpm_port;
>  struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
> +
> +static inline enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> +{
> +	switch (cc) {
> +	case 0x1:
> +		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
> +	case 0x2:
> +		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
> +	case 0x3:
> +		if (sink)
> +			return TYPEC_CC_RP_3_0;
> +		fallthrough;
> +	case 0x0:
> +	default:
> +		return TYPEC_CC_OPEN;
> +	}
> +}
>  #endif /* __LINUX_USB_TCPCI_H */
> -- 
> 2.7.4
> 
