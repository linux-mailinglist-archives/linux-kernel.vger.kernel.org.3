Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2928C48E21F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiANBWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:22:20 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30277 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiANBWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:22:18 -0500
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JZk676NnZzbjtp;
        Fri, 14 Jan 2022 09:21:35 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 14 Jan 2022 09:22:16 +0800
Subject: Re: Flush the hold queue fall into an infinite loop.
To:     Paul Moore <paul@paul-moore.com>
CC:     <linux-audit@redhat.com>, Xiujianfeng <xiujianfeng@huawei.com>,
        wangweiyang <wangweiyang2@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <96f4f1cb-0e7d-6682-ce33-f7f1314cba83@huawei.com>
 <8b487a19-d121-5fee-eda5-0aee9340f453@huawei.com>
 <CAHC9VhTGTmNzFURkAPm2LW3qL+ijBi=UmXqZBwEWeusC46+8yg@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <c0f9b9b3-69a3-1b31-5115-51dd580e00ca@huawei.com>
Date:   Fri, 14 Jan 2022 09:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTGTmNzFURkAPm2LW3qL+ijBi=UmXqZBwEWeusC46+8yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to stop droping the logs into audit_hold_queue when the auditd is abnormal.it
seems that this modification goes against the design intent of audit_hold_queue. its
effect is similar to removing the audit_hold_queue.

diff --git a/kernel/audit.c b/kernel/audit.c
index 2a38cbaf3ddb..a8091b1a6587 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -748,6 +748,7 @@ static int kauditd_send_queue(struct sock *sk, u32 
portid,
                                         (*err_hook)(skb);
                                 if (rc == -EAGAIN)
                                         rc = 0;
+                               audit_default = AUDIT_OFF;
                                 /* continue to drain the queue */
                                 continue;
                         } else
@@ -755,6 +756,7 @@ static int kauditd_send_queue(struct sock *sk, u32 
portid,
                 } else {
                         /* skb sent - drop the extra reference and 
continue */
                         consume_skb(skb);
+                       audit_default = audit_enabled;
                         failed = 0;
                 }
         }

在 2022/1/13 23:22, Paul Moore 写道:
> On Thu, Jan 13, 2022 at 6:57 AM cuigaosheng <cuigaosheng1@huawei.com> wrote:
>> When we add "audit=1" to the cmdline, kauditd will take up 100%
>> cpu resource.As follows:
>>
>> configurations:
>> auditctl -b 64
>> auditctl --backlog_wait_time 60000
>> auditctl -r 0
>> auditctl -w /root/aaa  -p wrx
>> shell scripts：
>> #!/bin/bash
>> i=0
>> while [ $i -le 66 ]
>> do
>>     touch /root/aaa
>>     let i++
>> done
>> mandatory conditions:
>>
>> add "audit=1" to the cmdline, and kill -19 pid_number(for /sbin/auditd).
>>
>>   As long as we keep the audit_hold_queue non-empty, flush the hold queue will fall into
>>   an infinite loop.
>>
>> 713 static int kauditd_send_queue(struct sock *sk, u32 portid,
>>   714                               struct sk_buff_head *queue,
>>   715                               unsigned int retry_limit,
>>   716                               void (*skb_hook)(struct sk_buff *skb),
>>   717                               void (*err_hook)(struct sk_buff *skb))
>>   718 {
>>   719         int rc = 0;
>>   720         struct sk_buff *skb;
>>   721         unsigned int failed = 0;
>>   722
>>   723         /* NOTE: kauditd_thread takes care of all our locking, we just use
>>   724          *       the netlink info passed to us (e.g. sk and portid) */
>>   725
>>   726         while ((skb = skb_dequeue(queue))) {
>>   727                 /* call the skb_hook for each skb we touch */
>>   728                 if (skb_hook)
>>   729                         (*skb_hook)(skb);
>>   730
>>   731                 /* can we send to anyone via unicast? */
>>   732                 if (!sk) {
>>   733                         if (err_hook)
>>   734                                 (*err_hook)(skb);
>>   735                         continue;
>>   736                 }
>>   737
>>   738 retry:
>>   739                 /* grab an extra skb reference in case of error */
>>   740                 skb_get(skb);
>>   741                 rc = netlink_unicast(sk, skb, portid, 0);
>>   742                 if (rc < 0) {
>>   743                         /* send failed - try a few times unless fatal error */
>>   744                         if (++failed >= retry_limit ||
>>   745                             rc == -ECONNREFUSED || rc == -EPERM) {
>>   746                                 sk = NULL;
>>   747                                 if (err_hook)
>>   748                                         (*err_hook)(skb);
>>   749                                 if (rc == -EAGAIN)
>>   750                                         rc = 0;
>>   751                                 /* continue to drain the queue */
>>   752                                 continue;
>>   753                         } else
>>   754                                 goto retry;
>>   755                 } else {
>>   756                         /* skb sent - drop the extra reference and continue */
>>   757                         consume_skb(skb);
>>   758                         failed = 0;
>>   759                 }
>>   760         }
>>   761
>>   762         return (rc >= 0 ? 0 : rc);
>>   763 }
>>
>> When kauditd attempt to flush the hold queue, the queue parameter is &audit_hold_queue,
>> and if netlink_unicast(line 741 ) return -EAGAIN, sk will be NULL(line 746), so err_hook(kauditd_rehold_skb)
>> will be call. Then continue, skb_dequeue(line 726) and err_hook(kauditd_rehold_skb,line 733) will
>> fall into an infinite loop.
>> I don't really understand the value of audit_hold_queue, can we remove it, or stop droping the logs
>> into kauditd_rehold_skb when the auditd is abnormal?
> Thanks Gaosheng for the bug report, I'm able to reproduce this and I'm
> looking into it now.  I'll report back when I have a better idea of
> the problem and a potential fix.
>
