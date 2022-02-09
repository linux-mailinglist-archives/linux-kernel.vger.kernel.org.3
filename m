Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42D4AF2D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiBINe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiBINez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:34:55 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C6DFC0613CA;
        Wed,  9 Feb 2022 05:34:58 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nHn7Y-0005Ye-01; Wed, 09 Feb 2022 14:34:56 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 27B35C24BE; Wed,  9 Feb 2022 14:34:47 +0100 (CET)
Date:   Wed, 9 Feb 2022 14:34:47 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] MIPS: Malta: Enable BLK_DEV_INITRD
Message-ID: <20220209133447.GB11741@alpha.franken.de>
References: <20220208191726.1304731-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208191726.1304731-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 12:17:26PM -0700, Nathan Chancellor wrote:
> This configuration is useful for boot testing malta_defconfig in QEMU
> with just a simple cpio initrd, instead of a full ext4 rootfs.
> 
> This results in an increase of ~164KB of vmlinux (with GCC 11.2.0):
> 
> $ diskus vmlinux.before
> 11.19 MB (11,194,368 bytes)
> 
> $ diskus vmlinux.after
> 11.36 MB (11,358,208 bytes)
> 
> This size increase comes from the fact that usr/Kconfig is sourced when
> CONFIG_BLK_DEV_INITRD is enabled, which defaults to supporting several
> decompression algorithms for compressed initrds. This seems like a
> reasonable tradeoff but these configurations could be disabled in the
> future if there are complaints about the size increase.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/mips/configs/malta_defconfig | 1 +
>  1 file changed, 1 insertion(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
