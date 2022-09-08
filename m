Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB55B16AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiIHIQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiIHIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:16:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A29B7EFB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87A27B8204C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13CDC433D6;
        Thu,  8 Sep 2022 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662624980;
        bh=DOujSj518pTDqCW8cJ1ggvFcLqk5w9OFQjxBCzgVe1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPQ1KfrGrPpprzueD6oFyqiCYaHKw6DA7Sg33wm6AFOB5TscrMEpK48Qo+SjenSCT
         uHIaj/RT60pqJH2K66OCY64ARDYtbCNTNFff+Exgf+Bx/BcFRujx61S0dRgSvsBnlx
         a+PnsviNCT0wuW+tc/NlqIxeOYv0slqO+qWBKGEU=
Date:   Thu, 8 Sep 2022 10:16:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     jirislaby@kernel.org, changlianzhi@uniontech.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: add a bounds checking in vt_do_kdgkb_ioctl()
Message-ID: <Yxmk0eb+mkE2kxnY@kroah.com>
References: <20220908075403.27930-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908075403.27930-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:54:03PM +0800, Hangyu Hua wrote:
> As array_index_nospec's comments indicate，a bounds checking need to add
> before calling array_index_nospec.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index be8313cdbac3..b9845455df79 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2067,6 +2067,9 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  	if (get_user(kb_func, &user_kdgkb->kb_func))
>  		return -EFAULT;
>  
> +	if (kb_func >= MAX_NR_FUNC)
> +		return -EFAULT;

Wrong error to return, only ever return that error if you have a memory
fault from copy_to/from_user().

But even then, how can kb_func ever be greater than MAX_NR_FUNC?  And
what is wrong with it being MAX_NR_FUNC?

> +
>  	kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);

Maybe we really don't need this at all, right?

thanks,

greg k-h
