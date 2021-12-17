Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC147975F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhLQW5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhLQW5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639781832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+KxH5v9Eb3o+QR18pfErKc1z+d/J0pC61Cr5tDyvWcc=;
        b=b1HnszjaX33gofi4ATvSJONR6lDXP1Fnmzed0ivcD+wuv3nPB7vsq8/wkJQtQqApJ2IpvF
        9uBuFTLfqDXfu/rNnt0LZuhlxfY1RKx2iA0iLs0aCau+AIS6dsPRsIjuAq6Q9ncjP0wFfM
        ATDjNQJTLTNF0D3c6eCXbMYnLfKRIGc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-wkZl_EUeNV2pe-mC7of01A-1; Fri, 17 Dec 2021 17:57:11 -0500
X-MC-Unique: wkZl_EUeNV2pe-mC7of01A-1
Received: by mail-qv1-f71.google.com with SMTP id kl17-20020a056214519100b003ba5b03606fso4079916qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 14:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+KxH5v9Eb3o+QR18pfErKc1z+d/J0pC61Cr5tDyvWcc=;
        b=TwVmR7WlD8/B7yaURPkTcYRn2dRjX4eRfuZ+bBAletsatYRyZdS8EKUl+hLCifSahI
         CSTOqW+PHXvQgxVcFotG2FIW0Kl5Qww0ql6+1aRPBU6NnUfaFhd1Ui+9qrRRyYLmrLh8
         nzeusyvXHmeg+DtqaBhEH8p9pOwXRWUCXLfbZjh5h25GRCfZqZ8CiMhifIChkgpFDm8V
         +Os/qMHb9TyeF2i5Rz0Jb/mKyhArDwzkk1bRTF9B+A4UNrWctRKS7cCy0sW7QPF3Tl/t
         3OkWS7r6X7lcKaYIltD2tqaqOnmmzXn4OLet2aZfDLLby7bikQfFxFEeSVVX3bmsUDBY
         0F8Q==
X-Gm-Message-State: AOAM533MOn4eZCk6hY/I+kmNx3srsiWpfKyAHTnbq0hFFNKrxDGPsn8I
        M37GDpQDj4vXBlySWrc8be/rfofr0pOUKDMnvhpn4weZjGKNeQYDDYpDwUtAn3P27ffCI//x4qR
        t2o8adoLeB1SmD+ckiZSGAyqN
X-Received: by 2002:a05:620a:c4f:: with SMTP id u15mr3355595qki.565.1639781830646;
        Fri, 17 Dec 2021 14:57:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXTuyfhYWKF4pQk89sjuYVjRKVvS7QNC4FUSVmFAhRcqT4DCDcP4pbJoonGDrl/wkVMlwLfw==
X-Received: by 2002:a05:620a:c4f:: with SMTP id u15mr3355589qki.565.1639781830438;
        Fri, 17 Dec 2021 14:57:10 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id g12sm8095977qtk.69.2021.12.17.14.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:57:10 -0800 (PST)
Date:   Fri, 17 Dec 2021 14:57:06 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <20211217225706.32ahbyf5yeuzrhre@treble>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-11-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211217220136.2762116-11-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:01:35PM +0000, Fenghua Yu wrote:
> The ENQCMD implicitly accesses the PASID_MSR to fill in the pasid field
> of the descriptor being submitted to an accelerator. But there is no
> precise (and stable across kernel changes) point at which the PASID_MSR
> is updated from the value for one task to the next.
> 
> Kernel code that uses accelerators must always use the ENQCMDS instruction
> which does not access the PASID_MSR.
> 
> Check for use of the ENQCMD instruction in the kernel and warn on its
> usage.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v2:
> - Simplify handling ENQCMD (PeterZ and Josh)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

