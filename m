Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F64C18AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiBWQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242819AbiBWQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A829250E0F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645634093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3lqn0tIphQCzoUYCoDMphawJdNppPNWOgdtGkax2nDU=;
        b=aF4lowHKa8ZCX3HXG9TX0Djguo45+Nwg8D41Rp8BlGUWTOzUwjOcAvWjbq3bODgNtGs4ZM
        jP1TG4QivJ5JiNqQ+CimnBpuiRF4Sm1Jly7hm1XkkQ2ZG+OWcn96dlPOCXIkbEJlfH0Ig0
        dz+DJXmBlrfaqzbe+1aTzbUsmKbq7Fk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-xXpnpVZjPA-8XU6MLuTmCg-1; Wed, 23 Feb 2022 11:34:51 -0500
X-MC-Unique: xXpnpVZjPA-8XU6MLuTmCg-1
Received: by mail-wm1-f69.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so1350407wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3lqn0tIphQCzoUYCoDMphawJdNppPNWOgdtGkax2nDU=;
        b=NmuhNQJor+8uBuZsz3LryarW0wPg7fe5jf4hw2FgPyJA9OZc2Onvuavsm+WgmrMGj3
         aQC/Wr6DduslZiMqi5FLrxQx1aFkqSXpgOaOp/g6T55m3Vk8+ZsZUQQ6cxONLFGTFTRo
         avT79qbENLkGR6gNnmcTLxLOeBgrUfuNlV67Bg2J1RlC6DmD1F5SyI3SJlw8uhQRZ6bm
         9tRV5UCwWHLn/PGH18EbYj3NAgGJGJOxC5xL+03Aju3rowdw73Bgc6ASXKNZ1NJ95WS9
         EOdZMnFxl7Oqd1GvEYQIsQTszOXwekuIL9L7M9cGwLAKY9SmTggCcyuLwKLMq2Gp8lkl
         zpuQ==
X-Gm-Message-State: AOAM530yTdzWxNuOagpfKFb3ExGc7MUvtkH0ws4oDSK2h2E/cE7xWHIX
        rcvcqMLmJdIOvU74TyzkwaUDS8Go51cTPLBJcFsGT8BtKpVys8hhZuuLDFiQvnGc08d5VXsjdbz
        FCWL6uL8oF1wuaKEakdCOe8JT
X-Received: by 2002:adf:9141:0:b0:1e3:1379:4cc6 with SMTP id j59-20020adf9141000000b001e313794cc6mr326544wrj.249.1645634090687;
        Wed, 23 Feb 2022 08:34:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ/k/Z9rXlko1fffkDNVbpa2o61BCYEPxiqEWZYB8KjyivPwlJr0kock4OVQ/OLM6ThVyT8w==
X-Received: by 2002:adf:9141:0:b0:1e3:1379:4cc6 with SMTP id j59-20020adf9141000000b001e313794cc6mr326532wrj.249.1645634090461;
        Wed, 23 Feb 2022 08:34:50 -0800 (PST)
Received: from debian.home (2a01cb058d3818005c1e4a7b0f47339f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d38:1800:5c1e:4a7b:f47:339f])
        by smtp.gmail.com with ESMTPSA id b10sm72357wrd.8.2022.02.23.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:34:50 -0800 (PST)
Date:   Wed, 23 Feb 2022 17:34:48 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: vlan: allow vlan device MTU change follow real
 device from smaller to bigger
Message-ID: <20220223163448.GB19531@debian.home>
References: <20220221124644.1146105-1-william.xuanziyang@huawei.com>
 <CANn89iKyWWCbAdv8W26HwGpM9q5+6rrk9E-Lbd2aujFkD3GMaQ@mail.gmail.com>
 <YhQ1KrtpEr3TgCwA@gondor.apana.org.au>
 <8248d662-8ea5-7937-6e34-5f1f8e19190f@huawei.com>
 <CANn89iLf2ira4XponYV91cbvcdK76ekU7fDW93fmuJ3iytFHcw@mail.gmail.com>
 <20220222103733.GA3203@debian.home>
 <20220222152815.1056ca24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20220223112618.GA19531@debian.home>
 <20220223071736.1cb2cf3e@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223071736.1cb2cf3e@hermes.local>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:17:36AM -0800, Stephen Hemminger wrote:
> On Wed, 23 Feb 2022 12:26:18 +0100
> Guillaume Nault <gnault@redhat.com> wrote:
> 
> > On Tue, Feb 22, 2022 at 03:28:15PM -0800, Jakub Kicinski wrote:
> > > On Tue, 22 Feb 2022 11:37:33 +0100 Guillaume Nault wrote:  
> > > > What about an explicit option:
> > > > 
> > > >   ip link add link eth1 dev eth1.100 type vlan id 100 follow-parent-mtu
> > > > 
> > > > 
> > > > Or for something more future proof, an option that can accept several
> > > > policies:
> > > > 
> > > >   mtu-update <reduce-only,follow,...>
> > > > 
> > > >       reduce-only (default):
> > > >         update vlan's MTU only if the new MTU is smaller than the
> > > >         current one (current behaviour).
> > > > 
> > > >       follow:
> > > >         always follow the MTU of the parent device.
> > > > 
> > > > Then if anyone wants more complex policies:
> > > > 
> > > >       follow-if-not-modified:
> > > >         follow the MTU of the parent device as long as the VLAN's MTU
> > > >         was not manually changed. Otherwise only adjust the VLAN's MTU
> > > >         when the parent's one is set to a smaller value.
> > > > 
> > > >       follow-if-not-modified-but-not-quite:
> > > >         like follow-if-not-modified but revert back to the VLAN's
> > > >         last manually modified MTU, if any, whenever possible (that is,
> > > >         when the parent device's MTU is set back to a higher value).
> > > >         That probably requires the possibility to dump the last
> > > >         modified MTU, so the administrator can anticipate the
> > > >         consequences of modifying the parent device.
> > > > 
> > > >      yet-another-policy (because people have a lot of imagination):
> > > >        for example, keep the MTU 4 bytes lower than the parent device,
> > > >        to account for VLAN overhead.
> > > > 
> > > > Of course feel free to suggest better names and policies :).
> > > > 
> > > > This way, we can keep the current behaviour and avoid unexpected
> > > > heuristics that are difficult to explain (and even more difficult for
> > > > network admins to figure out on their own).  
> > > 
> > > My $0.02 would be that if we want to make changes that require new uAPI
> > > we should do it across uppers.  
> > 
> > Do you mean something like:
> > 
> >   ip link set dev eth0 vlan-mtu-policy <policy-name>
> > 
> > that'd affect all existing (and future) vlans of eth0?
> > 
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
> > 
> 
> In general these kind of policy choices are done via sysctl knobs.
> They aren't done at netlink/ip link level.

I don't really mind if the configuration is per vlan, per upper device
or per netns, as long as we keep a clear behaviour by default.

