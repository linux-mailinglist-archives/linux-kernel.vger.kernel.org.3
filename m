Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC614F5CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiDFLpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDFLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CA644A4C0;
        Wed,  6 Apr 2022 01:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40EAE60AEA;
        Wed,  6 Apr 2022 08:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A203C385A3;
        Wed,  6 Apr 2022 08:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649233959;
        bh=nodaLOb2Mo4981eaXRtfGTuGpT7Ve2hplGDZmVY4lH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHC839FxFtktNSaxKSHjAb5Wq6B7+6E5lEZHyVZT9sqrz3DchyxkUjKJVMrR5nnPU
         ym8lhCH1clIjiO7zYIe3IfEGqdQn3bS8NpDmrXU3cYwGcDP7Wv5r64FVd+z3Zjm9ju
         muoNMnWCzNtFOL4RxqmTF7TuPeVtlIYEzqQFBiqE=
Date:   Wed, 6 Apr 2022 10:32:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, dianders@chromium.org
Subject: Re: [V2] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend
 path for console if console_suspend is disabled
Message-ID: <Yk1QH18D0qAerqQ9@kroah.com>
References: <1649233612-30844-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649233612-30844-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 01:56:52PM +0530, Vijaya Krishna Nivarthi wrote:
> For the case of console_suspend disabled, if back to back suspend/resume
> test is executed, at the end of test, sometimes console would appear to
> be frozen not responding to input. This would happen because, for
> console_suspend disabled, suspend/resume routines only turn resources
> off/on but don't do a port close/open.
> As a result, during resume, some rx transactions come in before system is
> ready, malfunction of rx happens in turn resulting in console appearing
> to be stuck.
> 
> Do a stop_rx in suspend sequence to prevent this. start_rx is already
> present in resume sequence as part of call to set_termios which does a
> stop_rx/start_rx.
> 
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 1543a60..6f767c7 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1481,6 +1481,10 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
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
> -- 
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
