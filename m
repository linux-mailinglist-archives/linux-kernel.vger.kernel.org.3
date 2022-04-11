Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7438E4FC3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiDKSRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiDKSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:17:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3270317053;
        Mon, 11 Apr 2022 11:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3DCDB817F3;
        Mon, 11 Apr 2022 18:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223BC385A4;
        Mon, 11 Apr 2022 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649700922;
        bh=HR43g8dQZ+Bf1PK6RXmGBq51cAbYP3qPfOsUCTcQM/s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=b+6SlUL0MNqNciSMHvizcaqgsproBh8RhlWrywElPTDdbV1yOn8Zrs4jEcudwNKXI
         wdMeh7ZImEiqzpvQ1H8RJF2+sik10SHDXdFdJIDem06V78JydjbMDlguteVmZrg8D6
         Pv80MSf+tS+Yx5ackjJmg+UYHe8ZxASKeqzExZvDBD/uofO/lyNE7HpXqaKjKVvC6N
         lfF5t1HkHQDh+aETqbWcSWVhe2D+83gopjZ2390ofgnXFzUnzUi6SCFDla3OXUNd3F
         CCG04moCR8SQ7otnfw0kkZpFgspQAwC09VPPZeC/h1MHUNzVN0hipMxjQU2lmikb5e
         7iOopVVL7QrNg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, sparclinux@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.18-rc2
References: <CAHk-=wh0+DYC2+Aeu2=vfUtGaDqVuKxKrxyhwQFoG89rcynzww@mail.gmail.com>
        <20220411103528.2187797-1-geert@linux-m68k.org>
        <alpine.DEB.2.22.394.2204111240560.38484@ramsan.of.borg>
Date:   Mon, 11 Apr 2022 21:15:16 +0300
In-Reply-To: <alpine.DEB.2.22.394.2204111240560.38484@ramsan.of.borg> (Geert
        Uytterhoeven's message of "Mon, 11 Apr 2022 12:42:07 +0200 (CEST)")
Message-ID: <87zgkrqyff.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Mon, 11 Apr 2022, Geert Uytterhoeven wrote:
>> JFYI, when comparing v5.18-rc2[1] to v5.18-rc1[3], the summaries are:
>>  - build warnings: +23/-0
>
>   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: 'struct page' declared inside parameter list [-Werror]:  => 38:37
>   + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]:  => 38:37
>
> sparc64/sparc-allmodconfig
>
>   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1639:13, 1756:13
>   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct mm_struct *)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1662:29, 1674:29
>   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct mm_struct *, long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1767:21
>   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct vm_area_struct *, long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1741:29, 1726:29
>   + /kisskb/src/arch/sparc/mm/srmmu.c: error: cast between incompatible function types from 'void (*)(struct vm_area_struct *, long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)' [-Werror=cast-function-type]:  => 1711:29, 1694:29
>
> sparc64-gcc11/sparc-allmodconfig
>
>   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_491' declared with attribute error: FIELD_PREP: mask is not constant:  => 352:38
>   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_520' declared with attribute error: FIELD_PREP: mask is not constant:  => 352:38
>
> mipsel/mips-allmodconfig
> arm64-gcc5.4/arm64-allmodconfig
>
> Actual error is:
>
>     /kisskb/src/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c: In function 'mt76x2e_probe':
>     /kisskb/src/include/linux/compiler_types.h:352:38: error: call to '__compiletime_assert_520' declared with attribute error: FIELD_PREP: mask is not constant

Does this commit fix it:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=dbc2b1764734857d68425468ffa8486e97ab89df

Or is this another issue?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
