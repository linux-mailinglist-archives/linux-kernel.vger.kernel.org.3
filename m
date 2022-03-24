Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2223C4E691A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352850AbiCXTLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbiCXTLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:11:46 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BC19C23;
        Thu, 24 Mar 2022 12:10:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 77D8B123380;
        Thu, 24 Mar 2022 19:10:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DA2EC123025;
        Thu, 24 Mar 2022 19:10:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1648149011; a=rsa-sha256;
        cv=none;
        b=spJtR+hcxoFnLVGEh7a9DH5ZBo+YFCqxFC/VNhUyLgDzVnHwuK1V1LKQdDCiJ8optrbPNY
        CipbUZeSp7QLBz4t2RwpII98bCea9qaPgTef+VRp2O98YrNueCyi5IB2Jk9RvzG+HbfRSa
        dfB7LisLiyvzHKiPsM5e6EOr23DS3sMvX9FiXO4h6itqZhyFRR0hcYNNw1+1lji3ORdQB9
        i6Hix49LAuapbZJ0zS4C0Z/VTomwDNh0JsTPfeD+YLcaFKFe2jVW69N59MXV8sbDLNxUCm
        Ko6+t4ym5yfiZcNxjnFnle0HhUwIZt+EMK1VwBvzIGtSS6FllRhU5LiMW2jiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1648149011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=pwKmYV1RoBxtzxKSXEKwAB9rqJlPOZrgOiJgt8hxgy4=;
        b=j7cKh35g5HOmBxVr5lI/luzslM1XGWa4ME8GBht/ttPo231t3lb9qE0NhVwl6CTjbxweZH
        8ZmJLIyJ7MKf6b3Op6g24sJhtM3vQq5JAd15go8TgITV+kxW1nUwYYFpuuCfGJM/RPWuJc
        KEgZ6rqrh7tKUu0ZuJjy9Eav9+bFnex6frWIKfN2cMfMVkR56LZv5LcMM7MAXdBBgP+ONj
        R3QnfNtUa0QeHzpQ8sM/nCkvkD322dHa+E0ysYAwf12NGFC9gFrkSIJcaQjt/EIsNljqTQ
        ZJtdGWW5Z4dWzmazdm2/3Aj01L1S4B/4Fa6flnJBAGHpFhc+OzkUSkYQED2OsQ==
ARC-Authentication-Results: i=1;
        rspamd-7b6f4d8d7c-jlxm8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.100 (trex/6.5.3);
        Thu, 24 Mar 2022 19:10:11 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Cooing: 1fede5b91cd265e9_1648149011319_3734797825
X-MC-Loop-Signature: 1648149011319:4135960393
X-MC-Ingress-Time: 1648149011319
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4KPZYC3PYNz3n;
        Thu, 24 Mar 2022 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1648149009;
        bh=pwKmYV1RoBxtzxKSXEKwAB9rqJlPOZrgOiJgt8hxgy4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=IpFB7+2K5Is8rvgQFUMnKvBjMs/w1DyQAUqZ5HBNz1nWzlzxlWUeXLdad1u26op46
         Wjzvh8RX/qtkvRptkje6TaFZlo3Hw+5kfkwAAIXAXhNYy53fvmsmwMRPJwaJikFc/Y
         sDZtf/AkPnMq4HQS5v4OLdqU8PpU6obOg3yL5ETpr9tnTPA/2o363eO0DFqNMZh+Cd
         TPYgB2YVPe9Jfmz2HxD+SvcZ5NVZGNBeyFCuN3fM682G92MVG51viFy51RwneWkUKp
         Ee0CQXiXv8gPkgmKI72FAjPLtatYgUsgE2B4Pno8kJL0Mts4R/F/klqoVeLbOo7959
         Q1svvRAGf9V8w==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 0/3] thermal: int340x: Misc acpi_buffer handling updates
Date:   Thu, 24 Mar 2022 12:09:47 -0700
Message-Id: <20220324190950.70486-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following is a fallout of eyeballing _OSC handling in the driver.
These changes have only been compile-tested. Patch 1 is a fix and the
other two are cleanups.

Thanks!

Davidlohr Bueso (3):
  thermal: int340x: Fix bogus acpi_buffer pointer freeing
  thermal: int340x: Consolidate freeing of acpi_buffer pointer
  thermal: int340x: Cleanup osc context init

 .../intel/int340x_thermal/int3400_thermal.c   | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

--
2.26.2

