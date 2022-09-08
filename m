Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDB45B1702
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIHIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiIHIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B4332AAE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662625814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opHRLepQrfUm0+zOxWDE1IyemjcpUteMhEnVxI/dcAo=;
        b=GBOOVvfB7N910BwqnZyjc6ssrS+1olqzqN0DYqvtgWPsfKcGfZWR2lKo8Zuy+eJaeHRExR
        dh5mMFYinuRLVu+x5+E9TPTFe2jHImIkc+6wunX71lTOBFPkfuV3vd77Z7x9u2GEz332bf
        fO8xtxtrI/VW670uhKBfZafrJIKJDZs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-cs71-humP826wuR4__OMJA-1; Thu, 08 Sep 2022 04:30:13 -0400
X-MC-Unique: cs71-humP826wuR4__OMJA-1
Received: by mail-wm1-f71.google.com with SMTP id h129-20020a1c2187000000b003b3263d477eso197944wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=opHRLepQrfUm0+zOxWDE1IyemjcpUteMhEnVxI/dcAo=;
        b=aD8gkkWkGhoyB7XqczZB3DY2Zz7/p4uFbxGJCQoEZ3gUfYNhRst/WbWw5S258k+bj9
         M23rDcSZUQw60CgE03eL0HP+FCsdsAuAR8rTI1IY8nQNbc/SNkxELSHdnwZzpVNdHz4H
         H/Pk+Wa9TdgrQ/fD2QgvrMXG67kXRaqtjicTHjrKqCYsrhWpNMwmg8FmK+Z3aIV1ilyw
         ln+2OmDhLwOAC2cldbycwDzBM5XWvNPe0/r8LrHSG0RhT/ktEzGzuC/Ekwfy+qTeXjtc
         nUnzoHCwOuCLT2c2NdSAW8Fo892f6SmlFmxca2R+l5vejwXDtbsZ4gqO+0/Ctf3BDnZe
         Ymzg==
X-Gm-Message-State: ACgBeo1tC1ZppGZTHAKo6egGGHz0nG6LlqwW46ZvHO3lxKPrHL6Jzyyg
        fAmnEUk1/DJueQDkLybgOfOQmzOi94wG+eM3xpvF6sV2kJySeq++2WvU6l89zrQiok16yCvZpH0
        +GPNaa51zX15TEa1GngmvWqRh
X-Received: by 2002:a7b:cb88:0:b0:3a5:ea1c:c541 with SMTP id m8-20020a7bcb88000000b003a5ea1cc541mr1496482wmi.114.1662625812029;
        Thu, 08 Sep 2022 01:30:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SwMIElGNbgYD/YsZ20ljCMhRe+R4cc7VaydN9lljIdfCNE3iz4v1UCtSVpJzo90tDWyI+9g==
X-Received: by 2002:a7b:cb88:0:b0:3a5:ea1c:c541 with SMTP id m8-20020a7bcb88000000b003a5ea1cc541mr1496455wmi.114.1662625811803;
        Thu, 08 Sep 2022 01:30:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c2d5600b003a541d893desm1731720wmg.38.2022.09.08.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:30:11 -0700 (PDT)
Date:   Thu, 8 Sep 2022 10:30:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
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
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220908083003.qsivb5j2f6pn4f2d@sgarzare-redhat>
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
>That sounds like a great idea!

Yep, I agree!

>I was unable to make the Dublin trip work
>so I think a video call would be best, of course if okay with everyone.

It will work for me, but I'll be a bit busy in the next 2 weeks:

 From Sep 12 to Sep 14 I'll be at KVM Forum, so it may be difficult to 
arrange, but we can try.

Sep 15 I'm not available.
Sep 16 I'm traveling, but early in my morning, so I should be available.

Form Sep 10 to Sep 23 I'll be mostly off, but I can try to find some 
slots if needed.

 From Sep 26 I'm back and fully available.

Let's see if others are available and try to find a slot :-)

Thanks,
Stefano

