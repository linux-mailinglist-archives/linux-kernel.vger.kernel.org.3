Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339D459B20B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiHUFQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHUFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:15:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D524BF0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:15:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g21so5888686qka.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=ICbJbu994zVr5Xs1z95aw5HWEa26kaUMyLqHNb1JBhY=;
        b=PN7QnVx2jBrgPHqyqwc/bGpaE8KQadBOlUYLB6T+dOoTpwUJFZfkh7+JVXHp8AIDdn
         aHVqAoV2ZwSdEszZ8lrHjiDGK+3Uii266yrUQ3R+HEjiDpKwO+93234VMS0VxIslm3a2
         GnKw+ulrN3ttL/lmXtLFPyG1MFfOBD03JI5VIL8VtHlzN+J13QiCn0MqBcDQjVUJ2yxu
         YXyfDyjsbE5tLakbt0uihPXt6VtlTnTU8qek0GTcV92IjJUEcnKUo2hYjjstnq3Z/sjr
         QdiFfxuMoiaHkH94kHcVhCTjcWUnNDlAi3dffLlojPKp6NroKfJZsJrztnzru2HRTkKk
         WHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=ICbJbu994zVr5Xs1z95aw5HWEa26kaUMyLqHNb1JBhY=;
        b=qsi0/kUSldt78qubJzFBZBkko0zNxYCZdoykzVmqmzGnjl3Hnc3cANzEedlevU52jl
         pvG+7aHdDzJB59C7yX8FB1eP/oXoM6B2siwTtAErNMJ7uyDOUhvZ4H6bzR28vKlkBLMs
         /1rFtVctqqFRrsnJ+0+8ScvWluYr5+vwpzc0sAlPJj8bFt7Qp3Br33SOVHSjsSh/vsAz
         okMRp+MB8Mg2Cv19/1SWri+S24VtXRvd2C+B2Zb4IwYLlRuPSYBCY4bKyXoMeulmQk3g
         q0MuGj4oulOqr421Kqx3wyT4pfB8Cbck4f1ehhO20nEJDXdce4MBF4E2AatZf9AZbnqt
         d/Hg==
X-Gm-Message-State: ACgBeo3utNmwEA8pkxIwi7q0jlGA5TGhuXm55xfKLcnvD2+vz0o5IZOc
        1Z6F0toq26XcUV0iK0WuzNOLNA==
X-Google-Smtp-Source: AA6agR68yl2fr8PEnDujhC7M2MHll9zueDCXCVVuM/SRsb8w23zlYBdOQcq71uTGZEOLB6PPe+MzJQ==
X-Received: by 2002:a05:620a:70a:b0:6b6:1997:b7f2 with SMTP id 10-20020a05620a070a00b006b61997b7f2mr9605948qkc.417.1661058954697;
        Sat, 20 Aug 2022 22:15:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006bb9125363fsm7972537qki.121.2022.08.20.22.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 22:15:53 -0700 (PDT)
Date:   Sat, 20 Aug 2022 22:15:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
In-Reply-To: <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
Message-ID: <c194262b-b634-4baf-abf0-dc727e8f1d7@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com> <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com> <20220818132421.6xmjqduempmxnnu2@box> <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com> <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 20 Aug 2022, Kirill A. Shutemov wrote:
> 
> Yes, INACCESSIBLE is increase of complexity which you do not want to deal
> with in shmem.c. It get it.

It's not so much that INACCESSIBLE increases the complexity of
memfd/shmem/tmpfs, as that it is completely foreign to it.

And by handling all those foreign needs at the KVM end (where you
can be sure that the mem attached to the fd is INACCESSIBLE because
you have given nobody access to it - no handshaking with 3rd party
required).

> 
> I will try next week to rework it as shim to top of shmem. Does it work
> for you?

Yes, please do, thanks.  It's a compromise between us: the initial TDX
case has no justification to use shmem at all, but doing it that way
will help you with some of the infrastructure, and will probably be
easiest for KVM to extend to other more relaxed fd cases later.

> 
> But I think it is wrong to throw it over the fence to KVM folks and say it
> is your problem. Core MM has to manage it.

We disagree on who is throwing over the fence to whom :)

Core MM should manage the core MM parts and KVM should manage the KVM
parts.  What makes this rather different from most driver usage of MM,
is that KVM seems likely to use a great proportion of memory this way.
With great memory usage comes great responsibility: I don't think
all those flags and seals and notifiers let KVM escape from that.

Hugh
