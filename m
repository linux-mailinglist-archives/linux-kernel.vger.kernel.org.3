Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804545280D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiEPJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiEPJ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:26:00 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54236D6C;
        Mon, 16 May 2022 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652693159; x=1684229159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j32zvz7zIgRB3Uec9x5LBXnza08b8JB8Wqu3W8uAuSo=;
  b=KGy0uWp6GZA3KzJfxGkzBLMN9Vkq4Du8+/3BPjH+tA8vB5CZnnrho2GQ
   EeLingwAbPgLaHrNk4QdKTgs7UFzumjQAnseGnoaQTKQl9LHu0J+UEuJf
   9bmkIL+4j8uqu/w/3/exi5H5jnuPnmzn4pRR+LXoIB1q/UnESsWtX2Hpn
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 May 2022 02:25:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 02:25:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 02:25:58 -0700
Received: from [10.216.5.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 16 May
 2022 02:25:55 -0700
Message-ID: <0eedc244-5c8a-c734-8bba-09a66d050a4e@quicinc.com>
Date:   Mon, 16 May 2022 14:55:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Content-Language: en-CA
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>
References: <1651484835-25189-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <1651484835-25189-1-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will be dropped.

Uploaded this change as v4 of an earlier patch.
Apologies for trouble.

On 5/2/2022 3:17 PM, Vijaya Krishna Nivarthi wrote:
> For the case of console_suspend disabled, if back to back suspend/resume
> test is executed, at the end of test, sometimes console would appear to
> be frozen not responding to input. This would happen because, during
> resume, rx transactions can come in before system is ready, malfunction
> of rx happens in turn resulting in console appearing to be stuck.
>
> Do a stop_rx in suspend sequence to prevent this.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>   drivers/tty/serial/serial_core.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 82a1770..e8c6875 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2211,9 +2211,16 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>   	}
>   	put_device(tty_dev);
>   
> -	/* Nothing to do if the console is not suspending */
> -	if (!console_suspend_enabled && uart_console(uport))
> +	/*
> +	 * Nothing to do if the console is not suspending
> +	 * except stop_rx to prevent any asynchronous data
> +	 * over RX line. Re start_rx, when required, is
> +	 * done by set_termios in resume sequence
> +	 */
> +	if (!console_suspend_enabled && uart_console(uport)) {
> +		uport->ops->stop_rx(uport);
>   		goto unlock;
> +	}
>   
>   	uport->suspended = 1;
>   
