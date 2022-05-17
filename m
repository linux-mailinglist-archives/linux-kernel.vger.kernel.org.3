Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0B52A43D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348386AbiEQOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348433AbiEQOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DBB4C79F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 594D7615C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449AEC34116;
        Tue, 17 May 2022 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652796295;
        bh=Q2KpV/j2HnVCcTf13L/YKoxhkcb4XM6FTwEhlWOH0vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j32IXsAfOr79u1X0Suaw8ekFaezaseBcc7NgoIGbMpu3OKCg7nXWb6piMdPzCtH3T
         8jM7pHfs5dkojn9N4AgfpIVj/ZckGLqc07q0UZI8+ZAdqcebRy642vy3Ilb1ynoNri
         tmH/Tz8gWMY043W39P9duG3I/UyHdgfRXIn2HvM0jR/3xvrhTR1MlGqvJjUqOjg2qp
         LrCg9AanQK1ars7TGq/R6AENgZxWEaUof7PtWtqT4eT8CBmvtUnA8O6icQ9wH9GZEM
         BOnM3LFV7cCc+9ObMGUOBKKxeJpT+Ur7GVhZ6Oi9iiuls3GPHfA0rXhS60ZcXe8PxF
         K3UqJq5CYVpZA==
From:   Will Deacon <will@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3] arm64: paravirt: Use RCU read locks to guard stolen_time
Date:   Tue, 17 May 2022 15:04:44 +0100
Message-Id: <165279381181.2978864.3665903579432057917.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220513174654.362169-1-quic_eberman@quicinc.com>
References: <20220513174654.362169-1-quic_eberman@quicinc.com>
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

On Fri, 13 May 2022 10:46:54 -0700, Elliot Berman wrote:
> From: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> 
> During hotplug, the stolen time data structure is unmapped and memset.
> There is a possibility of the timer IRQ being triggered before memset
> and stolen time is getting updated as part of this timer IRQ handler. This
> causes the below crash in timer handler -
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: paravirt: Use RCU read locks to guard stolen_time
      https://git.kernel.org/arm64/c/19bef63f951e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
