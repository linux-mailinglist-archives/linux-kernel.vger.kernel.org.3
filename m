Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73059EE52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiHWVkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiHWVkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:40:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF31400C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:40:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id e28so11434766qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=G86WRHJEnsOSMJyR+HIgPOCKLJ1FrfHPzigB3+KgUQA=;
        b=C6xtHq1NXPIMU5uiq5f8U0DS283aZaaUpCRuevskmzyHBlLjarhhQ4fJDZMI0/2W/x
         EC8gJu0aCTLkvueynaa8kDQMlCit6NrmK02gU7NZ7SFKQWjf7uiUo5LKIECjZDwqF/sT
         6UR54omum44/yPn132xscEFqF2nmEyZboXR/ZVbpcfa57YJRbNT4REnxUHfP33deAzrv
         +KzxpGd8WQKG3dc4Y5Rrl8Il1geRlEFvXWrWsbYTcrH1/2xz6NvVP5JQ7pGmn6LIP4HQ
         XqbCK/zYqEUr4jdAYPucRWHibKNZBB7ZyfwI9Ds2UGVH3uB+hRXu+wX2MaetjJPkjq70
         FXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=G86WRHJEnsOSMJyR+HIgPOCKLJ1FrfHPzigB3+KgUQA=;
        b=JVRBdRN1OVONdXpRoyyKd1JicCPqJL4FWEqvvvHFf+ZBb8zObPISozK+tEb2zdr3Zm
         I7NQQB9UQL6hw4sWfSMUw5jPdRmFftnRAuXkU6yAsV7qQw+O/ThFudiw8yEBqJwIEhsQ
         O4sx1r3zPncCXQEKi0f78JOQzA6OqOLbvCA04fXVkAYO0yIl4BAInZJ4xCZiu5rOVAix
         +ihIu1bCqeRjr2fnPpR/RiFfgVsJ0QrmcQszxH8V3Po7ncQXfJcHS1/lchRbOSsFrKJ/
         I1fhlkcNef1pnTlNQQUfV5lJhV0n0o+dBpO3gUHf2knLaC9P9ZbsIHdI3frHekgmO6aB
         7lSw==
X-Gm-Message-State: ACgBeo1RV9YXOnWLP9wstZZY+jY31Gaa3fZHDx6Zt8EZ0emyrWz3uVya
        9zH/C/BNbU9IuvC6AI/L63bf7VqQRCf1EHLM5tpVb4Zjjrc=
X-Google-Smtp-Source: AA6agR6XVm0mZhUNaQyuRLIRo3tTZ5Ozm5DTMfBOZ0xWzt+L/60JErk4kr0UwBvEdk5ofdoDMObkW43aLKr+PuUhZJo=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr22124846qtj.384.1661290802614; Tue, 23
 Aug 2022 14:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 00:39:26 +0300
Message-ID: <CAHp75VfSOL5R1JdH-RS4PEXT1dEwuFGsmUPfkAp7zdDEMGzzjw@mail.gmail.com>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk operations
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Aug 16, 2022 at 9:14 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> Currently, only one-register io operations support tracepoints with
> value logging. For the regmap bulk operations developer can view
> hw_start/hw_done tracepoints with starting reg number and registers
> count to be reading or writing. This patch injects tracepoints with
> dumping registers values in the hex format to regmap bulk reading
> and writing.

Since it's applied, below might be considered for follow-ups.

...

> +               if (val)
> +                       memcpy(__get_dynamic_array(buf), val, val_len);

I'm probably missing something, but what this condition prevents from?

...

> +       TP_printk("%s reg=%x val=%s", __get_str(name),
> +                 (unsigned int)__entry->reg,

Why do you need casting?

-- 
With Best Regards,
Andy Shevchenko
