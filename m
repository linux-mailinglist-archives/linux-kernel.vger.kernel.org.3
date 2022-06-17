Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782254FBCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiFQRAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFQRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:00:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C086A3054F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:00:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b8so6932284edj.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iE5OYluhOlLYmCxuJVh+ozmHKah+06JaPO4OAH+rP5I=;
        b=dXtqDKVQ9Xm7BzEXh0Vo1XCT3DGI0YbjEAvcNhmAsbk5qi2bpUyZ5uzs/iLMjFzRha
         gT/SiiG+hFi/3uC61x1i9318bgqLsc5yU4SOVCKrrXlXnCoYcWoI5CjENDvaXhxAX/QN
         SZbZXbLa+Dv1azY7wP++VbCbdbzlaEvIZZ7xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iE5OYluhOlLYmCxuJVh+ozmHKah+06JaPO4OAH+rP5I=;
        b=SHTVWRxUKYtTFS7y1hFb9lxz9ja7pD9QBukFigotwyJUI0tAtTgKtcEbzc9TxV5YwR
         1BWmYudz6tpk0cjbd+ScYeidaOHUen2f50tM069GQDHntG8m7L7qRk5ZUKerPmVv44Ys
         jhUzJYpUlkLHVK5ym5LDLgtV4FDKPU8l+DiqGmaZxpIsLLX9MFauBfhcjWAUWbU1r5/a
         law5UHOgFWVAvk7QEwMG+E+zf41ODtiXg/+aZ7rtvMXmF1KmIG/62pYsYYomPz36QAjJ
         VRBYgQhg0woH+lMSm+uTJjd5kyiW5KM4ip8/3fjKgqoClj5+BwW+c5Hj9vv0zqO45aRM
         H1Cg==
X-Gm-Message-State: AJIora8+nsOw8AU1bicGto6/e03A/JVc8kbq/WMtA+h1n4LvLReaQAaD
        uCHy0+B//g9m8gFLupx4pRbaKNuh9NfyHaP/
X-Google-Smtp-Source: AGRyM1tbka0tI0cJP8tJYGYpXexTh1mavUhpIw6YzgJ01IOXu9XG1/tln43CUccCPfE10WR8nBmyIg==
X-Received: by 2002:a05:6402:3886:b0:435:643a:b7ae with SMTP id fd6-20020a056402388600b00435643ab7aemr3824763edb.4.1655485207956;
        Fri, 17 Jun 2022 10:00:07 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id y24-20020a056402135800b0042dce73168csm4015298edw.13.2022.06.17.10.00.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 10:00:07 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so4674254wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:00:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr11311533wmq.8.1655485206627; Fri, 17 Jun
 2022 10:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <Yqw4Jujzz5ZzZ2Wg@kroah.com> <Yqywy+Md2AfGDu8v@dev-arch.thelio-3990X>
In-Reply-To: <Yqywy+Md2AfGDu8v@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Jun 2022 09:59:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh59Decy5ksYBW1kD2pmcgo8T0JdKa37iaeaEO5LUN62g@mail.gmail.com>
Message-ID: <CAHk-=wh59Decy5ksYBW1kD2pmcgo8T0JdKa37iaeaEO5LUN62g@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.19-rc3
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Fri, Jun 17, 2022 at 9:50 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> I think you tagged the wrong branch (char-misc-next vs. char-misc-linus)?
> The commits below do not match the tag description above.

Good catch. I verified the diffstat etc, but yeah, the actual
explanation in the tag doesn't match the contents.

It's pulled now, and the code changes look fairly harmless, but I
suspect Greg will want to send a real pull for the changes that were
intended to come in here..

                   Linus
