Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA76513218
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiD1LKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345329AbiD1LJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 881F466FBD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651144003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOu5am8KOe0yhknijbWSc9nIgISI1EHhtzqNkNPo72Q=;
        b=cXYCUjrVQV2poKkZRipFWB7Q2oPad6PQCxXdAKYhf9w8/YEjGuM0FOf+hKp3gw4G5x+vLs
        af1HCaCuSOwl1OXuJkjuOX47sCqAoXUq0Zvfwbn5t3tlkKgBGJitpNAUuRJ8LYibvmRoKQ
        a8UaPmdpaRTAwSyC9MdELtnjYxwjFao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-gD4ryxZSOK2_IxP5UFUWKA-1; Thu, 28 Apr 2022 07:06:42 -0400
X-MC-Unique: gD4ryxZSOK2_IxP5UFUWKA-1
Received: by mail-wr1-f70.google.com with SMTP id w4-20020adfbac4000000b0020acba4b779so1795248wrg.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fOu5am8KOe0yhknijbWSc9nIgISI1EHhtzqNkNPo72Q=;
        b=lZdns8EgMPP414PC2XwmDKtIFrnEQbVOJf2+21H3aIlFX/4TTutQOwkDz0ymxOiuLz
         BR0XBOYOLCAXmHrsIFQWe08VJlXSWgnAEWkWhptNrJ7fhGrB5zh+ONV3KphRzVRUMn0e
         skV4IeHbkN8oLjas0kmSbkpj1E7fb4SvIHoKmXZeD/cDPPDtwoxpFrkUD3RS4eF3tviA
         Y1M3i20UjkSOf6kZ8JYiLKQB0ncqWDIpaHF7PpwsuZboC7lPIOmVUzpblnFU9C2oAKt7
         MbYnY1PecPA+WF11wOX3fB3XGYzi4maELYn6mpjhonKMri7iN8zok4cRvvWYQOQJL8vi
         2/zA==
X-Gm-Message-State: AOAM533vFSvciAKKzix2aM8jzIlOk3skBJrzjQmZHXxV70tzb7LfWXe5
        mYX645px633V+oI0V4WeWK+PjqgN/uHPw9MezD7j7KUamUyYCV5uRdPmzvtOO9GZ9xRqBBp7NKE
        9Yb23mSHiZoWLiPR05txuMscz
X-Received: by 2002:a1c:5459:0:b0:394:1191:a1ff with SMTP id p25-20020a1c5459000000b003941191a1ffmr2210275wmi.96.1651144000707;
        Thu, 28 Apr 2022 04:06:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEuh7RPsaIpF9AUu/qCwpZ+jPB//bHxmrpwyPaS8uUDyhj5LkvVK/8+RDdhQEUo0XlzAiVfg==
X-Received: by 2002:a1c:5459:0:b0:394:1191:a1ff with SMTP id p25-20020a1c5459000000b003941191a1ffmr2210246wmi.96.1651144000472;
        Thu, 28 Apr 2022 04:06:40 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b00393faf12859sm4258790wmi.18.2022.04.28.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:06:39 -0700 (PDT)
Date:   Thu, 28 Apr 2022 07:06:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>, trivial@kernel.org,
        Ben Segall <bsegall@google.com>,
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
Message-ID: <20220428070620-mutt-send-email-mst@kernel.org>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-4-dinechin@redhat.com>
 <20220415044657-mutt-send-email-mst@kernel.org>
 <3D264F7F-624D-4E9D-A139-F1DB0CC6045C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D264F7F-624D-4E9D-A139-F1DB0CC6045C@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:48:01AM +0200, Christophe Marie Francois Dupont de Dinechin wrote:
> 
> 
> > On 15 Apr 2022, at 10:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Thu, Apr 14, 2022 at 05:08:55PM +0200, Christophe de Dinechin wrote:
> >> With GCC 12 and defconfig, we get the following error:
> >> 
> >> |   CC      drivers/virtio/virtio_pci_common.o
> >> | drivers/virtio/virtio_pci_common.c: In function ‘vp_del_vqs’:
> >> | drivers/virtio/virtio_pci_common.c:257:29: error: the comparison will
> >> |  always evaluate as ‘true’ for the pointer operand in
> >> |  ‘vp_dev->msix_affinity_masks + (sizetype)((long unsigned int)i * 8)’
> >> |  must not be NULL [-Werror=address]
> >> |   257 |                         if (vp_dev->msix_affinity_masks[i])
> >> |       |                             ^~~~~~
> >> 
> >> This happens in the case where CONFIG_CPUMASK_OFFSTACK is not defined,
> >> since we typedef cpumask_var_t as an array. The compiler is essentially
> >> complaining that an array pointer cannot be NULL. This is not a very
> >> important warning, but there is a function called cpumask_available that
> >> seems to be defined just for that case, so the fix is easy.
> >> 
> >> Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
> >> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> > 
> > There was an alternate patch proposed for this by
> > Murilo Opsfelder Araujo. What do you think about that approach?
> 
> I responded on the other thread, but let me share the response here:
> 
> [to muriloo@linux.ibm.com]
> Apologies for the delay in responding, broken laptop…
> 
> In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:
> 
> 	typedef struct cpumask cpumask_var_t[1];
> 
> So that vp_dev->msix_affinity_masks[i] is statically not null (that’s the warning)
> but also a static pointer, so not kfree-safe IMO.


Not sure I understand what you are saying here.

> > 
> > 
> >> ---
> >> drivers/virtio/virtio_pci_common.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index d724f676608b..5c44a2f13c93 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -254,7 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
> >> 
> >> 	if (vp_dev->msix_affinity_masks) {
> >> 		for (i = 0; i < vp_dev->msix_vectors; i++)
> >> -			if (vp_dev->msix_affinity_masks[i])
> >> +			if (cpumask_available(vp_dev->msix_affinity_masks[i]))
> >> 				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
> >> 	}
> >> 
> >> -- 
> >> 2.35.1
> > 

