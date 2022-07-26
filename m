Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F43581A75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiGZTrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGZTrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:47:13 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0937240A1;
        Tue, 26 Jul 2022 12:47:12 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g24so11259056qtu.2;
        Tue, 26 Jul 2022 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MAfdgifMMcfE/yXjpXpDSHvlhww07gmdGSC9ysTyuKc=;
        b=EFEbG43P2uz2lGXat4fyCPRM6thWWiiPkREsQpPN9+O/mqwyPckmqGwpoViHGCerJi
         QJlsMvlsxh9syDqBgncXxRlxo6namrgimntsHIOnjDl5VHWOb/6Pw1w+awTQ/s1YI8U7
         C0o4IGmuShLE0ehpCGpGPtG7QgQ9YxUt+1VNHrhgbgRs4dKUUb3kEeJNsfedphWsxX6R
         0z0KnBSoQoGh8XTvTM0iDMVL0XcqJaGh4RJMCGvzFyQfHvXOvsIVwdmnLw1zqNr1sBYL
         wyf+aFwi7hX1MRVi0Ko/r3NbFh8Vd1gweAUuErvI7HfPlvI+4Xmch/7b7qkPWiyYkrPA
         xayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=MAfdgifMMcfE/yXjpXpDSHvlhww07gmdGSC9ysTyuKc=;
        b=lI34dTy2z29iOvBFe3h+BVCoe4MC85e9R0NquB+FlqbaSYxPdSXbDocYlFGQMjaFRt
         fmn/y8bTgqm6WFdUhZ/sTT58rmDLdvMl9Wvtyvb8aW4/Pv0h6arYLo9SX6v7TwR74VxT
         yLSKyyZw08tLDlHoiHEURkFeCAMSrytPowEQ8+YfuQAS7UA3tAS0cpe7ysnI1pPc224g
         m+e4eQnlxd0O6n+GDXrObY/PYAbBSl9fj6mW8JT5cxBAM2BIoi1nGbtX4445jBMvPlXu
         FH+2LleHQLABpMWxcbiJEe6zNgDiowhUgz1Mhc8HLb8Q21sAdevRaTBYjDO+9oy/bTYe
         meZw==
X-Gm-Message-State: AJIora88DicRY6ZwFi+WJ3MwjnvngRDakTaK7pEiVmKkYURO0aPOSEug
        vrOfpHzNgoeWnjHgQhYdtw==
X-Google-Smtp-Source: AGRyM1tue0AfzJLG/Yn1jOuSrSPoqrsACDpveUi3WRkpV2rVPonkxoGaJ7hxgOnC0yfQXb79hjIKSg==
X-Received: by 2002:a05:622a:109:b0:31f:3302:3367 with SMTP id u9-20020a05622a010900b0031f33023367mr12518641qtw.488.1658864831713;
        Tue, 26 Jul 2022 12:47:11 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006b5e50057basm11427786qkj.95.2022.07.26.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 12:47:11 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:495f:ee54:913c:d540])
        by serve.minyard.net (Postfix) with ESMTPSA id 21AE81800D9;
        Tue, 26 Jul 2022 19:47:10 +0000 (UTC)
Date:   Tue, 26 Jul 2022 14:47:08 -0500
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
Message-ID: <20220726194708.GO3834@minyard.net>
Reply-To: minyard@acm.org
References: <20220717121124.154734-1-tmaimon77@gmail.com>
 <20220718125155.GA40038@minyard.net>
 <CAP6Zq1haOErfj2HZkqKwXZKr3+QvWP2VYK6QQOH5cjHYJ2rV0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1haOErfj2HZkqKwXZKr3+QvWP2VYK6QQOH5cjHYJ2rV0w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:41:38PM +0300, Tomer Maimon wrote:
> Hi Corey,
> 
> 
> On Mon, 18 Jul 2022 at 15:51, Corey Minyard <minyard@acm.org> wrote:
> >
> > On Sun, Jul 17, 2022 at 03:11:22PM +0300, Tomer Maimon wrote:
> > > This patch set adds Arbel NPCM8XX Keyboard Controller Style (KCS) support to
> > > KCS NPCM driver.
> > >
> > > The NPCM KCS driver tested on NPCM845 evaluation board.
> >
> > This seems reasonable, I've pulled it into my tree.  If anyone has any
> > issues with this, please respond.
> >
> > -corey
> >
> > >
> > > Tomer Maimon (2):
> > >   dt-bindings: ipmi: Add npcm845 compatible
> > >   char: ipmi: modify NPCM KCS configuration
> > >
> > >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 5 +++--
> > >  drivers/char/ipmi/Kconfig                                  | 6 +++---
> > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > >
> > > --
> > > 2.33.0
> > >
> 
> Sorry but I need to do a little fix in the document file.
> 
> Can I do it or have you already applied the patches?

At this point I'd prefer a patch on top of what is there.  5.19 isn't
released yet, so the window isn't open, but that will happen soon and I
don't want to rebase at this point.

-corey

> 
> Thanks,
> 
> Tomer
