Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C4512F39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbiD1JDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbiD1JDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:03:33 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 811752CC92;
        Thu, 28 Apr 2022 02:00:14 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7D96092009D; Thu, 28 Apr 2022 11:00:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 76A8C92009C;
        Thu, 28 Apr 2022 10:00:13 +0100 (BST)
Date:   Thu, 28 Apr 2022 10:00:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Zhang <starzhangzsd@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Joshua Kinard <kumba@gentoo.org>
cc:     liam.howlett@oracle.com, ebiederm@xmission.com, dbueso@suse.de,
        alobakin@pm.me, f.fainelli@gmail.com,
        zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] arch/mips/kernel/traps: add CONFIG_MIPS_FP_SUPPORT when
 using handle_fpe
In-Reply-To: <CANubcdUPQJcJ=dryJGsnQLhjcTouLUARD-GwCd7UjurUm+-GXg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204280951510.9383@angie.orcam.me.uk>
References: <20220426083259.526685-1-starzhangzsd@gmail.com> <alpine.DEB.2.21.2204270130210.9383@angie.orcam.me.uk> <CANubcdWwHXqC4gUztNseoConYHp+G4nUSYFaO-Te3jFVqT=1sw@mail.gmail.com> <alpine.DEB.2.21.2204271156190.9383@angie.orcam.me.uk>
 <CANubcdUPQJcJ=dryJGsnQLhjcTouLUARD-GwCd7UjurUm+-GXg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022, Stephen Zhang wrote:

> >  Please send me .config causing it and tell me what compiler and version
> > you have seen this error with.  We rely on things being optimised away
> > heavily throughout the Linux kernel, so this is certainly something to
> > investigate.  I have built such a config just fine, but maybe there's a
> > bug somewhere my setup does not trigger.
> 
> Okay. The compiler we used is:
> 
> Compiler gcc
> Compiler version 10
> Compiler string mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
> Cross-compile  mips-linux-gnu
> 
> the  commit id of kernel is c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49
> 
> and the .config file is sent as an attachment.

 Thanks.

 The bug is in arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h, 
which has:

#define cpu_has_fpu			1

(and similarly arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h).
This is not supported, as noted in arch/mips/include/asm/cpu-features.h:

/* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */

Perhaps we should explicitly undefine `cpu_has_fpu' if set to 1?

  Maciej
