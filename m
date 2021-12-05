Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDA468D28
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 21:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhLEUW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 15:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 15:22:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE3C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 12:18:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c4so18034019wrd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4+ZI+7GFGQ2KswckSCyD1z/fFJ1KnwaAZReLO5VybY=;
        b=FQvtpMMZ9Uj6r1+TMXLPzpbvcdX8xjU7R4z+lTghxykqitpTX0dr3zI5qepRUV0PL9
         dyokYSjp9qxLcGsOFiWmDdL4hprRkZJwIWLzcMt2TEqWSqXtz2r9fmPwS+Keasc1CbRJ
         HP/UhxwYuXZa8n114ZuKzZ/4TaSp5gXfj24Uy3Q0v5waZLo9bIzXm+NeTdc+Tip6P/No
         gVKg0wZuqGBcJQnEYIzisL1y+JCxZ+s61gfxkiyLZtTY2KNRtokvzZ690KLuAmDjNKuG
         AM8Xpc9Krc9GNyGAMmxTzaE5VyNtZ3EeqyX6L4NYrNaB2qf8tZK5Y2lcIhKGofPKIC7a
         /Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4+ZI+7GFGQ2KswckSCyD1z/fFJ1KnwaAZReLO5VybY=;
        b=cWh8QhiTa3yIb/jJUTRU2Yke6FVGEm73bGIjFY1k2/lHP1GKXYpYh0o4BNf7QX70PS
         Z1ngIwUK0xRnMw2yBLmgPcUqUAYFZTMG6CddlQo2SDBTbnEcpL1aAAs/H7sPoU33GL8N
         CAU9bURptG2lyjnWrRmAzltHIeOhYD/+Ug25mEVhI6qjeeDCTINYZpty4hDH11Mj7Yhx
         TC3MwcsObi20jyzF3K4o9lHuol4ZpiK008PT2AY9ywE1pjxRmMsD1DZMVY0Ei1aRvu6v
         s0vW53WZNyabaq7/iNC7MyMfyhUV6+2OKqL5MkCPv7EfMDTpEEEKz9Mca4GeSfDBGl7i
         nA1g==
X-Gm-Message-State: AOAM531VQiqy7aaQB88xWVzRN5PAnOxOfDGdL712rsfkSKqFguCPuGnj
        ObWandDSJahiHOkybzn4jIl2Porj6l0IXQ==
X-Google-Smtp-Source: ABdhPJztgn8mnSFKfWQ+h0/R5Opo8hX2CsdhLfWasYWAm5DdufhNpVlZPnBvFTNepR9HLZuKOurSGw==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr37525446wry.415.1638735534265;
        Sun, 05 Dec 2021 12:18:54 -0800 (PST)
Received: from localhost.localdomain ([41.249.159.5])
        by smtp.gmail.com with ESMTPSA id g19sm12043663wmg.12.2021.12.05.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 12:18:53 -0800 (PST)
From:   Nour-eddine Taleb <kernel.noureddine@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nour-eddine Taleb <kernel.noureddine@gmail.com>
Subject: [PATCH] scripts:extract-ikconfig: add support for zstd compression
Date:   Sun,  5 Dec 2021 21:18:31 +0100
Message-Id: <20211205201831.115815-1-kernel.noureddine@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update the script to accept kernel images that are using zstd compression.

Signed-off-by: Nour-eddine Taleb <kernel.noureddine@gmail.com>
---
 scripts/extract-ikconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/extract-ikconfig b/scripts/extract-ikconfig
index 3b42f255e2ba..5cbf6f1d7f56 100755
--- a/scripts/extract-ikconfig
+++ b/scripts/extract-ikconfig
@@ -62,6 +62,8 @@ try_decompress 'BZh'          xy    bunzip2
 try_decompress '\135\0\0\0'   xxx   unlzma
 try_decompress '\211\114\132' xy    'lzop -d'
 try_decompress '\002\041\114\030' xyy 'lz4 -d -l'
+try_decompress '\002!L\030'   xxx   'lz4 -d'
+try_decompress '(\265/\375'   xxx   unzstd
 
 # Bail out:
 echo "$me: Cannot find kernel config." >&2
-- 
2.33.1

