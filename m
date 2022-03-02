Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3D4CB038
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiCBUtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244463AbiCBUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:01 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206846D84A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:16 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 195so2637148pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/qCzXaSJsTevlXZxqUkbNmOTkHTMDBspxfTDqWAX6k=;
        b=BrUxiwuIeoNRbH8jZ36dzBZx/WriEcfMeF8R1thCBtA3mPceDRxvDDHJgIUlNSC73/
         o8Ef0k/TlerQjGcBWXZY+nR5akDOMaGKr3yHpeHCt3TQNMxRVYYjON2xCuT8rO8Swnfe
         G+MXqBP4mCD7SbVk/YT4+0t+hiiXfQUkMchwIVn5PTt9IVAlouYbHelpbKEwI872JcKk
         MLIxt8ZfX6NR6htfwg3FXsYR8EiP9WdKyLGmpepz3Salhb/t5eSGeNXPvojeuX5K/vPG
         iyeJ8OO2fI0e6rofjpAjwAUuwRqDoe4c9htP7ol076HnELRjXsXztp9MI/X7bMP7kBOQ
         j49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/qCzXaSJsTevlXZxqUkbNmOTkHTMDBspxfTDqWAX6k=;
        b=4W73oVvsG5QXHYTFJNthXY8segmzAbYmcMsEt+rJXgV6k+lqzYIU3yBjPAFyMQGHEl
         6lLOfia7hy+GWXXE7UZJ6CH7675EAvVCJCoSgiz/LBiZSeZTJDSMrKzOX+5hTCx5MFhl
         sKPywjsGQLP5z7DMZ29rSVKnrs94eLXFMVs16I53Da7pZJJsR+0LFHAAGfNsKw0XqHU8
         ECniTFJ5Dnnbv0jlTPabQM0Q5sFjjTQO2n+deksBBtr67ccv+BBP4GOvyKgcWjbiWqnH
         ZGdFKOPynS3bR9L7bbKFFOOJ74O/Lg6f9JytXy+dNn8lFfLUuNg0vHlR7zbBfJBfLmO+
         7B8Q==
X-Gm-Message-State: AOAM532xwG38H71tSLZ105OoIQgqgn6QerTlrib4LN6fkcOI9OaEnC0E
        TqvljmViqXdw77iLU7gNE6QiQ5CMPdr/+A==
X-Google-Smtp-Source: ABdhPJzBpsupHvG4Cux6vxKxRLWFsQe6QIitvMOhFX2OwjcuhGmCCe9xm+u30rBgNOjUkQLql+HQ9w==
X-Received: by 2002:a05:6a00:3006:b0:4f6:54ba:3581 with SMTP id ay6-20020a056a00300600b004f654ba3581mr4128592pfb.83.1646254095641;
        Wed, 02 Mar 2022 12:48:15 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:15 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 04/16] staging: r8188eu: mark PS_RDY_CHECK as bool
Date:   Thu,  3 Mar 2022 02:17:25 +0530
Message-Id: <20220302204737.49056-5-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
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

Mark PS_RDY_CHECK as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index b20436f75..7beabf82e 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -151,7 +151,7 @@ static void pwr_state_check_handler(struct timer_list *t)
 	rtw_ps_cmd(padapter);
 }
 
-static u8 PS_RDY_CHECK(struct adapter *padapter)
+static bool PS_RDY_CHECK(struct adapter *padapter)
 {
 	u32 curr_time, delta_time;
 	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
-- 
2.30.2

