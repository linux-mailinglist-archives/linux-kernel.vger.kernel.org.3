Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF44AF8B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiBIRsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiBIRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:48:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C23CC05CB86
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:48:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 111CAB8235A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253B8C340E7;
        Wed,  9 Feb 2022 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644428884;
        bh=bpT3sFMSFETjSP2Uvo1MS9Tcu2WoLqbpVCyvJuiqgrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+O3331ajEY5sc8sm0FVWfEU16lYfcmYbeIsGY8+EZoR769V1RsSHbgK4UaIf6Jg0
         L6Qky+61iosP/oVMkg3SA+j1qF2XRYrlZrCDyGG75N/HwSWqy0bBM5bLGbuMBLWHJn
         a3bosujBVq6qRiqBqF/8hxz5TWv6yFsNLGOcDoFdJuyRPGurD3NG7dcyw9rrSfXbar
         4rEkCTWW5ZjbXNPMAp7ieUNr0VvkAbHmBecG5RFu/r0Tqd7CTNBGo/HrWIGogBvv9V
         oPv4u+vjyn9zv0hPYdSqcpyVMEjPCPRlBbMKnWXBlcQsvs/kr7PZGlpX8EHTNwYy4r
         5g1KHjlfc33RA==
Date:   Wed, 9 Feb 2022 18:48:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 5/7] sched/preempt: add PREEMPT_DYNAMIC using static
 keys
Message-ID: <20220209174801.GA547263@lothringen>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209153535.818830-6-mark.rutland@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:35:33PM +0000, Mark Rutland wrote:
> +config HAVE_PREEMPT_DYNAMIC_KEY
> +	bool
> +	depends on JUMP_LABEL

This should probably be:

     depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
     select JUMP_LABEL

Otherwise you may run into trouble if CONFIG_JUMP_LABEL is initially n.

Thanks.
