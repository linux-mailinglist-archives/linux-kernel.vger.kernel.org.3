Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292B55263D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349341AbiEMOWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354225AbiEMOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93D1F393
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652451710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XNGqTrEW6BLwV+eAEiNN6NXB1twRXEux4iCiLYrUS7c=;
        b=ZFlvgaiyVSX9M30eM3d3qMzU6b/C2IlXcWX38jev38E+pkt9Yya+FUOI54lKIROov0fkJv
        VUVluxNpD3SNCpFHxf1KmpFeVYQZ5e+GvctP2CFlPps8XY9q7pJTaCyIy01EQ0/hNiWOYe
        2zOWE1BRWgJkCER0yH5JSjGMcuTIQBQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-dBK5W3pFMfKJZdhPZrv0cw-1; Fri, 13 May 2022 10:21:49 -0400
X-MC-Unique: dBK5W3pFMfKJZdhPZrv0cw-1
Received: by mail-wr1-f69.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso2984449wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=XNGqTrEW6BLwV+eAEiNN6NXB1twRXEux4iCiLYrUS7c=;
        b=fkcE7EQmBbLCJnH3w9p8SgCbc2s48ed63filg/Wy9RHkoc9SMl96UdE5q77YB4i4rn
         lNqhLMYwfoVx2fWyI8HSxLgg9XuIJDR7K7nTaV5ERTw/TBoNZZv1PZLl0C3MLbvukTj1
         Ol7r787vXa36uopQOTurLEHP0cbG6f86cLLAYgWU2+LKUdxpHY0yirYoxL1ByVVHL9yA
         g/2Exq/8KHM0pnz5hKGTVErZNP+MB5nNA+0WHdTFgdaMyonzK65mf0QMfoAw9IIv4YKB
         mR/w98mM2cWY8EBF2kGG5uEgNfnw+VQW1Lx9wxKDz2PkIudt9qqSukm534RzX+NPhdWm
         ty6g==
X-Gm-Message-State: AOAM530kCt9sU133Vd06LELTBbN1gZPKpPEy3aLolQFcmJ0XcdnZOpdW
        C96nCgfjSBvqUeS1KwUb6nKZdqT2JkWgP2qMPiEPYgVdSfs1tsIZBhNVLenUNikzB9t+jVTH2yX
        F7fcvQKpvVTwuE7TvYlMHD+XaiGfKHs/5+M8rfSFTD0ZBt3z+6GEn0e4NNro6kkygWsvO/ipNNF
        upqds=
X-Received: by 2002:a05:600c:1d88:b0:394:97e8:8afd with SMTP id p8-20020a05600c1d8800b0039497e88afdmr15051935wms.203.1652451708239;
        Fri, 13 May 2022 07:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr5VFZH30/lfTJ9dNeorX/0AaIiOWhyUFQ3gk8X42NkB3NYxI3noNgyxmYUJ1ht48ikh0DyA==
X-Received: by 2002:a05:600c:1d88:b0:394:97e8:8afd with SMTP id p8-20020a05600c1d8800b0039497e88afdmr15051868wms.203.1652451707881;
        Fri, 13 May 2022 07:21:47 -0700 (PDT)
Received: from localhost.localdomain ([151.29.63.116])
        by smtp.gmail.com with ESMTPSA id y25-20020a1c4b19000000b0039489e1bbd6sm5284325wma.47.2022.05.13.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:21:47 -0700 (PDT)
Date:   Fri, 13 May 2022 16:21:43 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Phil Auld <pauld@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ben Segall <bsegall@google.com>, Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        patrick.bellasi@matbug.net,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rik van Riel <riel@surriel.com>,
        Hillf Danton <hdanton@sina.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Paul Turner <pjt@google.com>,
        Dario Faggioli <raistlin@linux.it>,
        Andi Kleen <ak@linux.intel.com>, Scott Wood <swood@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Karl Rister <krister@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>
Subject: [ANNOUNCE] CFP: CPU Isolation Microconference - Linux Plumbers
 Conference 2022
Message-ID: <Yn5pd/yB5TLmOZ3x@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU Isolation can be considered as an holistic functionality that stems
from a close combination of several kernel and userspace components
working together to shield workloads with extreme latency or performance
requirements from interruptions (also known as Operating System noise).
An example of such type of workloads are DPDK (Data Plane Development
Kit) use cases (Telco/5G) where even the shortest interruption (e.g., a
few microseconds to service an IPI) can cause packet losses, eventually
leading to exceeding QoS requirements.

Despite considerable improvements in the last few years towards
implementing full CPU Isolation (nohz_full, rcu_nocb, isolcpus, etc.), a
certain amount of issues remain to be addressed, as it is still
relatively simple to highlight sources of OS noise just by running
synthetic workloads mimicking polling (always running) type of
application similar to the ones mentioned above.

Recently, improvements and discussions about CPU isolation features have
been made and discussed in LKML [1,2,3], and tools such as osnoise
tracer and rtla osnoise [4,5] improved the CPU isolation analysis.
Nevertheless, this is an ongoing process, and discussions are needed to
speed up solutions for existing discussions and improve the existing
tools and methods.

With this microconference we thus want to get together to discuss open
problems, most notably: how to improve the identification of OS noise
sources (expanding runtime tracing and/or code inspection tools), how to
track them publicly (repo/DB) and how to tackle the sources of noise
that have already been identified (e.g, [1,2,3]).

A non exhaustive list of potential topics is:

- OS noise profiling (format and public DB for the community)
- Tracing to detect OS noise: the rtla osnoise tracer and what it’s
  missing TLB/icache flush deferral [1]
- Extend cpuset v2 cpu partition feature to replace isolcpus kernel
  cmdline
- rt-trace-bpf tool
- Task isolation
- smp_call_function API improvements

If you are interested in participating in this microconference and have
topics to propose, please use the LPC CfP process [6], and select "CPU
Isolation MC" for the "Track".

The submission deadline is June 30.

Come and join us in the discussion, we hope to see you there!

In case of doubts, feel free to contact the MC Leads:

Juri Lelli <juri.lelli@redhat.com>
Daniel Bristot de Oliveira <bristot@redhat.com>

refs.
1 - https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
2 - https://lore.kernel.org/lkml/20220315153132.717153751@fedora.localdomain/
3 - https://lore.kernel.org/lkml/20211103170512.2745765-1-nsaenzju@redhat.com/
4 - https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html
5 - https://www.kernel.org/doc/html/latest/tools/rtla/rtla-osnoise.html
6 - https://lpc.events/event/16/abstracts/

