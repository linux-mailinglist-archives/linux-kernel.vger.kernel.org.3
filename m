Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982264EE399
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbiCaV6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiCaV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:58:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB20241B5C;
        Thu, 31 Mar 2022 14:56:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id pv16so2192630ejb.0;
        Thu, 31 Mar 2022 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xkr0PQO//o59RSxUJyyli+qBLYdHF3Dtr2QvlIoMNhs=;
        b=g5npxspDJVN7vb08r1+5lxuzHg3UsjA7ebp65WyBPtjQCXFAmTeuarZxWgLvAYOO/U
         D/IHYWdDBm7ZJc+/wt0/tVICYbQcsJRkDUXJEp+1JD9KGiZyoBw2JN+NdDoly1zRDmQ2
         gUSlVc0bccrCX4+DXGcE9CY3iGyRzN4JZUQzlHAajrcbfmMj1IhynbNKYu+4s1yDauqu
         NOuze66qApXULkhoSjOktm3IgP8GIAH11VHz+kDI8y9/q0E/Woyjku78qxk4rr5RfsPP
         rQze4WaYJSptnA/NcWCml/S6DN2YU012spFZlQYDuYT7sAb+lkBnKWypCyNryrtkPTkH
         4HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xkr0PQO//o59RSxUJyyli+qBLYdHF3Dtr2QvlIoMNhs=;
        b=pNVDlhQCHOYu07+0cHbKnVtgtk7QNzYGUvfi/yRa8Q+nYe6s73iXTzPrlnX4iR4dg6
         PkYoTIoYHwxd3jFqCdOBUFNe64Plf1XaY+332L3NFeRSvYmfRZOnWZYuZVR+azPZpQt1
         Ovmj9SHWkLID0jThzwPncLg32uJBf7W42GMrzwTKlvCCpK+H//4Ru++P4Hk9Y3uzBFHc
         mWbnStbOTm+Y5+xJPO5oGq+YF7ihnSeZejo4Nh+fyRbNxdzUsV8zNgf4cr3DKm5OZ+L4
         /566tUbHQ8Q5d3kF+sJeLmXmL1eHpe2vPX+x+7hqBGNz1YSQUgr348+dqkvLhY1Zr3xq
         fHOw==
X-Gm-Message-State: AOAM532Xlr0JWovyEBiiFUavs1XBsp98UmAVVfgR3nCki4/R+DJ8E4Z8
        0n+epgP+hSRXguXMUwjK0f0=
X-Google-Smtp-Source: ABdhPJwCu1E99glbIhrkJCTMPbFw5eaA1LSX9HxIKQqeRbbdCExVGLRsjJ+QkySEmU9Sepx/PUTYaw==
X-Received: by 2002:a17:906:5ad6:b0:6e0:1799:4a15 with SMTP id x22-20020a1709065ad600b006e017994a15mr6950703ejs.594.1648763803671;
        Thu, 31 Mar 2022 14:56:43 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id s24-20020a1709066c9800b006e490a8cf71sm251434ejr.4.2022.03.31.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:56:43 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] cifs: remove check of list iterator against head past the loop body
Date:   Thu, 31 Mar 2022 23:55:41 +0200
Message-Id: <20220331215541.883746-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331215541.883746-1-jakobkoschel@gmail.com>
References: <20220331215541.883746-1-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/cifs/smb2misc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index b25623e3fe3d..2d862291fab9 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -150,16 +150,18 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 		struct smb2_transform_hdr *thdr =
 			(struct smb2_transform_hdr *)buf;
 		struct cifs_ses *ses = NULL;
+		struct cifs_ses *iter;
 
 		/* decrypt frame now that it is completely read in */
 		spin_lock(&cifs_tcp_ses_lock);
-		list_for_each_entry(ses, &srvr->smb_ses_list, smb_ses_list) {
-			if (ses->Suid == le64_to_cpu(thdr->SessionId))
+		list_for_each_entry(iter, &srvr->smb_ses_list, smb_ses_list) {
+			if (iter->Suid == le64_to_cpu(thdr->SessionId)) {
+				ses = iter;
 				break;
+			}
 		}
 		spin_unlock(&cifs_tcp_ses_lock);
-		if (list_entry_is_head(ses, &srvr->smb_ses_list,
-				       smb_ses_list)) {
+		if (!ses) {
 			cifs_dbg(VFS, "no decryption - session id not found\n");
 			return 1;
 		}
-- 
2.25.1

