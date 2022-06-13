Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD25481BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiFMI1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbiFMI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:26:56 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECCE1EEE8;
        Mon, 13 Jun 2022 01:26:53 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n185so2498949wmn.4;
        Mon, 13 Jun 2022 01:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lk9moY61kZ9XuLOtqgImU78u273AwbpZh7RoCd2QahI=;
        b=a2qR2O5qMfNSxyj2tvVYGQ3wJQLPdIUWdoWHN+9l5ZSqwqUwNVc77e+1yjft1ed9QS
         tdGAb7ozYmiI9kFFJUTwzJxJEKeSpCj3S9dq73xnBs/wP8IfSxKhiYSQJ90urT3pqIsF
         R++wr7yo9yoXL3PG8UtAbiI1VlJQ8i3T+JEpJweyg0Q7jkt59UF4/lNF0ACQlnEcQPG9
         iWSAsh84kRn+BnR1nLLNeLHwfaf7VQUags9BU69dd4mLyubzoVpNbrJ/xNu3j2QVPiT7
         St0qj56oq4RxyXOi06c34JgTDw7xCxGBt1oie2B7XK1ZtJlEYa0EfqMG/Ajk5oKJlY9P
         XcDw==
X-Gm-Message-State: AOAM531whNow57ZdpvD5DRLcbMMPepxVaL+k7+rQtzvZwofIWt5bz/1q
        ktnJm9r/ij8scewyGajrplo=
X-Google-Smtp-Source: ABdhPJysyulOMFIght1NBUcVM17BPiD0U7rWRdhNqg3HjTR6tgv0+TuOhPc8khXtzmCcRyHjFEnNpg==
X-Received: by 2002:a05:600c:4f95:b0:39c:7bd0:d47d with SMTP id n21-20020a05600c4f9500b0039c7bd0d47dmr13254453wmq.17.1655108811530;
        Mon, 13 Jun 2022 01:26:51 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0020c5253d8fcsm9296108wrs.72.2022.06.13.01.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 01:26:50 -0700 (PDT)
Message-ID: <670010a1-7727-f2d9-87ad-18ddbeb0cbef@kernel.org>
Date:   Mon, 13 Jun 2022 10:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 1/6] serial: 8250: make saved LSR larger
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas.wunner@intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20220613075227.10394-1-ilpo.jarvinen@linux.intel.com>
 <20220613075227.10394-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220613075227.10394-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 06. 22, 9:52, Ilpo Järvinen wrote:
> DW flags address received as BIT(8) in LSR. In order to not lose that
> on read, enlarge lsr_saved_flags to u16.
> 
> Adjust lsr/status variables and related call chains which used unsigned
> char type previously to unsigned int. Technically, some of these type
> conversion would not be needed but it doesn't hurt to be consistent.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
...
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -119,7 +119,7 @@ struct uart_8250_port {
>   	 * be immediately processed.
>   	 */
>   #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
> -	unsigned char		lsr_saved_flags;
> +	u16			lsr_saved_flags;
>   #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
>   	unsigned char		msr_saved_flags;
>   
> @@ -170,8 +170,8 @@ extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
>   				      unsigned int quot_frac);
>   extern int fsl8250_handle_irq(struct uart_port *port);
>   int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
> -unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
> -void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr);
> +unsigned int serial8250_rx_chars(struct uart_8250_port *up, unsigned int lsr);
> +void serial8250_read_char(struct uart_8250_port *up, unsigned int lsr);

It looks odd to have
   u16 lsr_saved_flags
in the struct and
   unsigned int lsr
here and there. You wrote:
   Technically, some of these type conversion would not be needed
   but it doesn't hurt to be consistent
But it looks like you actually made them a bit inconsistent. So why not 
use u16 for everyone?

thanks,
-- 
js
suse labs
