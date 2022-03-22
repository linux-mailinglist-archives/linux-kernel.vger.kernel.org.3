Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2642D4E4729
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiCVUEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiCVUE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:04:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A934EF41
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:02:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q1-20020a17090a4f8100b001c6575ae105so2616171pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9z2OhjirVkz2pUbqaGLshsVzbhbV6ISeuMuKyH7hsWQ=;
        b=K2Z9Zm7zGkxEMQYec2pWhgy2XOQfPvprN/HESKZHkKo7Ap1wOflyxcYFVKuQSFNTtJ
         b9eFHIu5L4AWWJc2rbAjlYQK/tgMamITSdBIPTLzdCBvH8/DXHUfNKDYKSV7uYAznF90
         5FxANI/+CMn1ACq4S2PDBARc6QZrHnYt+JDhpLr4w8ewc+e7OZeymUewObip6OUr83bx
         ISHC6wAzK0V580zpUIfhQ0ipyyDhSG+fqlhmjqKrcby6Xp2j4oPkxHvlbuOTiWi5cEHr
         onyxLF1gkS/IltPtPUFuIQ6wdwtukxWWzPL22YWYSAJ3n74leqv6DMiSscTz9OOEhs1N
         LAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9z2OhjirVkz2pUbqaGLshsVzbhbV6ISeuMuKyH7hsWQ=;
        b=dCHHs1dsEwQ7bBUy6j7mde8Vo4ww1nbtQ0ivV2UINAu0/JhhXFjGrhuNp6kgvgmy+p
         1BnnND31UJln1nJYhw7L/CLIDoI1nWSTULGxL2JCAtl6YjjPDA5R1Dtf+qy28fr0UINh
         cop54rOyeWNMVCIkvM5Yr7uH9bKR6+DpDQJDnH9TgiCkC7k6Xn1NufJvu+O2+4NDUshg
         Xd8wIiZmd+CaFve51VcxpSuAxCDxDy6D8UlwYD/krEoEyXDGdQJpFDUbJioOha18aCXc
         NREBXf+hsJtbN6bemfM6bg+qT2+q15Uomqm7E5eUxckKVtCJl87ouBmKzXz70AVkxAhB
         O6GA==
X-Gm-Message-State: AOAM532sxyHf8qsevBvIx0tGmkQu+m0RFQE4nUnjeGHnPnUe1yvfmy2l
        yrZHHl8ND8rgJ1euyazcjlbrrQ==
X-Google-Smtp-Source: ABdhPJxGBLZF1jlZKcKbjlOflMXaW/vAHBWu7fR9pPGvxm7TO7lO3LkOEzMtr4yuUNUKm16mJIbDEQ==
X-Received: by 2002:a17:902:e88e:b0:154:7562:176d with SMTP id w14-20020a170902e88e00b001547562176dmr8166892plg.13.1647979378618;
        Tue, 22 Mar 2022 13:02:58 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f6519ce666sm24451135pfi.170.2022.03.22.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:02:58 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:02:58 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Mar 2022 13:02:56 PDT (-0700)
Subject:     Re: [PATCH 0/5] Generic Ticket Spinlocks
In-Reply-To: <c0328672-6dd1-b65b-1e2f-6f2562084f2d@conchuod.ie>
CC:     linux-riscv@lists.infradead.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        jszhang@kernel.org, wangkefeng.wang@huawei.com,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, peterz@infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     mail@conchuod.ie
Message-ID: <mhng-f97b1e7d-1523-4ae5-923b-e73a8db48824@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 11:18:18 PDT (-0700), mail@conchuod.ie wrote:
> On 16/03/2022 23:25, Palmer Dabbelt wrote:
>> Peter sent an RFC out about a year ago
>> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>,
>> but after a spirited discussion it looks like we lost track of things.
>> IIRC there was broad consensus on this being the way to go, but there
>> was a lot of discussion so I wasn't sure.  Given that it's been a year,
>> I figured it'd be best to just send this out again formatted a bit more
>> explicitly as a patch.
>>
>> This has had almost no testing (just a build test on RISC-V defconfig),
>> but I wanted to send it out largely as-is because I didn't have a SOB
>> from Peter on the code.  I had sent around something sort of similar in
>> spirit, but this looks completely re-written.  Just to play it safe I
>> wanted to send out almost exactly as it was posted.  I'd probably rename
>> this tspinlock and tspinlock_types, as the mis-match kind of makes my
>> eyes go funny, but I don't really care that much.  I'll also go through
>> the other ports and see if there's any more candidates, I seem to
>> remember there having been more than just OpenRISC but it's been a
>> while.
>>
>> I'm in no big rush for this and given the complex HW dependencies I
>> think it's best to target it for 5.19, that'd give us a full merge
>> window for folks to test/benchmark it on their systems to make sure it's
>> OK.
>
> Is there a specific way you have been testing/benching things, or is it
> just a case of test what we ourselves care about?

I do a bunch of functional testing in QEMU (it's all in my 
riscv-systems-ci repo, but that's not really fit for human consumption 
so I don't tell folks to use it).  That's pretty much useless for 
something like this: sure it'd find something just straight-up broken in 
the lock implementation, but the stuff I'm really worried about here 
would be poor interactions with hardware that wasn't designed/tested 
against this flavor of locks.

I don't currently do any regular testing on HW, but there's a handful of 
folks who do.  If you've got HW you care about then the best bet is to 
give this a shot on it.  There's already been some boot test reports, so 
it's at least mostly there (on RISC-V, last I saw it was breaking 
OpenRISC so there's probably some lurking issue somewhere).  I was 
hoping we'd get enough coverage that way to have confidence in this, but 
if not then I've got a bunch of RISC-V hardware lying around that I can 
spin up to fill the gaps.

As far as what workloads, I really don't know here.  At least on RISC-V, 
I think any lock microbenchmarks would be essentially meaningless: this 
is fair, so even if lock/unlock is a bit slower that's probably a win 
for real workloads.  That said, I'm not sure any of the existing 
hardware runs any workloads that I'm personally interested in so unless 
this is some massive hit to just general system responsiveness or 
make/GCC then I'm probably not going to find anything.

Happy to hear if anyone has ideas, though.

>
> Thanks,
> Conor.
>
>> RISC-V has a forward progress guarantee so we should be safe, but
>> these can always trip things up.
