Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9558CA78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbiHHOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiHHOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:23:33 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F810FDD;
        Mon,  8 Aug 2022 07:23:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so6608462otk.0;
        Mon, 08 Aug 2022 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc;
        bh=c4sdWPDGZh2lpcz0JPsH1RxILtP+3NzhgDmzZEzhFwU=;
        b=ZnLmow2wQ4sURptG6gn+2TtbvfsVwBPnjNh04IBl4k64MgxlFvSvUC+wp+vboN3FgO
         ZyzRtpw9HTFDSJFU034ypntElaqBvXbVjdm6be2TRrV7uK16N99P1EchihnkRoKVliBv
         8GPCh+Cfbd5UnCYx4nUQfWm3niPkbwQoKkNBKaNVXIw+u4CP7aMrxBGpmDm79s1VSoSA
         UiPRyNaRR/wMj53t/PjOxllk2TJrO0AEUzOkw2dCBTrfbgVAfMHFdUe/xgp/HVbunerL
         TOsm01vtfLxY0tyde5qMUJ1Q267z+JxC2cJNOEpgBI8FwHIQPZxY08ZWIUvoyhQxNAN4
         Du/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc;
        bh=c4sdWPDGZh2lpcz0JPsH1RxILtP+3NzhgDmzZEzhFwU=;
        b=5wwcMJcdS+iRaMctNi2ttckacXt1wCH5N1K2V8/40KJtrX7V8m9tLH1lGnZtjSqaSk
         TF2ykpMVvzZV4RDAa7yMMtB0Q83AV+zsvyE5wbXf1MA46idGg6lutDotjuFZRopLvmuW
         nQwMYiQD0C1xbopcmpxtiRnlXBIrOIvw5WmoaanYRk84oJM9GtEvqo/fZGJChu5DpYPU
         czZAMwqr9TX/nVfAGXxNLnpLBQ8ArHKmaXIDhDRLKBghpIoC8cN4VNJCnVniTRBB0oFb
         TEEaCYBUdUPRD7YKdmDOg/qvCEf1SWXoJ/ivqFioyPpKgVbABu3G1t91+4TEO0OoN8kJ
         NQDQ==
X-Gm-Message-State: ACgBeo03smLK9vMs7cx2MKmIhjb0OvBXNsFvKhU2mF908/OeDIdHMopT
        CXRGwV6bqNdNeu6cNPMoJw==
X-Google-Smtp-Source: AA6agR5il2qTkCti/3qg75D5Tbky90Do0XQ9veQVqgQYxxPzZdL+FNKM8OV8jU27apltAUSE8fZdRA==
X-Received: by 2002:a9d:73d0:0:b0:61c:8d31:6981 with SMTP id m16-20020a9d73d0000000b0061c8d316981mr7149505otk.99.1659968610070;
        Mon, 08 Aug 2022 07:23:30 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id fo34-20020a0568709a2200b0010e47737471sm2295305oab.49.2022.08.08.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 07:23:29 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:3153:e085:df0f:abc2])
        by serve.minyard.net (Postfix) with ESMTPSA id B79DE1800FA;
        Mon,  8 Aug 2022 14:23:28 +0000 (UTC)
Date:   Mon, 8 Aug 2022 09:23:27 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-binding: ipmi: add fallback to npcm845 compatible
Message-ID: <20220808142327.GR3834@minyard.net>
Reply-To: minyard@acm.org
References: <20220808075452.115907-1-tmaimon77@gmail.com>
 <da83671e-08b9-2d68-e5d3-d9b09c105bb4@linaro.org>
 <20220808122652.GO3834@minyard.net>
 <937b6737-5d55-2185-a4bc-7535fa6da85c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937b6737-5d55-2185-a4bc-7535fa6da85c@linaro.org>
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

