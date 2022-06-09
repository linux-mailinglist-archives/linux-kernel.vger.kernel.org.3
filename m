Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4B54549D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbiFITFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiFITFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:05:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592475932E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:05:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o7so16012833eja.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJGptLrlivYu3r1Vh/8xt7dfaCVEeV5kDBA6HRnUmvU=;
        b=deh/HChg+TfSg3z7xn7FcQAIg7H+tQW/ui2M7rcAe+8oHc12MP/eKSOnEhvsgU+0m0
         Je05b+yG1RJee18y1iFpaLblwneXA/DAXedyYc83XRClm40a8mTttstWVO3HU/NeDnug
         /t0vZjgrQR+5VXutsYnVM2WND6OgjzGN50n1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJGptLrlivYu3r1Vh/8xt7dfaCVEeV5kDBA6HRnUmvU=;
        b=yl++0BB57rp4dAPWFsOJADGSEGpLmqe5VzfUbyYVdXEzyM7mCSHUj5brZ5HZNvedDA
         i1AWyT+SxwckY/sOWYGjQ0PZPe5G9AWikxUoVxCM5HUg8Q6ueGMyBPBkoeC8s8hOhP2Z
         Kp6Kt+6XUaqDFgw/4zVSBonZa6qR2G+YOkAnkOmYdciITuNMxtK/Ul0IJra8MRqJSSI8
         wKwMJ9wWPk0wQVPZvS3sBmjbswg00OgEhnZz5G8pLBNZ71c9m+qOrB2NSSZzZmIYqhrv
         nFWRVNzSpGkS5cymV4S5P7fY7eVfMHJyKNKvrDlHQiB4KySoAsls2kLghRY9GtpSi89I
         fY8w==
X-Gm-Message-State: AOAM532HU+q34GIvbK6kWBLrHZNkNWCfaJ9r+f2jHApNbovPxk1dlR3u
        piIoExVjPsnCT6apq8gb7ijxcBlVCKJVCf+U
X-Google-Smtp-Source: ABdhPJyc8vsoBvZz/aIdDeBmwonp7O7mw/338EG81Py38X6iBdne/V6akZDO1JprkNtpFXRMLjTDpQ==
X-Received: by 2002:a17:906:8302:b0:70d:7465:495a with SMTP id j2-20020a170906830200b0070d7465495amr33049432ejx.115.1654801515591;
        Thu, 09 Jun 2022 12:05:15 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b006fec63e564bsm11200420ejj.30.2022.06.09.12.05.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 12:05:14 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id i205-20020a1c3bd6000000b0039c6fd897b4so51815wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:05:13 -0700 (PDT)
X-Received: by 2002:a1c:5418:0:b0:39c:3552:c85e with SMTP id
 i24-20020a1c5418000000b0039c3552c85emr4853784wmb.68.1654801513341; Thu, 09
 Jun 2022 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com> <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
In-Reply-To: <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 12:04:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
Message-ID: <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 11:41 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Why go back and forth... do it like Alexander the Great and the Gordian knot.
>
> Sword - Swash - Done.
>
> commit 6bfb56e93bcef41859c2d5ab234ffd80b691be35
> "cert host tools: Stop complaining about deprecated OpenSSL functions"

Well, it's not like that is the *right* fix.

But I think for now, the answer is "leave it like that until we can
just get rid of the ENGINE API entirely".

I absolutely detest the "deprecation" warnings. We used to do that in
the kernel too, and it was a complete disaster. The warnings are very
noisy, and nobody ever cares about them, so it's simply not worth it.

So we deprecated "__deprecated" in the kernel itself:

  771c035372a0 deprecate the '__deprecated' attribute warnings
entirely and for good

and I don't think we should care about it when it comes to OpenSSL either.

Eventually, that deprecated interface will go away entirely, and by
then we hopefully don't care about really old openssl implementations
and will have gotten rid of the uses.

But for now, I think putting our head in the sand is actually the
_better_ model rather than fighting some battle over old vs new
libraries.

Because sometimes, if you ignore a problem, it really does just go away.

                  Linus
