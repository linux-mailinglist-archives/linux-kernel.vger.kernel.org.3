Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4664C5A087A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiHYFhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHYFhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:37:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4790C67
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:37:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 2so17633164pll.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=EJr+R7ARbeiugKJJbNfdiybcH6LH0V+lvHZhpBPikbU=;
        b=F4ZoMmuXAUNMQ6Dy6YOgASr/O8yTAgsXy1s9puhvSlZwA4cEt1dgLOs7+QuyNmJY3Y
         U5z7ECV2ka2nnSGdyNQvIJq/fWAy5UuIFiSSThrwiP7ElCljvgFLe7ro7MOzJ914/K6L
         e8jtIRp8uF7e1YHp1Sn6nYJ9ruIZbXLfs8J5kOmxwyOgZxJ3cGTkuRUhNC4CE0845XMZ
         f7p6w/easm2Sl9b2HrTh37PpjIRkYRZ+3hZJzfNv9sJ/C0+tuVaQ6dfcV/m8AWLXNyWS
         PdyjKFcMd6LqvWBGMnCxAeJZJK08PXq60UFauGKH7UhAbiNlsB7DnYTNI5RmOfyu2FBJ
         h0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=EJr+R7ARbeiugKJJbNfdiybcH6LH0V+lvHZhpBPikbU=;
        b=KRJ4wWnW351e5xN9ZOXmOprpP6h4fkdKKdcTqdr7y5y+W66F+GrI15lbTEmz6jsydQ
         3vi8Ip86G7q3b8SGZAwR62NHA9U2qlIatZ7xRBMdEV9D+dcIB7unzTUrhLUQM/7ShE2A
         r1bTi36pYFE2Zwt0JI9expfo+j7j9HxBL75J0Tt00W+rwf+NiNA/zHfhqaK54QIR4NdM
         DXRIK/HLOGR72G+hcs13oLU6L7eFNjp2rqhg+G7/XVStrD8f6hyxHyffgPtOstuW/d6D
         iqgzo/WUFs7LUUnaThjgvDD3scq0gGuLqd1ljIZ1UIQ9twGxUPf4WHTtJIFU7qpsY0dI
         xujg==
X-Gm-Message-State: ACgBeo04QLkluIK36Z4HnJ3bXFXqjLHrnoe0TH0ZcwUkyhb5xtej6rkQ
        oszi1y5MFgj+hyz0U5sFHS4=
X-Google-Smtp-Source: AA6agR6Qnw0NMeYgf6cBDjjN+ntg3LzC6liuMEvLgUzO8hOVP6d3PBIpzTfbrZEUzLYQCsR5AAT2gQ==
X-Received: by 2002:a17:903:22c4:b0:16f:a93:9197 with SMTP id y4-20020a17090322c400b0016f0a939197mr2402533plg.134.1661405864316;
        Wed, 24 Aug 2022 22:37:44 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.11])
        by smtp.gmail.com with ESMTPSA id b18-20020a62a112000000b005362314bf80sm11433082pff.67.2022.08.24.22.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 22:37:44 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com
Cc:     rostedt@goodmis.org, mingo@redhat.com, davem@davemloft.net,
        imagedong@tencent.com, dsahern@kernel.org, flyingpeng@tencent.com,
        dongli.zhang@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: skb: fix kfree_skb event output error in perf
Date:   Thu, 25 Aug 2022 13:37:38 +0800
Message-Id: <20220825053738.476903-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
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

From: Menglong Dong <imagedong@tencent.com>

As Eric reported, the 'reason' field is not presented when trace the
kfree_skb event by perf:

$ perf record -e skb:kfree_skb -a sleep 10
$ perf script
  ip_defrag 14605 [021]   221.614303:   skb:kfree_skb:
  skbaddr=0xffff9d2851242700 protocol=34525 location=0xffffffffa39346b1
  reason:

The cause seems to be passing kernel address directly to TP_printk(),
which is not right.

Therefore, fix this by adding a '__string' field to the TP_STRUCT of
kfree_skb, which is 'reason_str', and passing it to TP_printk().

(Not sure if we should still keep the 'reason' field in
TP_STRUCT__entry)

Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 include/trace/events/skb.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 45264e4bb254..7235554141c3 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,6 +24,7 @@ TRACE_EVENT(kfree_skb,
 		__field(void *,		location)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
+		__string(reason_str, drop_reasons[reason])
 	),
 
 	TP_fast_assign(
@@ -31,11 +32,12 @@ TRACE_EVENT(kfree_skb,
 		__entry->location = location;
 		__entry->protocol = ntohs(skb->protocol);
 		__entry->reason = reason;
+		__assign_str(reason_str, drop_reasons[reason]);
 	),
 
 	TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
 		  __entry->skbaddr, __entry->protocol, __entry->location,
-		  drop_reasons[__entry->reason])
+		  __get_str(reason_str))
 );
 
 TRACE_EVENT(consume_skb,
-- 
2.37.2

