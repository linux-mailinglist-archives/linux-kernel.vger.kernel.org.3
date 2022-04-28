Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9DA513C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350872AbiD1T7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiD1T7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:59:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6CBF531
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A64D3B82FD9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469DBC385AD;
        Thu, 28 Apr 2022 19:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651175756;
        bh=vRnZSRIcTqcHKCeWjmxMZBxVcLsxLI+m8lZ+XQEEza8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUaqFQwLZ+kPqathikKDuZJIaOcX/OYkWvMud/2Qz5gdLLidFxSkYPPZxr1PSU9Xs
         c3HxamY4IAekJMXwYztltninPRKr1Due435Q+1gTAeqOEGO35Dvd8KHySUb/wqeKiD
         IK54zoxiEFBA9GXosZaccafRQzweNNc3wtrm4JqcdipGg4AyDQmVq3UkOpae/5hyND
         QigfMuiwx+KbhsPWuT9bzpXHYrSSdSxSAGAZxkJn+KpUJ+Gt2HJud1ECcPhaXGhGY+
         ksgSWmA1pXiuFh9aEjlAyRxzBukftfVNPEVn2Wsu4ON/nt/IudxV9rB3v+1RA9TDEC
         FAfJpvgTgzSvA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nkAEz-007l9y-Qp; Thu, 28 Apr 2022 20:55:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, tabba@google.com,
        Masahiro Yamada <masahiroy@kernel.org>, surenb@google.com,
        kvmarm@lists.cs.columbia.edu,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, will@kernel.org,
        qperret@google.com, linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Changbin Du <changbin.du@intel.com>, kernel-team@android.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v8 0/6] KVM: arm64: Hypervisor stack enhancements
Date:   Thu, 28 Apr 2022 20:55:50 +0100
Message-Id: <165117574186.3115452.6818682378273681624.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420214317.3303360-1-kaleshsingh@google.com>
References: <20220420214317.3303360-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kaleshsingh@google.com, mark.rutland@arm.com, james.morse@arm.com, tabba@google.com, masahiroy@kernel.org, surenb@google.com, kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, ardb@kernel.org, will@kernel.org, qperret@google.com, linux-kernel@vger.kernel.org, alexandru.elisei@arm.com, yuzenghui@huawei.com, changbin.du@intel.com, kernel-team@android.com, nathan@kernel.org
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

On Wed, 20 Apr 2022 14:42:51 -0700, Kalesh Singh wrote:
> This is v8 of the nVHE hypervisor stack enhancements. This version is based
> on 5.18-rc3.
> 
> Previous versions can be found at:
> v7: https://lore.kernel.org/r/20220408200349.1529080-1-kaleshsingh@google.com/
> v6: https://lore.kernel.org/r/20220314200148.2695206-1-kaleshsingh@google.com/
> v5: https://lore.kernel.org/r/20220307184935.1704614-1-kaleshsingh@google.com/
> v4: https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/
> v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
> v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
> v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/
> 
> [...]

Applied to next, thanks!

[1/6] KVM: arm64: Introduce hyp_alloc_private_va_range()
      commit: 92abe0f81e1385afd8f1dc66206b5be9a514899b
[2/6] KVM: arm64: Introduce pkvm_alloc_private_va_range()
      commit: f922c13e778d6d5343d4576be785a8204c595113
[3/6] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
      commit: ce3354318a57875dc59f4bb841662e95bfba03db
[4/6] KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack
      commit: 1a919b17ef012ca0572bae759c27e5ea02bfb47f
[5/6] KVM: arm64: Detect and handle hypervisor stack overflows
      commit: 66de19fad9ef47c5376a99bb2b00661f1c788a94
[6/6] KVM: arm64: Symbolize the nVHE HYP addresses
      commit: 6ccf9cb557bd32073b0d68baed97f1bd8a40ff1d

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


