Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA44B7B22
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbiBOXTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:19:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbiBOXTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:19:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63522F8B9A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D016ECE2150
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41ABC340F1;
        Tue, 15 Feb 2022 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967140;
        bh=eWOdfshPGhIlQe48cFCz8Z9EjmRibukkf+zjupjxwcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fo78gjumYQGjuGrujkcwmENjo+6sxhf9KmzRCcOZhqL1y0mxs8Aonxcv8zS8xXqCX
         CyfrJ6EvyeZ+AVzu6wJ2hLqcHgEWn6W+4XexJlndv+YE8m/4nRa0KskN7rBI+8u0j0
         +QLaw7stb6ETWu9beHOTLuSLAf3C6hMwxJxHvVbLgVRT+fcVoXhRrVQ5Cma7+l8yOJ
         xJw74Np7vD/Dv/R5c662E86lV/W4xrKMBv6XusLHLBCkXSc57QGelzGTmbwyZLs1b+
         aOoyvM/72hNAesgwH/LaEVYgAubD51vSInpQnLo5hGtS6e32XW9M33DP91k1MoPSPf
         spC4FKe4pVQTw==
From:   Will Deacon <will@kernel.org>
To:     david@redhat.com, akpm@linux-foundation.org,
        Jianyong Wu <jianyong.wu@arm.com>, anshuman.khandual@arm.com,
        ardb@kernel.org, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>, nd@arm.com,
        justin.he@arm.com, gshan@redhat.com, quic_qiancai@quicinc.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v4] arm64/mm: avoid fixmap race condition when create pud mapping
Date:   Tue, 15 Feb 2022 23:18:30 +0000
Message-Id: <164493953489.1197740.9545575140952933000.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220201114400.56885-1-jianyong.wu@arm.com>
References: <20220201114400.56885-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 19:44:00 +0800, Jianyong Wu wrote:
> The 'fixmap' is a global resource and is used recursively by
> create pud mapping(), leading to a potential race condition in the
> presence of a concurrent call to alloc_init_pud():
> 
> kernel_init thread                          virtio-mem workqueue thread
> ==================                          ===========================
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: avoid fixmap race condition when create pud mapping
      https://git.kernel.org/arm64/c/ee017ee35350

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
