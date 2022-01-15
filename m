Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FC48F8EB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiAOS57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiAOS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:57:58 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3844C061574;
        Sat, 15 Jan 2022 10:57:57 -0800 (PST)
Received: from localhost (91-154-92-187.elisa-laajakaista.fi [91.154.92.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sakkinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id BAA7C1B0001D;
        Sat, 15 Jan 2022 20:57:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1642273073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p01168ji5yuhIdVqODCr5u29e+zbliaN3E2LXFK/epw=;
        b=heWJMZBQdK4Xv9HjWwXI80tS9agIY+3EL/L0YRlAr7gtV7GVKEuyIvc3kJhP1cshXOyJ0e
        FB+Lj/lAOvaPWnTy/oVCRxqcr8xV/a8fhmaThzEosegovWdGmmVOr0P7D3ELYGQyTs/ej+
        l4ihFqBhqEE23VuKFJ1MbuubEPJ5jXivu8NlT6TanBZqI80rfr+nG+jqy2hm/+QwdXzLIT
        wBzfoqgY1yzHxliDy2Uhte7oz2dDRohJVuQ5Sx7olA52Ki5/A4X7Jsvjyy0YlsblsfoQRs
        jtg3JVZPMlhbXBKiBs67mYFp0yikHxl2LV28cQilBHHH6jrJ3hnYH4phJtm97A==
Date:   Sat, 15 Jan 2022 20:57:43 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/sgx: Limit EPC overcommit
Message-ID: <YeMZJ7gZi8JzTYYd@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107181618.6597-1-kristen@linux.intel.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1642273073; a=rsa-sha256;
        cv=none;
        b=Vuddu1Fy9mevGO0yBFjEtaMsffkZF+zOd6/6c6NYLRDt6+Zgv0lmaSrpiYhd4HaSkn7Fvu
        FZCCbFQ3FlJs28Ud8QXECkdReFqxCnVhfTJKO5ltxHtS3CnsSJylkVm2751B2sChiRa5l/
        4bPw+64ytyUzT4WsokyUAHJUyUH8/VcrYnNxukgv4Ao1Ly7oMbnPisNwR4H8nwtmKAroP7
        L4SfBaD19POzGXXnouWQyjxbHNyEJPoEXvaYDl+njS7WKtV5ko+zVBgW+bvLrwvsNByDve
        KpN3XrfDanB5wtFMzzCcG42Lv9oRXzI2XkFic2t2fjK3svE83aukrwPpR1ZngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1642273073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p01168ji5yuhIdVqODCr5u29e+zbliaN3E2LXFK/epw=;
        b=bk8Ea9fHgNbUV+9FOS0z5Rm5qqb3cvQbfUk7+DzYwU94l/o6LbtaID4O6E2ZYSErKRSMf4
        bmOE38f+rQt8tBUWNpGyRSAhtC7eBIA3z9Kj2EW2HDt346BUqcDCC4fCIbOZPB3IvsRiQj
        I2t7nzU0cZAOV1hWzsmh77t5b+klgFI661OjrNnp/nWoiCaO4DU0um2ZEj9g3L8EfWfFCK
        FP3kkEpoGCiwkL2A2k7vZwA1hs6asssIQSDLS5sGVlRjT8PgcRS7HTpIrzoEwSK5+3HdTB
        NzkvZv8ZHGe0QgNV87QkUtalbNun5DcsagwxvRwry3OZMPfD+kkU2tx7rI7Zug==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:16:15AM -0800, Kristen Carlson Accardi wrote:
> SGX currently allows EPC pages to be overcommitted. If the system is
> out of enclave memory, EPC pages are swapped to normal RAM via
> a per enclave shared memory area. This shared memory is not charged
> to the enclave or the task mapping it, making it hard to account
> for using normal methods. Since SGX will allow EPC pages to be
> overcommitted without limits, enclaves can consume system memory
> for these backing pages without limits.
> 
> In order to prevent this, set a cap on the amount of overcommit SGX
> allows.  Whenever a backing page is requested by an enclave, track
> the total amount of shared memory pages used across all enclaves and
> return an error if the overcommit limit has been reached. This will
> restrict the total amount of backing pages that all enclaves can
> consume to a maximum amount, and prevent enclaves from consuming
> all the system RAM for backing pages.
> 
> The overcommit percentage has a value of 150, which limits shared
> memory page consumption to 1.5x the number of EPC pages in the system.
> 
> Changes from v1
> ----------------
> * removed module parameter and disable boolean
> * increased over commit percentage to 150% from 100%
> 
> Kristen Carlson Accardi (2):
>   x86/sgx: Add accounting for tracking overcommit
>   x86/sgx: account backing pages
> 
>  arch/x86/kernel/cpu/sgx/encl.c | 76 ++++++++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
>  arch/x86/kernel/cpu/sgx/main.c | 52 +++++++++++++++++++++--
>  arch/x86/kernel/cpu/sgx/sgx.h  |  2 +
>  4 files changed, 128 insertions(+), 8 deletions(-)
> 
> -- 
> 2.20.1
> 

I've tested also these. Looking at the feedback, there's
nothing game changing, so you could add for the next
version:

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
