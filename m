Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD15521BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbiEJO04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbiEJNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:55:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572682AC6DA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:38:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x88so4351187pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GHOlPZuq9ezSbSi7QKV81AD3fWcig4ojEeTiiJu9rns=;
        b=rXYMHlY+INKGyljb119od5zwZqKjLefZ7x5+V3gEcSuInoNu6s6rW9cAVJC2Expc5x
         +wYJgNd5LpQkHFDb+RQR/wwG1MUXfj1czmjKvNIlx9rDZcKKXuwKDgnDB32MSseakwe2
         tg7DeYMb5SYFqik3Kw32QxfY+FdzErxyUViEbwb92itcJqGAvQy/ayYwghlmSGmoE1hI
         gampyv65bl4WMc3Y2FRkPdSGMEy36nK5/Nu+xXxC61XBokfPIVTeOiYwBG47hVpqR8+H
         ShAMU+2m3uSumhh/xQXwd+6DumzgL23/qUmcrEtE6kgIOCjke5EECqJ5xcwunfAW7K6a
         /efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GHOlPZuq9ezSbSi7QKV81AD3fWcig4ojEeTiiJu9rns=;
        b=YwSQVlrOPVDl7Iw+Gv6pTT8gUNDNVx8c9ACRb66+FFF+pBnmaX3oTxaROeiKjZVs6P
         GMR5XbCfPwikJffI+Ux70fvNTC7Rwe0V7mGZeAW40v4NzwkZZ7c9H/gbTB5URL0lFgok
         xq4uPDPxjlLi0W3yA3VTAcec7rXN/CouU6hRt7ZML1hejFjUCeANaH33N5eJy7wjVo8o
         vhifH3zz0z5QznLUEjGacH8r/NqgOZe2C5PAnUVNrRjQkHM4rfR0ZR9EGutdXrV4LjgC
         aYDjN3+QgXJup9bBKpywd9P5qdWAtNNcfEgsRcoEwIzzPJoNaRui8qw/5YczcA0ufT7H
         ciHg==
X-Gm-Message-State: AOAM530mqrAxa7ix+D1oldYUrEtbRVNDNkOyOvXG/5hB7ByPBWgHZqM8
        rl1dnbY+ZbEy4ql5bBLJr3RMdg==
X-Google-Smtp-Source: ABdhPJzSHtzkhje29zpON/VWlwmbFYZucRm3YdJ0qgj79xSC3Sv+5XXBWlRs5kNuv+4ZjznmbP3+xg==
X-Received: by 2002:a17:90b:4f81:b0:1dc:681e:248 with SMTP id qe1-20020a17090b4f8100b001dc681e0248mr93436pjb.98.1652189913993;
        Tue, 10 May 2022 06:38:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id fs12-20020a17090af28c00b001cd4989fedesm1815747pjb.42.2022.05.10.06.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 06:38:33 -0700 (PDT)
Date:   Tue, 10 May 2022 13:38:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jon Kohler <jon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: X86: correct trace_kvm_pv_tlb_flush stats
Message-ID: <Ynpq1hmtO+Yu21J2@google.com>
References: <20220504182707.680-1-jon@nutanix.com>
 <YnL0gUcUq5MbWvdH@google.com>
 <8E192C0D-512C-4030-9EBE-C0D6029111FE@nutanix.com>
 <87h7641ju3.fsf@redhat.com>
 <C8885C42-26FE-4BD3-80B1-2B8C7C413A21@nutanix.com>
 <874k1xzuov.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874k1xzuov.fsf@redhat.com>
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

On Tue, May 10, 2022, Vitaly Kuznetsov wrote:
> Jon Kohler <jon@nutanix.com> writes:
> 
> >> On May 5, 2022, at 4:09 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >> 
> >> Jon Kohler <jon@nutanix.com> writes:
> >> 
> >>>> On May 4, 2022, at 5:47 PM, Sean Christopherson <seanjc@google.com> wrote:
> >>>> 
> >> 
> >> ...
> >> 
> >>> 
> >>> The net problem here is really that the stat is likely incorrect; however,
> >>> one other oddity I didn’t quite understand after looking into this is that
> >>> the call site for all of this is in record_steal_time(), which is only called
> >>> from vcpu_enter_guest(), and that is called *after*
> >>> kvm_service_local_tlb_flush_requests(), which also calls
> >>> kvm_vcpu_flush_tlb_guest() if request == KVM_REQ_TLB_FLUSH_GUEST
> >>> 
> >>> That request may be there set from a few different places. 
> >>> 
> >>> I don’t have any proof of this, but it seems to me like we might have a
> >>> situation where we double flush?
> >>> 
> >>> Put another way, I wonder if there is any sense behind maybe hoisting
> >>> if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu)) up before
> >>> Other tlb flushes, and have it clear the FLUSH_GUEST if it was set?
> >> 
> >> Indeed, if we move KVM_REQ_STEAL_UPDATE check/record_steal_time() call
> >> in vcpu_enter_guest() before kvm_service_local_tlb_flush_requests(), we
> >> can probably get aways with kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST,
> >> vcpu) in record_steal_time() which would help to avoid double flushing.
> >
> > Thanks, Vitaly, I’ll rework this one and incorporate that. In the mean time, do you
> > have any suggestions on Sean's concern about losing the trace in situations
> > where pv tlb flushing isn’t happening?
> >
> 
> No strong preference from my side but there are multiple places which
> conditionally cause TLB flush but we don't have tracepoints saying
> "flush could've been done but wasn't" there, right?

IMO this one is different because it's an explicit request from the guest that is
otherwise not traced, whereas e.g. INVLPG will show up in exits.

> Also,
> kvm_vcpu_flush_tlb_all()/kvm_vcpu_flush_tlb_guest()/kvm_vcpu_flush_tlb_current()
> don't seem to have tracepoints so we don't actually record when we
> flush. Hyper-V TLB flush has its own tracepoints
> (trace_kvm_hv_flush_tlb()/trace_kvm_hv_flush_tlb_ex()) though.
> This probably deserves a cleanup if we want TLB flush to be debuggable
> without code instrumentation.

I don't have a preference either way.  I'm not opposed to tracing flushes, but I'm
also more than a bit skeptical that any non-trivial TLB bugs will be debuggable via
tracepoints.
