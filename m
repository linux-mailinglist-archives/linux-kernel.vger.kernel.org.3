Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB35996FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347506AbiHSINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiHSINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:13:16 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB7F109F;
        Fri, 19 Aug 2022 01:13:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id de16so515099qvb.12;
        Fri, 19 Aug 2022 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8xRjWWqTqJR71ec9sr3LoeTgstJo+nK7ZM6OvQ/WbBc=;
        b=DVv0rr+qy4mLu7yexcLS+HJNtsHJ5+uslwUhZzVTnQQFiAKL9OM3zDTELcxcOToPeK
         JrX1c8AJSS+/htimLfCCSJSdlCqa6weM2cWriohpw+0gwek/ZFhlCR4sgCSAbG8hEsNn
         5PQDvRHxPIqwQcUZxQlAV6MBazpbb4KGkoyuw5F56e5mTrFFEqtZqDEyoCwjY632jo1x
         o35r1L530rnrkj8B/g/iS1LGckhsUZ+/disp4ieZ+YNapGpgXWMWP922BEzAO0FLg3DH
         boKUdURD6zToLF/Ax/xHu3uwIe/biNd/GfXXNztp2t0/okr9wObJYoZR23HX2TPmkJF1
         VnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8xRjWWqTqJR71ec9sr3LoeTgstJo+nK7ZM6OvQ/WbBc=;
        b=erDCfnfy+PPohWSlm7ma0QWN0oD42r89B4Qy+7k8b9l49nEGRA16RCB6JIMvITK42W
         iHhaHnv69Or/I5oTd7jJTK72k9eylpTL8pZXulnQOBaveAqrpjEShrNWseokrnExJYwE
         unirH73SWsLj5Z+ARHoztFjGOhJYr6iilO9AwdLe+PeLFLU9T6zL9B4JErI8kuEGII+G
         JE1366dfeB5Ba3h1k5XjgjihAVOoR7tI6MEBz5csbXw8/UJ8/+GsTd+PSirVBtBzsuNi
         lglFaSr99exB/OQv+mB8CQmtKCLlnxq2nueuyWPtCdclFDXIOyKbkT2Z/6GrRMn4yZot
         C8bw==
X-Gm-Message-State: ACgBeo3a0Wkxr/BW37BDRB7rQGbYtOUjxQClQXad5rLbwBHYj4X4IxFz
        WG1WywVs2qZ/L+t+dB6OFjub4DrbvjL0O3uIr14=
X-Google-Smtp-Source: AA6agR7QeiiF9Fgn1+vYz0KTXJWVLHlcW9SAYPPFMlNenPsnnpM60xdb5eSHvet6ReebGjdcFjQAiwGzbcjgWETfc2g=
X-Received: by 2002:a05:6214:d07:b0:476:c32f:f4f4 with SMTP id
 7-20020a0562140d0700b00476c32ff4f4mr5460234qvh.11.1660896794198; Fri, 19 Aug
 2022 01:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220817105643.95710-1-contact@artur-rojek.eu> <20220817105643.95710-2-contact@artur-rojek.eu>
In-Reply-To: <20220817105643.95710-2-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 11:12:38 +0300
Message-ID: <CAHp75Vd49aCKkK+KvmxJrW2mKk7=VgtSBCTYE9umOhZhc4Y8FA@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio/adc: ingenic: fix channel offsets in buffer
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
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

On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> Consumers expect the buffer to only contain enabled channels. While
> preparing the buffer, the driver also (incorrectly) inserts empty data
> for disabled channels, causing the enabled channels to appear at wrong
> offsets. Fix that.

What consumers? Have you tested on all of them? Please, elaborate. It
might be that some of them have to be fixed. In such case you need to
report the issue to their respective channels and put the
corresponding links here.

P.S. It doesn't mean I'm against the patch.

-- 
With Best Regards,
Andy Shevchenko
