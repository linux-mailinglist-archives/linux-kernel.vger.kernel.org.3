Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C303533E56
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbiEYN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244512AbiEYN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9944C91575
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653487015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwKtBZV8ciaRCowgqevFzBNex6RHDTKadOeeg0UrfVc=;
        b=ieO6jRkRrzbm3543JJ1jzvykbWFwziukIABw4g6kfdb87cPaQ25y+ZuIn/UffOxdM60zYw
        W3VzAdtDgp0eF2ZiJBNNjF1Z8HcImmh0odhjwbXn3ffSlC/nZKH7o9Hb8xzg8Anloft+HP
        GZCdW79WcA/XwkrXkZ+GuCrRd5c3Jc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-0sDW9gHhNWyfEP9vRbyJdA-1; Wed, 25 May 2022 09:56:52 -0400
X-MC-Unique: 0sDW9gHhNWyfEP9vRbyJdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DE3D8001EA;
        Wed, 25 May 2022 13:56:51 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F263405D4BF;
        Wed, 25 May 2022 13:56:51 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id CDA06416F574; Wed, 25 May 2022 10:56:18 -0300 (-03)
Date:   Wed, 25 May 2022 10:56:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>, regressions@lists.linux.dev
Subject: Re: vchiq: Performance regression since 5.18-rc1
Message-ID: <Yo41ggMvkI1B9TeM@fuller.cnet>
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <YoszE8lQ9VcofLtX@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoszE8lQ9VcofLtX@linutronix.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:09:07AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-05-22 01:22:00 [+0200], Stefan Wahren wrote:
> > Hi,
> Hi,
> 
> > while testing the staging/vc04_services/interface/vchiq_arm driver with my
> > Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
> > regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
> > lru_cache_disable: replace work queue synchronization with synchronize_rcu
> > 
> > Usually i run "vchiq_test -f 1" to see the driver is still working [1].
> 
> What about
> 	https://lore.kernel.org/all/YmrWK%2FKoU1zrAxPI@fuller.cnet/
> 
> Sebastian

Stefan,

Can you please try the patch above ?


