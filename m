Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C76B51599C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381975AbiD3BdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiD3BdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:33:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3247F20D;
        Fri, 29 Apr 2022 18:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C82CB83843;
        Sat, 30 Apr 2022 01:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7506CC385A7;
        Sat, 30 Apr 2022 01:29:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SHh4hRgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651282179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=19JFfsHR6Tp7LcmMWZO8uINflblFf+OX3ZdrXJdqqB8=;
        b=SHh4hRgRP6EmLV+d8Xh1tNidnOnYrtcCnOmHoYFbdpuSemy3C8S1fPMV/ldzuGyhATS2wt
        QX3TUz29I6uiMgr043x0w9kboiVIsCRg4ugDiT1Se1IbNG39pJskGd7b8tMTbSsIetB1ML
        LgG5Mvoy+gMISDKnoQMhrH+LLo88UhI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8034c9c3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 30 Apr 2022 01:29:39 +0000 (UTC)
Date:   Sat, 30 Apr 2022 03:29:37 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 11/17] openrisc: account for 0 starting value in
 random_get_entropy()
Message-ID: <YmyRATzJBQX+wnIP@zx2c4.com>
References: <20220423212623.1957011-12-Jason@zx2c4.com>
 <20220429001648.1671472-1-Jason@zx2c4.com>
 <YmyOh/YbgGJ3DK79@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmyOh/YbgGJ3DK79@antec>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Sat, Apr 30, 2022 at 10:19:03AM +0900, Stafford Horne wrote:
> Hi Jason,
> 
> On Fri, Apr 29, 2022 at 02:16:48AM +0200, Jason A. Donenfeld wrote:
> > As a sanity check, this series makes sure that during early boot, the
> > cycle counter isn't returning all zeros. However, OpenRISC's TTCR timer
> > can be rather slow and starts out as zero during stages of early boot.
> > We know it works, however. So just always add 1 to random_get_entropy()
> > so that it doesn't trigger these checks.
> 
> Just one nit, you might want to qualify that this is related to simulators/qemu:
>  * "However, in simulators OpenRISC's TTCR timer can be rather slow..."

Nice catch, will do.

Jason

> 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Acked-by: Stafford Horne <shorne@gmail.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Changes v6->v7:
> > - Add 1 to cycle counter to account for functional but slow-to-begin
> >   counter on QEMU.
> > 
> >  arch/openrisc/include/asm/timex.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
> > index d52b4e536e3f..a78a5807c927 100644
> > --- a/arch/openrisc/include/asm/timex.h
> > +++ b/arch/openrisc/include/asm/timex.h
> > @@ -23,6 +23,9 @@ static inline cycles_t get_cycles(void)
> >  {
> >  	return mfspr(SPR_TTCR);
> >  }
> > +#define get_cycles get_cycles
> > +
> > +#define random_get_entropy() ((unsigned long)get_cycles() + 1)
> >  
> >  /* This isn't really used any more */
> >  #define CLOCK_TICK_RATE 1000
> 
> Thanks,
> 
> -Stafford
