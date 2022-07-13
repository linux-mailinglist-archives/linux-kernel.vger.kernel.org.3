Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B37573BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiGMRSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGMRSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EBB765FD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657732726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fB/Zu9mPceWP00NpRs7DLfPE5RMK6XwHrPMxpRqk4mQ=;
        b=GHJbG+UIjINUJ4PLHhz60NQnzActF9iry78siHDVxcMIIu18PVH01FjEm5VCmVfiMfwHII
        kYxRsqBlEUay//mXIbJuCjTn7p+JwDIOx1o9b0SO80JiGudE27p9tvp3OTRQVHTSUrFYiP
        Uzqc5tR4VwmqwTq77dOKCxCBlSwbV4w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-UTamI9ibPTSKxOXCum6iiA-1; Wed, 13 Jul 2022 13:18:45 -0400
X-MC-Unique: UTamI9ibPTSKxOXCum6iiA-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1152861wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=fB/Zu9mPceWP00NpRs7DLfPE5RMK6XwHrPMxpRqk4mQ=;
        b=7htXV861+dcnfSSDucstcsJ7Sd2XQqiVefiA8Rly7IdLOdqPufLEiBJdFFYVX+Td9d
         umYTwtj4/DCTX/RY2exKUsKMSZEhL1xcAcd+RfXBOO8E86SVnPPlFUpMtW7RBCbDYl9N
         km4qRaHUvLQ9X0iyBKeV+gweumygMlQhaxuUsMBMYK12o0Ykuhi5qJP4TyAhobNtg5TC
         u6+baB20KhnAeyqO4snSFbeCXMWvCWG4WDUOjGAxzmrsHfCbvcSNdOzCWXPmmqJfZgIe
         H8LzbyKggUVnWzbUxU1UXVtG0Q4SKLFko3Qw/k17ahonkd9aMuWE9zddNhzB7HVSDN+h
         X/jA==
X-Gm-Message-State: AJIora9T4XpQn5WfFeIbXFwFdOq8ufjEHgTaQR1Q8KLk8TyJ6ERM4cVr
        K+zWdoh9FWACHN5lNJp2UDdwyJnUDH+vdrHKXJcOFh5CL5wiIg4bdgj0rvG/w/+uy0xEkoOdQeh
        hPRbR3yWjOR/uWdzZX3KVMBfUpQqbQgaKMSFWraRAcJF+vTe1tItXy7L5DW7SlhbqJtKJyv9Ern
        W9
X-Received: by 2002:a05:600c:3b95:b0:3a2:e579:d196 with SMTP id n21-20020a05600c3b9500b003a2e579d196mr4847007wms.185.1657732724227;
        Wed, 13 Jul 2022 10:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u2tPaJyngwX1DO+Jqswo8UUqSE+a95Ncc+2bom+h2dbMWGyFJVyguTt9e8faRyz0pG5vqenA==
X-Received: by 2002:a05:600c:3b95:b0:3a2:e579:d196 with SMTP id n21-20020a05600c3b9500b003a2e579d196mr4846971wms.185.1657732723930;
        Wed, 13 Jul 2022 10:18:43 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3e07:e200:5f92:8384:b0a4:8063? ([2a0c:5a80:3e07:e200:5f92:8384:b0a4:8063])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003a2cf1535aasm3257593wml.17.2022.07.13.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 10:18:43 -0700 (PDT)
Message-ID: <a508ce3c711ebac73695af98a5d17187e22e74cb.camel@redhat.com>
Subject: Re: [PATCH] nohz/full, sched/rt: Fix missed tick-reenabling bug in
 dequeue_task_rt
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-kernel@vger.kernel.org, fweisbec@gmail.com
Cc:     bristot@redhat.com, vschneid@redhat.com, cmetcalf@ezchip.com,
        mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        mtosatti@redhat.com
Date:   Wed, 13 Jul 2022 19:18:42 +0200
In-Reply-To: <20220628092259.330171-1-nsaenzju@redhat.com>
References: <20220628092259.330171-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-28 at 11:22 +0200, Nicolas Saenz Julienne wrote:
> dequeue_task_rt() only decrements 'rt_rq->rt_nr_running' after having
> called sched_update_tick_dependency() preventing it from re-enabling the
> tick on systems that no longer have pending SCHED_RT tasks but have
> multiple runnable SCHED_OTHER tasks:
>=20
>   dequeue_task_rt()
>     dequeue_rt_entity()
>       dequeue_rt_stack()
>         dequeue_top_rt_rq()
> 	  sub_nr_running()	// decrements rq->nr_running
> 	    sched_update_tick_dependency()
> 	      sched_can_stop_tick()	// checks rq->rt.rt_nr_running,
> 	      ...
>         __dequeue_rt_entity()
>           dec_rt_tasks()	// decrements rq->rt.rt_nr_running
> 	  ...
>=20
> Every other scheduler class performs the operation in the opposite
> order, and sched_update_tick_dependency() expects the values to be
> updated as such. So avoid the misbehaviour by inverting the order in
> which the above operations are performed in the RT scheduler.
>=20
> Fixes: 76d92ac305f2 ("sched: Migrate sched to use new tick dependency mas=
k model")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---

Ping :)

--=20
Nicol=C3=A1s S=C3=A1enz

