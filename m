Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1337F4D63F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiCKOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344430AbiCKOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:40:56 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14374842;
        Fri, 11 Mar 2022 06:38:34 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id r127so7057142qke.13;
        Fri, 11 Mar 2022 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iU7gCGr1VdelurSCAywqdNeaWdDipjKRqNaP000KsAo=;
        b=PgpGhqFkFlrhdXEk5NEwF9LnOxYUeXR7cl7/M/TirE17bvhJL2qugvXCtwvlL4o4Dx
         L88gwsbwDdOIga1mu+25Awtebtfq44yuIMG5iCJ0VsaaEVVPUNdfv+NRf7KXQeIwypJu
         O8tZasWRh4WjIPL5ykgBT7qJs+Lyamqqom+fysMikTwBYZjuT8TsitusNFFYIOgDU0xx
         XHt5BzFqKYLLRwaqwYJEJbVxH+HW4ZEOkIr1QA19a/ZnPF8THsaPwt0wfhqp312cN9mr
         EWLQAd6GK+aqdwCSami1lTIStb48UD5E0fagjHl8zzpb4hHyx3KEaGxNnm+u0v8Kote0
         1ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iU7gCGr1VdelurSCAywqdNeaWdDipjKRqNaP000KsAo=;
        b=7Ag7JrPatoLWhD+bgxBG22eczX/CSifT8ZbWp+8HPMgQ2+eTiYOvGH6mzNRvn2cg4R
         JoR3CV4BETEi0DobwLsVtKLCRo/F5bod4lbe4ef6kIo1cjb9Hyi23D9EGFa4K3BF2nDO
         QN0y5m+wmo3VMvTG5Tjs293iciVKaUUytmUn84An5mEn+9uUKbb+kkQrJFU51L+D70fI
         BKfzz8lbi6B6gm6I2NOz3/i1p/gj3Bbc1yKBywntTdhcqG3BI9TMqXaZZHya7J5iqtjb
         RkE9cKDAl5JZU+eXiJKV3tlLn1uJRvcOMhFvzJV0Xm9wMWgGHOlzaZ4XhgsrT8uSulqN
         9zJQ==
X-Gm-Message-State: AOAM532zkWjaezKvFn/dhnWAxYFj9YcPuVZGmgMfYPPyvpZlddAjEUo5
        xqBbxvw2uq29p2rfumuGILDkr1792Bg=
X-Google-Smtp-Source: ABdhPJw6nD67gfFWGHM95lBbaXlhy7v9j3Co97lvY43StlVZnpd/eC3HALjxThfHbP3Kuo1mh5gAnQ==
X-Received: by 2002:a37:3d5:0:b0:67b:335d:59c3 with SMTP id 204-20020a3703d5000000b0067b335d59c3mr6551783qkd.739.1647009512972;
        Fri, 11 Mar 2022 06:38:32 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id s7-20020ac85cc7000000b002e1b34b30c9sm3116984qta.75.2022.03.11.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:38:32 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:38:30 -0500
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_fintek.c: Finish support for the F81865
Message-ID: <20220311143830.GA39653@localhost>
References: <20220311070203.18159-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311070203.18159-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-11 @ 02:02:00 AM, Trevor Woerner wrote:
> This driver only partially supports the F81865 device. The UART portions
> of this SuperIO chip behave exactly like the UART of the F81866, except
> that the F81866 has 128-byte FIFOs whereas the F81865 has 16-byte FIFOs.
> Therefore fill out the support for the F81865 in the places where it is
> missing.
> 
> Tested at 1500000 baud on the iEi NANO-PV-D5251-R10 board.

Is it too late to send a v2? I'd like to fixup the subject to remove the ".c",
and I should probably add some comments in the driver explaining that the
F81865 is functionally the same as the F81866 (except for the fifo sizes)
which is why the F81865 doesn't have any of its own #define's.

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index 251f0018ae8c..d9f0e546b1a1 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -316,6 +316,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
>  		break;
>  	case CHIP_ID_F81966:
>  	case CHIP_ID_F81866:
> +	case CHIP_ID_F81865:
>  		reg = F81866_UART_CLK;
>  		break;
>  	default:
> @@ -363,6 +364,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
>  	case CHIP_ID_F81216H:
>  	case CHIP_ID_F81966:
>  	case CHIP_ID_F81866:
> +	case CHIP_ID_F81865:
>  		uart->port.set_termios = fintek_8250_set_termios;
>  		break;
>  
> -- 
> 2.34.1.75.gabe6bb3905
> 
