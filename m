Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25846882D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhLDXHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:07:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36232 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhLDXHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:07:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63CD0B80DB7;
        Sat,  4 Dec 2021 23:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942E6C341C0;
        Sat,  4 Dec 2021 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638659014;
        bh=8zJ0Z57csGt4lxw64y4B7XzWNPoYg5bSz9NJFsnFyIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6YgGANzWCPCAnj6Au+6Mv8wP10OgLJiwj87BDajczLhBY0E/9+6xecYq2I7cbrzG
         AVNaJPqtBeusrIaY7+g0zBzbtJJNAU95ZYMNgmaqRC3b0kLKXSBhVAQ1vWpAIWa2Ue
         4xnUkAhAlQpM4fY9Z6w2hsQuvAb8GEecV5n18MejmSoImojAnIkgCmjjw4DrH1a+SO
         L+jsscGLSZhHJsUAmwIPMt7sFxiBD0m84ekYzmQc59te+YPwjb1dnScubEFhkWvR4a
         RW+vWNBKck4Is2HOL6k7fZ319CHgxJVibLQmwY/sZUpUs7ilRV2ohUjrtU8YU7ZyIp
         rUPFDTJuzHd7A==
Date:   Sun, 5 Dec 2021 01:03:30 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/25] x86/sgx: Keep record of SGX page type
Message-ID: <Yavzwhr5Zs50922Q@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <f1393ef80c8d1f1bdd3e34baf60c0286f77a8aa1.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1393ef80c8d1f1bdd3e34baf60c0286f77a8aa1.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:07AM -0800, Reinette Chatre wrote:
> SGX2 functions are not allowed on all page types. For example,
> ENCLS[EMODPR] is only allowed on regular SGX enclave pages and
> ENCLS[EMODPT] is only allowed on TCS and regular pages. If these
> functions are attempted on another type of page the hardware would
> trigger a fault.
> 
> Keep a record of the SGX page type so that there is more
> certainty whether an SGX2 instruction can succeed and faults
> can be treated as real failures.
> 
> The page type is made to be a property of struct sgx_encl_page
> and thus does not cover the VA page type. VA pages are maintained
> in separate structures and thus their type can be determined in
> a different way. The SGX2 instructions being supported do not
> operate on VA pages and this is thus not a scenario needing to
> be covered at this time.
> 
> With the protection bits consuming 16 bits of the unsigned long
> there is room available in the bitfield to include the page type
> information without increasing the space consumed by the struct.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

I think this is needed for any formation of these patches, and
I cannot forsee it done by any other way, so
 
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
