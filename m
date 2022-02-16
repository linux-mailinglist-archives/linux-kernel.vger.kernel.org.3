Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0975C4B8EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiBPRKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:10:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiBPRKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:10:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF32A7957
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:09:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F0661BA6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29ADC004E1;
        Wed, 16 Feb 2022 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645031391;
        bh=mC1Fks7IJyldNKvSocN4kpd3GRB2OB/Ri6oYSh4ZU0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVRG844dJm/53DJkdf9KNjs4psuCCL/81ATTFydbMCDLfGMDsx1k3wlMu5XbshbHk
         zu1DiOg/FsylEsEcy350txBeCl1GuUpj9D/cCwmtCYBsbdLFjOS8W+zu6IN/9hGRTn
         i8HN0DCB4b3NCJ/U694UXog8WnlGu216TW6Oa06JrbpIL743YO4RYUCB0pdFDbeUCT
         dTaBddfXxShB5Z2zx4GmNbVPMQqInEDsbJ8i9nFKGpEprSoypcMLOAHK79zUkpv67G
         vFtyRX1OwxEVRu8TGsEZyEL069GvWBf2KypMsYAhne7yw9hQmGqDNEMI1QOOe6ZDzY
         BqlFMV+CUggKQ==
Date:   Wed, 16 Feb 2022 17:09:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Add read_mostly declaration/definition to irq
 stack ptr
Message-ID: <20220216170947.GB10784@willie-the-truck>
References: <8798a3cc-6e64-6966-d5ad-fadca79d92ba@synaptics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8798a3cc-6e64-6966-d5ad-fadca79d92ba@synaptics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:46:42PM +0800, Jisheng Zhang wrote:
> Add "read-mostly" qualifier to irq_stack_ptr and
> irq_shadow_call_stack_ptr. This is to prevent the false sharing.
> 
> Before the patch, I got below percpu layout with one defconfig:
> ffffffc008723050 <mde_ref_count>:
> ffffffc008723050:       00 00 00 00
> ....
> 
> ffffffc008723054 <kde_ref_count>:
> ffffffc008723054:       00 00 00 00
> ....
> 
> ffffffc008723058 <irq_stack_ptr>:
>         ...
> 
> ffffffc008723060 <nmi_contexts>:
>         ...
> 
> ffffffc008723070 <fpsimd_last_state>:
> 
> As can be seen, the irq_stack_ptr sits with the heavy read/write percpu
> vars such as fpsimd_last_state etc. at the same cacheline.
> 
> After the patch:
> 
> ffffffc008723000 <irq_stack_ptr>:
>         ...
> 
> ffffffc008723008 <cpu_number>:
>         ...
> 
> ffffffc008723010 <arm64_ssbd_callback_required>:
>         ...
> 
> ffffffc008723018 <bp_hardening_data>:
>         ...
> 
> Now, the irq_stack_ptr sits with read mostly percpu vars such as
> cpu_number etc. at the same cacheline.

Were you able to measure any performance difference after this change?

Will
