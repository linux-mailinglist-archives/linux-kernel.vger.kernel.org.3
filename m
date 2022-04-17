Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44B0504638
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 05:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiDQDwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 23:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiDQDwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 23:52:12 -0400
Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE013CE6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 20:49:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 85355120DBA;
        Sun, 17 Apr 2022 03:49:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B2C75120DB7;
        Sun, 17 Apr 2022 03:49:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650167376; a=rsa-sha256;
        cv=none;
        b=2AWpxcPXLhDqchTvOP7wkCpWhYrtq7R9zHGTYYpZnIH5oTyHgNlYc32F3RbX/xvEJbEUBj
        jLTuSmYZZJIcELFiUf0LJ6e7YzPK7OXUxpv7hZhvIkH0J5IOGlx/XO4cZb4pB+8lhEX82M
        8xRZZ/4ehCQclqHzbaU6TTNiixiRE6Z6G1/roRG9cjDdyp3P8yYuiVOsx7399f3QlPQuGH
        cWd0G6jCtiC/KToyXgLTHTyx8HM7FrZjf1bzeml4sGCHR3ndJpy3N1BsNWjbgqC5IkNI23
        O8vzg3saZOElypqmLJn4qAEv5yj5foRUbKUycc5n2JEeWW1VNHvqyWhOvao9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650167376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=TCFsTcqFrfctJCb7WwW2kivBjtsWElvnzgT7n+875Bg=;
        b=qBd3agOJD+t73EVdA8gGF3zUxw5gp0ZQZm7rjqqEn+H5gG1XwSQEaN1hz8YlaSrflbj3Ji
        YtpgMprQWdoAAihi11LfN75TJSco/HCsskglu39uZae/1Vu59uqBgVONqBtIjXDjkytdA/
        PGQ41Mx+nelxplkloAzEemazJiFKM5zVpT1cZQK2E6KhSdxinDlIqMuxeizHE0oVNqxEbc
        9BLyH48LnufZKM2AcSn/z2idbZGm8COHMYD7o2roqDShmBTCgsXtBETBEqkTsQl9IyFL/j
        WANmTfc2xIaN/uf/DCVHFBoo75Sw5ZgjmulyL+AwKpBJ0ul5Bxg3d/Ktblottg==
ARC-Authentication-Results: i=1;
        rspamd-5f678fb567-vwqvc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.130 (trex/6.7.1);
        Sun, 17 Apr 2022 03:49:37 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Zesty-Tart: 6d7974f36c54f951_1650167377147_1315708952
X-MC-Loop-Signature: 1650167377147:3412058637
X-MC-Ingress-Time: 1650167377147
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4Kgwzz4Hh1z1K1;
        Sat, 16 Apr 2022 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650167376;
        bh=TCFsTcqFrfctJCb7WwW2kivBjtsWElvnzgT7n+875Bg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XvH2pFAONkX1wF6yc5i4ltrc8kz/udpMfHJXDhWOKtMH2cPpYlHYGFvIy4Bt8wYYM
         nJNOAEN/gOSXgT08Hwfv2CQJUeekOcuXzsyXI+lCrliLCiYUiksDFIp28hC+6eDczv
         KgWfyLGPdDSJjo3A7equ9HIkk2phgaci6fJIrkyudS9V6yeCy5BYgOM4uch9JkjjSm
         d6p/73eOsgrZvJLK1ZRbRjXAF1pSz5hIzH8Z8tTs10sJOeyPg4ZT3CKSXet+AN7dmO
         kisre1HGPtMtxSIzYp2Bo/7MsKpOnBSgxUEri02pJ61uw9xoYH0f+pJMKRs/T7+Ewp
         PQMf76CUUnBcQ==
Date:   Sat, 16 Apr 2022 20:49:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm/migrate: export whether or not node is toptier in sysf
Message-ID: <20220417034932.jborenmvfbqrfhlj@offworld>
Mail-Followup-To: linux-mm@kvack.org, mhocko@kernel.org,
        akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220416053902.68517-1-dave@stgolabs.net>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



This allows userspace to know if the node is considered fast
memory (with CPUs attached to it). While this can be already
derived without a new file, this helps further encapsulate the
concept.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Resending, just noticed this oatch was never posted.

  Documentation/ABI/stable/sysfs-devices-node |  6 ++++++
  drivers/base/node.c                         | 13 +++++++++++++
  2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index f620c6ae013c..1c21c3985535 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -198,3 +198,9 @@ Date:		April 2022
  Contact:	Davidlohr Bueso <dave@stgolabs.net>
  Description:
		Shows nodes within the next tier of slower memory below this node.
+
+What:		/sys/devices/system/node/nodeX/memory_toptier
+Date:		April 2022
+Contact:	Davidlohr Bueso <dave@stgolabs.net>
+Description:
+		Node is attached to fast memory or not.
diff --git a/drivers/base/node.c b/drivers/base/node.c
index ab4bae777535..b9de5b0360f2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -598,12 +598,25 @@ static ssize_t node_read_demotion_path(struct device *dev,
  }
  static DEVICE_ATTR(demotion_path, 0444, node_read_demotion_path, NULL);

+static ssize_t node_read_memory_toptier(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int nid = dev->id;
+	int len = 0;
+
+	len += sysfs_emit_at(buf, len, "%d\n", !!node_is_toptier(nid));
+
+	return len;
+}
+static DEVICE_ATTR(memory_toptier, 0444, node_read_memory_toptier, NULL);
+
  static struct attribute *node_dev_attrs[] = {
	&dev_attr_meminfo.attr,
	&dev_attr_numastat.attr,
	&dev_attr_distance.attr,
	&dev_attr_vmstat.attr,
	&dev_attr_demotion_path.attr,
+	&dev_attr_memory_toptier.attr,
	NULL
  };

--
2.26.2
