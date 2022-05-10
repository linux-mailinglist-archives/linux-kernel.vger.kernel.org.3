Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13E5219F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbiEJNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbiEJNfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D50C2BFBDA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652189090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qrQk331dY+acOKtsHio4tuTM5tl4Z2AS4qgsAPiJY2U=;
        b=ZMYUhcFxH76k9VKPpFikqzFnp14g0x0uRua7+Ua9L+euwb+gKfZTtwWXzG/Hqs3EFSvpQ6
        Da6ACRYguzluNX2Tgyx7G8tp2fJ+pRlklrnZyNlPQix8/zS2rG3t7A3ehsBgFY97+bd3Rw
        HDS9DW5WxYWvuAzBi+8xrqBG2BJZ0i4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-XFKYWjobP5SVRh-tdpdSeA-1; Tue, 10 May 2022 09:24:49 -0400
X-MC-Unique: XFKYWjobP5SVRh-tdpdSeA-1
Received: by mail-wr1-f71.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so2729990wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qrQk331dY+acOKtsHio4tuTM5tl4Z2AS4qgsAPiJY2U=;
        b=iHfhcvUsTYVPmMjBb5Nl1ZGhzIOV42NKCRevAk6B/CgcGncamejQf1jfMG1KBSYFpu
         3bD3JsOXWdI6k6oKzj3jmMSz1OLxsz7TApN3JXKJy7nsj6LDrobV81bcfjuSF1TBKWcF
         mboBBhhkwU/lhaQMRcfld+rDxg/Ia72vikUkn8kuD0TiU0LXSZnO6/qbxjHLsyc5kgLJ
         d3ta2JKsxh2B/fdZobhf6CutW0FWuywI2NyGX7IYo4FKxkGKupMBtTWsZ/3OinCj3auK
         igGY00EsRxvq/O3cC3aYaJwsFKD/Ik3cfXQztJ80YchBe/ljib7mr75APvBjuQ2OQzFj
         Ztxg==
X-Gm-Message-State: AOAM530mQbdx47oJT8rUDijeKbCdle5QtMnsDxnMA1pg6ZiwQ7TAzsQd
        ybAcBg542XGwq9HW8kCNH9/OISEjrvrjtQpn6jt1Xt1TL0X46ur5CJhtyQotO4YIsafuZOHw8QO
        6UiQkHGQx5wUtxaNXtciXG6Ie
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id l1-20020a7bc341000000b0037bc619c9f4mr52516wmj.38.1652189088026;
        Tue, 10 May 2022 06:24:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqwwogMAcS1Mjth3MHCVBlRUf2i94V/nGy/gavPvqLn2BGjAVyi0GQ29U+7t2tPijI+iv5XA==
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id l1-20020a7bc341000000b0037bc619c9f4mr52495wmj.38.1652189087788;
        Tue, 10 May 2022 06:24:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d654b000000b0020c6b78eb5asm13892257wrv.68.2022.05.10.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 06:24:47 -0700 (PDT)
Message-ID: <19e704ace63483a765a3298610218c5d110bb0e4.camel@redhat.com>
Subject: Re: [PATCH] net: macb: Increment rx bd head after allocating skb
 and buffer
From:   Paolo Abeni <pabeni@redhat.com>
To:     Harini Katakam <harini.katakam@xilinx.com>,
        nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, kuba@kernel.org, dumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, harinikatakamlinux@gmail.com,
        radhey.shyam.pandey@xilinx.com
Date:   Tue, 10 May 2022 15:24:45 +0200
In-Reply-To: <20220509121958.3976-1-harini.katakam@xilinx.com>
References: <20220509121958.3976-1-harini.katakam@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 2022-05-09 at 17:49 +0530, Harini Katakam wrote:
> In gem_rx_refill rx_prepared_head is incremented at the beginning of
> the while loop preparing the skb and data buffers. If the skb or data
> buffer allocation fails, this BD will be unusable BDs until the head
> loops back to the same BD (and obviously buffer allocation succeeds).
> In the unlikely event that there's a string of allocation failures,
> there will be an equal number of unusable BDs and an inconsistent RX
> BD chain. Hence increment the head at the end of the while loop to be
> clean.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

This looks like targeting the "net" tree, please repost adding a
suitable Fixes tag.

Thanks,

Paolo

