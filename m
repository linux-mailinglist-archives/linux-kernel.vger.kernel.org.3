Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F120F523059
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiEKKKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiEKKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4233EFD350
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652263797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mh+649Dh6qwU40nTibeYt+SA3w58BbW+O7J+x0oXwyM=;
        b=eNqYrYX1e2P0BJjIRFn+eX6GTgGZpxL+XjdAQyKjf+jyaKnEqjgpZDKFH6gSRa27qrOeag
        w1zrcsc/WgLEHmry/sfKcLz30zc+GO22wvcgCLG5VR21OHCFMzflN9dgCjyzhsBRr2mCRs
        c4DPIaVdXeANJQyaugc5O+V3aPq5mCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-pu6jrhgOOPqP2VtuPPFOYQ-1; Wed, 11 May 2022 06:09:54 -0400
X-MC-Unique: pu6jrhgOOPqP2VtuPPFOYQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D178185A7B2;
        Wed, 11 May 2022 10:09:53 +0000 (UTC)
Received: from localhost (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AEEE416362;
        Wed, 11 May 2022 10:09:51 +0000 (UTC)
Date:   Wed, 11 May 2022 18:09:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <20220511100949.GG122876@MiWiFi-R3L-srv>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <YnTKcvkCoRBxqGSW@MiWiFi-R3L-srv>
 <2da2e67a-864e-246b-b9d0-673c7af937b4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da2e67a-864e-246b-b9d0-673c7af937b4@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/22 at 10:43am, Eric DeVolder wrote:
> 
> 
> On 5/6/22 02:12, Baoquan He wrote:
> > On 05/05/22 at 02:45pm, Eric DeVolder wrote:
> > ......
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index 256cf6db573c..f197af50def6 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -9,12 +9,17 @@
> > >   #include <linux/init.h>
> > >   #include <linux/utsname.h>
> > >   #include <linux/vmalloc.h>
> > > +#include <linux/highmem.h>
> > 
> > Wondering where highmem.h is needed. Just curious.
> 
> Ahh, I missed that. At one point in time we moved map_crash_pages() into
> this file, which brought highmem.h along with it. But we have since moved
> map_crash_pages() into x86/crash.c. And I missed eliminating highmem.h at
> that time.
> 
> I have removed this for v9.

That's nice, and you can add my ack when repost.

Acked-by: Baoquan He <bhe@redhat.com>

