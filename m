Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636E856825A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiGFJBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiGFJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:01:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38CD2B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A02D61A0C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1BAC3411C;
        Wed,  6 Jul 2022 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657098065;
        bh=O5vfaJOmY630S2iHMOlIuDMP+z2m4nLFH7uCskj1on4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzA8UfW/I+II685vuTyCAKfooW2Cq099Oh1HZOkqOQtkLW5tIQNnLHzw9Xy+z1S4A
         nEDOXvzmB4BcQBa3PNv6R7C/jUK7LnT5SvnhQMwHlLmq1A+IFgupp1qOdk1rc99mPu
         bekuL/Qsqg0lGPbKd2oRufOtJfOfaqeQAor6WXg6qwd8/YunGN+B10LuDcI+0+hn7J
         XkMsgBeI6gN5RRiQGpdN3vZVCDL/EZVxMPWhcoEbVFKDiTEz6h7M2TdT6WHFP9jvO4
         Y5LewcW69v7JmWmEl8lDvsD7ltOSnTtol7pTtsjR3TI8UdqUxIKpzQ+2/uTdUyp0V8
         Xw4XxwiSjVz1g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o90u6-005Zti-TJ;
        Wed, 06 Jul 2022 10:01:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Don't return from void function
Date:   Wed,  6 Jul 2022 10:00:58 +0100
Message-Id: <165709805020.885966.4815879973915586287.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705142310.3847918-1-qperret@google.com>
References: <20220705142310.3847918-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, will@kernel.org, alexandru.elisei@arm.com, oliver.upton@linux.dev, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, qperret@google.com, james.morse@arm.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 14:23:10 +0000, Quentin Perret wrote:
> Although harmless, the return statement in kvm_unexpected_el2_exception
> is rather confusing as the function itself has a void return type. The
> C standard is also pretty clear that "A return statement with an
> expression shall not appear in a function whose return type is void".
> Given that this return statement does not seem to add any actual value,
> let's not pointlessly violate the standard.
> 
> [...]

Applied to kvm-arm64/misc-5.20, thanks!

[1/1] KVM: arm64: Don't return from void function
      commit: 1c3ace2b8b3995d3213c5e2d2aca01a0577a3b0f

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

