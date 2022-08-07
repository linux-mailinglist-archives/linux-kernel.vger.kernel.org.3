Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5558BBC4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiHGQFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHGQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:05:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B831A;
        Sun,  7 Aug 2022 09:05:49 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o1so4980609qkg.9;
        Sun, 07 Aug 2022 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc;
        bh=7uXlWgTEohYxQ85BoECVY/ep9kMm6DW6Jlta0tAZuF8=;
        b=EvHSbDNccf0snsRpgwYGhmLSWdQMVy+oeswA9ebG69tnbHOwO9NlY3PoOLjQT4BkGH
         /r3PLj7ywbrZeOhzqI6eH5Gmu7SBMh8hgvdV5q6c9rqjvnbvgJEk/1Uut0XQqAILbesQ
         SVXEJnwo2j3qbSkO0fkLZb4JkHKyqJ/DcDTqJAj2SgckTgnmQa4feQR76mxYwd0fN99P
         AulCq3TQx/wqxuYUg/VK+VxEu/tzkKeHD59iEX6uyek43aRXBqIc3lp5ZKJ2rLWBwdjc
         qDtKH2lEgi+YAxwyYDV+FlevhWc7bGMUeSYt3DOUO5mhPmS8lxiZbau4GvzyQTtENsWP
         1MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc;
        bh=7uXlWgTEohYxQ85BoECVY/ep9kMm6DW6Jlta0tAZuF8=;
        b=FSyG2MiRPpYDrwiDOWzYhmZbPAJMN8x/lQP+UL4jQ+7YNiFsOramcAfjq/Oh/6kGX1
         TeekfGHI1BUG73izYITnKargXiIRTWjPc2qb2iVGKWuYYnoXc+Y50kvbVKsHqJ6zf6Dx
         cSzk0qVpDNbNw9YSL5FFa9+xcjcsqr+9y6/RkzM1NUY3KufUKt+yNj3MzzfkIXBJYCTt
         tAaOCbIHFRVHnoFR0NVu52HCRcJYWrwgrOQOw+MpG1C2JizINfzpUlU5fPePg+OIUlSo
         /icRdxKdWm3TjwHSZTQcLi79ONQtB+onvqo2Y5l9qGEvf6kLdw44Up1z1nIJh+rjAtMk
         Yx5g==
X-Gm-Message-State: ACgBeo2GTUmTr9Lziuh8gKU8ySTWgd5m4JMi5HdsVBkS5q0CtFqTX/H8
        JizUZkB75Zkb1T62QJ1fWQ==
X-Google-Smtp-Source: AA6agR7W0fL0etBw0UI6nbPmKvtMZORG9mGYM35ublkn8y6s3O213D9Bej3/lrThwHkRKLA3SQFEPA==
X-Received: by 2002:a05:620a:4103:b0:6b9:3ee8:ed41 with SMTP id j3-20020a05620a410300b006b93ee8ed41mr3820288qko.264.1659888348837;
        Sun, 07 Aug 2022 09:05:48 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m22-20020ac866d6000000b0031f229d4427sm6206958qtp.96.2022.08.07.09.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 09:05:48 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:18ee:4123:89ce:5c5d])
        by serve.minyard.net (Postfix) with ESMTPSA id 0563E1800BB;
        Sun,  7 Aug 2022 16:05:47 +0000 (UTC)
Date:   Sun, 7 Aug 2022 11:05:45 -0500
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
Message-ID: <20220807160545.GM3834@minyard.net>
Reply-To: minyard@acm.org
References: <20220804181800.235368-1-tmaimon77@gmail.com>
 <20220805115827.GG3834@minyard.net>
 <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com>
 <20220807121138.GL3834@minyard.net>
 <CAP6Zq1iL7okjGU8_-CnrBnRUzjLKPD8FNw_oYso-jbthbeR1iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1iL7okjGU8_-CnrBnRUzjLKPD8FNw_oYso-jbthbeR1iQ@mail.gmail.com>
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

