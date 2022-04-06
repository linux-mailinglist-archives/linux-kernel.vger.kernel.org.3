Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114E4F6451
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiDFP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiDFP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:56:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B25A62A9;
        Wed,  6 Apr 2022 06:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 563A5B823BF;
        Wed,  6 Apr 2022 13:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C2DC385A7;
        Wed,  6 Apr 2022 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251356;
        bh=TLyvTgiqSYYjMHPC+UQMx0cLGBFAbPTGSNIZDD5qmEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRcBrf+6Ca4lrZIXmPFpnu3aoqjnUw8Z6cGxpjYO6fDettqwmZVCSZOBIDjbNq5YO
         i5dzuDYR466yR9B0fywX8ZLS4PfkvRVA3d5dgswxve5JR04uo5sl6q1eF5FS8iRgbt
         GwlSaGapzZSML6khLQC38qPSgzf4Vcu6K0tQvETDYD/0PA4/4eAakoulI0mdHDq+UM
         E9gaEVbSo/U0Ob/Nj1VCvMzAms8bYJaOpLrryGksX2erF/kPMQhBcBmkF5A4NqPuoz
         Qw94e16voGukyrwBeUu708IJvfk0MmtInmz6xMhBXUBoPGp45bobwDs9thZs76CmOW
         M53nCiiglPPcQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nc5cH-002AfU-Jz; Wed, 06 Apr 2022 14:22:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        Yu Zhe <yuzhe@nfschina.com>, james.morse@arm.com
Cc:     keescook@chromium.org, ricarkol@google.com, justin.he@arm.com,
        linux-arm-kernel@lists.infradead.org, samitolvanen@google.com,
        kernel-janitors@vger.kernel.org, catalin.marinas@arm.com,
        kvmarm@lists.cs.columbia.edu, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: vgic: remove unnecessary type castings
Date:   Wed,  6 Apr 2022 14:22:31 +0100
Message-Id: <164925133306.3716042.8666897986559310118.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220329102059.268983-1-yuzhe@nfschina.com>
References: <20220328103836.2829-1-yuzhe@nfschina.com> <20220329102059.268983-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, suzuki.poulose@arm.com, yuzhe@nfschina.com, james.morse@arm.com, keescook@chromium.org, ricarkol@google.com, justin.he@arm.com, linux-arm-kernel@lists.infradead.org, samitolvanen@google.com, kernel-janitors@vger.kernel.org, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu, will@kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 29 Mar 2022 03:20:59 -0700, Yu Zhe wrote:
> remove unnecessary casts.

Applied to fixes, thanks!

[1/1] KVM: arm64: vgic: remove unnecessary type castings
      commit: c707663e81ef48d279719e97fd86acef835a2671

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


