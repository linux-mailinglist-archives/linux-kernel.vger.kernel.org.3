Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED8E4C1931
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbiBWQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbiBWQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:59:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61D724E395
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645635521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrnFjZJqnZXyFMWjL1XK3nOp3zr2c5o3aom/wRAcqjE=;
        b=Y9aOvmZ8fPUS9BkQ4nBeBezO7MtwIt7oV7V5lBrv+YaXRg0Mb1o9tsjT3VMHcZh6voEfyg
        aQgkYrTEjhQzJexktC90ePv1Gr2w8q1iDr56EsJJY6C1N5UQHIZYj8sXmQ8cmjFX6buZFZ
        ojn4h+71qkHrE1J3oVBLqGK5iTyTLCM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-eHhH2WDuP_Obqxk9YTdkcw-1; Wed, 23 Feb 2022 11:58:39 -0500
X-MC-Unique: eHhH2WDuP_Obqxk9YTdkcw-1
Received: by mail-wr1-f69.google.com with SMTP id o9-20020adfca09000000b001ea79f7edf8so3257680wrh.16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MrnFjZJqnZXyFMWjL1XK3nOp3zr2c5o3aom/wRAcqjE=;
        b=XRafSdfqbX7S6kyzvBjXIgS5BpoNwQ+/nCCNx7s935B/nvDQ4y1kewDrsR6sqHyqwx
         4ZLJigwRbJXosfJTXwfSLV3UYryieRlnwA8NOmGtP1vkWPhMuOmejU7Rjpcz6wNfWfLQ
         mBvYiFpfRRUuoBXG4HHAGKsUHUGt4/EJBUB7DAkKU9b87AroKxF5MwII2S+gt+HJYnLh
         RxAWxjHQQouyjK/bode0fA2hrGUcOS4vLUZneK/zqfqpcXyTxXmu3MGvRMCt88jPQH1i
         6sFHQ2bn7sU/3eByT7rqZxrUyIWNAcRcGDduugNXrIxIDSDN081h24Gmsjf400PJzWzD
         JO2g==
X-Gm-Message-State: AOAM531aO/f5dfH+0I+IpmcTNYYOLSQkPI96tsVay5m1mn6zG7hxx1OT
        FTCkuaKZxZB+OLT1CNfGvNbb03jqItwqi8aha5g9pYNSo3QJjaMYOSZxBE5SBQysffozRvDODD5
        UVbE6h5vUkeTOQWkAjgszljRX
X-Received: by 2002:a05:6000:18aa:b0:1e8:5dda:c340 with SMTP id b10-20020a05600018aa00b001e85ddac340mr369482wri.677.1645635518619;
        Wed, 23 Feb 2022 08:58:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmMpvQCTWIKQnDJRHm7sxfRAogs9j3At5klIPegiIao6Z1JGlW44v7aKSAdY+2Bq7VfzArmw==
X-Received: by 2002:a05:6000:18aa:b0:1e8:5dda:c340 with SMTP id b10-20020a05600018aa00b001e85ddac340mr369471wri.677.1645635518398;
        Wed, 23 Feb 2022 08:58:38 -0800 (PST)
Received: from debian.home (2a01cb058d3818005c1e4a7b0f47339f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d38:1800:5c1e:4a7b:f47:339f])
        by smtp.gmail.com with ESMTPSA id z14sm57378wrm.100.2022.02.23.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:58:37 -0800 (PST)
Date:   Wed, 23 Feb 2022 17:58:36 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: vlan: allow vlan device MTU change follow real
 device from smaller to bigger
Message-ID: <20220223165836.GC19531@debian.home>
References: <20220221124644.1146105-1-william.xuanziyang@huawei.com>
 <CANn89iKyWWCbAdv8W26HwGpM9q5+6rrk9E-Lbd2aujFkD3GMaQ@mail.gmail.com>
 <YhQ1KrtpEr3TgCwA@gondor.apana.org.au>
 <8248d662-8ea5-7937-6e34-5f1f8e19190f@huawei.com>
 <CANn89iLf2ira4XponYV91cbvcdK76ekU7fDW93fmuJ3iytFHcw@mail.gmail.com>
 <20220222103733.GA3203@debian.home>
 <20220222152815.1056ca24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20220223112618.GA19531@debian.home>
 <20220223080342.5cdd597c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223080342.5cdd597c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 08:03:42AM -0800, Jakub Kicinski wrote:
> On Wed, 23 Feb 2022 12:26:18 +0100 Guillaume Nault wrote:
> > Do you mean something like:
> > 
> >   ip link set dev eth0 vlan-mtu-policy <policy-name>
> > 
> > that'd affect all existing (and future) vlans of eth0?
> 
> I meant
> 
>   ip link set dev vlan0 mtu-policy blah
> 
> but also
> 
>   ip link set dev bond0 mtu-policy blah
> 
> and
> 
>   ip link set dev macsec0 mtu-policy blah2
>   ip link set dev vxlan0 mtu-policy blah2
> 
> etc.

Unless I'm missing something, that looks very much like what I proposed
(these are all ARPHRD_ETHER devices). It's just a bit unclear whether
"ip link set dev vlan0 mtu-policy blah" applies to vlan0 or to the vlans
that might be stacked on top of it (given your other examples, I assume
it's the later).

> > Then I think that for non-ethernet devices, we should reject this
> > option and skip it when dumping config. But yes, that's another
> > possibility.
> > 
> > I personnaly don't really mind, as long as we keep a clear behaviour.
> > 
> > What I'd really like to avoid is something like:
> >   - By default it behaves this way.
> >   - If you modified the MTU it behaves in another way
> >   - But if you modified the MTU but later restored the
> >     original MTU, then you're back to the default behaviour
> >     (or not?), unless the MTU of the upper device was also
> >     changed meanwhile, in which case ... to be continued ...
> >   - BTW, you might not be able to tell how the VLAN's MTU is going to
> >     behave by simply looking at its configuration, because that also
> >     depends on past configurations.
> >   - Well, and if your kernel is older than xxx, then you always get the
> >     default behaviour.
> >   - ... and we might modify the heuristics again in the future to
> >     accomodate with situations or use cases we failed to consider.
> 
> To be honest I'm still not clear if this is a real problem.
> The patch does not specify what the use case is.

It's probably not a problem as long as we keep sane behaviour by
default. Then we can let admins opt in for something more complex or
loosely defined.

