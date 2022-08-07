Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0922158BAC7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiHGMLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 08:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiHGMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 08:11:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9702BF50;
        Sun,  7 Aug 2022 05:11:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v1so4771711qkg.11;
        Sun, 07 Aug 2022 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc;
        bh=zQGkdKu5K+mMGtINb8IUwXhsmEcLqR+snZ46Vc8nWxk=;
        b=X8rltdjmNBHQeJgcjT5qKvzBk79eACG1asdlFesZiy6mpB7LeCJF7SKsbdbpwbbRGU
         L5JPWtm6ii7OHXAzUWdcpmbBkfv9U6p1dxIbRbxH0ypFHqyTDdp5hx+UgzNqLvo3kt/q
         id4+yVLZ6A9XqLg4LE5kn5bB6eCDMWaXeK5W4IwzFhzV310nTnhLk4m1lBrYmCz5n3Ye
         ewSU1EmiL4x5YlqhdlFo7BTHk3sBl9jJj3NmnOirRC5pG9IBweefeZw3NBV6JpUoKHCY
         sPLKEk8/am2VcYKbwolANziEuKRbNbGGRN+bvhbPgQL9e+Mum1TwIOeuzII7ALtG4bfd
         yzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc;
        bh=zQGkdKu5K+mMGtINb8IUwXhsmEcLqR+snZ46Vc8nWxk=;
        b=YZNc9sascoXrx+qZZYc/chycZEqYqBcoxnf5kcRCpFqtUVS5hcGlQA2pr/NbyEmXVC
         WwlWuL1fOC3U6bcUO5KnrxrMFoYwhmqVv4Hc7m826pC0GdkjflLbH8Sj6t5bu36ueILS
         BkukxnMRTj5G9hWwfC7CJyX3O0X28pXBuA1KE9eugexP0YwnYdqbNccni/aWUVWXjvj5
         1/yZPOq0t9qUBObjZiDVU2dSpFbHyUdJ9YOK6fEey1Dv4tc8XgO4XEsNdmqnuXJedgLx
         7kQc3BbPfQvGOwCRQR38vgdT+QQhiz98Yx5utOdSlwKm0ehmpTjh57e8YP4pyqXf5Pic
         LofA==
X-Gm-Message-State: ACgBeo2AufVBSRETOvYB6zPFG47a8PSc9JzWVxM/ZhWoMD5ox0LoYM36
        HTE6ZA4eFBfJWDtFc4Jg5g==
X-Google-Smtp-Source: AA6agR6tyvVQVxivjpXI2f1/rmVg+DidYfAL1meKadBKrz4FxbrEPGrSK2B9b9rWSowTqapwQ782xQ==
X-Received: by 2002:a05:620a:460c:b0:6b8:fbfd:b963 with SMTP id br12-20020a05620a460c00b006b8fbfdb963mr11002856qkb.140.1659874301700;
        Sun, 07 Aug 2022 05:11:41 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id y8-20020a37f608000000b006b66510f4f7sm6896108qkj.6.2022.08.07.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 05:11:41 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:18ee:4123:89ce:5c5d])
        by serve.minyard.net (Postfix) with ESMTPSA id B96051800FA;
        Sun,  7 Aug 2022 12:11:39 +0000 (UTC)
Date:   Sun, 7 Aug 2022 07:11:38 -0500
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
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Message-ID: <20220807121138.GL3834@minyard.net>
Reply-To: minyard@acm.org
References: <20220804181800.235368-1-tmaimon77@gmail.com>
 <20220805115827.GG3834@minyard.net>
 <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2022 at 11:03:56AM +0300, Tomer Maimon wrote:
> Hi Corey,
> 
> Thanks for your comment.
> 
> On Fri, 5 Aug 2022 at 14:58, Corey Minyard <minyard@acm.org> wrote:
> >
> > On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
> > > Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> > > string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> > >
> > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > index cbc10a68ddef..4fda76e63396 100644
> > > --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
> > >  Required properties:
> > >  - compatible : should be one of
> > >      "nuvoton,npcm750-kcs-bmc"
> > > -    "nuvoton,npcm845-kcs-bmc"
> > > +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
> >
> > This is just wrong.  The compatible is supposed to identify the device,
> > not the board the device is on.  I think compatible here should be
> > "npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is
> > used on a board named npcm845.
> The NPCM8XX is not a board, The Nuvoton NPCM8XX is a fourth-generation
> BMC SoC device family.

Ok, but same principle applies.

If the device is exactly the same, then you would only use one of the
"npcm7xx-kcs-bmc" and put that in both device trees.  You can use
"nuvoton,npcm750-kcs-bmc", it's really not that important.  Or even
"nuvoton,npcm-kcs-bmc"

If the device has a minor difference that can be expressed in a 
parameter, then create a parameter for it.

If the device has enough differences that a parameter or two doesn't
cover it, then you put either nuvoton,npcm750-kcs-bmc or
nuvoton,npcm750-kcs-bmc in the device tree.  Not both.  Then you need
two entries in the of_device_id array and you use the data field or
something to express the difference.

Since there appears to be no difference, just put
"nuvoton,npcm750-kcs-bmc" in the npcm845 and I will drop the patch
adding all this.  Then a patch can be added saying it applies to both
the 7xx and 8xx series of BMC SOCs.  If you want to change the name,
then a patch will be needed for that, but then you will need multiple
entries in your device tree, but you would not document it as such, as
there would only be one that applies for this kernel.

I'm pretty sure the only reason to have muliple compatible entries in a
device tree is to cover multiple kernels where the name changed.

-corey

> >
> > -corey
> >
> > >  - interrupts : interrupt generated by the controller
> > >  - kcs_chan : The KCS channel number in the controller
> > >
> > > --
> > > 2.33.0
> > >
> 
> Best regards,
> 
> Tomer
