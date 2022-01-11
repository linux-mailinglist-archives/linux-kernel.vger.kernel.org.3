Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC148B2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbiAKRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243657AbiAKRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641921067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zWK4tN+9sCHLKxamK/wjM5K43GyYWdN/7hQupmm6IE=;
        b=HGgJi0MxH4OEKaMBF1cgIem2z9hvj6DukcreX0Jbswj7cxJqw3x/rW3Ryc4HEQ8FjHETyB
        kuxRTGHgllOk07zi1cif/Y+pkS1rtMn1ccDASm163fnOTBlxU+EKwjtcYz/xjEHZfe0HwO
        ogYNhJ64gYVz+xJq+c9cU07KZnZn9qg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-c8fctzw0MMWS5UQ8biL5-A-1; Tue, 11 Jan 2022 12:11:06 -0500
X-MC-Unique: c8fctzw0MMWS5UQ8biL5-A-1
Received: by mail-wm1-f69.google.com with SMTP id o185-20020a1ca5c2000000b003478a458f01so162894wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8zWK4tN+9sCHLKxamK/wjM5K43GyYWdN/7hQupmm6IE=;
        b=sGUDf/HW7mF+PbN3Leyk28AXNLFHXK0G0EakR8TJB/av29dy4KL3DtrLNgHjrq1Zhh
         05FfrpRYFQOiqEGcJoLkRSMTIwLCSNu96qMGvJKbQKz3vPiIIlssl3MNuPW0ywh0pxBD
         IQY3+xyvIcxyZ8Ao1Y1JnjsBRVI/yIuo6s6xv2JTrg+xd1S4H0CYdtb3rDztGBCe7KIu
         fcXSRGArTNqxv3lMSGeVh92rY7mzkej3bZOdTw+DXmMpgoomdWSKeaf3B1jlH5iemj2A
         7usX/nzF3kKzM8u3pSpOWIyLOFk3IQRPI9axcHrnH/S+CK0IHWi7ImHWe6bADG0MsUNX
         F2cQ==
X-Gm-Message-State: AOAM530Dd5u6qsT8gks8cV871tU2auj93zpSC9RjTjJXEVoAK1TGC8HD
        DKjGTwniGgrP2VTaIgm0DddXX7UuN81o2ZorYxE8wlKwJveHMjq0B8njGwS8yW/8jgvy9kUEcHO
        VzGJSF+z23BG4ckTLAJrYK2N8
X-Received: by 2002:adf:d222:: with SMTP id k2mr4451521wrh.332.1641921065237;
        Tue, 11 Jan 2022 09:11:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXpslAh5ADGc3957eLtWJpzW3P/MighujLUPuX4ruiB8rgSb0yOAB/BZQ8T7j19gWqojV1vQ==
X-Received: by 2002:adf:d222:: with SMTP id k2mr4451503wrh.332.1641921065031;
        Tue, 11 Jan 2022 09:11:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id z4sm2116440wmf.44.2022.01.11.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:11:04 -0800 (PST)
Message-ID: <48293134f179d643e9ec7bcbd7bca895df7611ac.camel@redhat.com>
Subject: Re: [PATCH 09/14] ipv6: hand dst refs to cork setup
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Jan 2022 18:11:03 +0100
In-Reply-To: <07031c43d3e5c005fbfc76b60a58e30c66d7c620.1641863490.git.asml.silence@gmail.com>
References: <cover.1641863490.git.asml.silence@gmail.com>
         <07031c43d3e5c005fbfc76b60a58e30c66d7c620.1641863490.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-11 at 01:21 +0000, Pavel Begunkov wrote:
> During cork->dst setup, ip6_make_skb() gets an additional reference to
> a passed in dst. However, udpv6_sendmsg() doesn't need dst after calling
> ip6_make_skb(), and so we can save two additional atomics by passing
> dst references to ip6_make_skb(). udpv6_sendmsg() is the only caller, so
> it's enough to make sure it doesn't use dst afterwards.

What about the corked path in udp6_sendmsg()? I mean:

udp6_sendmsg(MSG_MORE) -> ip6_append_data() -> ip6_setup_cork() 

what if ip6_setup_cork() errors out in that path?

Thanks!

Paolo

