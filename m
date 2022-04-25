Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1507B50EB02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245678AbiDYVKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245536AbiDYVKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:10:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D9B66F81
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:07:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q12so14333577pgj.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yfkLHIGendK7asqrB3cDu3rcvHBz4MAJahFLz57ZkQ=;
        b=V4iT+hMJVcqcQiKtfpts5LIiBYKBt1Jhpp/0+ZFS86rofurh3eEgQJnex0pBwJ0njo
         reGg6t4nGczMtMbw2LEwuA56ivqvdLjRRwrk0W4ANdeCyzOlOBrrk6dUFYAM7LRADDpD
         E6FsQ0yfoB1o8CqmrKhTNNZ6rZ7xy/rYF6Nfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yfkLHIGendK7asqrB3cDu3rcvHBz4MAJahFLz57ZkQ=;
        b=2UVhqaKoudVQnNFICiCjBmy1/Oz64kQaUs9XQ7kE4Qsl7W6nC6NwJKwR0/APfxe/75
         ka2VRVSavsaurbgAPmrJiB3j/8V3xvxULD9TR0ALaKpEHS9Ppk/tmRLlqjxeP2mluoku
         OQyod8yU52p61/e+iwKsGWLUSUZOVzCbksezBU4JuBE9+YodcC4duSqhh+G2AF1F16NE
         jPtSvKlo1nlNqP8aZpP3CY9aMYqzwDjxh4aKIgY4TEgXs/bcAjoToYMSUB91MPyLcb7q
         dyU4IeDzMLEkRU2IlbRqd+AXy6SQxIvbVvFoXd/GBR/J4LgLUQF4omnJyLXrozUnyGd1
         W7Nw==
X-Gm-Message-State: AOAM533sh+Pb9lpYSb8ZoMWQgqRTU+0MFfLHSU7vX6eEgDme2m3hkUw3
        wbsMBsCOfdjJ8yTqHj57P6a6Tg==
X-Google-Smtp-Source: ABdhPJyb9GFRAJd41b6tfRbfDmjkrPPMtCMSDUzHsF8HzvtcmNI07PBkoIsL+OZ9etzob8tZql/62g==
X-Received: by 2002:a63:475b:0:b0:3aa:436f:8812 with SMTP id w27-20020a63475b000000b003aa436f8812mr16652814pgk.607.1650920848531;
        Mon, 25 Apr 2022 14:07:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:15d7:3f2:9d41:116f])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm12617373pfc.190.2022.04.25.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:07:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2] Input: cros-ec-keyb: Only register keyboard if rows/columns exist
Date:   Mon, 25 Apr 2022 14:07:26 -0700
Message-Id: <20220425210726.3813477-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is a detachable, we may still probe this device because
there are some button switches, e.g. volume buttons and power buttons,
registered by this driver. Let's allow the device node to be missing row
and column device properties to indicate that the keyboard matrix
shouldn't be registered. This removes an input device on Trogdor devices
such as Wormdingler that don't have a matrix keyboard, but still have
power and volume buttons. That helps userspace understand there isn't
a keyboard present when the detachable keyboard is disconnected.

Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20220413033334.1514008-1-swboyd@chromium.org):
 * Use device_property_present

 drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 6534dfca60b4..ceb23e2e0d94 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -537,6 +537,15 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	u32 key_pos;
 	unsigned int row, col, scancode, n_physmap;
 
+	/*
+	 * No rows and columns? There isn't a matrix but maybe there are
+	 * switches to register in cros_ec_keyb_register_bs() because this is a
+	 * detachable device.
+	 */
+	if (!device_property_present(dev, "keypad,num-rows") &&
+	    !device_property_present(dev, "keypad,num-cols"))
+		return 0;
+
 	err = matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev->cols);
 	if (err)
 		return err;

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
https://chromeos.dev

