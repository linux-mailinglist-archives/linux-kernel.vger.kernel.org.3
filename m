Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2A4DC964
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiCQO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiCQO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:58:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0352042BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:56:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647529012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SNPcSHU+CM7EhtR1qixOFb9nT6804xY8a1v51dj1a8=;
        b=C4eat0tGTQhNy4zvdWI7Qb2TCGcQEqEejUT/ppWcGq4OjkpmZ3K1CRIVFtpHslTw3vCrXv
        az94VXfYuGMYd7dcxLN3VURgFpURUU+/YYHJ+tHP4ictN0N9/5RLZtNm/hASzC/LMkKaN/
        Qu1mv8O3Z8n7Rzyk2MOCICmhK/uYGJi6c2b8vPswdkP5BIDNlrAa/8lfJrbHBlXT1SVTIk
        BmE6i3fJLkZjeWe2OCOY3U4L167dCvvGM10gRmePDEnFhWy4gD3txJ3IJKXzC4zlVoZthl
        QE84AhB9lV3CPm5rhnXuWgwqSJugMKxloAH1dWdkHSyLOZ7WqJTQv5aR5SbU1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647529012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SNPcSHU+CM7EhtR1qixOFb9nT6804xY8a1v51dj1a8=;
        b=ETgmRl64KLtz3mLUlwA1OIgiIyETCdYhpe2ucFfiCA0DRxVX6zUzyTseQ7Uqa63gLZU0JA
        DppixLKrWP99mYDA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 26/30] x86/mm/cpa: Add support for TDX shared memory
In-Reply-To: <20220316020856.24435-27-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-27-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 15:56:52 +0100
Message-ID: <87o824d3uz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:

> Intel TDX protects guest memory from VMM access. Any memory that is
> required for communication with the VMM must be explicitly shared.
>
> It is a two-step process: the guest sets the shared bit in the page
> table entry and notifies VMM about the change. The notification happens
> using MapGPA hypercall.
>
> Conversion back to private memory requires clearing the shared bit,
> notifying VMM with MapGPA hypercall following with accepting the memory
> with AcceptPage hypercall.
>
> Provide a TDX version of x86_platform.guest.* callbacks. It makes
> __set_memory_enc_pgtable() work right in TDX guest.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
