Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3216C55A104
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiFXSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiFXSiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:38:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BBF7E002
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:38:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so6373645eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiP8VcEZQ30q3Pk2h5Gwsq7YGZeOh6yin9xVA7T6iaI=;
        b=Q0xRVwsW6uojzuz7GmFCcljGvfW5k7ElXVA7lvUp3NBj47SwMwuuXv7+qvn2HcdJLO
         UdXVgH1FThd5pleoQfjWrBJWa+YK42yeq+I6luoycW61OhF6AFcqiuRNAj1sPxtaYCFs
         5B4QaxAYi/epISS4yFeWUbcKzQ3LhfCLhsyac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiP8VcEZQ30q3Pk2h5Gwsq7YGZeOh6yin9xVA7T6iaI=;
        b=TL7DlWYK2mdAf/OC4m75QVxeiSpPVs5rJdsrWGWUW733wZHLridsmTCmLFSPY8HuaS
         lPxJ6+051lqFatbHasyFjlk13EAGj3KWnouC8MKAfASqqKEQFarClOGlceiw8Fl70G+5
         PsM3oGL6mVDVL/zEzFzEK+NWWHMWF+ZIYx9NgB/NLnE5wrkYHOmKy1r331ABBEHZz7T3
         RfBWsGTWOHERXIO5Od5E+RryijDJ5Ua9CggW9XXLMwDVHalfldMvkp9sbahRGujCmX2T
         oK8nYr7137rAb6HLi8T9TPeGJXDe3UQQNAuJUQSF3uUXLr7u9kU1m+Qy/1bltVPWZLMW
         kk0w==
X-Gm-Message-State: AJIora/O1DjdU2M1jXF5b0pGbbKhaNXDr1ua47rCIFkSL+5OAf3Lg6DX
        vMM5uVXpCLEE6pszmcCdy6EWhWPHfVRv6S3v
X-Google-Smtp-Source: AGRyM1t1Q0bsFxHlntlK+m/sJA8KLVSSE/EAtz2wlsDt+lHTRs5mMQaRhxPojYcIoJTDiWMhREg4hQ==
X-Received: by 2002:a17:907:3d8a:b0:726:396d:1848 with SMTP id he10-20020a1709073d8a00b00726396d1848mr339595ejc.339.1656095901526;
        Fri, 24 Jun 2022 11:38:21 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090660c900b007262a5e2204sm1517251ejk.153.2022.06.24.11.38.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 11:38:19 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1991572wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:38:19 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr5308343wmn.68.1656095898877; Fri, 24 Jun
 2022 11:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com>
 <CA+55aFyugRmHNV1BbhB_YHf3mgaiU6ND_KL8bu0PPEaRVNwWHg@mail.gmail.com>
In-Reply-To: <CA+55aFyugRmHNV1BbhB_YHf3mgaiU6ND_KL8bu0PPEaRVNwWHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jun 2022 11:38:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5aP-0fr8Q8ekwGn6KMAtkQbiBYxtnAFhj5LXCCszckQ@mail.gmail.com>
Message-ID: <CAHk-=wg5aP-0fr8Q8ekwGn6KMAtkQbiBYxtnAFhj5LXCCszckQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, mikoxyzzz@gmail.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        quic_eberman@quicinc.com, Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 24, 2022 at 11:29 AM Linus Torvalds <linus@linux-foundation.org> wrote:

Bah. That was really me, just with a badly set up "reply through lore"
setup, so with the wrong email address.

That's what happens when you are

 (a) incompetent

 (b) stopped getting the mailing lists as regular email because you
think lore works so well

 (c) normally rely on being cc'd

My apologies for the incompetence.

                Linus
