Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137EF4F5C15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbiDFL1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiDFL1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:27:01 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6B55F353;
        Wed,  6 Apr 2022 01:13:39 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id ot30so2552004ejb.12;
        Wed, 06 Apr 2022 01:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nbgR+IckzJRUGptIoNowdGGPeNkA0puvrWRLQTOMQtg=;
        b=b9ZCrlDB+GTB2tVlJ/03f4DiB6XAjJLJKb4ju2RtXtfz2tJbZYXFz71/nhsJDZOsLo
         L6raeh7/AIHcw83pF3yrDE4JGlD2ik+B4sCAwit8Ppm3GKgHrlmhhHSm4mGY32xNPa8H
         Ua9b8nJOpDTu9x+Jrpcpogv4mtiSYHw/ub8rC97JIaByLspqNSI7NAGdAhGjr5E4f8tU
         82bTW/HjL+6XlA2c0VQQBYENjhWK9k1Mta4sJE6n1Vi/tF2V1ZWrSqNHJdkU2hJGeQ5h
         n1+3vlgoZYK9Q7a7mkXf7XNgagipkFHKtDsrI0xhYIGyjBDKZcKHe6PeyV57qPlMb0Zq
         W8LA==
X-Gm-Message-State: AOAM531adGUewbHwKMnLe3tMcNrg+us/HWT5o3H5UmsvZixEJqcQ0pyz
        Y5PGfAvOpy4Of374/Vld9Y8=
X-Google-Smtp-Source: ABdhPJxi7OtObunO4HoGzaVX4GKdsXdaUsE1FqYamU4yS4gwOCjIaGhCC1e2eJVmIPDZ2UdFExQpcQ==
X-Received: by 2002:a17:907:3f9c:b0:6d8:116d:476b with SMTP id hr28-20020a1709073f9c00b006d8116d476bmr7036757ejc.432.1649232818074;
        Wed, 06 Apr 2022 01:13:38 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c14-20020a170906340e00b006ce98f2581asm6270629ejb.205.2022.04.06.01.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:13:37 -0700 (PDT)
Message-ID: <7cb1cc42-ef98-cbbe-1779-107602747d07@kernel.org>
Date:   Wed, 6 Apr 2022 10:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] tty: Add lookahead param to receive_buf
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
 <20220405102437.4842-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220405102437.4842-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 05. 04. 22, 12:24, Ilpo Järvinen wrote:
> After lookahead for XON/XOFF characters is added by the next
> patch, the receive side needs to ensure the flow-control
> actions are not retaken later on when those same characters
> get read by TTY.
> 
> Thus, pass lookahead count to receive_buf and skip
> flow-control character actions if already taken for the
> character in question. Lookahead count will become live after
> the next patch.
...
> --- a/include/linux/tty_ldisc.h
> +++ b/include/linux/tty_ldisc.h
> @@ -224,11 +224,11 @@ struct tty_ldisc_ops {
>   	 * The following routines are called from below.
>   	 */
>   	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
> -			       const char *fp, int count);
> +			       const char *fp, int count, int lookahead_count);
>   	void	(*write_wakeup)(struct tty_struct *tty);
>   	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
>   	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
> -				const char *fp, int count);
> +				const char *fp, int count, int lookahead_count);

Please always use unsigned if you don't expect negative numbers. count 
should be changed to unsigned in long term too.

> diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> index 58e9619116b7..1871a6a9cb00 100644
> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
> @@ -39,7 +39,7 @@ struct tty_port_operations {
>   };
>   
>   struct tty_port_client_operations {
> -	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
> +	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t, size_t);

Good, here it is unsigned and even of size_t size (I don't immediately 
see why, but OK).

thanks,
-- 
js
suse labs
