Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D524ADFC9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384353AbiBHRhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384340AbiBHRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:37:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551DCC06174F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:37:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E55CF617BB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585C6C004E1;
        Tue,  8 Feb 2022 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644341850;
        bh=t26HgygNCh8gCfuTN/ojA3LnBOvxFUkG2+R14a7qPUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDXHH6KXySyqGenuzjikTOkmMlmgn61tcGHp65CJstK7pekDYRNyzdPbsWcUdRHMa
         be9t0aqXdDBJZb2jh3M2ctzvjGKPhT2+U8miu88OGgesRiFS9qXr3dc9MBm6tagmwz
         vOEQKiTzfNU/5ARKxOpFxgcWjZ7pTKxkjlDZxqjKohjn1KxVvI9YexxZfQo0TFibwA
         2W1FOUJIJrluOsvh9LjXLg79eDMJ/gQF0HttM5iJCclCaGPPEvvIuxcp0nd2NYkoIP
         JaWnyT/RDPoiM/SXeYzlWDGxq1lDtrtgq5PPZG7Hy+jHEZijyvDHudQ9opSnqKHdZW
         NO2nOr+ZV8syw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHUQi-006Ksl-E4; Tue, 08 Feb 2022 17:37:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     will@kernel.org, jonathan.cameron@huawei.com,
        Alexandru.Elisei@arm.com, catalin.marinas@arm.com,
        linuxarm@huawei.com, jean-philippe@linaro.org, qperret@google.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        james.morse@arm.com
Subject: Re: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
Date:   Tue,  8 Feb 2022 17:37:27 +0000
Message-Id: <164434147328.3931943.1270605694385749340.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com, will@kernel.org, jonathan.cameron@huawei.com, Alexandru.Elisei@arm.com, catalin.marinas@arm.com, linuxarm@huawei.com, jean-philippe@linaro.org, qperret@google.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, james.morse@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 12:18:40 +0000, Shameer Kolothum wrote:
> Changes from v3:
> - Main change is in patch #4, where the VMID is now set to an
>   invalid one on vCPU schedule out. Introduced an
>   INVALID_ACTIVE_VMID which is basically a VMID 0 with generation 1.
>   Since the basic allocator algorithm reserves vmid #0, it is never
>   used as an active VMID. This (hopefully) will fix the issue of
>   unnecessarily reserving VMID space with active_vmids when those
>   VMs are no longer active[0] and at the same time address the
>   problem noted in v3 wherein everything ends up in slow-path[1].
> 
> [...]

Applied to next, thanks!

[1/4] KVM: arm64: Introduce a new VMID allocator for KVM
      commit: 417838392f2e657ee25cc30e373ff4c35a0faa90
[2/4] KVM: arm64: Make VMID bits accessible outside of allocator
      commit: f8051e960922a9de8e42159103d5d9c697ef17ec
[3/4] KVM: arm64: Align the VMID allocation with the arm64 ASID
      commit: 3248136b3637e1671e4fa46e32e2122f9ec4bc3d
[4/4] KVM: arm64: Make active_vmids invalid on vCPU schedule out
      commit: 100b4f092f878dc379f1fcef9ce567c25dee3473

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


