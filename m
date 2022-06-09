Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606435454E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiFITZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiFITZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:25:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488C44F1D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:25:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d14so6941104eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSgagsbvkmfJHY7CYmbuTXz5MyIqb1Bl1J/7nYFzNlM=;
        b=FVNNymOhRuplBcsV+zXBVZLeFMvqgJpfsBbgHGD7f/pNHtK4ouPMt7jThFW/F+cKNY
         INVY/vpRSk7QrdC8+hxmXbR8tsr13n5fNakRr3iCk8by11ygyGQgOGMCfosktXQTZhvv
         hwTUDZkiW3d/p8nCw8vhYtpNnLdiu7ZxBkKwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSgagsbvkmfJHY7CYmbuTXz5MyIqb1Bl1J/7nYFzNlM=;
        b=mFxguvBAAoBiNtmtaNghxBFW/oBy1R5Z8emECPoulluwZBu7RS8ZGzoRdbAGBjF82V
         fue/7n/gRl/AjY7dsgsL6cAHQL+bZhXm+4itqS6LtJGcTzdPebBRKAbM9PTkqbCmB4ci
         nsISlh+cHoTiRWT+5fz/0uGv+pNWj2vSKW2r3x9Psl2PmKyAQak+VxJi9IjlQmuMVS1o
         pt10/81kRK0PX3szXVeoT1yB1mc0YEHLBknam/e5PUgbvqWnCgqAyL2slUmZ11fPyQlt
         yPPfDg0xFp+hT99Z6Q5HYnQAKC5Du8nau6NSXvaVMT/ua0CDpQVvzVYBnkzIptuKGaHA
         Cl8Q==
X-Gm-Message-State: AOAM531vCvdRoT/EREUflUD9VPSMLU/+eBy7YvLt69j5u6QUfmkIH1Or
        7uc0J3Hq6vsW3tf+DuBse7/xga662xcH73fm
X-Google-Smtp-Source: ABdhPJzW8+pgj5yfrVjZteJ3A5TTCS7YpD+n22CrImTOUQuYbIuc6TDfedqESWQki+3sZT8P9hYlyQ==
X-Received: by 2002:aa7:c44b:0:b0:42d:d107:7e7a with SMTP id n11-20020aa7c44b000000b0042dd1077e7amr46558677edr.261.1654802749623;
        Thu, 09 Jun 2022 12:25:49 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id si28-20020a170906cedc00b006f3ef214e0csm11184625ejb.114.2022.06.09.12.25.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 12:25:48 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id x17so33725274wrg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:25:48 -0700 (PDT)
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id
 u3-20020a5d6da3000000b00219bcdd97cdmr3118138wrs.274.1654802747974; Thu, 09
 Jun 2022 12:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com> <20220609192308.GB10732@1wt.eu>
In-Reply-To: <20220609192308.GB10732@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 12:25:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
Message-ID: <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Willy Tarreau <w@1wt.eu>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>, keyrings@vger.kernel.org,
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

On Thu, Jun 9, 2022 at 12:23 PM Willy Tarreau <w@1wt.eu> wrote:
>
> IIRC you can also disable the deprecation warnings by defining the
> OPENSSL_SUPPRESS_DEPRECATED macro. It doesn't require to change the
> compiler's options and allows us to put our head in the sand.

That one had the downside that you have to know what you're doing to
make such a change ;)

I just wanted to be able to start doing pulls again after mistakenly
thinking that an upgrade would be pain-free.

                    Linus
