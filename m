Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16273519D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiEDKzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348350AbiEDKzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74224591
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6011661AC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4908C385A4;
        Wed,  4 May 2022 10:52:06 +0000 (UTC)
Date:   Wed, 4 May 2022 11:52:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michal Orzel <michal.orzel@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bertrand.marquis@arm.com
Subject: Re: [PATCH] arm64: cputype: Avoid overflow using
 MIDR_IMPLEMENTOR_MASK
Message-ID: <YnJa087yFSv/RAuf@arm.com>
References: <20220426070603.56031-1-michal.orzel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426070603.56031-1-michal.orzel@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:06:03AM +0200, Michal Orzel wrote:
> Value of macro MIDR_IMPLEMENTOR_MASK exceeds the range of integer
> and can lead to overflow. Currently there is no issue as it is used
> in expressions implicitly casting it to u32. To avoid possible
> problems, fix the macro.
> 
> Signed-off-by: Michal Orzel <michal.orzel@arm.com>
> ---
> Should we also add a U suffix to ARM_CPU_IMP_* macros that are also shifted
> by MIDR_IMPLEMENTOR_SHIFT? None of them has bit 7 set but we could take some
> precaution steps.

I'm ok with not adding it now. We haven't been consistent with this but
we did encounter a few issues in the past with other bits and only fixed
those that were touching bit 31.

-- 
Catalin
