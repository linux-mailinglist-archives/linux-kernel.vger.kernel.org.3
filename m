Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E44C46D702
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhLHPeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbhLHPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638977442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzCUQTQHixCkOFTrQyJFzqAE5wDab4E7u78+a05/gN0=;
        b=fPLCex9woVTqT4fATViJxotXR7/lns6BATMI0bPWEat5C5wrBI9Guac4dTiuJ6cGS9qGU+
        gyDgZkoh0bzJUF/pPk4/xI/4KKHONSjGOzrSsA4nkxuSDktjqWlMLAx800reUH9mSJ+ZkV
        wxsuxHnhkTZ2ClACCVSPxPBJFWgOnoM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-vJ2XAj5dNKChTpAZVcuZTg-1; Wed, 08 Dec 2021 10:30:40 -0500
X-MC-Unique: vJ2XAj5dNKChTpAZVcuZTg-1
Received: by mail-pf1-f199.google.com with SMTP id 4-20020a621604000000b004a4ab765028so1748855pfw.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzCUQTQHixCkOFTrQyJFzqAE5wDab4E7u78+a05/gN0=;
        b=6lhtqJ4koTLirO9WbjLK7xAvBvbH2yQ1rKdDrZapTpMPt40tAbUNwUTR+HcIFLDrOj
         qv+X6z0jE2zG4OMdyvhZ7CBV7rYt83nX92L5ufSCHketma4ivr6Leycn+u7aSWE6J1eL
         KQ+uuvzgXrqk+1rftEqmlwswjfQLhxukkHA+t4W+LdnQftYpvMN9+FoHG2LZXR6sqZ9A
         GE4l4eOu9X5BRkV6nzAHFxGorhDKXP31nA83vjy9XTMNJXMKLmi6Bg+4It9Ir5xRtwZP
         k06LOmBQvMGyzbEFmoj3Cf7I7dXClxNLnNn3djdTP3fG5QrjzVHeq6OzqPsDqBGxRb/N
         +2Jg==
X-Gm-Message-State: AOAM532vIXqji4XlCpabpLeGPWflRpPxL3rUo0cg4lTIe/jMnZkwEhaD
        IcLI2O1xHv293rQwQ/fKRp1Qys5Tn7RBqvb4ISVAj7MyaN5+qIEFrZO77GnORsdUapjrJp9O0Ib
        dIB2U+w7QmRA5Mhs0c24c06BRkAnpQ1FRb55TCzSC
X-Received: by 2002:a17:903:1c7:b0:141:e630:130c with SMTP id e7-20020a17090301c700b00141e630130cmr60620984plh.80.1638977439731;
        Wed, 08 Dec 2021 07:30:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyixfuggonvjhI2fbihDrgrNo0uHWJ2S5UbH6Tm5PzAKbFkHDDWpqgfjt6m65mYCqwZhBbOM27jqpCWVe311Zs=
X-Received: by 2002:a17:903:1c7:b0:141:e630:130c with SMTP id
 e7-20020a17090301c700b00141e630130cmr60620949plh.80.1638977439492; Wed, 08
 Dec 2021 07:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20211201164301.44653-1-tero.kristo@linux.intel.com>
In-Reply-To: <20211201164301.44653-1-tero.kristo@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 8 Dec 2021 16:30:28 +0100
Message-ID: <CAO-hwJJRXrMAxi_cWng=vuQv4Ej7_AFweZTxVqu9_uy+C6sfzg@mail.gmail.com>
Subject: Re: [RFCv3 0/7] USI stylus support series
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On Wed, Dec 1, 2021 at 5:43 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Hi,
>
> Another update here based on received feedback. Main change compared to v2:

If that's OK with you, I'd like to cherry-pick some patches from the
series: 1/7, 2/7 (the version from v4 because I requested changes),
4/7 and a lighter 5/7 where we don't have the MSC events we are still
discussing.

So Ideally, can you post a v4 based on top of hid.git/for-next
(without my hid-bpf changes) with those 4 patches?

Patch 3 is still up for discussion, and patches 6 and 7 are obviously RFC.

Actually, Patch 3 could be split into a part where you add the HID
usages and a part with the mapping of them. The HID usages part can be
integrated now too, and we'll have the USI mapping that would require
Dmitry's ack in a separate patch.

But if you prefer having everything in one series, that's fine by me too.

Cheers,
Benjamin

>
> - Dropped patch #5 : HID: core: map USI pen style reports directly
>   This is not needed anymore, as the same result can be reached by
>   modifying the flags of the relevant field in rdesc. This is done now
>   as part of patch #7 in the BPF code.
>
> I also dropped one of the fixes from my test branch [1] as pointed out
> by Benjamin, it is not needed if the BPF program is executed with the
> modalias link.
>
> Updated test branch can be found from [2].
>
> -Tero
>
> [1]
> https://github.com/t-kristo/linux/commit/81b27fd46780ce67c2706d586c0f4a437e87dbf6
> (HID: bpf: fix file mapping)
> [2] https://github.com/t-kristo/linux/commits/usi-5.16-rfc-v3-bpf
>
>

