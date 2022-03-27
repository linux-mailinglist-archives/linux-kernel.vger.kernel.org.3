Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362074E8881
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiC0Pvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiC0Pvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:51:38 -0400
Received: from sender4-of-o53.zoho.com (sender4-of-o53.zoho.com [136.143.188.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04E2656F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 08:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648396192; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RcvQOByGXY1unKdCDaOAC1LXz+mMzM43DKPB5bsS7he8xMlBOQ9iftL4k8yCob8vJvJqWzZxyHwpFBbNz3Ao/PQy/BGCPhEWO51iydLTr5wnr5Fm9leoZxuFUa/Pl+PYyzcDPhqTshv51XfZgb7pMKo4MdTjcth/9nirZjCADfk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648396192; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8ryXOoKRSeSj62X041ZptO6D0BqyP7/awmvCaEC3goQ=; 
        b=Tg2GYmu667sTaIw7UUNqpS36/3Jdmgfl33zsLJU3BpOw97jipJ0Nto1TyQJodAaOGk3i/nnC2mPRSDRwC6iI9JomeAXo8tbeNU1I87TKe0vOflLac4r1f/UTCVITMcf7TFRpUFFgJda9LILqCC+9e5/GD6Gqkrnp/CX5HJYrm4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648396192;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=8ryXOoKRSeSj62X041ZptO6D0BqyP7/awmvCaEC3goQ=;
        b=NKaXLtVA0nzqNngOwmr9FKIYWnsCiFxPqCU78hC0eXc8NGKqxYwIKWnu9IHEu7sj
        0NWAlK3Gtq72gptaxHS2AZkaDpBGxTES+reSup/uQA0NWbeRl/ZDiX9Kc9TAIpuiSjE
        x/f5b/Idr7FN6++AKJZQHevU9Awms/+C6bU1y2Do=
Received: from localhost.localdomain (49.207.212.179 [49.207.212.179]) by mx.zohomail.com
        with SMTPS id 1648396189292143.7738007891578; Sun, 27 Mar 2022 08:49:49 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     David Howells <dhowells@redhat.com>,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watch_queue: free the notes array
Date:   Sun, 27 Mar 2022 21:19:33 +0530
Message-Id: <20220327154936.9353-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__put_watch_queue() frees the individual notifications but doesn't free
the notes array itself causing a memory leak.

Reported by syzbot at:
https://syzkaller.appspot.com/bug?extid=25ea042ae28f3888727a

Fix by adding a kfree().

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-by: syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com
Tested-by: syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 kernel/watch_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 3990e4df3d7b..230038d4f908 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -370,6 +370,7 @@ static void __put_watch_queue(struct kref *kref)
 
 	for (i = 0; i < wqueue->nr_pages; i++)
 		__free_page(wqueue->notes[i]);
+	kfree(wqueue->notes);
 	bitmap_free(wqueue->notes_bitmap);
 
 	wfilter = rcu_access_pointer(wqueue->filter);
-- 
2.35.1

