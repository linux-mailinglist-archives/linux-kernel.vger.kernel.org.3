Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12225829EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiG0PrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiG0PrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:47:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567922299;
        Wed, 27 Jul 2022 08:47:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c20so12904328qtw.8;
        Wed, 27 Jul 2022 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rKRkz1r3/CKmoOGWsptt41HcBfvgNG2KAxM3cUlyRgg=;
        b=VoB86KfUBj/OZpm9xIVznbBQgZc4uhxKvVqM6lBqGHVxY4BRsFuuc3xlU3sMxZvcWa
         4b8ibsPfgRsNd5aIAwrY7NssOu/jUVv3lLJDGVPa6vRidh5+LMt14tCMnn1XwZLBFp+O
         HQ+Tj+xaYFKZ7w8ImT5JLW2a/FZn2lAizet0UGek3kuZgKbaK7WyoezQ8YGBsO8CqdJ1
         EjYv/CNb2NbNMBeCTv9ZteUxUViXcld1dSsU03u5kcWMpLMWMZYO0GH+RqTQJOpRT0K7
         sWi/+E8fjLR9kw8t4Qs+GVWY5Hcq0BKNIHpf3iWNYd5XZjYbecqJl8L+vRAphnxKscDy
         E1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=rKRkz1r3/CKmoOGWsptt41HcBfvgNG2KAxM3cUlyRgg=;
        b=HgSYz2mpjNDuCKJGm/ufh63qzUIqY/DRNRL3KZlKwA0T3pWB6POEV7c2X1MKBjZqyR
         2Ux06PQIWQJ35+9nDVCTEgJAECLfPcueGzvsXurnNa8XxbpFQtQhqqVtVrIGYk41EDps
         4lDPeta0NaFntZQI1bAzG9/5xUPwtPnkDw2W5DRtlW/ArEE5bPz4MvtmD5LdgHlW3PBV
         W7sC7aOU/GmWiZpQ6qeaFXvTH4RXawJz9WnBgO+OoAWtnxDEoiWvg2yt1ALZHw8fDV/W
         hlXAUkmc2ftgpbRBHoSRj7kqBmanPRCcJS/9kG9UJ3TaRuPznJkficrZ9jlVydG6wgTe
         BedA==
X-Gm-Message-State: AJIora8Y49hJ85okr9VO5yDhhrmKQjZIt2GMKTBQu3lmGDRtfUSG5GbJ
        bwMx/CgJaJ+NyKKkEyPjRw==
X-Google-Smtp-Source: AGRyM1syoHp48BJmUDOkb6xY/O5snpMs1dVQsCfX28eSSiv/YiQUo0sVB6pmKfpcMiJUw10Xvbbbnw==
X-Received: by 2002:a05:622a:1316:b0:31e:f3b4:1c8c with SMTP id v22-20020a05622a131600b0031ef3b41c8cmr19396972qtk.339.1658936823961;
        Wed, 27 Jul 2022 08:47:03 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id de39-20020a05620a372700b006b568bdd7d5sm14091459qkb.71.2022.07.27.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:47:03 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:495f:ee54:913c:d540])
        by serve.minyard.net (Postfix) with ESMTPSA id AF322180052;
        Wed, 27 Jul 2022 15:47:01 +0000 (UTC)
Date:   Wed, 27 Jul 2022 10:47:00 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
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
Subject: Re: [PATCH v1 0/2] char: ipmi: kcs: add Arbel NPCM8XX support
Message-ID: <20220727154700.GS3834@minyard.net>
Reply-To: minyard@acm.org
References: <20220717121124.154734-1-tmaimon77@gmail.com>
 <20220718125155.GA40038@minyard.net>
 <CAP6Zq1haOErfj2HZkqKwXZKr3+QvWP2VYK6QQOH5cjHYJ2rV0w@mail.gmail.com>
 <20220726194708.GO3834@minyard.net>
 <CAP6Zq1hHXiZw2a6+o30N-GUhcA_ZJoYH+wZa8AzLu3NmYST+kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1hHXiZw2a6+o30N-GUhcA_ZJoYH+wZa8AzLu3NmYST+kw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:39:08AM +0300, Tomer Maimon wrote:
> Hi Corey,
> 
> On Tue, 26 Jul 2022 at 22:47, Corey Minyard <minyard@acm.org> wrote:
> >
> > On Tue, Jul 26, 2022 at 10:41:38PM +0300, Tomer Maimon wrote:
> > > Hi Corey,
> > >
> > >
> > > On Mon, 18 Jul 2022 at 15:51, Corey Minyard <minyard@acm.org> wrote:
> > > >
> > > > On Sun, Jul 17, 2022 at 03:11:22PM +0300, Tomer Maimon wrote:
> > > > > This patch set adds Arbel NPCM8XX Keyboard Controller Style (KCS) support to
> > > > > KCS NPCM driver.
> > > > >
> > > > > The NPCM KCS driver tested on NPCM845 evaluation board.
> > > >
> > > > This seems reasonable, I've pulled it into my tree.  If anyone has any
> > > > issues with this, please respond.
> > > >
> > > > -corey
> > > >
> > > > >
> > > > > Tomer Maimon (2):
> > > > >   dt-bindings: ipmi: Add npcm845 compatible
> > > > >   char: ipmi: modify NPCM KCS configuration
> > > > >
> > > > >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 5 +++--
> > > > >  drivers/char/ipmi/Kconfig                                  | 6 +++---
> > > > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > > > >
> > > > > --
> > > > > 2.33.0
> > > > >
> > >
> > > Sorry but I need to do a little fix in the document file.
> > >
> > > Can I do it or have you already applied the patches?
> >
> > At this point I'd prefer a patch on top of what is there.  5.19 isn't
> > released yet, so the window isn't open, but that will happen soon and I
> > don't want to rebase at this point.
> O.K. thanks,
> I will wait until 5.19 is released and then I will send the patch.

Oh, sorry I wasn't clear.  You can send it now, I just don't want to
rebase what I have already.  Just a new patch on top of it, and I'll get
it in to 5.19.

-corey
