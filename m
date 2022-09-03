Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31235ABD77
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiICGdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiICGde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFCFB7779
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C24F60B2F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22C2C433D6;
        Sat,  3 Sep 2022 06:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662186812;
        bh=FLClP/CWYVB7U+G72MvxNuGbFWXAOpLmjXm5ZoyA6vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjHw+0/MjXvHwOTouWtGvy6gmAjwb5e8II4gKD8hDH9egGOQ/u5GSdGCxUyrcsBnL
         IfAE4LPvPLaoHXWB708NdPUVmcL/BzcKVVDudtMFOrSOKwtJ9vp7gcJDS3ey13Rx2p
         e+V/goiZZfJtAKgx8f+td7Bo1Z1bBIauRMwW0p2A=
Date:   Sat, 3 Sep 2022 08:33:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rafael@kernel.org
Subject: Re: [PATCH v1] drivers/base/auxiliary: check return value of
 strrchr()
Message-ID: <YxL1TprLv3wzr08u@kroah.com>
References: <CAMEuxRrg0nSroVGXwaCM1579Ddb822mY0hkSX5_Kcz1YqF_9sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEuxRrg0nSroVGXwaCM1579Ddb822mY0hkSX5_Kcz1YqF_9sg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:25:31PM -0700, Li Zhong wrote:
> From: Li Zhong <floridsleeves@gmail.com>
> 
> The return value of strrchr() could be NULL, which will cause invalid
> offset in (int)(p - name). So we check it here.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/base/auxiliary.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 8c5e65930617..7ac23be47e1f 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -191,7 +191,8 @@ static int auxiliary_uevent(struct device *dev,
> struct kobj_uevent_env *env)
> 
>   name = dev_name(dev);
>   p = strrchr(name, '.');
> -
> + if (!p)
> + return -EINVAL;
>   return add_uevent_var(env, "MODALIAS=%s%.*s", AUXILIARY_MODULE_PREFIX,
>         (int)(p - name), name);
>  }
> -- 
> 2.25.1

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
