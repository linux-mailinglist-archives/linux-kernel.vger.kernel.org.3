Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8547CA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhLVAIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhLVAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:08:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:08:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJYZf0kXFz4xd4;
        Wed, 22 Dec 2021 11:08:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1640131723;
        bh=VaK3fe/fwdQvGHMuHp0W4YtsHrFkm3aqf/mdtrIJnfY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AZ/3hHLatxABiCAVuLhEeUXvZWOLql6W16iEG/c+hI7PdR8C7f7z7ziHSBYEF5V7h
         X2bFYppX0K5l0KiULFvEORw3SEubax/VvTFa3KIF19cemiiNLmDEvrTXatkp0nc66D
         n4lnGiqWP6EcavcwIMpS2p3kJ2bJ2ni39lGQ0fib3rp3ZD9jcF2Zy6e7Ahd/StAF3B
         LQj7/fBagdAoUz8/kJP2XPIm4Lpbf3m1mvuF4zgYBSZgJ1tXiEB1aSA8Bk40+gu7u3
         kFyUFfxv6oXEMRsadk7lOD6J/RJ8G5osazX1+INvubKVjjcD6FBlibADXVo4c2Euus
         b3Pl4S7dIvwFw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     cgel.zte@gmail.com, arnd@arndb.de
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] powerpc/cell/axon_msi: replace DEFINE_SIMPLE_ATTRIBUTE
 with  DEFINE_DEBUGFS_ATTRIBUTE
In-Reply-To: <20211221144814.480849-1-deng.changcheng@zte.com.cn>
References: <20211221144814.480849-1-deng.changcheng@zte.com.cn>
Date:   Wed, 22 Dec 2021 11:08:38 +1100
Message-ID: <87h7b1lcvt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Fix the following coccicheck warning:
> ./arch/powerpc/platforms/cell/axon_msi.c: 456: 0-23: WARNING: fops_msic
> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> debugfs files.

But it also says:

  //# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
  //# imposes some significant overhead as compared to
  //# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

Your patch doesn't change it to use debugfs_create_file_unsafe(),
shouldn't it?

cheers

> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 354a58c1e6f2..47bb0ae8d6c9 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -453,7 +453,7 @@ static int msic_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
>  
>  void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
>  {
> -- 
> 2.25.1
