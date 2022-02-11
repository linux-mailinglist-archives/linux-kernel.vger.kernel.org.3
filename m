Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255974B2D41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbiBKTCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiBKTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A9C7CEC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644606133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uCPX5JhmQZBLLVR0kjaN03GHUoCUZZ0rX5OEZWbAEqs=;
        b=UwGi6y/kPm03xk0TblimgSka6ShxOrpl3AqTRiBRnmPZBcvUlIvZVdAbQ0UU2tZP/W/D7X
        Ky2adtTql1GvQdYkmb5NZmXslR4sqMNnIcjUGR1PaXNkzYvRgOIAesBR89hsWmRn6azanT
        IFyvCfoPL4FeW2v30fpFlSq/Mu+DCn0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-9OBYY8C-NZOsXMrNYGpsyA-1; Fri, 11 Feb 2022 14:02:12 -0500
X-MC-Unique: 9OBYY8C-NZOsXMrNYGpsyA-1
Received: by mail-yb1-f198.google.com with SMTP id q11-20020a252a0b000000b0061e240c8fb3so17079567ybq.22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCPX5JhmQZBLLVR0kjaN03GHUoCUZZ0rX5OEZWbAEqs=;
        b=GJPfkZUnP/OsJ/7sNn02LjInOosy3Pv4QRYqGNygq/lfwpZEcpfIicUiz9vBQMm/iA
         AqSRo6sGhHbh7pzwn7sLSSpHSNCFGELcpv3mXwh1ijm2gdyj6+VEs/kSEraeQk+kvWGI
         hyI6EjWk+6FRlIAgHSOtNLcJe/j8wFOMle7sWXWZU10eBS8uV18TmYO40zTEEf28F3pM
         4kBKG6HMs1gAMd4NlBb8o696BZsgz2nL7YHUGIuhMQVGyg6G+mIVtLjBtLMO3Udls57A
         u6Cva3YZgaGgzAwldAXKP5fzDTHY7jkiW5YSJhQcrK0a7A/7t/3nA3F9pZ7h5XCZdIxZ
         8a8g==
X-Gm-Message-State: AOAM530BtTuYf9ZaXA2D8jBYRHzN9FldPf6bj6aK1xR/5BNAM0GLL8Ry
        ne6dyglbM0U2kkmjIE6Vjm1oUWhvaI9n4rs+w2Mn+KhFkrTNFRpyd9tXf6NjlloV1/QDKZzADm/
        Sd71c/DdL3aCIkMulfvmIT3aqtLsBrdpoyGop6dmO
X-Received: by 2002:a25:b21c:: with SMTP id i28mr3146553ybj.340.1644606131724;
        Fri, 11 Feb 2022 11:02:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYUFvjxz9AR6X+PhbjsVUwP5fVasLhZdlrYK99Hz6fiZn9cSScfFVxKFtghFHfle1TtJOhtINrfIwjeIImGcQ=
X-Received: by 2002:a25:b21c:: with SMTP id i28mr3146511ybj.340.1644606131342;
 Fri, 11 Feb 2022 11:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20220208094334.16379-1-mgorman@techsingularity.net>
 <20220208094334.16379-3-mgorman@techsingularity.net> <9ab0a2c2-7dee-40b0-edd0-56a5b1915745@amd.com>
 <20220209103358.GP3366@techsingularity.net>
In-Reply-To: <20220209103358.GP3366@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 11 Feb 2022 20:02:00 +0100
Message-ID: <CAE4VaGDZ1Tf5UuDz+nB5OhAD70395-sXZgMNa2G69BJs2fafEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

we have tested 5.17.0_rc2 + v6 of your patch series and the results
are very good!

We see performance gains up to 25% for the hackbench (32 processes).
Even more importantly, we don't see any performance losses that we
have experienced with the previous versions of the patch series for
NAS and SPECjbb2005 workloads.

Tested-by: Jirka Hladky <jhladky@redhat.com>

Thanks a lot
Jirka


On Wed, Feb 9, 2022 at 12:08 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Feb 09, 2022 at 10:40:15AM +0530, K Prateek Nayak wrote:
> > There is a significant improvement throughout the board
> > with v6 outperforming tip/sched/core in every case!
> >
> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> >
>
> Thanks very much Prateek and Gautham for reviewing and testing!
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

