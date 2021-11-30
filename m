Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34DE4635A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbhK3NnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhK3Nm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:42:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E94C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:39:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j3so44547977wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJCq9TCGEAAe0QLHunar03JYEki0s6MYd1+NMSRrcoQ=;
        b=d/w+E5n/V+5hBxhdk0g75WsoErH+8H1iKLmZannde2++Fr/6UjHzfMvAlp6aRufDQn
         dNc9G4BjfygJXuYQaYdMG7DePZa9rbuor1BqxlhBPgHLnVEAVOLir+CgWz19Y6hcvEAF
         pa+yni/MVoSpRewsyjGS12kYZyzKWsXDONXNYhDPArkX1FN0jqUtVnPUnMZybLKrcyzE
         uk8nqN8ABlVRP11ghqXlndfp+JGqhxIowfwfJOSMvxCN4n3X+6kr/VlbqRIs96lGPK3b
         cups+JT+cG0I8cFb2w+EwlB0cuTu9Ua1hkXg89tO0WL/tqnH9j84LtmVWLXEh64RBcEM
         GM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJCq9TCGEAAe0QLHunar03JYEki0s6MYd1+NMSRrcoQ=;
        b=58geNFfVLCOlCMMhXl4hYzRUc1GXWFf+8eqoC9j/kFTjmMzSNEapJCW6xm5H4QnCOm
         PmoSOy7cHZVxBRxeAgXKcYSxU5V7sWhy1f3BLUmGorZ71dHBI27rw3LOMryl2HmhYkZm
         f7A54kp/1Cq0LaJ5HqIQ3L2bD0FhzA4jPKXkz9k8bz2gDYu/7ZEprSdDMDjN7GN5Lcin
         RJdAAT2bIvjE9V01EmWccrmEWlQqRAHcHkVEaSQIgcy3K4ZxzRPCPWbLq95K93+bp0Oh
         i8IS2gPNnKXuKRw//i5DJMmSiY0PaGlRdla3mozzsd0hfhgqulTqRdrsdADZaB75DmAb
         StxQ==
X-Gm-Message-State: AOAM533noSAroYhnMQUBkepVzbktyMVbtD79MDzw5cxXkxPKSbmbdzN+
        bmy+JjhvWKDV6Dg79pmBICBNeLpjofRm0w==
X-Google-Smtp-Source: ABdhPJxEmuREGy9jGWmDmVT4kO+DDDSfvPjc8VXIgod+dlmXN1TdJOBQlniYcjGxWcZ7v68yg7j7ww==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr41374973wrm.470.1638279575919;
        Tue, 30 Nov 2021 05:39:35 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id f7sm2825820wmg.6.2021.11.30.05.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:39:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Gilles BULOZ <gilles.buloz@kontron.com>
Subject: [PATCH] nvmem: core: set size for sysfs bin file
Date:   Tue, 30 Nov 2021 13:39:09 +0000
Message-Id: <20211130133909.6154-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we never set the size for nvmem sysfs binary file.
Set this.

Reported-by: Gilles BULOZ <gilles.buloz@kontron.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e765d3d0542e..23a38dcf0fc4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -312,6 +312,8 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
+	attr->size = nvmem->size;
+
 	return nvmem_bin_attr_get_umode(nvmem);
 }
 
-- 
2.21.0

