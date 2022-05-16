Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFD527E69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiEPHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiEPHS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:18:26 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4543713CD5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:18:24 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:51ae:171f:35c9:722d])
        by xavier.telenet-ops.be with bizsmtp
        id XKJK2700L2UsjYA01KJKhi; Mon, 16 May 2022 09:18:22 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nqUzi-000YsA-VZ; Mon, 16 May 2022 09:18:18 +0200
Date:   Mon, 16 May 2022 09:18:18 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.18-rc7
In-Reply-To: <20220516064231.2425428-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2205160916190.134019@ramsan.of.borg>
References: <CAHk-=wg2eVUN0a1E5UnBF1ziGaU1yrMJtnFPg4R78O=FcRDqnA@mail.gmail.com> <20220516064231.2425428-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.18-rc7[1] to v5.18-rc6[3], the summaries are:
>  - build errors: +2/-0

   + /kisskb/src/drivers/media/platform/nxp/imx-pxp.h: error: initializer element is not constant:  => 582:38

mipsel-gcc5/mips-allmodconfig

Seen before in other builds, missing "U"-suffix on large unsigned
constants.

   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 328:25

s390x-gcc11/s390-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/42226c989789d8da4af1de0c31070c96726d990c/ (all 131 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a/ (all 131 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
