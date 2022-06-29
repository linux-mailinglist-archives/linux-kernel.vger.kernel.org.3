Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25055FA46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiF2IVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiF2IVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:21:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772003BBD9;
        Wed, 29 Jun 2022 01:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A761B8213D;
        Wed, 29 Jun 2022 08:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25D2C34114;
        Wed, 29 Jun 2022 08:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656490865;
        bh=U9wHR/pjBxL3ZDudOYVv5qC9NLKMswEW1fATdofQxPU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FjcUn0sUlJBXcJ3Kdw6QkvKxf0bgKLF+nGgJTNbHezd41wQsVvog3bNTDIEYd20I2
         xC5mBGsIW7Y+hzzt0gdiSuE4HuJxxy8FhqTNRdXmS/pJlgZT95tHx2AO3EQ5JozjtS
         pGjPfy3BcfV4b4hRDE3UEKMN+iksTY4y4vRgOwa0jLCiw271xUOF2fqg/v0sRRXYk1
         zz8B+wj+2FGqHHYlPr+TJ1cff4ovJlU08zW5qaNCeSU3ESZSQ+2yAVCpOqn2DDeAfY
         bnww7mXSHjh/JNgYOm3ZlStlJu9wOEjx6X40A9x0MgxxfdJNTqiE6KmHYLWNooeJ17
         D9I+7LOE84aqg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0edab0e2-5355-a3da-445d-b6f45e3082ed@suse.cz>
References: <20220623083217.26433-1-jslaby@suse.cz> <20220624004225.0DE4AC3411D@smtp.kernel.org> <0edab0e2-5355-a3da-445d-b6f45e3082ed@suse.cz>
Subject: Re: [PATCH 1/2] clk: pistachio: Fix initconst confusion
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mliska@suse.cz, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, linux-clk@vger.kernel.org
To:     Jiri Slaby <jslaby@suse.cz>, mturquette@baylibre.com
Date:   Wed, 29 Jun 2022 01:21:02 -0700
User-Agent: alot/0.10
Message-Id: <20220629082104.E25D2C34114@smtp.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiri Slaby (2022-06-27 00:46:15)
> On 24. 06. 22, 2:42, Stephen Boyd wrote:
> > Quoting Jiri Slaby (2022-06-23 01:32:16)
> >> From: Andi Kleen <ak@linux.intel.com>
> >>
> >> A variable pointing to const isn't const itself. It'd have to contain
> >> "const" keyword after "*" too. Therefore, PNAME() cannot put the strin=
gs
> >> to "rodata".  Hence use __initdata instead of __initconst to fix this.
> >>
> >> [js] more explanatory commit message.
> >>
> >> Cc: Michael Turquette <mturquette@baylibre.com>
> >> Cc: Stephen Boyd <sboyd@kernel.org>
> >> Cc: linux-clk@vger.kernel.org
> >> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >> ---
> >>   drivers/clk/pistachio/clk.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
> >> index f9c31e3a0e47..742e5fab00c0 100644
> >> --- a/drivers/clk/pistachio/clk.h
> >> +++ b/drivers/clk/pistachio/clk.h
> >> @@ -34,7 +34,7 @@ struct pistachio_mux {
> >>          const char **parents;
> >>   };
> >>  =20
> >> -#define PNAME(x) static const char *x[] __initconst
> >> +#define PNAME(x) static const char *x[] __initdata
> >=20
> > Can it be const char * const and left as __initconst?
>=20
> Let me check, IIRC the struct where this is assigned would need to be=20
> updated too.
>=20
> I will get into it only some time next week.
>=20

Ok, sounds good. This seems to at least compile locally.

----8<---

diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
index f9c31e3a0e47..8be02ac2d909 100644
--- a/drivers/clk/pistachio/clk.h
+++ b/drivers/clk/pistachio/clk.h
@@ -31,10 +31,10 @@ struct pistachio_mux {
 	unsigned int shift;
 	unsigned int num_parents;
 	const char *name;
-	const char **parents;
+	const char * const *parents;
 };
=20
-#define PNAME(x) static const char *x[] __initconst
+#define PNAME(x) static const char * const x[] __initconst
=20
 #define MUX(_id, _name, _pnames, _reg, _shift)			\
 	{							\
