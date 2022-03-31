Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37D44EE393
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiCaV6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbiCaV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:58:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56630F7A;
        Thu, 31 Mar 2022 14:56:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a17so830699edm.9;
        Thu, 31 Mar 2022 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KeYUo5Rxtop2eZuKjtBKuva+XDteBCoX0CO2d3I1o2A=;
        b=Yk9NZ/50RFQdHnGdTItCs5XLEfu2j/9wx2Krv1F8waDIhUFBxkcr/3u7D3n2vmQpLN
         V2UnoOLGBqi25p94TtB1OOu9wOKMfcLiCDq0pBNS/gZJFJO+mZhP3oAMMNmEUQhiQfKO
         YrlZEIDX9qqd0I9rbolh4TrcqbhhBcRrcmjIS8O5pyeXnZarS485ZWAKJosEqGO3BG/u
         e10q8Fi21AM2ICtCEzO+UBOM7VqAeGfetXl6bKWIi4Kx7vIMWd2H4YF6SZzcgX6t1ppE
         SwLL98IGJEfdjwC7pEiVHGcdu0ifUs0467RFiVvQDXEc+MkRI6DG3e57KyfQhpuz2iPa
         SdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KeYUo5Rxtop2eZuKjtBKuva+XDteBCoX0CO2d3I1o2A=;
        b=rvUdgoevuJjnK2BSr+8H6gCM/FnJ7UrEWUkaA7JjmfiSH1qfq4wE+kQj8BefAYSSDr
         Y0Ay45csXMM4GzJiwlCqNMhGSBTF5KfjjVsCaQ8AxqmsR9qt7HcRV6Jvj4CV6kFxUaHN
         BH1Vwe8KWUYjvkhbLvjtx2gEVC1Kj4CZgJzq5ZY9GLdG8gOHYY9Y7T9AUE7oUWrBZYTn
         z40xMmNS6S/+0vl6iQbi02gx060bYsQZr40PCzi/nd1DQXSOJWgPK/lTvqAO2pBXR1iJ
         9SSBdnKUl7hvh7aLdFhK9zSBKegYR6YigZUBSxam64z293lHJFqjg2kknP1oQTXLXDV7
         wGGQ==
X-Gm-Message-State: AOAM532YX5QNIa8zk+mtDyc5CKvUDv0Wxbih8UdicL0MoIla+HTmFJsH
        bPqGW7bvb4SvKv/Y5F/KwIE=
X-Google-Smtp-Source: ABdhPJyONxCDb77pIW8ufJNOJ90VzxBr+yTgi+Y1i1NLHsjGazEEm2WeSQZh+WzkZH5N9StrRYvzkQ==
X-Received: by 2002:aa7:d398:0:b0:419:d011:fe8b with SMTP id x24-20020aa7d398000000b00419d011fe8bmr18763741edq.168.1648763802902;
        Thu, 31 Mar 2022 14:56:42 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id s24-20020a1709066c9800b006e490a8cf71sm251434ejr.4.2022.03.31.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:56:42 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] cifs: replace unnecessary use of list iterator variable with head
Date:   Thu, 31 Mar 2022 23:55:40 +0200
Message-Id: <20220331215541.883746-1-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator variable will *always* be a
bogus pointer computed based on the head element.

To avoid type confusion use the actual list head directly instead of
the last iterator value.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 7e7909b1ae11..4ac86b77a7c9 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3858,7 +3858,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	tcon = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
 	if (!tcon) {
 		resched = true;
-		list_del_init(&ses->rlist);
+		list_del_init(&pserver->smb_ses_list);
 		cifs_put_smb_ses(ses);
 		goto done;
 	}

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

