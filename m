Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5F536312
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351449AbiE0M64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349209AbiE0M6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A3AF3527A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653656332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdUWMIkaVQo5/ztJhdqUq/oyKx8W5hvof7Mbhxo94Xo=;
        b=J0r4sKAOGQQkiuIn/EvhbgFnpXw0If+p0G1zAmYaF2yWSqwl6ffLqyb8yCfHnuhwWi5DgY
        z3su95pwvfWrGXoMNK6TTisOgUYXjE8cxGJVwX8lxqPb0AcIp7uALUqiM8+BpnffDo4Fss
        VtTmMWv7QAFL8atD9Yz7vRCFi61pPUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-KF64FyXdNgWzknneb9PXnQ-1; Fri, 27 May 2022 08:58:48 -0400
X-MC-Unique: KF64FyXdNgWzknneb9PXnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CDB880B71A;
        Fri, 27 May 2022 12:58:48 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 058C340EC002;
        Fri, 27 May 2022 12:58:46 +0000 (UTC)
Date:   Fri, 27 May 2022 08:58:45 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <20220527125844.GA26124@pauld.bos.csb>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpCPjP2jJgLzCo1C@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpCPjP2jJgLzCo1C@slm.duckdns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 26, 2022 at 10:45:00PM -1000 Tejun Heo wrote:
> Hello,
> 
> On Fri, May 27, 2022 at 10:30:18AM +0200, Juri Lelli wrote:
> > FWIW, I was under the impression that this would nicely fit along the
> > side of other feaures towards implenting dynamic isolation of CPUs (say
> > https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
> > for example). Wouldn't be awkward to have to poke different places to
> > achieve isolation at runtime?
> 
> So, it were just being part of the isolated domain thing, it would make
> sense, but as a separate flag which isn't hierarchical, it's weird to put it
> there.

The way I see it is more that the "isolated domain thing" is one part of
this whole dynamic isolation thing and is just one flag among many (most
still on the drawing board, but planned). It may be that Waiman's "isolated" 
should be renamed "no_load_balance" or something.

Part of this is making cpu isolation more granular. 

> 
> > Also, I wonder if a proc/sys interface might be problematic for certain
> > middleware that is substantially based on using cgroups. I'll try to ask
> > around. :)
> 
> There is a downside to making a feature a part of cpuset in that it makes
> cgroup usage mandatory. This is fine for something which benefits from
> hierarchical organization but it is weird to require building cgroup
> hierarchy for straight-forward system-wide features.
> 

That ship may have sailed when SD_LOAD_BALANCE was removed, which is part
of what Waiman's feature addresses.  That is, now in order to get control
over the system-wide feature of which CPUs get scheduler load balanced you 
need to use cpusets. 


My 3 cents anyway  (inflation ;)


Cheers,
Phil


> Thanks.
> 
> -- 
> tejun
> 

-- 

