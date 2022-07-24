Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6657F763
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiGXWkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F951056B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E0D611F1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 22:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8655C3411E;
        Sun, 24 Jul 2022 22:39:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OIo+gX7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658702396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwwPwwf8qoP83WuKgLNvp+yCb0Gwetm9WwYQMbMcL3s=;
        b=OIo+gX7rmSX+g39zbesRVfqjC3U//gxNk03U5YiB9zk6EAq9kmTtoe3uq4kVaJgNBzXeDK
        0DRtPPMa5EZoC/945dYKIwf5qw8QMJnDe3SU5eQpOzyLWMy0/WGp5Dpp5BJlrgzIs8fROj
        75U711KkfeHRPQPuZVtgQ0ZL7/uilTA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f3c01f5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 24 Jul 2022 22:39:55 +0000 (UTC)
Date:   Mon, 25 Jul 2022 00:39:53 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     kernel test robot <lkp@intel.com>, ardb@kernel.org
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.15.y 6874/8723]
 arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version
 4.6 of GCC
Message-ID: <Yt3KObFVIUI2mFGt@zx2c4.com>
References: <202207250449.BYMZbIA2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202207250449.BYMZbIA2-lkp@intel.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Mon, Jul 25, 2022 at 04:14:48AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version 4.6 of GCC [-W#warnings]
>    #warning This code requires at least version 4.6 of GCC
>     ^
>    1 warning generated.
> 
> 
> vim +30 arch/arm/lib/xor-neon.c
> 
> 01956597cbc46d Ard Biesheuvel 2013-05-17  16  
> 01956597cbc46d Ard Biesheuvel 2013-05-17  17  /*
> 01956597cbc46d Ard Biesheuvel 2013-05-17  18   * Pull in the reference implementations while instructing GCC (through
> 01956597cbc46d Ard Biesheuvel 2013-05-17  19   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> 01956597cbc46d Ard Biesheuvel 2013-05-17  20   * NEON instructions.
> 01956597cbc46d Ard Biesheuvel 2013-05-17  21   */
> 01956597cbc46d Ard Biesheuvel 2013-05-17  22  #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> 01956597cbc46d Ard Biesheuvel 2013-05-17  23  #pragma GCC optimize "tree-vectorize"
> 01956597cbc46d Ard Biesheuvel 2013-05-17  24  #else
> 01956597cbc46d Ard Biesheuvel 2013-05-17  25  /*
> 01956597cbc46d Ard Biesheuvel 2013-05-17  26   * While older versions of GCC do not generate incorrect code, they fail to
> 01956597cbc46d Ard Biesheuvel 2013-05-17  27   * recognize the parallel nature of these functions, and emit plain ARM code,
> 01956597cbc46d Ard Biesheuvel 2013-05-17  28   * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> 01956597cbc46d Ard Biesheuvel 2013-05-17  29   */
> 01956597cbc46d Ard Biesheuvel 2013-05-17 @30  #warning This code requires at least version 4.6 of GCC
> 01956597cbc46d Ard Biesheuvel 2013-05-17  31  #endif
> 01956597cbc46d Ard Biesheuvel 2013-05-17  32  

Does this file need a depends on ≥4.6 thing in Kconfig? Or is something
else happening here since 4.6 isn't even supported by the kernel these
days?

Jason
