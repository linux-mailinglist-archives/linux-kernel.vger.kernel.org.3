Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003F54DC51F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiCQL5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiCQL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373AA1E5A6E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:56:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647518182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGDWpn4Nd+uvmJdYTff2wapx3t0iRL9wgWFjTPR3T/o=;
        b=kcfYjhPhEky1G/4eLzaWqhS2gXIePqiuNm/XHOly+5Ia7ezNUXWqibpOoBx9pI7XFqUS41
        VpMlla/Sn6DQbCsV7PlgiO+nWAhAOUCsde+nVf6DeNCQI8J0uODk/zmIE3zntV9/hBtU0Q
        fK6QcKIgq/SjApsDH73UmI1OVgAwAM3Bf2WDpGWdB0DkL6VBVs9jw5gaTXHb/ONOWWoKDf
        g9TNbcXPPuuP0GImKoStLisL51HAAEMs7i4sgV7HVERGW9s8AIUnItmndKuVH7ZbWbREj7
        Uf6A9RDQKSTxBzPg9Zc7yDRJ9EgDQ0gk1SM/x6ST9qevmAICI9IYF0lC47Cg2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647518182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xGDWpn4Nd+uvmJdYTff2wapx3t0iRL9wgWFjTPR3T/o=;
        b=4mfzzwiwJ1CkEX+izxxiJkuxfiWn4ECOne/Owep5gpdH1B0cjREr5Xp+DhG/Z761L/Dzgc
        7hz2d9K+NzrsnhAQ==
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv6 13/30] x86: Adjust types used in port I/O helpers
In-Reply-To: <20220316020856.24435-14-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-14-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 12:56:22 +0100
Message-ID: <87h77w23o9.ffs@tglx>
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
> Change port I/O helpers to use u8/u16/u32 instead of unsigned
> char/short/int for values. Use u16 instead of int for port number.
>
> It aligns the helpers with implementation in boot stub in preparation
> for consolidation.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
