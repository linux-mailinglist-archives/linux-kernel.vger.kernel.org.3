Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C99468811
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhLDW3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhLDW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:29:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D3C061751;
        Sat,  4 Dec 2021 14:26:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C535B80CF5;
        Sat,  4 Dec 2021 22:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51705C341C0;
        Sat,  4 Dec 2021 22:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638656759;
        bh=IRefYL7dKGvsQRLYIdYZwVhki+f45/Sooo3YLAFOfOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2eSF/MsexuL/WZDGRxYRGU7UQlPgsPyQOboq7zgQccSZM7toBzcAQIpmrvve4ufO
         WxhLlncrt/SrQCowTitiTafQJZibWw+H85YN76tRwm7A/FluLbpGikNrbyDer3TbiM
         wxivUhu/aJCd2XLw9CA0PeeH/Dom7YJxKNOsgDELmylgtwN012ZMX5xL2LW0qSO2M4
         F8ZfveqSG0D/lBDK48cE5A10rxZNE938LvuGHpy5YyXMEjqbGGqFvh+WPQjeqVP0wW
         ugR7CX7ojKVQ63C1LGdslb6a7nCe/M3UDCrOdWOft48OYq3b0abFmCEIZDgI7i5dNh
         z/nXxZ88mwuPQ==
Date:   Sun, 5 Dec 2021 00:25:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/25] x86/sgx: Support VMA permissions exceeding enclave
 permissions
Message-ID: <Yavq83gZzvkVaDqq@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <7e622156315c9c22c3ef84a7c0aeb01b5c001ff9.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e622156315c9c22c3ef84a7c0aeb01b5c001ff9.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:01AM -0800, Reinette Chatre wrote:
> === Summary ===
> 
> An SGX VMA can only be created if its permissions are the same or
> weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
> creation this rule continues to be enforced by the page fault handler.
> 
> With SGX2 the EPCM permissions of a page can change after VMA
> creation resulting in the VMA exceeding the EPCM permissions and the
> page fault handler incorrectly blocking access.
> 
> Enable the VMA's pages to remain accessible while ensuring that
> the page table entries are installed to match the EPCM permissions
> without exceeding the VMA perms issions.

I don't understand what the short summary means in English, and the
commit message is way too bloated to make any conclusions. It really
needs a rewrite.

These were the questions I could not find answer for:

1. Why it would be by any means safe to remove a permission check?
2. Why not re-issuing mmap()'s is unfeasible? I.e. close existing
   VMA's and mmap() new ones.

/Jarkko
