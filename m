Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7B53E288
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiFFHfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiFFHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:35:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186BF248D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:35:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LGld70rS2z4xDK;
        Mon,  6 Jun 2022 17:35:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1654500907;
        bh=VXk24EbNzKUoMXno58Py6qg0gnRf+KEUXyEIyOwIFm0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cs0nyc1uHndP9Xs2H7fKEXcwp8KKlnaaciymMe2zU54+MSROONOrStn24NoDklkMt
         fB+unGwy8tiU8yVdSWv6gOpM+kvObM6vjmgw1YAnPl0SPqydmIfvVteMkU57i+WGgF
         kHhVecbnAzwDuMzYR6lVzIHDo+ke5rLGJsvPQI7YeTKeo1rNWKnYO6k87jbZMsOhzO
         oiqYc/DUwXZ/gPfhn3Sy24Z91+USpbsIZsVFGwnrxvtaESGC3owLbJhSNWACzqzZht
         FuvUOhUy6jjSyqzFxYnfPRUqNzdKOUf+IwU/GB+t+6d27N6Rg5HPnu1Nfi37jy6IVC
         k5wjzJVdxXkeQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell Currey <ruscur@russell.cc>
Subject: Re: 5.19-rc1 build fails at scripts/check-local-export
In-Reply-To: <62ba96a2-0a0c-ab8e-351d-398f31a880ae@I-love.SAKURA.ne.jp>
References: <62ba96a2-0a0c-ab8e-351d-398f31a880ae@I-love.SAKURA.ne.jp>
Date:   Mon, 06 Jun 2022 17:34:58 +1000
Message-ID: <87tu8ynt25.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:
> Hello.
>
> Commit 31cb50b5590fe911 ("kbuild: check static EXPORT_SYMBOL* by script
> instead of modpost") introduced scripts/check-local-export but it fails
> in my CentOS 7 environment.
>
> $ rpm -q binutils bash
> binutils-2.27-44.base.el7_9.1.x86_64
> bash-4.2.46-35.el7_9.x86_64

I'm also seeing this, on Ubuntu 16.04.

$ bash --version
GNU bash, version 4.3.48(1)-release (powerpc64le-unknown-linux-gnu)

> $ make
...
>   HOSTCC  scripts/mod/mk_elfconfig
>   CC      scripts/mod/empty.o
> ./scripts/check-local-export: line 54: wait: pid 17328 is not a child of this shell
> make[2]: *** [scripts/mod/empty.o] Error 127
> make[2]: *** Deleting file `scripts/mod/empty.o'
> make[1]: *** [prepare0] Error 2
> make: *** [__sub-make] Error 2
>
> Is below change OK for you?
>
> diff --git a/scripts/check-local-export b/scripts/check-local-export
> index da745e2743b7..1631c79558b7 100755
> --- a/scripts/check-local-export
> +++ b/scripts/check-local-export
> @@ -51,7 +51,7 @@ do
>  done < <(${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } )
>  
>  # Catch error in the process substitution
> -wait $!
> +wait $! 2>/dev/null || :
>  
>  for name in "${export_symbols[@]}"
>  do

That fixes it for me.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
