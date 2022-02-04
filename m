Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC974A9F64
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377685AbiBDSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:44:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58742 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbiBDSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:44:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21CE261B9A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 18:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194A7C004E1;
        Fri,  4 Feb 2022 18:44:14 +0000 (UTC)
Date:   Fri, 4 Feb 2022 18:44:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     will@kernel.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, david@redhat.com, ardb@kernel.org,
        quic_qiancai@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gshan@redhat.com,
        justin.he@arm.com, nd@arm.com
Subject: Re: [PATCH] [PATCH v4] arm64/mm: avoid fixmap race condition when
 create pud mapping
Message-ID: <Yf1z+54GEtF6yxvX@arm.com>
References: <20220201114400.56885-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201114400.56885-1-jianyong.wu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 07:44:00PM +0800, Jianyong Wu wrote:
> The 'fixmap' is a global resource and is used recursively by
> create pud mapping(), leading to a potential race condition in the
> presence of a concurrent call to alloc_init_pud():
> 
> kernel_init thread                          virtio-mem workqueue thread
> ==================                          ===========================
> 
>   alloc_init_pud(...)                       alloc_init_pud(...)
>   pudp = pud_set_fixmap_offset(...)         pudp = pud_set_fixmap_offset(...)
>   READ_ONCE(*pudp)
>   pud_clear_fixmap(...)
>                                             READ_ONCE(*pudp) // CRASH!
> 
> As kernel may sleep during creating pud mapping, introduce a mutex lock to
> serialise use of the fixmap entries by alloc_init_pud(). However, there is
> no need for locking in early boot stage and it doesn't work well with
> KASLR enabled when early boot. So, enable lock when system_state doesn't
> equal to "SYSTEM_BOOTING".
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

This looks fine to me but I'd rather leave it in -next for a bit given
that we attempted to fix it a couple of times and got it wrong.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
