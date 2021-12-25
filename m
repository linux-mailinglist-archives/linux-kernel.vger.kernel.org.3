Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE27447F351
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 14:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhLYN15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 08:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhLYN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 08:27:56 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC6C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 05:27:56 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o17so9693995qtk.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ndhwfIHpC1n5b82xHYPKQo0rswOCK+/cEZ6RaVSz/3U=;
        b=a2yMocf6Lbi4/+KJhcOJp/ZIXcEILb+Hk8ScEFSbPfnTmRKN09ooY5BjZnB+zy+SoJ
         mZOyP5859LPr98bCQ16XN5TSd3sn0zNoZ3vVIUtXKiRpGUBNIgBiIk64XjlQARJqeErQ
         G+nAUtXiEEGXI30+2S+p5s41xrVwGmPb9TplPP80YrMiuNwno+1zoP3BABSY0lGtO7Jr
         tZr5q616NM7P+XgiYX6qYvjF5I6J4m10JjV6wFL/xV4lsWLILV6qEhLOZoYxQIc2mCEE
         VfVEj8E5rnIGEr0rV0bCx2IenDvv6pAJaNVGYMTn8jabVQdNmho0tilyw1XSHGuvDiHh
         DnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ndhwfIHpC1n5b82xHYPKQo0rswOCK+/cEZ6RaVSz/3U=;
        b=HaLjmH51d4N90LCMlb/ho/ntY6DWxr2DoqB3KcAVM5GqbSo5jrghEqOyifUpDX+ojZ
         JpxX88LirdFL94tLuFsNR7gCcghawsUtSXALZWfxk9ps2Ct3VDOpfAPqWUOB36grQlf8
         XYBpDBgy4F078i6eZxzi8FHwoI4UfVC/QEksIddGqJQ/HJUNOxF6ho/XjU3LJG+dlBVF
         ME48oZ6issKlt/z0wTZzqsj+l45r+mKu7Impfv84emZR6+5ue0dAa9rSojhanlOjUaLK
         PelmUW6z5tS4D0bsfwoFItQKD+nOlf6oAfp1thYDCSd8RIYp4SWFBvMzQ4sj/P2JTDQr
         Wkmw==
X-Gm-Message-State: AOAM530M34oZJtPSUYpzcMJIxclb8pDEPfufmpHCtdDJEX3ZnlFJSGip
        DwHXFv0l8i5xyI3pr6PuMi3La9P52HXqetCWV5s=
X-Google-Smtp-Source: ABdhPJylb6u75nPMw8uybdg5Ga7ZHBe0YpAqvO1o2Y4aQHYAjHaf1v4fK0ISMBoLrI/jwKAMV4ZdTg==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr8806423qta.466.1640438875532;
        Sat, 25 Dec 2021 05:27:55 -0800 (PST)
Received: from localhost.localdomain ([2a03:d9c0:1000::1038])
        by smtp.gmail.com with ESMTPSA id m15sm9112799qkp.76.2021.12.25.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 05:27:55 -0800 (PST)
From:   hrshy0629 <hongqiang601217@gmail.com>
To:     krzysztof.kozlowski@canonical.com, davem@davemloft.net
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org,
        hrshy0629 <hongqiang601217@gmail.com>
Subject: [PATCH] Module Name: drivers/nfc/pn544/pn544.c    fix a bug
Date:   Sat, 25 Dec 2021 21:27:28 +0800
Message-Id: <20211225132728.25111-1-hongqiang601217@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    I noticed that the same usage for API nfc_hci_send_cmd() in line 541 and line 552 of the file pn544.c.
    And the variable r is checked on line 545 but not checked on line 552.
    The r in line 552 should be checked.

Signed-off-by: hrshy0629 <hongqiang601217@gmail.com>
---
 drivers/nfc/pn544/pn544.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index 32a61a185142..531eda0d11a2 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -552,6 +552,8 @@ static int pn544_hci_complete_target_discovered(struct nfc_hci_dev *hdev,
 			r = nfc_hci_send_cmd(hdev, PN544_RF_READER_F_GATE,
 					     PN544_RF_READER_CMD_ACTIVATE_NEXT,
 					     uid_skb->data, uid_skb->len, NULL);
+			if (r < 0)
+				return r;
 			kfree_skb(uid_skb);
 		}
 	} else if (target->supported_protocols & NFC_PROTO_ISO14443_MASK) {
-- 
2.17.1

