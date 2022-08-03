Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54968589388
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiHCUtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiHCUtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:49:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975C5C976
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:49:38 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id o15so30044962yba.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Gy0vda4fEjaHYG8Mhy2G1yyPlIluCCBrlRGzTB0g14=;
        b=laFGVFAL3xhRLfkMa/LhVhutxUhcjnrwA4WrIgp/3QjtwtJSkWhvug/i0g0Zn5ilbh
         LYbpue7DspLK1Cnx74t+K7pcTRX25LeQsxSydS1aX5OzCqIIGbmZy8FZOzFCwkidIsWd
         jXwygMEWB8M65lc1xWWbh8iHi9iWN2/W1G++E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Gy0vda4fEjaHYG8Mhy2G1yyPlIluCCBrlRGzTB0g14=;
        b=3dAfiNX0gYaweAeYd90Y0mcm42iFjE9uOpqNl0E0TlT/1Qy7vf+dycLL9hSvHRF0cI
         zhK+SJTcX9fAUCNErEMxNeJk58f4GNkBmJuSjCmq+j/cc//r97wy7oin/OtvQueF9Wnt
         zpwNhuwFT3WeBq647GGgQrnsN+ZajLEhfdFHtxHX8R6y9MRb36M5cyGUOvigPdo4e3MU
         7+bDYTPEQZul8NSp8D5KJGufAsc3ECxWBQ09+bL4L0+GV4OPpGWWuBSxr0+ITausUQO2
         2/ZHA2p/tJ21bwl1GqRaLVNVQLfYuG7FhNg1/0zaWQi/8JdM3jIrJWRLs5u6kWz7Cd4q
         c1+g==
X-Gm-Message-State: ACgBeo3kQVwIWoQqKC24WAd6O87Cl7NApxWvnbSkGcGx4mWtQTfOxnIJ
        NZnAidrvQrI5VDvfqdhuOq2GaCpfVTnLeUPnQRpQ9g==
X-Google-Smtp-Source: AA6agR5lM3Raf5s7ohmYeE5wleyqMdPST+gQvxgTBp4oJg1xkl8CCaHr3+GkUA5ZwlYrONoFxLcnLYEfLkzWd7ASa0E=
X-Received: by 2002:a25:6908:0:b0:67a:6cf9:52e0 with SMTP id
 e8-20020a256908000000b0067a6cf952e0mr3893457ybc.62.1659559777815; Wed, 03 Aug
 2022 13:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220704000225.345536-1-dlunev@chromium.org> <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com> <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com> <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
 <Yun4LH+StcuBXRtO@sol.localdomain> <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
 <YuqimBLSh/4wvoDU@redhat.com>
In-Reply-To: <YuqimBLSh/4wvoDU@redhat.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Thu, 4 Aug 2022 06:49:27 +1000
Message-ID: <CAONX=-ctGm1pLYtVTk=vtLVi9v+F+vCcd=aQ1gZH7gDMGkh-3w@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: add message command to disallow device open
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org,
        Zdenek Kabelac <zdenek.kabelac@gmail.com>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not going to take this patch. It isn't the proper way to handle
> preventing use of a DM device.
Can you suggest a better mechanism that would be acceptable
from your perspective?

> In addition, the patch's header doesn't speak to a proper
> review/audit of implications this change would have
> on all aspects of a DM device's capabilities.
I would gladly clarify the commit message, and I am sorry
for making it terse in the beginning. Can you please
clarify, what capabilities are you concerned about? The
change shouldn't change any existing semantics if the
mechanism is never used on a specific system, and only
alters "open" behaviour in the cases where the specific
message was issued, but I am happy to cover any
additional aspects you are concerned about

Thanks,
Daniil
