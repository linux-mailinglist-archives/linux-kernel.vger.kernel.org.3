Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8056C2A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiGHXE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiGHXEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:04:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81337189
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:04:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu42so121817lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2l/32KaCBo1gSq39GaNT7RII8LMqC8kr4XQZOQvnXOA=;
        b=T5uS1kD18NVnsKmEagPWyTdelnYLKtM90m6FoHdK/unrwhAVSiTrrhedEwNrVoTF0L
         zGONP9nESzjKhuWpUxxzu6HwGbN+BJnRrVTBHtH7FIosfOikPD3J7B2MB9+zpGg8/FCm
         AhaTHsKfDerEsQ1gKInRw8BHuSHKFXfzAowg4NkCn+3/Sg8fPVoKHbwo8Upcyfgn8tcH
         KSnWlUm87+uOlC31OazZU41M/gSfxcP5KFEexA4zLCZaAq0WPtYz+k+qu3cWyxyGIGxg
         krD9fb+HFwzQE+dL0o0ePR1knwoQOXnd5GiphU5rOASyN5sRDN7PKD6ryAlP+XpGkUb1
         FRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2l/32KaCBo1gSq39GaNT7RII8LMqC8kr4XQZOQvnXOA=;
        b=BNwYP55jklHbWXXxLcNjwlwBBhYOOSu5X7JddWhn79/3zXZ4QALfsGa6F/uVpDapT1
         uHL/YoGo0lcUMDeGPe++Uu8RGA+hO/mweaFHZpAtpY5oguKhrgGDF8HRNhcJQlsEWSfj
         wIwRnWpT4eTP7OlthEctwv6st7hJoqnxryYJ9SNgOYysdAGQN4nmqSkdMWfAIasVGzkM
         fEVNb0M4gSlRtDjdOZ+Qnt1wHN1qvre35jZ6FJE5gZzBjaHQZqz2G3CenZ1pOZ6JlCLk
         /a9r3os1mK2FmQbuKHADYx/Ej3/AGC6uFj/eJPFfkdtj8Z7Usmkwfnv/ZgoGJyf9YFHN
         oFtA==
X-Gm-Message-State: AJIora+g8+KoaLppwcnK35vc3kavLaO74wqvJ8JnMYoyr2LXH8HuezDQ
        VKQcl6FVm+tJo7r6pyrc6J6FDj63bHFvYGBSdUDAbQ==
X-Google-Smtp-Source: AGRyM1tTcDEY1++IJMrqzp1Q4UfQpZq5Rn6/Yn4oIGFJw4jUkEPET+9M70VLB6Eeag4TdCWuKVPKTZkm9/RZ1yqWk9k=
X-Received: by 2002:a05:6512:1188:b0:481:2eb7:f2 with SMTP id
 g8-20020a056512118800b004812eb700f2mr3824575lfr.401.1657321461958; Fri, 08
 Jul 2022 16:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <17600de3-b295-ebdf-b9fa-323d2bc3cb93@arm.com> <20220623174131.3818333-1-ndesaulniers@google.com>
 <6b330119-fbf2-1c34-7ad3-0ae789658d22@arm.com> <bd4a9bad394b478f9ee0d9c0981948f8@AcuMS.aculab.com>
In-Reply-To: <bd4a9bad394b478f9ee0d9c0981948f8@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Jul 2022 16:04:10 -0700
Message-ID: <CAKwvOd=kcROA30fmviABhfUiDX2v8QYLPPmUV0hnQ2A29tMtDQ@mail.gmail.com>
Subject: Re: [PATCH v5] coresight: etm4x: avoid build failure with unrolled loops
To:     David Laight <David.Laight@aculab.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 2:40 AM David Laight <David.Laight@aculab.com> wrote:
>
> ...
> > > Regardless of which compiler or compiler options determine whether a
> > > loop can or can't be unrolled, which determines whether
> > > __builtin_constant_p evaluates to true when passed an expression using a
> > > loop induction variable, it is NEVER safe to allow the preprocessor to
> > > construct inline asm like:
> > >    asm volatile (".inst (0x160 + (i * 4))" : "=r"(__val));
> > >                                   ^ expected constant expression
>
> Can't you use (IIRC) an "=i" constraint with the C expression
> so that the compiler evaluates the expression and passes the
> correct constant value to the assembler?

Yes, though I think it may be even simpler for me to just use
__is_constexpr from include/linux/const.h here than try to rewrite the
existing macro soup to avoid calls to read_sysreg_s. Will send a
follow up.

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h
b/drivers/hwtracing/coresight/coresight-etm4x.h
index 33869c1d20c3..a7bfea31f7d8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -7,6 +7,7 @@
 #define _CORESIGHT_CORESIGHT_ETM_H

 #include <asm/local.h>
+#include <linux/const.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include "coresight-priv.h"
@@ -515,7 +516,7 @@
        ({
         \
                u64 __val;
         \

         \
-               if (__builtin_constant_p((offset)))
         \
+               if (__is_constexpr((offset)))
         \
                        __val =
read_etm4x_sysreg_const_offset((offset));       \
                else
         \
                        __val = etm4x_sysreg_read((offset), true,
(_64bit));    \

--
Thanks,
~Nick Desaulniers
