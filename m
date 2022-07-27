Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA12581F96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiG0FjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiG0FjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:39:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0467E3B95B;
        Tue, 26 Jul 2022 22:39:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t1so25553943lft.8;
        Tue, 26 Jul 2022 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiljjiRdL3J7XgA9lRW8mh7Q8UMy2rckFdpaiD+6ujw=;
        b=NztSDmjZzcPZTSmd5mq8HZlLFMGzHBXihUfv2sk5AX6Sm+oTSk2v97ABQJmVcRKGCr
         nI7dnqm4kSht8qcX+gw4Q8cSGhYGf1bjKvSyIlN9SlgqU59J9Ul56QJLCovYcBnfmJRD
         q6aLBlqsk7zmebygt0OPCeF5TLKGokvEcikOnaCurlpsi+kPxbBWQrZuG1kqY21lmCcZ
         3xF9QLcn1wTH5Aw6y8NGMxumMK6ob4Yp4Odcw9uoMz45IJ5PJAb6xDLzXVmKOb/f79pv
         oVNGbJSXYKtNM4EOmduPLzVooWUbOD9Ly63UwrLi11GBnoMikbrVq7T5U6J/Xx64KBWO
         fmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiljjiRdL3J7XgA9lRW8mh7Q8UMy2rckFdpaiD+6ujw=;
        b=OQzeH+sxY0XqUDhh7BpL4mOZa8qa9b0+sPHq7B+dSBooCdo/7+dC00ZWRlhRasho68
         tBQEQSB8WATx04lQ0p8SmsJ9EWkTGQrejEFeH548S7hO3+GnbkC40EpGUfb8Un4l8pLo
         Rz4azubXd/IU+4PAYCtODKhyiXIetfHE/TrpUatzpHOFIsGdVJ7kiAIfFTU2WuxiBKhj
         Ac3HvZ40Z7Kx1pt0Z/c4u0ipSoU6GdmJwH5JIlQ6brVQb9acmm/Kw2qh84VtkkwfEk3J
         3QItcKhmKKbMYmJZuShYP2N+vLGAgp7RIMQFytLt2G7Rz+Y5JqhLwoffFCSizSFTW5gf
         f6qA==
X-Gm-Message-State: AJIora/P7RG4SJPdd1eAnaA7IJNLpJwth4cpUZpXlgNNizxHkbDFtJyv
        souG/rCwbQxeGHdfQcFVvh0PH6lZQQ86zn+C/Gs=
X-Google-Smtp-Source: AGRyM1sj7CHKLLCJA3ZngRRcjw+xywD9YKDbSReMjh5p7lbqdpuRzGLay2un7mt8GHo/w/Z9ge1Msi88eyTx3z6We6w=
X-Received: by 2002:a19:6d0d:0:b0:48a:8b3c:e28 with SMTP id
 i13-20020a196d0d000000b0048a8b3c0e28mr4826021lfc.265.1658900360081; Tue, 26
 Jul 2022 22:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220717121124.154734-1-tmaimon77@gmail.com> <20220718125155.GA40038@minyard.net>
 <CAP6Zq1haOErfj2HZkqKwXZKr3+QvWP2VYK6QQOH5cjHYJ2rV0w@mail.gmail.com> <20220726194708.GO3834@minyard.net>
In-Reply-To: <20220726194708.GO3834@minyard.net>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 27 Jul 2022 08:39:08 +0300
Message-ID: <CAP6Zq1hHXiZw2a6+o30N-GUhcA_ZJoYH+wZa8AzLu3NmYST+kw@mail.gmail.com>
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

On Tue, 26 Jul 2022 at 22:47, Corey Minyard <minyard@acm.org> wrote:
>
> On Tue, Jul 26, 2022 at 10:41:38PM +0300, Tomer Maimon wrote:
> > Hi Corey,
> >
> >
> > On Mon, 18 Jul 2022 at 15:51, Corey Minyard <minyard@acm.org> wrote:
> > >
> > > On Sun, Jul 17, 2022 at 03:11:22PM +0300, Tomer Maimon wrote:
> > > > This patch set adds Arbel NPCM8XX Keyboard Controller Style (KCS) support to
> > > > KCS NPCM driver.
> > > >
> > > > The NPCM KCS driver tested on NPCM845 evaluation board.
> > >
> > > This seems reasonable, I've pulled it into my tree.  If anyone has any
> > > issues with this, please respond.
> > >
> > > -corey
> > >
> > > >
> > > > Tomer Maimon (2):
> > > >   dt-bindings: ipmi: Add npcm845 compatible
> > > >   char: ipmi: modify NPCM KCS configuration
> > > >
> > > >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 5 +++--
> > > >  drivers/char/ipmi/Kconfig                                  | 6 +++---
> > > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > > >
> > > > --
> > > > 2.33.0
> > > >
> >
> > Sorry but I need to do a little fix in the document file.
> >
> > Can I do it or have you already applied the patches?
>
> At this point I'd prefer a patch on top of what is there.  5.19 isn't
> released yet, so the window isn't open, but that will happen soon and I
> don't want to rebase at this point.
O.K. thanks,
I will wait until 5.19 is released and then I will send the patch.
>
> -corey
>
> >
> > Thanks,
> >
> > Tomer

Best regards,

Tomer
