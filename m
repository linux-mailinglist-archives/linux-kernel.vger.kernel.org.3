Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066B56AA2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiGGSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiGGSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:03:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6113F42
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0CFFB822B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A9FC3411E;
        Thu,  7 Jul 2022 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657217031;
        bh=YTOqB/8FxwvlqtWnARAcuLIVsG4UYRMnlekWFIwq8WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/dxfjIluD71YR+nClvJvjYz2RtGhcImUZUUNM7NguOlod0qfr+xcMoJ6rTP1wO1O
         cZwIfLlxpfXW0nfIX6fzdOhjotjfqOY6dg2HcMJX+6uSg7pPHieqKWdQzdG4Obn8I2
         8ib2fW/l2vFJwQce0xY6PYBgmClo3C8IuXHHwDZiQXP9LPke8Lu7lUV58BaJHPMEDW
         dTes073NMPcIJVgKupAOdxK35UK98YxyMp3rUdSZc7zAJLNs3/13bg3e9SHc2JuaAc
         Tn71qpOITcTIue4b8Ea5fzwr7plwCl2FW26vaZmiraVwoQOcVycw8S6UywaQ4Q1sfm
         YgSIzh/8GOqPA==
Date:   Thu, 7 Jul 2022 11:03:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] eeprom: idt_89hpesx: fix clang -Wformat warnings
Message-ID: <YscgBZuT5/GVLdIs@dev-arch.thelio-3990X>
References: <20220701232031.2639134-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701232031.2639134-1-justinstitt@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 04:20:31PM -0700, Justin Stitt wrote:
> see warnings:
> | drivers/misc/eeprom/idt_89hpesx.c:570:5: error: format specifies type
> | 'unsigned char' but the argument has type 'u16' (aka 'unsigned short')
> | [-Werror,-Wformat] memaddr);
> -
> | drivers/misc/eeprom/idt_89hpesx.c:579:5: error: format specifies type
> | 'unsigned char' but the argument has type 'u16' (aka 'unsigned short')
> | [-Werror,-Wformat] memaddr);
> -
> | drivers/misc/eeprom/idt_89hpesx.c:814:4: error: format specifies type
> | 'unsigned short' but the argument has type 'unsigned int'
> | [-Werror,-Wformat] CSR_REAL_ADDR(csraddr));
> 
> There's an ongoing movement to eventually enable the -Wformat flag for
> clang. See: https://github.com/ClangBuiltLinux/linux/issues/378
> 
> The format specifier for idt_89hpesx.c:570 and 579 was `0x%02hhx`. The
> part we care about `%hhx` describes a single byte format, wherein the
> leftmost byte of our u16 type (of which memaddr is) is truncated.
> 
> example:
> ```
> uint16_t x = 0xbabe;
> printf("%hhx\n", x);
> // output is: be
> // we lost 'ba'
> ```
> 
> There exists a similar issue at idt_89hpesx.c:814 which involves the
> CSR_REAL_ADDR macro. This macro returns a u16 but due to default
> argument promotion for variadic functions (printf-like) actually
> provides an int to the dev_err method.
> 
> My proposed solution is to expand the width of the format specifier to
> fully encompass the provided argument (which is promoted to an int, see
> below). I opted for '%x' as this specifies an unsigned hexadecimal
> integer which, with a guarantee, can represent all the values of a u16.

Additionally, this solution is in line with printk-formats.rst after
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]").

> As per C11 6.3.1.1:
> (https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf)
> `If an int can represent all values of the original type ..., the
> value is converted to an int; otherwise, it is converted to an
> unsigned int. These are called the integer promotions.`
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index b0cff4b152da..42eac114edd7 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -566,7 +566,7 @@ static int idt_eeprom_read_byte(struct idt_89hpesx_dev *pdev, u16 memaddr,
>  		eeseq.memaddr = cpu_to_le16(memaddr);
>  		ret = pdev->smb_write(pdev, &smbseq);
>  		if (ret != 0) {
> -			dev_err(dev, "Failed to init eeprom addr 0x%02hhx",
> +			dev_err(dev, "Failed to init eeprom addr 0x%02x",
>  				memaddr);
>  			break;
>  		}
> @@ -575,7 +575,7 @@ static int idt_eeprom_read_byte(struct idt_89hpesx_dev *pdev, u16 memaddr,
>  		smbseq.bytecnt = EEPROM_RD_CNT;
>  		ret = pdev->smb_read(pdev, &smbseq);
>  		if (ret != 0) {
> -			dev_err(dev, "Failed to read eeprom data 0x%02hhx",
> +			dev_err(dev, "Failed to read eeprom data 0x%02x",
>  				memaddr);
>  			break;
>  		}
> @@ -810,7 +810,7 @@ static int idt_csr_read(struct idt_89hpesx_dev *pdev, u16 csraddr, u32 *data)
>  	smbseq.bytecnt = CSR_RD_CNT;
>  	ret = pdev->smb_read(pdev, &smbseq);
>  	if (ret != 0) {
> -		dev_err(dev, "Failed to read csr 0x%04hx",
> +		dev_err(dev, "Failed to read csr 0x%04x",
>  			CSR_REAL_ADDR(csraddr));
>  		goto err_mutex_unlock;
>  	}
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
