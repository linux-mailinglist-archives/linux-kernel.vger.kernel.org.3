Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B252536E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiE1VdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiE1VdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:33:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07020E7305
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:33:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f21so14434814ejh.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Rr1XqBRFtH9yokEb+2q5QxOS7TvqnqoUdC3tQIVMqk=;
        b=Y+ENwDVOf6dOJ1PpslRXCoV5u4qq3G/DHJ2J9dJgEDD8WK0NNSKcF4O3Fnpk+Ip195
         pTmxjjpQ/BZXC524CXqPLL58e6PorCnigH0+PlghX2o+euyDEnA/C/f2JSG+ujRN64fd
         d48qtymd/oCvUWExN289cw/JaOqanZeO1LYfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Rr1XqBRFtH9yokEb+2q5QxOS7TvqnqoUdC3tQIVMqk=;
        b=oOSLV8wszMcJGaxDNJSUIlFnycbtAZ2ckO/+K4RSpPtxZw/P7sjeQm6qm205V1EV/E
         1Sd6wDUbtH2XMaSmqV6A2JTW6MFHgNMNgQlvA9pyqtL8dHc1p+GAdGMSnRccshohsXT+
         m/4Ny1bZnnwKHa8xjXOhXbF7ZtS0bEm8zIgZuhggVXpedP31CckXCW/3CinQhkvVRJi0
         gE9CN3KGnoAVE0foz7HJHF9Uuu/WlWBOLFuBHOWe4arI2L4JikCZMtUNRboUOCdS2lpu
         g84ucw4AGi2OExl9+enaNvkMW2H7nbo1zMWF+W8Aemn5mumFUpsOfNgGRx3sNwUFvaYP
         9VYw==
X-Gm-Message-State: AOAM533YwHnH/0Av3dpa1EMhyMObA1093gKHvb0nR4J5FlTH6CyKTUN7
        RyIvnlRXWOYTwpdF4NMly3nsaczKj2H3Ph1fFEw=
X-Google-Smtp-Source: ABdhPJwxtMwq84a5KE6zcLvLKrrpALuz0K9H5D2dgnPlOXvCxVViw0l54hB4WkPDx49Srce2P3EYug==
X-Received: by 2002:a17:907:3f1c:b0:6ff:2bc2:6ac2 with SMTP id hq28-20020a1709073f1c00b006ff2bc26ac2mr11290536ejc.696.1653773597283;
        Sat, 28 May 2022 14:33:17 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id my23-20020a1709065a5700b006feded0fa96sm2657760ejc.199.2022.05.28.14.33.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 14:33:16 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id t6so10118654wra.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:33:15 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr33820880wrs.274.1653773595375; Sat, 28
 May 2022 14:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220528211452.32134-1-Larry.Finger@lwfinger.net> <20220528211452.32134-3-Larry.Finger@lwfinger.net>
In-Reply-To: <20220528211452.32134-3-Larry.Finger@lwfinger.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 May 2022 14:32:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwDfDF5faiBAOfmJo13dB=_YFN3FrT73V5NLRw7UUwxg@mail.gmail.com>
Message-ID: <CAHk-=wiwDfDF5faiBAOfmJo13dB=_YFN3FrT73V5NLRw7UUwxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: Fix undersized array in rtw_xmit.c
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hmm. Maybe the reason Greg wasn't cc'd is that the people listed at
the end is odd here:

On Sat, May 28, 2022 at 2:15 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> Fixes: 7884fc0a1473 ("staging: r8188eu: introduce new include dir for RTL8188eu driver")
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>

ie it says "Greg" there, but there's no actual tag (presumably "Cc:"
missing, 1/2 seems to have had it).

                 Linus
