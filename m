Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811F2593345
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiHOQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiHOQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:29:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64AB6241
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:29:08 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c20so5829692qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NVdbXDDqt8OLuQLqClAaHnuBSzQXULtNPdEas2SrLJY=;
        b=gggYPfYCcZrz3KKyz6DVR+Swe51KgJItmUNgu0M9NHQfWWqXLRLoqWgNrflb24LvVq
         xcw1w86Vmq6OoZWjBE1JUPlLygkB8ijz53I/N7/8hK09levGgssM7nf3sHzC6b3NBVhW
         iA4kg5/OCyLeQxLxNUhl1MQIVyL0u9qRfrOO9qvkYhzcNWG0hc2z6LR7AQKJEL3qBiXM
         U4Ezv+avFSC7RtJhoomfXqFYpbhErgcW06VjKn2e61Xz9ceTMXsoui1OaeFTngV+5pRk
         TvMci2XKG2o6nBhkI2vewzFgGyW54cAwtZYjtYahkYFkQ4mDVLdFfsAT0ObXo/pl7Dip
         qbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NVdbXDDqt8OLuQLqClAaHnuBSzQXULtNPdEas2SrLJY=;
        b=fCncAKd0Kal2k4qxphXIAmXEY8e501ddnsGLacJcd4wFoCmlTcn+Md+GRqmg6DjqUf
         1DREFtEbj0fm/7rPWFk1NEdPjUp3HeWAajAwDES6me+WqarfAeNma5KIyw8EZCik0bs4
         wTD/n57jsQHcdTn2JcHP4OM5eGtljaBB7V297HkQ1TxWY8ObSpdTTuqAql71gt6V8fK6
         ieiJUQ6sndNGzmiHgbiColJVNzYLN107V+wQ/kJjPEHsthxizlsor6nJRuAGSHaQVTzD
         l6U+oAi5yrA+4zL+RLKF/qNCRxwPaNCaaMOEurQEzUP/6agZoA5iUAiZ4OBwbWM+tJ0/
         6CNQ==
X-Gm-Message-State: ACgBeo0CWuIchVrSwtppHPW39kU+w5wBMa5EhdBTceT8E9LwZBv9QWH3
        Ut2mK7crcoIMK6YkX8+Lqg76UINFvGb1TlOEAvmyjQ==
X-Google-Smtp-Source: AA6agR6illJXJezPnUlYRSvrzzoS5CAYf4IUEm95n/U6inIK5fOcXEH6F1mNmBMwtsRq0xclG5MWykhUOUCpEetI2Pg=
X-Received: by 2002:a05:622a:1013:b0:344:5b66:fe15 with SMTP id
 d19-20020a05622a101300b003445b66fe15mr5314154qte.66.1660580947982; Mon, 15
 Aug 2022 09:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <CABMhjYp3xUyQ9q6nXHvEA2zuzhYi0ETn6UETeH1apWf2n2eP7A@mail.gmail.com>
 <7ba0c325-bc1f-f6e4-dd8a-b5d13a04ef93@microchip.com> <CABMhjYrDyOoDusE4-y4VzM87Vg=NhPbow_dQ+1C4EcX50LrMHw@mail.gmail.com>
 <fb861221-2e9d-7d4a-dd52-b16b3b581fd6@microchip.com> <dd128dec-6092-7aeb-6e66-eb45cea3b0cd@microchip.com>
In-Reply-To: <dd128dec-6092-7aeb-6e66-eb45cea3b0cd@microchip.com>
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Mon, 15 Aug 2022 09:28:57 -0700
Message-ID: <CABMhjYrB+Qn9ZuJ3Lqpu0KVFGeg6avxkYqD=SQWyLjdQ3wSpjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: sifive: fix dt-schema errors
To:     Conor.Dooley@microchip.com
Cc:     palmer@rivosinc.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor,

Thanks -- really appreciate the help. Dell had to come out twice to
fix my laptop, and it's finally done (hopefully), but moving back and
forth between  the different distros has been really disruptive.


On Tue, Jul 26, 2022 at 9:42 AM <Conor.Dooley@microchip.com> wrote:
>
> On 01/07/2022 21:00, Conor Dooley wrote:
> > On 01/07/2022 20:49, Atul Khare wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> Conor,
> >>
> >> Apologies for the delay, but my laptop died a couple of weeks ago, and
> >> I have been scrambling to get things up and running on the
> >> replacement. I will try and get back to it ASAP.
> >
> > Nothing you can do about your laptop dying :)
> >
> >
>
> Hey Atul,
> Been another couple weeks so I am going to send a v3 of these
> patches (although without any changes to the v2) and we can
> resume discussion about the cache binding change there.
> Thanks,
> Conor.
