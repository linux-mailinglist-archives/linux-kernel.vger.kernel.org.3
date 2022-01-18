Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5549254F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiARMCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:02:08 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47470
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237808AbiARMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:02:07 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA4513F1E1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642507319;
        bh=lWp9D6Gb/hKsGfFZ+PUoC3Eon55T4hCbYJ43VkS4IP0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KNssfaq2OxU6nCW8Qvm8NeFpi4Hh/XfQ4rJhAWHTdWQxkqy2FG7FffXoc2YH1hZgc
         MDdWbHkO+P+exIqN+vgAC5J9/wsiDzxS1WsgxdIeM4UVxPNuNwsJWCTlnZmYz9WpNv
         FYN1dWeQM7a3uHfM6tFfLzxxqMPjWCmqANEkbA1ntfL/G8Ap7XzVuqPdX7VnNU68Yk
         uVhzLuFoJDol2l2f79Y2bJ/cffzYW8wM9y9FyLBsFccwDNJ1C0+BzE1ISFWsQ1fqbK
         J4chZxjs66/F9ZRCqYvNoCYy+V4A/MmVpaPA0IyzVkMuwTALyNgxnon3uI4oGdkIf2
         Box+H/OCZkkGQ==
Received: by mail-ed1-f70.google.com with SMTP id ee53-20020a056402293500b004022f34edcbso6102620edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lWp9D6Gb/hKsGfFZ+PUoC3Eon55T4hCbYJ43VkS4IP0=;
        b=5PurmjO7UHjJY4StV8EBpNvqyMLLckDlxFOdflcHagj547uguErY78893HCwHddcKQ
         LIvd2TfjUIEsqxR9cZCOODUnkHKOWMM9IjYwjkR7txr5GsN7WcYuSP7IIHrTP2e4Mp/D
         9aeDsjxVnskMMalgRTzuP5uYzp+KYrEDuQOF9QvIoVdRsD8ZFgFZyRK33ZlljTv73yDx
         XcI673aVi8InqbzjOuPgMItgC9L2flG8d1dY5XFlHYfiamlqTTeHV3CwEwLogvI3+cCd
         FUj/HDOnXJe8/kGbsWSFztshbQzy49f27yyVXvo2rq42ALTq4jxZmPeSuOwv6IB10ApT
         aS0A==
X-Gm-Message-State: AOAM533GashY9DhDjZH+5urSEQYButYuKj/KhHJtGbc/FRh2LudIVpgj
        nNuamYq3DlOGL0Jbc0QudoXXrj/ZKrkAaZLs1vZqaIkjn/kbuNZA6riCmuy35uOJM1PiF0iFM+k
        LunLO8jItxzzinoP/ObkyRZ2f9sVYbnCDUsc+NU9hwA==
X-Received: by 2002:a17:907:a424:: with SMTP id sg36mr11140758ejc.426.1642507319222;
        Tue, 18 Jan 2022 04:01:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO8IEgxKwBfxxftPu6ekoj48zmPhv17kAuB/R6hif+x1cfua53dfQ/bMN9TxZ5m2uJPBJEfw==
X-Received: by 2002:a17:907:a424:: with SMTP id sg36mr11140741ejc.426.1642507318974;
        Tue, 18 Jan 2022 04:01:58 -0800 (PST)
Received: from [192.168.0.41] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l8sm3063388edv.52.2022.01.18.04.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 04:01:58 -0800 (PST)
Message-ID: <bdca34bd-50f5-c526-26f1-0f2add02f361@canonical.com>
Date:   Tue, 18 Jan 2022 13:01:57 +0100
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
 <57ad6f87-2198-92c6-8c26-f5b5a8d8a354@canonical.com>
 <7c523b72-2285-80b9-e0fc-0fbb2aa9d439@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <7c523b72-2285-80b9-e0fc-0fbb2aa9d439@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 12:51, Roger Quadros wrote:
> Hi Krzysztof,
> 
> On 17/01/2022 15:08, Krzysztof Kozlowski wrote:
>> On 17/01/2022 13:35, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 17/01/2022 12:51, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   0c947b893d69231a9add855939da7c66237ab44f
>>>> commit: dbcb124acebd8148e9e858a231f1798956dd3ca6 mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
>>>> date:   4 weeks ago
>>>> config: arm64-randconfig-r001-20220117 (https://download.01.org/0day-ci/archive/20220117/202201171805.5HeoR4rS-lkp@intel.com/config)
>>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
>>>> reproduce (this is a W=1 build):
>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         # install arm64 cross compiling tool for clang build
>>>>         # apt-get install binutils-aarch64-linux-gnu
>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dbcb124acebd8148e9e858a231f1798956dd3ca6
>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>         git fetch --no-tags linus master
>>>>         git checkout dbcb124acebd8148e9e858a231f1798956dd3ca6
>>>>         # save the config file to linux build tree
>>>>         mkdir build_dir
>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>>
>>>>>> ERROR: modpost: "gpmc_omap_get_nand_ops" [drivers/mtd/nand/raw/omap2_nand.ko] undefined!
>>>
>>> The issue is that CONFIG_MEMORY is not set so OMAP_GPMC driver is not built causing the above undefined symbol error.
>>>
>>>>
>>>> Kconfig warnings: (for reference only)
>>>>    WARNING: unmet direct dependencies detected for OMAP_GPMC
>>>>    Depends on MEMORY && OF_ADDRESS
>>>>    Selected by
>>>>    - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST && HAS_IOMEM && ARCH_K3
>>>>
>>>
>>> A possible fix would be to select MEMORY along with OMAP_GPMC at the below location
>>>
>>> config MTD_NAND_OMAP2
>>>         tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>>         depends on HAS_IOMEM
>>> 	select MEMORY
>>> ^^
>>>         select OMAP_GPMC if ARCH_K3 
>>>         help
>>>           Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
>>>           and Keystone platforms.
>>>
>>>
>>> Is this OK?
>>
>> Instead rather "select MEMORY if ARCH_K3"?
> 
> I think we should drop "if ARCH_K3" for both for simplicity as the driver is using gpmc_omap_get_nand_ops() from that driver.
> 

Then it's fine.


Best regards,
Krzysztof
