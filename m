Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5755943E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiFXHam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFXHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:30:39 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 00:30:38 PDT
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEAE35DD7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:30:37 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="65526012"
X-IronPort-AV: E=Sophos;i="5.92,218,1650898800"; 
   d="scan'208";a="65526012"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 24 Jun 2022 16:29:33 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id CAEB9A9010
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:29:32 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2AEC7F7D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:29:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 04842200B2A7;
        Fri, 24 Jun 2022 16:29:32 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     tglx@linutronix.de
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] hrtimer: CPU and entry_time is added to a warning message in hrtimer_interrupt()
Date:   Fri, 24 Jun 2022 16:09:17 +0900
Message-Id: <20220624070917.128409-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220624070011.128234-1-yamamoto.rei@jp.fujitsu.com>
References: <20220624070011.128234-1-yamamoto.rei@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 16:00:11, Rei Yamamoto wrote:
> dmesg
> :
> [ 1462.836971] start repro_hrtimer_interrupt
> [ 1462.836976] test_handler = test_handler [repro] 0xffff9788f7bb3048
> :
> [ 1462.879117] hrtimer: CPU 7, entry_time = 1462807264840, interrupt took
> 60048886 ns             ^^^^^               ^^^^^^^^^^^^^
> 
> cat /sys/kernel/debug/tracing/trace
> :
>           <idle>-0       [007] d.h1.  1462.838075: hrtimer_expire_entry:
>                          ^^^^^
> hrtimer=0000000041fcee42 function=test_handler [repro] now=1462807264840
>                                                            ^^^^^^^^^^^^^

test_handler() keeps running for 20 milliseconds due to a loop,
and it leads to exceed next_expire.

# grep -A 21 "hrtimer_restart test_handler" repro.c
static enum hrtimer_restart test_handler(struct hrtimer *hrtimer)
{
        ktime_t start, end;
        printk(KERN_INFO "start test_handler %d times\n", count);

        hrtimer_forward_now(hrtimer, ns_to_ktime(TICK_NSEC));

        start = ktime_get();

        for(;;){
                end = ktime_get();
                if((ktime_sub(end, start)) > 20000000)
                        break;
        }

        if(count < 20){
                count++;
                return HRTIMER_RESTART;
        }else{
                return HRTIMER_NORESTART;
        }
}

Thanks,
Rei
