Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77E49D21F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbiAZS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244315AbiAZS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:57:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F30C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:57:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so519449pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0YXbOqZCsc8uF1b0Zx5GyaapQWG+DhSG9kbL2Nvau8w=;
        b=Ncar0u/nCD3QOPWjMEpiZC+nS8dL6KPw+LXBV3hT830C2ZuPO31OelF66gzYGeH6Zc
         np7imoQBUzeHT9/i8BkHDVWTVlV/EYcxhWRCcinjdcCRdR7YiBdRyer3HrKVtbxzvPZH
         QPIjz+EQlfUPCgKYD5kBrehuqjJ7OE+Mbz7WmGHMdYVj+MMjTJ8buUztU6v5i+WgRAMm
         s9/m3VIDZAPPZ0xtQlRRhfJZ2epEHxlB9KXJYUosX4LaeW7Adle+mjRc3AhhtcKYIVQx
         aYwSRnM+aGnObCYe9lPX4h5AXkPOUS2fq04L/HSeKtNcC9ipQboB+H5prEg4v0s2Bo2y
         cN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0YXbOqZCsc8uF1b0Zx5GyaapQWG+DhSG9kbL2Nvau8w=;
        b=HO2EeYX5Qyu0Wu0d/ns8G1E6gvM0h3J8/sPaPLkiVf1W0hSuXsxg6NuWoLJbw51AjW
         jUQMnJOEL9DXKoDxJAfpf2SRZDnuvnAo0jDVG02OEU6jXWabyaTfEHWeZDGXZp9S5/OA
         fRCw9pWDbrhaEyl5DFga9/P7cT+r5URnWuMtlP3C47f8x+Gm6a0Xd+nfcvIsPgRKVY+3
         sHV3vfeprpc4rGoaTkR3sls8AKOj2/LcdHmJxU4HQXnIySzt36vXNQwqAbTnIQYKktaC
         FfGtojYBnLQTWIKOMLC0tDETTH+8HyVoo2+SFQC/smuGlkxQNlm2F0ZGKVnb/Q80FSj9
         wyJA==
X-Gm-Message-State: AOAM532TNqqtoab9HwBnM7/nWPGrVbv/57KA4olJXhuMyQ4HOPjB4YB9
        6ukYLRbkbxUKXCAv6MrEXjLMuA==
X-Google-Smtp-Source: ABdhPJw1ZvbPGuzvUcLhU5wrEXvWSy+j0FWUp5hFY52/DHlJEXTVXCMy/jSjlubXgGGYh8KVBshO5A==
X-Received: by 2002:a17:90a:d203:: with SMTP id o3mr10075663pju.122.1643223433598;
        Wed, 26 Jan 2022 10:57:13 -0800 (PST)
Received: from [2620:15c:29:204:925c:a455:6d75:1ac8] ([2620:15c:29:204:925c:a455:6d75:1ac8])
        by smtp.gmail.com with ESMTPSA id g1sm2898783pfj.58.2022.01.26.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:57:13 -0800 (PST)
Date:   Wed, 26 Jan 2022 10:57:12 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        thomas.lendacky@amd.com, lkp@intel.com, ak@linux.intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, tony.luck@intel.com
Subject: Re: [PATCH] x86/mm: Fix warning on build with X86_MEM_ENCRYPT=y
In-Reply-To: <20220126115919.7691-1-kirill.shutemov@linux.intel.com>
Message-ID: <e58354f2-d978-2449-67cb-cae63d2b6dd7@google.com>
References: <202201261113.3P3URW2n-lkp@intel.com> <20220126115919.7691-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Kirill A. Shutemov wrote:

> So far, AMD_MEM_ENCRYPT is the only user of X86_MEM_ENCRYPT. TDX will be
> the second. It will make mem_encrypt.c build without AMD_MEM_ENCRYPT,
> which triggers a warning:
> 
> arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for
> 	function 'mem_encrypt_init' [-Wmissing-prototypes]
> 
> Fix it by moving mem_encrypt_init() declaration outside of #ifdef
> CONFIG_AMD_MEM_ENCRYPT.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 20f07a044a76 ("x86/sev: Move common memory encryption code to mem_encrypt.c")

Acked-by: David Rientjes <rientjes@google.com>
