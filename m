Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA525B256D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiIHSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiIHSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:14:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B52E72D6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:14:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c24so17490643pgg.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eMRpvkz5BHGreaY+PFzuwrNAMyJo1PrgAXdebzyX1bQ=;
        b=EAxgJt6mMMItIbhwv7qA+mTjUUPZvXlnbr28f8qnEOfklqfv8N6sl5jr03xZo8m7wk
         O33rZvP4lC2AXuGMkCcO4A3sK7x02HGPc8tEF3CaJjVhYDJ1gfkchwRH/WHIokemDGn+
         /U4Y9R+uW0qlwl0cB9bp/3Tf2xD9On15uwwQgU/9iFZOf7S/M20oQJL9aR5eQdM/lsEN
         WPfqAnH8fRjIo0OaSB4x0i7NxhhiKmxLACM3YK429Dg7ztSxuP8Fi60r6+gzic99t4Gm
         u3ZYmid9TNY1uJNg124RKrdlEThEO6V8U/IfbB47DxoF5DuFNapU1EgwbTOIlm8tbvA9
         o4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eMRpvkz5BHGreaY+PFzuwrNAMyJo1PrgAXdebzyX1bQ=;
        b=5oWjWrTqdnoVNGr52NNMuTOpSjf4cMzDYDLGfUvoZPujeDRWp5jXDJ7T51t7JlOEsw
         m1mCVkI/3W1T2zcmJTeSiMpgEtsZjWQBT9HgjGL2LTRJtXKTVhpawqgV1xSkfEGApEVC
         WqRiv7B+a4hL/4MCfAkFJZZHFs/lgXx3n3eyahgeDidDr/hXWem9LeN6LvzmaNdJOmES
         WfsY89r2jmnMQgzqW2+L/HIddsWiiMK6i6cU36ka2OHU3N6s5S4QA0lmgeVNY25qA53V
         yzaCuOiFMsOWJero4lW15A1mJLTSgtOkjYdbv8n+J8kRztT0ZGqZ+N3ss42C+o7D9R7t
         g0Jw==
X-Gm-Message-State: ACgBeo1yzX943Tx67X8Dgf8ngIEnJsFx+MHamSxAEiZzmje4CRNN95P5
        BRp0lIsoYowk/Xwf07BKt+FBRs02KeoO5hZOcCgprA==
X-Google-Smtp-Source: AA6agR4WLD24aEKV4Oh0WDDE40IxlBZK61fbyCC5sRP9hW+BrEfQofo5Xlteox0NOcEaFLEubNVXfkCyuOC1shnFH0Y=
X-Received: by 2002:a63:8a4a:0:b0:434:c99c:6fd4 with SMTP id
 y71-20020a638a4a000000b00434c99c6fd4mr8584040pgd.24.1662660859653; Thu, 08
 Sep 2022 11:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220908170133.1159747-1-abrestic@rivosinc.com>
 <CANaf2scedFxwDwBYNwk-9Y_p4O7Sc62FFjZPptdZeAs4H4JGiQ@mail.gmail.com> <CANaf2scD5QtgZuAXru5=uaZOkAQ_seHbJO0YKmT07DCTDLwKQw@mail.gmail.com>
In-Reply-To: <CANaf2scD5QtgZuAXru5=uaZOkAQ_seHbJO0YKmT07DCTDLwKQw@mail.gmail.com>
From:   Andrew Bresticker <abrestic@rivosinc.com>
Date:   Thu, 8 Sep 2022 14:14:08 -0400
Message-ID: <CALE4mHpz6DpV+jq2uqic7DCqv3a0qcYqov8+wjhZSVx5-2nkEw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Allow PROT_WRITE-only mmap()
To:     SS JieJi <c141028@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 1:28 PM SS JieJi <c141028@gmail.com> wrote:
>
> > https://fars.ee/1sPb, showing *inconsistent* read results on -r- pages
> > before/after a write attempt performed by the kernel.
>
> That said, maybe prohibit mmap-ing -w- pages is not the best fix for
> this issue. If -w- pages are irreplaceable for some use cases (and
> hence need to be allowed), I'd suggest at least we need to re-fix the
> read result inconsistency issue somewhere else despite simply
> reverting the patch.

Ah, this is because do_page_fault() also needs to be made aware of
write-implying-read. Will send a v2 shortly.

-Andrew

>
> Yours, Pan Ruizhe
