Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C04D2AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiCIIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiCIIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:54:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98624BC3;
        Wed,  9 Mar 2022 00:53:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59E61B81EAB;
        Wed,  9 Mar 2022 08:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A855C340E8;
        Wed,  9 Mar 2022 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646815982;
        bh=wpEIW3SwPpEISRwjNCu5yxdFfn1cnwyk3HFiMUGaj9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elGmIHCl6AlCPZYydvwXmo45L0wIvPpHHIWHBojLETnoaZ9uFe5Wxh3pT8miC8a+r
         yswjkGA+w51Dr+kUhpwu6VTRwJZacWx8V3BQGbsaNqA26SBhYe9lDp1ls32Kfd/Lp5
         jGTWFEAu/FvuSu9hfBYGVWoNOJwRCoDnxifFeu7S73qwh1QryU8ufIaZK8OnITOa76
         oT9pp2g4XiHlsoBisPlVI1KVm/Wnnx22aQfNfg1J7OM/6XTI8kOCOADhgdwPk0Pc7U
         /f9TNyBjO1PvSmBgG+BQrAHQAuAPdW5RmS0bHME9yxL4t8Ms6qQS4VMAi/kehdvW00
         nlvpVY2zdakzQ==
Date:   Wed, 9 Mar 2022 10:52:18 +0200
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
Message-ID: <YihqwiU3Dr5mvMQx@iki.fi>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <20220304093524.397485-14-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304093524.397485-14-jarkko@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:35:08AM +0200, Jarkko Sakkinen wrote:
> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
> +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)

What if this was replaced with just SGX_IOC_ENCLAVE_RESET_PAGES, which
would simply do EMODPR with PROT_NONE? The main ingredient of EMODPR is to
flush out the TLB's, and move a page to pending state, which cannot be done
from inside the enclave.

It's there because of microarchitecture constraints, and less so to work as
a reasonable permission control mechanism (actually it does terrible job on
that side and only confuses).

Once you have this magic TLB reset button in place you can just do one
EACCEPT and EMODPE inside the enclave and you're done.

This is also kind of atomic in the sense that EACCEPT free's a page with no
rights so no misuse can happend before EMODPE has tuned EPCM.

BR, Jarkko
