Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7E48F8EF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiAOTCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:02:19 -0500
Received: from meesny.iki.fi ([195.140.195.201]:54886 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbiAOTCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:02:17 -0500
Received: from localhost (91-154-92-187.elisa-laajakaista.fi [91.154.92.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sakkinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 99CE420194;
        Sat, 15 Jan 2022 21:02:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1642273335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6+byRl82CpxyJhOAegiEUplqovfZkizblYVHI0tOzg=;
        b=ZY2jQAehWw9wXRF8Ei1TOYRJOp6eX5CGxir5nYFRa6PV0TUmL2qYGf8BXJukv/QG0tD+Qm
        7uLWKiiDHJJH92KJD81onMkA+2LOU0c6aq1/E5peBRy6oZ2Q1IRN6/e1roVJMgm5le6ejH
        HizmlNKvfqqrhrh0v51yniz1YWb8HW0=
Date:   Sat, 15 Jan 2022 21:02:05 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/sgx: Limit EPC overcommit
Message-ID: <YeMaLTtcx9t0+HGG@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <YeMZJ7gZi8JzTYYd@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeMZJ7gZi8JzTYYd@iki.fi>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1642273335; a=rsa-sha256; cv=none;
        b=vn8j1yk0TnejkZAE3vq4uF6drbUieteXe7QVbYJpfHheCBei5os1TFKevDP0NhWx7KIKTZ
        NtyMrUhVBSoDxW7vbstZf+FzH8+EJAdDATMdKa/JaV9udMS1rmPywAoVg/HRClP44IgB4o
        kIPP+HQIuY2v5FyOKAxT6gXka+yykgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1642273335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6+byRl82CpxyJhOAegiEUplqovfZkizblYVHI0tOzg=;
        b=bZi81rHBY9neTnhty5xoCJ7iA3W7iFmIdT4MYrNqMzCDOpPC43xHsH9xesuNRD3F5638sh
        fwXTsJqbh4QcMBwSNQFjcxe5HhV8ZnoKsOW68RHHAhHJtubMEeclRRNFgBRbNJ+9QzxOWH
        RnKyk6ElTnyoVAT0cHFL2+uHE3ayH2c=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 08:57:44PM +0200, Jarkko Sakkinen wrote:
> On Fri, Jan 07, 2022 at 10:16:15AM -0800, Kristen Carlson Accardi wrote:
> > SGX currently allows EPC pages to be overcommitted. If the system is
> > out of enclave memory, EPC pages are swapped to normal RAM via
> > a per enclave shared memory area. This shared memory is not charged
> > to the enclave or the task mapping it, making it hard to account
> > for using normal methods. Since SGX will allow EPC pages to be
> > overcommitted without limits, enclaves can consume system memory
> > for these backing pages without limits.
> > 
> > In order to prevent this, set a cap on the amount of overcommit SGX
> > allows.  Whenever a backing page is requested by an enclave, track
> > the total amount of shared memory pages used across all enclaves and
> > return an error if the overcommit limit has been reached. This will
> > restrict the total amount of backing pages that all enclaves can
> > consume to a maximum amount, and prevent enclaves from consuming
> > all the system RAM for backing pages.
> > 
> > The overcommit percentage has a value of 150, which limits shared
> > memory page consumption to 1.5x the number of EPC pages in the system.
> > 
> > Changes from v1
> > ----------------
> > * removed module parameter and disable boolean
> > * increased over commit percentage to 150% from 100%
> > 
> > Kristen Carlson Accardi (2):
> >   x86/sgx: Add accounting for tracking overcommit
> >   x86/sgx: account backing pages
> > 
> >  arch/x86/kernel/cpu/sgx/encl.c | 76 ++++++++++++++++++++++++++++++++--
> >  arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
> >  arch/x86/kernel/cpu/sgx/main.c | 52 +++++++++++++++++++++--
> >  arch/x86/kernel/cpu/sgx/sgx.h  |  2 +
> >  4 files changed, 128 insertions(+), 8 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
> 
> I've tested also these. Looking at the feedback, there's
> nothing game changing, so you could add for the next
> version:
> 
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

The test environment was a VM running my desktop [*] and I just
run many instances of kselftest as a test case.

[*] i5-9600KF CPU

/Jarkko