On Sun, Aug 07, 2022 at 05:54:28PM +0300, Tomer Maimon wrote:
> On Sun, 7 Aug 2022 at 15:11, Corey Minyard <minyard@acm.org> wrote:
> >
> > On Sun, Aug 07, 2022 at 11:03:56AM +0300, Tomer Maimon wrote:
> > > Hi Corey,
> > >
> > > Thanks for your comment.
> > >
> > > On Fri, 5 Aug 2022 at 14:58, Corey Minyard <minyard@acm.org> wrote:
> > > >
> > > > On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
> > > > > Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> > > > > string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> > > > >
> > > > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > > > index cbc10a68ddef..4fda76e63396 100644
> > > > > --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > > > +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
> > > > > @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
> > > > >  Required properties:
> > > > >  - compatible : should be one of
> > > > >      "nuvoton,npcm750-kcs-bmc"
> > > > > -    "nuvoton,npcm845-kcs-bmc"
> > > > > +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
> > > >
> > > > This is just wrong.  The compatible is supposed to identify the device,
> > > > not the board the device is on.  I think compatible here should be
> > > > "npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is
> > > > used on a board named npcm845.
> > > The NPCM8XX is not a board, The Nuvoton NPCM8XX is a fourth-generation
> > > BMC SoC device family.
> >
> > Ok, but same principle applies.
> >
> > If the device is exactly the same, then you would only use one of the
> > "npcm7xx-kcs-bmc" and put that in both device trees.  You can use
> > "nuvoton,npcm750-kcs-bmc", it's really not that important.  Or even
> > "nuvoton,npcm-kcs-bmc"
> If we use "nuvoton, npcm-kcs-bmc" we should take care of backward dts
> compatibility, and I am not sure we like to change NPCM KCS driver.
> >
> > If the device has a minor difference that can be expressed in a
> > parameter, then create a parameter for it.
> >
> > If the device has enough differences that a parameter or two doesn't
> > cover it, then you put either nuvoton,npcm750-kcs-bmc or
> > nuvoton,npcm750-kcs-bmc in the device tree.  Not both.  Then you need
> > two entries in the of_device_id array and you use the data field or
> > something to express the difference.
> >
> > Since there appears to be no difference, just put
> > "nuvoton,npcm750-kcs-bmc" in the npcm845 and I will drop the patch
> > adding all this.  Then a patch can be added saying it applies to both
> > the 7xx and 8xx series of BMC SOCs.  If you want to change the name,
> > then a patch will be needed for that, but then you will need multiple
> > entries in your device tree, but you would not document it as such, as
> > there would only be one that applies for this kernel.
> 
> It little bit confusing to use nuvoton,npcm750-kcs-bmc that are
> related to NPCM7XX for NPCM8XX KCS.

A little, but it's not unusual.

> We can use the generic name "nuvoton, npcm-kcs-bmc" as you suggested
> above but we should take care of backward dts compatibility, and I am
> not sure we like to change NPCM KCS driver.
> 
> We had a disscation with Arnd, Arnd asked us to use a fallback as we
> did here if NPCM8XX device module is similar to NPCM7XX module:
> https://lore.kernel.org/lkml/20220522155046.260146-5-tmaimon77@gmail.com/
> 
> I think we should use a fallback to describe the NPCM8XX KCS in the
> dt-binding document.

I'm ok with that option.  I guess I should have mentioned it.  Add
nuvoton,npcm-kcs-bmc to the driver's of_device_id table.  Then use that
in that compatible string in the device tree.  Leave the 750 compatible
string in the table for backwards compatibility.

There's no point in having a bunch of those strings if they are all the
same.  If a new one comes out that is different, we can handle that when
the time comes.

-corey

> >
> > I'm pretty sure the only reason to have muliple compatible entries in a
> > device tree is to cover multiple kernels where the name changed.
> >
> > -corey
> >
> > > >
> > > > -corey
> > > >
> > > > >  - interrupts : interrupt generated by the controller
> > > > >  - kcs_chan : The KCS channel number in the controller
> > > > >
> > > > > --
> > > > > 2.33.0
> > > > >
> > >
> > > Best regards,
> > >
> > > Tomer
> 
> Best regards,
> 
> Tomer
