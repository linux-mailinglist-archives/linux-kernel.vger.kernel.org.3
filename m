Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481E04CE1FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiCECBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiCECBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C253730;
        Fri,  4 Mar 2022 18:00:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B69761F69;
        Sat,  5 Mar 2022 02:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07948C340E9;
        Sat,  5 Mar 2022 02:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646445642;
        bh=teMw15QNNKxcL9BNgZK2e3zh41BE0uafMgfWgTe4aqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nl6Srsn9BEOlgTsNzAAhTFWkm5wMr50b8QEK3Wo27w+Ls1xIMwxSYRZcHUEaTT0CW
         cgL8FaNx/NOMw1tP5tgHZHUzpwEyYmrVSUFb8fFA0sdgjCf5ef3waB18bfwBlcwOB2
         BjCLPcV+lT2tXM9svFQ8fZoIknGc26HnrLhJUVmwbJlSafC/hldriiumYM+wJuXzNn
         qaQW2I5nGNLNUSFLUAfrEpnnYTs50s8uvRsm6NvC9DLBL2YN2agPQDeobhdiT03YM5
         YeoER4A0Ea48ui4V4eNGil/zzMtUoBYVb9rzTYh6KM6KcZ+eDzJxFDaU6zPWsp2/Ii
         nS3MDvvMblxAA==
Date:   Sat, 5 Mar 2022 03:59:56 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/sgx: Do not limit EAUG'd pages by
 pre-initialization policy
Message-ID: <YiLEHBlXAz+sUheO@kernel.org>
References: <20220304033918.361495-1-jarkko@kernel.org>
 <684930a2-a247-7d5e-90e8-6e80db618c4c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684930a2-a247-7d5e-90e8-6e80db618c4c@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:09:36AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/3/2022 7:39 PM, Jarkko Sakkinen wrote:
> > Pre-initialization policy is meant for EADD'd pages because they are
> > part of the enclave identity. It's a good practice to not let touch the
> > permissions after initialization, and does provide guarantees to e.g.
> > LSM's about the enclave.
> 
> I disagree. There are scenarios where it is indeed good practice to
> modify the permissions after initialization.  For example, pages that
> may be used for relocatable code can start with RWX permissions but once
> the pages have been populated with the code they should be able to restrict
> permissions to RX only. It is not good practice to require RWX permission
> over their entire lifetime. Ideally pages should only have the lowest
> permissions possible. 

The only permissions kernel has real control is PTE permissions when
the enclave has been initialized.

You are introducing an artificial limitation with vm_run_prot_bits
that makes e.g. EMODPE more costly for no good reason, and in-kernel
variable has nothing to do with the permissions. They are located
in EPCM.

> Supporting the modification of permissions after initialization enables
> the security conscious enclave owner to support the security
> principle of least privilege.

1. Kernel has the control of PTE permissions.
2. Enclave has the control of EPCM permissions.

vm_run_prot_bits does not help making anything more secure.

BR, Jarkko
