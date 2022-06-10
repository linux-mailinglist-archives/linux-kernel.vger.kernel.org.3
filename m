Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E08546819
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiFJOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiFJOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:15:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB680294;
        Fri, 10 Jun 2022 07:15:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v25so35481487eda.6;
        Fri, 10 Jun 2022 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jc3e3K9fjKuQFsXc0udFTdSyc0Wk0NlV5mtyrMlUESQ=;
        b=qQAJN7RGaTvIZRcl8Dv0wSzr6O6oEXuJKOv0S1WLzjNDFkdZ88hMK7cJEz83N1oL/4
         JcJfPUF5p2NjH2QioHWJSf0WKP8PA+t0PCmR+4yvUDsQyrOCjhq84M1ruq37Yqy2JGdW
         9Sw+0JIfuIlsfl4gEAlwbwOFlCgEFTD4JBJdW0StJVOKPwhqGLMVWfBsSRx/3RrCNYQH
         Ybr2mE4tLk/Glgd7jHIQRWr0UL94xqfsd7hp0a2ONlaOKKeuM8a0oOTxDtfdy7dLfdHT
         DOm7lhrR9zwDCGPk/Y5kritgVei38OSMBttoiAejqQINdCMU6jMPIKCeEBDNlPB7o3M4
         8ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jc3e3K9fjKuQFsXc0udFTdSyc0Wk0NlV5mtyrMlUESQ=;
        b=eseO2grTKbSn/VOFz0Z4CwyMJIiwoJtfs+Rd+To7MNd4SXMZXtjJtEZR+4ROoKOO3J
         8qpxl14u2Qi9xq2WQ81g4DPJzNTigbQ8ottXSWgzwuMRdZh3/8tqnP9nqVndDW4Bnpgm
         bzuSNxrmQSPbD1GM5Te32xDcSUxVy2ZVt3Mb40tTUlP553WghbLlZ/2jr6gP9S7lNOcT
         vz3R3KtYH0te281pYagOS6PvICwZqSIwyuHyL0m9oXH4LK0hnJm550EMmgcikubQg1Zq
         Iq7d7jGvMmoKZX/KHCJN0qcgXlb5fNYhjmmOecEPdtI+oWOCUQmRAeP0aqNr+9krMnfP
         S/TA==
X-Gm-Message-State: AOAM530UDZHk2lwS3nZJWKFQI+GtP7BkewZ5cHi1pcPtYmwLBXMedpke
        F9ErzXa0kC1MD97ADdOunmRzqekwBSWwFOHY33lhOboojWw=
X-Google-Smtp-Source: ABdhPJxhvmb4o6j3Y2SxEQa9mbryRYzOrjzrGHUfx+Eu77n5bO7q5iFBngkcwJJgllmLOLtLiNZC3QrZPQaU1MNFfkk=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr51509702edr.209.1654870507104; Fri, 10
 Jun 2022 07:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:14:30 +0200
Message-ID: <CAHp75Vcr=i2zSFkD6MhR=TE8fWqqYqsuWnZJTeQ5HcRjw3U3hA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Convert to immutable irq chip
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
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

On Tue, Jun 7, 2022 at 5:53 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Update the driver to use an immutable IRQ chip to fix this warning:
>
>     "not an immutable chip, please consider fixing it!"

...

>         int irq = irqd->hwirq;

Consider switching to irq_hw_number_t with irqd_to_hwirq() (in a
separate patch) as pointed out in the documentation.

-- 
With Best Regards,
Andy Shevchenko
