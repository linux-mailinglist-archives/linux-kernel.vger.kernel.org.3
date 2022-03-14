Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E104D8778
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiCNOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiCNOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:54:25 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E802559C;
        Mon, 14 Mar 2022 07:53:14 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nTm4O-0006nG-03; Mon, 14 Mar 2022 15:53:12 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1C409C2E31; Mon, 14 Mar 2022 15:52:52 +0100 (CET)
Date:   Mon, 14 Mar 2022 15:52:52 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-mips@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MIPS: boot/compressed: Use array reference for image
 bounds
Message-ID: <20220314145252.GF13438@alpha.franken.de>
References: <20220309185032.229123-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309185032.229123-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:50:32AM -0800, Kees Cook wrote:
> As done with other image addresses in other architectures, use an
> explicit flexible array instead of "address of char", which can trip
> bounds checking done by the compiler. Found when building with
> -Warray-bounds:
> 
> In file included from ./include/linux/byteorder/little_endian.h:5,
>                  from ./arch/mips/include/uapi/asm/byteorder.h:15,
>                  from ./arch/mips/include/asm/bitops.h:21,
>                  from ./include/linux/bitops.h:33,
>                  from ./include/linux/kernel.h:22,
>                  from arch/mips/boot/compressed/decompress.c:13:
> arch/mips/boot/compressed/decompress.c: In function 'decompress_kernel':
> ./include/asm-generic/unaligned.h:14:8: warning: array subscript -1 is outside array bounds of 'unsigned char[1]' [-Warray-bounds]
>    14 |  __pptr->x;        \
>       |  ~~~~~~^~~
> ./include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
>    35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>       |                                                   ^
> ./include/asm-generic/unaligned.h:32:21: note: in expansion of macro '__get_unaligned_t'
>    32 |  return le32_to_cpu(__get_unaligned_t(__le32, p));
>       |                     ^~~~~~~~~~~~~~~~~
> arch/mips/boot/compressed/decompress.c:29:37: note: while referencing '__image_end'
>    29 | extern unsigned char __image_begin, __image_end;
>       |                                     ^~~~~~~~~~~
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/boot/compressed/decompress.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
