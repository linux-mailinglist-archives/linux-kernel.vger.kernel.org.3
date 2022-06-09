Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB03854578C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiFIWmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiFIWmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:42:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736741E048D;
        Thu,  9 Jun 2022 15:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 361ADB8309F;
        Thu,  9 Jun 2022 22:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E8BC34114;
        Thu,  9 Jun 2022 22:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654814520;
        bh=QnDYuiyOMPoijl3cgJs2K46AvbHIJm4yF3pRDUw7KYE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SIgLJ84EguNj0Bo2TuVdkZgrdox1YGG+6FQfl2rM10+0XlG0PaacA5MpNqIBo8blG
         R8Ld0q32wOqu3rKBbvaErn48Ia7KhgZWI1OtZlIwzc4Px9+Dtz+cCi7GvNn7rwhoMc
         61W+uTGse+w7PMbasodWhMOJqX6z9fTWJaTT1oukiwPHygw2655+DR+t5cgu3JVavy
         j8sx5TJbePukBth/XwEp9/nvFlQnCwEu8DOj2kSzudJHW0LNKfpWx2rpvPdXmXJUdb
         jZuQ9Sw2z7sjbIGf0escnuCIsMIF+IVos9IjcAhU86ugPygYDCAn/BwJffCgQiZ4yA
         fYN2EZWvvombg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
References: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH] clk: ingenic-tcu: Properly enable registers before accessing timers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        mturquette@baylibre.com, paul@crapouillou.net
Date:   Thu, 09 Jun 2022 15:41:58 -0700
User-Agent: alot/0.10
Message-Id: <20220609224200.D1E8BC34114@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-06-03 06:47:05)
> Access to registers is guarded by ingenic_tcu_{enable,disable}_regs()
> so the stop bit can be cleared before accessing a timer channel, but
> those functions did not clear the stop bit on SoCs with a global TCU
> clock gate.
>=20
> Testing on the X1000 has revealed that the stop bits must be cleared
> _and_ the global TCU clock must be ungated to access timer registers.
> Programming manuals for the X1000, JZ4740, and JZ4725B specify this
> behavior. If the stop bit isn't cleared, then writes to registers do
> not take effect, which can leave clocks with no defined parent when
> registered and leave clock tree state out of sync with the hardware,
> triggering bugs in downstream drivers relying on TCU clocks.
>=20
> Fixing this is easy: have ingenic_tcu_{enable,disable}_regs() always
> clear the stop bit, regardless of the presence of a global TCU gate.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Any Fixes: tag?
