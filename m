Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1BA5854BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiG2RtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiG2RtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:49:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED0389A84
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:48:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z19so5252118plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PTRupmp5vsLtMUYck90Z7yNnJEZgEVE+WjYQFBmYlJE=;
        b=dZIpPUXOgSfBNELSae/S8aQkP6DV6ayAYEnmtZooiXfEyh+MMKpkCvpwZUlvTpEAkK
         G/qpjTm2j+mhW8XIe6o75toIeVLE1G0p9VOgp+v6O3ab95FxQNNHaWbal2VtR4Td0tVJ
         VTHAAKlPwj+Aedxm0R880y53SQzweX3DNSkaXMWGePt19yUwtqLEZNXl812jy7cFEvWY
         Kg0oV1Hq+kBogxJ51xmQtjpP2+LmaEaeY9s/2Bne5hnFtacTzXiGCnb1sDoSvX4KSt/P
         TD/LrOV1GSIrSPT9EUaEc5NLbwuLB4JxgMniSp9H6bgRsPUx/ltYqelxYkE/SnIwCJkM
         jyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PTRupmp5vsLtMUYck90Z7yNnJEZgEVE+WjYQFBmYlJE=;
        b=ZElWx4jv61JdKxb1IR+nvBH2EzD814YPrGaJ51CrItWK/oAuSJsRNs6O7bkfzV3ryL
         x+AlFmRE4bMR2D9ANlJeOzNpO82kDEycSY6kUq6BfjRUmFUAi83ZBIake45p5SVw0BFb
         jsSxOFbTaBkV0pCHRHLlP1GJUZk0VKnMxbDnZS4JCcyWE/sSbyqxp+Vl655tqrxjA8tQ
         B9LzZty/V6IUQ81xD3JlmvmAH7XZspT4NXWg8pU0KszZDcM+/11StaFd4R+CDvMlTyto
         WiWaR/j1mpJMRXXDWiAVr8E+PxSrSF95ABUr59cuiHfD6SyRrV6DqbTRV5ZEn4V/eASK
         VkTw==
X-Gm-Message-State: ACgBeo1pm/IdudI7LXlpfXIk6khFoDCrnn+a0hG6s+z3QIWHM1UIYS/l
        BnAzer2h+0442BEo6IxXuHlJkImQyqKRZw==
X-Google-Smtp-Source: AA6agR6FAJ5onZVuWEdXDjXacsA4rjiICGO1wSe5bgK5CukF6i921ex19FBZiNXsDyqeVYngrys1Yg==
X-Received: by 2002:a17:902:f7c6:b0:16d:c795:d43e with SMTP id h6-20020a170902f7c600b0016dc795d43emr4986750plw.162.1659116938601;
        Fri, 29 Jul 2022 10:48:58 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r17-20020a170903411100b0016c29dcf1f7sm3883867pld.122.2022.07.29.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:48:58 -0700 (PDT)
Date:   Fri, 29 Jul 2022 17:48:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: do not shadow apic global definition
Message-ID: <YuQdhaUi0ur4l/zb@google.com>
References: <20220729084533.54500-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729084533.54500-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022, Vincent Mailhol wrote:
> arch/x86/include/asm/apic.h declares a global variable named `apic'.
> 
> Many function arguments from arch/x86/kvm/lapic.h also uses the same
> name and thus shadow the global declaration. For each case of
> shadowing, rename the function argument from `apic' to `lapic'.
> 
> This patch silences below -Wshadow warnings:

This is just the tip of the iceberg, nearly every KVM x86 .c file has at least one
"apic" variable.  arch/x86/kvm/lapic.c alone has nearly 100.  If this were the very
last step before a kernel-wide (or even KVM-wide) enabling of -Wshadow then maybe
it would be worth doing, but as it stands IMO it's unnecesary churn.

What I would really love is to not have the global (and exported!) "apic", but
properly solving that, i.e. not just a rename, would require a significant rework.
