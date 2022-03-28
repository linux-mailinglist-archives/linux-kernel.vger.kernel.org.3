Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADC4E8C44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiC1CrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiC1CrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:47:05 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A62AC59
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:45:25 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id kl29so10893512qvb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ic1J9Xu9303zvCU0MVW+zENYERz0NLxNdtebxDnbdrk=;
        b=LJfXcx4kB3L/EmjBwCdZzWO5h/ewkMWZHucZk8iSl6Wt9Rl/9QnRbBsuaMLQGJGaQo
         5+g90bNOKWxBhNI9y9KPIhcPEpqDZGQDwhWyPe0hMXnWCpgg1IRCxPWBKzGe0JPNGzDp
         2BIBfofHn5Njx1H/ngGxURv/QQr6naxV1I9dnvxexcr64SP1+sQ6Viuzv1Y3mjxQLfOJ
         2SRb0wAo/JU07aAz590fnvdIx3Dfvxy55kHxuHaU+3BIGZURRPUiKqI5O7uTwN+tC7Aw
         dP0uPw/yxlRdhtMmCZTuyRA0WmKzafQpRklsPCRlarF9qfbazOrg4CRPO3m8CAgy9ALA
         efNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ic1J9Xu9303zvCU0MVW+zENYERz0NLxNdtebxDnbdrk=;
        b=10ttPrsTaora5MJRO97jAcnjwkdGlrG3W1SHpMcRYADBIrD5UEG8Re/UEqQi5lhR0B
         jqK3Knn3tuaUMIg30HXM74D63+MZhenV559JKjRSHwr9EL8qjSfRyysejr/GVuGpOZYJ
         t47aXu4kgkJPqY9xpew6SUhWZYgNoczLRBtYGuW0EznXOJKNCGyG9sGGOLykrAwq1rjD
         JUapnDAw+aOb5RxqnCEOEx7oFaMmfJgfydS6AOGOO0EoITII804R1BfYu9A4NUbckoYn
         ZHj03dqvHhQstgb094BhVhfXdiEZW6kUlu5ckPsStgpOpo+Uf+jVxhrL3olH0mTwbzLc
         qG5w==
X-Gm-Message-State: AOAM532/65qoiUqo5E+YqaGWGeT/701A4wWpTkzWtIZmBngXmV2NKL0B
        SX5VFFz/RmUgmTbB3VyVFS8=
X-Google-Smtp-Source: ABdhPJxmiOh2roAno966gtbALYyV+hgFZpJLzOKa9nXusciGi0RzN+ik8jpImK/+/AzDzPtLNmiO9A==
X-Received: by 2002:a05:6214:20a6:b0:443:5818:ade2 with SMTP id 6-20020a05621420a600b004435818ade2mr1721823qvd.84.1648435524791;
        Sun, 27 Mar 2022 19:45:24 -0700 (PDT)
Received: from localhost ([98.242.64.6])
        by smtp.gmail.com with ESMTPSA id t128-20020a37aa86000000b0060ddf2dc3ecsm7231756qke.104.2022.03.27.19.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 19:45:24 -0700 (PDT)
Date:   Sun, 27 Mar 2022 19:45:22 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: Pull request for bitmap branch
Message-ID: <YkEhQiJkFmCLeYy6@yury-laptop>
References: <YkEK37hEhUcl5NUU@yury-laptop>
 <20220328131756.5aa6b7aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328131756.5aa6b7aa@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 01:17:56PM +1100, Stephen Rothwell wrote:
> Hi Yury,
> 
> On Sun, 27 Mar 2022 18:09:51 -0700 Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Can you please pull this branch for linux-next?
> > https://github.com/norov/linux/tree/bitmap
> 
> Normally, I don't add new branches to linux-next during the merge
> window.  An exception is for branches that only contain changes meant
> to be merged by Linus during the current merge window.  Even then, this
> is very late to the table :-(

OK. I'll send a reminder when the window will be closed.
 
> Also, you should tell me the branch name I need to fetch (which I will
> refetch every day, so it should be a good stable name - like
> "for-next"), and if this branch will be merged directly by Linus, or
> through some other tree.

I'll rename it to 'bitmap-for-next'. Thanks.

> OK, I just checked ... the above URL is not a git tree.  I suspect you
> meant me to fetch the "bitmap" branch of
> https://github.com/norov/linux.git, right?

Yes

> One more thing, that branch is based on Linus' tree of today, so really
> cannot have received much testing in its current form :-(

Rebasing this series from 5.17 to origin/master causes a couple merge
conflicts, so I decided to simplify your work.

Are you OK if I rebase it on 5.18-rc1 when it will be created and send
new request?

Thanks,
Yury
