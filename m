Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A4575043
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbiGNOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiGNODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F297E6870C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657807343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzI2xFBiAM8l/m5BCcJd1veC9jaA+Dymufc6m+uuo/s=;
        b=JNitHfEbo/H6rHiF7lqujLr796MILlVq6kNo/oZipdosHgqtREV4T9EICDemGuwXPTqHlk
        xV74jvpBmxOwkn8u0poSk+GGeQWT2xLVichwbsGjAK0Li4H3maGGMGNx3zf4HkBif39p1/
        2RYlMfB5ucNmkkzboqySaQU5+pX6wls=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-oW_zcTArOg6wMdi7HomoFg-1; Thu, 14 Jul 2022 10:02:18 -0400
X-MC-Unique: oW_zcTArOg6wMdi7HomoFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76FC53800C28;
        Thu, 14 Jul 2022 14:02:17 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA155C28100;
        Thu, 14 Jul 2022 14:02:16 +0000 (UTC)
Date:   Thu, 14 Jul 2022 10:02:15 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v3] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <YtAh57FudrywhX67@lorien.usersys.redhat.com>
References: <20220713183855.2188201-1-pauld@redhat.com>
 <CAGsJ_4yb5Z3msMgXRZpSXLFiysQdJq-n_p9B6d-p2t_-_UHhVQ@mail.gmail.com>
 <YtATLNvojuvOOmys@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtATLNvojuvOOmys@lorien.usersys.redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 08:59:25AM -0400 Phil Auld wrote:
> On Thu, Jul 14, 2022 at 12:23:01PM +1200 Barry Song wrote:
> > btw, we have a lot of other places which might need this, such as
> > drivers/base/topology.c
> > 
> > so perhaps we can move them to some common place,
> > 
> > #define cpu_bitmap_bytes  (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1
> > : PAGE_SIZE)
> > #define cpu_list_bytes  (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE)
> > 
> > is include/linux/cpumask.h a good place for it?

drivers/base/base.h does not look like the right place, so I think your cpumask.h idea
is better. I'll put in there and update the topology.c BIN_ATTRs. 

Thanks,
Phil

> 
> My concern is the ones that are breaking actual userspace code. But yes, those
> otherwise have the same 0 size. 
> 
> It seems somewhat specific to drivers/base. Maybe there's a less global place to
> put those closer. I can look and do it this way if that will help get it fixed.
> 
> 
> Cheers,
> Phil
> 
> > 
> > >  /**
> > >   * struct node_access_nodes - Access class device to hold user visible
> > > --
> > > 2.31.1
> > >
> > 
> > Thanks
> > Barry
> > 
> 
> -- 

-- 

