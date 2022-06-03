Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E053D25E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349285AbiFCT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbiFCT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:28:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EFB580F3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:28:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 25so11145314edw.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLcd3Cw3hjI1NfLbhZ7+1EK5axo7GcECogVJtB2kQoo=;
        b=n63Lg6qyTjWXwuTeS8v+72aLJUJKw4vX/fzlGVF9KlWhmWjFlvsfSiHMmLjmJq8wL+
         J1+x0KJSnIYLk4zcB8ymTQjBIInkv9QNNiGw+gbTuk6Agp3JicslpgubNSGLpQP5/Qnp
         V13l+3GFTz3kWlwBXsM4/d9NyoyY6+LvUMNLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLcd3Cw3hjI1NfLbhZ7+1EK5axo7GcECogVJtB2kQoo=;
        b=S3T9CWb1+GsntUIDMGBrf307Bu7FnqQXUZhn6tdM7cOlIJzRMquCeUgLuBxv8eYRix
         UDQt/PkbAb0WUje+AgRmk1mpPPqTColmAEoyw5mbg5Q5iHWgv4qK6MqtAhPFI50vAn1n
         Co5IDuPZQEVB44cWf2LeapWXpTTrddKEP5jobZJFKF6al+P7AfC8WXVnoT3ark8WNI5F
         13vhlnfrsenPhKlvm6LtSv/KScXSSXqeIN8gR/noS7wz6rD7tlwZaebQPfmY5UhBsJf7
         HruN8USAE4MG+o2jVpqXsAXKmg7uHjQJ1aSANJM+hK9oYQqKi83PLIRy4t0OhpQoW+z3
         tpAg==
X-Gm-Message-State: AOAM530Cq/ENWnW+8szq8g3+AprFGoiiEcd+EAvJflI9tsASIjt9jWqE
        5Gt9XwNMnZQk0y8Q7ByhTEiStvO3DZ/B4qZqSPU=
X-Google-Smtp-Source: ABdhPJy5y9ZdktNHSybpOtgW9xnl5/OWvGDbNDWHKkSoFXeOTxHcm1x1MO23HGMZfZsDZM62x7aBWw==
X-Received: by 2002:a05:6402:3207:b0:42d:dba6:8ef0 with SMTP id g7-20020a056402320700b0042ddba68ef0mr12848941eda.410.1654284534530;
        Fri, 03 Jun 2022 12:28:54 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906520800b006feb3d65337sm3151649ejm.102.2022.06.03.12.28.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 12:28:51 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id p10so11578982wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:28:51 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr9544675wri.342.1654284530598; Fri, 03
 Jun 2022 12:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
 <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com> <CGME20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b@eucas1p1.samsung.com>
 <3866c083-0064-ac9a-4587-91a83946525d@samsung.com> <ff029402-f90c-096a-7366-b58f53555ace@quicinc.com>
 <fb44af37-daf7-974d-95fe-1a6c2cdab676@samsung.com> <cb802fb1-d0b8-68af-1c04-f73bc1beca77@quicinc.com>
 <f525c352-d995-0589-584f-0e9acf419f80@quicinc.com>
In-Reply-To: <f525c352-d995-0589-584f-0e9acf419f80@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Jun 2022 12:28:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UyNgfYe2Xh3uuYYHB4yPajZKO+i8nCngFn7TedbF-piA@mail.gmail.com>
Message-ID: <CAD=FV=UyNgfYe2Xh3uuYYHB4yPajZKO+i8nCngFn7TedbF-piA@mail.gmail.com>
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 3, 2022 at 11:54 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> >>> Add a start_rx in uart_resume_port after call to set_termios to handle
> >>> this scenario for other drivers.
>
> Since start_rx is not exposed it doesn't seem like we will be able to
> handle it in core.
>
> In your drivers, Can we add a call to stop_rx at begin of set_termios
> and then undo it at end?
>
> That would ensure that set_termios functionality is unaffected while
> fixing the broken cases?
>
> If that's not an option we will have to go back to a previous version of
> limiting the change to qcom driver.

How about this: add an optional start_rx() callback to "struct
uart_ops" and then only do your stop_rx() logic in uart_suspend_port()
if you'll be able to start it again (AKA if the start_rx() callback is
not NULL). That keeps the logic in the core.

-Doug
