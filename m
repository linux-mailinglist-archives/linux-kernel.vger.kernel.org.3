Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816AE5167A9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354307AbiEAURP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiEAURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:17:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CEA329BC
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 13:13:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so22328544lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Af6YvJ/bQ4g0cZpEqaiRxER9UMLmWrxLeH8xi992H8w=;
        b=Sn+yCF7EzbvgA/RjBCegCyU8kaRy8zPQSxaZwU2XAcJmTDp4VEbJ2sCYxrfSt1c1u5
         IufXI1t12+Qu88WHdcO7wOZFTQlFHaYMCw6GX0CY8KCzM1jgKYpLSJMfEY0fARJy/ODr
         x2RnI7DyeqZ3Y0Kg/iLNnjMl1mrfX/zKJ3c1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Af6YvJ/bQ4g0cZpEqaiRxER9UMLmWrxLeH8xi992H8w=;
        b=ZitFtK78HO9Tohp7MWpisuSNQzJHqWF7f49MW2mhqTqcfB1lOENKKVIcA12bLzeJCY
         m7I8ll0T3RuC3bJPZ7YieBIT5UNG2C/RPPvQeTbxGkaPEurB8v+b0cfe5zFd+Rd6YxO3
         dLxvbioQWDhFjjL1YGx8faGEpA+9yPbsEulF0igGWptT2zJa0cIs2v7Mj25IA4/hofsI
         FSmdZkIJcMGmIlAIaZjRsJ2mtDYOTnipuBqojAzxH34NZ90Y706htw9j3Ltfb9P9J3/U
         etfXf/taq9KrOSg0hCTwnIfp++uKWext5MQyDxsWWlOwOIilFZQUVt++yTjgub248PDi
         n/tg==
X-Gm-Message-State: AOAM532WyGRCQgyYwGDVOFZuXYbu5EosbJNue4YVmBdaQ5gwOYPN+Jgp
        ppOw/fyAfTeogex1ozxD/G+R/8Mm0L8GZQ==
X-Google-Smtp-Source: ABdhPJw8YUtFVE+p6/o0pnqcRG5xv6+odD1NvLKmwkmhqHXOBq7/svtLvnXBgp0iNENlq/vPjBK+4g==
X-Received: by 2002:ac2:5cdb:0:b0:471:fd36:fa56 with SMTP id f27-20020ac25cdb000000b00471fd36fa56mr7148766lfq.501.1651436022216;
        Sun, 01 May 2022 13:13:42 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m16-20020ac24ad0000000b0047255d21170sm520733lfp.159.2022.05.01.13.13.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 13:13:41 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x17so22317949lfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 13:13:41 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr7168727lfh.687.1651436020874; Sun, 01
 May 2022 13:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFRbG=mGdbR72moLtW87ZQW_T1HkhZtcpHRGzZy3NZ7afGVqQ@mail.gmail.com>
In-Reply-To: <CAOFRbG=mGdbR72moLtW87ZQW_T1HkhZtcpHRGzZy3NZ7afGVqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 May 2022 13:13:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXp7Ps9ML5ThsX1tvdRg6SKRH3r6MM1-EA_Y8-n+6v2A@mail.gmail.com>
Message-ID: <CAHk-=whXp7Ps9ML5ThsX1tvdRg6SKRH3r6MM1-EA_Y8-n+6v2A@mail.gmail.com>
Subject: Re: [5.18.0-rc4+] report: kernel compile
To:     Ozgur Kara <zgrieee@gmail.com>
Cc:     linux-staging@lists.linux.dev, ozgurk@ieee.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 12:44 PM Ozgur Kara <zgrieee@gmail.com> wrote:
>
> Samsung RC530 (notebook) - FAIL (1)
> Raspberry PI Model B - FAIL (2)
>
> Fail Log:
>
> + nvidia driver fail.
> + scripts/Makefile.build:497: recipe for target 'arch/arm/kernel' failed

Is there full information available somewhere?

            Linus
