Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1F478AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhLQMFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:05:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235463AbhLQME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639742698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFL0NA899+dl8pGdN4feSxlcWteEEodzpzVsgH67cyw=;
        b=ihuSN2jfH7ARH4nYSQhnojOuL7yaZKGVTxlaBcxmcUrNQTRI7qBOcObea6/FCA2gos+rBT
        beSEibRB6mtJcyUS7mfxlElYSRVKEETceRz97XOay9T8572xN1VGjIkyu10tc7o4KLwUXo
        rr6e1SKew7A2BGOnOTITjbsz5V0VIAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Wcy_ls16MjS0EoR9Rq_cKA-1; Fri, 17 Dec 2021 07:04:57 -0500
X-MC-Unique: Wcy_ls16MjS0EoR9Rq_cKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6173D2F24;
        Fri, 17 Dec 2021 12:04:55 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F8A47A541;
        Fri, 17 Dec 2021 12:04:35 +0000 (UTC)
Date:   Fri, 17 Dec 2021 20:04:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     tglx@linutronix.de, hch@lst.de, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH v2] irq: consider cpus on nodes are unbalanced
Message-ID: <Ybx8zqja/UoCzVO3@T590>
References: <20211217104407.2156-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217104407.2156-1-yamamoto.rei@jp.fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 07:44:07PM +0900, Rei Yamamoto wrote:
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

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

