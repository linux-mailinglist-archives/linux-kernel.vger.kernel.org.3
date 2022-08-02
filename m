Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769885879BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiHBJOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiHBJOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:14:09 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97C17E26
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:14:05 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id 2ZE2280024C55Sk06ZE2Mv; Tue, 02 Aug 2022 11:14:02 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oInyT-005nLM-MQ; Tue, 02 Aug 2022 11:14:01 +0200
Date:   Tue, 2 Aug 2022 11:14:01 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.19
In-Reply-To: <20220801124705.2029590-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2208021113170.1381271@ramsan.of.borg>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com> <20220801124705.2029590-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.19[1] to v5.19-rc8[3], the summaries are:
>  - build errors: +5/-0

   + {standard input}: Error: displacement to undefined symbol .L271 overflows 12-bit field:  => 1625
   + {standard input}: Error: displacement to undefined symbol .L271 overflows 8-bit field :  => 1634
   + {standard input}: Error: displacement to undefined symbol .L318 overflows 8-bit field :  => 1665, 1681, 1693, 1711

sh4-gcc11/sh-allyesconfig (seen before)

   + {standard input}: Error: pcrel too far:  => 1629, 1686, 1635, 1655, 1702, 1618, 1660, 1676, 1672, 1684, 1685, 1698, 1695, 1656, 1649, 1670, 1667, 1657, 1644, 1673, 1705, 1609, 1632, 1700
   + {standard input}: Error: unknown opcode:  => 1713

sh4-gcc11/sh-all{mod,yes}config (seen before)

The root cause is probably a compiler bug:

     sh4-linux-gcc: internal compiler error: Segmentation fault signal terminated program cc1

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3d7cb6b04c3f3115719235cc6866b10326de34cd/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e0dccc3b76fb35bb257b4118367a883073d7390e/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
