Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB54BCB2D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 00:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiBSXqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 18:46:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiBSXqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 18:46:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD2B47078
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 15:46:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q1so1432579plx.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SE8/5k7kAYoXUtarIh1kOSgHwvbuz9lmCsQJJgavSvs=;
        b=R44rQ8rLMNPtPpJGi8dqiVqcwfJ1yhbrxm5J5Q8s4BdRphUOUX1eVlz6yPXLN8OhEu
         aL7Yv9vR0/3333D/f/zkysYFvYfVUOsowoteean3m9TZ0z8/oC79WfG0zZqIZ7n8u39S
         Z/yBsAVYtnriOawdomFODg0PZQKmCFTPDiSqixTNTB3hn1YxKnKWokx2BYzb1bU4va4L
         q2cAwOaxjZQALahh7w+QPgDwXySqakfrdm392K/HDsR1jUkUKD2E42uZ/xQ1DShf+r9H
         1hqBa20/qMo7/bzVKUt6uyD6ZmjJXE0xTlC/gngJqZMhaRA0oNhkdw0FajrpTRrc/CAI
         mGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SE8/5k7kAYoXUtarIh1kOSgHwvbuz9lmCsQJJgavSvs=;
        b=LEpcmaIsSUOlI84RV7HmvwNlsdkAhvFH2ikNRRyEeV8aezYXLEYFzLpQ8JTgBrSzjc
         ICiBShPHZns3I3cLACfGlP5+Y7F5QCpXzTpnsUdySwMoiQxYecIMmx1AljE2K3/AUwzO
         2dwY1/0fzxegmba950rajG7Mg/lJDF9+n1oIMCvP0g3QLbLxfaHP1T0uvhyqne43DLJa
         fATxsOgfd/+pbTOfuxnwh1vp4fIoj3T76t0DNtXnfWd+qwKk3x17nXmrV4qorax65As/
         5WtQXQbJ5PjaQUvaTKKfbVMRt08KAwNzC51d6GfozVLOFb7bJPJhPkdAQM+9vVDEWiIO
         r0hA==
X-Gm-Message-State: AOAM530RlSB++JO8HXIdrRRgzKIrc4ODEyganwZD6RRFwQTwV36PKIn8
        rKQZYf6Xhg9Mm3bFcY3uIe4=
X-Google-Smtp-Source: ABdhPJzWSRiH1A3/uLrXEMpzt7hbnK38D9JLtZOSASQLmj3eqm6PWnBCpllXZ8WqwoE0WCiRXkKhHA==
X-Received: by 2002:a17:90b:3eca:b0:1b9:b85e:87f6 with SMTP id rm10-20020a17090b3eca00b001b9b85e87f6mr19021939pjb.132.1645314372065;
        Sat, 19 Feb 2022 15:46:12 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:9903:f314:b63c:83a0])
        by smtp.gmail.com with ESMTPSA id x126sm7052318pfb.117.2022.02.19.15.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 15:46:11 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     maz@kernel.org
Cc:     21cnbao@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        song.bao.hua@hisilicon.com, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp before issuing ipi
Date:   Sun, 20 Feb 2022 12:46:00 +1300
Message-Id: <20220219234600.304774-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6432e7e97b828d887da8794c150161c4@kernel.org>
References: <6432e7e97b828d887da8794c150161c4@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	dsb(ishst);
>> 
>>  	for_each_cpu(cpu, mask) {
>>  		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
>
> I'm not opposed to that change, but I'm pretty curious whether this 
> makes
> any visible difference in practice. Could you measure the effect of this 
> change
> for any sort of IPI heavy workload?
> 
> Thanks,
> 
>          M.

In practice, at least I don't see much difference on the hardware I am
using. So the result probably depends on the implementaion of the real
hardwares.

I wrote a micro benchmark to measure the latency w/ and w/o the patch on
kunpeng920 with 96 cores(2 socket, each socket has 2dies, each die has
24 cores, cpu0-cpu47 belong to socket0, cpu48-95 belong to socket1) by
sending IPI to cpu0-cpu95 1000 times from an specified cpu:

#include <linux/module.h>
#include <linux/timekeeping.h>

static void ipi_latency_func(void *val)
{
}

static int __init ipi_latency_init(void)
{

        ktime_t stime, etime, delta;
        int cpu, i;
        int start = smp_processor_id();

        stime = ktime_get();
        for ( i = 0; i < 1000; i++)
                for (cpu = 0; cpu < 96; cpu++)
                        smp_call_function_single(cpu, ipi_latency_func, NULL, 1); 
        etime = ktime_get();

        delta = ktime_sub(etime, stime);

        printk("%s ipi from cpu%d to cpu0-95 delta of 1000times:%lld\n",
                        __func__, start, delta);

        return 0;
}
module_init(ipi_latency_init);

static void ipi_latency_exit(void)
{
}
module_exit(ipi_latency_exit);

MODULE_DESCRIPTION("IPI benchmark");
MODULE_LICENSE("GPL");

do the below 10times:
# taskset -c 0 insmod test.ko
# rmmod test

and the below 10times:
# taskset -c 48 insmod test.ko
# rmmod test

by taskset -c, I can change the source cpu sending IPI.

The result is as below:

vanilla kernel:
[  103.391684] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122237009
[  103.537256] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121364329
[  103.681276] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121420160
[  103.826254] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122392403
[  103.970209] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122371262
[  104.113879] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122041254
[  104.257444] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121594453
[  104.402432] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122592556
[  104.561434] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121601214
[  104.705561] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121732767

[  124.592944] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:147048939
[  124.779280] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:147467842
[  124.958162] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:146448676
[  125.129253] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:141537482
[  125.298848] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:147161504
[  125.471531] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:147833787
[  125.643133] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:147438445
[  125.814530] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:146806172
[  125.989677] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:145971002
[  126.159497] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:147780655

patched kernel:
[  428.828167] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122195849
[  428.970822] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122361042
[  429.111058] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122528494
[  429.257704] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121155045
[  429.410186] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121608565
[  429.570171] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121613673
[  429.718181] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121593737
[  429.862615] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:121953875
[  430.002796] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122102741
[  430.142741] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122005473

[  516.642812] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:145610926
[  516.817002] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:145878266
[  517.004665] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:145602966
[  517.188758] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:145658672
[  517.372409] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:141329497
[  517.557313] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:146323829
[  517.733107] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:146015196
[  517.921491] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:146439231
[  518.093129] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:146106916
[  518.264162] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:145097868

So there is no much difference between vanilla and patched kernel.

What really makes me worried about my hardware is that IPI sent from the second socket
always shows worse performance than the first socket. This seems to be a problem
worth investigation.

Thanks
Barry
