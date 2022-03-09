Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866694D2C36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiCIJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiCIJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:36:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6CB16F94E;
        Wed,  9 Mar 2022 01:35:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD5A61633;
        Wed,  9 Mar 2022 09:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90883C340E8;
        Wed,  9 Mar 2022 09:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646818558;
        bh=ap3IEN9WI5D+Wgpg4vty70KterEBnX5GNImrGJ+LBJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gI2/a/YEZeybZGVlUbgVYJv1aPXi1imBbSmLpKrUEcVrKR/vK/SKI3gQJ23HPqWQB
         oQj4dHxxMSqHEAzGvaWeLia0mjnyEd4Czd8UuJlbjtSWsj/dMzPLOo0s6wUSyGHKkh
         mm/libqAZ0/oCdUR2bKYtmzeYpmnbjbDCUwUVIJz+3vrId5DHejdfOl/O9yCYxRuMa
         pIxy/SZUem7wJv2ttBf/fhTLfH01+9qki4C2WXrCsY9DAOW2HxD4Qj9PDTBKzMy/RG
         LKx2LL0Wpdfoln2GXVQp35GxwINMjrLx6h0b7qPr7JuaNjnEz1V/tQHTCT26ARb7mF
         MkFvLoOnLi9Bw==
Date:   Wed, 9 Mar 2022 11:35:14 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2.1 14/30] x86/sgx: Support restricting of enclave
 page permissions
Message-ID: <Yih00gFMaJhLIgxa@iki.fi>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <20220304093524.397485-14-jarkko@kernel.org>
 <YihqwiU3Dr5mvMQx@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YihqwiU3Dr5mvMQx@iki.fi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:52:22AM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 04, 2022 at 11:35:08AM +0200, Jarkko Sakkinen wrote:
> > +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
> > +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
> 
> What if this was replaced with just SGX_IOC_ENCLAVE_RESET_PAGES, which
> would simply do EMODPR with PROT_NONE? The main ingredient of EMODPR is to
> flush out the TLB's, and move a page to pending state, which cannot be done
> from inside the enclave.
> 
> It's there because of microarchitecture constraints, and less so to work as
> a reasonable permission control mechanism (actually it does terrible job on
> that side and only confuses).
> 
> Once you have this magic TLB reset button in place you can just do one
> EACCEPT and EMODPE inside the enclave and you're done.
> 
> This is also kind of atomic in the sense that EACCEPT free's a page with no
> rights so no misuse can happend before EMODPE has tuned EPCM.

I wonder if this type of pattern could be made work out for Graphene:

1. SGX_IOC_ENCLAVE_RESET_PAGES
2. EACCEPT + EMODPE

This kind of delivers EMODP that everyone has been looking for.

BR, Jarkko
