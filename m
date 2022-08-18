Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118F559809A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiHRJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiHRJOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:14:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB92AC7A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:14:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2268322wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=cV+6JmDqRsHto+NJ7ur42IQlcQDeqI5BYnnycodDOHw=;
        b=Qytl31GcqbfZWhPFiKty1tW81eqZTOS/RgsPloCoXnoLKWgSGvojvm7W/wEJ6kCN32
         IbrxQI2OCq3wLElSHmnEXtWb5JsM8B+CNU2ftdGrBfOl/lLNUa4XiF7QB3Kw/gulTk+z
         qOEUtVRTPdSWAUaz11Jhaz7s7mw21NNqafrc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=cV+6JmDqRsHto+NJ7ur42IQlcQDeqI5BYnnycodDOHw=;
        b=tIFdECLC1x8uH7Hxj2FQVJF3gsOdykZ5B6EwlGfo+F4T3UCDgYta1AEQI9GBsKusar
         jIR6gWb6vHTAk1Bs/KZsdIm27msq5Dqk02HuxESTD0fWlvtDSbYb/m+fylN6Bptq8oup
         7OVcPzFuBDFs0uspYSwPkUKnRKeFWhT4Y2aKvaYRygsRn/kqWhpRL6jhilqXadICBK02
         2DQsASrD79c/zLX2AlfF5DffYOxHU6oWlU19Aup+UfWnmYfQFDMkpqtjqxKocyWdj4nd
         iRrKAyUPFL+8HbKoFjQd5O2sm9805tQ1wTmpYMi0gpaVXnsJ9lG12gwztHe1eGF5FBg2
         dQyA==
X-Gm-Message-State: ACgBeo2zh2ZpuqRF6cbgGex4TBm15tLkogM8cyD+kxPuEe81RMceeAQs
        ihp1oXxvgk61ZQSo1VT4Gja6Ap4GaEodKA==
X-Google-Smtp-Source: AA6agR4EmS5rcO/bXt1mS7uP5MHRAAf9eGtKHx49/+JIg4PQt1mnKTJf3AYqwdtuohjJqR4S3qH/tg==
X-Received: by 2002:a05:600c:4f48:b0:3a5:e707:bb8c with SMTP id m8-20020a05600c4f4800b003a5e707bb8cmr4559950wmq.198.1660814042258;
        Thu, 18 Aug 2022 02:14:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bfd7:4d1c:d13d:975? ([2001:8b0:aba:5f3c:bfd7:4d1c:d13d:975])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0021e42e7c7dbsm878998wri.83.2022.08.18.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 02:14:01 -0700 (PDT)
Message-ID: <e902a360e3759c7f87d98d71d79a0d5cbe935e3e.camel@linuxfoundation.org>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with
 dash
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alexandre.belloni@bootlin.com,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Aug 2022 10:14:01 +0100
In-Reply-To: <7eacd1d9-42ba-fd61-7f37-0635cebcb33d@infradead.org>
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
         <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
         <7eacd1d9-42ba-fd61-7f37-0635cebcb33d@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-17 at 16:52 -0700, Randy Dunlap wrote:
>=20
> On 8/17/22 16:46, Nick Desaulniers wrote:
> > On Thu, Aug 4, 2022 at 12:03 PM <alexandre.belloni@bootlin.com> wrote:
> > >=20
> > > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > >=20
> > > When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fail=
s
> > > with a syntax error which is not the one we are looking for:
> >=20
> > Thanks for the patch, though I think I'd rather see `/bin/bash`
> > hardcoded. Bash is a non-optional requirement as of
> > commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for
> > process substitution")
> > scripts/ is kind of a mess...
> >=20
>=20
> Well, once upon a time, we took patches to remove bash-isms (convert to
> standard shell)...
> No longer, AFAICT.

This problem is a little more subtle.=C2=A0

As far as I could work out, exec() is used on entries like this in
kConfig. exec() falls back to /bin/sh so it is hard to see where this
would be changed to be /bin/bash.

I have no issue with bash being required and used and if someone can
work out how to make that happen for the exec() calls, I'm fine with
that. It would probably require some parsing of the "code" being passed
to kConfig to decide how to call exec().

What worries me is seeing the kernel behaviour changing depending on
whether /bin/sh is dash or bash and I think that should be fixed as a
more urgent matter.

I'd hope Alexandre's patch could be taken in the meantime as it doesn't
really hurt anything and does fix a very unexpected behaviour change
depending on the host system setup.

Cheers,

Richard

