Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA04548C2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352787AbiALLPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:15:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237932AbiALLPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641986106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/O6VUSuDrBCGXjIOjB+lCz/TDMc6L1BfrxoUSl2WMqg=;
        b=aGibjgzr8vSsqUTeUNO4UlQgIpykX45L9lmdJjyGGtjmpGB4Wbn8SfiuPYYch6dV6LKMd2
        oYUlQ2JMJPXjd8IcDAcnin/KxI5r4p4fZHPRitbyEkt/4qVswPfGGLpSx39qJ38TfYCSJL
        MxsWr5/6VBatkHYP4FoLwqCSHuTU/IA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-8A80HG8nNfaIos3c_evOhg-1; Wed, 12 Jan 2022 06:15:05 -0500
X-MC-Unique: 8A80HG8nNfaIos3c_evOhg-1
Received: by mail-qv1-f70.google.com with SMTP id 6-20020ad45b86000000b0041a32b5b1c4so599466qvp.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/O6VUSuDrBCGXjIOjB+lCz/TDMc6L1BfrxoUSl2WMqg=;
        b=em53vddM1kf5WWxxYDkoCTi2w63JEVLofWvxl4QlJW4Eps1PHjD3HGYf0pRtLDFVqX
         L5lLETAAZ1oiICzoKvH8qJcYkFpkoY4nuy5T1VY78DLtOEXw68AOUqwuyw32iG3eJib/
         BCYeQ4kS6r3Cbo6a41aKYT+NpZKgjFIDn7KRYhESrBCNr5+4UWtrUJph0nHzRCRBjL8G
         /FVE0TmjCve4sLoc4ijq5K9nI0wOlyz3BruNwHgyGu0sPe4kvFZ887Hvn2hr0r28J91m
         zEOzA2lPyEK1iEFlrI/D0TFP20jx+ziKnHeuT1KJ8OIHinhKmB1gBh1SrQmy7HqLLGjw
         VAiw==
X-Gm-Message-State: AOAM5314cpjRsrfCvz2mnqLJ0TLpZQQM2jofofVM2n37w1Q3a9UMtds4
        8vKGM+PSP0GAQ/UACMSMTNqI9Flo8PexoD4Wq+w6NpiMEhR07q1PNC5Nyc4c/Zv89WkKnD9us6I
        m5WoLXnUzsGuClNgOs+DbmmIl
X-Received: by 2002:a05:622a:1c5:: with SMTP id t5mr7159795qtw.311.1641986105465;
        Wed, 12 Jan 2022 03:15:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytfENyhCNljtiDCzXK7f0hQt2E1jJGbk4pwZSAZeomnRI3JR8zM0bsNr9/Do/Yp2K6SzERzg==
X-Received: by 2002:a05:622a:1c5:: with SMTP id t5mr7159783qtw.311.1641986105264;
        Wed, 12 Jan 2022 03:15:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id y17sm1361497qkp.134.2022.01.12.03.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 03:15:04 -0800 (PST)
Message-ID: <3520c1e1609d8bef103766ad03508d0060824b98.camel@redhat.com>
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
Date:   Wed, 12 Jan 2022 12:15:01 +0100
In-Reply-To: <9e3bb558-ecb1-a6aa-35e4-a2771136b3fe@gmail.com>
References: <cover.1641863490.git.asml.silence@gmail.com>
         <07031c43d3e5c005fbfc76b60a58e30c66d7c620.1641863490.git.asml.silence@gmail.com>
         <48293134f179d643e9ec7bcbd7bca895df7611ac.camel@redhat.com>
         <9e3bb558-ecb1-a6aa-35e4-a2771136b3fe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-11 at 20:39 +0000, Pavel Begunkov wrote:
> On 1/11/22 17:11, Paolo Abeni wrote:
> > On Tue, 2022-01-11 at 01:21 +0000, Pavel Begunkov wrote:
> > > During cork->dst setup, ip6_make_skb() gets an additional reference to
> > > a passed in dst. However, udpv6_sendmsg() doesn't need dst after calling
> > > ip6_make_skb(), and so we can save two additional atomics by passing
> > > dst references to ip6_make_skb(). udpv6_sendmsg() is the only caller, so
> > > it's enough to make sure it doesn't use dst afterwards.
> > 
> > What about the corked path in udp6_sendmsg()? I mean:
> 
> It doesn't change it for callers, so the ref stays with udp6_sendmsg() when
> corking. To compensate for ip6_setup_cork() there is an explicit dst_hold()
> in ip6_append_data, should be fine.

Whoops, I underlooked that chunk, thanks for pointing it out!

Yes, it looks fine.

> @@ -1784,6 +1784,7 @@ int ip6_append_data(struct sock *sk,
>   		/*
>   		 * setup for corking
>   		 */
> +		dst_hold(&rt->dst);
>   		err = ip6_setup_cork(sk, &inet->cork, &np->cork,
>   				     ipc6, rt);
> 
> 
> I don't care much about corking perf, but might be better to implement
> this "handing away" for ip6_append_data() as well to be more consistent
> with ip6_make_skb().

I'm personally fine with the the added dst_hold() in ip6_append_data()

Thanks!

Paolo

