Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF85793F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiGSHTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiGSHTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 013221EC7C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658215151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9hDHTDlizIptgWB6Wc2g1JY5Cp3r9WdCLFbnkktkQc=;
        b=cbNS8XTXG58vc+T0/GV/cZZOGSyNoUNjfC1GWf3dtqEEv3pN9Hn+SOXu91gF7l91Vl4utJ
        5yQW/tQYElI0UsHdwNUulc8oZ1D3BQsHJxm+OFj72LgBnPAs6uHeD7eP4TxMiProXgEao7
        uUj+QxWUWFNeUlY1Q1n6+Kmt1M4/BBg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-O_Ja-1FgP_qAUBsSCsl5gw-1; Tue, 19 Jul 2022 03:19:10 -0400
X-MC-Unique: O_Ja-1FgP_qAUBsSCsl5gw-1
Received: by mail-wr1-f69.google.com with SMTP id s16-20020adf9790000000b0021e36810385so144037wrb.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c9hDHTDlizIptgWB6Wc2g1JY5Cp3r9WdCLFbnkktkQc=;
        b=AhrZOdVNlNfHg5fYVWc7aZGutiFIxnFVFt46SkX3QQDyj9wqdMKKy1pdfEDTIIMJub
         n7yY7ChCppf7//lk7/ogJm2udhujs8PaZy9i4wZTOT3wTmtFFrfrvu/1xCkC/F8qh7jN
         Fq3x6Dqvz4LOpldZdIPZ1qOvMhfXdjgGpnj3/xZuY3CiZajn4pEfoGXDxCzusKdJCDj9
         uvt8eor3lvo6Kgr0sJlSqhjtplt6KYbBt9CaxHITlPe3anFfUjojOAOpb++ehrbUtLaA
         dR2MSQF/ZzqtQJ4Fk37NjguT8rhnQ+VDWIY1HDJvJ6pFZ5a/1ov8Fdf+vWqmte3wXbHA
         gVVQ==
X-Gm-Message-State: AJIora/RGMWBTws8aSDRCF9s7scgNecf2oS0E3C/LILGdYZ8GlTAZ0HD
        xZk2MTJLhgVaM8kVxBsytoV2pMWUsMbkkc4gJjsfdryssfRFhMaKPRteXifzgDQVNnZJ26OACCJ
        YI3fDxVbXexrwiGryYYnA4xrd
X-Received: by 2002:a05:600c:1e8d:b0:3a1:9eb0:fd81 with SMTP id be13-20020a05600c1e8d00b003a19eb0fd81mr28211948wmb.19.1658215149278;
        Tue, 19 Jul 2022 00:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAQs17h1Ymb8uk5JFCX89t+L/+vzCNvu6h2agEgN2ZYhi+24NX+nsWLtaM89NhetUbKjlAtg==
X-Received: by 2002:a05:600c:1e8d:b0:3a1:9eb0:fd81 with SMTP id be13-20020a05600c1e8d00b003a19eb0fd81mr28211917wmb.19.1658215149021;
        Tue, 19 Jul 2022 00:19:09 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.74])
        by smtp.gmail.com with ESMTPSA id j17-20020adfd211000000b002185631adf0sm12244730wrh.23.2022.07.19.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 00:19:08 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:19:05 +0200
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
Message-ID: <YtZa6YYnMPVUP345@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
 <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
 <YtEbd2WjIOB6nXvr@localhost.localdomain>
 <DC16804A-D429-402E-B076-783B6373D21C@vmware.com>
 <YtVZokpe+l50EpWs@localhost.localdomain>
 <B466E709-EFCF-4B27-B3F6-D7561C381BF7@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B466E709-EFCF-4B27-B3F6-D7561C381BF7@vmware.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/22 05:30, Ankit Jain wrote:
> 
> 
> > On 18-Jul-2022, at 6:31 PM, Juri Lelli <juri.lelli@redhat.com> wrote:
> > 
> > ⚠ External Email
> > 
> > On 18/07/22 07:46, Ankit Jain wrote:
> > 
> > ...
> > 
> >> Hi Juri,
> >> 
> >> Actually, while testing I already included below commits in 4.19-rt :
> >> 
> >> feff2e65efd8d84cf831668e182b2ce73c604bbb (sched/deadline: Unthrottle PI boosted threads while
> >> enqueuing)
> >> 46fcc4b00c3cca8adb9b7c9afdd499f64e427135 (sched/deadline: Fix stale throttling on de-/boosted tasks)
> >> 2279f540ea7d05f22d2f0c4224319330228586bc (sched/deadline: Fix priority inheritance with multiple)
> >> 0e3872499de1a1230cef5221607d71aa09264bd5 (kernel/sched: Remove dl_boosted flag comment)
> > 
> > Interesting.
> > 
> > Is the workload you are using to test this easily reproducible? I'd like
> > to try that out on my end to check if I see the same (of course the
> > issue I was working on goes away with my fix :).
> > 
> > Best,
> > Juri
> > 
> 
> Hi Juri,
> 
> The test with which i am able to hit the issue is as follows:
> 	• Schedule SCHED_FIFO/55 (sched_priority = 55) tasks running infinite loop on all isolated cores.
> 	• spwan 30-40 docker containers in loop (docker load , docker run)
> 	• Immediately after that schedule SCHED_FIFO/55 (sched_priority = 55) tasks running infinite loop on all isolated cores again.
> 	• BUG_ON gets hit almost every time.
> System config as follows:
> 	• 4.19-rt kernel
> 	• 40 cpu (0-1 housekeeping, 2-39 isol cpus)
> 	• stalld-1.3.0 with the fixes from latest version (for task starvation avoidance), "tuned" with real-time profile 

Thanks for the details. Yeah, I should be able to set this up on my end.
It might just take a bit though, as I have some pto planned coming up.
But, I'll get to it eventually.

Thanks again,
Juri

