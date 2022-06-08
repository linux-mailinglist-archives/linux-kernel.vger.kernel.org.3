Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E243543F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiFHW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiFHW5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:57:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3447981E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AED7B82AC0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C84C34116;
        Wed,  8 Jun 2022 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654729047;
        bh=mzp8Yvqgh77sLpM5RG27L0HnoG7RYKGHw8dSZJRvpCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KP4lY+aTYqYmLAWToFFs2Z3ZN/FKmkEriopLPxFHxmopoF4zbvGBX0cUmY2iriuve
         HD8q19wzSKb6oitxmQvT/zWwTGsNoOHWQKuzjRyzLHcGGKZqPg1qajv97tFrcJxBEP
         GBQZNvoP8RRJDQ546xgGKXrenKIu11cBIVanA1DeDO2vaj71iYEiE32hCzNAQpv5FP
         g4M3IuovwFMJrtj9I6N0TnKK2xxd6Z23tyEXXGVtH9J5xCWiMIGQDfsMxqA1+CYST/
         UdjZNvv7yO+CixXdqfWRhGq8XDTSGgk/bYQpOly7XqkhTknztVWJTSsqksPWqwbI41
         JALnmvdKSFuwg==
Date:   Wed, 8 Jun 2022 15:57:24 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Joe Damato <jdamato@fastly.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        jiangshanlai@gmail.com, bp@suse.de, brgerst@gmail.com
Subject: Re: [PATCH] x86/mm: Fix RESERVE_BRK() for older binutils
Message-ID: <20220608225724.2drhxj5pt2w5gbaf@treble>
References: <a802eefebee4d2c01f479a7d3f2008fdd32ce270.1654702810.git.jpoimboe@kernel.org>
 <CALALjgy6=Ebi-k-YrSsEozW3Yy4KJGWLiH_5M8i4neEd9ozj_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALALjgy6=Ebi-k-YrSsEozW3Yy4KJGWLiH_5M8i4neEd9ozj_A@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 01:12:09AM +0300, Joe Damato wrote:
> I applied the patch on top of commit 58f9d52ff689 ("Merge tag
> 'net-5.19-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") and the kernel
> now builds successfully for me.
> 
> The resulting kernel boots fine on the machine, as well.
> 
> Tested-by: Joe Damato <jdamato@fastly.com>

Thanks.  Unfortunately, the LLVM linker doesn't like the patch...

>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(kernel/setup.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS
--
>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(mm/init.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS
>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(kernel/setup.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS
--
>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(mm/init.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS

-- 
Josh
