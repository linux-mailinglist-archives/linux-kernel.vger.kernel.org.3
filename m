Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D544B0443
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiBJELD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:11:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBJELB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B8E21EADC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644466262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fCleA6qk4g07f7l5mDTgk4q/YqeXJTxG07KlUJFIXY=;
        b=NiPAra9F5mw97nImLqIAuYA7ww9xdxagl2EiJAr2aY1YI7/Te/HBaj0ETpp5LmzjZdTUjI
        NxEuUoaqqcvA5xmUbmNi4opkrJ+I4CWa/kbCyl3SHj9vS/ptvTNuBJV/T3N8DGFY93wg23
        R0WS0jM8El95d2EtMwT4SeD9Wx98jy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-ZCkri3ABOoyGNZYGNhub1Q-1; Wed, 09 Feb 2022 23:10:59 -0500
X-MC-Unique: ZCkri3ABOoyGNZYGNhub1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9658D15720;
        Thu, 10 Feb 2022 04:10:58 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E9875E26B;
        Thu, 10 Feb 2022 04:10:24 +0000 (UTC)
Date:   Thu, 10 Feb 2022 12:10:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] irq: consider cpus on nodes are unbalanced
Message-ID: <YgSQKvv7rL6MFPRr@T590>
References: <20220210031053.5352-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210031053.5352-1-yamamoto.rei@jp.fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:10:53PM +0900, Rei Yamamoto wrote:
> If cpus on a node are offline at boot time, there are
> difference in the number of nodes between when building affinity
> masks for present cpus and when building affinity masks for possible
> cpus. This patch fixes a problem caused by the difference of the
> number of nodes:
> 
>  - The routine of "numvecs <= nodes" condition can overwrite bits of
>    masks for present cpus in building masks for possible cpus. Fix this
>    problem by making CPU bits, which is not target, not changing.
> 
> Signed-off-by: Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>  kernel/irq/affinity.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f7ff8919dc9b..d2d01565d2ec 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -269,8 +269,9 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  	 */
>  	if (numvecs <= nodes) {
>  		for_each_node_mask(n, nodemsk) {
> +			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
>  			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
> -				   node_to_cpumask[n]);
> +				   nmsk);
>  			if (++curvec == last_affv)
>  				curvec = firstvec;
>  		}
> -- 
> 2.27.0
> 

-- 
Ming

