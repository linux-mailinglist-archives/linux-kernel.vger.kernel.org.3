Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C7551F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiFTOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbiFTOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD28C5C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F411F611D0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65199C3411B;
        Mon, 20 Jun 2022 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733360;
        bh=cNga3wLmI9V97jkEz2+oGgn7LYpWHhGgN0ZFwAqekGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2E5MXyeN1c1H6mn2i+PFZ2j4M7F90rw3bvAdwoHwHKUAUv+Wewug6e5LnnfjweS/
         BGRZc00cRYr05xktVVqRnqojDLmDg0MUCVWtpN5/9BF3mpsdwLzdQbubj0uH5eeu76
         3gGsvejs6UnYVkH7Qrbz5HrElLYNMkWer1V+kvMb+99XlF2Q7p/PFlXddvXLY6X4fX
         Ex/IbIvYoc3EN4nZ8/0EKcW2focxt8vYS2DkySTv0WT57IsI5g7AomWcnmlcvyhJ33
         FvIHidEmWqdfI86CVPVpwmGHTMtsBcfmmJBZcp+BWuXRpZpS7S4vrfDaer42Q4ekgs
         BEdmjDaPXNGvw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3Hsi-0001LT-BV; Mon, 20 Jun 2022 15:55:57 +0200
Date:   Mon, 20 Jun 2022 15:55:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] node: put_device after failing to device_register
Message-ID: <YrB8bIJj3fvvsCHg@hovoldconsulting.com>
References: <20220615151738.1766206-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615151738.1766206-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:17:38PM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> We need to call put_device() to give up the reference initialized
> in device_register() when it returns an error and this will clean
> up correctly.
> 
> Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
> Signed-off-by: Zhi Song <zhi.song@bytedance.com>
> ---
> V1 -> V2: Fix up the changelog text correct.
> V2 -> V3: Add a fixes tag line specifying the commit where this bug was
> introduced.
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

That's a pretty obvious use-after-free you just added here. You can't
access dev after you've just freed it.

The name is freed along with the rest of the struct device so you need
to remove the second explicit free. And you should rename the label too.

>  free:
>  	kfree(access_node);

But here's another use after free... The put_device() call you added
will have freed access_node by calling node_access_release().

Johan
