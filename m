Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2835883B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiHBViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiHBViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:38:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4A12D19
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:38:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i14so9448068ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gGqmfyaQUIm1YKWrnwaqQi5kSsYHF26dRAa7cpMkCzA=;
        b=eMok4V+57otNs2BeWfG866Y1IKaVKq4NfyM6SS4ePJCkRdsCOnVuqvcMm+THg2znTU
         KoqedMGzuUZohUxkWE/46g2lrKXqTca2vCGSSID1cSEI2SeNGpbnrFL3UYkLxOKUfHjk
         IFzFL6t8Qb8lLb8hTo7hb5NdB8UV0Yeg1wCe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gGqmfyaQUIm1YKWrnwaqQi5kSsYHF26dRAa7cpMkCzA=;
        b=AQfHI8YGlCy9C+/S0BSWN0ayutttuFfhQwP6W1jN3+VtR10tzGlrj4j2PPsLD4SIt7
         fFbaFDe/sTMbnryawbmkyHseNcwEiRv1ZaBjZ7EWbchX3jdtOnsxnhqaeIn4JsPi3NcV
         PXsyO5DDPfRlUH7Rr3Ao1nuHfq1Ms0n3Gm8XOtGsT68KNzBYQOCWmuEGxWOTzdRZKl8k
         5Np2xNXlPUaJYCDks74BfIPzW77ApW4xq6y6tQXquHpMTukWJTn5SiLZWitd3A7j7JFH
         ecM7MdIazWleLpr3H3/5nQ77kZoTU8bPGG9o1VprlQikgPgMWFbwGHcP0yiZ9PgqbKrU
         Vhog==
X-Gm-Message-State: AJIora8rHAAGVSreqLx6SWaHYjILlYl/Bwv+4NYpIfUksQxyz49ktmrX
        /rB8NhInb07dS56rO5uhVkyR1kQOHMHw/DK/
X-Google-Smtp-Source: AGRyM1sNRKGZ3n1ZLWxqyGZ1egmXIzKKdOxZGFBkRLlebolJcdN8tRThOeZTsJTZK6DNWORvC1jKnA==
X-Received: by 2002:a17:907:6e12:b0:72e:6774:cb80 with SMTP id sd18-20020a1709076e1200b0072e6774cb80mr17208045ejc.504.1659476285849;
        Tue, 02 Aug 2022 14:38:05 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090669c800b00726abf9a32bsm6606214ejs.138.2022.08.02.14.38.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 14:38:05 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id bk11so9505259wrb.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:38:05 -0700 (PDT)
X-Received: by 2002:a5d:59a4:0:b0:21e:8704:ea35 with SMTP id
 p4-20020a5d59a4000000b0021e8704ea35mr13392751wrr.442.1659476284974; Tue, 02
 Aug 2022 14:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <202208011036.F80AB3F@keescook>
In-Reply-To: <202208011036.F80AB3F@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 14:37:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiArcrKvo7QuAk2RNbgAPCOVihhm3OUN=JPNzE2zpuFFg@mail.gmail.com>
Message-ID: <CAHk-=wiArcrKvo7QuAk2RNbgAPCOVihhm3OUN=JPNzE2zpuFFg@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v5.20-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Zhang Jiaming <jiaming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 10:37 AM Kees Cook <keescook@chromium.org> wrote:
>
> Andrei Vagin (2):
>       fs/exec: allow to unshare a time namespace on vfork+exec
>       selftests/timens: add a test for vfork+exit

.. I think that "exit" was supposed to be "exec".

> Zhang Jiaming (1):
>       exec: Fix a spelling mistake

One step forward, one step back.. ;)

                  Linus
