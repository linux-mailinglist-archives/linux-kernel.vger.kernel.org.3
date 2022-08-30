Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000CC5A7138
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiH3W6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiH3W6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:58:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91418982C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so9659005pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HwGs98rx5BCd9/rgNaN7+8SbaVUbF2hiZY4CVcaNvm4=;
        b=eB3MC0Tad/kB+uoOqsolA2dlwF8ySo8h9JTtZjitG+Gquo+Dyd6U0wXrnhlI9wf5fq
         JlVczQudCM5itV8dzFwRom6m3cIaoIo5oy2Ux5geWqHMWOZtyA6kqkxgfBqQeedxrt6u
         bi0PcJIDVpLWQgfcc1QRNrVY0jqV+m7v4XbbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HwGs98rx5BCd9/rgNaN7+8SbaVUbF2hiZY4CVcaNvm4=;
        b=iIj8YU0nk5qd9UO09wTrIOvPWPS6g4H6sa8pINVQaE9gARP7FrS2n3alFwfaVVwRz7
         ZVMg8cmSvSFcs4u8PyU289BGaomGMplRFOtSCv/+oz8AWl87fLAidAkhIawcwVGsLJ+i
         i/o/bRdrmCPLXlTGrJmnoId0NReqyP0AUtE2zvImTtrQDVOQXi0KXyY8KjN/Hwmyhijw
         /5BTzLtROeZlYIeNv1W8KdGmrQZ+U/8Ku/Ep+YUc2k60IbXE2CYPv8DBMfmiH5VNdMIw
         wypW6AVCx2XCKvd5pXPDYpXa03OaL0w/Gf6Ppf9WhHBkJVlBOP6dkVWS8OJ67LWaL7AF
         1K0w==
X-Gm-Message-State: ACgBeo1glrwzehaQ90lT0kN+Flqk+3EydeGxSsNJW+wM1hIrFAQgOP7V
        /NzSupcNgazvJNe5QrBwvtB90g==
X-Google-Smtp-Source: AA6agR45HAcVMAFaGvKD+VuQ2Xa/q4B6SQ6eo25+pm9MGhFjmFQmLdcpsmWTCIr9hw1VRWyt+jKH8Q==
X-Received: by 2002:a17:90b:4b48:b0:1fd:d2cd:896c with SMTP id mi8-20020a17090b4b4800b001fdd2cd896cmr296743pjb.120.1661900315349;
        Tue, 30 Aug 2022 15:58:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5f34:2f6:2856:188e])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001743be790b4sm10083539plb.215.2022.08.30.15.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:58:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 2/4] platform/chrome: cros_typec_switch: Remove impossible condition
Date:   Tue, 30 Aug 2022 15:58:29 -0700
Message-Id: <20220830225831.2362403-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830225831.2362403-1-swboyd@chromium.org>
References: <20220830225831.2362403-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of 'index' is unsigned long long, which can't possibly be less
than zero. Remove the impossible check.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 383daf2c66b7..3381d842c307 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -243,7 +243,7 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
 			goto err_switch;
 		}
 
-		if (index < 0 || index >= EC_USB_PD_MAX_PORTS) {
+		if (index >= EC_USB_PD_MAX_PORTS) {
 			dev_err(fwnode->dev, "Invalid port index number: %llu\n", index);
 			ret = -EINVAL;
 			goto err_switch;
-- 
https://chromeos.dev

