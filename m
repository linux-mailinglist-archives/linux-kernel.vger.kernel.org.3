Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429154C8E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiCAOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiCAOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:55:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB197A1BCB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:54:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m22so14313132pja.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0LEShqmIhADtB98y63SiY1/Q+LarGUNjrKgaYHXELs=;
        b=Ta7xrfpQ1F4+0SvhhJ2LXZ8Y5eqK9E+b4jaCrOatAf8/kpUp0JUGuLwwQESLUwyUq7
         3IIZA0VbEcFFf5HX6zSDYt+NWzfzZwC8GcLXihxBLwDa1hdTKjouKzg/AvHNoccy/Qg6
         YHHbyBe90vT51ZLTzmoTSBoyLBHOXw+k9e6+C8FF/+NQ78TFcsnCoSsujnDCwevPnygz
         ZYBTl77h1K0CO3Gfe98D9vrf4NpEcm5mPFhwaLXhYafSNZlTRC0MBZ4mOphBHOGTGDH0
         eugVYAFhI3K1w12kBI2Wm8u/6NN2l2nzM/DRYDGWol5fLqonfipGCCWuuP+pu/x/6Arf
         NEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0LEShqmIhADtB98y63SiY1/Q+LarGUNjrKgaYHXELs=;
        b=4/4+nxmWOX/3K9APab7Q/0nvYmoH7Y+4C2/5HF3SNBWIarJ1bOMWEDYeqjVFTatO6W
         uY/aowK/bEOLqkLKwqhbUnSFfPzniiPJhrCU0mo+a8Uop/PPRm6ILxomkNFaHLx/QGLs
         8jIXnD2cNlC7++4n4CG7Dcw1xQm/E6hYNF8mxA7lcGteximISpuiX6gbPrlslAUXRnMa
         ZnKVfHs82PpB4g1svKr5X8oXOD5d5WR//FT4awcoxxdQokwanD1jZ2b8BqWj6s+hxFWw
         jR5866vg9JEorE496LO3eGaCgT3I94uAQ67gA+YLf4ju/PaXlltqzjFGl3VZtsCRYzsT
         m6Bg==
X-Gm-Message-State: AOAM5321mPv3yrDm63oixgRLiJ43Vi4qwSfSJwcPZaOCIIUpAztVKY9Y
        /xp8fyPORGE6wB5rMPTtw9NhR78A0pr4Ql/cDxo3Sg==
X-Google-Smtp-Source: ABdhPJy0cdFS33vtWbPRgP3waAuLsK6+yuO4ys6zltYHiy3GgDdT0XJ40EuAylqyt1rzPgwW8O2GS4y2+zcn40OCxNg=
X-Received: by 2002:a17:902:8c85:b0:151:83cd:40cb with SMTP id
 t5-20020a1709028c8500b0015183cd40cbmr3042653plo.70.1646146471278; Tue, 01 Mar
 2022 06:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20220204093359.359059-1-jens.wiklander@linaro.org>
 <20220204093359.359059-9-jens.wiklander@linaro.org> <CAHUa44HkQtstCyUt_J962rzysFnOJOP+e3T2gL7nV+6V5hfa9A@mail.gmail.com>
 <YhLweBhnmITyErqG@kernel.org>
In-Reply-To: <YhLweBhnmITyErqG@kernel.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 1 Mar 2022 15:54:20 +0100
Message-ID: <CAHUa44Ex0i345f-USHJ-QovTf3ZYs0rTDufYGrtaZJNVksKqgQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 2:52 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Feb 09, 2022 at 03:08:48PM +0100, Jens Wiklander wrote:
> > Hi Jarkko,
> >
> > On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > Uses the new simplified tee_shm_register_kernel_buf() function instead
> > > of the old tee_shm_alloc() function which required specific
> > > TEE_SHM-flags
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
> > >  1 file changed, 9 insertions(+), 14 deletions(-)
> >
> > Since this patch depends on other patches in this patch set and vice
> > versa is it OK if I take this patch via my tree? I'm aiming for v5.18
> > with this.
>
> Yes.
>
> You can also add:
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko

Thanks. Unfortunately it's a bit late to apply the R-B, I've already
sent the pull request to arm-soc and it has been imported into that
tree.

Thanks,
Jens
