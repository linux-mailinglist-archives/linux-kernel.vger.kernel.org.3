Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB51585117
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiG2Nun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiG2Nuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:50:40 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BE31DF3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:50:37 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ef5380669cso51634497b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc7yLt5IYorojKO3ICCa0CRVv9oy13vBhJXBMrvr6OM=;
        b=LVKyykhNekRqURRcFK+KkrZlN6nDcbnoroZTsLOyhSnIfzEeOR0C32i8AroUuM4MrU
         D+fdeLN+bsNp8i892mZaIYhiJXm+/GrFg9qKxWNuy8SMuXFrTNX/jUGt8bk49QHsww+d
         4wz2MLiAGLir6BCeYlJXVAP8OlvIbeB77enAYuSErzf/O8AdZezRbIYVrQajabatlG0+
         vVsErnsFF54VyoHMzX4P4Oy//XFBVEQWyFr5oJzM+epd2JHzggg1pYvGiWeazg8fnJ/u
         TarJKPr/B9w7aQ1LPi1Eyo4RE4468Kbgn/Me2KHb1DNcW+Ahs3bWFGSVktCDPDfrAo9U
         ld3Q==
X-Gm-Message-State: ACgBeo0o4VZOYV8hyMsTQRzOwuv36KTTta7mKRU7H6p8griqJsaSxeCU
        At/Jne+3Qm9sxjFoM8cwMQV+YnXHzOaLQvoBtU0=
X-Google-Smtp-Source: AA6agR7N06JTGpJ4QLYk8Z03zUx9Fp/OjHDhdx95SiBZbwtm8248SKOxxs7Nw8cRMeKx3XT3PDI3yYivm1OLHs6L5QI=
X-Received: by 2002:a81:1145:0:b0:31f:61b7:fda6 with SMTP id
 66-20020a811145000000b0031f61b7fda6mr3099724ywr.45.1659102637070; Fri, 29 Jul
 2022 06:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220723151521.51451-1-mailhol.vincent@wanadoo.fr> <CAMZ6Rq+KohWoRurA3cKog18D=NuXNj_k4+ZmPRiakZd7ZPS1OQ@mail.gmail.com>
 <YuPRDvELE+Sx5p2c@zn.tnic>
In-Reply-To: <YuPRDvELE+Sx5p2c@zn.tnic>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 29 Jul 2022 22:50:25 +0900
Message-ID: <CAMZ6Rq+FXiJHRK5NC6nBj1uuu11rPpR8vVWNdY61ZiZeWHi=8Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/2] x86/asm/bitops: optimize ff{s,z} functions
 for constant expressions
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri. 29 Jul. 2022 at 21:22, Borislav Petkov <bp@alien8.de> worte:
> On Fri, Jul 29, 2022 at 08:24:58PM +0900, Vincent MAILHOL wrote:
> > This patch series [1] has been waiting for more than two months
> > already. So far, I have not heard back from any of the x86 mainteners.
> > Do you see anything wrong with this series? If not, any chances to
> > have someone of you to pick it up?
>
> They're on my todo list but you have to be patient. If you haven't
> heard, we're still busy with this thing called retbleed.

Understood and thanks for the update!
If this is on your radar, then no more worries on my side. I wish you
courage and good luck for the retbleed fix!


Yours sincerely,
Vincent Mailhol
