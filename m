Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90785535B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiE0Iaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiE0Iag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C90AED8E9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653640234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TR2Yi3TabZ8KESWGazD0t1fMBCkgs8Tx+KayBLPN0TE=;
        b=Y7DGNkLLTwLv4mmR06IG6D3xejKyAxu2WPpGbjnVToV+nzByd6EnsbvdlAZOLSP8ZSMlTt
        m9taZrjZHI9UVJEqDSgL/Pk91g7MqKiMRiGkT4WYtRGO45aFB4u1Vj+JyjKtvDCUsR1Hqt
        ky6y3xb1xOUCuH0G4MWaYgh1tMkwUkQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-4cbmlTqrPM-RFas1jjyhHw-1; Fri, 27 May 2022 04:30:31 -0400
X-MC-Unique: 4cbmlTqrPM-RFas1jjyhHw-1
Received: by mail-qv1-f72.google.com with SMTP id kk13-20020a056214508d00b004622b4b8762so2952368qvb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TR2Yi3TabZ8KESWGazD0t1fMBCkgs8Tx+KayBLPN0TE=;
        b=p/zIa4h4qsucyTYxBvKY0pHJzAPbCNRnKHLuxBvEomjaZZX/gpIHsGbCuhYryGLCtC
         7+Yb91nc4wD8c8tj1WGhcJfu3gdaP1IqVmcEYoGsOh/BoBE5oe7WfVEVnmMM1Mpq37PQ
         bAM//lD/zZYtkziJqq5pywVCwQwa3CQNmGUJrPIzMM3aCcJossJm0I/cYre0AmhcUjd4
         /Q8Kal7p0UV99xik5A2wN2KCnOUIsrxtdt0PiM5af/0BbOmfs0XQDiuLjQyoyYdqSsEg
         XM8VmBReg5RsYN90Van/+V2lZMrx8L5LUxMje6HfhI+Wx8ZF/jRd8NsTl62fBPskr+7p
         KBZQ==
X-Gm-Message-State: AOAM532060m4BtdQ/edRmv6mWuX1FLjaqrOakanIOfGkMrBnuT2fcyt0
        wfVLK+HPVhJ15MeCIYPsyUYJNa2zWwFYr5XTJOsDr4wgc8HAEvRJa5EceUltTuI2T5ERV9SVsx6
        4yewhIfVB67KZNIIGqsh2YLaf
X-Received: by 2002:a05:622a:1456:b0:2f9:4569:1338 with SMTP id v22-20020a05622a145600b002f945691338mr13565892qtx.385.1653640231180;
        Fri, 27 May 2022 01:30:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya/0SapQcwBr/iLbWrDlhntpdfbhznqsLbuxqJJCuXCslAXkh5RvQSrs/hMKYnkRqFHAY6eA==
X-Received: by 2002:a05:622a:1456:b0:2f9:4569:1338 with SMTP id v22-20020a05622a145600b002f945691338mr13565871qtx.385.1653640230917;
        Fri, 27 May 2022 01:30:30 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id l21-20020a37a215000000b006a377a015d4sm2483596qke.39.2022.05.27.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:30:30 -0700 (PDT)
Date:   Fri, 27 May 2022 10:30:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpAdSW8JXVPOoNJl@slm.duckdns.org>
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

On 26/05/22 14:37, Tejun Heo wrote:
> On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> > I am thinking along the line that it will not be hierarchical. However,
> > cpuset can be useful if we want to have multiple isolated partitions
> > underneath the top cpuset with different isolation attributes, but no more
> > sub-isolated partition with sub-attributes underneath them. IOW, we can only
> > set them at the first level under top_cpuset. Will that be useful?
> 
> At that point, I'd just prefer to have it under /proc or /sys.

FWIW, I was under the impression that this would nicely fit along the
side of other feaures towards implenting dynamic isolation of CPUs (say
https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
for example). Wouldn't be awkward to have to poke different places to
achieve isolation at runtime?

Also, I wonder if a proc/sys interface might be problematic for certain
middleware that is substantially based on using cgroups. I'll try to ask
around. :)

Best,
Juri

