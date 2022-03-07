Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775FB4D03E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiCGQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiCGQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:18:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5465C2;
        Mon,  7 Mar 2022 08:17:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9A260C53;
        Mon,  7 Mar 2022 16:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9DDC340E9;
        Mon,  7 Mar 2022 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646669860;
        bh=Ow0qlJFv8Ai59R6SHq7SYcAd/WZ7HKl8y68xRyfOxi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuKoSqjhMqktUxl46K8ouMyuOIiXymZ2HjoZbPuOghcZie5K3+EVDsY3WOmi5DFQJ
         2kSKhUsaVelRDLZRnVg7WF8c7nHebO9+ZThCKAFWorgAPUiIfF+CD1demP0pR7ti+y
         xFP3jtJL4kaufTDt12aTMdlYxuA9SF6bXNpbLwXWk7tjSgi0nMa1P/DK7bCQB851ZU
         Cc4AXxEmFN3o8UA9q/HKTJB5MchFo4iRbXEejhaBFq/7xrOBnpzaKT/lDUok9xsbZ7
         5g87SlzJkSDEAAzbYvFHH2kRCUT8iHg3tOCV/Pqb1FCFcV66hPW9+/fhGou/9nudSR
         W9dA2Vo/K9FFA==
Date:   Mon, 7 Mar 2022 18:16:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 19/32] x86/sgx: Support adding of pages to an
 initialized enclave
Message-ID: <YiYv+2YRiavU3KBN@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <fcbde9c3e67289eaff9cd8b34989919629fe823c.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbde9c3e67289eaff9cd8b34989919629fe823c.1644274683.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:45:41PM -0800, Reinette Chatre wrote:
> +	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
> +	if (!encl_page)
> +		return VM_FAULT_OOM;
> +
> +	encl_page->desc = addr;
> +	encl_page->encl = encl;
> +
> +	/*
> +	 * Adding a regular page that is architecturally allowed to only
> +	 * be created with RW permissions.
> +	 * TBD: Interface with user space policy to support max permissions
> +	 * of RWX.
> +	 */
> +	prot = PROT_READ | PROT_WRITE;
> +	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> +	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;

You should use sgx_encl_page_alloc() here and not reinvent wheel.

I wrote a patch that exports it:

https://lore.kernel.org/linux-sgx/20220306053211.135762-3-jarkko@kernel.org/T/#u

BR, Jarkko
