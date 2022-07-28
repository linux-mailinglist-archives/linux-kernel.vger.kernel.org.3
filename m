Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99858445C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiG1QuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiG1QuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 990C21CE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659027005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIy76qh/yn6fLhiFpSUVtVzXiaOXTimgQYvl1mAlPk8=;
        b=izCOrgwX+vubwJogOZbdPORq/zVRGFxL1KvCRJypQH5E3BE541Tu8S/40Vp3HI8khUEmwG
        VvrsAEJA3necD53s72ICswVda39IiiZQ6zmz4n/8oUwz4NaFa8k6DszEhFCNLUFFdIEX0p
        rAQuDAjsSvRbUBiTueQJkIaZsXknUNU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-9i0KJamRNYOyoCsuOlje2w-1; Thu, 28 Jul 2022 12:50:04 -0400
X-MC-Unique: 9i0KJamRNYOyoCsuOlje2w-1
Received: by mail-wr1-f70.google.com with SMTP id h18-20020adfaa92000000b0021ec200d50fso576903wrc.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kIy76qh/yn6fLhiFpSUVtVzXiaOXTimgQYvl1mAlPk8=;
        b=4LIttzm3MYqL5ViMyfHgbMZtPFYGcSoednYv0QFo7dpmdv/Ey5p1VCG8vcwZWEVweR
         UrD06eTcJkaP4EhzT/eSByNxCDbpazBIHqwiDAqOop3jG3SGNZGAO4At4dZtB/0Vv5rq
         VEUJZyL5y8RnR3TOHsoIXNjU1tnAHaWbgKpfWbSy3nU3nFv1WHEcHwUzV/sevnQHwiSy
         foeY6Bkqg8H8o27/kxPwFkSkdexC/2h2clZdIFeUEROnVOzH5+Nw6yjDu8AxBBwZUTN0
         sg3WgQm7ImYpJYr/Kvk8G2+otAd1Tz+/HFjyMuGSnFQpb2Cl0QCYRrn6ArzegWlpc3m8
         v3uA==
X-Gm-Message-State: AJIora9rwf+Cp0Yf0OWk+CaKlKwvubFqkVM06iKcNqlkMbk687hrwUlT
        QzON9JSk07prhrKS/QbvCCEec7qfDJdcl4tJc5kLHqDawZmiMPFbis4b1mz5/hcRieJOH169AHX
        UsSgl6FlLVYILc91yE/8qdPNlY6dLA6z73id0MstrmQjdoM+pJHR0FvKmGcUK+uoNxwXU1jWOzT
        eq
X-Received: by 2002:a5d:6e88:0:b0:21a:3403:9aa0 with SMTP id k8-20020a5d6e88000000b0021a34039aa0mr18752415wrz.379.1659027002895;
        Thu, 28 Jul 2022 09:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sV2ZxJpo254QMEOwrfsEQMmSwY/r9IAoxCasnNvv82dZ0NXLiauf6oEhaA7uerPugkOgzuag==
X-Received: by 2002:a5d:6e88:0:b0:21a:3403:9aa0 with SMTP id k8-20020a5d6e88000000b0021a34039aa0mr18752393wrz.379.1659027002687;
        Thu, 28 Jul 2022 09:50:02 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id k11-20020a05600c0b4b00b003a37d8b864esm1648515wmr.30.2022.07.28.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:50:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Waiman Long <longman@redhat.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
In-Reply-To: <a58852b4-313a-9271-f31d-f79a91ec188b@redhat.com>
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728144420.GA27407@blackbody.suse.cz>
 <a58852b4-313a-9271-f31d-f79a91ec188b@redhat.com>
Date:   Thu, 28 Jul 2022 17:50:01 +0100
Message-ID: <xhsmhbkt9dvwm.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/22 10:59, Waiman Long wrote:
> On 7/28/22 10:44, Michal Koutn=C3=BD wrote:
>> This should apply only to tasks that were extracted out of the root
>> cgroup, no? (OK, those are all processes practically.)
> The reset is done on all cgroups in a particular subtree. In the case of
> cgroup root, it is all the processes in the system.
>>

I've been briefly playing with this, tasks in the cgroup root don't seem
affected on my end (QEMU + buildroot + latest tip/sched/core):

  $ mount -t cgroup2 none /sys/fs/cgroup
  $ /root/loop.sh &
  $ PID=3D$!
  $ taskset -pc 2-3 $PID
  pid 177's current affinity list: 0-3
  pid 177's new affinity list: 2,3
  $ echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
  $ taskset -pc $PID
  pid 177's current affinity list: 2,3

However tasks extracted out as mentioned by Michal definitely are:

  $ mount -t cgroup2 none /sys/fs/cgroup
  $ /root/loop.sh &
  $ PID=3D$!
  $ taskset -pc 2-3 $PID
  pid 172's current affinity list: 0-3
  pid 172's new affinity list: 2,3
  $ mkdir /sys/fs/cgroup/foobar
  $ echo $PID > /sys/fs/cgroup/foobar/cgroup.procs
  $ taskset -pc $PID
  pid 172's current affinity list: 2,3
  $ echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
  $ taskset -pc $PID
  pid 172's current affinity list: 0-3

IIUC this is just what happens anytime a task gets migrated to a new
cpuset. Initially loop.sh remains attached to the root cpuset, and the echo
+cpuset migrates it to the /foobar one.

Does that match what you're seeing?

