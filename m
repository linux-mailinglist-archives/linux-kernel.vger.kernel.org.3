Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450534EA1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345678AbiC1Urq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346366AbiC1Uov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5746F32EF8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648500187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJEPbSEt0O6lWWC+/4/A5CGukD+9ye2bG6M4HjxFpHI=;
        b=VokgyMEoNeXACqeY7cBSnVAuQEbnXhkyfjX85Hykn8cb+g4KzL3K+A+4Gc1msISb8RHk6A
        cD/xnmgquUZl317dSEfL5RVfFhFyPDzSu89eGzozPeA+BAkBk4D16ZJFc8bQpxJWuAxql1
        fUGLGkzKkeut3ztZBisdFUbrDOc0mRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-M3iupVMDMGSjIcyAi0lF1A-1; Mon, 28 Mar 2022 16:43:05 -0400
X-MC-Unique: M3iupVMDMGSjIcyAi0lF1A-1
Received: by mail-wm1-f71.google.com with SMTP id n19-20020a7bcbd3000000b0038c94b86258so211691wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJEPbSEt0O6lWWC+/4/A5CGukD+9ye2bG6M4HjxFpHI=;
        b=fJ6Wv5o4lUWypINWVMmc4nR5giUgwrzK5XmwKslPcvL9thyVDqvRKmgsf9fCkLLgJh
         LTeYg+Afwqaalm0+P2uL0m8QyX8/1WkOEaKjt6Tr4LIOEh1hI1i889rViNkkAJLPYBse
         4gphMDTRArXKi51vPr1cqAKlBC7btnXYcRfuVN3B0Y7bRYPRCdgfGxvCMwpkYhoBV7cG
         +OEBkpN1V4ldcUlB3opuE2fn2KWxatkLxYDb0o2osl7azauQFSBVz/5y833ey3SOLqoC
         Xg71fN7dCYAah/zqYaZlLFwtWb0G+pjgw6xel3o1+UBpv7Hi82g32o3Y/7uEgisN+Kw1
         N7Ug==
X-Gm-Message-State: AOAM530noa53Y9alhHwoJN9HwIwUWQciEWhWRYLIkOnTvGTFSlhCIAXt
        N/Grp+2WJnFDirLHMZgeCwR4FXKXZycY0ovA40iz0Zuoj2JA5gFv3gdwIPs1KpnXCzmayf4GRmn
        rcYlzyhRD5epoYbUUoweybi82
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr1467638wmj.138.1648500184579;
        Mon, 28 Mar 2022 13:43:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqJ51NlOZBInKiTlBe3giVlBSqn5C3pjZeP3UUXO1W7rcm9wq0r9ipgX192N0DSiX3l8eE+Q==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr1467606wmj.138.1648500184334;
        Mon, 28 Mar 2022 13:43:04 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm616358wms.26.2022.03.28.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:43:03 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:42:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Minghao Xue <quic_mingxue@quicinc.com>
Cc:     jasowang@redhat.com, robh+dt@kernel.org, jean-philippe@linaro.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ztu@quicinc.com
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Message-ID: <20220328164228-mutt-send-email-mst@kernel.org>
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
> Some systems want to set the interrupt of virtio_mmio device
> as a wakeup source. On such systems, we'll use the existence
> of the "wakeup-source" property as a signal of requirement.
> 
> Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>

I don't have enough of a clue about dt to review this.
Pls get some acks from people with DT expertise.

> ---
> v1 -> v2: rename property from "virtio,wakeup" to "wakeup-source"
> 
>  Documentation/devicetree/bindings/virtio/mmio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index 4b7a027..160b21b 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -31,6 +31,10 @@ properties:
>      description: Required for devices making accesses thru an IOMMU.
>      maxItems: 1
>  
> +  wakeup-source:
> +    type: boolean
> +    description: Required for setting irq of a virtio_mmio device as wakeup source.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.7.4

