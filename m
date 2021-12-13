Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E81473471
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbhLMS4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhLMS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:56:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44655C061574;
        Mon, 13 Dec 2021 10:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9E9461190;
        Mon, 13 Dec 2021 18:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355EEC34600;
        Mon, 13 Dec 2021 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639421808;
        bh=lFEPGVcplB2/PUnkl473QALTUhz7KgoAcwA4eLB2eUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdV7ERkpi5xIZkM+GeAomPGESkR11M/ptbUrlD6g747DJcOcIgbw3JK2z4BNh64of
         AOvY/6qBrBY+s8JIwGfVyuP250d67ntL7euQPgOnDFRjm8tEeK9HOe3NKFBIquSWyY
         3GCtWHwrt+5Ce8P2QxM52P4YQHI2aMl/Tg0GU9wpO20/B5tqTGcav0vRCc6me14oJK
         W5732bSUFOIqT7yW9FI9y7Ujd+3ccAi5qhBJflvoq8H9fgh6N+5fP9CnllwHb0XNSk
         urahTjjbf+Zp61YJNoeLJ88oiKh2QbWmtWz0n0bDxjaJgnZw324rzzGYc+w4onaeyv
         1PmD8KQox2C4g==
Date:   Mon, 13 Dec 2021 18:56:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Weilong Chen <chenweilong@huawei.com>
Cc:     catalin.marinas@arm.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] cache: Workaround HiSilicon Taishan DC CVAU
Message-ID: <20211213185643.GA12717@willie-the-truck>
References: <20211126091139.358114-1-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126091139.358114-1-chenweilong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:11:39PM +0800, Weilong Chen wrote:
> Taishan's L1/L2 cache is inclusive, and the data is consistent.
> Any change of L1 does not require DC operation to brush CL in L1 to L2.
> It's safe that don't clean data cache by address to point of unification.
> 
> Without IDC featrue, kernel needs to flush icache as well as dcache,
> causes performance degradation.
> 
> The flaw refers to V110/V200 variant 1.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
>  Documentation/arm64/silicon-errata.rst |  2 ++
>  arch/arm64/Kconfig                     | 11 +++++++++
>  arch/arm64/include/asm/cputype.h       |  2 ++
>  arch/arm64/kernel/cpu_errata.c         | 32 ++++++++++++++++++++++++++
>  arch/arm64/tools/cpucaps               |  1 +
>  5 files changed, 48 insertions(+)

Hmm. We don't usually apply optimisations for specific CPUs on arm64, simply
because the diversity of CPUs out there means it quickly becomes a
fragmented mess.

Is this patch purely a performance improvement? If so, please can you
provide some numbers in an attempt to justify it?

Thanks,

Will
