Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5295292D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiEPVXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343601AbiEPVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:23:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89043377E0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:23:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu29so28121140lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0X13uqjNwYdIdWF5gsH4FGVLE1+a8Dz5UwUWTgnJlnA=;
        b=sDdIuJSBLpwXUzgV/cidT7T3qcWOdU7KajEF1YzNd/JRtNz/CLGSzqsrvOxCZzMWp7
         Jnys5cE+YBGvLmz6gGNuzdNjv8fK8wRl+jmqsW+hSKvsIY0PuTiLpoDG9qBwjTX0SPIl
         ejOpeMDPHIPdCFPNWemfNB60WYn9uYtBijGiVUSQsqQnBcre8eXTW7iYm258/CRjL0/l
         Bikup4FGjM8uRIedMPAguPjGx3+DLWrqWiG+GLESgbRY3vnIq3Awg9mz2TEQdqU9zUvK
         7chJcLIxJCt6FD4g/vbWnJHEX29bkdQq99LeK8xzL8xDsQmxg2V2eUYZI16SrA2xFPTj
         h/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0X13uqjNwYdIdWF5gsH4FGVLE1+a8Dz5UwUWTgnJlnA=;
        b=lrVpNQsiz7+kqunI15na2+R6WrHQDHYd7iv0K14SpMl6U1p2tCtkrdTPzN62ckShqt
         DlF++lZ/t7l9daIFfkKlKX8Z6F/iMGGRRAMNDNmFtNMJ6ZS2xjkuZY0T9BH6bfExY1a/
         86YzfCGUdCCI7FHMIna4KXN8T6/GLwFH9n95OLjOUsYfm68199Gvp06bTmuBB4YsGaEv
         loq+Hnj0BUBTAZyJuX5+NUllEV+PmgNsmV5OyPpijx3NCHCa4XwUWagKa1+/ZFrOlIZr
         vvZC8c+ND7zgQE7q1kgsX//4VjeFCdslXdd4Xdlnbm6hedcsdCFZyqpA9KJ9klkhYjZG
         Wycw==
X-Gm-Message-State: AOAM53026YEvOyOPhzhhiTcHiudQAb5JxWboAtqbpfTKckXBx2Gbn8lu
        NAG4WgKTMsMbvslouRd7e8UhflDVfK5g/IIrkKH5nJGrqYY=
X-Google-Smtp-Source: ABdhPJyoZlfgGcyXBwCgV/a8OHUAiXJ0ELcBg2e2lZ34zKTVoYlJPwz1ktnYj23HVuUWIkL7HHmLVdBPtWvVtWOyx1o=
X-Received: by 2002:a05:6512:1291:b0:473:b522:ef58 with SMTP id
 u17-20020a056512129100b00473b522ef58mr14566653lfs.190.1652736181566; Mon, 16
 May 2022 14:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220516130047.3887590-1-trix@redhat.com> <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
 <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
In-Reply-To: <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 May 2022 14:22:50 -0700
Message-ID: <CAKwvOd=-H+rvt83rgrR3GyXdSDe+n0aG8CFLEshij9jNAzCQtw@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
To:     Tom Rix <trix@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nathan Chancellor <nathan@kernel.org>, arnd@arndb.de,
        gregkh@linuxfoundation.org, ricky_wu@realtek.com,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:06 AM Tom Rix <trix@redhat.com> wrote:
>
>
> On 5/16/22 8:56 AM, Nathan Chancellor wrote:
> > On Mon, May 16, 2022 at 09:00:47AM -0400, Tom Rix wrote:
> >> The clang build fails with
> >> rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >>          } else if (efuse_valid == 0) {
> >>                     ^~~~~~~~~~~~~~~~
> >>
> >> setting_reg2 is set in this block
> >>    if (efuse_valid == 2 || efuse_valid == 3) {
> >> ..
> >>    } else if (efuse_valid == 0) {
> >>      // default
> >> ..
> >>    }
> >> But efuse_valid can also have a value of 1.
> >> Change the 'else if' to 'else' to make the second block the default.
> >>
> >> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> > I am not sure if this fix is correct from a functional standpoint (i.e.
> > is treating efuse_valid == 1 the same as efuse_valid == 0 correct?) but
> > it is better than not handling this value altogether. For what it's
> > worth:
>
> I looked at how the code used to work, this seemed better than
> initializing to NULL.
>
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > As a side note, it is unfortunate that this change made it into -next
> > when there was an outstanding report about this warning:
>
>  From the clang side, this is a build break and my static analysis infra
> goes down.
>
> These build breaks seem to happening every week, is there a precommit
> clang gating test that could be done for -next ?

Probably worth asking Stephen, though I don't think there's _any_
gating (i.e. presubmit testing) for -next, since that'd increase the
build capacity needed. -next is tested post-merge (i.e. post submit
testing) IIUC.

>
> Tom
>
> >
> > https://lore.kernel.org/202205100220.WyAyhKap-lkp@intel.com/
> >
> >> ---
> >>   drivers/misc/cardreader/rts5261.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> >> index 749cc5a46d13..f22634b14dc8 100644
> >> --- a/drivers/misc/cardreader/rts5261.c
> >> +++ b/drivers/misc/cardreader/rts5261.c
> >> @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
> >>                      setting_reg1 = PCR_SETTING_REG4;
> >>                      setting_reg2 = PCR_SETTING_REG5;
> >>              }
> >> -    } else if (efuse_valid == 0) {
> >> +    } else {
> >>              // default
> >>              setting_reg1 = PCR_SETTING_REG1;
> >>              setting_reg2 = PCR_SETTING_REG2;
> >> --
> >> 2.27.0
> >>
> > Cheers,
> > Nathan
> >
>


-- 
Thanks,
~Nick Desaulniers
