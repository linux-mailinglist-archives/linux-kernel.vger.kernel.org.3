Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB757E6FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiGVTFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiGVTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:05:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1381B792
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:05:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b10so5125991pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vtl7bUaSww2dX17uKCCNma/7oSJnHJ4lHRUjybpg4i8=;
        b=RulLqLWXe0zwxBGEwxGsZJ1b8VWZmr4rF9aGoGxT0tfU+8Vm3wPUy6DNRddSdKCr7e
         2oUwC3AuWKsKNXkUULj+mUelwunEa8mkmj1xNvzLdIHtgWzZjMwgt6c5UFPjp4/7uiHZ
         y4udA3l5JlaAIz8j4JbaqgTeYlinMBwqPhv+P3oWYA83RaDiRNqIMfCrwC10DzQoKkV9
         Iua95KQXA1UlEGHZV3zgYkBHCzc3/9+3EgDJThiY5WZFj74Z+CQmYW716pkmc8ejLif1
         3JV1RjAkz9E4sMViqwU/m9VAYJP8vb2hZfJgSpvcKkfqIAx94LIkjfzJr0djFksFc8Og
         FHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vtl7bUaSww2dX17uKCCNma/7oSJnHJ4lHRUjybpg4i8=;
        b=4kGwV32HyDT3jMOyC2HJUPqFnsaluOkXXPvJC4v0oT9pzCzYbSX5VDWo0uU8K8Rx1l
         ceGhhlCZQhez+OpOC6P0XEcMnDq3YyglWIxve5uGMJR70fR/3Q0gbW1BF2EJd87+/L6n
         mgzr0K9QdvGp8hCEuDXt3BgFjrZL/HqoK3VjEftG+fv510yXpH1JEsNQvzYcz55Mqb/d
         yR7Qt7MJRMr0ZRK990rqyJlrr8jn68FwutLypW42xHiB7+7Y3UoPG1yx+/jy4QTVYC1z
         d3gEjLIp4Nh8VtM9XbUIJDDRZCWqpCHQuLR+TWFVBuAFIz2jQNb7q1mUfMWqIor1vuz+
         lpyQ==
X-Gm-Message-State: AJIora9b0Kw+L+eF7nYqkP6URCz2SM9OEgGcuGMUPkYiQiwHzcjDgDjh
        6h4xj3sZwQKiQUYhjvDvt4E=
X-Google-Smtp-Source: AGRyM1uFaeXDHEI4BMILhSrtIg1WRubkzoeUpiRVbRs+e50rghlZQkcndSePJu3BxBwAcb9ZYcUvBQ==
X-Received: by 2002:a17:902:d40c:b0:16d:288d:7295 with SMTP id b12-20020a170902d40c00b0016d288d7295mr1216366ple.67.1658516726617;
        Fri, 22 Jul 2022 12:05:26 -0700 (PDT)
Received: from localhost ([192.55.54.49])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b0016c454598b5sm4169148pls.167.2022.07.22.12.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:05:26 -0700 (PDT)
Date:   Fri, 22 Jul 2022 12:05:24 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Message-ID: <20220722190524.GA3299911@ls.amr.corp.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 05:27:08PM -0700,
Dave Hansen <dave.hansen@intel.com> wrote:

> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> > In TDX guest, the second stage in attestation process is to send the
> > TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
> > not support communication channels like vsock or TCP/IP, implement
> > support to get TD Quote using hypercall. GetQuote hypercall can be used
> > by the TD guest to request VMM facilitate the Quote generation via
> > QE/QGS. More details about GetQuote hypercall can be found in TDX
> > Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
> > titled "TDG.VP.VMCALL<GetQuote>.
> 
> So, the quote portion of this is basically a bidirectional blob sender.
>  It's to send a blob between guest userspace to host userspace.
> 
> Do we *REALLY* need specific driver functionality for this?  For
> instance, is there no existing virtio device that can send blobs back
> and forth?

It's virtio-vsock.  If virtio-vsock is available, the communication works.
However, some users would like to disable virtio-vsock on their environment for
some reasons.  Even virtio at all.  Especially for confidential computing use
case.  It's their choice.  It can't be assumed that virtio is available.

The goal is VMM-agnostic (but TDX-specific) interface for that.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
