Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B64CD9DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiCDROh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiCDROf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:14:35 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708671B0C42;
        Fri,  4 Mar 2022 09:13:47 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B88B22B2;
        Fri,  4 Mar 2022 17:13:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B88B22B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1646414026; bh=g5o2ryWaYQu9REprkJxgGT1nLR2b6vhVSdyiaZoA/A0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rYf9Cp6F+YK/HVF8dz5VoLYjhz9W+I+Xg5QSs/xHeNmxpYpGmcuhdnlVua8tRYojN
         4xSKWTA7FMAW89vSbQHQkwqVAuECPkijC3Y0gNOknJCLH2ZXv61dwiMrfrZwjlSQ+N
         7et8vSlF7KmqNJcJ6T1WXGRM6HbnnAdc3VW5qKJ4+JqK3ybahGif2+Y1nldHccTSox
         vxZGeRU1GMFDJSwRqhPncVmkXpa6wvcDneIwJTCT+49++JpxgITC51r5Fr3EncDShc
         qomD0Ke1cPZ+NyAcamcmlZEHSk70wj+MVsG2gs3aZU6MGtkUw6XzCfWIQ3nZPu1gIa
         /phqt/xj/hVaA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>
Subject: Re: [PATCH] Documentation/locking/locktypes: Fix PREEMPT_RT _bh()
 description
In-Reply-To: <20220224212312.2601153-1-ahalaney@redhat.com>
References: <20220224212312.2601153-1-ahalaney@redhat.com>
Date:   Fri, 04 Mar 2022 10:13:46 -0700
Message-ID: <875yothc8l.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Halaney <ahalaney@redhat.com> writes:

> With PREEMPT_RT the _bh() version of a spinlock leaves preemption
> enabled, align the doc to say that instead of the opposite.
>
> Reported-by: Leah Leshchinsky <lleshchi@redhat.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  Documentation/locking/locktypes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 4fd7b70fcde1..bfa75ea1b66a 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -247,7 +247,7 @@ based on rt_mutex which changes the semantics:
>     Non-PREEMPT_RT kernels disable preemption to get this effect.
>  
>     PREEMPT_RT kernels use a per-CPU lock for serialization which keeps
> -   preemption disabled. The lock disables softirq handlers and also
> +   preemption enabled. The lock disables softirq handlers and also
>     prevents reentrancy due to task preemption.

Applied, thanks.

jon
