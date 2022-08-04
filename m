Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7881589DF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbiHDO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiHDO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:57:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC281CB25;
        Thu,  4 Aug 2022 07:57:17 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c17so12680179lfb.3;
        Thu, 04 Aug 2022 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8JNbodMueoEd4ImyROxuslz2NcHFXRVvVz0CY4xXL6Q=;
        b=bUH+Fm34iVCV0p1rnEdX7I6T1s493igT+HExDi/8Bhg86px9EzTwZTVvUSbf23x0of
         mUq+/03uJNyMCFifoCjpjyuHVsojpxUnto7vAtLNf6K34nXhpCkorYve4tN9A0x1IN+j
         7BzjyLh0v7qiC4xxeyC0Nqz9xefm77pozxJFiUCQLTKO5B0jpb5LLj2+twXU/M8SGVEN
         SL/qH7MYCFzgUxfeNB9Uq7GsDPBCSMVr+gMTlehGk1R5bHihdhOhNtJ8IR7cEJoSIFJV
         wCz/688Im08X6cSOzhAuLEmrg2elXqS1NKam5DRQsQr1Bm9kVLcdvnK7PGcvf+vyR6jS
         dDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8JNbodMueoEd4ImyROxuslz2NcHFXRVvVz0CY4xXL6Q=;
        b=M94KwqC39BpdUh2NV4WCRkhT8tGZrsbRnSvDHbBnIxQGOSA5SGgkfjQZ2rcaEog8/3
         Yog3p8tjngdKu2icwYA2p2W0zFzkE3Ty1kZUtFGJFsgFwqzPTbaMySLfIdDiZJbTeiHU
         Gpb1cF8+Y94elLRClIxMP84aECCsKhgEYqHOr4WzT+xxviZcKBWZCWh3dxiT9mghchOq
         ad+rdvRoPNLaDoCKCmLPhQRLnG4QgmYuWY6BsRBuGIcqjXE6Qv+aTaJn3BrTz58F2yyG
         yyGMpz2modbNYhdGDuIsHmKOZuwmeooO49Q+sUrCAw7ecX73wY8LfBbcQgmeRM3hajRg
         ExdA==
X-Gm-Message-State: ACgBeo1RdVfjF8wF5OO4gnteu+NBDYU2bQ+DB3aMF/St0uw3xUhHe6XY
        QfbnGCFETYAWpN5rVkfcxjtuhMzFLJO0grtsmSs=
X-Google-Smtp-Source: AA6agR7OOuSag4FDjo6Dbl4xoBFIuVP0LQIgpdmgsRMbcMKMGKSS86wDo0KAR/8Kfe7Qgrw6h0G1IyqONkTOqsC5PMY=
X-Received: by 2002:a05:6512:3990:b0:48a:ae02:1000 with SMTP id
 j16-20020a056512399000b0048aae021000mr787247lfu.401.1659625035106; Thu, 04
 Aug 2022 07:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220717121124.154734-1-tmaimon77@gmail.com> <20220718125155.GA40038@minyard.net>
 <CAP6Zq1haOErfj2HZkqKwXZKr3+QvWP2VYK6QQOH5cjHYJ2rV0w@mail.gmail.com>
 <20220726194708.GO3834@minyard.net> <CAP6Zq1hHXiZw2a6+o30N-GUhcA_ZJoYH+wZa8AzLu3NmYST+kw@mail.gmail.com>
 <20220727154700.GS3834@minyard.net>
In-Reply-To: <20220727154700.GS3834@minyard.net>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 4 Aug 2022 17:57:03 +0300
Message-ID: <CAP6Zq1gQkoRqMc2+7ZDjwdyyfAhF+PuNjSQfSSS7yQojXS__mw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] char: ipmi: kcs: add Arbel NPCM8XX support
To:     minyard@acm.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

Sorry, miss this email...

On Wed, 27 Jul 2022 at 18:47, Corey Minyard <minyard@acm.org> wrote:
>
> On Wed, Jul 27, 2022 at 08:39:08AM +0300, Tomer Maimon wrote:
> > Hi Corey,
> >
> > On Tue, 26 Jul 2022 at 22:47, Corey Minyard <minyard@acm.org> wrote:
> > >
> > > On Tue, Jul 26, 2022 at 10:41:38PM +0300, Tomer Maimon wrote:
> > > > Hi Corey,
> > > >
> > > >
> > > > On Mon, 18 Jul 2022 at 15:51, Corey Minyard <minyard@acm.org> wrote:
> > > > >
> > > > > On Sun, Jul 17, 2022 at 03:11:22PM +0300, Tomer Maimon wrote:
> > > > > > This patch set adds Arbel NPCM8XX Keyboard Controller Style (KCS) support to
> > > > > > KCS NPCM driver.
> > > > > >
> > > > > > The NPCM KCS driver tested on NPCM845 evaluation board.
> > > > >
> > > > > This seems reasonable, I've pulled it into my tree.  If anyone has any
> > > > > issues with this, please respond.
> > > > >
> > > > > -corey
> > > > >
> > > > > >
> > > > > > Tomer Maimon (2):
> > > > > >   dt-bindings: ipmi: Add npcm845 compatible
> > > > > >   char: ipmi: modify NPCM KCS configuration
> > > > > >
> > > > > >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 5 +++--
> > > > > >  drivers/char/ipmi/Kconfig                                  | 6 +++---
> > > > > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.33.0
> > > > > >
> > > >
> > > > Sorry but I need to do a little fix in the document file.
> > > >
> > > > Can I do it or have you already applied the patches?
> > >
> > > At this point I'd prefer a patch on top of what is there.  5.19 isn't
> > > released yet, so the window isn't open, but that will happen soon and I
> > > don't want to rebase at this point.
> > O.K. thanks,
> > I will wait until 5.19 is released and then I will send the patch.
>
> Oh, sorry I wasn't clear.  You can send it now, I just don't want to
> rebase what I have already.  Just a new patch on top of it, and I'll get
> it in to 5.19.
>
> -corey

Sent a patch now.

Best regards,

Tomer
