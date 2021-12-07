Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA2046B18C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhLGDl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhLGDl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:41:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2636C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 19:38:26 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id q17so8466841plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 19:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgLANVeoEWx99c2g5F+eOupMQbrDVH7yHQdCQyf/x3s=;
        b=MT6W4r1zYygvCw5gIqXUZZiGp8XK/e2Z//93cCCjywLuDCKL+Z0PjVK7EA+2VcKsUM
         vHLUhTBD6IMoG3GFa9Ez3OsEl2B4mcugzDfjDLQvqW86UWRVujSNXwKbAgceis7Z1jB3
         yniEiaM7ip3kNx4oA0wpSoU7LXBvSAK8Yxmxj9VA2BLX3+Gus+42HfOkJY49FfsZD0ai
         l4ZcyfSH4MkA2V4YEm18R82mNpkS1MfU3bHzwMlh5e8LRDFLpB4fKK43t5te6sbWePDB
         kFP44VYzw/TyR2EWONv3doUebVjVyMtbAYwkX39h+dYFQLmKlCu/m2EPykU9POmtMD5Y
         FbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=EgLANVeoEWx99c2g5F+eOupMQbrDVH7yHQdCQyf/x3s=;
        b=5oWvpSTtM0XNyShJdYeGzK9vsUL/1veyjUhpeG+eEBEQeJqoMPD8J6/JTGVKgYSTja
         xTRE6GL6xp8pn66XeQiYUh0KDfX563ogmoP7Fa4E7HaQTmSjkXR5VvFBxTocBQ34HkEL
         0yZBrfdnVLfTCA4SE7tG6H3k1lwFyhndXS23GCDg6CFrccQOtDHP+wQ/hzqPH0EwDRrs
         jF1dC1ikwAoWPf2lS0FiLsFwLr0mg2tRmO5NxaXdd3sTwHfPkPwHdJen9jvFGs6XniC4
         OyO6OqufX9Uon3lD12YdYt8Zty0IkyQ93ZyNoEkqfFIC4P/WW2/HuDK6XjmEmuO2Cndj
         uLXQ==
X-Gm-Message-State: AOAM5327vp9P0Ko4DsMfkkMMFxZo6oSkA/MGBZ+XhZMp/QU2TCZZiybm
        iE5Lm5V/pz00YEt952VUSCw=
X-Google-Smtp-Source: ABdhPJyDMWDZtLYtBjUESrslaht0GAv0oPqV3SmZpFjfG870MdlRofCjCzVZsdmcgh6YzlWkmIGDmA==
X-Received: by 2002:a17:90b:314d:: with SMTP id ip13mr3430857pjb.228.1638848306421;
        Mon, 06 Dec 2021 19:38:26 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id n3sm11052865pgc.76.2021.12.06.19.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 19:38:25 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] fsi: scom: Error handling fixes
Date:   Tue,  7 Dec 2021 14:08:09 +1030
Message-Id: <20211207033811.518981-1-joel@jms.id.au>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two error handling fixes, thank you to Dan for the bug report.

Joel Stanley (2):
  fsi: scom: Fix error handling
  fsi: scom: Remove retries in indirect scoms

 drivers/fsi/fsi-scom.c | 45 ++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

-- 
2.33.0

