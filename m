Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1895C490928
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiAQNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:08:31 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43016
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232521AbiAQNIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:08:24 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 39B2A3F1DD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642424903;
        bh=e08JKMUCF9rkW7h8herQx6Sp+GfYHkpXq4pM7aKk9D8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=L5kyqyR8KzD0g668bEsrnQlxQteAO4+lj6r4akvlz7rmjir6q5ODVprjrOGfE5vh6
         xZ19/8UpLeTGkEGuosTsegRWgb3NIbgoBetV6rEhDobhJBNrcIfD2iElYKKKJJDjCv
         nYIBrpdBNjz9xrqYi/B/sqbNZKsBW4aJ7BzpIPRcQs3G7QKx/kuvZqtJMZZhlf8ub9
         tHitEI37tZzBeZQFESk8yZ62KwWGDTU7c0K/uGHbsrUQkR96ygtq7bJz7NdWqUwIFA
         ZKTUjj0jjKOeLpKpBeSH3kOo/sS/a/3V4vC/GqBsLFw7Mu8whq1edO+aNhP0tY+PLq
         XNHhVjKmsUW6w==
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso14216084edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e08JKMUCF9rkW7h8herQx6Sp+GfYHkpXq4pM7aKk9D8=;
        b=PzqY9fdyb/v+mhAP81Tc3Ndj+TIsAmpmTF11POrSnQrLdi0+Ce33LBk9OZLR62M3RR
         4+7hl5HBXl+VHO32d5TzQuOEYak5Zrbd0MvAxnfYGpCxSEuPgdPM+V4AtkHPSwv7VmuT
         zFOTiNx3RJwU0CecFQRHHtNvGCK8cggzqNyMOmFb/gpPlBWGaTw6mcIYovvO4/4iZgSY
         fVN8IPiso7RFkeRQ/gQA1KgcpYGVCa64UaYpiSSoHGmj3Hk+cfhSKiKyITUtGSSd7RVA
         +nn99UMbdD4c/zd5M72cJDc78d8lfbHVy6aFEdHKbZX8i9UCPXVxuntJegPWrFs93Z10
         bBQw==
X-Gm-Message-State: AOAM530iq3k/pLzIZl8fi+dEM6lmkpbUmgGIEZ+mx+D7t2zg3V/Uzs2i
        UyePsT2P1Nm3wrXI9yRJiRmRn81Vg2MiuCF3e5hppxZH0/kN2dfaEVzf2SjofBaG+hpQA/m2qOw
        Q/KTnsZggqmDWOLGe4C0/NrNgniNjLn9F81lVTh49jg==
X-Received: by 2002:a50:eacb:: with SMTP id u11mr20647274edp.290.1642424902564;
        Mon, 17 Jan 2022 05:08:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaB8f22s1yf7HiR470gf2zwStoCK0L+L42jchbE9hJLljq12+sbh42N7thqto1gshz4ZpU+w==
X-Received: by 2002:a50:eacb:: with SMTP id u11mr20647256edp.290.1642424902353;
        Mon, 17 Jan 2022 05:08:22 -0800 (PST)
Received: from [192.168.0.37] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id vr3sm4408676ejb.107.2022.01.17.05.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 05:08:21 -0800 (PST)
Message-ID: <57ad6f87-2198-92c6-8c26-f5b5a8d8a354@canonical.com>
Date:   Mon, 17 Jan 2022 14:08:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: ERROR: modpost: "gpmc_omap_get_nand_ops"
 [drivers/mtd/nand/raw/omap2_nand.ko] undefined!
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202201171805.5HeoR4rS-lkp@intel.com>
 <232ecd71-c4f8-6272-9a1e-91372763c3f5@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <232ecd71-c4f8-6272-9a1e-91372763c3f5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 13:35, Roger Quadros wrote:
> Hi,
> 
> On 17/01/2022 12:51, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   0c947b893d69231a9add855939da7c66237ab44f
>> commit: dbcb124acebd8148e9e858a231f1798956dd3ca6 mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
>> date:   4 weeks ago
>> config: arm64-randconfig-r001-20220117 (https://download.01.org/0day-ci/archive/20220117/202201171805.5HeoR4rS-lkp@intel.com/config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install arm64 cross compiling tool for clang build
>>         # apt-get install binutils-aarch64-linux-gnu
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dbcb124acebd8148e9e858a231f1798956dd3ca6
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout dbcb124acebd8148e9e858a231f1798956dd3ca6
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> ERROR: modpost: "gpmc_omap_get_nand_ops" [drivers/mtd/nand/raw/omap2_nand.ko] undefined!
> 
> The issue is that CONFIG_MEMORY is not set so OMAP_GPMC driver is not built causing the above undefined symbol error.
> 
>>
>> Kconfig warnings: (for reference only)
>>    WARNING: unmet direct dependencies detected for OMAP_GPMC
>>    Depends on MEMORY && OF_ADDRESS
>>    Selected by
>>    - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST && HAS_IOMEM && ARCH_K3
>>
> 
> A possible fix would be to select MEMORY along with OMAP_GPMC at the below location
> 
> config MTD_NAND_OMAP2
>         tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>         depends on HAS_IOMEM
> 	select MEMORY
> ^^
>         select OMAP_GPMC if ARCH_K3 
>         help
>           Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>           and Keystone platforms.
> 
> 
> Is this OK?

Instead rather "select MEMORY if ARCH_K3"?

However I had impression that selecting a user-visible options is
discouraged, especially from within the drivers. What I would expect is
to select it from the machine/architecture code like you did before [1]
but was rejected by Nishanth.

https://lore.kernel.org/linux-devicetree/20211217161417.q2qwwlki7oieqzjd@headlock/

In such case, your choice (with if ARCH...?) seems sensible.
MTD_NAND_FSL_IFC already does it.

Best regards,
Krzysztof
