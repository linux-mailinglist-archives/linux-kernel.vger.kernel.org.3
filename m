Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CE5782F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiGRNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiGRNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19BEF63D4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658149292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eys+Z4CsioRJRql2AEhhAjwV+0wb8WqObF1vNqWzRYU=;
        b=EZ5umrgXSrB/R5J7Kt52vjjU+CTFgRsey5t8ShZEsDOqtrLMuAczj8hSQV63+IVErTEctB
        hXuZf0JOeNFtaHdBZme2SpywTasSNZESQg/fjFCLHYzZZM2POaMieZEwrni/YGa3aq6w99
        PEFZWG16HDiPLMQTFDTz9TKewKBo1KE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-P4c5r4vuMnWNoLwee76Yeg-1; Mon, 18 Jul 2022 09:01:28 -0400
X-MC-Unique: P4c5r4vuMnWNoLwee76Yeg-1
Received: by mail-wr1-f72.google.com with SMTP id v23-20020adfa1d7000000b0021d620f5ef3so1989127wrv.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eys+Z4CsioRJRql2AEhhAjwV+0wb8WqObF1vNqWzRYU=;
        b=4qh5EtJ4TNGVXKDIoSMy8yToF6kQy9covEmXpUHP4d3yhQ3xRcxVmX8/2k16FHn4Aa
         IOZL82KL1qB5+S0H1ktRkKECThDCCZGkAv0iwKpa3KkZFrHF17LcKMvus0WOD3ZU2yXZ
         zaPrJvQaQQpdiE6JkewbClefO43dafgrxa2PW23sfg/VZGhtFZaYzIAls6lX0JQo2kaz
         QIy9p/zVvPJYksqBtoKD8O4s+rkgpKAFTzi4Q/sLZQwk1V6pjWuRLaN7kJtwhKM2C1XJ
         YpH0DfQafX9rAFsRKOf/xgwMQgcU8waYs/2jTFCbhJPF4RDHeYzmbeRygOVIzr7VRBuF
         w4sg==
X-Gm-Message-State: AJIora8MvAX5tLiyMcCcXmSF/Y5OUZ0G5Fpa0SZHVqjX4Un2o+JYZJP/
        +rYJIQq3DxfqouvTnSfzWBKwHaWujVoeo0DUHON1boBBZxbToiinHTB3vJ0pClnLpiKgOQ+kohB
        Elh6p7/NuBQHjjO7F3AEEtRJZ
X-Received: by 2002:a05:600c:348d:b0:3a3:1fe6:6b38 with SMTP id a13-20020a05600c348d00b003a31fe66b38mr1467576wmq.144.1658149287014;
        Mon, 18 Jul 2022 06:01:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXuNVNsIeKnZKdua0sBlCscP7wWrQFFJY6q2dJH6v/YJjUFsSjlnw3rB0/veB2xpWl9vf6nQ==
X-Received: by 2002:a05:600c:348d:b0:3a3:1fe6:6b38 with SMTP id a13-20020a05600c348d00b003a31fe66b38mr1467515wmq.144.1658149286348;
        Mon, 18 Jul 2022 06:01:26 -0700 (PDT)
Received: from localhost.localdomain ([151.29.59.195])
        by smtp.gmail.com with ESMTPSA id q10-20020adfab0a000000b0021d4155cd6fsm10667881wrc.53.2022.07.18.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:01:25 -0700 (PDT)
Date:   Mon, 18 Jul 2022 15:01:22 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Ankit Jain <ankitja@vmware.com>
Cc:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>,
        Him Kalyan Bordoloi <bordoloih@vmware.com>,
        Keerthana Kalyanasundaram <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <YtVZokpe+l50EpWs@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
 <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
 <YtEbd2WjIOB6nXvr@localhost.localdomain>
 <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/22 07:46, Ankit Jain wrote:

...

> Hi Juri,
> 
> Actually, while testing I already included below commits in 4.19-rt :
> 
> feff2e65efd8d84cf831668e182b2ce73c604bbb (sched/deadline: Unthrottle PI boosted threads while
>  enqueuing)
> 46fcc4b00c3cca8adb9b7c9afdd499f64e427135 (sched/deadline: Fix stale throttling on de-/boosted tasks)
> 2279f540ea7d05f22d2f0c4224319330228586bc (sched/deadline: Fix priority inheritance with multiple)
> 0e3872499de1a1230cef5221607d71aa09264bd5 (kernel/sched: Remove dl_boosted flag comment)

Interesting.

Is the workload you are using to test this easily reproducible? I'd like
to try that out on my end to check if I see the same (of course the
issue I was working on goes away with my fix :).

Best,
Juri

