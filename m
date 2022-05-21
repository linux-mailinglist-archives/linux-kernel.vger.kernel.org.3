Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2152FF74
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiEUUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbiEUUh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E4B73A5F0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653165476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lV7BrdQ4ujV3JaRxGlibSyfD3tp6S+keiDHJLEnX4rI=;
        b=RAqbyOmS51ievNl7ApfytWFWmF9+VsQ7oPavDcLx4zGmdhM5YYr0qykstW7Iy31DzHxZck
        j7h6h4hstiuXSRTA89R5MvhtLxU+GlG4XafCnnLwJbbLQNCkiwodjwcnxzlKxDspUDjF8U
        c7cZjbVGyIIMozgc8xfIY653FBTa6Xk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-LIRptqfbMu6q8kNVxYxapg-1; Sat, 21 May 2022 16:37:55 -0400
X-MC-Unique: LIRptqfbMu6q8kNVxYxapg-1
Received: by mail-ot1-f69.google.com with SMTP id c9-20020a0568301ae900b00606aa7e2d03so3327348otd.23
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV7BrdQ4ujV3JaRxGlibSyfD3tp6S+keiDHJLEnX4rI=;
        b=QlMdz/lqTIJlSSdB/T4A+jF2+VsOvab8pxmJRf/tukuoSBU9xCqBTMWzS+xqDgk7TR
         4LATXkk+CjdszMl2KQjNHcCc/vV2Pls9l9CYhQeHADcQqEHD1YE45bxYuejHprJYdQe2
         zAIGTjw2qzDFqCbF1cmaHw/U9+/LXU17kXuDgg7Mb3ZyNM3X2kNiA72Zj7sHGZmMhnvE
         xmHpE/dcQNRYpgrkWCagU8N9lyfvCRHyl4s5R0ySWRvQMHDZhOTVnwVA2bl5qLFUi0cL
         77T6E9wxNW48ZPjyrqlrboaLThP1cVw9VbRrLak/b7atgMAz6qUpR0hEasJyEAB2cBV7
         IUHQ==
X-Gm-Message-State: AOAM531tTt1aUegz+YvIAIZJAjITUX7wRle8JOPs7azffRFy/roKu+cq
        YODuUN2lsOStPepXr8Ia3RjIcptGSwdoorty74afewM+L60Zx5TYRH2jKScFp8YuacnxCmjKTON
        6OIuVwy/z8Muk/XmXWGllqGd+
X-Received: by 2002:a05:6808:1814:b0:32b:851:35d5 with SMTP id bh20-20020a056808181400b0032b085135d5mr4002286oib.206.1653165474492;
        Sat, 21 May 2022 13:37:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIxKBUfhEWEra9+wIF21FKv7KmWa9pxAfcrwEuD/KklNUJaePTR27sfK5MfHrHG2DsQpmg6g==
X-Received: by 2002:a05:6808:1814:b0:32b:851:35d5 with SMTP id bh20-20020a056808181400b0032b085135d5mr4002282oib.206.1653165474325;
        Sat, 21 May 2022 13:37:54 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s11-20020a9d58cb000000b006060322127bsm2388730oth.75.2022.05.21.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:37:53 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        luciano.coelho@intel.com, miriam.rachel.korenblit@intel.com,
        johannes.berg@intel.com, quic_srirrama@quicinc.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] iwlwifi: mvm: remove setting of 'sta' parameter
Date:   Sat, 21 May 2022 16:37:46 -0400
Message-Id: <20220521203746.442924-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
[drivers/net/wireless/intel/iwlwifi/mvm/rs.c:2686]: (warning) Assignment of function parameter has no effect outside the function. Did you forget dereferencing it?

The setting of the 'sta' parameter is not needed.  In the if-check that sets it
to NULL, mvm_sta is also set to NULL.  Then the next statement checks if
mvm_sta is NULL and does an early return. So remove setting sta.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 974eeecc9153..d75e3024ae3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2683,7 +2683,6 @@ static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
 		/* if vif isn't initialized mvm doesn't know about
 		 * this station, so don't do anything with the it
 		 */
-		sta = NULL;
 		mvm_sta = NULL;
 	}
 
-- 
2.27.0

