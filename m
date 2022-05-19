Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5218452DED5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiESU6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244382AbiESU57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0856EC3D2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6D34B8288F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA3BC385AA;
        Thu, 19 May 2022 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652993875;
        bh=x13lgvI1NLwKjefgh/hXMZpz1ml1ACd9zj8zDJhtgss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILD2JdyTZXM7ZphRjpyODgeNLgnu8bVwFsXmlbUD0j7AE/lNSxsr7ekXLyVE1PtCC
         wbhK/59K1EUVkHa1PeUCWWPpQllkNkc8hN9gr5IdYBxwvKPF+vbXyb8rfyAm6uCW/r
         MTpZo+wXhBfWoB0dyGOD5Vqv+TNYslfbO1evBgnh4yXW6mIgYx7E61rRR3gMk9SW59
         qw0BkoEmh/Mdh1fk74cuAp9Kce+StedldvEWVOlQSFBD9tw50CpfEkoc2qrVVTUUcH
         Ln1yE0+BB6zw0S7C4xiDQKbWjl0K979nQqP60RsQdPaQrOzgDUwXc6W68dGalemoQI
         8rmocEXHcASQA==
Date:   Thu, 19 May 2022 13:57:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tom Rix <trix@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
Message-ID: <YoavUdiAJXPqsU7Q@dev-arch.thelio-3990X>
References: <20220516130047.3887590-1-trix@redhat.com>
 <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
 <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
 <CAAd53p57APcectWW-NN_=HE6JkTQRk717cWNZ5iJcP+MtEYjog@mail.gmail.com>
 <bab0c4250147420a842f3e966a8264a6@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab0c4250147420a842f3e966a8264a6@realtek.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:10:17AM +0000, Ricky WU wrote:
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Tuesday, May 17, 2022 9:53 AM
> > To: Tom Rix <trix@redhat.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>; arnd@arndb.de;
> > gregkh@linuxfoundation.org; ndesaulniers@google.com; Ricky WU
> > <ricky_wu@realtek.com>; linux-kernel@vger.kernel.org; llvm@lists.linux.dev
> > Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
> > 
> > On Tue, May 17, 2022 at 1:06 AM Tom Rix <trix@redhat.com> wrote:
> > >
> > >
> > > On 5/16/22 8:56 AM, Nathan Chancellor wrote:
> > > > On Mon, May 16, 2022 at 09:00:47AM -0400, Tom Rix wrote:
> > > >> The clang build fails with
> > > >> rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized
> > whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> > > >>          } else if (efuse_valid == 0) {
> > > >>                     ^~~~~~~~~~~~~~~~
> > > >>
> > > >> setting_reg2 is set in this block
> > > >>    if (efuse_valid == 2 || efuse_valid == 3) { ..
> > > >>    } else if (efuse_valid == 0) {
> > > >>      // default
> > > >> ..
> > > >>    }
> > > >> But efuse_valid can also have a value of 1.
> > > >> Change the 'else if' to 'else' to make the second block the default.
> > > >>
> > > >> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
> > > >> Signed-off-by: Tom Rix <trix@redhat.com>
> > > > I am not sure if this fix is correct from a functional standpoint (i.e.
> > > > is treating efuse_valid == 1 the same as efuse_valid == 0 correct?)
> > > > but it is better than not handling this value altogether. For what
> > > > it's
> > > > worth:
> > >
> > > I looked at how the code used to work, this seemed better than
> > > initializing to NULL.
> > 
> > Or maybe use a single if block?
> > 
> > u16 setting_reg1 =PCR_SETTING_REG1 , setting_reg2 =
> > PCR_SETTING_REG2; ...
> > if ((efuse_valid == 2 || efuse_valid == 3) && (valid != 3) {
> >     setting_reg1 = PCR_SETTING_REG4;
> >     setting_reg2 = PCR_SETTING_REG5;
> > }
> > 
> > Kai-Heng
> > 
> > >
> > > >
> > > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > >
> > > > As a side note, it is unfortunate that this change made it into
> > > > -next when there was an outstanding report about this warning:
> > >
> > >  From the clang side, this is a build break and my static analysis
> > > infra goes down.
> > >
> > > These build breaks seem to happening every week, is there a precommit
> > > clang gating test that could be done for -next ?
> > >
> > > Tom
> > >
> > > >
> > > > https://lore.kernel.org/202205100220.WyAyhKap-lkp@intel.com/
> > > >
> > > >> ---
> > > >>   drivers/misc/cardreader/rts5261.c | 2 +-
> > > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/misc/cardreader/rts5261.c
> > > >> b/drivers/misc/cardreader/rts5261.c
> > > >> index 749cc5a46d13..f22634b14dc8 100644
> > > >> --- a/drivers/misc/cardreader/rts5261.c
> > > >> +++ b/drivers/misc/cardreader/rts5261.c
> > > >> @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr
> > *pcr)
> > > >>                      setting_reg1 = PCR_SETTING_REG4;
> > > >>                      setting_reg2 = PCR_SETTING_REG5;
> > > >>              }
> > > >> -    } else if (efuse_valid == 0) {
> > > >> +    } else {
> > > >>              // default
> > > >>              setting_reg1 = PCR_SETTING_REG1;
> > > >>              setting_reg2 = PCR_SETTING_REG2;
> 
> Sorry for the trouble 
> here can be changed to 
> ...
> } else if (efuse_valid == 0) {
> 		// default
> 		setting_reg1 = PCR_SETTING_REG1;
> 		setting_reg2 = PCR_SETTING_REG2;
> } else {
>  return;
> }
> Because other values are invalid

Tom, were you going to send a v2 of this?

Cheers,
Nathan
