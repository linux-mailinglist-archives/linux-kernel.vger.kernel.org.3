Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D194F9F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbiDHVhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiDHVhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:37:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C7124BFF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:35:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so9500894pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qOh37iLUcxnJDmoGj1A0J8wEY8rbxtdTzE2pYYO2Ks=;
        b=K7ke0nxKWUWDfr1v0VmW7e7Sj+uaxy5yBp10RU78CNH/g52aooIPr2w/v94GPqq3yt
         zFQSXrnXOZwWVUdkVrnXqcdRHdIfF/bEXnSJnFQRftzCNuBi1e8Qhjqx8VPGVIHFvCXB
         2Z8dmxdfIM2m4yiW/h/ciGT0wL20FvLMroNAuoVc3UK7tZGvENlBr1v4Ga4ak5TS0xT7
         EVCU5/eAZq6lWcTbvTxiMajlg+tAlQpvVvxFpD9bd10ybCnJ2A+a3w5D0mo5UZtae6pZ
         0Cu/TPA4wIOD9fd48Rf6GMXJ5k7Fa9yM+N6O3DNJ4Y5rx+o8OM4kClD90lO10A1XGyd+
         MH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qOh37iLUcxnJDmoGj1A0J8wEY8rbxtdTzE2pYYO2Ks=;
        b=keDV7P5cCPxKAiLwc62bEZkC2R4knV/cntN+FNP/Qb5Cg7btaccSbiFQ8w+JWT6KrW
         OABPFgmRcwYpStpx9xJL9b59lKTytcBfloWfJJZpZFxn5eQ9GWDA7RbDi2HmWLNF/R8e
         B0Gp3anSfssLhUeo6iymtVi40Np8UwqFM92kqP9Q8BVzOkoOE5L6+OqLH2s/qk2vEKmd
         unfgES2hux6iqnb+ioVj23vPhXR9N0zwng0aPy8w5JpnGvd2snbXo4PZbmXim3L8YkUc
         9hO172WtBvmX7EN7HN/2vZ8LUsuUe9KWFEdBDk4KlNM5vGYzNxSMYmrr7GfAo6d3YGLp
         lZog==
X-Gm-Message-State: AOAM532tWQUNhnFcHL0+GYdMWKMxICiBm+6L78X8vPglSR6bCcQcEP6f
        EYgPwp+6j7UK1UUkGSP0Lbs+xLYA0UYqwJZ/wCr5uQ==
X-Google-Smtp-Source: ABdhPJxus4Jbsc/w4aGFY60Ag12TVzRnVuVqzB94CGBFmaLEQk//iA1NOJ2EJlj9NmymKztcqpk5RfgvqqLZIEnC9mU=
X-Received: by 2002:a65:53cc:0:b0:382:8506:f1a6 with SMTP id
 z12-20020a6553cc000000b003828506f1a6mr17358980pgr.44.1649453716972; Fri, 08
 Apr 2022 14:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com> <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
In-Reply-To: <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 8 Apr 2022 11:35:05 -1000
Message-ID: <CAGtprH9DGyxSKSwVhc0Td3x-M4-C6j=+d3DEtkxOty+PPB0V_g@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 28, 2022 at 10:17 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Mar 10, 2022 at 6:09 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
> > This is the v5 of this series which tries to implement the fd-based KVM
> > guest private memory. The patches are based on latest kvm/queue branch
> > commit:
> >
> >   d5089416b7fb KVM: x86: Introduce KVM_CAP_DISABLE_QUIRKS2
>
> Can this series be run and a VM booted without TDX?  A feature like
> that might help push it forward.
>
> --Andy

I have posted a RFC series with selftests to exercise the UPM feature
with normal non-confidential VMs via
https://lore.kernel.org/kvm/20220408210545.3915712-1-vannapurve@google.com/

-- Vishal
