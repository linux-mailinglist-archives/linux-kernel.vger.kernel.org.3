Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47BC566805
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiGEKbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiGEKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 077F3140ED
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657017081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFyVmo3W/U4eGvfIkwXUtO/9rUsoM3oDAPa80BChrQE=;
        b=Ae3U3TH49cv49sLxvs1LVz3wseMsDIvCfE4e4q4z4m1QuX9x1UuOdDBdM3xbBfZLvRFxSa
        LsHnC8jTivTjCYmg3qHfETp25Dk1+SvYGTEnkC0sWJgHcdz4OH39Jgh3ATLa96KxOL4eia
        vn/5h0s74fykXYB/Roy2zXnCg0GURno=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-oyZHXzwjMfWl3rTIXnAboA-1; Tue, 05 Jul 2022 06:31:12 -0400
X-MC-Unique: oyZHXzwjMfWl3rTIXnAboA-1
Received: by mail-qt1-f198.google.com with SMTP id fz24-20020a05622a5a9800b0031d5de96774so4585559qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PFyVmo3W/U4eGvfIkwXUtO/9rUsoM3oDAPa80BChrQE=;
        b=PaH2lhsfuijCtYZZT7a2uNX8K2ahv0/4xw587Dyin3kZOJG6ff/VZiVBwZRdaw9mdM
         seoYXW42gRcIgoabHJHvwNF2Z/hqvquJG7uw8Vx6rEv+eiGTBqBo9jX8c1gQWDw++qRw
         0hZ4UmrmjMIJzmaUOePwr1zcZocfH94MrlVKth/IHuuiVmbgwCT//HbXhedGiHvZftPb
         U68/49Qj/dsebFcGjJSB9WLqf3Zz0PsJzge1QeJd1DCdp36xBMbo+w5JkycERPJEkWcI
         jJN3kGkTUq3D6scgG3+/VesvtSxR0iDjjllEv3aCKBCFj+1PakwMISPiGPYhcO3P+Iex
         mx5A==
X-Gm-Message-State: AJIora9L/tQN38EBhkM+SqR2vCEjTJQz04lKO43UnslE9agI9FkFsn3n
        pE3MIQ89f9ircO3pxdcgzmc2a8XVldwgCRy26p8+Bu4w0WLZ+eXS4nOc3gffS4PQCBHT7ammCYb
        oyAn9JjAnFhCaysWpHLbAUTaa
X-Received: by 2002:a05:6214:2465:b0:472:fcc9:1dcd with SMTP id im5-20020a056214246500b00472fcc91dcdmr5204234qvb.78.1657017072369;
        Tue, 05 Jul 2022 03:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sWVqjveyPu1tKpVwGio5G3SChbbKm0lyG6eFSaojhLOuJtH9XUz4Vc5LbKw1gHmxGwlhP+nQ==
X-Received: by 2002:a05:6214:2465:b0:472:fcc9:1dcd with SMTP id im5-20020a056214246500b00472fcc91dcdmr5204192qvb.78.1657017071891;
        Tue, 05 Jul 2022 03:31:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a240300b006af45243e15sm21884942qkn.114.2022.07.05.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 03:31:11 -0700 (PDT)
Message-ID: <248071bc915140d8c58669b288c15c731407fa76.camel@redhat.com>
Subject: Re: [PATCH] net: Shrink sock.sk_err sk_err_soft to u16 from int
From:   Paolo Abeni <pabeni@redhat.com>
To:     Leonard Crestez <cdleonard@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Soheil Hassas Yeganeh <soheil@google.com>,
        Wei Wang <weiwan@google.com>,
        Joanne Koong <joannelkoong@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Jul 2022 12:31:07 +0200
In-Reply-To: <74c6f54cd3869258f4c83b46d9e5b95f7f0dab4b.1656878516.git.cdleonard@gmail.com>
References: <74c6f54cd3869258f4c83b46d9e5b95f7f0dab4b.1656878516.git.cdleonard@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-03 at 23:06 +0300, Leonard Crestez wrote:
> These fields hold positive errno values which are limited by
> ERRNO_MAX=4095 so 16 bits is more than enough.
> 
> They are also always positive; setting them to a negative errno value
> can result in falsely reporting a successful read/write of incorrect
> size.
> 
> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> ---
>  include/net/sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I ran some relatively complex tests without noticing issues but some corner
> case where this breaks might exist.

Could you please explain in length the rationale behind this change?

Note that this additionally changes the struct sock binary layout,
which in turn in quite relevant for high speed data transfer.

Thanks!

Paolo

