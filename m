Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD35478F5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiFLE5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLE5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C219C32
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5CE60A5A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46F3C34115;
        Sun, 12 Jun 2022 04:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655009821;
        bh=6n7SpCFndiSPCmzPBF8JaXynaNVK28eEuvgyLIxMrUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9eFDnF98RsRAaGn5eNwM9ngABujmBcqHzCxb4p8c0yHku2dmwTCmdHM9JElvKFes
         TvIItOeBsBr2ckU4iJk4vYvLcJRi7zVtLkABUXqTiWmbvuJaorozYqEXMzvwcJ4n7Q
         EuX/zBCWhF53xEWCnQ++l6tMWaxhY9QpJD6DOs5c=
Date:   Sun, 12 Jun 2022 06:56:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: simplify some macros
Message-ID: <YqVyGuACfuroV5ti@kroah.com>
References: <cover.1654994517.git.namcaov@gmail.com>
 <a3438e13cf2c117ad74432cdca4be97e731e9b21.1654994517.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3438e13cf2c117ad74432cdca4be97e731e9b21.1654994517.git.namcaov@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 03:05:13AM +0200, Nam Cao wrote:
> There are some macros which are not really useful, but make the code
> harder to read. Replace these with clearer codes.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  .../r8188eu/include/Hal8188ERateAdaptive.h    | 10 +++---
>  drivers/staging/r8188eu/include/basic_types.h | 31 -------------------
>  2 files changed, 5 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> index 20d73ca781e8..79e4210c6b65 100644
> --- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> +++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
> @@ -26,15 +26,15 @@
>  #define GET_TX_REPORT_TYPE1_RERTY_0(__paddr)			\
>  	le16_get_bits(*(__le16 *)__paddr, GENMASK(15, 0))
>  #define GET_TX_REPORT_TYPE1_RERTY_1(__paddr)			\
> -	LE_BITS_TO_1BYTE(__paddr + 2, 0, 8)
> +	((u8 *)__paddr)[2]
>  #define GET_TX_REPORT_TYPE1_RERTY_2(__paddr)			\
> -	LE_BITS_TO_1BYTE(__paddr + 3, 0, 8)
> +	((u8 *)__paddr)[3]
>  #define GET_TX_REPORT_TYPE1_RERTY_3(__paddr)			\
> -	LE_BITS_TO_1BYTE(__paddr + 4, 0, 8)
> +	((u8 *)__paddr)[4]
>  #define GET_TX_REPORT_TYPE1_RERTY_4(__paddr)			\
> -	LE_BITS_TO_1BYTE(__paddr + 5, 0, 8)
> +	((u8 *)__paddr)[5]
>  #define GET_TX_REPORT_TYPE1_DROP_0(__paddr)			\
> -	LE_BITS_TO_1BYTE(__paddr + 6, 0, 8)
> +	((u8 *)__paddr)[6]
>  /*  End rate adaptive define */
>  
>  int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm);
> diff --git a/drivers/staging/r8188eu/include/basic_types.h b/drivers/staging/r8188eu/include/basic_types.h
> index ffb21170e898..c4b08fb82200 100644
> --- a/drivers/staging/r8188eu/include/basic_types.h
> +++ b/drivers/staging/r8188eu/include/basic_types.h
> @@ -15,37 +15,6 @@ typedef void (*proc_t)(void *);
>  /*  TODO: Macros Below are Sync from SD7-Driver. It is necessary
>   * to check correctness */
>  
> -/*
> - *	Call endian free function when
> - *		1. Read/write packet content.
> - *		2. Before write integer to IO.
> - *		3. After read integer from IO.
> -*/
> -
> -/* Convert little data endian to host ordering */
> -#define EF1BYTE(_val)		\
> -	((u8)(_val))
> -
> -/* Create a bit mask  */
> -#define BIT_LEN_MASK_8(__bitlen) \
> -	(0xFF >> (8 - (__bitlen)))
> -
> -/*Description:
> - * Return 4-byte value in host byte ordering from
> - * 4-byte pointer in little-endian system.
> - */
> -#define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
> -	(EF1BYTE(*((u8 *)(__pstart))))
> -
> -/*Description:
> -Translate subfield (continuous bits in little-endian) of 4-byte
> -value to host byte ordering.*/
> -#define LE_BITS_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
> -	( \
> -		(LE_P1BYTE_TO_HOST_1BYTE(__pstart) >> (__bitoffset)) & \
> -		BIT_LEN_MASK_8(__bitlen) \
> -	)
> -
>  #define	N_BYTE_ALIGMENT(__value, __aligment) ((__aligment == 1) ? \
>  	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
>  
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
