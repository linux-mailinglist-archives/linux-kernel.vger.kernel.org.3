Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F42D496E48
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 00:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiAVX1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 18:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiAVX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 18:27:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A8C06173B;
        Sat, 22 Jan 2022 15:27:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C007AB80927;
        Sat, 22 Jan 2022 23:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E778CC004E1;
        Sat, 22 Jan 2022 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642894045;
        bh=M+MQhp+HSCK78FPXyMCdwnIZZqwcnoAsYpMjBJfr0qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=himcJttT2YJlLoxsSLkRu071kxDcSQP61Wg45eCD3ZoSVyjLVJSTNaqQ4c8TiKuiJ
         EDnA6WU7mUD7tbbtyxepsa+yUEvb/EUanXTJ0TcwACV15lO8EYAO1HRnXT4oPeLMRP
         K4cKH+N5UEniK8qPzmRJF4AW9P6UEx0Q/iNUqxCAqydMO35VGoCaBlqraHWgxVW6KT
         5vXQj+SKReEdL25PinipTt0xFwqY85znKJmbMO9n+4sMmHcfwczWO2k6J/psgTIvQY
         IWohdEozkVQIVCtu1dX6YvOqO/cLvEjOwsZ0u6Xtiy/xZ7jDNcVyUiSIlGT8B9Su+I
         mBNy2S3psb1HA==
Date:   Sun, 23 Jan 2022 01:27:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org,
        mingo@redhat.com, linux-sgx@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] x86/sgx: Add poison handling to reclaimer
Message-ID: <YeySy2lGjEbNbK1G@iki.fi>
References: <be5af586f667c7bcb8ef01286ce75675de5d100f.1642630582.git.reinette.chatre@intel.com>
 <3bfe66204ee84a0bbccaf7cd20af0d8300fb9f26.camel@kernel.org>
 <8ac3fc3e-9d90-48cf-d84e-40f9cbddd9ac@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ac3fc3e-9d90-48cf-d84e-40f9cbddd9ac@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 10:20:01AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 1/20/2022 5:09 AM, Jarkko Sakkinen wrote:
> > On Wed, 2022-01-19 at 14:23 -0800, Reinette Chatre wrote:
> >> The SGX reclaimer code lacks page poison handling in its main
> >> free path. This can lead to avoidable machine checks if a
> >> poisoned page is freed and reallocated instead of being
> >> isolated.
> >>
> >> A troublesome scenario is:
> >>  1. Machine check (#MC) occurs (asynchronous, !MF_ACTION_REQUIRED)
> >>  2. arch_memory_failure() is eventually called
> >>  3. (SGX) page->poison set to 1
> >>  4. Page is reclaimed
> >>  5. Page added to normal free lists by sgx_reclaim_pages()
> >>     ^ This is the bug (poison pages should be isolated on the
> >>     sgx_poison_page_list instead)
> >>  6. Page is reallocated by some innocent enclave, a second
> >> (synchronous)
> >>     in-kernel #MC is induced, probably during EADD instruction.
> >>     ^ This is the fallout from the bug
> >>
> >> (6) is unfortunate and can be avoided by replacing the open coded
> >> enclave page freeing code in the reclaimer with sgx_free_epc_page()
> >> to obtain support for poison page handling that includes placing the
> >> poisoned page on the correct list.
> >>
> >> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark
> >> free pages")
> >> Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and
> >> free pages")
> > 
> > Same comment as for the first version: remove the first fixes tag.
> > 
> 
> For completeness I'll duplicate my response also:
> 
> The commit you refer to, commit d6d261bded8a ("x86/sgx: Add new
> sgx_epc_page flag bit to mark free pages", introduced a new page flag bit
> (SGX_EPC_PAGE_IS_FREE) that should be set when an EPC page is freed. The
> commit also sets the bit in sgx_free_epc_page() when an EPC page is freed.
> The commit should also have set that bit when the EPC page is freed in the
> reclaimer, which contains an open coded version of sgx_free_epc_page(),
> but it did not. This fix adds the snippet that was omitted from that
> commit.
> 
> Reinette

Let me check. Yes, I can see it in lore, but somehow it has slipped out
of my inbox. My apologies.

The change would make sense even as a clean up (no reason to have open
coded of sgx_free_epc_page(), let alone this regression:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
