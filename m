Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F49B4C4069
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiBYIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbiBYIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72D5B2A242
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645778798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/63QecjVRTlyc4mXw5SxJXv1w/J0+vHHzMDdcnAuAe8=;
        b=i0oZvH2uUzjvYh3R2rXEj5NDKPoptzO/I7b2mwxBBsCmLOAAP6SwxQ23fvDm8Kv50trtVz
        c/hcQrs/KjqA/udLK4RkbAsPeK6y1JMoKuAuP5Suxj48KUriew90qFeOTXzUGtDkYhUiQZ
        U68GNYsygCTeXKr/Gl6ZHSc3TvPlC5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-LzM4_Q8fOIqLvr2mf3FLTA-1; Fri, 25 Feb 2022 03:46:37 -0500
X-MC-Unique: LzM4_Q8fOIqLvr2mf3FLTA-1
Received: by mail-wm1-f69.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso1256325wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/63QecjVRTlyc4mXw5SxJXv1w/J0+vHHzMDdcnAuAe8=;
        b=0yBn+dl8ulSArtdwUVaJXVce/d8NTZcibOGGg+57w5NlEb4V7c1/85ATe4Ed2o35HW
         KOp6YnBbIp3E0PCI9yAjkT0QYVffXVKYh7q7Ys+ptR5xJ7ENovJs+29vujFmMZISq5Cw
         czIpNC6AVz2G0AEU0/+DaxDoJGe/vBIXeyMHxMHPg1p1NuSxHmiQexjihqUe4U/N8Iog
         4OekuY+qQA0E2QmXHf++DjgoaYSjwYSDoOT8x69+l4LpOfcofYTzTQ8kiGkWpab0IolB
         LggvpjbQGsFD9ljjdS2wDw7T3IdmxM79L/8YXE1OoH1bwgzSMl1djGxJ/FkMI4ubfwSQ
         tDCQ==
X-Gm-Message-State: AOAM5320aMyPSULh+dRrQmnwc+x1yuBcP44Sc8Ud7kdjSeneQmEpWV+t
        xnTm5r2CsjOVXJSK9FTM/hLvYkPqFXZ1rciOtgri32vhZ0z1F/xHPWIAXDH+7gECWrBOU0GOEXQ
        fKfPtfvgdAYjevfha+P5qM5jM
X-Received: by 2002:a7b:c216:0:b0:381:21f4:4965 with SMTP id x22-20020a7bc216000000b0038121f44965mr1756546wmi.167.1645778796001;
        Fri, 25 Feb 2022 00:46:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweIQgiKOqGgrEPQnlyECuG8dpM9fCwjhyPYQBprWncbs0xzV9rJWY6PsFOjTDKql0KRFdDcg==
X-Received: by 2002:a7b:c216:0:b0:381:21f4:4965 with SMTP id x22-20020a7bc216000000b0038121f44965mr1756529wmi.167.1645778795768;
        Fri, 25 Feb 2022 00:46:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-142.dyn.eolo.it. [146.241.242.142])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5411000000b001e688b4ee6asm1812504wrv.35.2022.02.25.00.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 00:46:35 -0800 (PST)
Message-ID: <0b026eb24a0348d32b6dda94950f6517f8304456.camel@redhat.com>
Subject: Re: [PATCH] net:fix up skbs delta_truesize in UDP GRO frag_list
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lena Wang <lena.wang@mediatek.com>, davem@davemloft.net,
        kuba@kernel.org, matthias.bgg@gmail.com
Cc:     wsd_upstream@mediatek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hao.lin@mediatek.com,
        Eric Dumazet <edumazet@google.com>
Date:   Fri, 25 Feb 2022 09:46:34 +0100
In-Reply-To: <1645769353-7171-2-git-send-email-lena.wang@mediatek.com>
References: <1645769353-7171-1-git-send-email-lena.wang@mediatek.com>
         <1645769353-7171-2-git-send-email-lena.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Re-adding Eric, as Jakub cc-ed him in the previous iteration, but his
address has been lost here.

On Fri, 2022-02-25 at 14:09 +0800, Lena Wang wrote:
> From: lena wang <lena.wang@mediatek.com>
> 
> The truesize for a UDP GRO packet is added by main skb and skbs in main
> skb's frag_list:
> skb_gro_receive_list
>         p->truesize += skb->truesize;
> 
> When uncloning skb, it will call pskb_expand_head and trusesize for
> frag_list skbs may increase. This can occur when allocators uses
> __netdev_alloc_skb and not jump into __alloc_skb. This flow does not
> use ksize(len) to calculate truesize while pskb_expand_head uses.
> skb_segment_list
> err = skb_unclone(nskb, GFP_ATOMIC);
> pskb_expand_head
>         if (!skb->sk || skb->destructor == sock_edemux)
>                 skb->truesize += size - osize;
> 
> If we uses increased truesize adding as delta_truesize, it will be
> larger than before and even larger than previous total truesize value
> if skbs in frag_list are abundant. The main skb truesize will become
> smaller and even a minus value or a huge value for an unsigned int
> parameter. Then the following memory check will drop this abnormal skb.
> 
> To avoid this error we should use the original truesize to segment the
> main skb.

For some reasons 3 different mails with this patch lanted on the ML, I
guess 1 would have sufficed :)

This looks like a fix for the -net tree, please specify the target tree
in the patch subj and a suitable 'fixes' tag. Likely:

Fixes: 53475c5dd856 ("net: fix use-after-free when UDP GRO with shared fraglist")

> 
> 
> Signed-off-by: lena wang <lena.wang@mediatek.com>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9d0388be..8b7356c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3876,6 +3876,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  		list_skb = list_skb->next;
>  
>  		err = 0;
> +		delta_truesize += nskb->truesize;
>  		if (skb_shared(nskb)) {
>  			tmp = skb_clone(nskb, GFP_ATOMIC);
>  			if (tmp) {
> @@ -3900,7 +3901,6 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  		tail = nskb;
>  
>  		delta_len += nskb->len;
> -		delta_truesize += nskb->truesize;
>  
>  		skb_push(nskb, -skb_network_offset(nskb) + offset);
>  

Looks correct to me:

Acked-by: Paolo Abeni <pabeni@redhat.com>

I *think* posting a v2 could be the easier way to handle the above
glitches. If you do so (no changes to the patch body), please retain my
ack.

Cheers,

Paolo

