Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165594E892B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiC0SES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiC0SEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:04:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB0A344FC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:02:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q5so16399133ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQOFDrIFh2bz70XHqIr89KbFLDHUuV5VP66dlTu2bGw=;
        b=UaVNLwcZnvNLhG+fejMyq3YjMXYSMxy5CO44s6uUwA0vwEwVOizoIns9xkanN7LLp0
         W1vSRjwHVhQ+ttok6Z7J+uole/YvctKvrH6MJNpHghzdUIo/cKLR1r4McGrH4Vruxf7W
         HID+h3OJaj/oQ34G67d/vgqL0v6Fwqnq6rLSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQOFDrIFh2bz70XHqIr89KbFLDHUuV5VP66dlTu2bGw=;
        b=v4zaD8/NwrHeGa4HKic1dmmXJ5n2H/L8eTfBZ8V48FI4Fd0U/4cn30C/2s/L05+sK1
         41qtZAoDrjREgRu5HAREOXbG5NgvnJwC7Z4lN6E0Ep27fX+p5IFtKIeL1+O5JtxvIBXX
         FuYxx2gkU6Rmc0KlwUdiK9+nfoHqDLmKYjhUgOMyl+3zQU6bDmpj/WXJyjT2pz+rfpPQ
         ZIp+eniU6h7Bx3XpPun7eUP9rBdOmoS5ulAfTcpsF5pRNWZBYrzIyVdWKNkW3RR/gXtn
         TqwBRW9IInRooaz/nDp9GNQz6aaTejzDgq6FyJWj8lpkhNI02e3E2Ok4P1RNRKe+ZwpN
         B0Kw==
X-Gm-Message-State: AOAM532FgqHbLSDKxgHJH9WAnuPHEPkvjuVvewBgKCC1NAoSJyD9oJ5v
        OaLGrdiAZRZ0t7gc9VZu6fZzbYbZcOD9s3vNphk=
X-Google-Smtp-Source: ABdhPJwioTJCOJsWYRRlCq9uEfb7AzsH86N3OZv4zjae5Zwku3CV0PgAzAYdksPOAzElbMrWr0PnCg==
X-Received: by 2002:a2e:1544:0:b0:247:dce4:681 with SMTP id 4-20020a2e1544000000b00247dce40681mr16904931ljv.430.1648404154029;
        Sun, 27 Mar 2022 11:02:34 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id b14-20020a0565120b8e00b0044a29806f79sm1416776lfv.259.2022.03.27.11.02.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 11:02:30 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h7so21220284lfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:02:29 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr16370626lfv.52.1648404149184; Sun, 27
 Mar 2022 11:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220325150419.757836392@linuxfoundation.org> <20220325150420.085364078@linuxfoundation.org>
 <CAHk-=wiaeZKiEk87Sms1sy53m8tT3UCLOoeUBnX1c_1dZ78WjQ@mail.gmail.com>
 <Yj7oXgoCdhWAwFQt@kroah.com> <CAHk-=wgeOrhN_Gznm80==STG1pEbqLMCaZZoeQzZu=NN9GOTgw@mail.gmail.com>
 <YkAuqiHAEaDLHDAO@kroah.com>
In-Reply-To: <YkAuqiHAEaDLHDAO@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 11:02:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzSHQqz33i0DfmFyEG43eeyDkkUO=a3jY0eH2h_1AwgA@mail.gmail.com>
Message-ID: <CAHk-=wgzSHQqz33i0DfmFyEG43eeyDkkUO=a3jY0eH2h_1AwgA@mail.gmail.com>
Subject: Re: [PATCH 5.10 11/38] swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
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

On Sun, Mar 27, 2022 at 2:30 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> But why did you just revert that commit, and not the previous one (i.e.
> the one that this one "fixes")?  Shouldn't ddbd89deb7d3 ("swiotlb: fix
> info leak with DMA_FROM_DEVICE") also be dropped?

The previous one wasn't obviously broken, and while it's a bit ugly,
it doesn't have the fundamental issues that the "fix" commit had.

And it does fix the whole "bounce buffer contents are undefined, and
can get copied back later" at the bounce buffer allocation (well,
"mapping") stage.

Which could cause wasted CPU cycles and isn't great, but should fix
the stale content thing for at least the common "map DMA, do DMA,
unmap" situation.

What commit aa6f8dcbab47 tried to fix was the "do multiple DMA
sequences using one single mapping" case, but that's also what then
broke ath9k because it really does want to do exactly that, but it
very much needs to do it using the same buffer with no "let's reset
it".

So I think you're fine to drop ddbd89deb7d3 too, but that commit
doesn't seem *wrong* per se.

I do think we need some model for "clear the bounce buffer of stale
data", and I do think that commit ddbd89deb7d3 probably isn't the
final word, but we don't actually _have_ the final word on this all,
so stable dropping it all is sane.

But as mentioned, commit ddbd89deb7d3 can actually fix some cases.

In particular, I do think it fixes the SG_IO data leak case that
triggered the whole issue. It was just then the "let's expand on this
fix" that was a disaster.

                  Linus
