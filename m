Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA066595E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiHPOGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiHPOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:06:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53C29F1A7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:06:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y3so13638486eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=v67fLx2SsYmXkg1Fdi0JXC8gGND5NRH5uKTqVhwYSUI=;
        b=Ju5xuuLC9C+n6VMthS725e6wl8VEnc3vzrwV5dn6dZsgGzedXd3n7k4QoLTaCRMAgK
         LAm0VyCVErNs0kAwHwvlj3smae7Tnf2VXX/wwZr3Risbm+fhqNou7gL9DvATGXZ3OM2t
         ClZ6z3K3/0PhpCGWzexwOQ+gSEx9Qb/Z4PrhWtgnwN5GY7SakBbfsBSHLNEwfDtU2QEH
         SzImyJT5V9R2G+Eym8fIvC/Z7aK3auCUc99ook/6+uZqytYFf6uXmlZVz1W/Psl3au9g
         6erT4JI5IP00PNBlNMvY4gpOTtL/lNu9w25ISae95TsXgRoL2qtAxr+ZcQITXoukZ/lV
         UumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=v67fLx2SsYmXkg1Fdi0JXC8gGND5NRH5uKTqVhwYSUI=;
        b=RRUVw2U9GDSD0sBmEo35bRMGzDW2hoJgbut8FFwK3gUX4koyDs8eNEWg1ig/VadD9Z
         toliU8ykPtHrj0gQUyDsx2L10S/iKLf0wlFvZ8JwtuftKLv91fQiKI68m2yHeJzl8JDf
         Gvs3HPYnNIZzM3/FaHMYXkRw8FmW3MtiaanSWGskBqEq+QInv7E4v4KEtBlgQ+/HcJmj
         jXSpfRJTgw479Nq/8TIMeOx060xP4r/t+/TMarVpvzLnYDITNxZ8YhTlwy80bG2Ja13d
         WOWs3PI5g0Tz0BboG9i7YI3jJSGmVLdI1dDjA2E+SC76vVSVXBziaecf78/rhA27Wqke
         LVFw==
X-Gm-Message-State: ACgBeo3eFvg9S5D6myVca0g6YUasfnABP54PUSAQiNTMwSVuV4sAPgH3
        S48XhE4L5I74BqmK7Uzng9GMKw==
X-Google-Smtp-Source: AA6agR6r1l6Sr0C+9O74LK7tEXhHcKr5WkJuNVf5fov9/5YQxlPkY7/Fk0oRlGomhuTpkbuGdBedSQ==
X-Received: by 2002:a05:6402:1777:b0:43d:85da:2fac with SMTP id da23-20020a056402177700b0043d85da2facmr19125475edb.32.1660658795422;
        Tue, 16 Aug 2022 07:06:35 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b00730799724c3sm5450092ejh.149.2022.08.16.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 07:06:34 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:06:33 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor.Dooley@microchip.com
Cc:     jrtc27@jrtc27.com, palmer@dabbelt.com, robh@kernel.org,
        tglx@linutronix.de, maz@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        anup@brainfault.org, guoren@kernel.org, sagar.kadam@sifive.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Message-ID: <20220816140633.pkjws7n3qxsescjh@kamzik>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
 <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
 <20220809141436.GA1706120-robh@kernel.org>
 <61829ccd-20d7-e2f0-0a6b-bcd0e076b9ea@microchip.com>
 <1d94e18d-7f51-0619-95a9-6ca5fa7d9671@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d94e18d-7f51-0619-95a9-6ca5fa7d9671@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 07:18:02PM +0000, Conor.Dooley@microchip.com wrote:
> Any takers on trashing my regex? Otherwise I'll just submit
> a v2 with the regex and it can be shat on there instead :)
> 
> On 09/08/2022 19:36, Conor Dooley wrote:
> > On 09/08/2022 15:14, Rob Herring wrote:
> >> On Mon, Aug 08, 2022 at 10:01:11PM +0000, Conor.Dooley@microchip.com wrote:
> >>> On 08/08/2022 22:34, Jessica Clarke wrote:
> >>>> On Fri, Aug 05, 2022 at 05:28:42PM +0100, Conor Dooley wrote:
> >>>>> From: Conor Dooley <conor.dooley@microchip.com>
> >>>>> The final patch adds some new ISA strings
> >>>>> which needs scruitiny from someone with more knowledge about what ISA
> >>>>> extension strings should be reported in a dt than I have.
> >>>>
> >>>> Listing every possible ISA string supported by the Linux kernel really
> >>>> is not going to scale...
> >>
> >> How does the kernel scale? (No need to answer)
> >>
> >>> Yeah, totally correct there. Case for adding a regex I suppose, but I
> >>> am not sure how to go about handling the multi-letter extensions or
> >>> if parsing them is required from a binding compliance point of view.
> >>> Hoping for some input from Palmer really.
> >>
> >> Yeah, looks like a regex pattern is needed.
> > 
> > I started pottering away at this but I have arrived at:
> > rv64imaf?d?c?h?(_z[imafdqcbvkh]([a-z])*)*$

Don't forget the ^ at the start.

Do we need to worry about optional major and minor version numbers?
Or check that Z names have at least one character following the category
character? Actually, the first letter after Z being a category is only a
convention. Maybe we don't want to enforce that. What about X extensions?

Thanks,
drew

> > 
> > I suspect that before "h?" there should be more single letter
> > extensions added for completeness sake. So then it'd bloat out to:
> > rv64imaf?d?q?c?b?v?k?h?(_z[imafdqcbvkh]([a-z])*)*$
> > 
> > I checked a couple different "bad" isa strings against it and
> > nothing went up in flames but my regex skills are far from great
> > so I'm sure there's better ways to represent this.
> > 
> > Anyways, this pattern is based on my understanding that:
> > - the single letter order is fixed & we don't care about things that
> >   can't even do "ima"
> > - the multi letter extensions are all in a "_z<foo>" format where the
> >   first letter of <foo> is a valid single letter extension
> > - we don't care about the e extension from an OS PoV (this could be a
> >   very flawed take...)
> > - after the first two chars, the extension name could be an english
> >   word (ifencei anyone?) so it's not worth restricting the charset
> > - that attempting to validate the contents of the multiletter extensions
> >   with dt-validate beyond the formatting is a futile, massively verbose
> >   or unwieldy exercise at best
> > 
> > Some or all of those assumptions could be very very wrong so if {someone,
> > anyone} wants to correct me - feel ***more*** than free.. 
> > 
> > Thanks,
> > Conor.
> > 
> > patch would then look like:
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index d632ac76532e..1e54e7746190 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -74,9 +74,7 @@ properties:
> >        insensitive, letters in the riscv,isa string must be all
> >        lowercase to simplify parsing.
> >      $ref: "/schemas/types.yaml#/definitions/string"
> > -    enum:
> > -      - rv64imac
> > -      - rv64imafdc
> > +    pattern: rv64imaf?d?q?c?b?v?k?h?(_z[imafdqcbvkh]([a-z])*)*$
> >  
> >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
> >    timebase-frequency: false
> 
