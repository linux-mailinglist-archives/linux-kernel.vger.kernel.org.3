Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5957448573C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbiAER3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242255AbiAER3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:29:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9BDC061201;
        Wed,  5 Jan 2022 09:29:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e5so84509309wrc.5;
        Wed, 05 Jan 2022 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLJ0atlZelpnb95O2mRH3Zdf/JvlCYdoZsqjm3uLcC4=;
        b=Gzy5I4vJIEmLsZZ5y0qgeS/aSqMzGqt2EZmUDLbSVxQmks023qGvD1ytTjPdLO39AJ
         +3jvwDN+pJv6VIb819YSHFHYm4s5a7XQnDLQ1YyflsZTLSIKN86+r4pFUmZ8+v0adGcn
         vn5oIs2UoB0r4RvT2E51r54tJr38EU2Irc9/llTCZeWaXQSF6FGU2+TDD9ubrPnbGZG9
         ugiBLLYM8Dexkkz7UaXz7FFZxOjuFCzomMMne5NOH8KeKNZmVp1pXAbgvyl02FmAAxYo
         oTdMr4A7kmX7vnunCzmE8TTH3AMb6e7oVmWJtwi8aqMrzaQ7wfW5kMDVXqZ4vMoadmxD
         Tb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLJ0atlZelpnb95O2mRH3Zdf/JvlCYdoZsqjm3uLcC4=;
        b=sv8S2Qyf9iC7B3bAIfC3KIYd7psdtGiiGAJ+NQFZJfAlOff3tBfpuZAtxzoPWFh2Vk
         blCVQnqEZDVXO0ysqBL6UzxMbP1bNt+eAG0PdQO6BaAj0gUYVL90up6/8ESycWivdiae
         W8v4q5NpfwpYhkJ3aN2RPdNIa6DDS9GN40bMCCtngYU1jzSoeJY4z2YbRrIca3E090NE
         JfFsnsVgUp/eH3fIH200PGyabwmKIp+59BrdEtwkxvjL7De2kjuKbvrPTQv3b1FIjwNS
         2xG2iWbGcFdFJZHSYR0lDl9dPMZq3nfuFpBCuIRrHe73W3dyL8jaaW4Ml6oOVedBUPY+
         e18w==
X-Gm-Message-State: AOAM532SNQwcHi/jni1M77gi8MAKK5LWDht/YNv3pnLpSaQQClyBdx8X
        8I6QLlkyz2ccXA/0AfVGifk=
X-Google-Smtp-Source: ABdhPJwgvi2gCbOTJoe+m+KLQHatR0exAU9ZHyDFQO3YliCy/uwOfTcC+C20ZISbcDOWvDXclP5kuA==
X-Received: by 2002:adf:e904:: with SMTP id f4mr47248973wrm.245.1641403760315;
        Wed, 05 Jan 2022 09:29:20 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g6sm43071442wri.67.2022.01.05.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:29:19 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, spbnick@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/4] HID: hid-uclogic-params: Fix NULL pointer dereferences
Date:   Wed,  5 Jan 2022 18:29:11 +0100
Message-Id: <20220105172915.131091-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series fixes 4 possible NULL pointer dereference errors
present in hid-uclogic-params.c found by Coverity.

Even though the fixes are small and very similar I made them
in 4 patches to include the Coverity ID on each of them and
make Coverity happy.

I didn't find any code calling the functions with invalid
params, but since the check is there, it's better to make sure
that it's doing its job.

Thanks,
José Expósito

José Expósito (4):
  HID: hid-uclogic-params: Invalid parameter check in
    uclogic_params_init
  HID: hid-uclogic-params: Invalid parameter check in
    uclogic_params_get_str_desc
  HID: hid-uclogic-params: Invalid parameter check in
    uclogic_params_huion_init
  HID: hid-uclogic-params: Invalid parameter check in
    uclogic_params_frame_init_v1_buttonpad

 drivers/hid/hid-uclogic-params.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.25.1

