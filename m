Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3668A52F1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352396AbiETSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351777AbiETSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:01:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3ED188E54
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:01:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c2so7986436plh.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhyTscK+P12+72mYbR2QUOoRFikQv5/b7915viC4NC4=;
        b=TcbhkaA+ESN+OPqp5q7h7FRrnUKdpOHBRuN2IsTJWTpIPoTwUKllsKVSjZjR476EEl
         +tJnF+iRFCzqkUudVDaKW50mbIkVyyJfbynwclJ3Wmhz2l0/z+MPF6eDrYJYwKtzq7Py
         +3Gw/wR3QHbHevzT+Omgzq2uV9UIdPN+SOIhH/esj2BfoLwa9y1herUw3Tkc8kzVb59w
         himRsvHKL2+Ka6vvFqCRDiPDLyZ2RLR4saSA8sWXhPcxHvNJonCD339OF9RibsakKwlL
         m3pB0EHEalt2vIiP9x2+H1PgSZE8JtyZm7RGAnWQ3QCP/RxhvtIQmTP+6TcZ8AabC8uh
         sOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhyTscK+P12+72mYbR2QUOoRFikQv5/b7915viC4NC4=;
        b=1rRki/2UjtCgEBu8TP7X6V3tWkIeCujNNHXybPGFjJdjBOaEw69whBY8K2HpAbSWeK
         Hqug3WPi/8cEYr3pDKBtCe7njUsYHPvjL6/fiFUXXJA+jF7e+28vYiCVxxNds0Ln4Icn
         t23lgSSBJQNCbgjEaVKa47Hrx7H/IU6VIqeJQPdcOx14ri8AJlBbvBGFxcliw2JOJd5m
         dRESVUY6TR1BdCrt6kDxQhR7dkVGpzMBWq0uh4Jqxt62IH8gU87h6VcNP2OLZoWuKQQ4
         2V1QBKdtfnGJa4vVJNDLkW6FYhGwbz3lpBZIRHjS1pnbr9ewN57sqGXeKyOWUpzuYai9
         Nihw==
X-Gm-Message-State: AOAM532tNIvQ8ptuqOnrAV3W8ZcoKb9YHFYGNczhHQDG1Ngqhbv2rRPA
        1Wmul0LOjvw2zAPnlvbhIYPBRA==
X-Google-Smtp-Source: ABdhPJxh9h6408QlT8PD1y12q4yRHYJh++HLkpbtDxRL6Iw+K0RKoNbju1sf2J78TESI3+VzCVokoQ==
X-Received: by 2002:a17:90a:ab90:b0:1da:375f:2f44 with SMTP id n16-20020a17090aab9000b001da375f2f44mr12150125pjq.33.1653069715606;
        Fri, 20 May 2022 11:01:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a00228d00b0050dc762819esm2143485pfe.120.2022.05.20.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:01:54 -0700 (PDT)
Date:   Fri, 20 May 2022 18:01:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv2 2/3] x86/tdx: Clarify RIP adjustments in #VE handler
Message-ID: <YofXjHpME0SwaHfV@google.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-3-kirill.shutemov@linux.intel.com>
 <af726924-4eb1-aa2c-319f-0a67003ef37f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af726924-4eb1-aa2c-319f-0a67003ef37f@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022, Dave Hansen wrote:
> BTW, how do we know that all non-EPT_VIOLATION exits reasons are
> instruction execution?

The TDX module spec actually does a decent job of calling this out explicitly:

  #VE may be injected by the Intel TDX module in several cases:
    * Emulation of the architectural #VE injection on EPT violation, done by a
      guest-side Intel TDX module flow that performs an EPT walk.
    * As a result of guest TD execution of a disallowed instruction (see 10.4 above),
      a disallowed MSR access (see 10.7 above), or CPUID virtualization (see 10.8 above).
    * A notification to the guest TD about anomalous behavior (e.g., too many EPT
      violations reported on the same TD VCPU instruction without making progress).
      This kind of #VE is raised only if the guest TD enabled the specific notification
      (using TDG.VM.WR to write the TDCS.NOTIFY_ENABLES field) and when a #VE can be
      injected. See 16.3 for details.

The first one is (obviously) the EPT violation / MMIO case.  The second is purely
instruction execution (the MSR and CPUID clauses are specific to RDMSR, WRMSR,
and CPUID)).  The third I hadn't seen until now, but it's opt-in.

The main switch statement further guarantees the kernel is only going to handle
EPT violations and instruction exits at this time:

        switch (ve->exit_reason) {
        case EXIT_REASON_HLT:
                return handle_halt();
        case EXIT_REASON_MSR_READ:
                return read_msr(regs);
        case EXIT_REASON_MSR_WRITE:
                return write_msr(regs);
        case EXIT_REASON_CPUID:
                return handle_cpuid(regs);
        case EXIT_REASON_EPT_VIOLATION:
                return handle_mmio(regs, ve);
        case EXIT_REASON_IO_INSTRUCTION:
                return handle_io(regs, ve->exit_qual);
        default:
                pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
                return false;
        }

