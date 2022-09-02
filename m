Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA35AA4FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiIBBTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiIBBTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:19:14 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC0A6AE4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:19:12 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id f18so1221575yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ueaMAy0ULQXZkazcTVS3d2242HyoqlSUdmi5cz1KhEY=;
        b=R2qVyttBCJQwbJXVrydxtV1/cd+Lika0i1FPmMP4hGyR8WodGqptWlssWfyaHbl380
         qN6PNs23+rHD7FmWoO9gAAiKMPG0ZKr2Hc/j5BMXquhm+6xJGx/2qgyEQHEme+b1vN/U
         Yc93n6kU4fLHJ4f9BA+HHK9O9SwHlHB8jkfiFWPfGFbIucMMUqLundiBpVoGsLUqamDb
         E4Z219ZCEnA93yeIUhR9RCru1tZJNyX9ae5GNxmpyLfU3O3CSpzPBuZjQTCS7S9sBJ3K
         tDN119b09+e9QkeG02fZw1HSy29S6/7bYU+UgtkcYanoW0vJOayYboS/GbU/p+L2Hy/T
         vvog==
X-Gm-Message-State: ACgBeo0kaSW4VMVKNDHWOfKAmn+gq/XOsH7ovsC8YbndodJtcPdDJo/a
        /sr7BkNXOqkp7UkJZhOmvDzn5VgntX/yL0SuzN4=
X-Google-Smtp-Source: AA6agR56eWPZZgZXhHE8+UymN7vbahfHkIj+3WZnQbGp9SGVdxxxFcRy7/EqFd2T34smijqy8pq+bc3zPUahaBRooBk=
X-Received: by 2002:a25:6a56:0:b0:694:52ad:aab6 with SMTP id
 f83-20020a256a56000000b0069452adaab6mr7186184ybc.151.1662081552016; Thu, 01
 Sep 2022 18:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr> <Yw8hJS9f6SofG4/6@yury-laptop>
In-Reply-To: <Yw8hJS9f6SofG4/6@yury-laptop>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 2 Sep 2022 10:19:00 +0900
Message-ID: <CAMZ6RqJJZSsnd8e=WATDVN2S2gFq1h-iCNstaakUXSubWP+img@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 31 Aug 2022 at 17:51, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Aug 31, 2022 at 04:57:40PM +0900, Vincent Mailhol wrote:
(...)
> Please keep me in loop in case of new versions.

A side comment, but if you want not to miss such discussion again in
the future, why not do this?

diff --git a/MAINTAINERS b/MAINTAINERS
index 56af0182a93b..f6caf4252799 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3602,6 +3602,7 @@ M:        Yury Norov <yury.norov@gmail.com>
 R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:     Maintained
+F:     arch/*/include/asm/bitops.h
 F:     include/linux/bitmap.h
 F:     include/linux/cpumask.h
 F:     include/linux/find.h

N.B. this is just a suggestion, please feel free to discard it.

> Thanks,
> Yury
