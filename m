Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891A750270C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbiDOIvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiDOIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DE089F6F7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650012540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZL74iZG7RWeRqPE6lEKycuxieaWdZqnT1Xtw1tATKRc=;
        b=LcPQKzD5uC1ZlDHfaQPYKXITguEzMae762YQANW0TZNjJKkrr+r1CoIcQcRH5DJeEcfjVJ
        mkXmukN6KnTFdFW+t+IwbQNaTarEcerHmOObnMbSzj+AqUDp5+nYDKqCwVaA0Ro3yw90+O
        sz981GF6+rSJLjtqL3mrijcv0l6lI4I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-Rttbr6GJPGi2ZFEExTLBUg-1; Fri, 15 Apr 2022 04:48:59 -0400
X-MC-Unique: Rttbr6GJPGi2ZFEExTLBUg-1
Received: by mail-wm1-f71.google.com with SMTP id g9-20020a1c4e09000000b0038f20d94f01so3579806wmh.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZL74iZG7RWeRqPE6lEKycuxieaWdZqnT1Xtw1tATKRc=;
        b=EvIOxZV3AVIXZAP50/PhJ5sB5U2+Z7gvJpearO0U/YpOixPmxMns3CAbDJ6cr1FDOB
         5esf0lX0PPNP0gfQk8LjuQpzwrja7DgdFaMpAnYllbWP7rt3+o1oSdOWDOkVHHA9c7qD
         ulARkr/nb7NoV1GjEv7tVHy6PUR4RzkazqqgqLG7XFY3p4gD9glypwlAWodyrusu20QW
         AmFNQ1MhpsHvREkD037tpnkOBx2GBcw/1lm7ISrVnjxiQfl/6J2hjpNUGB4WUY98O8kg
         0xFJXX4U4PTs1iRkDBAfn4mtt4KS/g6cMvTYKHxWn8yCatLlVxHvJ8ckSoTI4w0pKegM
         BmeA==
X-Gm-Message-State: AOAM5330ohnG1yAclBdekIa+cv+roe2YG2/zBsRaHdE0EcTnBNzoy1Ti
        YcwfeB8NAjMt/NgrrbnJ5VND/ZESiZ05Ov3I/wG4M5JbJ8/IPcx+Q9rjL9bjTlQ7GKgwoKNFkW9
        FGliU7luZd6WA5TGZcbn5pdsQ
X-Received: by 2002:a5d:5942:0:b0:207:9abd:792a with SMTP id e2-20020a5d5942000000b002079abd792amr4772289wri.118.1650012537837;
        Fri, 15 Apr 2022 01:48:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPBTR/5B6KGMYNKFUH2+unsto2dPt4f/qCZVO6aw/4RjmYeKlekMGG/1WSqNdH6ecXBzOV0g==
X-Received: by 2002:a5d:5942:0:b0:207:9abd:792a with SMTP id e2-20020a5d5942000000b002079abd792amr4772272wri.118.1650012537613;
        Fri, 15 Apr 2022 01:48:57 -0700 (PDT)
Received: from redhat.com ([2.53.138.98])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c2b87000000b0038e6a025d05sm4871569wmr.18.2022.04.15.01.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 01:48:56 -0700 (PDT)
Date:   Fri, 15 Apr 2022 04:48:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     trivial@kernel.org, Ben Segall <bsegall@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Subject: Re: [PATCH 3/3] virtio-pci: Use cpumask_available to fix compilation
 error
Message-ID: <20220415044657-mutt-send-email-mst@kernel.org>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-4-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220414150855.2407137-4-dinechin@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:08:55PM +0200, Christophe de Dinechin wrote:
> With GCC 12 and defconfig, we get the following error:
> 
> |   CC      drivers/virtio/virtio_pci_common.o
> | drivers/virtio/virtio_pci_common.c: In function ‘vp_del_vqs’:
> | drivers/virtio/virtio_pci_common.c:257:29: error: the comparison will
> |  always evaluate as ‘true’ for the pointer operand in
> |  ‘vp_dev->msix_affinity_masks + (sizetype)((long unsigned int)i * 8)’
> |  must not be NULL [-Werror=address]
> |   257 |                         if (vp_dev->msix_affinity_masks[i])
> |       |                             ^~~~~~
> 
> This happens in the case where CONFIG_CPUMASK_OFFSTACK is not defined,
> since we typedef cpumask_var_t as an array. The compiler is essentially
> complaining that an array pointer cannot be NULL. This is not a very
> important warning, but there is a function called cpumask_available that
> seems to be defined just for that case, so the fix is easy.
> 
> Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>

There was an alternate patch proposed for this by
Murilo Opsfelder Araujo. What do you think about that approach?


> ---
>  drivers/virtio/virtio_pci_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d724f676608b..5c44a2f13c93 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -254,7 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>  
>  	if (vp_dev->msix_affinity_masks) {
>  		for (i = 0; i < vp_dev->msix_vectors; i++)
> -			if (vp_dev->msix_affinity_masks[i])
> +			if (cpumask_available(vp_dev->msix_affinity_masks[i]))
>  				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>  	}
>  
> -- 
> 2.35.1

