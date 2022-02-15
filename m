Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241E4B7A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiBOVzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:55:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiBOVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:55:01 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860BB7C6A;
        Tue, 15 Feb 2022 13:54:51 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id h125so202882pgc.3;
        Tue, 15 Feb 2022 13:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8rxiLZRrx6DkhO6JhZGnTb7or4pWWLsRk06cZxBhHFc=;
        b=Dwo/ynMFZvHDoVx9x9jqxJwX1hdBWQ+BjNyU4pjsx/aduWpeqyfV5R9+REia4gssoc
         GHncUzKURrDB2DDuIDYe59dgMtaSIxvPp8EsH25xTNAiCl4UuvhN+rlx1QVvO1o1Rj1d
         y7vUJTiqGx3p8JERAoqVYMHvq9qswFVqrKBHr7g4HN+WyWh5XXojJ4oVaHL8MMCxrnoy
         mQ/TF0esGTTaPj3F4VqwqjU71ptziclr7PQstPC07Pi5UXuLx4FOGHLUJkc/Tko8zJ73
         xYHphpmFaOvLapoA9w2zBhXAFAEI6sEfIPkD6qDMm+DQWfbeJWq9chJDnknpZlr8ITDR
         7BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8rxiLZRrx6DkhO6JhZGnTb7or4pWWLsRk06cZxBhHFc=;
        b=kof5znjXU9d2uUk7548F521JD0iISlFd5NVSoQronsbt3o5D0c8cVMKBrpIkW+2NYA
         MU0HBKm4Jyn8G74QbVN2TJ1fEtv/x6CKBgIgBA9zyrou3J2OVGQBfl67bMhM4OnMBglR
         o+VVdVovjpMSFciIv348If/p5lRNqvv1XZpM6kOjcqBew11/D76PiOBTMVtg6omX12pF
         uv0rANWB6cneLhQRajsZQvxhDzLQlH1X11cbi3VnAilzRPmZOVqRtUAiIIPjpBlJ5u2q
         qjCb5hEdIOBF2ZNxblNQHbvyGCcNB2sv+Xi70kBaU4pl96qx439Aj8gIRaKLMkbnkrRx
         6Pbw==
X-Gm-Message-State: AOAM533P5vcIigTYDsF7A/eAzIx+6Q0ojFsDXA8h6yVk/x7xy6tUd+ig
        OWm21ymvfexFdV8Jc5GPVqFkq0kk4a4=
X-Google-Smtp-Source: ABdhPJxiN+JCVRQYH9oGI2pGDYtFcvfb2aMo9uGf8dinshye5/X0eDxqzrhqjOvt4llszoYfaaZwEQ==
X-Received: by 2002:a63:89c7:: with SMTP id v190mr792552pgd.208.1644962090354;
        Tue, 15 Feb 2022 13:54:50 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id y20sm22134080pfi.87.2022.02.15.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:54:48 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:54:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] input: ps2-gpio: refactor struct ps2_gpio_data
Message-ID: <YgwhJkRGdduf5oYc@google.com>
References: <20220215160208.34826-1-danilokrummrich@dk-develop.de>
 <20220215160208.34826-2-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215160208.34826-2-danilokrummrich@dk-develop.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Tue, Feb 15, 2022 at 05:02:05PM +0100, Danilo Krummrich wrote:

> +static inline struct ps2_gpio_data *
> +to_ps2_gpio_data(struct delayed_work *dwork)
> +{
> +	struct ps2_gpio_data_tx *txd = container_of(dwork,
> +						    struct ps2_gpio_data_tx,
> +						    work);
> +
> +	return container_of(txd, struct ps2_gpio_data, tx);
> +}
> +
>  static void ps2_gpio_tx_work_fn(struct work_struct *work)
>  {
>  	struct delayed_work *dwork = to_delayed_work(work);
> -	struct ps2_gpio_data *drvdata = container_of(dwork,
> -						    struct ps2_gpio_data,
> -						    tx_work);

This can simply be written as:

	struct ps2_gpio_data *drvdata = container_of(dwork,
						     struct ps2_gpio_data,
						     tx.work);

No need to resubmit unless you disagree - I can change it on my side.

Thanks.

-- 
Dmitry
