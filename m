Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0642A4AD238
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiBHHco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBHHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:32:42 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DAC0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:32:41 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebc2.dynamic.kabel-deutschland.de [95.90.235.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0129961E64846;
        Tue,  8 Feb 2022 08:32:38 +0100 (CET)
Message-ID: <0baca95b-771f-2217-1098-2d0eee568ea7@molgen.mpg.de>
Date:   Tue, 8 Feb 2022 08:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: ppc64le: `NOHZ tick-stop error: Non-RCU local softirq work is
 pending, handler #20!!!` when turning off SMT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


On the POWER8 server IBM S822LC running Ubuntu 21.10, Linux 5.17-rc1+ 
built with

     $ grep HZ /boot/config-5.17.0-rc1+
     CONFIG_NO_HZ_COMMON=y
     # CONFIG_HZ_PERIODIC is not set
     CONFIG_NO_HZ_IDLE=y
     # CONFIG_NO_HZ_FULL is not set
     CONFIG_NO_HZ=y
     # CONFIG_HZ_100 is not set
     CONFIG_HZ_250=y
     # CONFIG_HZ_300 is not set
     # CONFIG_HZ_1000 is not set
     CONFIG_HZ=250

once warned about a NOHZ tick-stop error, when I executed `sudo 
/usr/sbin/ppc64_cpu --smt=off` (so that KVM would work).

```
$ dmesg
[    0.000000] Linux version 5.17.0-rc1+ 
(pmenzel@flughafenberlinbrandenburgwillybrandt.molgen.mpg.de) (Ubuntu 
clang version 13.0.0-2, LLD 13.0.0) #1 SMP Fri Jan 28 17:13:04 CET 2022
[…]
[271272.030262] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271272.305726] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271272.549790] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271274.885167] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.113896] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.412902] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.625245] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271275.833107] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271276.041391] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
[271277.244880] NOHZ tick-stop error: Non-RCU local softirq work is 
pending, handler #20!!!
```


Kind regards,

Paul
