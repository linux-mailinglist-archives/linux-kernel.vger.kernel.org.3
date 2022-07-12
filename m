Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDEB570EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiGLALg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGLAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:11:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9152DC8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:11:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 73so6104594pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=pYJSNK++URL7ml+30jswVD87/OQVdQZrhzC845LEs7k=;
        b=qxrEt/3MEqj85loNwXArrXIlqWsMWP07mCCIpjh8LDQ6/Up/BKUljJHzuV173suOca
         5mQXaPOc0ibxvEYC57cBJEEwKQOwTfIKmggrkJ+qy3ChckbHorhm232xp3ZjAfrcIZC5
         J5nenR/yOHeQSF+NB+itaR8f1kvRi4pNGWuvMk42fOSH/scF6C+OSnSphR84e90KDOYL
         NFZ8bPd/JMvKeeM4qwNbfTJm3+xjDGYz39nhoWxmHcL58YYk/KOG9M6ddgDUwgLlETnN
         FhwuoSom9ig1jZfr7wuKB+s0RQxxi6OEmm1l4Dhd8bzaFmhxf76r2iab4TxogCUy3ds8
         /RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=pYJSNK++URL7ml+30jswVD87/OQVdQZrhzC845LEs7k=;
        b=IOQHgrj03i4UQCVxZv0luSz21KNbMfKRk5OVbb33IoUvgODakAKzO2ju/0FGhKYnRh
         w4a3vb9p87blV+X5V6e3rf0KqBS7d3R6AXwMuIVZ7m70R+amVrgNxKrNAyMdyEEwYFre
         DRBlBWY1ZgeT5HGoI607mdim7ckwSOJZptSOIeHN06kkqu83e+IWK1/VT+GqcjQXWToZ
         ATna7gMO9N4N/wgPfaJIQK2Ev6EmedMu6ocl9XuLSZCEuFOpvdimiDzmqSYAZecerqUP
         0UPL1lLe3uv8fhCm/Ujk4ETaaA/l4AL7UvCyd80SfIvjEvlvxhQsRPuU2KqZSK3s3DSW
         g3YQ==
X-Gm-Message-State: AJIora8W6zlCiL2brX6ArAicxhHx5h7r7Mi7pd0fOeLQ/vVtiDVqaw9U
        RLP4mPnQOGSKwGmDWbHXHeY=
X-Google-Smtp-Source: AGRyM1t39qgkkNP/abAMREpftfvNugHAvP0Kz6nYqFRL3OrTCZCnEcezzbo9Jw4E/rAR80lRHl6v8Q==
X-Received: by 2002:a63:d54c:0:b0:412:562e:6964 with SMTP id v12-20020a63d54c000000b00412562e6964mr17825555pgi.528.1657584688368;
        Mon, 11 Jul 2022 17:11:28 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id f68-20020a625147000000b0052ab8646500sm5319214pfb.56.2022.07.11.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:11:27 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:11:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 04/13] locking/qspinlock: move pv lock word helpers into
 qspinlock.c
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-5-npiggin@gmail.com>
        <48a8bde8-8783-e1f6-ef44-c9cae15f71a7@redhat.com>
In-Reply-To: <48a8bde8-8783-e1f6-ef44-c9cae15f71a7@redhat.com>
MIME-Version: 1.0
Message-Id: <1657584645.mcdt86nt6j.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Waiman Long's message of July 6, 2022 5:34 am:
> On 7/4/22 10:38, Nicholas Piggin wrote:
>> There is no real reason not to keep all the bit manipulation together.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   kernel/locking/qspinlock.c          | 107 ++++++++++++++++------------
>>   kernel/locking/qspinlock_paravirt.h |  51 -------------
>>   2 files changed, 63 insertions(+), 95 deletions(-)
>>
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index 7360d643de29..8f2173e22479 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -141,7 +141,24 @@ struct qnode *grab_qnode(struct qnode *base, int id=
x)
>>  =20
>>   #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
>>  =20
>> +/**
>> + * set_pending - set the pending bit.
>> + * @lock: Pointer to queued spinlock structure
>> + *
>> + * *,0,* -> *,1,*
>> + *
>> + * The pending bit is used by the queue head vCPU to indicate that it
>> + * is actively spinning on the lock and no lock stealing is allowed.
>=20
> The pending bit has different usage in pv and non-pv cases. The=20
> description here refers to the pv case. For non-pv, it is used to avoid=20
> loading the the extra node cacheline in likely contended case.

Ah thank you, I can expand on that.

Thanks,
Nick
