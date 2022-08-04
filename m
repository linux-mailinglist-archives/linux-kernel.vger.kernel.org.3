Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529058A0B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiHDSpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiHDSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:45:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A4F587
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:45:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dc19so816165ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cwG0I+hEkm6kWFoVuo/ynZfsV9+825Fs1BMQA0uiNPc=;
        b=W5gGdlxU9iuIN9t2E3RBXdRpDwkdGPbVgkhMVC3h9eBl69+sEBEGIPlmm3/svZn5E4
         fC4QSkFDdNsUieok6liYVfyUTjuubtN9bgzl96QcvELUoO7BHv71win8GkQEeo1xBmLM
         fjNXI7kxeo9ensDsvUL4ZSvUgOsY4USJgZB/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cwG0I+hEkm6kWFoVuo/ynZfsV9+825Fs1BMQA0uiNPc=;
        b=YTZvtP5iUqb0At82g9js2amd/6YNp1/seG7z4kw3JJIjaVXQ4QeL1j8wmDLSVdOlbd
         Irk6N2C/2aT6EVQS1cD4JPYO6neJqvgKUpER8Smr1AVSZdGpjf6Arm3JPVWafb3+WEsz
         nj56pzbGRJPq7JXN4zmuFieLe0G1Psuhls4Ng+0no0q0uSUcATzY1nDjHUn+V0quF2Rw
         i1OQw++OcRTPStsNoa6zBcQJxkNsb/L5UNhLHbZJi+1VPtZHBBX0xXeyeVEso3nqmfaw
         Q660AoZjQ0F9B5IaRVfUj7sZV948lbEDRUC6HNkX9IwPw30pcv8qK4gPg5kTdSQkQfU5
         ikdg==
X-Gm-Message-State: ACgBeo03tscWn0GOASwUqPtrAdPr9UrTHuy/Kj7qW42yEAyB+7P2cSMW
        5piyjZIlnd/OReeHt9WT/GyZu2I3lEk2ZHoe
X-Google-Smtp-Source: AA6agR7cT2tpcBh1ruTqVT4zXBxmgtNPz2oeZ7D1O/0h1SRxBeNmoEOj9Y1qONVAyUPg9Cx/1yD15A==
X-Received: by 2002:a17:907:7349:b0:730:61c8:d80d with SMTP id dq9-20020a170907734900b0073061c8d80dmr2261710ejc.699.1659638743230;
        Thu, 04 Aug 2022 11:45:43 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id ak20-20020a170906889400b0072fd6e9f707sm614337ejc.100.2022.08.04.11.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 11:45:42 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id j7so791721wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:45:42 -0700 (PDT)
X-Received: by 2002:a5d:6dae:0:b0:220:8005:7dff with SMTP id
 u14-20020a5d6dae000000b0022080057dffmr2103512wrs.442.1659638741845; Thu, 04
 Aug 2022 11:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <YuqB0tl2hjT3x7a4@kroah.com> <YuqXtcaUPflINBd6@dev-arch.thelio-3990X>
In-Reply-To: <YuqXtcaUPflINBd6@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 11:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdoqmF4fC8orFv0pRZBUfgyQMGM8yS136_vZ=9=8uQ3Q@mail.gmail.com>
Message-ID: <CAHk-=wjdoqmF4fC8orFv0pRZBUfgyQMGM8yS136_vZ=9=8uQ3Q@mail.gmail.com>
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Andrey Strachuk <strochuk@ispras.ru>
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

On Wed, Aug 3, 2022 at 8:43 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> For the record, this breaks allmodconfig with clang (I haven't seen a
> formal report on it anywhere and this missed -next coverage because
> Stephen is on vacation):

Hmm. It passes my own internal clang testing, but that's for a more
limited config.

So I've merged this in my tree, but would appreciate a fixup patch if
you have one.

                  Linus
