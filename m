Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20AF54F66B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382245AbiFQLKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380571AbiFQLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E21916C57D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655464210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SShT3vcxqQroV09KuLPeNUVFL/VD0CKqEBxOX5fe8cQ=;
        b=fX/3Z8oT6z7LtTD/FWC75Rhz8jRFixBOHV3L6XkXsuvORRk/w/DdO4GQKAV4rm1Leao5mq
        Nr7q8w7z2D6yJL/GKbGgZOnC+J7iqyeRAJGWRmwEH2BtPn4n/Lwkl7h4nvSzSWJzIciGqB
        RxCt2VBZf636ops0BCxD952nltkz1vg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-uvX5TQs_OFqjjGGAX2CZIg-1; Fri, 17 Jun 2022 07:10:08 -0400
X-MC-Unique: uvX5TQs_OFqjjGGAX2CZIg-1
Received: by mail-wm1-f71.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so1447765wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SShT3vcxqQroV09KuLPeNUVFL/VD0CKqEBxOX5fe8cQ=;
        b=f6nPjKFVRygJcMpiHHDr0sjvSjGeLr5aJmgieKlkLu/RM2dnzPQPMsECI4cCCOZXqe
         JUD6+1iFuuolo3ORaTj0cfIDa73ULpVcMfmOVa4iQrXASPKdKAamw1sq11q3eR9a7KvC
         7v8PlQtVSq+Iy0tgjHZ/EW9F4dfnvjC/lkLHpNG5eQCztrxoFrv36CpT6fJFbIiNck22
         E9H9i3H8S3qV+kus/tSfwTK8AnihT5nqh6rU6UnKkBWnUBJS/zkxgIE7FO8yVt/T76B5
         P/loNh5+G+R75AYjaotp5cYzZ1z9k6RUEq7ZSVkNxoPtwwNsxEAokrpYZmkJ9gnzlath
         NEzQ==
X-Gm-Message-State: AJIora/BUpYxvmQ5YHhQmg00xROGB6FpdVJElkwgpMbQwPz/vGCFoRr9
        kOWXBCpz08AAyKa1EmC8ALxe77Q9d7PUp6mTHIPPxhHFnA/EJsanWzM71m9qxPWml3j2gFXAX09
        LUEOA9fkxgqK6wogyeOeZ/xYE
X-Received: by 2002:a05:6000:1d97:b0:210:25d6:e125 with SMTP id bk23-20020a0560001d9700b0021025d6e125mr8675657wrb.464.1655464207736;
        Fri, 17 Jun 2022 04:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAayzFQgEAXV+jhFgQVFluJPXrCa3GwlGC0FKLIUDxcVCUK/t2P5aewq7HaaHhl1yvuSI20w==
X-Received: by 2002:a05:6000:1d97:b0:210:25d6:e125 with SMTP id bk23-20020a0560001d9700b0021025d6e125mr8675639wrb.464.1655464207533;
        Fri, 17 Jun 2022 04:10:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b0020fc6590a12sm4264061wru.41.2022.06.17.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:10:06 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Brian Norris <briannorris@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] sched: Drop outdated compile-optimization comment
In-Reply-To: <20220615222745.3371892-1-briannorris@chromium.org>
References: <20220615222745.3371892-1-briannorris@chromium.org>
Date:   Fri, 17 Jun 2022 12:10:05 +0100
Message-ID: <xhsmhk09f7dgy.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/22 15:27, Brian Norris wrote:
> Looks like this exists from way back in 2011 (commit 095c0aa83e52
> ("sched: adjust scheduler cpu power for stolen time")), when there was a
> little more aggressive use of #if around these variables. That #if is
> gone, and the comment just confuses the reader now. (For one, we don't
> call sched_rt_avg_update() directly any more either.)
>

So that sched_rt_avg_update() became update_irq_load_avg() with

  91c27493e78d ("sched/irq: Add IRQ utilization tracking")

and then the #ifdef configs were reorganized in

  11d4afd4ff66 ("sched/pelt: Fix warning and clean up IRQ PELT config")

I'd argue that comment is still somewhat relevant but it applies to that
block:

#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
		update_irq_load_avg(rq, irq_delta + steal);
#endif

if !CONFIG_HAVE_SCHED_AVG_IRQ then yes you'd expect the compiler to not
even add a call to update_irq_load_avg() in there, but compilers aren't the
most trustworthy things :-) If you feel like it, you could play with
GCC/clang and see what they emit if you remove those #ifdefs.

