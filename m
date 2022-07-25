Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF05805DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiGYUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiGYUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:41:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE413DEA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:41:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m8so15448904edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZom5onWB4/D1hB5gtNREa3jGNLAjEikzJFm8hKoPD0=;
        b=JrYQ1MsbBhAWbnaL4bCij1Z+c5wDkvvYdK/PM2IEUDz7HvTomeAn+WSNJzMkgCy13b
         EgrIXpYySyaMWbLxouqnE+66vsESWi1xYmrXXjwGjSyGP3XC1acrXDW7ZHHBF0j7gDG3
         0TvsT1JhnAFNTi/QJSeb9SeoqJaAD3nciEmLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZom5onWB4/D1hB5gtNREa3jGNLAjEikzJFm8hKoPD0=;
        b=KGoT09JugTTHZz+CtBCDbcz/NwCoVZ4pLvCHWPMu3zzfMJvjJquH53Ua1yyttG1d1S
         S3kyRELhsh+fYhWcOheYHihw1iXENUMZXL0WU1qixeYycShFA7jLWJ71vq77Xf9AmPbI
         Pv5k919H+rAtQFnvcZplmM/gKQMA2IhnJphAaXyr21w+wYFy4NcbxPjz9i0Ay3yBRjEe
         pVzXL6V7L0ey5mAMxjtBYcJBfM+pNKt4vpewusUr3h4H1aDYfZ1gSm3f+K3ZdzZdVwbp
         JsPkCLkEhL9fvxiaqXWM8bBxWh2t3dqxRFB9fICTOUpuYshllqWIedccn4v54NgYd3nm
         S41w==
X-Gm-Message-State: AJIora99Imef97gEm9uXFJSih/Q9JBE118/XIzQ8GxnpGfW1VnjUEF2X
        nrz9Dpk3B4v0beWvZeA1bya+63/Pp3TRcVpe
X-Google-Smtp-Source: AGRyM1u4/ApsW4wVcpUMnBvUIYK+zy0fY40AnZHi/WhdEALwwFewEUJYXHM6N5sSKAitr5ANIAl4Kg==
X-Received: by 2002:a05:6402:1e8c:b0:43c:2032:7d98 with SMTP id f12-20020a0564021e8c00b0043c20327d98mr4510879edf.297.1658781675475;
        Mon, 25 Jul 2022 13:41:15 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b0072ee79bb8ebsm5728438ejh.126.2022.07.25.13.41.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:41:14 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id a18-20020a05600c349200b003a30de68697so73072wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:41:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr12441864wmq.154.1658781674109; Mon, 25
 Jul 2022 13:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net> <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <CAHk-=wgGrewyOqT7Cm-eHKp5W+8rJ=aL8iNtsbhRfc0YD2gbeA@mail.gmail.com> <Yt7+pPyEmYYH8D1K@yury-laptop>
In-Reply-To: <Yt7+pPyEmYYH8D1K@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jul 2022 13:40:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6k1oxtEF3M7_icZ_62Je4R0VUaA69jo4xrOTxF_mMoQ@mail.gmail.com>
Message-ID: <CAHk-=wg6k1oxtEF3M7_icZ_62Je4R0VUaA69jo4xrOTxF_mMoQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc8
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jul 25, 2022 at 1:35 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> Here we have 2 ugly options - having pairs of almost identical
> functions, or passing dummy variables. I decided that copy-pasting is
> worse than abusing branch predictor.

The thing is, we have solutions for this - just use a single inline
function, and make it *see* the constant.

That way the compiler can DTRT, either generating two copies (with the
constant elided) or depending on the branch predictor.

That's particularly true in a case like this, when there is only *one*
case for the normal situation (ie little-endian). Because let's face
it, big-endian is completely dead and legacy model.

              Linus
