Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B356520721
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiEIV4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiEIVz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:55:56 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59B2CF2A2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:49:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d127-20020a633685000000b003ab20e589a8so7905861pga.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y0bm740K5+F6biKf1anieq/YyEnbNkxKhtJ2NmAXxf4=;
        b=aSchQdcqnmMb/VjA10rMe3/jVjjMT/JZX6/FYRJyK6VZCBKgNmWGVqzqjDPq4sm18f
         feiEx05SXqX4mNbxsyK0x05JjPEvq0xh239aehUwjkmRGTbRakYFecinOJgy14/z9Zzj
         33dF5DW43DXTiTEzJhEhw5U2jPDCCkbFN+sk4BhGowgddy2H9waNWiols9Tco5aRev6x
         w6D5fdiKELFOebJOln+qHSV54+VmvSe1kLXoKhVrMXloF9qzCnpuqMyeNIzqBRs67wWf
         P6gqlxTZNZjg7yzulRhn69Cjv1Fx7uIqvkRXZUpxUq//wPNu9fVg3l17uyjr+/b2mPS8
         1zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y0bm740K5+F6biKf1anieq/YyEnbNkxKhtJ2NmAXxf4=;
        b=ffcYqlAyfCXjmGFhydCsIbw7v/1zO1lDrviy8lxEACUhbnn2J0By+czqdaprqMzI0b
         SN19AyphjRJtwU8/4icd9gq4rK8ud/RNLIfrRdiklAPs4NZhu1bI5cWChNELDeNeMdrw
         8Nq9GlkfHBg2ls1x4VZO/B77+LV1e8odhiCM1EymJ6+KsaCJNperOQrFtFYCGTNi60m9
         yoj1E+OI3Oh5qJIs6IQm677gMX06/BoUXtO0i59yuXLL/JXbcgbFg2mKDB0DG/6pSaOY
         OCcLSld9w5DblR3u3JJsHcqH0ActgH04zwFeP6mFrtWfSmhNCvKKssqzk1HbMR/AhPcS
         DWzQ==
X-Gm-Message-State: AOAM532tbFruAVyiQSdFP2QX5rfMYh90Ih3L4mdcOfU3RkkRARJcH5LW
        MDK6EyStBvNDzsAIri+vatT4CJm5Zn7uYA==
X-Google-Smtp-Source: ABdhPJwyTRI9THI5Gqo+5ll5l+vfaNn1LrixYDdSQE27lSRAXBNR5d7F6x17NOR/h4f72zkObxGlEhqwkrNyeA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:90a:7acd:b0:1dd:12d7:5204 with SMTP
 id b13-20020a17090a7acd00b001dd12d75204mr8606517pjl.145.1652132975207; Mon,
 09 May 2022 14:49:35 -0700 (PDT)
Date:   Mon,  9 May 2022 21:49:30 +0000
Message-Id: <20220509214930.3573518-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] driver core: location: Add "back" as a possible output for panel
From:   Won Chung <wonchung@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "back" as a possible panel output when _PLD output from ACPI
indicates back panel.

Fixes: 6423d2951087 ("driver core: Add sysfs support for physical location of a device")
Signed-off-by: Won Chung <wonchung@google.com>
---
 drivers/base/physical_location.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
index fbd9f9839e92..2b60d2b51684 100644
--- a/drivers/base/physical_location.c
+++ b/drivers/base/physical_location.c
@@ -56,6 +56,9 @@ static ssize_t panel_show(struct device *dev, struct device_attribute *attr,
 	case DEVICE_PANEL_FRONT:
 		panel = "front";
 		break;
+	case DEVICE_PANEL_BACK:
+		panel = "back";
+		break;
 	default:
 		panel = "unknown";
 	}
-- 
2.36.0.512.ge40c2bad7a-goog

