Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449974E64C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbiCXOOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiCXOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:14:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B0C1D0C6;
        Thu, 24 Mar 2022 07:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BF5DB8232E;
        Thu, 24 Mar 2022 14:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92F3C340EC;
        Thu, 24 Mar 2022 14:13:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JEtwjSNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648131186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIzr5thlPNjUyjVa4lUMwHixNT/M39WCVGTM0oAMfZU=;
        b=JEtwjSNz2LZg0tI9/HGyYOG1kc4uwj2Uvp29Jq5wtFo0xAWyhNgagOkMgTc4zG5ysqarcB
        Y+jb0O3X9MBWI/M3IAKtT4r1JftQD1OLYPw9+yyOKJqpG/lTCIBW07QKsxQyJ9XX5mpzIH
        qwiwRrWJ1MysJfEkRzbZPHw+js5e5Eg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1efc11bd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Mar 2022 14:13:06 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id m67so8682890ybm.4;
        Thu, 24 Mar 2022 07:13:05 -0700 (PDT)
X-Gm-Message-State: AOAM533X+on28a+d6DeejMi/6V/T8Oe8kxKP0WHZrJjEc2uoMxsxiPZ/
        H7C305H7w6KRD4wieAkCXKNartq5A5aqT7G671c=
X-Google-Smtp-Source: ABdhPJwjwuRIdCRVKdNMt23qr40BTyRImQIRzFEJcxyV5Q31c6sohQ1XrN1AC7qHXVmIbtw5ZZe7qol/ppCLZ2zPLVs=
X-Received: by 2002:a5b:cd1:0:b0:633:6f7d:ef98 with SMTP id
 e17-20020a5b0cd1000000b006336f7def98mr4623574ybr.267.1648131184658; Thu, 24
 Mar 2022 07:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220322191436.110963-1-Jason@zx2c4.com> <6716f3ffefae4ed8b5fd332bfcca8a9a@AcuMS.aculab.com>
 <YjqLAWbZ8K7eg3Fw@zx2c4.com> <3707a8f9-93e7-ee54-42a3-ac12a279c6bc@rasmusvillemoes.dk>
In-Reply-To: <3707a8f9-93e7-ee54-42a3-ac12a279c6bc@rasmusvillemoes.dk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Mar 2022 08:12:53 -0600
X-Gmail-Original-Message-ID: <CAHmME9r4HLCatEi2s5WGsq1GiBPYs=3-SHE4Tw=+9_5u0q25DQ@mail.gmail.com>
Message-ID: <CAHmME9r4HLCatEi2s5WGsq1GiBPYs=3-SHE4Tw=+9_5u0q25DQ@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>, Jann Horn <jannh@google.com>
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

Hi Rasmus,

On Wed, Mar 23, 2022 at 2:43 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 23/03/2022 03.50, Jason A. Donenfeld wrote:
>
> > - Since these seeding shell scripts have always been broken, because
> >   this is how the rng has always been, rather than trying to bolt on a
> >   very imperfect fix in the kernel for something that never worked
> >   right, we could suggest shell scripts take the path that I implemented
> >   for systemd:
> >   https://github.com/systemd/systemd/commit/da2862ef06f22fc8d31dafced6d2d6dc14f2ee0b
> >   In shell, this would look like:
> >
> >     #!/bin/bash
> >     cat seedfile > /dev/urandom
> >     { cat seedfile; head -c 32 /dev/urandom; } | sha256sum | cut -d ' ' -f 1 > seedfile
>
> Maybe stating the obvious, but in the interest of preventing
> proliferation of more broken shell scripts: The tail of the above should
> be spelled
>
>   ...  > seedfile.tmp && mv seedfile.tmp seedfile
>
> or seedfile would be truncated before cat had a chance to read it.

You're not wrong. The actual thing that got committed is:
https://git.buildroot.net/buildroot/commit/?id=f0986de551f46e72268857fd817986e9be697cd0
which thankfully doesn't have this issue.

Jason
