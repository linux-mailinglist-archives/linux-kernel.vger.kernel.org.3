Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9385AE35C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbiIFIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiIFIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:46:01 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593367CAAD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:41:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3454e58fe53so32505687b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YtFrslcd7VroEKijkv+M1ZLM7ZldrFv64ctwlB1wWHE=;
        b=ZE32UXObWue7HNp0BR21IQMNooFVkUhN7dwgZRzIe5ybmvovLToWKWu1j8YmW/khSH
         pHIaNgZuNTBTcDWUOpfjHB7WYm7gK48OfMrqPyJ339BpsEOfV9UFKmxqXTmZK2kCH7g8
         dIN0V+opKFW6/pR/ofARA3H4ckyeG3iEZ+ZWPuT6udPAalt2x4cZriJUMm1sT2K4DJNR
         fPBJns3aBeDgpf0q5C7FAbp0LqJOhSls2JXSSRSTnKBhdV807mLtEhEWg5lTN3FbiNIS
         uGQZhscSNbRDZqz3W+WNNobLhHXBTOqrk4q3Vb6eT+goN5EtaIBE+P9xlNpcXyFdNITD
         CZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YtFrslcd7VroEKijkv+M1ZLM7ZldrFv64ctwlB1wWHE=;
        b=gLt+gCXAmMWnR7dRuUkkQejD2EHfMvGRA6VHJ3Bp23+PA/Aiwkw99P3L7SEIL6vUEc
         UmmwFGujPXDzxwBhRAJTDClDSBGbrZUfPM44YYsWXvezBfvj3dcS7PGxD+XN7xx147zZ
         e5TbpV2UzHPYE3YVwptgd35AkqZ7KpQEbsL7/hZ9MsVEu2Z1WTSrLuGQSl+uyrkVke3n
         xneVHekiqRPVO7EtipdQFSnxnv5g+S0mOnaTziCtf5hPC1Yi4UPh/9moNZhfNF/BUV2g
         bml61PumuukIFIEzDKehHKfPfAK2eRPd+UQMD8aJKBmwoxMalzcIswMUT2S10i4P7cGm
         0Exg==
X-Gm-Message-State: ACgBeo2gL/8bqRXcpw04wNjPi7rba+BzSROu4+8aWbQsvqJKhkI86M6g
        iXTCXiEOOAcLQmQus+yzJngK4c2IN1+kbQIU1kV77g==
X-Google-Smtp-Source: AA6agR5vg5o9a1hpAhKt50VBUZ6F8E2KCroqiblK7POTlRF0Kohm1W38ZPcFxsoUJ+Xn13nVfWHDM0t4Qba1AFb4dK0=
X-Received: by 2002:a81:bb41:0:b0:328:fd1b:5713 with SMTP id
 a1-20020a81bb41000000b00328fd1b5713mr42992802ywl.238.1662453707138; Tue, 06
 Sep 2022 01:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220906174946.61819060@canb.auug.org.au>
In-Reply-To: <20220906174946.61819060@canb.auug.org.au>
From:   Marco Elver <elver@google.com>
Date:   Tue, 6 Sep 2022 10:41:11 +0200
Message-ID: <CANpmjNPuG+=qoiZ6M3UzZNfXq3tpS59GPrH358md+q5gxZzTRg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kspp tree with the tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 09:49, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the kspp tree got a conflict in:
>
>   lib/Kconfig.debug
>
> between commit:
>
>   724c299c6a0e ("perf/hw_breakpoint: Add KUnit test for constraints accounting")
>
> from the tip tree and commit:
>
>   bb26bbd0a067 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
>
> from the kspp tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc lib/Kconfig.debug
> index e40550a5bdd3,1f267c0ddffd..000000000000
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@@ -2533,16 -2542,15 +2545,25 @@@ config STACKINIT_KUNIT_TES
>           CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
>           or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
>
>  +config HW_BREAKPOINT_KUNIT_TEST
>  +      bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
>  +      depends on HAVE_HW_BREAKPOINT
>  +      depends on KUNIT=y
>  +      default KUNIT_ALL_TESTS
>  +      help
>  +        Tests for hw_breakpoint constraints accounting.
>  +
>  +        If unsure, say N.
>  +
> + config FORTIFY_KUNIT_TEST
> +       tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
> +       depends on KUNIT && FORTIFY_SOURCE
> +       default KUNIT_ALL_TESTS
> +       help
> +         Builds unit tests for checking internals of FORTIFY_SOURCE as used
> +         by the str*() and mem*() family of functions. For testing runtime
> +         traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
> +
>   config TEST_UDELAY
>         tristate "udelay test driver"
>         help

Looks good to me, thanks!

Reviewed-by: Marco Elver <elver@google.com>
