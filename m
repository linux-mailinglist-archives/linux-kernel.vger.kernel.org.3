Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42104EDACF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiCaNru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiCaNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:47:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C78541A5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:45:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id yy13so48247085ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/YUi6mCcjJfNHzYelacuYuRxwq2OVmqFdDTkQF6fA4=;
        b=HEVrrCaJT5HkNqz8wOQ5XL4tmcwa8NXw3F16ZsW0kiaE+kG+kya5uzynWCzIq15QBb
         zEjWjFg5wPus55PGqmm9QzZK6PWbnZZEOirBcQJUPsOEG8wRKR+DGkQsLKAofG3RWnf0
         LfNGwaM7ZTYQMqF4mME3FWXzy9ZPP09/uMT0wlPxZzXf9OUCj1BX9MAMar5WH5kSqQP9
         GyKF7OvUt4uiilKbmFh1vpS+xTvYzCBCcUJyAQ3NSTwywZ8kzM1dn2G3UrOeLoNPintX
         gB7x8piKyudEoEX9A+zetdGHlRM0tttjFrsmagbaTIruwVZyHZwTRYOYhtBJ5HoKUhIv
         78oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/YUi6mCcjJfNHzYelacuYuRxwq2OVmqFdDTkQF6fA4=;
        b=Zfxv9Ej0jIOL8zGEJqD09mY+Yb6SIg8Q1n81QvQpLkir3HuVLEPWkOgSTJJaa6BlHf
         iWaq/jqABt8EOIEhlRIUhN0RuywgAqJYJDXQbnhYlAz8q62wWsg0fWh2iWXwbOaffFdg
         reWlpRFEYE6mfHLMXjfmgiuJcCQ92pAFM2nxHoJSc2HfTF/Tdo5sfnY7ETWHJcNa36vr
         jTfAFnrd79H+6hym1KuQhYQIQPkLBmeZI1C9XowMpjGpzzQ29kVVBpqzRzdsT3cTgeqk
         W0BuigF9OvFkpoa0gmfnvDjkUKbunXLPlTDgrL1f6VnAeYPnvz+dRI7HeIdDBsLjY8rl
         WgDA==
X-Gm-Message-State: AOAM530TwBEeNCAGSJUEPNzbM2BcYvXuoF52c+AunhJxTr1C0Nvbjgxx
        QJmgSVY0sPhgl9WRoN27BP1B53Fg2YG0n0WKpJg=
X-Google-Smtp-Source: ABdhPJzhQUSYxSwTyt2L3VUiLv2LZj/el5j6vlxbV2KYX/vtKDQC6JfK47m4Z8URiJIlslpkHEDH7Q==
X-Received: by 2002:a17:906:9f25:b0:6e1:205a:c47 with SMTP id fy37-20020a1709069f2500b006e1205a0c47mr4985936ejc.281.1648734358430;
        Thu, 31 Mar 2022 06:45:58 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090694c100b006da91d57e93sm9360168ejy.207.2022.03.31.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:45:57 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH] MAINTAINERS: add drbd co-maintainer
Date:   Thu, 31 Mar 2022 15:42:36 +0200
Message-Id: <20220331134236.776524-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In light of the recent controversy surrounding the (lack of)
maintenance of the in-tree DRBD driver, we have decided to add myself
as co-maintainer. This allows us to better distribute the workload and
reduce the chance of patches getting lost.

I will be keeping an eye on the mailing list in order to ensure that all
patches get the attention they need.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53df75660f16..b1f5f034b2ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6038,6 +6038,7 @@ F:	drivers/scsi/dpt/
 DRBD DRIVER
 M:	Philipp Reisner <philipp.reisner@linbit.com>
 M:	Lars Ellenberg <lars.ellenberg@linbit.com>
+M:	Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
 L:	drbd-dev@lists.linbit.com
 S:	Supported
 W:	http://www.drbd.org
-- 
2.35.1

