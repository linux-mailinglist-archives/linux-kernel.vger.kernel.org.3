Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17350ABD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441837AbiDUXLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376864AbiDUXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248294838B;
        Thu, 21 Apr 2022 16:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9345D61E5C;
        Thu, 21 Apr 2022 23:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BA6C385A7;
        Thu, 21 Apr 2022 23:08:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K5z1dYji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650582493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlddADKQ3AGw2t0YmUp0o0GcYu9D9LCFCg+b01QDrBs=;
        b=K5z1dYji87Bm2k4wZ3J/WyCdmLUsaeMxXdB/l7aUSG1MDzKmUiJ17Xnm3WRJkhh5p6YKRt
        npQlf8IICeMIqc8QG7+MDYU3EMKer6HpHPzqXUf0+dhYxK2G+r/nKU4QTSJS5wtxatqoml
        rwZTaiOlWQT4IjTVqMWVpIPO/FDee1E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b22c2117 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 21 Apr 2022 23:08:12 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id f38so11423350ybi.3;
        Thu, 21 Apr 2022 16:08:12 -0700 (PDT)
X-Gm-Message-State: AOAM533lBwrWEleHgQJLf03hFuxiivmomfcCPmfNdHQm1iuyubIpKpdO
        W+5CjzUX00zodwSSLkx8ED6jINdAMH6+yJQOrQU=
X-Google-Smtp-Source: ABdhPJzuf7x4xjPYKmw6Ka/eN1yu3T/TGCemPFRI4D4R0m/lz7DEzWxb/TCk4a6N91tvMBDhsVqcOtwajX/7xDE4hAs=
X-Received: by 2002:a25:fe0c:0:b0:641:2884:2c7e with SMTP id
 k12-20020a25fe0c000000b0064128842c7emr1978057ybe.382.1650582491910; Thu, 21
 Apr 2022 16:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220421204320.258010-1-ebiggers@kernel.org>
In-Reply-To: <20220421204320.258010-1-ebiggers@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 22 Apr 2022 01:08:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9rtrjyE0Cqk9qvW_xxhFduvbMt5-cmjD134JCxk2iLKDQ@mail.gmail.com>
Message-ID: <CAHmME9rtrjyE0Cqk9qvW_xxhFduvbMt5-cmjD134JCxk2iLKDQ@mail.gmail.com>
Subject: Re: [PATCH] siphash: update the HalfSipHash documentation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Apr 21, 2022 at 10:44 PM Eric Biggers <ebiggers@kernel.org> wrote:
> -Danger!
> +**Danger!** HalfSipHash should only be used in a very limited set of use cases
> +where nothing better is possible, namely:
>
> -Do not ever use HalfSipHash except for as a hashtable key function, and only
> -then when you can be absolutely certain that the outputs will never be
> -transmitted out of the kernel. This is only remotely useful over `jhash` as a
> -means of mitigating hashtable flooding denial of service attacks.
> +- Hashtable key functions, where the outputs will never be transmitted out of
> +  the kernel. This is only remotely useful over `jhash` as a means of mitigating
> +  hashtable flooding denial of service attacks.

I think we should actually drop this chunk of the patch. You wrote in
your commit message, "HalfSipHash-1-3 is not entirely limited to
hashtable functions, with it now being used in the interrupt entropy
accumulator." But in fact, random.c uses HalfSipHash-1, with no three
round finalization (since we use BLAKE2s for that). So it's not
_quite_ the same thing. If it were, we could have gotten away by just
calling the actual hsiphash function, but instead it's just applying
the round function as a permutation.

If you feel strongly that somebody might accidentally copy and paste
that after grepping for halfsiphash and trying to figure out how to
use it, I suppose we could keep this. But it strikes me as very much
not the same thing as the hsiphash_* family of functions.

Jason
