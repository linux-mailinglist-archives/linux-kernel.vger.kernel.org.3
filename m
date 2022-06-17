Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C46F54F391
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381325AbiFQIuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381316AbiFQIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:50:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C799D694B0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34FF3B827CC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFD8C3411B;
        Fri, 17 Jun 2022 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655455846;
        bh=c/802ysll8Uki8K7DNXXeYK+6Hshm0ZRzMFKDT/R5y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l34oNkGtiMK10v/6Eb56qZkXkJYA9qFULLpSaVeXUwh77j4GpjR8jNUa1rSyqA6Cs
         j9BhdySQZ6r1wg5g0HnThfGCOsSoA7lm+5/GlsOA6IKEV/bVhJnMjeKV69XHUasWup
         52u5ShSQSjAbQJ8kF1oktqnmI0gmCmAZ9VA+Fbt80XTxNHYdqyAi2blnuObrMOWRRF
         mvazN7SxrJQLe1g7S6+pKVx5XW4qYoi3kzbXbfernlFx0/nVJprWzuSRMOC0z9CdEv
         9bMq8/ek4bi2KSoiEbYSFConEq/8vXB67YSZ9fQGuc978KJGJkitHEgcyrCbzIPuwu
         UAu9QFZK3Le2Q==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o27gi-001FiI-VG;
        Fri, 17 Jun 2022 09:50:45 +0100
MIME-Version: 1.0
Date:   Fri, 17 Jun 2022 09:50:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Prevent kmemleak from accessing pKVM memory
In-Reply-To: <Yqw/PI6jF5HZTvxB@google.com>
References: <20220616161135.3997786-1-qperret@google.com>
 <165545408679.771055.5076080259874437048.b4-ty@kernel.org>
 <Yqw9dou3qgpAKQkZ@kernel.org> <Yqw/PI6jF5HZTvxB@google.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fa3b5bb1caeaaf98b8a754504c3c9be1@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qperret@google.com, rppt@kernel.org, suzuki.poulose@arm.com, alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, james.morse@arm.com, will@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 09:45, Quentin Perret wrote:
> On Friday 17 Jun 2022 at 11:38:14 (+0300), Mike Rapoport wrote:
>> On Fri, Jun 17, 2022 at 09:21:31AM +0100, Marc Zyngier wrote:
>> > On Thu, 16 Jun 2022 16:11:34 +0000, Quentin Perret wrote:
>> > > Commit a7259df76702 ("memblock: make memblock_find_in_range method
>> > > private") changed the API using which memory is reserved for the pKVM
>> > > hypervisor. However, it seems that memblock_phys_alloc() differs
>> > > from the original API in terms of kmemleak semantics -- the old one
>> > > excluded the reserved regions from kmemleak scans when the new one
>> > > doesn't seem to. Unfortunately, when protected KVM is enabled, all
>> > > kernel accesses to pKVM-private memory result in a fatal exception,
>> > > which can now happen because of kmemleak scans:
>> > >
>> > > [...]
>> >
>> > Applied to fixes, thanks!
>> >
>> > [1/1] KVM: arm64: Prevent kmemleak from accessing pKVM memory
>> >       commit: 9e5afa8a537f742bccc2cd91bc0bef4b6483ee98
>> 
>> I'd really like to update the changelog to this:
>> 
>> Commit a7259df76702 ("memblock: make memblock_find_in_range method
>> private") changed the API using which memory is reserved for the pKVM
>> hypervisor. However, memblock_phys_alloc() differs from the original 
>> API in
>> terms of kmemleak semantics -- the old one didn't report the reserved
>> regions to kmemleak while the new one does. Unfortunately, when 
>> protected
>> KVM is enabled, all kernel accesses to pKVM-private memory result in a
>> fatal exception, which can now happen because of kmemleak scans:
>> 
>> $ echo scan > /sys/kernel/debug/kmemleak
>> [   34.991354] kvm [304]: nVHE hyp BUG at: [<ffff800008fa3750>] 
>> __kvm_nvhe_handle_host_mem_abort+0x270/0x290!
>> ...
>> 
>> Fix this by explicitly excluding the hypervisor's memory pool from
>> kmemleak like we already do for the hyp BSS.
> 
> Looks good to me, thanks.

Now updated. Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
