Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957E8553197
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbiFUMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350297AbiFUMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:03:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A02AE0A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 865D0B8175F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C353C3411C;
        Tue, 21 Jun 2022 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655813016;
        bh=x0F8lQOWpfyP6V0sr7PF7lDJooRfhL/Hx6J8uYMt0yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4tvklvjUzFvOF906LQj+6uhge9ejd2hL+BDBvEOkG8gNJSW/iAEmc/auhdaqnZjt
         g5VhIzxt2L7krqpoxN/5TGWAmiH8ImDTP/yfASWx2BJ5p7Ia3NlnhY/yad++YpEHY6
         ElKC+TfhCa9oqzra6++kW84uCgH20CwFR0oMxROfkykUnln30GHOpAo0mJn+DUy/d3
         7CeACcrofZ8DFulkNfJNFyu4LksvAeDrL4dXtrLePmHqGkCubjLD0Fj0u4AchKp8t/
         bazZ+7U5rpoPmyuW14r1CLqXzHqoAXl4oyMsJlR59WMfhZnNY5vt0hWPAUwgAqfMQD
         h0OH/aZ68X9ew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3cbS-0006Bu-Ex; Tue, 21 Jun 2022 14:03:30 +0200
Date:   Tue, 21 Jun 2022 14:03:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?5pm65a6L?= <zhi.song@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] node: put_device after failing to device_register
Message-ID: <YrGzkuFtna+blmA6@hovoldconsulting.com>
References: <20220615151738.1766206-1-zhi.song@bytedance.com>
 <YrB8bIJj3fvvsCHg@hovoldconsulting.com>
 <C6760D95-B26F-47AE-A8F6-F80129135A6C@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6760D95-B26F-47AE-A8F6-F80129135A6C@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 06:17:22PM +0800, 智宋 wrote:
> > On Jun 20, 2022, at 21:55, Johan Hovold <johan@kernel.org> wrote:

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

> dev_set_name() allocates new space to dev->name and assigns the address of space to dev->name if it allocates successfully. But if we fail to allocate space, there isn’t any new space for dev->name. Therefore, there’s no need for calling kfree_const(dev->kobj.name) in dev_set_name()’s error handling.

Note that your mails are being rejected by the mailing list since they
include HTML. Can you see if you can fix your mail client to send as
text instead?

That may fix lack line breaks too (break lines at 72 columns or so).
 
> If we fail to do device_register(dev), we just need to put_device(dev) which will do free access_node, kobj.name and other cleanup.
> 
> Maybe the code is: 
> 
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -144,21 +144,19 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
>         dev->parent = &node->dev;
>         dev->release = node_access_release;
>         dev->groups = node_access_node_groups;
> -       if (dev_set_name(dev, "access%u", access))
> -               goto free;
> +       if (dev_set_name(dev, "access%u", access)) {
> +               kfree(access_node);
> +               return NULL;
> +       }
>  
> -       if (device_register(dev))
> -               goto free_name;
> +       if (device_register(dev)) {
> +               put_device(dev);
> +               return NULL;
> +       }
>  
>         pm_runtime_no_callbacks(dev);
>         list_add_tail(&access_node->list_node, &node->access_list);
>         return access_node;
> -free_name:
> -       put_device(dev);
> -       kfree_const(dev->kobj.name);
> -free:
> -       kfree(access_node);
> -       return NULL;
>  }

The above fix looks correct now.

> Thanks for your patience. :)

You're welcome. Thanks for finding and fixing the bug.

Johan
