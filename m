Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600DF53AAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355995AbiFAQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355979AbiFAQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:06:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38ED25FB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:06:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so2328604pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdU8nswDqDsvPFeghxy5VOQMyKFYGDaAch2jfB9635E=;
        b=sqkBQ+oelmeycGTEbBFn+nTTkjaGRqBXEUQSTvOpgbteOU/ZsWp7opfi0R5ILLB/jR
         Nq5d3RQ4Jq1U1qiV4YM21+5/uMmLydBeus0f5ruqm9nl6UW74s2+4K5aBBkIBO/HWx/Y
         q2BNayFfm5vz6v4Lo2yafvtHwTgfx4QR0DdxmKJ3QXLhMJPYUDyfWsxfO1f2Uf3um8ba
         /O6zT936csRbleUVGGpnW1AYJ35ZSJknk/RsxKus9ftd4t3X+43mKlFLvMFpSe0CJ8e9
         ZfLZnzVDEYVCyC6YAISmJ37SNDP6BJBIP9L0X3cPTMejLr3LwU+s5CQtCfc8JuCdFwXr
         b7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdU8nswDqDsvPFeghxy5VOQMyKFYGDaAch2jfB9635E=;
        b=PiqHVgj00cwcQKiAlpkTjAAkul/W49gl/i2BEPuymn2GdNt/OkSTD8ZEv+ZRU/qh+H
         HU/PZSjlC57awiYiM456NahoJnL/LOZO6qm2eKU3X5EcJ4acaRKBg3j6PsLW/3KzFF/2
         cLmWufjl4iFPVKtZRfUeBbAY0PNwlw/Gge5DAiE0vkEhYyEDPP6pCugL7oNXi3mW7s7e
         ZmDfB7QhKY2Ctrkzgb0mnEkmbGBFti+vt+b9zoQMNgqxyr/601ssyOsuX0ZNU3Nf40i8
         dbHPzrl2YeFL/fN7muC1bzteVV3l3YDedzFMWyxQcbIKxKAVlUGAwDGYngjrMqJV1qlc
         6zkw==
X-Gm-Message-State: AOAM530/GeV6M/8BaaQKAEm2jc0mviuyWwXuYv92BkqdWochCSbiF33E
        awRFX5J1PmkB00Emrcxs9SbHpA==
X-Google-Smtp-Source: ABdhPJxm9QXDQf89uXG4X2gE7qX9VgeOpxAulz1ZoiDWF1W7ncnlBKoSdAQeSXV0+j+jimhhEeXzjA==
X-Received: by 2002:a63:6aca:0:b0:3ab:a56:126a with SMTP id f193-20020a636aca000000b003ab0a56126amr120286pgc.576.1654099608158;
        Wed, 01 Jun 2022 09:06:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902e30c00b00163f1831ddfsm1713143plc.40.2022.06.01.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 09:06:47 -0700 (PDT)
Date:   Wed, 1 Jun 2022 16:06:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Make hyperv_clock selftest more stable
Message-ID: <YpeOkx0gkINeKFuz@google.com>
References: <20220601144322.1968742-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601144322.1968742-1-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022, Vitaly Kuznetsov wrote:
> hyperv_clock doesn't always give a stable test result, especially with
> AMD CPUs. The test compares Hyper-V MSR clocksource (acquired either
> with rdmsr() from within the guest or KVM_GET_MSRS from the host)
> against rdtsc(). To increase the accuracy, increase the measured delay
> (done with nop loop) by two orders of magnitude and take the mean rdtsc()
> value before and after rdmsr()/KVM_GET_MSRS.

Rather than "fixing" the test by reducing the impact of noise, can we first try
to reduce the noise itself?  E.g. pin the test to a single CPU, redo the measurement
if the test is interrupted (/proc/interrupts?), etc...  Bonus points if that can
be implemented as a helper or pair of helpers so that other tests that want to
measure latency/time don't need to reinvent the wheel.
