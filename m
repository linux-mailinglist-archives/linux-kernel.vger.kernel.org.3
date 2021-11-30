Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA5463E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhK3SzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbhK3SzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:55:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E276C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:51:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r138so20762196pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wwy0PF+bZDzgKrKsfEB6F7lM0DxNwS3682Y0XALKAo0=;
        b=G/yEhhosh2AMjf0gwIdOYRLjIu1H51PXBs/zTa3+KCCirq6oTXVJ1LC+UXJwdqaGkj
         wqLPWdRYaN/oemF0abvRQNCS7JbWOSOhYQ6mgr6BD0arqhHTeUxb8TIyVpwOqifcvW3v
         T3ITHaEP7qwMLqMtHqHArFr6Ds3PLNpkVhbf+OzmVst0bPbg6oV4Om5x7MRJs6ypy8dp
         7idZ1eN82btkfp/rU8LNeINAxczjIpwOrrqAoqCUZP2mqXm1HwskvMRTV/2DLLOSO5yy
         m/gUMxoPqrLalwJ8Sp798CV9gIZgqb0HUhd7cwexaZ7+s9NvgibOKUh2AmByek0NfIv2
         zFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wwy0PF+bZDzgKrKsfEB6F7lM0DxNwS3682Y0XALKAo0=;
        b=K/KTuQqW3SseilxZAhGIIOTmMadRuqSoilzExWGOcT2tXz8E8KS66vDWmToqUell8j
         3fP6p/Z0YorScU45720npsbcH4ozy0RSl3bVTcFc3ye1XzIFoomzC76IjxqAc8wvV9w9
         98+6o6lisIUFF1gRzoHCHJZaV8KBwv8F4YSK/mIzPUiW5P6QQuY1GRwlqutAw36vFcvB
         RvIGiqlD/yPEcoFztHxDLd6dEWGaTDZSc3iI6oZ5yMAy/OR4q2BFCZIqsThvyBmsj+VY
         Hl3Pre5cjqu6mtwJgteY+xk09owRAS8oi+IaNILsEjhHr5tkpUW/obn5QZlXlaSNEnxu
         brnQ==
X-Gm-Message-State: AOAM530dvUsMQXyZbq7yyxj/kxUsnSkkzakERAfe6pWKtEjnt4Q+S+au
        FYbgOM0CgbLZERu/KGJ1YQXG5A==
X-Google-Smtp-Source: ABdhPJzTMiizwv7kxr5S7dT/xhcRHe5iqmPIztXbiRRsm8yMq5/BJz/k44J3p7O/aPqHsp08XaVyag==
X-Received: by 2002:a63:1007:: with SMTP id f7mr786041pgl.212.1638298316768;
        Tue, 30 Nov 2021 10:51:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z10sm22036593pfh.106.2021.11.30.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:51:56 -0800 (PST)
Date:   Tue, 30 Nov 2021 18:51:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, isaku.yamahata@gmail.com
Subject: Re: [RFC PATCH v3 00/59] KVM: X86: TDX support
Message-ID: <YaZyyNMY80uVi5YA@google.com>
References: <cover.1637799475.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637799475.git.isaku.yamahata@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021, isaku.yamahata@intel.com wrote:
> - drop load/initialization of TDX module

So what's the plan for loading and initializing TDX modules?
