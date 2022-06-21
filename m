Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F9552B70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbiFUHES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiFUHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F821250
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9D7D612F5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43429C3411D;
        Tue, 21 Jun 2022 07:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655795055;
        bh=kHTXC3AzY4zPOVxPRYVqw1oMnvlKWb2xzZuc6Wb0U6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fq8WEJQGUDeniIX0uaeTrPRD1rkHGfuRXq0DsjmqsQt8T8F50uy8KRwpK63J9AxVZ
         GFVkukF+V5bb10FXZ8Q7ipvFsZY/Tg0+rcOjFKNL21KPpGWsRpf7YRU+CUcuEq+cvk
         hyRkNeCWI3hGxxPe6Bwn+TSggkhiXpxYCpkz9hmoU5Khn82g6Jhj1iU9Yq/XUVA4dr
         9vuAc91rwecXa96HqTo5TXAxfNnjAGR9LRYwyFOc4oPqXZg7DUT6KoJIIwco4/7AY4
         NgtFgbXvXVnr1sGsGnI8dHSFnmswCb9DbHkQq4odQ+Ei16FKQK0JrcgTPmLjQ/hWZj
         hWU8UOXgxrHlA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3Xvl-0002RG-3W; Tue, 21 Jun 2022 09:04:09 +0200
Date:   Tue, 21 Jun 2022 09:04:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?5pm65a6L?= <zhi.song@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] node: put_device after failing to device_register
Message-ID: <YrFtaZedCOwSyOof@hovoldconsulting.com>
References: <20220615151738.1766206-1-zhi.song@bytedance.com>
 <YrB8bIJj3fvvsCHg@hovoldconsulting.com>
 <1D7A6F9F-9069-4D87-A493-7DB1BDA1EDB4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D7A6F9F-9069-4D87-A493-7DB1BDA1EDB4@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 01:28:33AM +0800, 智宋 wrote:
> > On Jun 20, 2022, at 21:55, Johan Hovold <johan@kernel.org> wrote:
> > On Wed, Jun 15, 2022 at 11:17:38PM +0800, Zhi Song wrote:
> >> device_register() is used to register a device with the system.
> >> We need to call put_device() to give up the reference initialized
> >> in device_register() when it returns an error and this will clean
> >> up correctly.

> >> diff --git a/drivers/base/node.c b/drivers/base/node.c
> >> index 0ac6376ef7a1..88a3337c546e 100644
> >> --- a/drivers/base/node.c
> >> +++ b/drivers/base/node.c
> >> @@ -154,6 +154,7 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
> >> 	list_add_tail(&access_node->list_node, &node->access_list);
> >> 	return access_node;
> >> free_name:
> >> +	put_device(dev);
> >> 	kfree_const(dev->kobj.name);
> > 
> > That's a pretty obvious use-after-free you just added here. You can't
> > access dev after you've just freed it.
> > 
> > The name is freed along with the rest of the struct device so you need
> > to remove the second explicit free. And you should rename the label too.
> > 
> >> free:
> >> 	kfree(access_node);
> > 
> > But here's another use after free... The put_device() call you added
> > will have freed access_node by calling node_access_release().

> put_device will free kobj.name at kobject_put => kref_put => 
> kobject_release => kobject_cleanup => kfree_const(name) 
> and free access_node at kobject_put => kref_put => kobject_release 
> => kobject_cleanup => t->release(kobj).  (The value of t->release is 
> device_release, it will invoke dev->release that is node_access_release)
> 
> If name is not set, kfree_const (name) won’t be invoked in kobject_cleanup.

Right.

> If we fail to invoke dev_set_name or device_register, we just need 
> to invoke put_device(dev) which will process free name, free access_node 
> and other jobs.
> 
> Therefore, the proper code would be this: 
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -144,20 +144,14 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
>         dev->parent = &node->dev;
>         dev->release = node_access_release;
>         dev->groups = node_access_node_groups;
> -       if (dev_set_name(dev, "access%u", access))
> +       if (dev_set_name(dev, "access%u", access) && device_register(dev))
>                 goto free;
>  
> -       if (device_register(dev))
> -               goto free_name;
> -
>         pm_runtime_no_callbacks(dev);
>         list_add_tail(&access_node->list_node, &node->access_list);
>         return access_node;
> -free_name:
> -       put_device(dev);
> -       kfree_const(dev->kobj.name);
>  free:
> -       kfree(access_node);
> +       put_device(dev);
>         return NULL;
>  }
> 
> The only put_device is enough. Is it correct?

I'm afraid not. You can only call put_device() after the struct device
has been initialised by device_initialize(), which is done in
device_register(), so you need to restructure the error handling
somewhat.

Johan
