Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71534F7829
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiDGHx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiDGHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:53:53 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767CA133143;
        Thu,  7 Apr 2022 00:51:53 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id d7so5377982edn.11;
        Thu, 07 Apr 2022 00:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HlsFChQWDI+lV323VTGrNLIEBT5KrxizBz+j2lMHlwI=;
        b=dt7bntg+rIwUuqhNa+HK2lYxGI7i78mMntA89ZqOFmDbpzQ+2+rbv6zkCxS0iIaXEC
         /TYEBSL0WOSYfr3CMEslNzrIhNbVCibyL5YqCvX+ErsxDtvvmxVO+cCMNhTEr9qp1xao
         YZFUnhosglCfC+E8GEm7/Rt1+mdieOhvd0+BR7NVJCk9L9XSCSZAcWYZqL6TeNCMQ8u6
         MvvyztejMpHDCkdHgCvL90yBpFSQGXYF26yX98rvCpHdWDS42tA/EitqyIQOWHul8Syc
         wyOAZElqteck1zxHTmP8yh4LGdAHqRIPhJ2HC4jpEiA+/DQjTc3Z/Dgi4pJcNIWXx5Rl
         P7Mg==
X-Gm-Message-State: AOAM532cibsTf3L+rMNJiRDKIGgMXiAsMX3O2AOeWwApp5AgKRZ4RGAK
        IMiPOwwzuJ2X7P5OP84kjIgSv6JqvJQBvg==
X-Google-Smtp-Source: ABdhPJw1TiS6DOGazUz5QGMFL8eXsLD6FrZWh9hwqvGvacCLdg7yT3h2UqzUAxcpxOmWSG72TV48nw==
X-Received: by 2002:a05:6402:a42:b0:41c:dc68:f9bb with SMTP id bt2-20020a0564020a4200b0041cdc68f9bbmr13103298edb.244.1649317912006;
        Thu, 07 Apr 2022 00:51:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j14-20020a170906278e00b006e7fee99933sm3373622ejc.33.2022.04.07.00.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:51:51 -0700 (PDT)
Message-ID: <0f52c6aa-46be-6971-76df-364150b1c1e1@kernel.org>
Date:   Thu, 7 Apr 2022 09:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [V3] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend
 path for console if console_suspend is disabled
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org
References: <1649316351-9220-1-git-send-email-quic_vnivarth@quicinc.com>
 <1649316351-9220-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1649316351-9220-2-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 04. 22, 9:25, Vijaya Krishna Nivarthi wrote:
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

So why is it OK for every other driver? Should uart_suspend_port() be 
fixed instead?

> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v3: swapped the order of conditions to be more human readable
> v2: restricted patch to contain only stop_rx in suspend sequence
> v1: intial patch contained 2 additional unrelated changes in vicinity
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 1543a60..53723d2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1481,6 +1481,10 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
>   	struct uart_port *uport = &port->uport;
>   	struct qcom_geni_private_data *private_data = uport->private_data;
>   
> +	/* do a stop_rx here, start_rx is handled in uart_resume_port by call to setermios */
> +	if (uart_console(uport) && !console_suspend_enabled)
> +		uport->ops->stop_rx(uport);
> +
>   	/*
>   	 * This is done so we can hit the lowest possible state in suspend
>   	 * even with no_console_suspend

thanks,
-- 
js
suse labs
