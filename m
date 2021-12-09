Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649DE46F70B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhLIWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhLIWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:52:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF6C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:49:05 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b13so5015994plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5fONBaGbybKzue2XLxxX2YbOEZ4qd2Ct4y/vd2xLsnE=;
        b=InhMOjllI4DbnszQLY3xVQ63doFnaeoe0Q/+sKFoJb6vsdHj2GcIhSFj6g05tFu/js
         CGAyzFz9fXv6NxqgGFDG+M3Ql+LmiUZ6jCgc0+6htVkFZAs/teRW+U0AGBPP7/ZvMStU
         Q6xE1KdLmHcyr5umpNYjBsHuuWuZMeua6B9t7HfBwfq9QmPeVKeo3GxKZYzdyzO2PoDV
         S8iF/xz7XXCGwLbe6lQ1OEx7KzeAdDyDrLHv2bq4ym48nw0uAYJoDf9TYaTKde6dSFe2
         Z0mtunH5c/9ngALvatt79/Sm9dk4yIFXqMyPaIJDfFYaewLnP4H6q9mCtF+KPsqhV9tV
         qOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fONBaGbybKzue2XLxxX2YbOEZ4qd2Ct4y/vd2xLsnE=;
        b=EV45C2P+U7y9Y9mTlG+3mNJrTOdZ242n2bGWug239lKFbXtsWH56tCzoyPv2x38772
         VIg/yzWpQsxnikkaJT58D3X44AGBNg+7S4jdByvuo8Pa9kHbt+KqfCZfwWZPGlkzpv+5
         3ASI+7HXSNqueBtT2f9w4up2OjokD4ka7aMoJlBralhg5Bae881zzkGMBBQbQw2oTlEf
         0eeVj3VsYq3i7spgwn6pFTzklal1Bg4urAqULXfLhU6+xmho5ROWqFs74mdtIsAWIDsM
         rHMWFZGji6nbywYdY+fwuROPrsUTTVSgaNIq3tsFJaxPaI6j7scQIsTr7mluJrIWjsnc
         EAGA==
X-Gm-Message-State: AOAM531BG15GesrHB7Bvb0/+4jdmFiD/FbgQ15mrqUKAV8UTXgk9es88
        EOF8hjnW0F6TVPhLuiziOH/dUQ==
X-Google-Smtp-Source: ABdhPJwKOBdQgmR0CbWd5XTq4kCFuXtH1gjwpkBUNWr7EWTF2jPt74NBwDwk8HZtKlquvjizNA1qyQ==
X-Received: by 2002:a17:90a:3045:: with SMTP id q5mr19144057pjl.58.1639090145183;
        Thu, 09 Dec 2021 14:49:05 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z2sm721429pfh.188.2021.12.09.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:49:04 -0800 (PST)
Date:   Thu, 9 Dec 2021 22:49:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com,
        joao.m.martins@oracle.com, stable@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3] selftests: KVM: avoid failures due to reserved
 HyperTransport region
Message-ID: <YbKH3aMQ9R+fgFFG@google.com>
References: <20211209223040.304355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209223040.304355-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021, Paolo Bonzini wrote:
> AMD proceessors define an address range that is reserved by HyperTransport
> and causes a failure if used for guest physical addresses.  Avoid
> selftests failures by reserving those guest physical addresses; the
> rules are:
> 
> - On parts with <40 bits, its fully hidden from software.
> 
> - Before Fam17h, it was always 12G just below 1T, even if there was more
> RAM above this location.  In this case we just not use any RAM above 1T.
> 
> - On Fam17h and later, it is variable based on SME, and is either just
> below 2^48 (no encryption) or 2^43 (encryption).
> 
> Fixes: ef4c9f4f6546 ("KVM: selftests: Fix 32-bit truncation of vm_get_max_gfn()")
> Cc: stable@vger.kernel.org
> Cc: David Matlack <dmatlack@google.com>
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20210805105423.412878-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com>

> +	/*
> +	 * Otherwise it's at the top of the physical address
> +	 * space, possibly reduced due to SME by bits 11:6 of
> +	 * CPUID[0x8000001f].EBX.  Use the old conservative
> +	 * value if MAXPHYADDR is not enumerated.

It'd be nice to run these out to 80 chars when you apply.
