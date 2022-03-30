Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F04ECD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiC3TaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350659AbiC3TaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:30:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258AB31DC4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:28:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m3so37574909lfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVig4TMXo4XXW+YYHFnVZTCO1uSpbm2NwpusO0nWM20=;
        b=eoAarFYSq60lhcO0YE7U6h8l1TAYLsyl0mwxA7kyk0Yf1FEPtAz0UDJNugw0CuGySz
         QC8AA8LwEOz7YnhM5H8EYLCMgvcySHe66L0/u6GiqQheodoMrPENraETAYN9xc6fW/5d
         ftWAS0w3hXHYM0Ao8IqqpFHIl/DI2GyDW9+nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVig4TMXo4XXW+YYHFnVZTCO1uSpbm2NwpusO0nWM20=;
        b=dJ8CMaihkC9asMx7fI24csPTdsDMcrbNAHZ3c2w295CPvtqphEfBd8F2phsxBkIbr8
         yRct6LRVbVREAZFA1cMmi8fqCQTVwU2XCvmTg9FNjNAK+X0Kxp1eyF6xBJV0a269SYT/
         3TeTDQe8XZQ0OnHV269du0+hQB5APX1Y9LeyMTz/cRpZfHBOuIzRdNJhniWHZd2KUxY0
         fKLsK+DTtrzPDWyfWv66zwWwnyi9fSbLz0ArCgD4/5hLYFP5xEn1MXoq1tsSQs6fWuRH
         nEP0gHpW5PEYcQ6f9XlduJbreIOFF6p6R5FpNkcAul7//AZnkPmG2PCOQReTbwUhFB+o
         XR3w==
X-Gm-Message-State: AOAM5333yw1HlCLl7SHVzVJgl2YCmDuQsWcnHe5vaXL1i44Kc9mRwuHZ
        1miGgd41c4Ss2SScUcQ24OUkPm8vio3Oyg6O
X-Google-Smtp-Source: ABdhPJz1Ol1ms2sGhc/HrCKhkbbwdldZo8y5hlFzyTzBsjYtQpuc/X1TrHZcmSZ4FF2nyGKNqW5lHQ==
X-Received: by 2002:a05:6512:3f99:b0:447:1ef5:408a with SMTP id x25-20020a0565123f9900b004471ef5408amr8281388lfa.490.1648668509667;
        Wed, 30 Mar 2022 12:28:29 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x1-20020a056512130100b004484c116de3sm2424636lfu.246.2022.03.30.12.28.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 12:28:28 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d5so37581901lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:28:27 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr8015065lfb.435.1648668507455; Wed, 30
 Mar 2022 12:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220329222514.51af6c07@gandalf.local.home> <1546405229.199729.1648659253425.JavaMail.zimbra@efficios.com>
In-Reply-To: <1546405229.199729.1648659253425.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 12:28:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ0RccFsUhgKpdh130ydsY57bqaCGRQS7w3-ckgHP=OA@mail.gmail.com>
Message-ID: <CAHk-=wgZ0RccFsUhgKpdh130ydsY57bqaCGRQS7w3-ckgHP=OA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Set user_events to BROKEN
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 9:54 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If we are not ready to commit to an ABI, perhaps it would be safer to ensure
> that include/uapi/linux/user_events.h is not installed with the uapi headers
> until it's ready.

I don't th8ink the uapi matters if the code then cannot be used.
There's no regression in that.

That said, if we leave the code in the kernel source tree, I feel like
we should probably at least compile-test it.

So maybe it should be marked as

        depends on BROKEN || COMPILE_TEST

instead?

             Linus
