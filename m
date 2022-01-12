Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB3148CF03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiALXPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiALXPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:15:24 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D52C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:15:24 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso6869987pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/y2AAoWg0jo7n/Hplc5uIX7ONjc1oVp5Pl/tJw5N/bY=;
        b=ct3L7doJdQkcZMxdhA0xSjCLCeqq29INV0vAvLZJ/PoHgqdf6L3aOZAVhVJC1twVgy
         UzIY3r9n7wNgxSZXlpuG7Rl2GC6ygpvo8XmvEECrMObCy5Rt7QBIntpHqSLUSvtT9Tik
         aqiDhzzGbOTzTSg180N2ZyRC7oLcBRqKO/6RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/y2AAoWg0jo7n/Hplc5uIX7ONjc1oVp5Pl/tJw5N/bY=;
        b=R7tH1/9a5EyC+l05nEjuaN+MfGtOyk7uQi5bvpxuYVMc4P/pBfbIFSionmK8E5+2ZK
         E3s3PZ2wUelRCUeP+y+DtSc711wYt3/wyB/WZry/6Lgk9qAPrjaFprnp5Ozqs3OO1T34
         G+QhvHl1T/B5fu/4Tz25Ie7cyk4HLVFX80/L7WD5hL7I8mLyRRITv/VDiRQGlHJOBj58
         Gx/S6yep63shQZ5TOyqxb2szRanrCyqAlxUFEyRV5b6jA3eu16ZAOg0E1+dUyaP+RgRv
         riU2031inlxooSnHFdzQhNGV6+/amQKx7iGYoitSIKa/czTLpSoufpIwdQLnZASI1F25
         S/qw==
X-Gm-Message-State: AOAM533Gq4tB54y/tV9kUoGEzyycPuLgMMVo7SCLKulKz62szmJK+VMF
        DIcjnDCjQjDKMCGRC2ZG1aoM+A==
X-Google-Smtp-Source: ABdhPJzsXk6JsYAFimqDxGcn80EZtzgRfrXjeMB3Em9qLPu/9WL/yzdgzVKl9kVoSu3y9oy78IKdSg==
X-Received: by 2002:a17:902:d304:b0:14a:3d9d:3208 with SMTP id b4-20020a170902d30400b0014a3d9d3208mr1973241plc.86.1642029323634;
        Wed, 12 Jan 2022 15:15:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 10sm624376pfm.56.2022.01.12.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:15:23 -0800 (PST)
Date:   Wed, 12 Jan 2022 15:15:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][RESEND] sata_fsl: Use struct_group() for memcpy() region
Message-ID: <202201121515.8679164D6@keescook>
References: <20220112220652.3952944-1-keescook@chromium.org>
 <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 03:23:40PM -0700, Jens Axboe wrote:
> On 1/12/22 3:06 PM, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Use struct_group() in struct command_desc around members acmd and fill,
> > so they can be referenced together. This will allow memset(), memcpy(),
> > and sizeof() to more easily reason about sizes, improve readability,
> > and avoid future warnings about writing beyond the end of acmd:
> > 
> > In function 'fortify_memset_chk',
> >     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> > ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> >   199 |    __write_overflow_field();
> >       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-ide@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Jens, can you take (or Ack) this? It's a dependency for the FORTIFY_SOURCE
> > improvements that are close to being finished. :)
> 
> I don't maintain libata anymore, so Damien is the guy to nudge ;-)

Ah-ha, okay, thanks.

/me waves "hi" to Damien. :)

-- 
Kees Cook
