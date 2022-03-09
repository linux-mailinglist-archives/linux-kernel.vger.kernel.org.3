Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A179B4D2577
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiCIBCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCIBCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BAF12D205
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:40:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b24so845086edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYmupwL1NthFsF42+Fr0z4aIrhKGW9iSWfQCfyDDaEk=;
        b=T9Y8CKYiSW3hGc9HM0/MT5sFo5blD99UIhMWcRbFD5kggM3DUwxybXuISqMFUGIjrg
         mWQ74CDHtfn9kXLqt5VqIvjs1zPAj3pO65tEdbgr+OX1FrAEaiMiYghKLtQSRfh7w9WS
         TgKR2SZWDkmK6Hkv45V1e1kyBDZQ0M8AOrIp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYmupwL1NthFsF42+Fr0z4aIrhKGW9iSWfQCfyDDaEk=;
        b=XPUmw7egwDf/qKrFhIJ1/1YS8+unX3f9wdmeAKd9LJJsVi1LroviTFEEo4QmOTo7oy
         q73zIkvXVnmEcmLUoyPbqCG9d2Iv9l26cTGc7hMrP/U0s9p/1x092xNVxPlriiJ6QKVf
         5YTSm+M84DC7HCnM5rwEq5YEeDToWJoPYndH+eD2riIcBoxmEvlPyAQ5Yf11Vv2WDyx6
         1Pu/PehtasihskSZoyO8i4xB/F07AVsi6o+FKI3BCDcXhsG58fOwo1mI8eCWPJc0LZBo
         AFT9b39gVsXy4xtT/Owf7fQ0akNY4jPvCgpBx2eVmo7QwVBQnSctTTuI5DzbIUROcHNO
         6qLA==
X-Gm-Message-State: AOAM531018DPxCGZKj8b2URMsLv2Xoh+soYA5T35eXLlMKRwZnR/G5+n
        jMVH8ZeB3Cp4mDYdB4j+g6menjvnFDjN9XbN9bM=
X-Google-Smtp-Source: ABdhPJwEpdX4FXcPQdo97CnWbVsMe3AbW6oIXl5LQCLjtFfR+5zd1+Ao15Q7yUjyb9eQHLbvr5d8mg==
X-Received: by 2002:a05:6512:ad2:b0:448:4c48:15ec with SMTP id n18-20020a0565120ad200b004484c4815ecmr1331063lfu.305.1646784569436;
        Tue, 08 Mar 2022 16:09:29 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2599b000000b004481e254f08sm61075lfn.240.2022.03.08.16.09.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 16:09:28 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id z26so832392lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:09:27 -0800 (PST)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr3400178lji.152.1646784567653; Tue, 08
 Mar 2022 16:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20220308215615.14183-1-arnd@kernel.org>
In-Reply-To: <20220308215615.14183-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 16:09:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsCrVxToP0Zx+cUAVZmSKi=Y6NP1+VnBcoPyPPEBfonQ@mail.gmail.com>
Message-ID: <CAHk-=wjsCrVxToP0Zx+cUAVZmSKi=Y6NP1+VnBcoPyPPEBfonQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] [v4] Kbuild: std=gnu11 changes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        David Sterba <dsterba@suse.com>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
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

On Tue, Mar 8, 2022 at 1:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I've incorporated the feedback from Masahiro Yamada in this
> version, splitting out one more patch, rebasing on top of
> the kbuild tree, and changing the order of the patches.
>
> Please apply to the kbuild tree.

I'd actually like to see this as a separate branch, so that I can
merge it early - or other peoples git branches end up depending on it.

Yeah, it shouldn't change anything on its own, but since it allows for
new syntax, we might have other things depending on it (I'm obviously
thinking of the list_for_each_entry() series that keeps getting
posted).

                      Linus
