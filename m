Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDC553284F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiEXKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiEXKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:52:05 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425403DDFD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:52:02 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24OApmZQ009433;
        Tue, 24 May 2022 19:51:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Tue, 24 May 2022 19:51:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24OApl4u009406
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 May 2022 19:51:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <43845fc4-eb41-e3c1-4e47-1cc80530ea09@I-love.SAKURA.ne.jp>
Date:   Tue, 24 May 2022 19:51:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
References: <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
 <Yod3S8jmle+LYlES@slm.duckdns.org>
 <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
 <YofLmMTAjNVM+9nQ@slm.duckdns.org>
 <d05f4745-ba08-61eb-4780-ddfe50d0f1b9@I-love.SAKURA.ne.jp>
 <YohxUC45xk523g9I@slm.duckdns.org>
 <e9df5f75-2958-db1b-462d-dba4a0455f44@I-love.SAKURA.ne.jp>
 <YovasFyOcKB6ZanQ@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YovasFyOcKB6ZanQ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, I'm planning to send a patch during this merge window for announcing
that flushing system-wide workqueues should be avoided. So far I made three
patterns shown below.

  Pattern 1: Use BUILD_BUG_ON() for flush_workqueue(system_*_wq), nothing for flush_scheduled_work().

    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220520&id=5015b3b61696f8f44e7113e5bc14f4a20cbf57ff

  Pattern 2: Use __compiletime_warning() for both flush_workqueue(system_*_wq) and flush_scheduled_work().

    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220523&id=84baad17cb8286b6b53b675f8c3d7343ee6a990c

  Pattern 3: Use __compiletime_warning() for both flush_workqueue(system_*_wq) and flush_scheduled_work().

    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220524&id=e449c388913ccd36641f7cc0c335029a7cc161f4

Unfortunately, there is no way to emit compiletime message as neither
warning nor error. Any approach that uses compiler attributes causes warning,
but not everybody use approach that doesn't use compiler attributes.

Not only init/Kconfig recommends CONFIG_WERROR=y (i.e. recommends
__compiletime_warning == __compiletime_error), commit 771c035372a036f8
("deprecate the '__deprecated' attribute warnings entirely and for good")
also discourages use of compiler warning. Thus, I can't tell which way to go.

In this merge window, all flush_workqueue(system_*_wq) users and some of
flush_scheduled_work() users will be removed. But I worry that new users
come in before I complete removing the remaining flush_scheduled_work() users.
Actually, https://syzkaller.appspot.com/bug?extid=bde0f89deacca7c765b8 was
an example of such new users found after I announced at
https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp .
I somehow want to teach in-tree, to-be-in-tree and out-of-tree users
about this change.

Must I drop __compiletime_warning() for flush_scheduled_work() part if I want to
send this change before all in-tree flush_scheduled_work() users are removed?

