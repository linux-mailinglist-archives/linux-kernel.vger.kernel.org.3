Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1285F4D798D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiCNDFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCNDFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:05:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E56412
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:04:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a5so13079732pfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WZscqLQeE0UBrVt4o3s0SihTxtpjWcEu7i3MAqpyVM=;
        b=R/1ChIUAucw3Ock0ufVdivfQnF1dlS2KKCXIEQqQFTW1Iq2gPL5uwcBVmiTQdjPYVf
         AO5n/vMsl9UnGTtHap1YXZgsKktylhyvQpB6lH21X89lRbE2ZjSsdLvR/FSjloRfmYeV
         9+HBNenqdawijpRjxm4ZwUDBJE2NIRAwYRZ/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WZscqLQeE0UBrVt4o3s0SihTxtpjWcEu7i3MAqpyVM=;
        b=gmzvcceHIuThrFkCHB8O7hMG7AG72HT7TO+P/RqXoKXgwJAgyD+ib9JHeYtHsr6wXp
         ig8YJje+24rHneODyRPxLcrrqiiH+wWNn7YNaq0Hi+/LdOAwBqeS2A2brE+m5jq77Eg9
         6DiotfHitg/exjS5zfrCqiJejf4aNq6Pmjis/SEm5ct9bAjQKfgNb0PdCqMxKKlh7gpy
         QMBDU1BpOxo8/2y6wqkmT5a0SOpfiaLUUahe0gMdR+NP0C7jdV2sAJ1rv7zDa9g8KFQL
         Pu3ixEg4ydLzY4sgyJRv/xPnY5T0mYHKRSYUCfqFRHK3hmSfIumxtLCmBAZlxNbyundK
         d+4Q==
X-Gm-Message-State: AOAM53070+P10xaNTBMSIF6wE8iVoyVKijorxwcH1i2cDJHyPJgAu5yU
        zQgxY1abhr7ab/JLzJ8zziUdYWcIyQdG2g==
X-Google-Smtp-Source: ABdhPJwzSLC6xvw2IF7ESyaSlPHaQmP5GbSq4DlQSy5erM5IYHhdLABEeaFqLC0uLXe+bXDaAVpFAg==
X-Received: by 2002:a63:914b:0:b0:37e:9914:b268 with SMTP id l72-20020a63914b000000b0037e9914b268mr18383366pge.85.1647227070040;
        Sun, 13 Mar 2022 20:04:30 -0700 (PDT)
Received: from saltlake.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.gmail.com with ESMTPSA id l5-20020a056a0016c500b004f140564a00sm18504216pfc.203.2022.03.13.20.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 20:04:29 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        heikki.krogerus@linux.intel.com, wsa+renesas@sang-engineering.com,
        pmalani@chromium.org, Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: chromeos_laptop - Fix potential double free
Date:   Mon, 14 Mar 2022 03:03:36 +0000
Message-Id: <20220314030337.777685-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In chromeos_laptop_prepare(), cros_laptop->i2c_peripherals is allocated
inside chromeos_prepare_i2c_peripherals(), and is also freed when
encountering an error. The caller later calls chromeos_laptop_destroy()
to perform cleanup, which tries to free the same value again. As the
value is not NULLed, this will cause a double free error.

Fix this by setting cros_laptop->i2c_peripherals to NULL in the error
handler inside chromeos_prepare_i2c_peripherals() after conducting the
free.

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/platform/chrome/chromeos_laptop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 4e14b4d6635d..3d10257b1107 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -785,6 +785,7 @@ chromeos_laptop_prepare_i2c_peripherals(struct chromeos_laptop *cros_laptop,
 			fwnode_remove_software_node(info->fwnode);
 	}
 	kfree(cros_laptop->i2c_peripherals);
+	cros_laptop->i2c_peripherals = NULL;
 	return error;
 }
 
-- 
2.25.1

