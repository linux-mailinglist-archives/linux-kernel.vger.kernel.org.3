Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A354B570
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiFNQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiFNQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C412E686
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B659B8198C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD2C3411B;
        Tue, 14 Jun 2022 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655222861;
        bh=5gCD2JV3ZWghhc9U/yO/bwiUMMhro8fX8j1C1mvpog4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psYJcwvzb2tgDUrgQ6HL5O5fXbV8qrcIzokWzqxkSSHRXCwTk9y2nR0kQhzRBFOeI
         6p9SUqrwwvyIJMzTK69iVbveHGJ/UmB6vK9kSmGo6XIGeaZoJCQAE7mnEi8X4J+PR5
         Tjs6LwWKjg/DU/mh66zg9esOwro5OodpgIJFR6RU=
Date:   Tue, 14 Jun 2022 18:07:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] node: put_device after failing to device_register
Message-ID: <YqiyS0iYOCw0gycN@kroah.com>
References: <20220614160059.1739862-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614160059.1739862-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:00:59AM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> We need to call put_device() to give up the reference initialized
> in device_register() when it returns an error and this will clean
> up correctly.
> 
> Signed-off-by: Zhi Song <zhi.song@bytedance.com>
> ---
>  drivers/base/node.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ac6376ef7a1..88a3337c546e 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -154,6 +154,7 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
>  	list_add_tail(&access_node->list_node, &node->access_list);
>  	return access_node;
>  free_name:
> +	put_device(dev);
>  	kfree_const(dev->kobj.name);
>  free:
>  	kfree(access_node);
> -- 
> 2.30.2
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
