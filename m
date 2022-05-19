Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5D52DF40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbiESVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbiESVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:24:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE54AED787
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C459B8251E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B097C385AA;
        Thu, 19 May 2022 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652995492;
        bh=FsRbufRw+MhQWn7vapVa5XTrm9yYh+z9BmU03OnXMTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwaz7ixed+wrvid/0u6qLFmvVD2CGVrr/P94NvjGC+YeRqmWUZsz39VuBwt1lxCPg
         1fRaAKbyj+a5xEfJlv++rcSZQeTh+UwhhCaLbVXsggm7n/iu9V+Je8tnjzuWem46rp
         hZbyiXN11TGFol2xlbxUOGChMDCG4EYS/k4z7MOVXNcYR+HpoH4qFVnYdC4wJ2XnDC
         2/52GNWEl1/TZ5oSe9neBQmMWzu7628oBVd5iVT7OCR9h1XWaMACGsi9s8SC2tE2zW
         cipe2S5Qf6OHa16pUXFkNDGQ82S8+lqiLeR1LCrAmR68FYPtZjz+Eg+N4l3qL4cEZb
         u8l9/pFtR6RkQ==
Date:   Thu, 19 May 2022 14:24:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Ricky WU <ricky_wu@realtek.com>, miquel.raynal@bootlin.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
Message-ID: <Yoa1ob+KHFz0fsdu@dev-arch.thelio-3990X>
References: <20220516130047.3887590-1-trix@redhat.com>
 <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
 <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
 <CAAd53p57APcectWW-NN_=HE6JkTQRk717cWNZ5iJcP+MtEYjog@mail.gmail.com>
 <bab0c4250147420a842f3e966a8264a6@realtek.com>
 <YoavUdiAJXPqsU7Q@dev-arch.thelio-3990X>
 <6e3f182e-73ac-9c1d-9fb1-1fb360b1a6cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e3f182e-73ac-9c1d-9fb1-1fb360b1a6cd@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 02:18:59PM -0700, Tom Rix wrote:
> 
> On 5/19/22 1:57 PM, Nathan Chancellor wrote:
> > On Tue, May 17, 2022 at 08:10:17AM +0000, Ricky WU wrote:
> > > > -----Original Message-----
> > > > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Sent: Tuesday, May 17, 2022 9:53 AM
> > > > To: Tom Rix <trix@redhat.com>
> > > > Cc: Nathan Chancellor <nathan@kernel.org>; arnd@arndb.de;
> > > > gregkh@linuxfoundation.org; ndesaulniers@google.com; Ricky WU
> > > > <ricky_wu@realtek.com>; linux-kernel@vger.kernel.org; llvm@lists.linux.dev
> > > > Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
> > > > 
> > > > On Tue, May 17, 2022 at 1:06 AM Tom Rix <trix@redhat.com> wrote:
> > > > > 
> > > > > On 5/16/22 8:56 AM, Nathan Chancellor wrote:
> > > > > > On Mon, May 16, 2022 at 09:00:47AM -0400, Tom Rix wrote:
> > > > > > > The clang build fails with
> > > > > > > rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized
> > > > whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> > > > > > >           } else if (efuse_valid == 0) {
> > > > > > >                      ^~~~~~~~~~~~~~~~
> > > > > > > 
> > > > > > > setting_reg2 is set in this block
> > > > > > >     if (efuse_valid == 2 || efuse_valid == 3) { ..
> > > > > > >     } else if (efuse_valid == 0) {
> > > > > > >       // default
> > > > > > > ..
> > > > > > >     }
> > > > > > > But efuse_valid can also have a value of 1.
> > > > > > > Change the 'else if' to 'else' to make the second block the default.
> > > > > > > 
> > > > > > > Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
> > > > > > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > > > > I am not sure if this fix is correct from a functional standpoint (i.e.
> > > > > > is treating efuse_valid == 1 the same as efuse_valid == 0 correct?)
> > > > > > but it is better than not handling this value altogether. For what
> > > > > > it's
> > > > > > worth:
> > > > > I looked at how the code used to work, this seemed better than
> > > > > initializing to NULL.
> > > > Or maybe use a single if block?
> > > > 
> > > > u16 setting_reg1 =PCR_SETTING_REG1 , setting_reg2 =
> > > > PCR_SETTING_REG2; ...
> > > > if ((efuse_valid == 2 || efuse_valid == 3) && (valid != 3) {
> > > >      setting_reg1 = PCR_SETTING_REG4;
> > > >      setting_reg2 = PCR_SETTING_REG5;
> > > > }
> > > > 
> > > > Kai-Heng
> > > > 
> > > > > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > > > > 
> > > > > > As a side note, it is unfortunate that this change made it into
> > > > > > -next when there was an outstanding report about this warning:
> > > > >   From the clang side, this is a build break and my static analysis
> > > > > infra goes down.
> > > > > 
> > > > > These build breaks seem to happening every week, is there a precommit
> > > > > clang gating test that could be done for -next ?
> > > > > 
> > > > > Tom
> > > > > 
> > > > > > https://lore.kernel.org/202205100220.WyAyhKap-lkp@intel.com/
> > > > > > 
> > > > > > > ---
> > > > > > >    drivers/misc/cardreader/rts5261.c | 2 +-
> > > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/misc/cardreader/rts5261.c
> > > > > > > b/drivers/misc/cardreader/rts5261.c
> > > > > > > index 749cc5a46d13..f22634b14dc8 100644
> > > > > > > --- a/drivers/misc/cardreader/rts5261.c
> > > > > > > +++ b/drivers/misc/cardreader/rts5261.c
> > > > > > > @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr
> > > > *pcr)
> > > > > > >                       setting_reg1 = PCR_SETTING_REG4;
> > > > > > >                       setting_reg2 = PCR_SETTING_REG5;
> > > > > > >               }
> > > > > > > -    } else if (efuse_valid == 0) {
> > > > > > > +    } else {
> > > > > > >               // default
> > > > > > >               setting_reg1 = PCR_SETTING_REG1;
> > > > > > >               setting_reg2 = PCR_SETTING_REG2;
> > > Sorry for the trouble
> > > here can be changed to
> > > ...
> > > } else if (efuse_valid == 0) {
> > > 		// default
> > > 		setting_reg1 = PCR_SETTING_REG1;
> > > 		setting_reg2 = PCR_SETTING_REG2;
> > > } else {
> > >   return;
> > > }
> > > Because other values are invalid
> > Tom, were you going to send a v2 of this?
> 
> No.
> 
> Miquèl has the best fix.
> 
> https://lore.kernel.org/lkml/20220518170920.4db16990@xps-13/

Different warning/patch I think? There are too many of these flying
around as of late :( this one doesn't have a new version from what I can
tell.

I do see a fix for that one available:

https://lore.kernel.org/20220519132300.424095-1-miquel.raynal@bootlin.com/

Cheers,
Nathan
