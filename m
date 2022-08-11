Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32C58FEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiHKPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiHKPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:02:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7169D24BEA;
        Thu, 11 Aug 2022 08:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E776B82144;
        Thu, 11 Aug 2022 15:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54807C433C1;
        Thu, 11 Aug 2022 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660230141;
        bh=2+gh8k2LlVNKWFxEu+WPl9ll4HYEyNbUFNiZpgXDGUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jA46IFbUYlcBl2dGV9Jq7CrjslaVz98zknQlszPazfdGk4wzKtUoJJ5b1MbENzJHW
         5aspY8ejQaW+oyvA/kBZu+r8VCxN2lujGULnMXO1TK3WyeNlPE3Ps9CKSIJ8guRUyt
         vfeT8igf/6BcLLTluwkWFxTeKK3rUNGh5llG24ZElfspS5qeOVrJ+sPaw3k6c1AGXt
         woZNRztzkLE/HU4m8vGw3ow6U5WP7x5uaC2h2w11+0W+EMHQRwIBgOAHacW2retu49
         sDNb7/+U/wE1f8in/OGoBxTmYQWz2Sb4kSxiRsndlBwFP7nU60P1XFCF4bE8QNelo6
         fNCL2h0Pgu0zw==
Date:   Thu, 11 Aug 2022 08:02:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: mainline build failure for arm64 allmodconfig with clang
Message-ID: <YvUZ+9kJ/AvUMxzO@dev-arch.thelio-3990X>
References: <YvSxeDkmwxcJL+Z0@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvSxeDkmwxcJL+Z0@debian>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On Thu, Aug 11, 2022 at 08:36:24AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build for arm64 allmodconfig
> with clang. The errors are:
> 
> sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>                  ^~~~~~~~~~~~~
> ./include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
>         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                  ~~~     ^~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> ./include/uapi/sound/sof/abi.h:30:23: note: expanded from macro 'SOF_ABI_MAJOR'
> #define SOF_ABI_MAJOR 3
>                       ^
> sound/soc/sof/ipc3-topology.c:2343:19: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>                                 ^~~~~~~~~~~~~
> ./include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
>         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                  ~~~     ^~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> ./include/uapi/sound/sof/abi.h:31:23: note: expanded from macro 'SOF_ABI_MINOR'
> #define SOF_ABI_MINOR 23
>                       ^~
> sound/soc/sof/ipc3-topology.c:2343:34: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>                                                ^~~~~~~~~~~~~
> ./include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
>         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                  ~~~     ^~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> ./include/uapi/sound/sof/abi.h:32:23: note: expanded from macro 'SOF_ABI_PATCH'
> #define SOF_ABI_PATCH 0
>                       ^
> 3 errors generated.
> 
> drivers/ntb/hw/idt/ntb_hw_idt.c:2409:28: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                                 "\t%hhu-%hhu.\t", idx, idx + cnt - 1);
>                                         ~~~~           ^~~~~~~~~~~~~
>                                         %d
> drivers/ntb/hw/idt/ntb_hw_idt.c:2438:29: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                                         "\t%hhu-%hhu.\t", idx, idx + cnt - 1);
>                                                 ~~~~           ^~~~~~~~~~~~~
>                                                 %d
> drivers/ntb/hw/idt/ntb_hw_idt.c:2484:15: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
>                         idx, data, src, ndev->peers[src].port);
>                                    ^~~
> 3 errors generated.
> 
> For both, git bisect points to 0af5cb349a2c ("Merge tag 'kbuild-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild")

Right, these are exposed by commit 258fafcd0683 ("Makefile.extrawarn:
re-enable -Wformat for clang"). They both have fixes in -next so I am
hoping they will be in Linus's tree soon:

b7bf23c0865f ("ASoC: SOF: ipc3-topology: Fix clang -Wformat warning")
a44252d5c3bb ("ntb: idt: fix clang -Wformat warnings")

Cheers,
Nathan
