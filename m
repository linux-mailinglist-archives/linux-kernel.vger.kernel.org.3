Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D764F1E94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379763AbiDDV6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379092AbiDDQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:34:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6737ABA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:32:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x31so9449635pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2bL0zVy+T84o1RMeqMcnjFfLYjA+GUYGgoiquYSSAHY=;
        b=QRTuRBVdMggNkZKDKiVvRCfbxLmN/4Scvw/NVPF7mRZ6Ng7eYBz4lEM8ZpODjayuz6
         fHIj9gn+tCSfkLNwzzluQHLAI2YPvxvzhKEE9MRM0emAM5N+T/84llSb51wruVmWrtvS
         XEfdi++KzE+e3iOjOVtFEcKg7tUbFt9GjJOMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2bL0zVy+T84o1RMeqMcnjFfLYjA+GUYGgoiquYSSAHY=;
        b=uzjF7QHFuVeUb1i5X20fLRFUw/FCNZQY4MdFFeIVwPYvus9A4xiHAbjaHPBTtdfy9k
         wmiNWyWMmtMZCX57wymyjFNfgHPdvwNJMWxlnuP53ZqU8UnriYNpYvUbBUsB86jikMfA
         CcogOtwXWyZMnawkR473tBkv34E2Y3ekIx+/YO04S54hOP7xiuaKDQteYLQTJ5kNP7+s
         anH/sZP18iKCk/X1SdjcYVvL/vjkk4Ze6gpfamYH5K8oQ+VfnP02xPqCu6sHKLF5SK/u
         7VGKrTIMdTf75NXmwMiI/wC86pyxuoDZFFUQNbtUXEH6r8tNyIQxmX9D6QM+6POlkAW/
         JvdQ==
X-Gm-Message-State: AOAM533xNlFIynawfRLxZ01+Z4sfBYsPgri9o8KQ1ndnKLBpjVOljQNb
        a+zgYGk95dvH0JtcgKjWxInkOQ==
X-Google-Smtp-Source: ABdhPJwKOuEHl+BnsbgNxrNKz+t2civ6hhXWxr7p+FhUpmTI1La4qStQ4P50t0JSRmOGG8TiOxxaqA==
X-Received: by 2002:a05:6a00:10c7:b0:4fd:9ee6:4130 with SMTP id d7-20020a056a0010c700b004fd9ee64130mr375022pfu.84.1649089942793;
        Mon, 04 Apr 2022 09:32:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1ebc:cb71:2a38:38db])
        by smtp.gmail.com with UTF8SMTPSA id s20-20020aa78d54000000b004fac74c83b3sm12466884pfe.186.2022.04.04.09.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 09:32:22 -0700 (PDT)
Date:   Mon, 4 Apr 2022 09:32:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org
Subject: Re: [PATCH] drivers/tty/serial/qcom-geni-serial: Do stop_rx in
 suspend path for console if console_suspend is disabled
Message-ID: <Yksdk+YTxXRDWBbj@google.com>
References: <1648491444-17137-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1648491444-17137-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:47:24PM +0530, Vijaya Krishna Nivarthi wrote:
> [Why]
> For the case of console_suspend disabled, if back to back suspend/resume
> test is executed, at the end of test, sometimes console would appear to
> be frozen not responding to input. This would happen because, for
> console_suspend disabled, suspend/resume routines only turn resources
> off/on but don't do a port close/open.
> As a result, during resume, some rx transactions come in before system is
> ready, malfunction of rx happens in turn resulting in console appearing
> to be stuck.
> 
> [How]

Please drop the [Why] / [How] 'tags'

> Do a stop_rx in suspend sequence to prevent this. start_rx is already
> present in resume sequence as part of call to set_termios which does a
> stop_rx/start_rx.
> Additionally other changes have been made at same place
> a) replace the hardcoded flags with macros
> b) perform voting before calling resume_port in resume sequence
> c) consequently, swap the order in suspend sequence

This patch is short, but IMO it still does too many things at once which
aren't all directly related. At the very least the change from hardcoded
flags to macros should be in a separate patch. If the ICC voting order
isn't direcly related with the console_suspend issue then I'd also suggest
to split it out into its own patch.

> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index aedc388..37d064f 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> +#include <dt-bindings/interconnect/qcom,icc.h>
>  
>  /* UART specific GENI registers */
>  #define SE_UART_LOOPBACK_CFG		0x22c
> @@ -1477,34 +1478,38 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
>  {
> +	int ret;
>  	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>  	struct uart_port *uport = &port->uport;
>  	struct qcom_geni_private_data *private_data = uport->private_data;
>  
> +	/* do a stop_rx here, start_rx is handled in uart_resume_port by call to setermios */
> +	if (!console_suspend_enabled && uart_console(uport))
> +		uport->ops->stop_rx(uport);
> +
>  	/*
>  	 * This is done so we can hit the lowest possible state in suspend
>  	 * even with no_console_suspend
>  	 */
> +	ret = uart_suspend_port(private_data->drv, uport);
>  	if (uart_console(uport)) {
> -		geni_icc_set_tag(&port->se, 0x3);
> +		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ACTIVE_ONLY);
>  		geni_icc_set_bw(&port->se);
>  	}
> -	return uart_suspend_port(private_data->drv, uport);
> +	return ret;
>  }
>  
>  static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
>  {
> -	int ret;
>  	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>  	struct uart_port *uport = &port->uport;
>  	struct qcom_geni_private_data *private_data = uport->private_data;
>  
> -	ret = uart_resume_port(private_data->drv, uport);
>  	if (uart_console(uport)) {
> -		geni_icc_set_tag(&port->se, 0x7);
> +		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
>  		geni_icc_set_bw(&port->se);
>  	}
> -	return ret;
> +	return uart_resume_port(private_data->drv, uport);
>  }
>  
>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> -- 
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.
> 
