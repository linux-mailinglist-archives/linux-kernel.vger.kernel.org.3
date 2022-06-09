Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F9545502
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbiFITcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiFITcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:32:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BEF1124D6;
        Thu,  9 Jun 2022 12:32:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h18so19487711ilj.7;
        Thu, 09 Jun 2022 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vK0gqUxlF5+nrUpbBLImn6xeSITO/VWm8eA5YMiJKYw=;
        b=WENXzV+fR2uXHUawg+rcx0jxNQA/3XqQmdOdLJq8HF6NPlgGA69/Eso6yhT4DB9UvW
         rE1I0h2RsbOb0H2c/S+D5zSRzr07YoPK7B6OO6w8MBhM8mfAaYfeJ9mH4OVT6xRB4/z6
         mgzowQqlLnElRl3PqNgd/Xhj7tCvuRihydElK3QIqvISOQ83t3jBI2CHX/KSG0hD5PUI
         5tO4/sfnoMkT3G1NxdHePVBDNn4v61pBQ6JO3XLErWOfCcZdQrMhl82mUxkX0b2aatJI
         TRb3oQeK7mVJxY0ExEyOF7g3ZXdsPiVTBf6ubtSKdMY6VaGqUPEvOKBUfGX/Y14J9bXY
         dZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vK0gqUxlF5+nrUpbBLImn6xeSITO/VWm8eA5YMiJKYw=;
        b=q5n3t/2ly/phsEc3PH1g7SMQaQkLB8OzS9hMkVCbs5FgY2Ah/TWSml3wWeAjNYmZLV
         RTN7VjZxlqMJHvJ3laGF2j7cj46WIrRJ5lGQoeldpg8+5RL0YEf6b/bAGR7YNO7XDDcc
         5dKm59htHlB69imKh4VG7zOccKTq+TZYxohiB4Tb/HTGJ8Im7Ip8bJjMM/UKjxbHoRfE
         zxHDrHD3bsHYzTlnJUw0VWU6PPZ0XrrN72CE87VBdO9+PNdGu+SSJH9c8wuW6AJc2kcW
         CnUJ9QAKQwlhr5H4ntJqntQiTpq31Tyze7aEaDc4jIFZF+JsOt8+BAqQK6GmR1CkqdIF
         Kf9Q==
X-Gm-Message-State: AOAM530Tm0gqAF7bUwATgzXVwCtSS885JZz/2Bphtjrt1C8PDXhwAMN5
        24y0ZINiAxd8Cg6Layf4oDKASgPZK+T1DcJYR9t0zBvB/Pe10w==
X-Google-Smtp-Source: ABdhPJzp+3cKmgr0Ld0E/gduXew0HM21lB4wccTngkPkf3WY+uazLuR/GvCVKERiir3zLyaA2Ial2PcNDansldTt/KM=
X-Received: by 2002:a05:6e02:1a8e:b0:2d3:bd16:40ee with SMTP id
 k14-20020a056e021a8e00b002d3bd1640eemr23705942ilv.20.1654803140323; Thu, 09
 Jun 2022 12:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
 <20220609192308.GB10732@1wt.eu> <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
In-Reply-To: <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 9 Jun 2022 21:31:44 +0200
Message-ID: <CA+icZUUCOoE8x3Js=DYEjgyV_rz-T-M7gPZdFQu7tsKcUoA0hg@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 9:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 9, 2022 at 12:23 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > IIRC you can also disable the deprecation warnings by defining the
> > OPENSSL_SUPPRESS_DEPRECATED macro. It doesn't require to change the
> > compiler's options and allows us to put our head in the sand.
>
> That one had the downside that you have to know what you're doing to
> make such a change ;)
>
> I just wanted to be able to start doing pulls again after mistakenly
> thinking that an upgrade would be pain-free.
>

My first approach in making this work....

From 3b019a241a72742c7f239965ed92385e9ffd9ed3 Mon Sep 17 00:00:00 2001
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 27 May 2022 09:25:45 +0200
Subject: [PATCH] extract-cert: Suppress warnings with OpenSSL v3 API

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
certs/Makefile | 1 +
1 file changed, 1 insertion(+)

diff --git a/certs/Makefile b/certs/Makefile
index d8443cfb1c40..52f71f0925e2 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -75,4 +75,5 @@ targets += x509_revocation_list
hostprogs := extract-cert

HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
+HOSTCFLAGS_extract-cert.o += -Wno-deprecated-declarations
HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2>
/dev/null || echo -lcrypto)
--
2.36.1

...before looking through the Wild Wild Web for fixes.

-Sedat-
