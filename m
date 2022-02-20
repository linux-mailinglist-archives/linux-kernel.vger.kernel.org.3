Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF64BCB7E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 02:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbiBTBeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 20:34:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiBTBeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 20:34:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76973CA62
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 17:34:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l8so10100439pls.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 17:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZ8NsrnVmX9Djw5GkQPupP2noNGOaBfYcmgSSWfjjeQ=;
        b=R01TB2pwygCdRmhZKRnaNEJbTch3/f5nd07G5a1BoctSRMpsh1BaWPG76MuftxbzMd
         g6CtH/0L1EvT8pB6LdMQmOrRY5Z5gEu/Hro73yo3g02AKErUxiIt2ewEkK0mZojSBg1X
         CBK/Bpd250kLkN8HavvvNPZBQv0SGq5r4FXeFcXaMngiGbqxW2KVVdbg9vcWCv48ljUe
         24JO9/bPFDkkYLQqu2ZsKwYgZAY0g7LQH/Nc2Ac6pkc63vo92NS2ZPPPyMLcDriqNTiE
         /jvXhU/WGju0G1hO5NvP7f1ADMrBVit8/35z43AdsXsSF63GkiUF1qYvut15+enXTwdw
         qyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZ8NsrnVmX9Djw5GkQPupP2noNGOaBfYcmgSSWfjjeQ=;
        b=0p/Zt9SEo0VPq3h4XN8eBH/OGqo8aIsBcy3rvE+Q9+ubKKdxI6pOQMQlyvAZDY8NLU
         f2xUzWlGw4NOX7VOPJaexqPOy7ItAXTZx1cTp7EF/PX6j2XsEtPkOxt3T6gg5Zto5Wrc
         ZLABoY/r6r4aUdAfG+OgOge9cPb7skD+TWtooW2SqQueEOsJsIc1TjCT3tZW5Q9wb9Gy
         x1lQ6IO1Z4F6T/UjdaMx4vGK3NCpFH6vZWTOLe9j1r0gJM0sxXZV2cw9lhaGioFxKsef
         H8gTIm5WvH9dO/h7l1un+q/4qFPsEBo195qlZ7SDfkV4+dFXPWEtqA4WxMvUGW40NHkI
         lpBQ==
X-Gm-Message-State: AOAM532UkPVYACXiuR+kIXpz21IohYBTASGKXYSdCiwhWGh7+hVOd/AB
        OWLI+ykGexNMoteZzpOguxWK5DOwv30=
X-Google-Smtp-Source: ABdhPJy1C8ZC960D/LpXzxtCBcQMKWgwka+NtoZaoMeJ95FnT0xeE56zywnGSLagHXQi+DjWMnq5vA==
X-Received: by 2002:a17:902:e5c4:b0:14f:ab63:482d with SMTP id u4-20020a170902e5c400b0014fab63482dmr1267478plf.126.1645320843200;
        Sat, 19 Feb 2022 17:34:03 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:9903:f314:b63c:83a0])
        by smtp.gmail.com with ESMTPSA id e4sm13431706pgr.35.2022.02.19.17.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 17:34:02 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, maz@kernel.org, song.bao.hua@hisilicon.com,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp before issuing ipi
Date:   Sun, 20 Feb 2022 14:33:51 +1300
Message-Id: <20220220013351.311430-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220219234600.304774-1-21cnbao@gmail.com>
References: <20220219234600.304774-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So there is no much difference between vanilla and patched kernel.

Sorry, let me correct it.

I realize I should write some data before sending IPI. So I have changed the module
to be as below:

#include <linux/module.h>
#include <linux/timekeeping.h>

volatile int data0 ____cacheline_aligned;
volatile int data1 ____cacheline_aligned;
volatile int data2 ____cacheline_aligned;
volatile int data3 ____cacheline_aligned;
volatile int data4 ____cacheline_aligned;
volatile int data5 ____cacheline_aligned;
volatile int data6 ____cacheline_aligned;

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
                for (cpu = 0; cpu < 96; cpu++) {
                        data0 = data1 = data2 = data3 = data4 = data5 = data6 = cpu;
                        smp_call_function_single(cpu, ipi_latency_func, NULL, 1); 
                }   
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

after that, I can see ~1% difference between patched kernel and vanilla:

vanilla:
[  375.220131] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126757449
[  375.382596] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126784249
[  375.537975] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126177703
[  375.686823] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127022281
[  375.849967] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126184883
[  375.999173] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127374585
[  376.149565] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:125778089
[  376.298743] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126974441
[  376.451125] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127357625
[  376.606006] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126228184

[  371.405378] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:151851181
[  371.591642] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:151568608
[  371.767906] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:151853441
[  371.944031] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:152065453
[  372.114085] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:146122093
[  372.291345] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:151379636
[  372.459812] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:151854411
[  372.629708] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:145750720
[  372.807574] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:151629448
[  372.994979] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:151050253

patched kernel:
[  105.598815] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:124467401
[  105.748368] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123474209
[  105.900400] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123558497
[  106.043890] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122993951
[  106.191845] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122984223
[  106.348215] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123323609
[  106.501448] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:124507583
[  106.656358] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123386963
[  106.804367] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123340664
[  106.956331] ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123285324

[  108.930802] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:143616067
[  109.094750] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:148969821
[  109.267428] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:149648418
[  109.443274] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:149448903
[  109.621760] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:147882917
[  109.794611] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:148700282
[  109.975197] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:149050595
[  110.141543] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:143566604
[  110.315213] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:149202898
[  110.491008] ipi_latency_init ipi from cpu48 to cpu0-95 delta of 1000times:148958261

as you can see, while cpu0 is the source, vanilla takes 125xxxxxx-127xxxxxx ns, patched
kernel takes 122xxxxxx-124xxxxxx ns.

Thanks
Barry
