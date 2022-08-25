Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F635A1A26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbiHYURY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbiHYURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53DEC00E4;
        Thu, 25 Aug 2022 13:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52720614F3;
        Thu, 25 Aug 2022 20:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6D4C433C1;
        Thu, 25 Aug 2022 20:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661458635;
        bh=dLKe38UMDVEYT5k7ufeHLWp48ewEBHqhZ8c9eWlkaCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PjKM1Ak0f3M5+xQQfWzE0Lse4CYpUCFYHMVtNu7yJk/Pam38a9gbg8BavsL8nbZsa
         JdtthUeA8KilXMEBQM10NBWzS8qL5qZ35TgKdv1ADUmmmrVm7kMg7Z9I0eTNyGGyaY
         bQBDE50MARwOtPTgRSxgMxBMCBofjtFqRWDmeZIbWCw2OoYv8BARQ32UT1VgGQMgGH
         p3grRNWwDNW7EyXM0pnrz2Rmr/cqObisuhI9N2QYuJhPMRhP0DzIerSYEe7tgnsLXV
         oSkOgiQ67qRq2xQQu7/zYRVcXsh2+4+svAE61f5fNkFmZQPNyKN2p8qv6RxbbSZpm8
         M+l3eVmzzfDlw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B885404A1; Thu, 25 Aug 2022 17:17:12 -0300 (-03)
Date:   Thu, 25 Aug 2022 17:17:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Zixuan Tan <tanzixuan.me@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/genelf: Switch deprecated openssl MD5_* functions
 to new EVP API
Message-ID: <YwfYyLE3ajSFVHGQ@kernel.org>
References: <CABwm_eTnARC1GwMD-JF176k8WXU1Z0+H190mvXn61yr369qt6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABwm_eTnARC1GwMD-JF176k8WXU1Z0+H190mvXn61yr369qt6g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 26, 2022 at 01:00:58AM +0800, Zixuan Tan escreveu:
> Switch to the flavored EVP API like in test-libcrypto.c, and remove the
> bad gcc #pragma.
> 
> Inspired-By: 5b245985a6de ("tools build: Switch to new openssl API for
> test-libcrypto")

How did you test the end result? Can you please describe step by step?

Also please consider adding a 'perf test' entry to make sure this
doesn't regress.

Thanks,

- Arnaldo

> Signed-off-by: Zixuan Tan <tanzixuan.me@gmail.com>
> ---
>  tools/perf/util/genelf.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index 953338b9e887..ed28a0dbcb7f 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -30,10 +30,6 @@
> 
>  #define BUILD_ID_URANDOM /* different uuid for each run */
> 
> -// FIXME, remove this and fix the deprecation warnings before its removed and
> -// We'll break for good here...
> -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> -
>  #ifdef HAVE_LIBCRYPTO_SUPPORT
> 
>  #define BUILD_ID_MD5
> @@ -45,6 +41,7 @@
>  #endif
> 
>  #ifdef BUILD_ID_MD5
> +#include <openssl/evp.h>
>  #include <openssl/md5.h>
>  #endif
>  #endif
> @@ -142,15 +139,20 @@ gen_build_id(struct buildid_note *note,
>  static void
>  gen_build_id(struct buildid_note *note, unsigned long load_addr,
> const void *code, size_t csize)
>  {
> -       MD5_CTX context;
> +       EVP_MD_CTX *mdctx;
> 
>         if (sizeof(note->build_id) < 16)
>                 errx(1, "build_id too small for MD5");
> 
> -       MD5_Init(&context);
> -       MD5_Update(&context, &load_addr, sizeof(load_addr));
> -       MD5_Update(&context, code, csize);
> -       MD5_Final((unsigned char *)note->build_id, &context);
> +       mdctx = EVP_MD_CTX_new();
> +       if (!mdctx)
> +               errx(2, "failed to create EVP_MD_CTX");
> +
> +       EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
> +       EVP_DigestUpdate(mdctx, &load_addr, sizeof(load_addr));
> +       EVP_DigestUpdate(mdctx, code, csize);
> +       EVP_DigestFinal_ex(mdctx, (unsigned char *)note->build_id, NULL);
> +       EVP_MD_CTX_free(mdctx);
>  }
>  #endif
> 
> -- 
> 2.34.1

-- 

- Arnaldo
