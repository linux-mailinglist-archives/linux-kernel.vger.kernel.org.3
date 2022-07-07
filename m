Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68092569CEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiGGIMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiGGILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:11:55 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 700DA4D178
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0HzhM
        FxpifCBbW6I6z0WZTmqc/mz0kk5U7sD4ONHr8Y=; b=nYlki+Qz653MUyXmP9S9N
        dp2gcB9vQ5/El97/KrnDZ/IDUnfW7r1wO1WONyuUyL4e2ZSWIawgua7fz5D9pYn9
        /uMnT8eAUoHfYejKPuInRUphjgGoWMmHovWYb4MEgNoL4hqhhtg9S4MM6y3Jhjsx
        N4gtFzmdMsLLHpxOKQvqe0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgCH1Xk8lcZidfLLGA--.27011S2;
        Thu, 07 Jul 2022 16:11:41 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] arm-cci: Fix refcount leak bugs
Date:   Thu,  7 Jul 2022 16:11:39 +0800
Message-Id: <20220707081139.308849-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgCH1Xk8lcZidfLLGA--.27011S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DCF4UWrWrZF47CF4rZrb_yoW5Gr4Upa
        yYkrWYyrW8Kr4xKFZ2ya45AFZYg34IkrW3Ca47GFnI9wn8JFyYqr409F90vr15AF97Ja4r
        trs8tF15Ca1vv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEjg4dUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgU3F1-HZdEL9gAAsu
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, there are several bugs:

(1) In cci_probe(), we should call of_node_put() for the refernece
returned by of_find_matching_node() which has increased the refcount.

(2) In __cci_ace_get_port(), we should call of_node_put() in fail path
or when the reference is not used anymore as the reference is returned
by of_parse_phandle() which has increased the refcount.

(3) In cci_ace_init_ports(), we should call of_node_put() when the
referne is not used anymore as the of_get_cpu_node() will increase
the refcount.

(4) In cci_probe_ports(), we should call of_node_put() when breaking
out of for_each_available_child_of_node() which will automatically
increase and decrease refcount. Besides, we should also call
of_node_get() for the new reference created in 'ports[i].dn'.

Fixes: ed69bdd8fd9b ("drivers: bus: add ARM CCI support")
Signed-off-by: Liang He <windhl@126.com>
---

 For bug(4), I have not found when the global 'ports' is destroyed,
so I cannot use 'of_node_put()' for its 'dn'. Please check it carefully.

 drivers/bus/arm-cci.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..d8e66022de5c 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -167,9 +167,12 @@ static int __cci_ace_get_port(struct device_node *dn, int type)
 	cci_portn = of_parse_phandle(dn, "cci-control-port", 0);
 	for (i = 0; i < nb_cci_ports; i++) {
 		ace_match = ports[i].type == type;
-		if (ace_match && cci_portn == ports[i].dn)
+		if (ace_match && cci_portn == ports[i].dn) {
+			of_node_put(cci_portn);
 			return i;
+		}
 	}
+	of_node_put(cci_portn);
 	return -ENODEV;
 }
 
@@ -199,6 +202,7 @@ static void cci_ace_init_ports(void)
 			continue;
 
 		port = __cci_ace_get_port(cpun, ACE_PORT);
+		of_node_put(cpun);
 		if (port < 0)
 			continue;
 
@@ -461,8 +465,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
@@ -498,7 +504,7 @@ static int cci_probe_ports(struct device_node *np)
 			ports[i].type = ACE_LITE_PORT;
 			++nb_ace_lite;
 		}
-		ports[i].dn = cp;
+		ports[i].dn = of_node_get(cp);
 	}
 
 	/*
@@ -551,7 +557,9 @@ static int cci_probe(void)
 		return -ENXIO;
 	}
 
-	return cci_probe_ports(np);
+	ret = cci_probe_ports(np);
+	of_node_put(np);
+	return ret;
 }
 
 static int cci_init_status = -EAGAIN;
-- 
2.25.1

