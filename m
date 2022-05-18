Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCA52C211
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiERSMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiERSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:12:16 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6396833C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:12:15 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id C66A02086D;
        Wed, 18 May 2022 18:12:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 42ABB6000E;
        Wed, 18 May 2022 18:12:12 +0000 (UTC)
Message-ID: <f0acebb66b9b46ad472e0d0989dc0f5810cac3dd.camel@perches.com>
Subject: Re: [PATCH -next v2 6/6] nbd: use pr_err to output error message
From:   Joe Perches <joe@perches.com>
To:     Yu Kuai <yukuai3@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Date:   Wed, 18 May 2022 11:12:11 -0700
In-Reply-To: <20220518122618.1702997-7-yukuai3@huawei.com>
References: <20220518122618.1702997-1-yukuai3@huawei.com>
         <20220518122618.1702997-7-yukuai3@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: w4co9fngahnb146d6hsxcz85b1hfpa7z
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 42ABB6000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19oEFmBk8xUFTV8bdFQZy9WR91s/9xDnsE=
X-HE-Tag: 1652897532-761824
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-18 at 20:26 +0800, Yu Kuai wrote:
> Instead of using the long printk(KERN_ERR "nbd: ...") to
> output error message, defining pr_fmt and using
> the short pr_err("") to do that. The replacemen is done
> by using the following command:
> 
>   sed -i 's/printk(KERN_ERR "nbd: /pr_err("/g' \
> 		  drivers/block/nbd.c

It's also good to rewrap to 80 columns where possible.

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
[]
> @@ -2130,13 +2130,13 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>  	nbd = idr_find(&nbd_index_idr, index);
>  	if (!nbd) {
>  		mutex_unlock(&nbd_index_mutex);
> -		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
> +		pr_err("couldn't find device at index %d\n",
>  		       index);

like here

>  		return -EINVAL;
>  	}
>  	if (!refcount_inc_not_zero(&nbd->refs)) {
>  		mutex_unlock(&nbd_index_mutex);
> -		printk(KERN_ERR "nbd: device at index %d is going down\n",
> +		pr_err("device at index %d is going down\n",
>  		       index);

and here and below...

> @@ -2170,7 +2170,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>  	nbd = idr_find(&nbd_index_idr, index);
>  	if (!nbd) {
>  		mutex_unlock(&nbd_index_mutex);
> -		printk(KERN_ERR "nbd: couldn't find a device at index %d\n",
> +		pr_err("couldn't find a device at index %d\n",
>  		       index);
>  		return -EINVAL;
>  	}
> @@ -2192,7 +2192,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>  	}
>  	if (!refcount_inc_not_zero(&nbd->refs)) {
>  		mutex_unlock(&nbd_index_mutex);
> -		printk(KERN_ERR "nbd: device at index %d is going down\n",
> +		pr_err("device at index %d is going down\n",
>  		       index);
>  		return -EINVAL;
>  	}


