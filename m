Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834905A3664
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiH0Jmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiH0Jmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:42:31 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694396FF8;
        Sat, 27 Aug 2022 02:42:31 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id p48-20020a4a95f3000000b0044b0f5a8d17so675460ooi.0;
        Sat, 27 Aug 2022 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=rqXbDU0e1tN4j5qNVRfAuljmb4yEN9erSBSwCMYT9p4=;
        b=ClMxVp+vwHXZuCvXg9uAgklzyD8SdlevrrCBTD0YEFrqGGPCOFJzyyISmPpuF27pqp
         Gg0k14dwf5ws2PSjWdiX8zm1tWEgYY9jMXoQcCFeSPe3aHRLDD1DK0ubptEBXt4e5AWX
         /ycS1tINPMWt6jWr43uERP3X097Qh/yRP61wdaUbDXIHSGc5OF1pqZpJ4Dll0iY/ukrO
         8P+J+gHcWofpYWC938hYiu0BNJ08y/EQIqch3XMlEIZqHjBo6aweYjCNjYIexL5VsNMK
         cURhZ7AUK1um6itvwquxmRr2FiIf0NFIy1q8ehRKrOx7UKgnat9IuEPRyFlqxKipye9A
         N6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=rqXbDU0e1tN4j5qNVRfAuljmb4yEN9erSBSwCMYT9p4=;
        b=zqrG5fhYw4LnYDg+4LsiNKnd1AcllaA76lemVygAcbE5WZPfO7L+QECRsQrg3bQTAQ
         Pr8dCLRZalT2uVdxmSprW2xhwqcHWIRPZHH01Uh6YtPdBeHfdXNrF4z8hpNx9BjCRq9g
         QngTV5H3EztQ7hpU6ehKTwpBNhIyqydlSn8koF95HCGbPLuBdVTxCs+bNgYp5NmREDLP
         5+odBhJK/45zjduCp7XRTYgSC5ugWG6q6e20dGu2jUyiqWK7vem5mdwUX7Lu4676kKC0
         YtZhKsVkSqpKcbltbhJvBUsIhIntz90OyBDAMERZ/6dcV02VAmlmMHw+y8AHaCuhieR/
         Vo7g==
X-Gm-Message-State: ACgBeo0SKYAeK/Av2bH5+TJcrOnJo0De7lEhuTHNJqu5+BkzsA+kkddM
        mvXa2eW4+JQPLNao5Za6s0mVQNzYvsK9MVhsNF0k7kje9Koi6g==
X-Google-Smtp-Source: AA6agR7B9I6t4g5X3YmiBGfhO1RGQqgDYZA8IWaaMnL2zcRgHEWvokmIMvvJe4Yh7jD5YugeIEhqZwAPSP+Qq9w1Y58=
X-Received: by 2002:a4a:d154:0:b0:449:681b:3e76 with SMTP id
 o20-20020a4ad154000000b00449681b3e76mr2496123oor.47.1661593350486; Sat, 27
 Aug 2022 02:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220822141110.17199-1-91tuocao@gmail.com> <YwORy3QMbRUSlBZE@kroah.com>
In-Reply-To: <YwORy3QMbRUSlBZE@kroah.com>
From:   tuo cao <91tuocao@gmail.com>
Date:   Sat, 27 Aug 2022 17:42:19 +0800
Message-ID: <CAEVeK2AiYFK9eopn1Uzp+osA-j22e1KbfUohJ+hRVmLNsq0gpQ@mail.gmail.com>
Subject: Re: [RESEND] serial: 8250_bcm7271: move spin_lock_irqsave to
 spin_lock in interrupt handler
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, whether it's spin_lock_irqsave() or spin_lock(), the security is
the same. Since this commit:e58aa3d2d0cc01ad8d6f7f640a0670433f794922,
interrupt nesting is disabled, which means interrupts has disabled in
the interrupt handlers. So, it is unnecessary to call
spin_lock_irqsave in a interrupt handler. And it takes less time
obviously to use spin_lock()=EF=BC=8Cso I think this change is needed.

Finally, I'm sorry I lacked real hardware to verify it and can't
provide changelog text.

Thanks.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=80 22:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 22, 2022 at 10:11:10PM +0800, Tuo Cao wrote:
> > it is unnecessary to call spin_lock_irqsave in a interrupt handler.
>
> Yes, but it is safer to do so, right?
>
> Why is this change needed?
>
> Did you test it on real hardware to verify it works?
>
> We need a lot more information in the changelog text before being able
> to accept this.
>
> thanks,
>
> greg k-h
