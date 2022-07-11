Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D6E570C31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiGKUxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:53:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3952E79;
        Mon, 11 Jul 2022 13:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 14F9ECE17D7;
        Mon, 11 Jul 2022 20:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFFDC34115;
        Mon, 11 Jul 2022 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657572791;
        bh=KXWk2bwFJGa9viXQjgAbCz3X/tgVw7ZmGdeVHoxdjSs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VwcXpE0FwrmOYBh/WgN9Y4npxfHq0ApT+kDw1RnvbQdp81F5iVCR0cx2beMmsgQS4
         18768pyPV/FKK4FOYNj+WXWntfcx7oVgK3yA1Glls4So9XytSNe02a/czKjfdSKlw5
         /b7k+CGtcBqjLhi034R1q8/ETTUMEuRRU2A8C71BM79pKYS1Jqlx24MmK4Jt2T14Xn
         OP0VHnx69/Z4RW9XCPpXKgfhvaz3aFFtZjULsYprdtxRoASmAGgdK758EiWN1XGQQV
         jJmh50BMd4SAIevYQMxjD4jHK9t5bK75fwhJtHh+yQt6JuLCDadfQR6f+jn7NXbJcg
         Z5LqooGnizDqg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <98363f27-e7a4-7351-fad7-361f7e465b7e@suse.cz>
References: <20220623083217.26433-1-jslaby@suse.cz> <20220624004225.0DE4AC3411D@smtp.kernel.org> <0edab0e2-5355-a3da-445d-b6f45e3082ed@suse.cz> <20220629082104.E25D2C34114@smtp.kernel.org> <98363f27-e7a4-7351-fad7-361f7e465b7e@suse.cz>
Subject: Re: [PATCH 1/2] clk: pistachio: Fix initconst confusion
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mliska@suse.cz, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, linux-clk@vger.kernel.org
To:     Jiri Slaby <jslaby@suse.cz>, mturquette@baylibre.com
Date:   Mon, 11 Jul 2022 13:53:09 -0700
User-Agent: alot/0.10
Message-Id: <20220711205310.EAFFDC34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiri Slaby (2022-07-08 00:16:12)
> On 29. 06. 22, 10:21, Stephen Boyd wrote:
> > Quoting Jiri Slaby (2022-06-27 00:46:15)
> >> On 24. 06. 22, 2:42, Stephen Boyd wrote:
> >>> Quoting Jiri Slaby (2022-06-23 01:32:16)
> >>>> From: Andi Kleen <ak@linux.intel.com>
> >>>>
> >>>> A variable pointing to const isn't const itself. It'd have to contain
> >>>> "const" keyword after "*" too. Therefore, PNAME() cannot put the str=
ings
> >>>> to "rodata".  Hence use __initdata instead of __initconst to fix thi=
s.
> >>>>
> >>>> [js] more explanatory commit message.
> >>>>
> >>>> Cc: Michael Turquette <mturquette@baylibre.com>
> >>>> Cc: Stephen Boyd <sboyd@kernel.org>
> >>>> Cc: linux-clk@vger.kernel.org
> >>>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >>>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >>>> ---
> >>>>    drivers/clk/pistachio/clk.h | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk=
.h
> >>>> index f9c31e3a0e47..742e5fab00c0 100644
> >>>> --- a/drivers/clk/pistachio/clk.h
> >>>> +++ b/drivers/clk/pistachio/clk.h
> >>>> @@ -34,7 +34,7 @@ struct pistachio_mux {
> >>>>           const char **parents;
> >>>>    };
> >>>>   =20
> >>>> -#define PNAME(x) static const char *x[] __initconst
> >>>> +#define PNAME(x) static const char *x[] __initdata
> >>>
> >>> Can it be const char * const and left as __initconst?
> >>
> >> Let me check, IIRC the struct where this is assigned would need to be
> >> updated too.
> >>
> >> I will get into it only some time next week.
> >>
> >=20
> > Ok, sounds good. This seems to at least compile locally.
>=20
> Yeah, that works. I've sent a v2.
>=20
> BTW is the code intended to put the actual strings to .init.rodata? As=20
> that was never the case. Only those PNAME defined arrays (pointers to=20
> strings) end up in .init.rodata now and the strings are in .rodata.

I think both the strings and the array should be in .init.rodata. The
clk framework deep copies data like parent names.
