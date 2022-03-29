Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30144EAFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbiC2OxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiC2OxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BD517E6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BBA3616BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF9CC2BBE4;
        Tue, 29 Mar 2022 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648565497;
        bh=+utyFpCgB9/BoZfxFp+h+l4laC2+NOLMzF+IdJYwTP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4kHok8yHdkFr6K/a5gMUvm7K4WOIU2IREt5YVihKQeWhdEWWSMwI5S9IFMRm84cO
         A5GBHZPg0MpglN5xKLlm/RSYWcunRovXo17h76l2krJbTMr7TjslCPf4HgCem4sGQG
         n3UME4DZXlUhD/9KhlApoJgk8SWEtWSuE0mEHvB0=
Date:   Tue, 29 Mar 2022 16:51:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: add necessary #include in
 sm750_accel.h, sm750_cursor.h
Message-ID: <YkMc9p4nd/4+2fkf@kroah.com>
References: <20220318165046.33745-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318165046.33745-1-namcaov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 05:50:46PM +0100, Nam Cao wrote:
> In sm750_cursor.h, struct lynx_cursor is used without including the
> header file where this struct is defined. Similar thing is seen in
> sm750_accel.h.
> 
> The module can still be compiled because there is "#include "sm750.h""
> before every "#include "sm750_accel.h"" and "#include "sm750_cursor.h"".
> However, the order of #include should not affect the ability to compile.
> 
> Add "#include "sm750.h"" to sm750_accel.h and sm750_cursor.h.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.h  | 2 ++
>  drivers/staging/sm750fb/sm750_cursor.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
> index 2c79cb730a0a..fe6ff196272c 100644
> --- a/drivers/staging/sm750fb/sm750_accel.h
> +++ b/drivers/staging/sm750fb/sm750_accel.h
> @@ -2,6 +2,8 @@
>  #ifndef ACCEL_H__
>  #define ACCEL_H__
>  
> +#include "sm750.h"
> +
>  #define HW_ROP2_COPY 0xc
>  #define HW_ROP2_XOR 0x6
>  
> diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
> index b59643dd61ed..f023b691ac0b 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.h
> +++ b/drivers/staging/sm750fb/sm750_cursor.h
> @@ -2,6 +2,8 @@
>  #ifndef LYNX_CURSOR_H__
>  #define LYNX_CURSOR_H__
>  
> +#include "sm750.h"
> +
>  /* hw_cursor_xxx works for voyager,718 and 750 */
>  void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
>  void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
> -- 
> 2.25.1
> 
> 

I think the current code is fine, given that this is not actually
"fixing" anything.  If you wish to unwind all of the #include mess in
this driver, that would be fine, but I doubt it really is worth it.  You
really should not need more than 1 .h file for a single module, this one
is split up way too much.

thanks,

greg k-h
