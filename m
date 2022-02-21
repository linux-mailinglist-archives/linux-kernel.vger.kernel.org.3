Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853A4BE9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378757AbiBUPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:04:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378698AbiBUPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:04:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F9BC3B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA8C6117F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCABC340EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:04:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q9oeRAwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645455858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hM71yuCM3+OXKIMaiJcGjymZ4zvSvahj07CTrhoP1E4=;
        b=Q9oeRAwVJh9PFo6nwNel5ZNfv9JS8KBr8eV+OjGwEBrfQuj8ZM/SeFYkWFonvRjjCB7cjq
        X4ygtTClaRkb+4pxG5UjZ24wkzTFP3xzGmVtVey6T9mOeKfXp2CeILL7qcaW9/SCZpBCFr
        6GGS3PmqG1tep5WJr9nAtpxFqZhkchs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89c259e4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 15:04:18 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d646fffcc2so141254877b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:04:18 -0800 (PST)
X-Gm-Message-State: AOAM531wTLy5QBu+GT3UFgNxJ0bGjekshF0lYSqH4NnQ64+ReFpiRYpX
        snh9DJNijA1a7A+Rfm+NTb8isV9bY/Lcg7kjDZ4=
X-Google-Smtp-Source: ABdhPJw7BIn2BtCVdNm5s48y6S3hg0n68pBaEMLctwzmD2tSApTLpY2wsPw/QIVEiZ1nRhFNe/65FznIm1urhsj4rPs=
X-Received: by 2002:a81:5c83:0:b0:2d2:c136:70f3 with SMTP id
 q125-20020a815c83000000b002d2c13670f3mr20917580ywb.404.1645455857226; Mon, 21
 Feb 2022 07:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20220209135211.557032-1-Jason@zx2c4.com> <20220209180507.646941-1-Jason@zx2c4.com>
 <YhMM1C7n4ipZcQE3@sol.localdomain>
In-Reply-To: <YhMM1C7n4ipZcQE3@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 16:04:06 +0100
X-Gmail-Original-Message-ID: <CAHmME9o5XzZVQUKBkS7d30AwVvPX3weyHdBsUBOK7fKaQO0JMA@mail.gmail.com>
Message-ID: <CAHmME9o5XzZVQUKBkS7d30AwVvPX3weyHdBsUBOK7fKaQO0JMA@mail.gmail.com>
Subject: Re: [PATCH v2] random: make more consistent use of integer types
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 4:54 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > -static size_t crng_fast_load(const u8 *cp, size_t len)
> > +static size_t crng_fast_load(const void *cp, size_t len)
> >  {
> >       unsigned long flags;
> > -     u8 *p;
> > +     u8 *src = (u8 *)cp;
>
> This should use 'const u8 *'.

Will fix.

>
> >  int __init rand_initialize(void)
> >  {
> > -     int i;
> > +     size_t i;
> >       ktime_t now = ktime_get_real();
>
> This introduces an assumption that BLAKE2S_BLOCK_SIZE % sizeof(unsigned long) ==
> 0.  That happens to always be true, but it would be better to either not change
> this, or rewrite the loop to 'i = 0; i < BLAKE2S_BLOCK_SIZE; i += sizeof(rv)'

Good idea; I'll rewrite the loop. That always bothered me too.

Jason
