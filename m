Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1269583250
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiG0SsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbiG0Sru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235FB8AEF7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA596185C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A19C433C1;
        Wed, 27 Jul 2022 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658943898;
        bh=AWPi2RklWEjJYdEzBQpvRo0y/4ESXyMm2zfHiG6ND9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etgrUijw96ihMWnWUPv3FzrcFwxEpRCLr+oOGWV72DLbEwxwtQoDFJM2MeWFySaPz
         VOKAb1tMManT0QS58XVOGXyj9H0HwmLcEWPFE0ZEhzvjaSYj+yuU0h6DIGWD/wdTUY
         QohUfPXgUiTr4YYnUsJ8JZ6f0CDJkba73puBdNfNaYBF3QRpvNbQ6SULjYluTHjVw9
         PCOgvcY43jreB4bOKDQRGIRcGzD0xcub70nrEW6QcXwulyfR8oghe+BEMQs3fZM9rz
         GupPSX/fAsMDZKY6sD2oyk3LG3L7A//Q4t8iqRIM5W+iXv/s8UU2Oo7/u9gXWVVYmJ
         97ORi+2uluY0Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oGl5c-00ATqn-6O;
        Wed, 27 Jul 2022 18:44:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     tabba@google.com, oliver.upton@linux.dev, broonie@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>, mark.rutland@arm.com,
        madvenka@linux.microsoft.com
Cc:     andreyknvl@gmail.com, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, wangkefeng.wang@huawei.com,
        catalin.marinas@arm.com, vincenzo.frascino@arm.com, ast@kernel.org,
        kernel-team@android.com, elver@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        android-mm@google.com
Subject: Re: [PATCH v6 00/17] KVM nVHE Hypervisor stack unwinder
Date:   Wed, 27 Jul 2022 18:44:53 +0100
Message-Id: <165894387426.1300284.3994289980983137161.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
References: <20220726073750.3219117-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tabba@google.com, oliver.upton@linux.dev, broonie@kernel.org, kaleshsingh@google.com, mark.rutland@arm.com, madvenka@linux.microsoft.com, andreyknvl@gmail.com, kvmarm@lists.cs.columbia.edu, will@kernel.org, wangkefeng.wang@huawei.com, catalin.marinas@arm.com, vincenzo.frascino@arm.com, ast@kernel.org, kernel-team@android.com, elver@google.com, mhiramat@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, android-mm@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 00:37:33 -0700, Kalesh Singh wrote:
> This is v6 of nVHE stacktrace support. The series is based on
> arm64 for-next/stacktrace.
> 
> The previous versions were posted at:
> v5: https://lore.kernel.org/r/20220721055728.718573-1-kaleshsingh@google.com/
> v4: https://lore.kernel.org/r/20220715061027.1612149-1-kaleshsingh@google.com/
> v3: https://lore.kernel.org/r/20220607165105.639716-1-kaleshsingh@google.com/
> v2: https://lore.kernel.org/r/20220502191222.4192768-1-kaleshsingh@google.com/
> v1: https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/
> 
> [...]

Applied to next, thanks!

[01/17] arm64: stacktrace: Add shared header for common stack unwinding code
        commit: 6bf212c89c48458d8deef1c973678c62528dab04
[02/17] arm64: stacktrace: Factor out on_accessible_stack_common()
        commit: 15a59f19a015185bff90a68f601caec151dea4b4
[03/17] arm64: stacktrace: Factor out unwind_next_common()
        commit: be63c647fd28d25484257f5f36a008db7d99991d
[04/17] arm64: stacktrace: Handle frame pointer from different address spaces
        commit: 5b1b08619f50422c3e43d1fd7af257595a9e4a67
[05/17] arm64: stacktrace: Factor out common unwind()
        commit: f51e7146740514347d6c5526a2c393e224a19c0d
[06/17] arm64: stacktrace: Add description of stacktrace/common.h
        commit: 051ece6758cc10c2a6f1700ffe86d23fbb0b2553
[07/17] KVM: arm64: On stack overflow switch to hyp overflow_stack
        commit: 548ec3336f323db56260b312c232ab37285f0284
[08/17] KVM: arm64: Stub implementation of non-protected nVHE HYP stack unwinder
        commit: 573e1e8275f7167ddd533c6e4e0f500f8be4d974
[09/17] KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
        commit: 879e5ac7b2e4db05799a905b5a07fc9e5dedf651
[10/17] KVM: arm64: Implement non-protected nVHE hyp stack unwinder
        commit: db129d486ebdf4e3168282236f9d9008b42cac7e
[11/17] KVM: arm64: Introduce hyp_dump_backtrace()
        commit: 314a61dc31845c233e47c53db3fe6f34284034f4
[12/17] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
        commit: 72adac1bd234002a65cef738e0eebfd6c2ce2e30
[13/17] KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
        commit: 6928bcc84bc4bd9a24a1cb1986418c3de76e1d99
[14/17] KVM: arm64: Stub implementation of pKVM HYP stack unwinder
        commit: 25aa73b6db1831527cd4f14bf0ddf8dceadec802
[15/17] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
        commit: 871c5d931417d3c0e1aa32c9e04da1dc74703843
[16/17] KVM: arm64: Implement protected nVHE hyp stack unwinder
        commit: 75e9459e48d4867caf549e388bd4faabe1dbcbd3
[17/17] KVM: arm64: Introduce pkvm_dump_backtrace()
        commit: 3a7e1b55aad45c0cf86bd4e2f212bb9a61905142

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

