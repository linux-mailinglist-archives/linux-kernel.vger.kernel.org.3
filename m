Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF60A4F6AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiDFUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiDFT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:59:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210322E1627
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:29:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 2so3210023pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rr+xzlj7vxdfalta/rr/vaKILwxRPcQ5/NXkWgY8K0M=;
        b=B1sq59hw7ckgQoFKnsvmJEAip8CSip0a3sLJR00RxPH+khENkQjAQh+kGzBFbqGjv8
         citQ4qw67DSyfwtGlKNNuIWL2hIUe6J9qjHzgonZu6wuCG7dLAtC8e1IjtXwMAze0sDj
         RLNQx0bJkjkiIxjwT0lKFRoFztKbmKj/m+Y+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rr+xzlj7vxdfalta/rr/vaKILwxRPcQ5/NXkWgY8K0M=;
        b=6qOAGBQ6h2k6WIhqmrTo2WfMwKSy6wM/B+tgWoSZ8eO0dtHcR8WkyQ9BK+iEUNgouv
         H7GZASEOjU+1rBtI9xtEKOIeank8TnHidLRHSfmIz690YlcW0afzw38+R9Z6Izstnelf
         TmEBfmlStnYkWss8n0oe9I0pGCvy4U4xagm1lyheWJO6CgUEqFSqgUmLlISyqo9GBEdJ
         3UU0kCyaX9DZFODo/c8CSI+brCbSKeznNbFqsyQusjTgra00LIIp06sJlY3+s/Ion3Zk
         n/1PXZvLQZx3QkemlYvD4gUFPW04RobZz1amZxgOBCv11ILTQ85U8uJDpBlcW5+HsCQR
         eMOA==
X-Gm-Message-State: AOAM531FKtksUwkPNJQOCA/RUE7Xv/nrz64LZQfnheCQ6AIEt4XET+SP
        Qw49wSZoF9TbBYWAYSNzNfq0XQ==
X-Google-Smtp-Source: ABdhPJwdSFDwLNqsqc2vubhlC0RRxfBG/wKDtKr3C4VRsDexJML+RuUfa9a4Gqn1DJb+ZvQadwh34w==
X-Received: by 2002:a17:902:da83:b0:156:aa83:8409 with SMTP id j3-20020a170902da8300b00156aa838409mr9949694plx.22.1649266181846;
        Wed, 06 Apr 2022 10:29:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dddf:7cc7:1261:9584])
        by smtp.gmail.com with UTF8SMTPSA id z10-20020a17090a8b8a00b001ca7bafba51sm6126276pjn.0.2022.04.06.10.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 10:29:41 -0700 (PDT)
Date:   Wed, 6 Apr 2022 10:29:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org
Subject: Re: [V2] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend
 path for console if console_suspend is disabled
Message-ID: <Yk3OA8CLoijOyDDf@google.com>
References: <1649233612-30844-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649233612-30844-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

nit: I think for a human reader would be slightly clearer to swap the order
of the conditions, i.e.:

	if (uart_console(uport) && !console_suspend_enabled)

> +		uport->ops->stop_rx(uport);
> +
>  	/*
>  	 * This is done so we can hit the lowest possible state in suspend
>  	 * even with no_console_suspend

v1 one had additional changes which weren't directly related with
console_suspend. They looked worthwhile though, please make sure to
send them in separate patches.
