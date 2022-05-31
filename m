Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382E5538D02
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiEaIip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244937AbiEaIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:38:40 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60F6339A;
        Tue, 31 May 2022 01:38:28 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4LC5Jv4Wfkz9sTd;
        Tue, 31 May 2022 10:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.msdigital.de;
        s=MBO0001; t=1653986303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlLwFIVR/fLL8FKR1FZXvk/wLP3oPC0CsS041Mp0NLg=;
        b=ec0zv5uYyNG/EkJXF3A7kB5BQRLt91zjL3Esia32991FBzYQBz8/E9QYo1AqX5pdG4VmoD
        5E097DpYOd8N3wJEDb4MRp7oxxtDIPYFtYQKtTp/UYK2ZrX1EnavhnAVQncwWpGaiYKVu1
        5tkqCMOfytFrUs5qK98pvYUjR7UkE3T4QnhN86ImrnjnZ0b75ZAmcz24c8P22QtZzcGzb8
        2qak/3nStWCicp+Roo9lwWyKze/oG1cABphI4WOdMFulugvH9MpVIrfu76P2ouE9wGhhRP
        oFIl6ymGjzJFHdBLJiCpa0zSyBOOhKjfX7O/fX+aMWAKVAVs+LECxojJBYtKew==
Message-ID: <689d5b9d-3d1e-75be-ea0d-250e16b6d85c@mail.msdigital.de>
Date:   Tue, 31 May 2022 10:38:21 +0200
MIME-Version: 1.0
Subject: Re: PROBLEM: No static MAC address for usb gadget ethernet via kernel
 parameter any more.
Content-Language: de-DE
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
 <6c0eb462-3fab-473d-8989-b56e5748e5f7@mutex.one>
 <83b013eb-b320-f397-0ecc-f4824f3f45b9@msdigital.de>
 <874k1htj8b.fsf@mutex.one>
 <5ad210a8-a834-607e-351c-83ff23e23f5a@mail.msdigital.de>
 <87tu9cpyv6.fsf@mutex.one>
From:   Maximilian Senftleben <kernel@mail.msdigital.de>
In-Reply-To: <87tu9cpyv6.fsf@mutex.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4LC5Jv4Wfkz9sTd
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just tested, the fix works for me.

Am 26.05.2022 um 08:54 schrieb Marian Postevca:
> Could you test if this patch fixes the issue for you?
> Should apply without problems on kernel 5.17.
> ---
>   drivers/usb/gadget/function/u_ether.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 6f5d45ef2e39a..b5bf51cdc3c8f 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -775,9 +775,14 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
>   	dev->qmult = qmult;
>   	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>   
> -	if (get_ether_addr(dev_addr, addr))
> +	if (get_ether_addr(dev_addr, addr)) {
> +		net->addr_assign_type = NET_ADDR_RANDOM;
>   		dev_warn(&g->dev,
>   			"using random %s ethernet address\n", "self");
> +	}
> +	else {
> +		net->addr_assign_type = NET_ADDR_SET;
> +	}
>   	eth_hw_addr_set(net, addr);
>   	if (get_ether_addr(host_addr, dev->host_mac))
>   		dev_warn(&g->dev,
> @@ -835,6 +840,9 @@ struct net_device *gether_setup_name_default(const char *netname)
>   	INIT_LIST_HEAD(&dev->tx_reqs);
>   	INIT_LIST_HEAD(&dev->rx_reqs);
>   
> +	/* by default we always have a random MAC address */
> +	net->addr_assign_type = NET_ADDR_RANDOM;
> +
>   	skb_queue_head_init(&dev->rx_frames);
>   
>   	/* network device setup */
> @@ -871,7 +879,6 @@ int gether_register_netdev(struct net_device *net)
>   	dev = netdev_priv(net);
>   	g = dev->gadget;
>   
> -	net->addr_assign_type = NET_ADDR_RANDOM;
>   	eth_hw_addr_set(net, dev->dev_mac);
>   
>   	status = register_netdev(net);
> @@ -912,6 +919,7 @@ int gether_set_dev_addr(struct net_device *net, const char *dev_addr)
>   	if (get_ether_addr(dev_addr, new_addr))
>   		return -EINVAL;
>   	memcpy(dev->dev_mac, new_addr, ETH_ALEN);
> +	net->addr_assign_type = NET_ADDR_SET;
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(gether_set_dev_addr);
