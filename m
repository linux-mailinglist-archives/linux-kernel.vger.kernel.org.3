Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B765A6EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiH3Uxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiH3Uxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:53:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1289F8672B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n18-20020a25d612000000b0069661a1dc48so632399ybg.20
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=tq1rGOekL7pxfkbRlGyK3KX3p9F0Zh08RbUI+01hRUg=;
        b=GaJO4twNi//joTXJTPWxgSzYipFe8SFbxE0TwPATGPceoH0L9qw6PxWyI4VePZPq22
         e0Kx5DlnOZ7JYvnNrtLs7c/gccDFrFqH/bMNpKQLRVXJ9g6os3iC/o9t1mXE1kRQLLUz
         oRj8T3mCI5ec4vl+nnlV15HA1hZ9gk5icQj/vRm0N/S3b2WPboC0BUV+XN5EMheZxU0q
         gVfO/xXSOSmXN0EJjQ0iN+pv4vkQmGIze5WY78Zfc8JyC12/NLeWaLxmJEzzSD+jkBA/
         g23gNH82+6WH4A50GMfM2p+TTtZti14jjyClR0qHMvv+fqKmKhdUkYhPayGwHf/sblLW
         J64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=tq1rGOekL7pxfkbRlGyK3KX3p9F0Zh08RbUI+01hRUg=;
        b=BQJTksKwieTvOSfxeofz/LxNAiSc2Ng0bXpHUh0j+/OICYVM/pr0i9Z+SNDdbPH9NW
         L5m59T4mKeh9Jz3+L0dRiS7C5Qxe7CswBMGv+sSI01sWI5VTcGBY2XC3kdl/d2aX/lTT
         Q6T1cKhAQSyxjBqoz6WlilAgVzFKdZcjgAf6kDihYxv8kAfcp/EWS2Zkv/Ck3maGLoQV
         q4SPaz2oM30Q+WsHxVaGOOWt12RO+Yd9l+dLln4XlN03JQuP+yfaFaueLOPq1TY7FeDF
         7ygUDp9PVfFsblhAdCweYv7jefFocIPmbZXEFcfbWkJbT3vl0ZlCUYo3KjjkeLotp0oQ
         g46w==
X-Gm-Message-State: ACgBeo0xGTGwRMwBZhOuCuyMz24LzpNeYjrsUeHd+wmW+R37kkx7ktoh
        4Lo2esHM0GrH7t9xw0t62bcWytitHCIwDphHUIk=
X-Google-Smtp-Source: AA6agR4dBFylOu7ENF0OBdRcDD8jqjP5h6mT6knhTjUUE0aN3cOZzhxPvL1PJy8o3v6+fD7gA3xIeJWHSV8Fb9bzdbU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:422b:cadb:302a:7901])
 (user=ndesaulniers job=sendgmr) by 2002:a25:e045:0:b0:695:8c84:830e with SMTP
 id x66-20020a25e045000000b006958c84830emr13699876ybg.391.1661892810159; Tue,
 30 Aug 2022 13:53:30 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:53:09 -0700
In-Reply-To: <20220830205309.312864-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220830205309.312864-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661892789; l=2526;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=NiERkNadHhm2EwGjNfh56GkMuWFz22MOk8ubAMworHM=;
 b=4b7CW2eRyGqCrk6jxunZg73/YfTFIUeBxElVhLch0T+D+wwOAD/cx2kmbruA1JucDblnRonezs2R
 HQgCnOf3AdtnhlBZTKh6bVxdD5ErMKT/fpOPkr/AzBgtE5AHXXTq
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830205309.312864-4-ndesaulniers@google.com>
Subject: [PATCH 3/3] HID: avoid runtime call to strlen
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking into a CONFIG_FORTIFY=y related bug, I noticed that
hid_allocate calls strlen() on a local C string variable. This variable
can only have literal string values. There is no benefit to having
FORTIFY have this be a checked strlen call, because these are literal
values.  By calling strlen() explicitly in the branches of a switch, the
compiler can evaluate strlen("literal value") at compile time, rather
than at runtime.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/hid/hid-input.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 48c1c02c69f4..9ad3cc88c26b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1922,12 +1922,15 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 		switch (application) {
 		case HID_GD_KEYBOARD:
 			suffix = "Keyboard";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_GD_KEYPAD:
 			suffix = "Keypad";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_GD_MOUSE:
 			suffix = "Mouse";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_DG_PEN:
 			/*
@@ -1938,36 +1941,44 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 			 * will have to change it and the test suite will not be happy.
 			 */
 			suffix = "Stylus";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_DG_STYLUS:
 			suffix = "Pen";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_DG_TOUCHSCREEN:
 			suffix = "Touchscreen";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_DG_TOUCHPAD:
 			suffix = "Touchpad";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_GD_SYSTEM_CONTROL:
 			suffix = "System Control";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_CP_CONSUMER_CONTROL:
 			suffix = "Consumer Control";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_GD_WIRELESS_RADIO_CTLS:
 			suffix = "Wireless Radio Control";
+			suffix_len = strlen(suffix);
 			break;
 		case HID_GD_SYSTEM_MULTIAXIS:
 			suffix = "System Multi Axis";
+			suffix_len = strlen(suffix);
 			break;
 		default:
+			suffix_len = 0;
 			break;
 		}
 	}
 
 	if (suffix) {
 		name_len = strlen(hid->name);
-		suffix_len = strlen(suffix);
 		if ((name_len < suffix_len) ||
 		    strcmp(hid->name + name_len - suffix_len, suffix)) {
 			hidinput->name = kasprintf(GFP_KERNEL, "%s %s",
-- 
2.37.2.672.g94769d06f0-goog

