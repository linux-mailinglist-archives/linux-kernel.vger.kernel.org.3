Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79125469AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiFJPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbiFJPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:44:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E72811834;
        Fri, 10 Jun 2022 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1654875867; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+tcOPT05j3Kld5+e+h7aRQWdZMPfkG6IYiab36lRGQ=;
        b=L0MEO77i4G7CF4vEWHNwlMbxWPLFq2qLGmgKuB0QwrPb+hEK6Pyo9HUHSzkxU4UeVdrzvM
        4Wm1EhLIfh9s/+humVWofwmmLzuMR9VCkZN61UXdHThNZSx7j1yNFh7Y5KmhQ1vhdAdaWO
        3BeraoaT1wxNPWI3ojpETz0BLTeONwE=
Date:   Fri, 10 Jun 2022 16:44:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic-tcu: Properly enable registers before
 accessing timers
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <TDQ9DR.SDDTZMEA0H7F3@crapouillou.net>
In-Reply-To: <qONO5Rg11q4yBfTVshsrN1odktNWOtHV@localhost>
References: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
        <20220609224200.D1E8BC34114@smtp.kernel.org>
        <qONO5Rg11q4yBfTVshsrN1odktNWOtHV@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven., juin 10 2022 at 16:43:27 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
>=20
> Stephen Boyd <sboyd@kernel.org> writes:
>=20
>>  Quoting Aidan MacDonald (2022-06-03 06:47:05)
>>>  Access to registers is guarded by=20
>>> ingenic_tcu_{enable,disable}_regs()
>>>  so the stop bit can be cleared before accessing a timer channel,=20
>>> but
>>>  those functions did not clear the stop bit on SoCs with a global=20
>>> TCU
>>>  clock gate.
>>>=20
>>>  Testing on the X1000 has revealed that the stop bits must be=20
>>> cleared
>>>  _and_ the global TCU clock must be ungated to access timer=20
>>> registers.
>>>  Programming manuals for the X1000, JZ4740, and JZ4725B specify this
>>>  behavior. If the stop bit isn't cleared, then writes to registers=20
>>> do
>>>  not take effect, which can leave clocks with no defined parent when
>>>  registered and leave clock tree state out of sync with the=20
>>> hardware,
>>>  triggering bugs in downstream drivers relying on TCU clocks.
>>>=20
>>>  Fixing this is easy: have ingenic_tcu_{enable,disable}_regs()=20
>>> always
>>>  clear the stop bit, regardless of the presence of a global TCU=20
>>> gate.
>>>=20
>>>  Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>  ---
>>=20
>>  Any Fixes: tag?
>=20
> Probably 4f89e4b8f121 ("clk: ingenic: Add driver for the TCU clocks")
> but I don't have docs or hardware to confirm the bug affects the=20
> jz4770,
> which is the only other SoC affected by the change.
>=20
> I think what caused my problem was my bootloader stopping all the=20
> timer
> channels. The stop bits are supposed to be zeroed at reset, so I'd=20
> guess
> the jz4770 relied on that and only worked by accident.

I'll test it on JZ4770 this weekend.

> I'll send a v2 along shortly. Is it worth CC'ing stable as well?

If the bug is in jz-5.18 or earlier, yes.

Cheers,
-Paul


