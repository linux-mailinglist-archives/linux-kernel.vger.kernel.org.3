Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639F8473210
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240967AbhLMQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbhLMQmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:42:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C085C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:42:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2516BB811A5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 16:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FAFC34603;
        Mon, 13 Dec 2021 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639413773;
        bh=wimcO+QIhOAyjAXutFKJzVaoU5e9PpqUP7V1Ryd2E1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3QqiP+z13hiX+gZxXZz/NWZY+OBXONDmvtJm2bEdNIV7ieRlEav7h/qOrXAXdmne
         R6Dc5SHHjh8jSmcXGpK0RbyP8lriee12MTGV8I+i9zss76ns6wboMHj0sKP55o/OdR
         UJtlpB9cJlJRwhhVLla606lDu8duWqg5Tn/5koF3xzTt8aJ+iWYiquPY/+VraRHi5i
         9C9wN31Nee+j4vqazosizghz81xhEp8iAkIht2DU2l1bgS3ZAbQbJPNhQydxRBH8eA
         61yhL3j842B93ktMn6NaVdC8ahli1Iv0cJQupuDHtQpBTZWnrQClfvTA48B61RL0+7
         fj43DBOuapNOA==
From:   Will Deacon <will@kernel.org>
To:     anshuman.khandual@arm.com, catalin.marinas@arm.com,
        Jianyong Wu <jianyong.wu@arm.com>, akpm@linux-foundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, gshan@redhat.com,
        david@redhat.com, justin.he@arm.com, ardb@kernel.org, nd@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: avoid fixmap race condition when create pud mapping
Date:   Mon, 13 Dec 2021 16:42:44 +0000
Message-Id: <163941094777.2464379.2692109101400876104.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211210095432.51798-1-jianyong.wu@arm.com>
References: <20211210095432.51798-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 17:54:32 +0800, Jianyong Wu wrote:
> fixmap is a global resource and is used recursively in create pud mapping.
> It may lead to race condition when alloc_init_pud is called concurrently.
> 
> Fox example:
> alloc_init_pud is called when kernel_init. If memory hotplug
> thread, which will also call alloc_init_pud, happens during
> kernel_init, the race for fixmap occurs.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: avoid fixmap race condition when create pud mapping
      https://git.kernel.org/arm64/c/a6a6b9aa34e5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
