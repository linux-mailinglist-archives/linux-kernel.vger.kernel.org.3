Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266E847907E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbhLQPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhLQPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:53:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A02C061763;
        Fri, 17 Dec 2021 07:53:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2E262287;
        Fri, 17 Dec 2021 15:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766A3C36AEA;
        Fri, 17 Dec 2021 15:53:16 +0000 (UTC)
Date:   Fri, 17 Dec 2021 15:53:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [next] arm64: efi-rt-wrapper.S:8: Error: unknown mnemonic `bti'
 -- `bti c'
Message-ID: <YbyyaX/7S+1PqRYq@arm.com>
References: <CA+G9fYt-k1daHarGoXKz7uYvsAcDMNM2bk7jRcYBNf0sRE=+LQ@mail.gmail.com>
 <YbyX+I2PBwio0MYk@arm.com>
 <YbyjerZen9CwYKSV@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbyjerZen9CwYKSV@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 02:49:30PM +0000, Mark Brown wrote:
> On Fri, Dec 17, 2021 at 02:00:24PM +0000, Catalin Marinas wrote:
> > We defined the bti macro in assembler.h but that's not included by
> > linkage.h and not all asm files seem to include the former. At a quick
> > grep we need the diff below, not sure it's the best solution:
> 
> That seems sensible to me, especially given the small number of files
> affected.  The other thing would be to decide that all assembly files
> should have the header included by default but that seems like it's
> invasive and probably disproportionate.

There's also this:

diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index 9065e4749b42..b77e9b3f5371 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -1,6 +1,10 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H

+#ifdef __ASSEMBLY__
+#include <asm/assembler.h>
+#endif
+
 #define __ALIGN		.align 2
 #define __ALIGN_STR	".align 2"

-- 
Catalin
