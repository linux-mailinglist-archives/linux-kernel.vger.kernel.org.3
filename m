Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE346882E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhLDXMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:12:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35300 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhLDXMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:12:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B956D60F4B;
        Sat,  4 Dec 2021 23:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2331CC341C2;
        Sat,  4 Dec 2021 23:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638659332;
        bh=+Y/tn8ciLuBAi9Kv6hz9J4LjiDSmFsdd83l+yA1RICw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9LWY6HiWyA/RQkNCnOPqKbQ19EkiGiLBCI0WFwzaHvZXSVGdTs77XBNbQT4Z31qL
         i8aCWENsAK79QCbTrB8suvH9jI/wGXbcMu2K5Gty+qWpiCl41xX46BF5C8l7Q+NfRB
         xGnQeIK3a2iCVxVEajVn6pZLb8k3851vZU3+wxqMqvUXLiHT3/yjYLQbj4ZKx/ai2f
         PRjsjcWeQ8dEeK/3qu5KYRwydD2G3jW08eqGTjxTNQVIQcjb1mk2aeob5RGE6BM12l
         H3+N/bYRvWuTB/Y3J+Zz1UdmOsGZpoB64pu6ZRFYvXV0Ab8DxcbLW/r8VfPxAFXXPM
         WwP/Q/Dc9onDg==
Date:   Sun, 5 Dec 2021 01:08:47 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
Message-ID: <Yav0/3jeJsuT3yEq@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:08AM -0800, Reinette Chatre wrote:
> In the initial (SGX1) version of SGX, pages in an enclave need to be
> created with permissions that support all usages of the pages, from the
> time the enclave is initialized until it is unloaded. For example,
> pages used by a JIT compiler or when code needs to otherwise be
> relocated need to always have RWX permissions.
> 
> SGX2 includes two functions that can be used to modify the enclave page
> permissions of regular enclave pages within an initialized enclave.
> ENCLS[EMODPR] is run from the OS and used to restrict enclave page
> permissions while ENCLU[EMODPE] is run from within the enclave to
> extend enclave page permissions.
> 
> Enclave page permission changes need to be approached with care and
> for this reason this initial support is to allow enclave page
> permission changes _only_ if the new permissions are the same or
> more restrictive that the permissions originally vetted at the time the
> pages were added to the enclave. Support for extending enclave page
> permissions beyond what was originally vetted is deferred.

This paragraph is out-of-scope for a commit message. You could have
this in the cover letter but not here. I would just remove it.

> Whether enclave page permissions are restricted or extended it
> is necessary to ensure that the page table entries and enclave page
> permissions are in sync. Introduce a new ioctl, SGX_IOC_PAGE_MODP, to

SGX_IOC_PAGE_MODP does not match the naming convetion of these:

* SGX_IOC_ENCLAVE_CREATE
* SGX_IOC_ENCLAVE_ADD_PAGES
* SGX_IOC_ENCLAVE_INIT

A better name would be SGX_IOC_ENCLAVE_MOD_PROTECTIONS. It doesn't
do harm to be a more verbose.

/Jarkko
