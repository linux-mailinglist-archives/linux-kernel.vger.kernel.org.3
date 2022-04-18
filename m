Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30839505D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbiDRRZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiDRRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:25:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2203338BC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:22:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g18so27999555ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXb8JTv6xgqQWntZiQXAcxcRjbYBTKiyAa3H17w50Tc=;
        b=RVUSTxRF71mSooXE7dW+1t+mrhTmjHAHT5FUH1id48JJYRdzMBRa5XLtYjyTbab6pH
         xtz9QHPlqZY7utKycL3xrmT/Z+/LXdB1ybCh1bLHcoFwghGk8FDSVQ/P4uaPjaZkc7HE
         KRGCzINwviScy2NdVrYJY5OB8vwNTqYa+c9s+U+vkJXJZNdgU/O7FTzPVsV8tbvhGMd8
         Xalc+DB8fo6yg8KPaE82bG6ax5KakTDI/JMD5Sfk7YnFV15PePUvvTATXqxinPq98Aw3
         /duHjrsQqxsoDdjIs2TjMBmqJOsr/uyUDA3aiNTlLlwQN00F5TS8iTs7Ar7sGJe3WXkU
         Sw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXb8JTv6xgqQWntZiQXAcxcRjbYBTKiyAa3H17w50Tc=;
        b=tPPg0K/SsQ5pZGYczvestrGNqDXa94BZ1rri5SKwGLSQHydTjUKjgsQ/HE2FFjVtOY
         9AU3fCJSPNwrIpA4OghM43iRupU1nJAKH73WSpqUkV6V03DmdhhKvMaEtWfeePcvTTkP
         4k5eFyA51KjX2XiGDG2EOlinU3ZX3ly+wfysMrpsj9oAu5lsYqJtz2EGUrf0zYtFLmTR
         WBTcMmT+Xa4C5Ev/UbNpSw/cwSfU8/ttgzz5q3aPMgmMXi9GNfYG3BT/0ewx2W5ocatV
         C5yKR9cj4Q/quN4oWC1DATZBrYXkd9xTqCc+fKtwpiOxd3VNauGkZsVN0J4fquyAyB6v
         QdGg==
X-Gm-Message-State: AOAM533azH4z+KP0OnbXEyr6d9UcArxFVTgQQRMyxHmz2/506EL5YLht
        p8wer9ZZuiRnPWHWlzP7w1s=
X-Google-Smtp-Source: ABdhPJy/4R8YV8uUl1wOhx2cVpZcruXMe+ePdvRcORn0HBg6sx9nPwNqsCK2rl4qxRsItMqkwCVj5w==
X-Received: by 2002:a17:907:a421:b0:6ea:beb6:fd99 with SMTP id sg33-20020a170907a42100b006eabeb6fd99mr10088740ejc.261.1650302567563;
        Mon, 18 Apr 2022 10:22:47 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm7222087edt.94.2022.04.18.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:22:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Mon, 18 Apr 2022 19:22:44 +0200
Message-ID: <13023135.uLZWGnKmhe@leap>
In-Reply-To: <Yl14+RJjFU58yNpR@kernel.org>
References: <20220418075304.20259-1-fmdefrancesco@gmail.com> <Yl14+RJjFU58yNpR@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 18 aprile 2022 16:43:05 CEST Mike Rapoport wrote:
> Hi,
>=20
> On Mon, Apr 18, 2022 at 09:53:04AM +0200, Fabio M. De Francesco wrote:
> > `scripts/kernel-doc -none include/linux/highmem*` reports the following
> > warnings:
> >=20
> > include/linux/highmem.h:160: warning: expecting prototype for=20
kunmap_atomic(). Prototype was for nr_free_highpages() instead
> > include/linux/highmem-internal.h:256: warning: Function parameter or=20
member '__addr' not described in 'kunmap_atomic'
> > include/linux/highmem-internal.h:256: warning: Excess function=20
parameter 'addr' description in 'kunmap_atomic'
> >=20
> > Fix these warnings by (1) move the kernel-doc comments from highmem.h=20
to
> > highmem-internal.h (which is the file were the kunmap_atomic() macro is
> > actually defined), merge it with the comment which already was in
>=20
>                    ^ (2) ?
>=20
> > highmem-internal.h, and (3) replace "@addr" with "@__addr".

Hi Mike,

It looks like these days I'm a bit distracted...
I'm about to send a v2 patch.

>=20
> There is also replacement of "addr" with "page", so I'd phrase (3) as
> "use correct parameter names"

Yes, correct, I missed this too :(

> =20
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> Other than that
>=20
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for your "Acked-by:" tag.

Regards,

=46abio

> > ---
> >  include/linux/highmem-internal.h | 14 +++++++++++---
> >  include/linux/highmem.h          | 13 +------------
> >  2 files changed, 12 insertions(+), 15 deletions(-)
> >=20
> > [snip]



