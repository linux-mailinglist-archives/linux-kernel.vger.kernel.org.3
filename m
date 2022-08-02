Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9DE587B56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiHBLHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHBLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:07:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0F3F33F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:07:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rq15so19264499ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HhBjbo8A8eWeFC5DIsw7GV25tztk2PipnKxnLI7M/pc=;
        b=IZO632N+8fJgZ63cyIvrli96zxrVST1ZyxOO8uBBjR7RIEMfaWr20NZlDFLUDxhhCX
         TDHj2F4kY+WNO+je4RnJkMQ0dzAZ/xosI0+XAfs+WzvCxsfdFOAdhRgo8UzUKUXdgKVg
         odRGlOFdwz3kFg+ziaFThsZLfgJ+ao3Iq+X8wExis8bP1MhvZrtLr1/2swsb8DIINGqJ
         fRksmk0gBuAkSGJWtRQ785h7GYoedhPHcJgcvHUBPq/JGrLZHA76fqmdp8ltcqDqLq0b
         Ria0Do+5yx7Lg212wl4xvex/Wa3Ox6r2E/JIP4tdxU19UfV7xJz/gCQAz1VaSyvQV6fJ
         +tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=HhBjbo8A8eWeFC5DIsw7GV25tztk2PipnKxnLI7M/pc=;
        b=YySopo7CtN10RcwjHETfLhVPS86k+4bY+DNSpAkYg9PAv0oJh0uUIw4J8s5XwHXNeR
         2FAjkIRvJaqinmz6PXTyr8aGF/G/klDCtTS3+Ighcd/nsjFzhD/NJgK9W2atgp6Sgm7v
         nfQXbuxZnbYJLAcIJlZ/XIQMqWzghQFECkCR38TBHNHGweAJrm0uN0ApkYcAcVyjAZCb
         MYBW9wHWJYCtlr4jE9efQTPpLSJDASOBaz6uIOjfRv7tofKKt27DItuzmGaFAjRiQ+mO
         uVy7Be1LOR/O/js1ZFjvuqG4qLQZ6lz0BeS2DdwtDoQyOnovKyQ7h8ck8v/jKOCBRwbV
         jlcg==
X-Gm-Message-State: AJIora/Si1WrDErpw4yRJMrP48fHyrRxvbIcMkxLY1TJrWmaMRMnECGC
        HE7SSZxJVitaHjKlXjHBgvs=
X-Google-Smtp-Source: AGRyM1uIexBXkZ/W8ypkBhJxXAeE7iOOu9zuACRy8RUXHAcGJJt+UJ5KxTBjnCDBBrNIWr41YAr2KQ==
X-Received: by 2002:a17:907:9801:b0:72f:1a8d:8dbe with SMTP id ji1-20020a170907980100b0072f1a8d8dbemr15444298ejc.537.1659438467494;
        Tue, 02 Aug 2022 04:07:47 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id ck28-20020a0564021c1c00b0043df40e4cfdsm808114edb.35.2022.08.02.04.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:07:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 13:07:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] x86/numa: Use cpumask_available instead of hardcoded
 NULL check
Message-ID: <YukFgFTaq4Aw+uht@gmail.com>
References: <20220731160913.632092-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220731160913.632092-1-code@siddh.me>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Siddh Raman Pant <code@siddh.me> wrote:

> GCC warning log:
> ===========================================================================
> 
> arch/x86/mm/numa.c: In function ‘cpumask_of_node’:
> arch/x86/mm/numa.c:916:39: warning: the comparison will always evaluate as ‘false’ for the address of ‘node_to_cpumask_map’ will never be NULL [-Waddress]
>   916 |         if (node_to_cpumask_map[node] == NULL) {
>       |                                       ^~

Your fix makes sense I suppose, but I'm wondering how testing didn't 
trigger this warning.

Off-stack isn't a rare config option:

  kepler:~/tip> make allmodconfig
  #
  # No change to .config
  #
  kepler:~/tip> grep CPUMASK_OFFSTACK .config
  CONFIG_CPUMASK_OFFSTACK=y
  kepler:~/tip> 

What am I missing?

> Fixes: c032ef60d1aa ("cpumask: convert node_to_cpumask_map[] to cpumask_var_t")
> Fixes: de2d9445f162 ("x86: Unify node_to_cpumask_map handling between 32 and 64bit")

These are ancient commits from 2009 & 2011.

Thanks,

	Ingo
