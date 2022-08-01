Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F21586E09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiHAPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHAPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:47:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13EB33340
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59359B8124C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6824C433D6;
        Mon,  1 Aug 2022 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659368858;
        bh=vo0HQjEwl/3zE+Vx+C+n57BORefplVKjlJ4d+4Oo0TY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=niTCD5PwhTlZvw2lOpi1FfZDU1mbAc/YFlmwC/MGGPTNveZnncw5Kic0avG4zE0PO
         7+xNtUaU8upocsv0k7dmk3HkLREJ3qd/pc/mK8AMYX3o6U1KgHSRmSm5JE3PPFOQXQ
         DHJrcmQgiU6K0otv33AE1U94Ba9q7TkxVHOcToIPHHLz1Q/+o12CLpsSFDeWPLUIvR
         GoXwWaBiZztW/cB/DZ9r860L5Y7CuulnuJQ9VCEu2ggHTfdVXTAfQ4gaJQKZR8Mzmb
         RISwcAEckgVpyS4UroYeFnUEkhcQs1oBAt0yRMNlcPLHEgyTp8JYby9Jl2gbqvZDE2
         3oYcLiIxudsiQ==
Date:   Mon, 1 Aug 2022 08:47:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/ethernet/atheros/ag71xx.c:994:38: warning: passing
 argument 2 of 'ag71xx_hw_set_macaddr' discards 'const' qualifier from
 pointer target type
Message-ID: <20220801084736.0655e1da@kernel.org>
In-Reply-To: <202208010713.jcG50gwa-lkp@intel.com>
References: <202208010713.jcG50gwa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 07:20:16 +0800 kernel test robot wrote:
> Hi Jakub,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3d7cb6b04c3f3115719235cc6866b10326de34cd
> commit: adeef3e32146a8d2a73c399dc6f5d76a449131b1 net: constify netdev->dev_addr
> date:   8 months ago
> config: mips-randconfig-r033-20220801 (https://download.01.org/0day-ci/archive/20220801/202208010713.jcG50gwa-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adeef3e32146a8d2a73c399dc6f5d76a449131b1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout adeef3e32146a8d2a73c399dc6f5d76a449131b1
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/ethernet/atheros/

That's fixed by 225b0ed27e6 FWIW but the fix went into the wrong tree.
Luckily the merge window is upon us.
