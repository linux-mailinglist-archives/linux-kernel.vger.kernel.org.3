Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6736503415
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiDPFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDPFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:41:39 -0400
Received: from fossa.birch.relay.mailchannels.net (fossa.birch.relay.mailchannels.net [23.83.209.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEDFCBC5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:39:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 20EFB8E0A3F;
        Sat, 16 Apr 2022 05:39:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EF6068E09A9;
        Sat, 16 Apr 2022 05:39:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650087546; a=rsa-sha256;
        cv=none;
        b=Rv8hokrlQgajo4Jbtm4zIK69NBTeKQ6wjhoUPcFX2RrSarvSlz2NX5Gf/JiT1vHxOfiNUW
        W8aFzSk7BsHBa/N8ZAIZZXd6bsRHrNJkxN5nnFXYdhUD4ra+Rxj2yXNn5Irx+hAMtpxCCH
        U2qZw2BuDdzCjr+U0+pbZtGwtX/GAWLHzXFTDmjPwIuIy6mpvLShYxBZNYO6xcSO3W3t+0
        7s6XX+IKJYCDXHJFwxnhQZG4hssqDHcB98QPWnWKYj7yKDxtxHsKifERg3ZbSdY0qo8ex6
        NH6ZajU1vS8PlcIx2eRi0FLVLMOm5TdqPX5YYnRPMuVItgUGaZL2dAbajc0AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650087546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=/AuduwDgNmzkMSaAHYWzdl7vHKgWrilc8InFp3p5fzI=;
        b=IsOvUypEddzTdJ508E4Rv7RDnvKNUje9E8bnVJ50Uc25Pccti+vynuGRQ4ZpWUIeyP2dZ9
        mecYJuAplAwe+Yu13eBprgRmlzF93ZDFmValurHWSxyXSTKcFmeYZakU0YsITkwpCVGtLY
        cB2Tn2He8HIH2aPEGf63oEqAfVaYNa5oUVzivNPsPGTJKnoxMnYEvT3//ybnG4DC/NR+Bi
        H2pjlTByWcebA03VGZ7mlmMYpJnHXH7IajOQFCPeiO60tdZ0eQmeTDaXim1FcP0UArrNso
        0HU2cBE4BqkwDCAvudAMVnu4qQvagqN3hDTORzP+ho5jJDXjrCdyLLpxy3Uhdw==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-gws7k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.158.161 (trex/6.7.1);
        Sat, 16 Apr 2022 05:39:07 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Interest: 0e76ef4c5602c715_1650087546733_3015440060
X-MC-Loop-Signature: 1650087546733:2936475200
X-MC-Ingress-Time: 1650087546733
Received: from localhost.localdomain (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KgMSm6C99z1PK;
        Fri, 15 Apr 2022 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650087545;
        bh=/AuduwDgNmzkMSaAHYWzdl7vHKgWrilc8InFp3p5fzI=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=LdIv3zIO6Ogg4UZdBIU9QMEd/OVtpX/jb97r7N8KedKTM0CCVuLIcDmPmK2n+9qc6
         bzDJcR+fBA75u4DYQ/WmmRfzwHM0MftpZAJ0fJRjR1OGv6+dGSsqYhMbxlCkD31d0c
         jKqKeGLNX8zzw24faD7dzt5dAqPw6AxJwB5ZMpo1XYLWhDAcyrZwo1TGWsP5HhEktJ
         3Ok/jehJoVLM6WvA9CRbp48OC9swAVPdvviyHREX33X5+2/pZ1NfxIg2pO+AXHocaG
         qsL+11YD8osMdM2p1X9zHqOFz3btAiIhFPUVNFm44JIQVSXG8FeYOj1AFI0Nrv96Sw
         WPlieZ65dmdUw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC lsfmm 0/6] mm: proactive reclaim and memory tiering topics
Date:   Fri, 15 Apr 2022 22:38:56 -0700
Message-Id: <20220416053902.68517-1-dave@stgolabs.net>
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

With the increasing popularity of memory tiering, the idea of this series is to trigger
some discussion around David's[1] system-wide proactive reclaim beyond memcg[2] as well
as sysfs as the interface for exporting system-wide tiering information[2]. I am
hoping this can be discussed at LSFMM, and while I know many are interested in tiering
subjects in general, I have not seen anyone bring this up in the list.

There has been some initial discussion towards the need to expose system-wide tiering
information to userspace. I thought I'd start with two sysfs files as a node attribute
that exports the demotion_node as well as whether or not the node is fast memory. This
was considered (and I agree) better than a new /sys/devices/system/tier/tierN/ interface.
So, are we going to go this route? If so, what further information is useful for users?
Does having instead a /sys/devices/system/node/nodeN/reclaim/ make sense?
  
Applies against Linus' current tree and has only been _gently_ tested.

Thanks!

Davidlohr Bueso (6):
  drivers/base/node: cleanup register_node()
  mm/vmscan: use node_is_toptier helper in node_reclaim
  mm: make __node_reclaim() more flexible
  mm: introduce per-node proactive reclaim interface
  mm/migration: export demotion_path of a node via sysfs
  mm/migrate: export whether or not tier is toptier in sysfs

 Documentation/ABI/stable/sysfs-devices-node |  22 ++++
 drivers/base/node.c                         |  68 ++++++++++--
 include/linux/migrate.h                     |  15 +++
 include/linux/swap.h                        |  16 +++
 include/trace/events/vmscan.h               |  12 +--
 mm/migrate.c                                |  15 +--
 mm/vmscan.c                                 | 108 +++++++++++++++-----
 7 files changed, 206 insertions(+), 50 deletions(-)

--
2.26.2

