Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60853B42E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiFBHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiFBHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:12:48 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22755B0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:12:46 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4289E2000B1;
        Thu,  2 Jun 2022 07:12:43 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 034E480864; Thu,  2 Jun 2022 09:09:57 +0200 (CEST)
Date:   Thu, 2 Jun 2022 09:09:56 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     Jonathan.Cameron@huawei.com, broonie@kernel.org, arnd@arndb.de,
        lukas.bulwahn@gmail.com, daniel@zonque.org,
        zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v3] pcmcia: add MIPS_DB1XXX dependence
Message-ID: <YphiRHtC0TaxNDDY@owl.dominikbrodowski.net>
References: <20220510023255.1283529-1-starzhangzsd@gmail.com>
 <CANubcdVNEsJvGz+gpJjvF14_D_+K9Xv5UtQJdf9s1o07ghFY1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdVNEsJvGz+gpJjvF14_D_+K9Xv5UtQJdf9s1o07ghFY1A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A different variant is upstream now, see

	https://git.kernel.org/torvalds/c/2380dd691e1fe1ebe3f346d0ce54f8fc7eacc167

Thanks,
	Dominik

Am Thu, Jun 02, 2022 at 02:23:43PM +0800 schrieb Stephen Zhang:
> ping
> 
> Stephen Zhang <starzhangzsd@gmail.com> 于2022年5月10日周二 10:33写道：
> >
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > drivers/pcmcia/db1xxx_ss.c uses the bcsr_xxxx() from
> > arch/mips/alchemy/devboards/bcsr.c, which causes a link
> > error:
> >
> > drivers/pcmcia/db1xxx_ss.c:(.text+0x2b4): undefined reference to `bcsr_read'
> > mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x2fc): undefined reference to `bcsr_read'
> > drivers/pcmcia/db1xxx_ss.c:(.text+0x374): undefined reference to `bcsr_read'
> > mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x380): undefined reference to `bcsr_read'
> > drivers/pcmcia/db1xxx_ss.c:(.text+0x534): undefined reference to `bcsr_read'
> > drivers/pcmcia/db1xxx_ss.c:(.text+0xcc8): undefined reference to `bcsr_mod'
> >
> >
> > So add MIPS_DB1XXX dependence.
> >
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Changes from v1:
> > - Rewrite the commit message.
> > Changes from v2:
> > - Give credit to k2ci for reporting the issue.
> > ---
> >  drivers/pcmcia/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> > index 2ce261cfff8e..04b51cb67fbf 100644
> > --- a/drivers/pcmcia/Kconfig
> > +++ b/drivers/pcmcia/Kconfig
> > @@ -151,7 +151,7 @@ config TCIC
> >
> >  config PCMCIA_ALCHEMY_DEVBOARD
> >         tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
> > -       depends on MIPS_ALCHEMY && PCMCIA
> > +       depends on MIPS_ALCHEMY && MIPS_DB1XXX && PCMCIA
> >         help
> >           Enable this driver of you want PCMCIA support on your Alchemy
> >           Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300
> > --
> > 2.30.2
> >
