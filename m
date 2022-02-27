Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588254C5F49
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiB0WCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiB0WCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1916C1E7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645999298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cu46C1+p5Z2okY9b0dKEBxEay9/qjlT1Qhpw4rLUHes=;
        b=b5tEwhdbYcALCcJ4RuKAbxaz3FVW/1cKHfsxq+eKmHehFAoRhSWTIwA17atjhz9F6BqK5r
        Kj2n8qzn0QcdQo1dlObMdUWfydOH7X+mXV43/RiYNNBMvOJ/vw18QjhUWe+6I5a5SI5Hbh
        TwSyi4+UzBEq0LKAWDUs5qAAFVKNnxk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-T_j8bzwtNp2TEmXVO7LLOw-1; Sun, 27 Feb 2022 17:01:36 -0500
X-MC-Unique: T_j8bzwtNp2TEmXVO7LLOw-1
Received: by mail-qv1-f69.google.com with SMTP id q14-20020a0cf5ce000000b004326eec23acso10561325qvm.20
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cu46C1+p5Z2okY9b0dKEBxEay9/qjlT1Qhpw4rLUHes=;
        b=RMUCnZN/E8BTFNMZrvwkFGmSGX0EMwInZK74kGHupiKXjPXgeuRwIlYQS2L7jKWn4o
         OhetwSTp6BZkx3VfkAbddJy+8K3H/xao3HnPia7yuyQroK10kdVKSd13MM2ad5viMPQF
         PGPlr6290BXRMy4w5i4B9wEST4V36J3hIneJUegyk1PuJ2Xcx7spPKvHGg9auOepBrv8
         QoEwW8GlfJ5nAA/NoXPxjLUATavyWZu5mzSu7s0+etdjDWXJHNmu5h8vDalRs2U5QPib
         D5wB/x/uJ3q+kp2kXYqpD43lAOoqwNdDIHynqa6VN7d7HgUS82LEBNnwFD6YNrTXiT1g
         2B0Q==
X-Gm-Message-State: AOAM533TPSpuDWz3VwEl7MoaL7gafU7GhXNfTMIWD5Kw9YyqkPTGmiZj
        TVanUQQvT71Ubevd2ppYH2jYt8ifnAHhXxqiPAJnWUckJoqSiLX9AS0qUhMNDgE5zMnhC8kigd2
        zMmQPOR4B/b0ms2hU5eR/uEVG
X-Received: by 2002:a0c:c784:0:b0:432:304c:a383 with SMTP id k4-20020a0cc784000000b00432304ca383mr12049590qvj.100.1645999296296;
        Sun, 27 Feb 2022 14:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJjmQIkWrwxek7pSlDac4e+FnTb1QHQ+fKpFNR9do+JasixFssPsd0lPHDPtuZuyEI2vnRlw==
X-Received: by 2002:a0c:c784:0:b0:432:304c:a383 with SMTP id k4-20020a0cc784000000b00432304ca383mr12049562qvj.100.1645999295943;
        Sun, 27 Feb 2022 14:01:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id p25-20020a05620a057900b005f1928e8cd0sm4107044qkp.134.2022.02.27.14.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:01:35 -0800 (PST)
Date:   Sun, 27 Feb 2022 14:01:30 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [PATCHv4 01/30] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
Message-ID: <20220227220130.23yjme7jucxo266l@treble>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 06:56:01PM +0300, Kirill A. Shutemov wrote:
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
> Acked-by: David Rientjes <rientjes@google.com>

The patch title, warning, and "Fixes" tag tend to give the impression
this is fixing a real user-visible bug.  But the bug is theoretical, as
it's not possible to enable X86_MEM_ENCRYPT without AMD_MEM_ENCRYPT,
until patch 27.

IMO it would be preferable to just squash this change with patch 27.

Having it as a separate patch is also fine, but it shouldn't be
described as a fix or use the Fixes tag.  It's more of a preparatory
patch.

-- 
Josh

