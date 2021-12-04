Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013E1468824
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLDWyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:54:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59836 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhLDWyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:54:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44230B80DA3;
        Sat,  4 Dec 2021 22:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDBAC341C2;
        Sat,  4 Dec 2021 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638658262;
        bh=hRacCfwsJ2qHEFPaTfcsopqBxQW7DdnpU7OiAarPhIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcBunO3lJeP/1Am7eYz9ZoLA1gP57aloeWuQzUC/ZY4hT59OlbFyhy2/6Y8n/iPqO
         pSISRbWCHALmtW362qqaHWZAOBPkU2IWLnDMpScD3wiUJWRSIzAU0hG9VrTC1c8vc6
         sTTs18ugSARO1GVGAklrgg30hklXd8wCShlBuAzF0YwTaojEJfKLhwm0FssNfoIx6/
         0wPm++yWeyJy7c+t3URy4yj49xHraXuYEZZ9gPIXnokr8R/dwx1vSsv8plMsyj7TZs
         lGzXy3Qey2YrB0s6RbMZq6d+4wsXewykCVbHbIe77B00zP2kbnj1fqEjr6iMhxRXmv
         3pUFIb45gE7hA==
Date:   Sun, 5 Dec 2021 00:50:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <Yavw05Op0PTm3AuX@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What about:

"x86/sgx: Add encl_page->vm_run_prot_bits for dynamic permission changes"

On Wed, Dec 01, 2021 at 11:23:03AM -0800, Reinette Chatre wrote:
> Enclave creators declare their paging permission intent at the time
> the pages are added to the enclave. These paging permissions are
> vetted when pages are added to the enclave and stashed off
> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
> enclave PTEs.
> 
> Current permission support assume that enclave page permissions
> remain static for the lifetime of the enclave. This is about to change
> with the addition of support for SGX2 where the permissions of enclave
> pages belonging to an initialized enclave may be changed during the
> enclave's lifetime.
> 
> Introduce runtime protection bits in preparation for support of

By writing "Introduce runtime protection bits", instead of simply "Add
encl_page->vm_run_prot_bits", the only thing you are adding is obfuscation.

Try to refer to the "exact thing", instead of English rephrasing
whenever possible.

> enclave page permission changes. These bits reflect the active
> permissions of an enclave page and are not to exceed the maximum
> protection bits that passed scrutiny during enclave creation.
> 
> Associate runtime protection bits with each enclave page. Initialize
> the runtime protection bits to the vetted maximum protection bits
> on page creation. Use the runtime protection bits for any access
> checks.

I guess the first sentence in this paragraph is completely redundant
as the first sentence of the previous paragraph tells the exact
same story.

> struct sgx_encl_page hosting this information is maintained for each
> enclave page so the space consumed by the struct is important.
> The existing vm_max_prot_bits is already unsigned long while only using
> three bits. Transition to a bitfield for the two members containing
> protection bits.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

So this commit message left the most important thing unanswered,
or I missed it (which happens quite often): why two fields instead
of one? Why vm_max_port_bits needs to stay constant?

It's something that should be clearly documented.

/Jarkko
