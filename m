Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36815403A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbiFGQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344968AbiFGQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:20:10 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708B100516;
        Tue,  7 Jun 2022 09:20:08 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 257GJoBO025330;
        Wed, 8 Jun 2022 01:19:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 257GJoBO025330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654618791;
        bh=6jn4g0bEm4pnbqpqYo5valb6ctHlAIo3Yj8rwsQtilo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U/Obnu8qP3eDyfPEa2ueMu5okOo9mz3I4EcmjOnQIFg+NfCPrXR/Hgd+jbCy8r4TM
         9p1ROeAQ/56dphxgCypDD+pHDkVU8LIJLkPlJgjNba9//HrvwbxI0zLNo4lHP93QI/
         9g+UwvUjRmdQ9XBNL12/Aphcf/Rtsy7yzy7Js2ichMEEjAqw+I2ksHY6ZAn8xPMpw4
         jXVGsYhjnvouUdqyDoP0rSZHVTCcTTzCjJsGSWq/0Pbzdi3o89NwTDpG53wHLms2L+
         4zno6JlEvdFy+wtjIvoXJG9K1JlX2BlW65gPB0fs8tm3zyQakERR+uprcvrrAbFa7d
         OuiWz6wjNdecw==
X-Nifty-SrcIP: [209.85.210.182]
Received: by mail-pf1-f182.google.com with SMTP id j6so15909329pfe.13;
        Tue, 07 Jun 2022 09:19:51 -0700 (PDT)
X-Gm-Message-State: AOAM533cIR/QsRjrSlVXpd7+woCeptCpRdIdGpRNbtxB9D2bo9i9y05Q
        uKml8FULNHnlKz86EyBwHh/eNOF0khesLQs994w=
X-Google-Smtp-Source: ABdhPJz5DeWEk7jFaz5r/SLeE6TLHxM5/3UGC85lnyTqC7mkSeVa3DqNqn5kbJoQ1Ag0SxD1MwqgQ2YERlTO5QBkWLk=
X-Received: by 2002:a05:6a00:2349:b0:51c:29c0:82f6 with SMTP id
 j9-20020a056a00234900b0051c29c082f6mr8191041pfj.32.1654618790202; Tue, 07 Jun
 2022 09:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
In-Reply-To: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 8 Jun 2022 01:19:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZqpXw4UVzFtg55ewgCrgGu3BGHNj3mB0YNfiswAT12Q@mail.gmail.com>
Message-ID: <CAK7LNAQZqpXw4UVzFtg55ewgCrgGu3BGHNj3mB0YNfiswAT12Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: avoid regex RS for POSIX awk
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 11:43 AM Kevin Locke <kevin@kevinlocke.name> wrote:
>
> In 22f26f21774f8 awk was added to deduplicate *.mod files.  The awk
> invocation passes -v RS='( |\n)' to match a space or newline character
> as the record separator.  Unfortunately, POSIX states[1]
>
> > If RS contains more than one character, the results are unspecified.
>
> Some implementations (such as the One True Awk[2] used by the BSDs) do
> not treat RS as a regular expression.  When awk does not support regex
> RS, build failures such as the following are produced (first error using
> allmodconfig):
>
>       CC [M]  arch/x86/events/intel/uncore.o
>       CC [M]  arch/x86/events/intel/uncore_nhmex.o
>       CC [M]  arch/x86/events/intel/uncore_snb.o
>       CC [M]  arch/x86/events/intel/uncore_snbep.o
>       CC [M]  arch/x86/events/intel/uncore_discovery.o
>       LD [M]  arch/x86/events/intel/intel-uncore.o
>     ld: cannot find uncore_nhmex.o: No such file or directory
>     ld: cannot find uncore_snb.o: No such file or directory
>     ld: cannot find uncore_snbep.o: No such file or directory
>     ld: cannot find uncore_discovery.o: No such file or directory
>     make[3]: *** [scripts/Makefile.build:422: arch/x86/events/intel/intel-uncore.o] Error 1
>     make[2]: *** [scripts/Makefile.build:487: arch/x86/events/intel] Error 2
>     make[1]: *** [scripts/Makefile.build:487: arch/x86/events] Error 2
>     make: *** [Makefile:1839: arch/x86] Error 2
>
> To avoid this, use printf(1) to produce a newline between each object
> path, instead of the space produced by echo(1), so that the default RS
> can be used by awk.
>
> [1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html
> [2]: https://github.com/onetrueawk/awk
>
> Fixes: 22f26f21774f ("kbuild: get rid of duplication in *.mod files")
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> ---

Portable and clean solution!

Applied to linux-kbuild/fixes. Thanks.





-- 
Best Regards
Masahiro Yamada
