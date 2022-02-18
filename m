Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73C4BB004
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiBRDKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:10:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiBRDKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:10:08 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83948BF17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:09:52 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c7so4507734qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smgI3MOP3ZExWA5vhZDRgT/sxoUbszVrY843KRx6UAg=;
        b=LD9RgfrJLO3yiJqzb0a/d85Ea/mQa6ykDAloz/d7bw2cxwQ/GLWKDDF6lHPBtQT1en
         Jyoxwiofg1/Rei0oCty7JNAK2/hYSrKLAnZR7+AG0GGz6GN95Fn//ed2HKf7p1eyuBTz
         NOkLHT6HidkAjcDphEeoN+VKyd1FKDXmDq4Rp/Knhcisjq9ViwkGwiBsrSa3WtuFS+gu
         oIMWT0KN6n5+99MHCyLUvN3ma4zsLNZnV216Pz+Z/FOsSa1aHNySa6kSbHkHKEFm4Zat
         voFG48IDr0WMp0EYu3WUaKtnybxQibI1g0twdGQZuJw37hNyfmx63Na9LYudiDFrYOMP
         uTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smgI3MOP3ZExWA5vhZDRgT/sxoUbszVrY843KRx6UAg=;
        b=gdHS3FIHCHhlQTZkTUpBw5TQGzjwCRTNHtORbhlNoscXvprN8JXt8lugKR4rxOc897
         vGe5MSdshciwzGkbEy/cNB8470Nbih2qtUIvbFjHN/aXTRvVA9bc2xm6XGDkxxicBXJo
         vjPb0htexIgzLkofsqVxYpUVGCgsTbKT0jQ3vJElmeHPUYGnWNZ+b9T1iRgLScF+H45n
         WjMb/bLEAE/9nC48nCGjieDtEj5eu9C8OJPaaOblHxtWY7pVbBM0SMe9Bj5CxQnVP7df
         B7h+U+UM/hxHxDZRvVSpp4iwGFYclMMU3MQfvY9z7vN+ZBkO2TOePk6G9vtV3ap083aC
         Ihzg==
X-Gm-Message-State: AOAM532xyrDrA1op6FRbvhXrfMAwXbwQEGS4JyA4RZiVsiQ1ASh0CCnB
        18WK2zeSzPapieCnRCY7P+U=
X-Google-Smtp-Source: ABdhPJw1Q3QSxbTpFYTAMVPiPbtJT/XnqEZtz0Oe56QkRWMBRMl8AHCPp743iOr09CjOYbqSk++aSw==
X-Received: by 2002:a05:620a:11a7:b0:60d:df4a:f732 with SMTP id c7-20020a05620a11a700b0060ddf4af732mr2948880qkk.244.1645153792105;
        Thu, 17 Feb 2022 19:09:52 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x13sm22366287qko.114.2022.02.17.19.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 19:09:51 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     Felix.Kuehling@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdkfd: Replace one-element array with flexible-array member
Date:   Fri, 18 Feb 2022 03:09:43 +0000
Message-Id: <20220218030943.1905838-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use "flexible array members" for these cases. The older
style of one-element or zero-length arrays should no longer be used.
Reference:
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 482ba84a728d..d7c38fbc533e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -310,7 +310,7 @@ struct cdit_header {
 	uint32_t	creator_revision;
 	uint32_t	total_entries;
 	uint16_t	num_domains;
-	uint8_t		entry[1];
+	uint8_t		entry[];
 };
 
 #pragma pack()
-- 
2.25.1

