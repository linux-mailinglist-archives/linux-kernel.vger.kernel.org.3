Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB5570E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiGLAKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGLAKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:10:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E8A3E771
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:10:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 73so6103139pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=nPm1+OWctOA0Hf4porrExLMLHsKwOrco71sJEdbBhGg=;
        b=oYsF4NiH6G+/jxKKqgdR7avAvjSc5+n+MHMxK2MQ0BUE7i4KcN6Q7aSldg5ssnxs3d
         z6QXwEFH0oHNCZbWlsfvX8WhZPU4N9NGI+xbPAKkYkG5V5CQOwWgOlmB3nLpK7Nc3/5u
         bvLrwnMdBzPsoboRTaqnpf4l+OKWnvln7fO4z05VZMpHWZaX5ayB1Lvg4M3TCcZcq55K
         tRryg3sN7kFnLVbFVcXELDq/6uhKYDa1mV//fpvQ/ArXAxulxRVGCKalrQU4rMrYIZHd
         aW9vyfaKF88C+3o8jKB4139Mk9hF290blNVVkGJS8SAVdlK2gaMJ0ehBYXcUHWC1ufij
         4Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=nPm1+OWctOA0Hf4porrExLMLHsKwOrco71sJEdbBhGg=;
        b=0mpHgHtuwgbU3XXl25UzxY+x4mqqosrecQcY7yE3NBpSggtLXkavSWW51anIlDkclU
         /v1Ssl2zcDxy2PsA7QhUgPa7/QrPZPKvIDB3YantvtkFwO2atojumtTQ0JGeIH2/JRJZ
         o65N4MntYoracf+wanuQhP2szP2xb1ScuslNhOlvFrOKgl83BGdqXdynMgP4xYu0W4oZ
         jFOoGez9YoXJpZNr6a7f0n9rhQt8iaGXBuz/8k8LSWIzVorPTUuADMDJrYHIy3ZzbPti
         7KztL5dxRp0WYeYwmPGQWHh33ugpLOk25HawbGCZ4BJKOSRVWVHU2DcuzRfgn63LWoqT
         DEsg==
X-Gm-Message-State: AJIora/iZjjaz5qEXtzIlcViRwIuBYGhbGAY4ySjXEIF6sg8009h/MjX
        iIipt+OUIKziWvXPZh5iAMA=
X-Google-Smtp-Source: AGRyM1slJeHPQsN+1JVSFRGQl9bHUvz+vaH7yldqTha7eQsTTCLPD8U/vXSui/10qDO+p5ev3Nb4nA==
X-Received: by 2002:a63:4d5f:0:b0:412:12cb:b09f with SMTP id n31-20020a634d5f000000b0041212cbb09fmr17772429pgl.26.1657584634978;
        Mon, 11 Jul 2022 17:10:34 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090a1b8d00b001e2f892b352sm7536224pjc.45.2022.07.11.17.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:10:34 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:10:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 03/13] locking/qspinlock: split common mcs queueing code
 into its own function
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-4-npiggin@gmail.com>
        <YsRucXLUueWlAeJC@worktop.programming.kicks-ass.net>
In-Reply-To: <YsRucXLUueWlAeJC@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1657584429.qwey1g734l.astroid@bobo.none>
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

Excerpts from Peter Zijlstra's message of July 6, 2022 3:01 am:
> On Tue, Jul 05, 2022 at 12:38:10AM +1000, Nicholas Piggin wrote:
>> +void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>> +{
>> +	if (pv_enabled()) {
>> +		queued_spin_lock_mcs_queue(lock);
>> +		return;
>> +	}
>> +
>> +	if (virt_spin_lock(lock))
>> +		return;
>> +
>=20
> This reminds me; at the time I meant to make queued_spin_lock_slowpath()
> a static_call() and redirect the function appropriately at boot time.
> But that was before static_call() was merged and I never seem to have
> gotten around to doing that afterwards...

Wouldn't hurt. OTOH hyper optimising the contended path is probably
almost not measurable. Optimising coherency in the contended path
absolutely, but straight line code less so. That said don't let me
stop you :)

Thanks,
Nick
