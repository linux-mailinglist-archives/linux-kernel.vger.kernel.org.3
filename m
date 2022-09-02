Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772785AA726
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiIBFPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiIBFPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:15:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0206B2A704;
        Thu,  1 Sep 2022 22:15:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r6so711222qtx.6;
        Thu, 01 Sep 2022 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/FPvSu5Og6r5KCFvrM/XvD5oQdCoQmFQqyC6B9qZN9g=;
        b=G8131IqrlpHP4CzYjGkQNjXm8IyVVFqG/ye8pGjHbGhU/MTuIOhAPeoo7MY99Hr8mm
         OFjUw3own/fILPs6zy/j2KpcWeFxqr40z1l8+j4IrBF0+FuyochX0BiCTsW1g+l2wlgq
         /X81qajoFnzetFnGIGXdncgxCa0ljNcCQjNvBxT1budI2f8A1WHeyHUQRlLQn0D+fq8P
         8A+lV9k5Qk4MnBK2dsUw3SanpvnTwyGBFT/PX3PQJPhsiPjfIWmLoiwLqQx8EQThWeCN
         kH5m+DXKqvlGRztfDrUgvbsJ8MKJn/hUETbrUyoYvL60S+3+MtalO83nNZNbAp7I0pif
         XHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/FPvSu5Og6r5KCFvrM/XvD5oQdCoQmFQqyC6B9qZN9g=;
        b=oQeyPguVuNhSowmcvpLLGE3tUfBrR3e7fQOXhoBxIhDpqC3vonOENnATVtnXBJf65b
         /Bqryz7VF0s6KPPLHOHR67N5A4TaFeh4x4/aWj8sm9JxoRWZlVsNaZo+XxnuZQcVSiNk
         /q7bLg0jqvkI1ZI/EGgPa0nqAif6pqjwtp0GAGaXB6RtP7rR80Yy3slIwkQFLJg+HbLa
         HzR1E4Im57Hv2Ts9TxObXbJEEXczOFpiLbzLiVpnmzBC8yBWzLV91AEHrvRN94wccuKT
         Xj0wQboloj2l92HywW5XO/NnPVkq0P6p8LIE/oTMDirrHt0qtehf4HBA1AHLUgWjO0jO
         b+fA==
X-Gm-Message-State: ACgBeo3OMSyIzRxLRqrMJnEApMQDvWSPi52pPwO9MN86rOtC28ZE/SGC
        nKJrO1zJDIWPHAbGU1arNbdX+C2PyfkgAxDn/Xw=
X-Google-Smtp-Source: AA6agR5TMJCTdI8lPLurDZddFyotVb//UahRpflITQxKq1hFILTM/GvJbwYD4fqsz88B+3lNqPo9zW2PBILCTcxGngw=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr27107617qtx.481.1662095736071; Thu, 01
 Sep 2022 22:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220901235003.20520-1-qingtao.cao@digi.com>
In-Reply-To: <20220901235003.20520-1-qingtao.cao@digi.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 08:15:01 +0300
Message-ID: <CAHp75Vdgj9bFMs17ydpoJWvtJkX_9goG7LtQFhko=E4_6CV7aQ@mail.gmail.com>
Subject: Re: [v2 PATCH 1/1] gpio: exar: access MPIO registers on slave chips
To:     Qingtao Cao <qingtao.cao.au@gmail.com>
Cc:     nathan@nathanrossi.com, Qingtao Cao <qingtao.cao@digi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 2:50 AM Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
>
> When EXAR xr17v35x chips are cascaded in order to access the MPIO registers
> (part of the Device Configuration Registers) of the slave chips, an offset
> needs to be applied based on the number of master chip's UART channels.

Looks good to me, but here is one important thing. Is documentation
really refers to this setup as "master-slave"? If no, can we replace
to something like promary/secondary or other suitable variants?
(Replace in the comments and variable names, etc)

-- 
With Best Regards,
Andy Shevchenko
