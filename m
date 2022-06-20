Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2667455147D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiFTJiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiFTJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 557821007
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655717878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVJ4Pc7idX3cRmZ7fOi1Ns6MbMDwBjisN2g0tryFY6w=;
        b=VNoHXUA0DL40Zi+bDVAE6jIYIhn4fWCiQZa8Rl/r5v6jmgUdvxMC3lECUl+oA59n31dhK0
        +MHtrEKUpUeb63AII4lkI+q3GCDfIo4QKsWOBTkNPKDXEsby8ZfPF7jjblmBfQLh1QbQd4
        RHEdTtraQCdfxYKt7ITrv16xgtMzTf0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-1O_-_gYdMQGPNp9pVI4E0w-1; Mon, 20 Jun 2022 05:37:56 -0400
X-MC-Unique: 1O_-_gYdMQGPNp9pVI4E0w-1
Received: by mail-wr1-f71.google.com with SMTP id m7-20020adfa3c7000000b0021b94088ba2so205341wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mVJ4Pc7idX3cRmZ7fOi1Ns6MbMDwBjisN2g0tryFY6w=;
        b=GMNYhzZH9DZ8MUXDkeynzHpO88efJ6sXwKEYCohB0XnNqJLGZxgbrE6fS0EcspWigI
         5QSvx55o99d1/TaPELQRCCObkykL21/3h98W/VlQlPQ4XX6zHqcDlRg7J6TZMM/qVpiR
         rD3zNRXRu64d+bnHzkmc3mCiPokZeRPc1DjcNSp4a05RjtJ6m5t4KzDuiXeT4ZU7v/SB
         GAbM5PknXbfScL6uT5e8BGanvJVpaw73Lrq/EMLy1wsp/PDNoyog32EGyT/DQR8ZVfqk
         A6+Ftst5KEhgVQvMjKHkOmRWU88KHYzc31qM3dbkqIsidR152a+r5yLBo/Gu7qx24pnD
         SKjw==
X-Gm-Message-State: AJIora8H3Yk1d3nsHpA9LTpQi2O/Rzi8YDBId3z7SS0iffTYmGlZ5AEd
        5A3ajkrGDdUz3Xuq4k7SdNwandjwq9j0MkE5tDWSz3oFhNyYuDV1TKXByADiAC+loSqjYxlfrck
        s7p7BJhA7ro2t44qLMmL10v5O
X-Received: by 2002:a05:6000:2a4:b0:213:bb34:7ff6 with SMTP id l4-20020a05600002a400b00213bb347ff6mr22791895wry.292.1655717875392;
        Mon, 20 Jun 2022 02:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkrLOZNzUhdaLZd1T7cZrm18QpT/h/SI9PyK8jG4W9Tt/2oH4zMfDzBTXmcISzHSSxAUXX6A==
X-Received: by 2002:a05:6000:2a4:b0:213:bb34:7ff6 with SMTP id l4-20020a05600002a400b00213bb347ff6mr22791874wry.292.1655717875163;
        Mon, 20 Jun 2022 02:37:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it. [79.46.200.40])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b0039c50d2d28csm18574590wmq.44.2022.06.20.02.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:37:54 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:37:50 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= 
        <liubo03@inspur.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: Remove unnecessary variable assignments
Message-ID: <20220620093750.ug6g7vzrninakd3x@sgarzare-redhat>
References: <d6527c0690634815820c1c7c04b31551@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6527c0690634815820c1c7c04b31551@inspur.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On Mon, Jun 20, 2022 at 09:32:28AM +0000, Bo Liu (刘波)-浪潮信息 wrote:
>Hi
>
>>On Fri, Jun 17, 2022 at 01:59:52AM -0400, Bo Liu wrote:
>>>In function vp_modern_probe(), "mdev->pci_dev" is assigned to 
>>>variable
>>>"pci_dev", variable "pci_dev" and "mdev->pci_dev" have the same 
>>>value.
>>>There is no need to assign variable "pci_dev" to "mdev->pci_dev". So
>>>remove it.
>>>
>>
>>I suggest rephrasing the description a bit.
>>Maybe into something like this:
>>
>>     In function vp_modern_probe(), "pci_dev" is initialized with the
>>     value of "mdev->pci_dev", so assigning "pci_dev" to 
>>     "mdev->pci_dev"
>>     is unnecessary since they store the same value.
>>
>>Anyway, the patch LGTM:
>>
>>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>The new patch is:
>
>In function vp_modern_probe(), "pci_dev" is initialized with the
>value of "mdev->pci_dev", so assigning "pci_dev" to "mdev->pci_dev"
>is unnecessary since they store the same value.
>
>Signed-off-by: Bo Liu <liubo03@inspur.com>
>---
> drivers/virtio/virtio_pci_modern_dev.c | 2 --
> 1 file changed, 2 deletions(-)

It looks good, but I think it is better to send a proper v2.

You can also add my R-b just before your S-o-b

Thanks,
Stefano