On Mon, Aug 08, 2022 at 03:38:45PM +0300, Krzysztof Kozlowski wrote:
> On 08/08/2022 15:26, Corey Minyard wrote:
> > On Mon, Aug 08, 2022 at 11:11:16AM +0300, Krzysztof Kozlowski wrote:
> >> On 08/08/2022 09:54, Tomer Maimon wrote:
> >>> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> >>> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> >>>
> >>> Fixes: 84261749e58a ("dt-bindings: ipmi: Add npcm845 compatible")
> >>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >>
> >>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Ok, I think I understand how this is supposed to work.  It's not
> > altogether clear from the device tree documentation.  It says in
> > Documentation/devicetree/bindings/writing-bindings.rst:
> > 
> > - DO make 'compatible' properties specific. DON'T use wildcards in compatible
> >   strings. DO use fallback compatibles when devices are the same as or a subset
> >   of prior implementations. DO add new compatibles in case there are new
> >   features or bugs.
> 
> This documentation is short, so it explains what should be done, not
> exactly why it should be done. If we wanted "why" this would not be set
> of 4 sentences but twice more...
> 
> > 
> > AFAICT, there are no new features or bugs, just a new SOC with the same
> > device.  In general usage I have seen, you would just use the same
> > compatible.  
> 
> Most of the usages are like shown here. There are several other cases.
> It's the same with poor or good code - you will always find both patterns.

It is true, but lack of specified good examples makes it hard for people
like me to know what is right and wrong.

> 
> > However, if I understand this, that last sentence should say:
> > 
> >   DO add new compatibles in case there is a new version of hardware with
> >   the possibility of new features and/or bugs.
> > 
> > Also, the term "specific" is, ironically, vague.  Specific to what?
> 
> To me it is rather clear. Specific as in first meanings of the word (1,
> 3, 4 and 5):
> https://en.wiktionary.org/wiki/specific

Everything is always clear when you understand something :).
The really hard part about technical documentation is forgetting what
you know and approaching it from a newbie's context.

> 
> nuvoton,npcm7xx-kcs-bmc would not be definite (allows more meanings),
> unique (in terms of devices it expresses), distinctive (as two different
> devices use the same) or serving to identify one thing (again - two SoCs).
> 
> What other meaning do you think of?

It is not the definition of specific that is vague, it is what
"specific" applies to.  Is it specific to a SOC?  Specific to a board?
Specific to a particular device implementation?  Specific to a rev of
the silicon?

I will say that when I read that sentence, it means nothing to me.
If it said "DO make compatible properties as specific as possible to the
particular hardware implementation of the device" that would have more
meaning, but still leaves the reader wondering exactly how to do this.

For instance, should I put board/rev specific compatibles in?  Would it
be:

   "mycompany,myboard-rev1-npcm845-kcs-bmc", "mycompany,myboard-npcm845-kcs-bmc",
   "nuvoton,npcm845-revb-kcs-bmc", "nuvoton,npcm845-kcs-bmc",
   "nuvoton,npcm750-kcs-bmc"

That's about as specific as you can get with fallbacks for everything,
but it is too specific?  How far do you go?  There might be wiring
differences on specific board, maybe that makes a difference.

That's where good (and identified bad) examples and rationale come in.
Tell the user why something is being done and it's easier to understand
what to do in different situations.  It's not a matter of number of
sentences.  Just like code, shorter is not always better.

Anyway, I have ranted for too long.  Thank you for clearing this up for
me.

-corey

> 
> > 
> > It would be nice to have something added to "Typical cases and caveats"
> > that says:
> > 
> > - If you are writing a binding for a new device that is the same as, or
> >   a superset of another existing device, add a new specific compatible
> >   for the new device followed by a compatible for the existing device.
> >   That way, if the device has new bugs or new specific features are
> >   added, you can add workarounds without modifying the device tree.
> > 
> > Anyway, I have added this to my tree with your ack.
> 
> Fantastic, thanks!
> 
> 
> Best regards,
> Krzysztof
