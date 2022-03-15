Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E84D96D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbiCOI5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiCOI5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:57:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4904D9C2;
        Tue, 15 Mar 2022 01:56:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r6so27413401wrr.2;
        Tue, 15 Mar 2022 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+9b1eA94wfP4i6MAVgWuHZj4pXzpE1FtolQLRVci5l0=;
        b=QjEfVsX4+qdHdmOCh+9K0nGg5N8WZAjOHXYq/YjA5UNMGT2h6ZKP4507RjVXer1NBK
         RpAOgKQL7NByXozBw9ay0z5UVzajz8cuop3HQZBcJ2jRUePmXcSoAabjxLnrLYV7D0Iu
         SQd+vcI/UWSTxGBs7l+aEzPP7GPhQ0zzP2g4RgtIqRTPiLhoUBAhD307ZepvwuFtujAM
         13bO6qMdkyrv1Xr5Bx2WoEt6e0t9gNXu659MjPa6ICMEPv25WBsxqw6nCcqG9XRPOQYj
         Mqn8KGDmYS+JIzdJ6oNWagOWr7L5xwJgWth4GfV0D1FdUyXXDL2IoIc0hLs5OyXY9iEu
         7CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+9b1eA94wfP4i6MAVgWuHZj4pXzpE1FtolQLRVci5l0=;
        b=QFYOdAvMoryPLGmbsk9NYz+1r0skP2l6iR+ir2chQqsAbGQQwZrGpJ/ERV0nAFVwgL
         z+xtfZwTV1ZBEPuue49azPjDPo4dj40rJN0GCh3c0F1OhGmrI3vLQEf6Ku8zYX7glxlQ
         qRbOGRh2Hc2OzL4VYfwfvvlBgVHPqbG7AHRs/d4tH8T18w3pMouXTmcHF31uiyMAQbt4
         pHcfd6Z1r8H7Z2PjKRv4ZHfTjkk83bpbA00/1QV1lDFxc4GqIjVEEtckcGAjpgrpBYPD
         WIAPEKAVFJ7qe6z8+4nq0LTw5jsEPbE6DbmpLK5LFZ5GJPU4WV2Jye/EnpSJJZIjyddk
         XpKA==
X-Gm-Message-State: AOAM531+gogDYm/W2FWCX+rbN/1Rb72tLxdulZ2huOXqB34KtsILOmj/
        xcgZTXqQMX60mY0544iBgK4=
X-Google-Smtp-Source: ABdhPJwiO4fI4TEOC9OkpnPcoHgV1zvTwwzhG81K66/p6v79SLGEfQaxkFswTwTdO5a/5WYnJcuIcQ==
X-Received: by 2002:a05:6000:15c3:b0:203:b7a0:ae6b with SMTP id y3-20020a05600015c300b00203b7a0ae6bmr6538739wry.692.1647334559883;
        Tue, 15 Mar 2022 01:55:59 -0700 (PDT)
Received: from felia.fritz.box (200116b8264e940055af9bf2b8e4e824.dip.versatel-1u1.de. [2001:16b8:264e:9400:55af:9bf2:b8e4:e824])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c2b04000000b0038a0e15ee13sm1698724wmr.8.2022.03.15.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:55:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] srcu: drop the needless initialization in srcu_gp_start()
Date:   Tue, 15 Mar 2022 09:55:49 +0100
Message-Id: <20220315085549.22033-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c7ef4c30f12 ("srcu: Make Tree SRCU able to operate without snp_node
array") initializes the local variable sdp differently depending on the
srcu's state in srcu_gp_start().

Hence, the initialization of sdp with the variable definition is not used
before its second initialization.

Drop the needless initialization in srcu_gp_start() to have clear code.

No functional change. Some changes in the resulting object code due to
various rearrangements by the compiler.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Paul, please pick this minor non-urgent clean-up patch.


 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 328dd9ba9037..470da67325d6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 static void srcu_gp_start(struct srcu_struct *ssp)
 {
-	struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
+	struct srcu_data *sdp;
 	int state;
 
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
-- 
2.17.1

