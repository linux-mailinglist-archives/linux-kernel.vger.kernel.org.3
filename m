Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA94D8ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiCNR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiCNR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:29:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28529BF73;
        Mon, 14 Mar 2022 10:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE6FAB80E84;
        Mon, 14 Mar 2022 17:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B47C340E9;
        Mon, 14 Mar 2022 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647278925;
        bh=4eD0cVEjg/hqa/+sA+6q+5ginR+jlqXMwv3B2EDkCA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjDW3ZznjOfTG+xMS5wEsbUxR+f8RYQTLTVeD14vejLpeUdjAdD4stPFEywHyoUnA
         YDvqx50aXw/Vw3wOH3N1Asv/tZ0kTac7t1Y6zDQYf34iB7WBhU2QGFkNOwhxRUxBLm
         dyf/LjA8ooEfyFubslh0lSpkrokIbpV274+EK0rI=
Date:   Mon, 14 Mar 2022 18:28:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] staging: fbtft: Consider type of init sequence
 values in fbtft_init_display()
Message-ID: <Yi97SaQdudVfKV9W@kroah.com>
References: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:34:14PM +0200, Andy Shevchenko wrote:
> In the fbtft_init_display() the init sequence is printed for
> the debug purposes. Unfortunately the current code doesn't take
> into account that values in the buffer are of the s16 type.
> 
> Consider that and replace the printing code with fbtft_par_dbg_hex()
> call.
> 
> Fixes: b888897014a9 ("staging/fbtft: Remove all strcpy() uses")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 4a35347b3020..b28a059ad3b4 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -1035,10 +1035,9 @@ int fbtft_init_display(struct fbtft_par *par)
>  			for (j = 0; par->init_sequence[i + 1 + j] >= 0; j++)
>  				;
>  
> -			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
> -				      "init: write(0x%02X) %*ph\n",
> -				      par->init_sequence[i], j,
> -				      &par->init_sequence[i + 1]);
> +			fbtft_par_dbg_hex(DEBUG_INIT_DISPLAY, par, par->info->device,
> +					  s16, &par->init_sequence[i + 1], j,
> +					  "init: write(0x%02X)", par->init_sequence[i]);
>  
>  			/* Write */
>  			j = 0;
> -- 
> 2.34.1
> 
> 

Any reason you didn't test build this?

drivers/staging/fbtft/fbtft-core.c: In function ‘fbtft_init_display’:
drivers/staging/fbtft/fbtft-core.c:1038:48: error: passing argument 3 of ‘fbtft_dbg_hex’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 1038 |                                           s16, &par->init_sequence[i + 1], j,
      |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/fbtft/fbtft.h:441:50: note: in definition of macro ‘fbtft_par_dbg_hex’
  441 |                 fbtft_dbg_hex(dev, sizeof(type), buf,\
      |                                                  ^~~
drivers/staging/fbtft/fbtft-core.c:52:26: note: expected ‘void *’ but argument is of type ‘const s16 *’ {aka ‘const short int *’}
   52 |                    void *buf, size_t len, const char *fmt, ...)
      |                    ~~~~~~^~~
  LD [M]  drivers/staging/gdm724x/gdmulte.o
cc1: all warnings being treated as errors
