Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780244C0D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbiBWHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiBWHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:50:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A86D1B9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:49:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so1940111pjw.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=E627RUNZI8BVu7aKzkB9EQU+HaYuIF8E1n5hAwi8GVI=;
        b=UhqSJ2zS5M8ZUtUHuH6t9qQu4lgWEU8YXCYrKcOaIeEMUDWkreFKvOOHIZu+3397hg
         RmMYQiZubfgjjm14Zk6D4fhr5sUY0f+1bdT2v7QCDpLQwZlGx7eTXJRc3FLW/l9lLA4a
         60opWRg2r3Y+fSFqq31WqhOUpbpJH+jbO3C1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=E627RUNZI8BVu7aKzkB9EQU+HaYuIF8E1n5hAwi8GVI=;
        b=zE7brgI/+dYjR0O/0GWvbAQVseAkZzed0C2WML0bD7Wb3LuZY6/UOsHFb3q3DeFyId
         rWkmsvOfjyERrWuHWAsHU4Ch3g22PiiqQpGYVY1rjwW/MmzjQyKy5npJfvnaYm3k2ZNL
         F2WeLvttk7zi12jxTyXmpxRBnlbnn0Q+sGD2lab5h+CoXWcvqbj52nypKzM+Bnhk1nLY
         MZB8gPIQ7sVf8xX47WuXDpf2GmUQ8BhXijby9cSbNN53H4MQLDdsVlo4Nlj5G0X/NyDk
         zdSJwDS963bhmB6nu99sbtX6T5MoZYPfFlGqxOZEpj/Dmjd31yTM1/1UPMmwtbIJ2L9V
         pfpA==
X-Gm-Message-State: AOAM533lvkjT3sDTfsAqCRtZp8ySxZ7vZCtAZJzv+30UXKKWzmpIuvIu
        MYZwKh5N1RCUx5QxLJ+WAZNang==
X-Google-Smtp-Source: ABdhPJzZcoICgoXFEPRWRrS1CdNR8/GchBf+zvOrVpytglbEK2XtyhsZd1JBznLxucmnfNejVvFwFw==
X-Received: by 2002:a17:90b:197:b0:1bc:5037:7c52 with SMTP id t23-20020a17090b019700b001bc50377c52mr7964776pjs.174.1645602597667;
        Tue, 22 Feb 2022 23:49:57 -0800 (PST)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e10sm5221699pgw.16.2022.02.22.23.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:49:57 -0800 (PST)
Date:   Tue, 22 Feb 2022 23:49:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_pstore=3A_Don=27t_use_sem?= =?US-ASCII?Q?aphores_in_always-atomic-context_code?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220218181950.1438236-1-jannh@google.com>
References: <20220218181950.1438236-1-jannh@google.com>
Message-ID: <8D85619E-99BD-4DB5-BDDB-A205B057C910@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 18, 2022 10:19:50 AM PST, Jann Horn <jannh@google=2Ecom> wrote=
:
>pstore_dump() is *always* invoked in atomic context (nowadays in an RCU
>read-side critical section, before that under a spinlock)=2E
>It doesn't make sense to try to use semaphores here=2E

Ah, very nice=2E Thanks for the analysis!

>[=2E=2E=2E]
>-static bool pstore_cannot_wait(enum kmsg_dump_reason reason)
>+bool pstore_cannot_block_path(enum kmsg_dump_reason reason)

Why the rename, extern, and EXPORT? This appears to still only have the sa=
me single caller?

> [=2E=2E=2E]
>-			pr_err("dump skipped in %s path: may corrupt error record\n",
>-				in_nmi() ? "NMI" : why);
>-			return;
>-		}
>-		if (down_interruptible(&psinfo->buf_lock)) {
>-			pr_err("could not grab semaphore?!\n");
>+	if (pstore_cannot_block_path(reason)) {
>+		if (!spin_trylock_irqsave(&psinfo->buf_lock, flags)) {
>+			pr_err("dump skipped in %s path because of concurrent dump\n"
>+				       , in_nmi() ? "NMI" : why);

The pr_err had the comma following the format string moved, and the note a=
bout corruption removed=2E Is that no longer accurate?

Otherwise looks good; thank you!

--=20
Kees Cook
