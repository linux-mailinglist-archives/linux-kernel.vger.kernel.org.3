Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C469158DD2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbiHIR3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245582AbiHIR3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:29:20 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472392558E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:29:17 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id w129so6198727vkg.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X51BqTmyz62H+vqsKG64R+IOzVhf2VTJSfvImzqHNOU=;
        b=oD9ZwFgnvCcKlSTZr6o3yp92Q2QKX6zkHMaNekBLIa6CxUvpM6grqwVhEGXyKhDjVg
         9ZFgBhb1+OqFRgDWm54ZDDIFdfne2uu/TXn/VsAlC3NsFEfwULv0ciL0LfPBPlWq8JmL
         sc9BgEKYUO0+x119ZGaTh+/7I5vv4ix/v+10Rv341iFLCKJc4TAB00qBZO49R3lbplF2
         WAPZCYQi0qCl5YmbIu03wnk2TgXGThxyRD1mkIZptfKu7r1BUWwgVVi97N5RWyK18cgL
         vdwaB9D0s59SqbZ1OwruQAL9c07i1c4nXOatjkb58naDajulOBYpB/4y4OQhs8JTeEDu
         NgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X51BqTmyz62H+vqsKG64R+IOzVhf2VTJSfvImzqHNOU=;
        b=hwHhsC9Pb3bREywnxV16wKVZcDeUzAi97E1cFE6g5wKruSNSnclfrq6wM1oBgxvzXH
         ms414LWXL5Zl487ghskARZ+ZsSFhzPK6FfX7WjKQedtl7OHri4qxzzGrYvWPQpOVz0zD
         991EM33bVewGtwlJvLMRWH5ExPuMKAn50g4ZGCg/YS7Yh7J8uIyxG34CAituWV8Z0Z78
         /BIxgm/RVNabgRcCzYfJ3luecLx60vob02TWAW+CIT3ikufrm3/JNrk3jVpVycUIdr/e
         ecNIlj0gHwb3lmwqG5vA8/MA86YOSndlTr4VWsm+5PYP78YgdsM1+Q7VWEwf+aT/8NNx
         YIDQ==
X-Gm-Message-State: ACgBeo1IcXcQY0fMkpAJtqqetllBX0XpRONHEXJDgztKtdvMWUsu8XC5
        uL5ddbGuog3UEoDa/V/NFNL31x9P0QmLZtnxAN002Q==
X-Google-Smtp-Source: AA6agR7NMFLsstQwzdrKMUje0FEdQ/a6KEXBcZictn3Xkq3vl7/nI4wY6OyKJziAnLk46yFHT1ibpMCA054EnVyZUgI=
X-Received: by 2002:a1f:1bd1:0:b0:377:b693:bb39 with SMTP id
 b200-20020a1f1bd1000000b00377b693bb39mr10070581vkb.22.1660066156290; Tue, 09
 Aug 2022 10:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220805214734.1937451-1-eugenis@google.com> <875yj1x0k0.wl-maz@kernel.org>
 <CAFKCwrjVaOdrGktxVHLCDPyJSRjZ0B3FHTGsb3PXMULL=dw9rA@mail.gmail.com> <87v8r1uztz.wl-maz@kernel.org>
In-Reply-To: <87v8r1uztz.wl-maz@kernel.org>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Tue, 9 Aug 2022 10:29:05 -0700
Message-ID: <CAFKCwriq-Vh+fhxso=xqtKzkL95QkYOOkMR8XwTOJfeg1M-2qQ@mail.gmail.com>
Subject: Re: [PATCH] mte: Follow arm64.nomte override in MMU setup.
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 9:49 AM Marc Zyngier <maz@kernel.org> wrote:
>
> In which case what is the tag memory doing in the linear map?
> Shouldn't it be marked as reserved, not mapped, and in general
> completely ignored by the NS OS?

That would be wasteful. The idea is to only reserve the parts of the
tag memory that correspond to the TZ carveout and release the rest to
the NS OS.
