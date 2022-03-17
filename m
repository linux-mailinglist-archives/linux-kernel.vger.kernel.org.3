Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE904DC973
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiCQPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiCQPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF07520214E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:00:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647529207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nh0nVqWt/6mnzc1g/y/peK7xgJFnY8oaONKZHXXXTII=;
        b=y1CxF8VoXIxb5HK+qi8usp93P9UWMZTT5LErSWHsC/591UTWTJlrxyl6m8GhWS4PuU/M69
        nQg8P6Cutz+RBsluPfixySDBWl95dLAAkH6VBg946nKRwRLf2F16ygZnh+0XnnY1/Nisx4
        z+9LMuwYN5L2JuXu3KwGgBQIA6kQcyQpzILDmYHd4Q1JExYrdHMi9JFPhZ+qFtieMjSApq
        iYK9PZ63Xw4LCLrsqXefHiM1hESeh+Ag+gG2un+TFFBVoCWP2hPTKMXxSHY7jOY91Ns1vl
        cNVvULiiBEPskTVdNSMKukZl5ooT2nZFrzt7ALzhKVBX892zaN/60SxGIWO8Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647529207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nh0nVqWt/6mnzc1g/y/peK7xgJFnY8oaONKZHXXXTII=;
        b=4gDrp4O6WMQokGfx6YBwqqe7nup3m4YRs/vY2L+E8ahbdLGdd4hj6K6n2gjNOBDLIDCvzN
        mqSbj2D0mOh6I4AQ==
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
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 28/30] x86/tdx: ioapic: Add shared bit for IOAPIC base
 address
In-Reply-To: <20220316020856.24435-29-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-29-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 16:00:07 +0100
Message-ID: <87lex8d3pk.ffs@tglx>
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
> Introduce a special fixmap helper just for the IOAPIC code.  Ensure
> that it marks IOAPIC pages as "shared".  This replaces
> set_fixmap_nocache() with __set_fixmap() since __set_fixmap()
> allows custom 'prot' values.
>
> AMD SEV gets IOAPIC pages shared because FIXMAP_PAGE_NOCACHE has _ENC
> bit clear. TDX has to set bit to share the page with the host.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
