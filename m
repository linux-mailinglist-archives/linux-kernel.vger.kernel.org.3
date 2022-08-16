Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAEC5953F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiHPHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiHPHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:35:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DE3345D3F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:25:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 73so8254244pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=MxYo0wID6qdiUi1PWrTNYuPWf+xyX55MuzHvys+JBlQ=;
        b=HNG5YoKVg/uARURi7z+KxjtjKr/VB9Io6i9U54isD7yHkjUWLXWwgBB7EtsCk1fHz7
         Ms6LnkS25EPLnr0MI4skiDY+/5BaFuE3O0TXG8oGSifRIHSotfUJdKFf2fRS/9HSHbtj
         40YWi2Hh2zIBKmXMSTATQChbA3jmLP7s7KEfrIrcLDoqCnBOx+/Ek4KAbJF2I20XMeWU
         zobafXdKaXjpsO8Pbz7Fd6AwwkSZWNklUY627J5JG7afk7bAaHR73RWKQ1k8N8eeEhbZ
         Os5yzdgD2gJ1nSi8SVch6LJEe1B6X9dPvJS6wOBnByvbSJqcuerk9hhgPzyadLUbgWGP
         Zyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=MxYo0wID6qdiUi1PWrTNYuPWf+xyX55MuzHvys+JBlQ=;
        b=mZHmdtMmXoZRRqXQofAhuAx05N+LaG9Gevnk/IFLPEUJ+a7Mr4a/3BKb7j+j0OB5oI
         UdeajUdZQoQjMfoSEusf216t9H0Ky4AAzPvdBuU1dsXBMsoD7xgJtU9l9urO8D/V4NBQ
         EOySOvHVXoNMr1V/zRKFy6K/I+jyhMzwQKO85pSBY3FpX7XlEfNN3XZIh1YHAb3C8agb
         A94DsKMgWULJjicMF6q4yu2g+6F/jIStfnUHi7vdaF6ZQtpreEUkEa473mjYrtaOgeI+
         /0fw3EcLxE6Dqec1JjjbnID/A4/2jmRSHC5yIxwjSzsJ+R6ouG8nxJLKJchx0wXgpzLX
         nDEQ==
X-Gm-Message-State: ACgBeo3JvAwY/rAQaPzbV5bs/q4hAwBA8O1brVvja+0Jd6dnPyyHAx7f
        c/6T+iznosq1JlKBEqj6vAM=
X-Google-Smtp-Source: AA6agR48L0okt24RFYhW4WImisMWOqBxTxvnH6Fqb4gmg3xnz6e1o11I2k7zj29XeRDDnJ/mATqd/w==
X-Received: by 2002:a05:6a00:4509:b0:52d:4943:90b4 with SMTP id cw9-20020a056a00450900b0052d494390b4mr19648774pfb.22.1660623909687;
        Mon, 15 Aug 2022 21:25:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a488e00b001fa8ee8649esm658199pjh.7.2022.08.15.21.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 21:25:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Aug 2022 21:25:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <20220816042507.GB1108868@roeck-us.net>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815211919.2028890-1-isaacmanjarres@google.com>
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

On Mon, Aug 15, 2022 at 02:19:18PM -0700, Isaac J. Manjarres wrote:
> Both __device_attach_driver() and __driver_attach() check the return
> code of the bus_type.match() function to see if the device needs to be
> added to the deferred probe list. After adding the device to the list,
> the logic attempts to bind the device to the driver anyway, as if the
> device had matched with the driver, which is not correct.
> 
> If __device_attach_driver() detects that the device in question is not
> ready to match with a driver on the bus, then it doesn't make sense for
> the device to attempt to bind with the current driver or continue
> attempting to match with any of the other drivers on the bus. So, update
> the logic in __device_attach_driver() to reflect this.
> 
> If __driver_attach() detects that a driver tried to match with a device
> and that results in any error, then the driver should not attempt to bind
> with the device. However, the driver can still attempt to match and bind
> with other devices on the bus, as drivers can be bound to multiple
> devices. So, update the logic in __driver_attach() to reflect this.
> 
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: stable@kernel.org
> Fixes: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from bus_type.match()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  drivers/base/dd.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> v1 -> v2:
> - Fixed the logic in __driver_attach() to allow a driver to continue
>   attempting to match and bind with devices in case of any error, not
>   just probe deferral.
> 
> Guenter,
> 
> Can you please give test this patch to make sure it still works for you?
> 

Not as well as v1. I still see the clk crash with versatileab, and imx25-pdk
emulations now stall during boot when trying to boot from usb.

Guenter
