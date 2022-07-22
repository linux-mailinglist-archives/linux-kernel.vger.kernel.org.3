Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674B57D86B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiGVCQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiGVCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:16:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5262F9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:16:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 17so3397278pfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Xe422so7ud5t4YBuAP/W7X4X+zOAjoGHV1YSVXSBWHs=;
        b=UdnkYII0Mpk5gU0mPLoZ2kG0/OaBeGUAjgxOzrlE+RJPmHsy1ze+cw7/7CzyOwl/m6
         3c9ZWSWpY1zC3E2/C6du47ou8KFtaz5aSQViJNcTai3NYKQ3mQR7vQUSq6qmjMUbdoTU
         LeGWmh0TGSxm7RQ4m6tSe63+kOTqRZ40O9iY0vAzaVIjNYXk2vyfI/wvqF0gepZ3Dl1q
         uWDhenbsKj1wwazDWAXb5o+dRllBXJG6X5v0PgnXoeX4WJs5nLhsjbXQvePgdZ+AKw3O
         fAUyfQMuW11vXuLj9ebBhbjoXyUck8Xvi7WmYb+ZzcKxhX+6/ibjwqRxUzomAk2IDTkn
         iMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Xe422so7ud5t4YBuAP/W7X4X+zOAjoGHV1YSVXSBWHs=;
        b=3vJMd7Z66Z+A0vO2a6Px+UudZdzNbwy2rc1zvgUBs2FQlxoJ7JwVNnKK4t3CS4AX9X
         Fn9dmBeO4bBXCtZXSbO351yKbDvU+HEy0oXJvmMhw6jo2dnmBlTbEqEMmKqtRH6eGpcH
         ZUwdV/XizdcsMPoERNGQ1P8Cme5NhDc+FGQCucMFv4N8N3gimXHj0mGvEGtMqDCTTzVn
         mbetIpTn4qMPjyvUdtZUVbPrjPn97IGQMJiZrUHk24mPaTo9DLb1xIF0VMFxS7Wzo/J2
         1oHD61vji7Fs5AyyhLgaueMGxXnleqvA1zm4b1vsq6EaGfDeon6l35wh2qTvXK0SrQaS
         TS4g==
X-Gm-Message-State: AJIora8axLCUicUtGuSj4UyPG9afoaV5alVu6nTJ6A6ykFJPne7tynlR
        B4Oad88k1L7GOw34WANH4mmDEA==
X-Google-Smtp-Source: AGRyM1uh0a9LLTCNKRh+u/DKFqJBSZpJ4ioHEmsFBqJSyNsfFlXf07R8aGw3AcdIjWwCL7tIyFH2WQ==
X-Received: by 2002:aa7:9afa:0:b0:528:bbf7:e444 with SMTP id y26-20020aa79afa000000b00528bbf7e444mr1127722pfp.71.1658456196235;
        Thu, 21 Jul 2022 19:16:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79d85000000b00525161431f5sm2448652pfq.36.2022.07.21.19.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:16:35 -0700 (PDT)
Date:   Thu, 21 Jul 2022 19:16:35 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Jul 2022 18:56:05 PDT (-0700)
Subject:     Re: [PATCH 0/2] riscv: Add macro for multiple nop instructions
In-Reply-To: <20220607143059.1054074-1-heiko@sntech.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Christoph Hellwig <hch@lst.de>, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-24b00ffb-dcaa-40b3-8da3-2c2fe26ea3aa@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jun 2022 07:30:57 PDT (-0700), heiko@sntech.de wrote:
> Some cases need multiple nop instructions and arm64 already has a
> nice helper for not needing to write all of them out but instead
> use a helper to add n nops.
>
> So add a similar thing to riscv and convert the T-Head PMA
> alternative to use it.
>
>
> Heiko Stuebner (2):
>   riscv: introduce nops and __nops macros for NOP sequences
>   riscv: convert the t-head pbmt errata to use the __nops macro
>
>  arch/riscv/include/asm/asm.h         | 15 +++++++++++++++
>  arch/riscv/include/asm/barrier.h     |  2 ++
>  arch/riscv/include/asm/errata_list.h |  8 +-------
>  3 files changed, 18 insertions(+), 7 deletions(-)

Thanks, these are on for-next.  I had to fix up some minor conflicts, but
hopefuly nothing went wrong.
