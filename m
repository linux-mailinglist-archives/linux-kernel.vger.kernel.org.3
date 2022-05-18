Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4864752BEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiERPjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbiERPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:39:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B2FAFB1D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:39:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so2138856plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z/HMrrvCFWNmAHmvXNwS49dfDiOpl1n+gYXOKnIc4zI=;
        b=dar/R+iwJh6De/GxHOwX6pHMbcfNFw2VosEiMVS9rUR0uhV04veQWjUvNn1Um9Mals
         wRoCyapdixfM61qMc2HADICJWAjNnbA0wtGr+uJWt1QyWrw8PNXt7Yv4NGDLvF2Gd909
         XcWfnB1NhBE0JV5FT3WZn8Q7ynTgoH7QPo1cYLo2usyEG3DmpqGOF4Wvrv4j9nv286VG
         lcdB7BWKcl6xOcJUlig3kblVxHP0L0b6ubldhuv/9M5eUxiQc66zPE9PTz5a6oeBRpRm
         cN/wh3MpbOvQlWkpL/q6/zoIwYwptqGj6VxyDCscWcLs6MIpRyajD/xgVpEZAEStq968
         ahlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z/HMrrvCFWNmAHmvXNwS49dfDiOpl1n+gYXOKnIc4zI=;
        b=IiVSUhMy0Pm7spda8HUf52OG0qBufqYXs8WJ/U4D85xguIlEHn+mZdUoAq4/jrEMZW
         TdZ/PYz5fCGV/PyCaaLhSu3C2ETvO1fAVOM99CbzFWDEldiE4qKcqeUrlb9XNVhdh/I7
         xFvK8ADcQSXGIL6rrAjZ4NuW8nzYjNEUkvf58MP3/UpTB3oh2o0D6quTqr22tMJ2xzfU
         kTUKNa72XFeW9DPY99GFHPO6FXxxxyrBWGrILuoaZ0r4sdcbkfPSCVGROYdUgelYxBjQ
         Uj6jGwaLY0EKDqtCo0OythHlbmONoXWX01mnWSKTAItLTbgCCixCoPQtswZhPDyZFVki
         PG9g==
X-Gm-Message-State: AOAM530d40V0o86Kem8KmyBP1FE8IoDjzuy0WKRPXx+UuEJW8hBdp4rf
        YyZd+tEAz5rL3OAfjRBrkBz8GQ==
X-Google-Smtp-Source: ABdhPJy4YDsen62GVqvNQ0gvtfR6xnGo8BpbBvHMqJCocqqqkTLqWVsTvmo43FO52CB7x/t5SXQ/jg==
X-Received: by 2002:a17:902:f814:b0:161:505d:a4f4 with SMTP id ix20-20020a170902f81400b00161505da4f4mr318446plb.6.1652888374834;
        Wed, 18 May 2022 08:39:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gv3-20020a17090b11c300b001da160621d1sm1671704pjb.45.2022.05.18.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:39:34 -0700 (PDT)
Date:   Wed, 18 May 2022 15:39:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v3 02/19] KVM: x86: inhibit APICv/AVIC when the guest
 and/or host changes apic id/base from the defaults.
Message-ID: <YoUTMsnFS+bSED+5@google.com>
References: <20220427200314.276673-1-mlevitsk@redhat.com>
 <20220427200314.276673-3-mlevitsk@redhat.com>
 <20220518082811.GA8765@gao-cwp>
 <8c78939bf01a98554696add10e17b07631d97a28.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c78939bf01a98554696add10e17b07631d97a28.camel@redhat.com>
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

On Wed, May 18, 2022, Maxim Levitsky wrote:
> On Wed, 2022-05-18 at 16:28 +0800, Chao Gao wrote:
> > > struct kvm_arch {
> > > @@ -1258,6 +1260,7 @@ struct kvm_arch {
> > > 	hpa_t	hv_root_tdp;
> > > 	spinlock_t hv_root_tdp_lock;
> > > #endif
> > > +	bool apic_id_changed;
> > 
> > What's the value of this boolean? No one reads it.
> 
> I use it in later patches to kill the guest during nested VM entry 
> if it attempts to use nested AVIC after any vCPU changed APIC ID.

Then the flag should be introduced in the later patch, because (a) it's dead code
if that patch is never merged and (b) it's impossible to review this patch for
correctness without seeing the usage, e.g. setting apic_id_changed isn't guarded
with a lock and so the usage may or may not be susceptible to races.

> > > +	apic->vcpu->kvm->arch.apic_id_changed = true;
> > > +}
> > > +
