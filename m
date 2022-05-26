Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF49534C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbiEZI7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiEZI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E000A8880
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653555568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBuQubLXsKdHypsOLS0DFxdMqRgrnMQKA1oWPGoQKlI=;
        b=Ljly1e9wzrW8u5S9J4AMm5uY2/UH3i0p3kWkw38uFTCnONZpVTWSIHgd9fL6XITOIhjf1k
        vpjYGbHspViSqCnN8VTEUzR+v9/t7wb4WVpyqLUHDxqWAyQFtES3Obg+6TlVEYbBvOvtEx
        7nxM5S4JJC9ki+H08qci5b5dJX/hHGw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-P4MqsIMZOP2jImVxM-YdsA-1; Thu, 26 May 2022 04:59:26 -0400
X-MC-Unique: P4MqsIMZOP2jImVxM-YdsA-1
Received: by mail-wr1-f69.google.com with SMTP id n13-20020a5d67cd000000b0021003b039e0so153041wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QBuQubLXsKdHypsOLS0DFxdMqRgrnMQKA1oWPGoQKlI=;
        b=hzr0zsFicgJm1HyhIbdaVK8ODziLzVjg2QIEWYm0vaAgpH0+6BGsJXlYqaN0u1zHhK
         CgBpv6tMxwKBLE4qbZJPLxPr378WEzrLTNHXaTf9t30X6qc2L2sO4tecZeFFA3LOdmWC
         Iv+ZrsGDqX8ZcWwnXm0nz9kM7PebB+BHxudO/o/0buYiDXiM6VfS6W5kKwYc7YZrTJPN
         rb+IwlFLmAEi/y2rzhUZRSzCWD4aWjrXMmWa9VSjOJ1mTv6nS9I1q9+HnobcS7YYfiRB
         htASQQzWd7SDFF6/pbthKYoY/NpZcwUGJTtRvNpaOzvNSOZ4D8hiMCiaCynafFBK4BJC
         2osw==
X-Gm-Message-State: AOAM531Hev+L2kmmVK18/Z/IECQpjX6cmDoYSiQpdP0ZU8dEz2Vql5jS
        IW6HxDPR58ZhPuBnibcq/wK7IyORKPaWXkWZ5w20TbQf4sRI+X9c0MDQDNvSKhU5xK8VKFxsAUg
        5Fm6SnyecY/YQaxEGj8ePphc4
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id i12-20020a0560001acc00b0020ff12aa535mr10151113wry.375.1653555565586;
        Thu, 26 May 2022 01:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCzonV2Cu3c/gBioAW18CkReONSq7IWRWZkImNQWIDlZfYH8w2iZN8Bzrt8eIEu0exVcGFWg==
X-Received: by 2002:a05:6000:1acc:b0:20f:f12a:a535 with SMTP id i12-20020a0560001acc00b0020ff12aa535mr10151093wry.375.1653555565296;
        Thu, 26 May 2022 01:59:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b003973ea7e725sm4616302wma.0.2022.05.26.01.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:59:25 -0700 (PDT)
Message-ID: <de4aab60766b3de8705b09e36b8050feb92865ec.camel@redhat.com>
Subject: Re: [PATCH net] net: macsec: Retrieve MACSec-XPN attributes before
 offloading
From:   Paolo Abeni <pabeni@redhat.com>
To:     Carlos Fernandez <carlos.escuin@gmail.com>
Cc:     carlos.fernandez@technica-engineering.de,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Era Mayflower <mayflowerera@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 26 May 2022 10:59:23 +0200
In-Reply-To: <20220524114134.366696-1-carlos.fernandez@technica-engineering.de>
References: <20220524114134.366696-1-carlos.fernandez@technica-engineering.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-24 at 13:41 +0200, Carlos Fernandez wrote:
> When MACsec offloading is used with XPN, before mdo_add_rxsa
> and mdo_add_txsa functions are called, the key salt is not
> copied to the macsec context struct. Offloaded phys will need
> this data when performing offloading.
> 
> Fix by copying salt and id to context struct before calling the
> offloading functions.
> 
> Fixes: 48ef50fa866a ("macsec: Netlink support of XPN cipher suites")
> Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

I'm sorry to nick-picking again, but this patch don't pass checkpatch
validation:

https://patchwork.kernel.org/project/netdevbpf/patch/20220524114134.366696-1-carlos.fernandez@technica-engineering.de/

Specifically, you should add a 'From:' tag as the first line:

From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

(Or send this patch from the above email address)

Thanks!

