Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB65B20AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiIHOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiIHOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812DFD6BAC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662647820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wFcDqpqfo5+BlCFcCMK6T6o/K8WN6HmeBg3zPocSOsQ=;
        b=QbIlCjgNx9J2Q77eday2QeT5PwYMI8cKX9Nz+5HimDyXUB5wSYzPcGkleNfZajy1d1AMu+
        AheUGYsTGT0MX79CtWPpaqiLqf4AfKHYTWbXXp/ddUOGTxAKRFcqumPHdAp8mbgjO/8IIi
        nWCTn6RBpob3WAxByef3KwceFSs7Fi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-368-SE5nQjTjMdCJg7EbTz-luQ-1; Thu, 08 Sep 2022 10:36:59 -0400
X-MC-Unique: SE5nQjTjMdCJg7EbTz-luQ-1
Received: by mail-wm1-f71.google.com with SMTP id c25-20020a05600c0ad900b003a5ebad295aso484167wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wFcDqpqfo5+BlCFcCMK6T6o/K8WN6HmeBg3zPocSOsQ=;
        b=ku54lSDD9Wb0+hG3eM6pf4um0gDZxmcM3X1K1Y4e66k8D6xIeUcNG/9CKDQ8oKnYiL
         v6jhNvQWvEx8Rxe5EQhjr9SWTYEd+eYUzagKaTDY9UJd4p56CEh3wemdkXSbUf5nxvyK
         51h6cBaeiQB85YMPI6sn18g2XzlUZ3U4vFWrvHuuMtCN+V8SMkwo1ecPGKAB9/e1Yaw1
         S5OHn3Kz/rOIAZqLkLcHhfc3D6DFW6DD8cFKOs8xJXPgzCn0iGdlAi3B1ECkdCBWUbKQ
         R3UNs3buMIRsPh/cDYJvSH+tRUVm9xNxCtB7K7lc7ZnKZNWBi05ypxksxNzxRa1WZ5VA
         ERzQ==
X-Gm-Message-State: ACgBeo2EkznTJF24CN8du9QS9eo1SmxsGIt5kPtEPOMyWcOVsSTBQNq4
        UIbtU+aqkgDU0pBilhuxqXPEpKQlTVA7rMg6KBfM3Pt8XrO20cJUjVywfQKcZM5/zHGlOtWFrRq
        +9BXMD+1UkbcGLN/wN4KjcFnp
X-Received: by 2002:a5d:6da2:0:b0:228:64ca:3978 with SMTP id u2-20020a5d6da2000000b0022864ca3978mr5285517wrs.542.1662647818270;
        Thu, 08 Sep 2022 07:36:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6BEGVkHcFX/ZuPLpySO7WMaIWzsWXcmGzFBbS0MxMsqv14mvHPWdYH6rv4OjZ1+HxLnAXdhw==
X-Received: by 2002:a5d:6da2:0:b0:228:64ca:3978 with SMTP id u2-20020a5d6da2000000b0022864ca3978mr5285510wrs.542.1662647818042;
        Thu, 08 Sep 2022 07:36:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003a3442f1229sm3131212wmn.29.2022.09.08.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:36:56 -0700 (PDT)
Date:   Thu, 8 Sep 2022 16:36:52 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Call to discuss vsock netdev/sk_buff [was Re: [PATCH 0/6]
 virtio/vsock: introduce dgrams, sk_buff, and qdisc]
Message-ID: <20220908143652.tfyjjx2z6in6v66c@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <YxdKiUzlfpHs3h3q@fedora>
 <Yv5PFz1YrSk8jxzY@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yv5PFz1YrSk8jxzY@bullseye>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 02:39:32PM +0000, Bobby Eshleman wrote:
>On Tue, Sep 06, 2022 at 09:26:33AM -0400, Stefan Hajnoczi wrote:
>> Hi Bobby,
>> If you are attending Linux Foundation conferences in Dublin, Ireland
>> next week (Linux Plumbers Conference, Open Source Summit Europe, KVM
>> Forum, ContainerCon Europe, CloudOpen Europe, etc) then you could meet
>> Stefano Garzarella and others to discuss this patch series.
>>
>> Using netdev and sk_buff is a big change to vsock. Discussing your
>> requirements and the future direction of vsock in person could help.
>>
>> If you won't be in Dublin, don't worry. You can schedule a video call if
>> you feel it would be helpful to discuss these topics.
>>
>> Stefan
>
>Hey Stefan,
>
>That sounds like a great idea! I was unable to make the Dublin trip work
>so I think a video call would be best, of course if okay with everyone.

Looking better at the KVM forum sched, I found 1h slot for Sep 15 at 
16:30 UTC.

Could this work for you?

It would be nice to also have HyperV and VMCI people in the call and 
anyone else who is interested of course.

@Dexuan @Bryan @Vishnu can you attend?

@MST @Jason @Stefan if you can be there that would be great, we could 
connect together from Dublin.

Thanks,
Stefano

