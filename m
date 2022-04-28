Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C18513206
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiD1LHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiD1LHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3824C187
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651143840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pu2kafg8s3Dpw8thSMePtydoo2e/yB3JPGTXgTvagKs=;
        b=YRWdx1Ex33CotqSvMURQm16VI/xTbwe5CKv1syW2uItuieZLL32dXIzXjHDkGpOHvyivqX
        lvbWTqqyhHwQORswrUM3sjumfF+fLcs2TE3CfJFo3qQcMXbVnr3mE9npg2TM4dwDJM2nmA
        pDbycwSQMvwqU+Ms17YJNyIY9tzZRrs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-HcEpPW9gOyi7DFrJ3qREJw-1; Thu, 28 Apr 2022 07:03:58 -0400
X-MC-Unique: HcEpPW9gOyi7DFrJ3qREJw-1
Received: by mail-wm1-f70.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso4234255wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pu2kafg8s3Dpw8thSMePtydoo2e/yB3JPGTXgTvagKs=;
        b=fejUUMTQHQaqNaJbclzwqMOXQllN4C9rbCCX+EWN+B7J+GbJXUDM8wJUmdzbjKEpTg
         Dq52VikkfXhJDoX6KvP+9X/sCiwp8PhbaURWYnk06X4R6FB5aEwgRHt6r1eEvws9jDg/
         FIReqbP5PIAPDVlU6bHUSiAenbRFONIqW67rkvRuV6miXMcIcZCyfZ+Q6F25f/JB5hzX
         g4T5jhwz396nuSUhUT+YxkUjK1QZg8wv8SBlZg+9WZoAqDXPjD9mfkfoEc7xMvEtlCOB
         y6SRtyeiz2wBNV0SGVxqz6GWFsMxaxMgQE8OHWnQgCG8KA2C4vhqZfFgyxOIa0OQHW9s
         fmYA==
X-Gm-Message-State: AOAM5334OGTcEKmi/ir4SuYuVaMQJo/veONou0nkyQEIlyQAOIDrVI83
        MoKSRXmRmqTkTkvS3f4gjtxmWWZFMo2Q/0lIzpOKg1HPEi19rPc4wZm5M7ze1orEAQ0ZgM8G6V7
        h3nDoIIDeCw29J1YhBiagrNI3
X-Received: by 2002:a5d:6388:0:b0:20a:ed44:fd38 with SMTP id p8-20020a5d6388000000b0020aed44fd38mr7212097wru.153.1651143837709;
        Thu, 28 Apr 2022 04:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnastE0TZ6WITcJ/eq00hMdksgzT7uwfrmU0vGkPpJVNtnSjzZ7TyLkFOB0HxZizgmJ6RGWg==
X-Received: by 2002:a5d:6388:0:b0:20a:ed44:fd38 with SMTP id p8-20020a5d6388000000b0020aed44fd38mr7212079wru.153.1651143837425;
        Thu, 28 Apr 2022 04:03:57 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm4205877wmb.48.2022.04.28.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:03:55 -0700 (PDT)
Date:   Thu, 28 Apr 2022 07:03:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
Cc:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mopsfelder@gmail.com,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
Message-ID: <20220428070345-mutt-send-email-mst@kernel.org>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
 <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
 <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:55:31AM +0200, Christophe Marie Francois Dupont de Dinechin wrote:
> 
> 
> > On 28 Apr 2022, at 11:51, Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com> wrote:
> > 
> > 
> > 
> >> On 28 Apr 2022, at 11:46, Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com> wrote:
> >> 
> >> 
> >> 
> >>> On 15 Apr 2022, at 05:51, Murilo Opsfelder Araújo <muriloo@linux.ibm.com> wrote:
> >>> 
> >>> On 4/14/22 23:30, Murilo Opsfelder Araujo wrote:
> >>>> GCC 12 enhanced -Waddress when comparing array address to null [0],
> >>>> which warns:
> >>>> drivers/virtio/virtio_pci_common.c: In function ‘vp_del_vqs’:
> >>>> drivers/virtio/virtio_pci_common.c:257:29: warning: the comparison will always evaluate as ‘true’ for the pointer operand in ‘vp_dev->msix_affinity_masks + (sizetype)((long unsigned int)i * 256)’ must not be NULL [-Waddress]
> >>>> 257 | if (vp_dev->msix_affinity_masks[i])
> >>>> | ^~~~~~
> >>>> In fact, the verification is comparing the result of a pointer
> >>>> arithmetic, the address "msix_affinity_masks + i", which will always
> >>>> evaluate to true.
> >>>> Under the hood, free_cpumask_var() calls kfree(), which is safe to pass
> >>>> NULL, not requiring non-null verification. So remove the verification
> >>>> to make compiler happy (happy compiler, happy life).
> >>>> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102103
> >>>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> >>>> ---
> >>>> drivers/virtio/virtio_pci_common.c | 3 +--
> >>>> 1 file changed, 1 insertion(+), 2 deletions(-)
> >>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >>>> index d724f676608b..5046efcffb4c 100644
> >>>> --- a/drivers/virtio/virtio_pci_common.c
> >>>> +++ b/drivers/virtio/virtio_pci_common.c
> >>>> @@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
> >>>> 	if (vp_dev->msix_affinity_masks) {
> >>>> 		for (i = 0; i < vp_dev->msix_vectors; i++)
> >>>> -			if (vp_dev->msix_affinity_masks[i])
> >>>> -				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
> >>>> +			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
> >>>> 	}
> >>>> 	if (vp_dev->msix_enabled) {
> >>> 
> >>> After I sent this message, I realized that Christophe (copied here)
> >>> had already proposed a fix:
> >>> 
> >>> https://lore.kernel.org/lkml/20220414150855.2407137-4-dinechin@redhat.com/
> >>> 
> >>> Christophe,
> >>> 
> >>> Since free_cpumask_var() calls kfree() and kfree() is null-safe,
> >>> can we just drop this null verification and call free_cpumask_var() right away?
> >> 
> >> Apologies for the delay in responding, broken laptop…
> >> 
> >> In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:
> >> 
> >> 	typedef struct cpumask cpumask_var_t[1];
> >> 
> >> So that vp_dev->msix_affinity_masks[i] is statically not null (that’s the warning)
> >> but also a static pointer, so not kfree-safe IMO.
> > 
> > … which also renders my own patch invalid :-/
> > 
> > Compiler warnings are good. Clearly not sufficient.
> 
> Ah, I just noticed that free_cpumask_var is a noop in that case.
> 
> So yes, your fix is better :-)

ACK then?

