Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA5560726
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiF2RPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiF2RPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C83CA61
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAA2B61DE8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0932AC341CA;
        Wed, 29 Jun 2022 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656522899;
        bh=nRYAO0YhqCfW4n6wXNQYaEZksNx77Z2cvSAAwv2BTXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmoROso54H2ZVFwQUwvRDiFyIa1hsR2lG/3lAZaePvTzKruFHeRsiGi4UC7PkEO8l
         qWc1TuTWvJNfGt8g2jUYIoiEpgw1IVFqpfuGxCEmq/KihSpGPzrNcam7ATayIKyxmW
         f84Z6R9fLtvGpaBEBiC5vfSbFRpz2dLWFplsUScFoVQLHclhAH0r2DGjW5wk0y5V0C
         9aUICt/P0uNFQcTVjcc5lpqsp1Ao41rJTVA8vpojbxmL/unJ8H/UQaDityIYrRDKh7
         LPIOQxETfTJbjRenZ5zm+rwcV+1EmrEfYCPDrqPdM/NXyS98sXiPnIlRoc+1bN6puO
         vZ9EP/kQpZRvQ==
Date:   Wed, 29 Jun 2022 10:14:57 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/3] x86: fix setup of brk area
Message-ID: <20220629171457.amdsrgaxady55hds@treble>
References: <20220623094608.7294-1-jgross@suse.com>
 <20220623094608.7294-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220623094608.7294-3-jgross@suse.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

It helps to actually Cc the person who broke it ;-)

On Thu, Jun 23, 2022 at 11:46:07AM +0200, Juergen Gross wrote:
> Commit e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
> put the brk area into the .bss..brk section (placed directly behind
> .bss),

Hm? It didn't actually do that.

For individual translation units, it did rename the section from
".brk_reservation" to ".bss..brk".  But then during linking it's still
placed in .brk in vmlinux, just like before.

> causing it not to be cleared initially. As the brk area is used
> to allocate early page tables, these might contain garbage in not
> explicitly written entries.
> 
> This is especially a problem for Xen PV guests, as the hypervisor will
> validate page tables (check for writable page tables and hypervisor
> private bits) before accepting them to be used. There have been reports
> of early crashes of PV guests due to illegal page table contents.
> 
> Fix that by letting clear_bss() clear the brk area, too.

While it does make sense to clear the brk area, I don't understand how
my patch broke this.  How was it getting cleared before?

-- 
Josh
