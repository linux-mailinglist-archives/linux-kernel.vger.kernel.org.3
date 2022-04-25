Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729CF50DB39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiDYIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiDYIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:33:24 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD71B93;
        Mon, 25 Apr 2022 01:30:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B8845240005;
        Mon, 25 Apr 2022 08:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650875418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/NOD3HQYXnNSYrB/0k1nvGPoHKrLg3AU9uknY9njKs=;
        b=TA5UE9BnBKepmzRzwXMptNSOitLJEVdWmCcuzNPzXX00mcYTAl0cCq7JBTgXQkFtJbDVUh
        M4K7kW432xV5NI/IjC/BKhRx4+QBuYcq5tS0xhfG1vUwnpJ4cnmy74snLGA6BjSTB01HQR
        yCyitR1KAfKXDfNv+N/zYuDbHfwe8L/NnLOhU3z9+5lQF6T6Fz0RquvCKYu5yWpFwGD9RC
        Tn/tMh7Jvf/uh7dpcMGCFiOMGTfoIvvY7UhTFfc0llKo3EeEcDkOP9H09tvq0SnFpXpAQm
        1crpOPlCPg38IHx5FcUIgUii7oMNqF5fzI38i4NHp1rdOtWdD1jsO2sQzD7Z7g==
Date:   Mon, 25 Apr 2022 10:30:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel test robot <lkp@intel.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "joern@lazybastard.org" <joern@lazybastard.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        kernel <kernel@axis.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtd: phram: Allow cached mappings
Message-ID: <20220425103015.1cc05f77@xps13>
In-Reply-To: <20220425102816.54619c66@xps13>
References: <20220412135302.1682890-5-vincent.whitchurch@axis.com>
        <202204131446.omJ5mC54-lkp@intel.com>
        <20220414090402.GA11067@axis.com>
        <20220425102816.54619c66@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


miquel.raynal@bootlin.com wrote on Mon, 25 Apr 2022 10:28:16 +0200:

> Hi Vincent,
> 
> vincent.whitchurch@axis.com wrote on Thu, 14 Apr 2022 11:04:02 +0200:
> 
> > On Wed, Apr 13, 2022 at 08:45:59AM +0200, kernel test robot wrote:  
> > > All errors (new ones prefixed by >>):
> > > 
> > >    In file included from include/linux/io.h:13,
> > >                     from drivers/mtd/devices/phram.c:21:
> > >    drivers/mtd/devices/phram.c: In function 'register_device':    
> > > >> arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'    
> > >      274 | #define iounmap(addr)           do { } while (0)
> > >          |                                 ^~
> > >    drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
> > >      150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
> > >          |                                            ^~~~~~~
> > >    drivers/mtd/devices/phram.c: In function 'phram_remove':    
> > > >> arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'    
> > >      274 | #define iounmap(addr)           do { } while (0)
> > >          |                                 ^~
> > >    drivers/mtd/devices/phram.c:372:53: note: in expansion of macro 'iounmap'
> > >      372 |         phram->cached ? memunmap(phram->mtd.priv) : iounmap(phram->mtd.priv);
> > >          |                                                     ^~~~~~~
> > > 
> > > 
> > > vim +/do +274 arch/sh/include/asm/io.h
> > > 
> > > d57d64080ddc0f Paul Mundt        2010-01-19  272  
> > > 13f1fc870dd747 Christoph Hellwig 2020-07-14  273  #else /* CONFIG_MMU */
> > > 13f1fc870dd747 Christoph Hellwig 2020-07-14 @274  #define iounmap(addr)		do { } while (0)
> > > 13f1fc870dd747 Christoph Hellwig 2020-07-14  275  #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
> > > 13f1fc870dd747 Christoph Hellwig 2020-07-14  276  #endif /* CONFIG_MMU */
> > > d627a2ebd1a303 Paul Mundt        2010-01-28  277      
> > 
> > Thank you for the report.  This patch could certainly be changed to work
> > around this, but ISTM that the right fix is in the SH header file, since
> > the problem could hit in other cases too.  I've posted a fix here now:
> > 
> >  https://lore.kernel.org/lkml/20220414081257.1487499-1-vincent.whitchurch@axis.com/  
> 
> Looks good to me but I don't want to be the one "carrying" new compile
> errors so I'll drop the series for now, until you get this patch
> applied. Please then just resend the series with this thread mentioned
> and I'll take it back.

BTW, I'm only talking about this improvement, patches 1-3 will remain.

