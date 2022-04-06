Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237194F5C34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiDFLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiDFLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:32:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB2B1BB820;
        Wed,  6 Apr 2022 01:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16FCDB81FB7;
        Wed,  6 Apr 2022 08:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E835C385A1;
        Wed,  6 Apr 2022 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649233308;
        bh=m02B52PlbTGkHsglDWYkbPf87t6nOSAI6SsL2u6s9WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dmHURPUrahNYrn7D2K0tE4AfQoQwL9KCcwOVFz4YF8tjyg7IESCEUUr0Xt/EbQcxA
         aE98Em+gCM0thhr269/aiLBr8phAStBLl9zuDH1mD1TDm5MeHozKdsrEtWq+Mu9hzY
         qh6zzKhJscn44zJUQmNlYDuqfCwIEoHorKnVKwqg=
Date:   Wed, 6 Apr 2022 10:21:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Message-ID: <Yk1NmTdUgMcSIq1O@kroah.com>
References: <20220406082216.11206-1-jaewon02.kim@samsung.com>
 <CGME20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f@epcas2p2.samsung.com>
 <20220406082216.11206-2-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406082216.11206-2-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 05:22:16PM +0900, Jaewon Kim wrote:
> The console_write and IRQ handler can run concurrently.
> Problems may occurs console_write is continuously executed while
> the IRQ handler is running.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index e1585fbae909..9db479d728b5 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2480,12 +2480,24 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
>  			     unsigned int count)
>  {
>  	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
> +	unsigned long flags;
> +	bool locked = 1;

"1" is not a boolean :)

