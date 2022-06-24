Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10BD559B89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiFXOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:30:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776654BFD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:30:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p6-20020a05600c1d8600b003a035657950so1636085wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=aj4iPurOG117lGbV6R8kb4VecXLBHE5B/GnlxqitdOs=;
        b=FrzNxbBjr7b6b7Dw3Rbr6y+WQ6fizGGUJ0A/DSQk+ae6/YXj5nf6Dz1Y06gklcZkDw
         m249DFnPSQ8QGcyYe3EhXB/T2n9rpAtDClYkrnSjUOtT2RlgqSsJx+EfVygXANmiiXbQ
         JPh2sEIw6BV5446hRomCG/TR6QxZ9o4pOlbxWad8f+8yVqO8L00WYugxmuuIA2AV9XeV
         IspeUjtw0VcicBsOuYBz7qD3tOfsxMZvaFzsYMLERY0U1DKSi4WKD2IUqEI/Hhsy8ej1
         IrfAY27GbCJ9a/gQpmThr1xbdYIHoxhcG9ExAjz4XL4/s6vji8lnjfkOcMORGSrowG4D
         eIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=aj4iPurOG117lGbV6R8kb4VecXLBHE5B/GnlxqitdOs=;
        b=NVPioETgcGKpZ0RHOvzwdejBGIN1XWqHEA+Y3ngYzlvv/TrlQ49mD7O2wrQi8QaEdN
         sSSxOBH2hXZK8i0ImOKPhGCRaf+E9TSHUMMjFpi4jojkSCAZTt2SRy4DB30TGoSiLgb7
         8j4fiXCc7PXAUKWSVUH5QxPXr6vfIYfWOzvX8BiQbrkECJ/8efoU+u7cEyVHJtThMYHX
         Nf7sungwEzpvV0BAQ8h8RHn0qSPMefmJhn5Sp5T9iCutyQT/rldD4EEffRtGXc5xbIeo
         2n3CmxJ0m+yCVU4qz0HlkdYyNADfCKn0vQTqu6hBjgHTUjXLmCOwGaKUIbj3+l2/kbn5
         uTiw==
X-Gm-Message-State: AJIora+ZjuNTW+RyKvBAZmKBGZwPTMC40EPgcNOSSCxi5s2q+5ngoNZy
        B7ZhZ7J94/yM4avLBeRFigM=
X-Google-Smtp-Source: AGRyM1vIs6fIp/6V5KBZKY7C12k2KVkAot3HUHjcT2vWKDt9de7HBPTu4y5PsBWLM1qQ5ZYr+40e7g==
X-Received: by 2002:a7b:c188:0:b0:3a0:391d:45f4 with SMTP id y8-20020a7bc188000000b003a0391d45f4mr4062248wmi.11.1656081009361;
        Fri, 24 Jun 2022 07:30:09 -0700 (PDT)
Received: from localhost (92.40.168.224.threembb.co.uk. [92.40.168.224])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm3039268wrm.27.2022.06.24.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 07:30:08 -0700 (PDT)
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
 <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
 <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
 <YrWqAqGUuy8Z0F3x@sirena.org.uk>
 <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
 <Z2ggoG49naOiT1BMxPbsMc2zOjAUEnha@localhost>
 <ca26910886a765dd7edc4815ef90bedbd0f99a95.camel@perches.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
In-reply-to: <ca26910886a765dd7edc4815ef90bedbd0f99a95.camel@perches.com>
Date:   Fri, 24 Jun 2022 15:31:15 +0100
Message-ID: <duS4BsAjcIRLiWV6ym9lJgPbPrOrefWf@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joe Perches <joe@perches.com> writes:

> On Fri, 2022-06-24 at 14:05 +0100, Aidan MacDonald wrote:
>> Joe Perches <joe@perches.com> writes:
>> 
>> > On Fri, 2022-06-24 at 13:11 +0100, Mark Brown wrote:
>> > > On Thu, Jun 23, 2022 at 11:26:10PM +0200, Andy Shevchenko wrote:
>> > > > On Thu, Jun 23, 2022 at 11:13 PM Aidan MacDonald
>> > > 
>> > > > > Use 'unsigned int' for bitfields for consistency with most other
>> > > > > kernel code.
>> > > 
>> > > > There is no point to convert the fields you are about to remove.
>> > > 
>> > > > So, either don't touch them or make this patch closer to the end of the series.
>> > > 
>> > > It costs us nothing to convert them, this isn't a difficult or hard to
>> > > understand refactoring - the patch is fine the way it is.
>> > 
>> > Modulo the defects that might be introduced if an overflow occurs.
>> > 
>> > struct foo {
>> > 	unsigned int a:1;
>> > 	bool b:1;
>> > }
>> > 
>> > Assign a non-zero int without bit 0 set to each and see if
>> > a and b differ.
>> 
>> Bool permits implicit pointer-to-bool conversions, so it isn't free
>> of pitfalls either.
>
> Care to describe some of those pitfalls?
> I can't think of any off the top of my head.
>

I just listed the pitfall. I don't consider silently converting a
pointer to a bool value desirable, outside of contexts where that
is made obvious, ie: while(...), if(...), and so on.

>> Overflow is probably more dangerous in general,
>> but here there's little chance of pointers or overflow getting involved.
>
> I don't know _this_ code at all, nor have I read it.
>
> If all the conversions are just deleted later, then of course
> it should not be converted at all.

Only _some_ of the flags are being removed, not all of them.

>
> I'm just commenting on the proposed refactoring.
>
> I'm trying to show that conversions of bool:1->unsigned int:1
> as being trivial are not so trivial after all.
>
> It's fairly common to have code like:
>
> 	[bool] foo.bar = some_value & SETTING;
>
> where some value is tested for a mask/bit and a non-zero is true.
>
> So conversions of foo.bar from bool:1 to unsigned int:1 are not
> wise unless all possible side effects are known.

Good point. I didn't take that into account, because I expect all
users are using literal true/false values.

Anyhow, Andy asked for the flags to be converted to unsigned int since
he thought bool was strange for a bitfield, and grepping showed it was
much less common than unsigned int. I personally don't mind either way,
so maybe it's better to leave them as bools.
