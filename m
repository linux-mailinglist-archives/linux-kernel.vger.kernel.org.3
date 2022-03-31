Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546B4EE386
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbiCaV5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbiCaV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:57:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA071DFDFD;
        Thu, 31 Mar 2022 14:55:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x34so834960ede.8;
        Thu, 31 Mar 2022 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=340G7DDlJvxfnruHeGXTFxEtC53hXW3frN9N7jMbYMo=;
        b=pqa1CDnLEUEUIbaKrQKpfnlyqz9Wf9ivrcPZx4GweI+V3rxNnyGYtErdnkFl0KZWPy
         aVQOM1sjDXASbi84kEzqN1bkF5mEznJlonLoaL0lJQauqFA7/NR22vzkm4ZmzUTXOghP
         XLeXUiEI5Ya1ggWcU34UmZIXQ/Dv24iQjhn3X8hWnRsNlXsLvpsm6tcfoqQJTXlkR7iH
         L27DYCyr5wnD+BIK4wIsRbw34owX4oYQXE7K0Ccqn7RKHHQACNQ7NucVRrynQRtg7/tB
         riygE186FI3tDxlvdnK2G/Axi8AoQypB49XyAkclnzkoxG/WUO7/vxh+z5er3Y0w2QDX
         ZT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=340G7DDlJvxfnruHeGXTFxEtC53hXW3frN9N7jMbYMo=;
        b=1GMHJkGahrL6uA80Mq199Z2eX821EAsWQNxtXlrv/f55NEK16iiDo/dZcwnNp08t+h
         iLtBfGCMglv7mYMoAnWptcgpI3aJqzaRNtZPa1SY7xzrupFgVgZK/AGFBvID+43SJ+Da
         VKlXRPj+rxvydDvcdJBesNnsgw2g7z27FjFrG5FFjb+HgAUvX1xLnQ17cHWnXwkYh8aY
         jS1ZkKVJmTwF4UYHPcoQDc2tmOTse5p5+o52cY6HdpnogvV1P0V+N54lHM7WVE/fLznr
         ZgP6wRA24kqzC/HXX8Z2NB5af9swLcP507MnkDu6+5IwTqfg1L3QI9xxPVatkQAdSWti
         gOjw==
X-Gm-Message-State: AOAM53369f540v3VqzDTJDoGTYIjyFwpLPUjQ+qxq+PGooMwK3boD72l
        1F9WC8Vy7GMXEVWHCI2cpJM=
X-Google-Smtp-Source: ABdhPJz2iC+c3oAylzaewgDKd9bjHplvo2CImrsZPyv6lnBH4ueew5wYDmb+r1VTQEpAO+qB10tjkQ==
X-Received: by 2002:a05:6402:4250:b0:419:5e89:a40f with SMTP id g16-20020a056402425000b004195e89a40fmr18515273edb.319.1648763726247;
        Thu, 31 Mar 2022 14:55:26 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id r11-20020aa7cfcb000000b0041902ac4c6asm307950edy.1.2022.03.31.14.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:55:25 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] ceph: use dedicated list iterator variable
Date:   Thu, 31 Mar 2022 23:53:28 +0200
Message-Id: <20220331215329.882411-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/ceph/caps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f1ad6884d4da..519750bc5a1a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1577,7 +1577,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 	while (first_tid <= last_tid) {
 		struct ceph_cap *cap = ci->i_auth_cap;
-		struct ceph_cap_flush *cf;
+		struct ceph_cap_flush *cf = NULL, *iter;
 		int ret;
 
 		if (!(cap && cap->session == session)) {
@@ -1587,8 +1587,9 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		}
 
 		ret = -ENOENT;
-		list_for_each_entry(cf, &ci->i_cap_flush_list, i_list) {
-			if (cf->tid >= first_tid) {
+		list_for_each_entry(iter, &ci->i_cap_flush_list, i_list) {
+			if (iter->tid >= first_tid) {
+				cf = iter;
 				ret = 0;
 				break;
 			}

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

