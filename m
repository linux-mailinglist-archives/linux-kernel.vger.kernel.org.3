Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAED543D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiFHUJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFHUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:09:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE2BA987
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4C3CB82AC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5139AC34116;
        Wed,  8 Jun 2022 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654718981;
        bh=pz7GykqV2fBiNMIoMumJXkyndH8tIJzyT30UbdEylm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h7S1smJh5zFtLPBh3uAO9csKh+t12Pf8/uD6P4jq1i5weXqc30W53KfRvY/2Ew0p9
         YXQADjF9ap1MvHMjE+BiJwnsjEp+UgYdL1adxVQ+9V6Q9zYAxWdHLZ8XAXyt2UBNEo
         nbtb+3fSany3022UQpV4rFwMZ8b/9DBAs4BQt+94=
Date:   Wed, 8 Jun 2022 13:09:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, trix@redhat.com
Subject: Re: [PATCH v2] include/uapi/linux/swab.h: move explicit cast
 outside ternary
Message-Id: <20220608130940.8d2c3cb4a31b77a3274756df@linux-foundation.org>
In-Reply-To: <20220608001422.26383-1-jstitt007@gmail.com>
References: <CAKwvOd=-NXR5HoHwwEUZMsCt90oaADH6XHifje9n-8S8rj9SFw@mail.gmail.com>
        <20220608001422.26383-1-jstitt007@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jun 2022 17:14:22 -0700 Justin Stitt <jstitt007@gmail.com> wrote:

> A cast inside __builtin_constant_p doesn't do anything since it should evaluate
> as constant at compile time irrespective of this cast. Instead, I moved this
> cast outside the ternary to ensure the return type is as expected.
> 
> For instance, if __HAVE_BUILTIN_BSWAP16__ was not defined then __swab16 is
> actually returning an `int` not a `u16` due to integer promotion as described
> by Nick in this thread. This has repercussions when building with clang
> -Wformat. This fix should solve many of these warnings.
> 

ARM allmodconfig:

In file included from ./include/linux/swab.h:5,
                 from ./arch/arm/include/asm/opcodes.h:86,
                 from ./arch/arm/include/asm/bug.h:7,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/slab.h:15,
                 from ./fs/xfs/kmem.h:9,
                 from ./fs/xfs/xfs_linux.h:24,
                 from ./fs/xfs/xfs.h:22,
                 from fs/xfs/scrub/agheader.c:6:
fs/xfs/scrub/agheader.c: In function 'xchk_superblock':
./include/uapi/linux/byteorder/little_endian.h:42:52: error: unsigned conversion from 'int' to 'short unsigned int' changes value from '-49265' to '16271' [-Werror=overflow]
   42 | #define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
      |                                                    ^~~
./include/uapi/linux/swab.h:102:46: note: in definition of macro '__swab16'
  102 | #define __swab16(x) (__u16)__builtin_bswap16(x)
      |                                              ^
./include/linux/byteorder/generic.h:96:21: note: in expansion of macro '__cpu_to_be16'
   96 | #define cpu_to_be16 __cpu_to_be16
      |                     ^~~~~~~~~~~~~
fs/xfs/scrub/agheader.c:158:23: note: in expansion of macro 'cpu_to_be16'
  158 |         vernum_mask = cpu_to_be16(~XFS_SB_VERSION_OKBITS |
      |                       ^~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:249: fs/xfs/scrub/agheader.o] Error 1
make[1]: *** [scripts/Makefile.build:466: fs/xfs] Error 2
make: *** [Makefile:1839: fs] Error 2

