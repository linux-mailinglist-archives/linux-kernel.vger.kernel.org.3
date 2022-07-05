Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A05671AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiGEO64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiGEO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:58:54 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9614D03;
        Tue,  5 Jul 2022 07:58:53 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265E2Cef029805;
        Tue, 5 Jul 2022 14:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=cmapoeKIf7kKpMc7yVkcYev4UkKDulrpVjaHQttUP34=;
 b=gOHlT52gAnX1LmsbgZtj58vGlWNayNcm+fX8SWGQT12XWsbRplXrefyFko13bmXDCavq
 MvUSQGr0Y5CM13HJhtVbNhk7Ts/XI1cFkf6jhobazC4hoVIBNvh/NT9+6ROmy4ibpCIh
 Rp3kt9l0V8RsuMgcaEtx8dIY1GUHScJFhZRaKHOaddWRZkmdSVuRROoY90K9aXJsE+27
 wPpw1/sQWrTKjprMgxs3yjjew6vm8kzUMYSwQFKA+rNCHA4b/bqgfk5uzEBvXKBDznHc
 c6EvqAVtODkIuBm2/DPV8HtoMJ1ZIKaGkrvVUo+1vfq4FKitdv/l/ucMIZjG+BWKXfPR FQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3h4gf6mtxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 14:58:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8C91D800204;
        Tue,  5 Jul 2022 14:58:48 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 886FE800ECA;
        Tue,  5 Jul 2022 14:58:47 +0000 (UTC)
Date:   Tue, 5 Jul 2022 09:58:45 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] sgi-xp: Use the bitmap API to allocate bitmaps
Message-ID: <YsRRpQVyDF94mAuT@swahl-home.5wahls.com>
References: <ef49726d60f6a531428609f60a2398b6c3d9a26e.1656966181.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef49726d60f6a531428609f60a2398b6c3d9a26e.1656966181.git.christophe.jaillet@wanadoo.fr>
X-Proofpoint-GUID: 2YjXQjyKse1tUUtvoiIyKFAhUkBC2DNX
X-Proofpoint-ORIG-GUID: 2YjXQjyKse1tUUtvoiIyKFAhUkBC2DNX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=873
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207050064
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Mon, Jul 04, 2022 at 10:23:17PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> While at it, remove a useless cast in a bitmap_empty() call.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/sgi-xp/xpnet.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
> index 50644f83e78c..2396ba3b03bd 100644
> --- a/drivers/misc/sgi-xp/xpnet.c
> +++ b/drivers/misc/sgi-xp/xpnet.c
> @@ -285,7 +285,7 @@ xpnet_connection_activity(enum xp_retval reason, short partid, int channel,
>  		__clear_bit(partid, xpnet_broadcast_partitions);
>  		spin_unlock_bh(&xpnet_broadcast_lock);
>  
> -		if (bitmap_empty((unsigned long *)xpnet_broadcast_partitions,
> +		if (bitmap_empty(xpnet_broadcast_partitions,
>  				 xp_max_npartitions)) {
>  			netif_carrier_off(xpnet_device);
>  		}
> @@ -522,9 +522,8 @@ xpnet_init(void)
>  
>  	dev_info(xpnet, "registering network device %s\n", XPNET_DEVICE_NAME);
>  
> -	xpnet_broadcast_partitions = kcalloc(BITS_TO_LONGS(xp_max_npartitions),
> -					     sizeof(long),
> -					     GFP_KERNEL);
> +	xpnet_broadcast_partitions = bitmap_zalloc(xp_max_npartitions,
> +						   GFP_KERNEL);
>  	if (xpnet_broadcast_partitions == NULL)
>  		return -ENOMEM;
>  
> @@ -535,7 +534,7 @@ xpnet_init(void)
>  	xpnet_device = alloc_netdev(0, XPNET_DEVICE_NAME, NET_NAME_UNKNOWN,
>  				    ether_setup);
>  	if (xpnet_device == NULL) {
> -		kfree(xpnet_broadcast_partitions);
> +		bitmap_free(xpnet_broadcast_partitions);
>  		return -ENOMEM;
>  	}
>  
> @@ -574,7 +573,7 @@ xpnet_init(void)
>  	result = register_netdev(xpnet_device);
>  	if (result != 0) {
>  		free_netdev(xpnet_device);
> -		kfree(xpnet_broadcast_partitions);
> +		bitmap_free(xpnet_broadcast_partitions);
>  	}
>  
>  	return result;
> @@ -590,7 +589,7 @@ xpnet_exit(void)
>  
>  	unregister_netdev(xpnet_device);
>  	free_netdev(xpnet_device);
> -	kfree(xpnet_broadcast_partitions);
> +	bitmap_free(xpnet_broadcast_partitions);
>  }
>  
>  module_exit(xpnet_exit);
> -- 
> 2.34.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
