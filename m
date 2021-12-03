Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7F46702E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378217AbhLCCuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:50:40 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:32906
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378119AbhLCCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:50:38 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87EB83F1F2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 02:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638499634;
        bh=fDAstI6DIL9UfbvksL4gr0n/7nHn2PQecVhugGjIupQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZU2eeVXNzUJZSbPZSbWV7gv2FZvbkcJq5o/p9hk2JSueAWv0NvgkZ3McG4dnKpkEQ
         F8zwFn2Yjrhg2LAPlRnJj8dmuxEgFcqJgWbIVUfRlp1b7KJR4OSTWLkseDFXrUdOb3
         rUsTZ4/zhaIBdEzv+Qr9bUN0ICAiZXWSpEkPCa06WVBHljfnou54RBRvTPym6FinGx
         6Atd56dvaxdsh2doyIL6HDz9ozV0twyWFQH1JCWL5Ke4B5/iDTMBSBVeK2vk2KT6S3
         nzD/e3ItZkky2/QW0UKD3hzGIUmB6svbDeR6wFYP+yUAXFAFxPUKrsx25ocsh6ZdWl
         VnCFB5jl9Z6HA==
Received: by mail-oi1-f199.google.com with SMTP id t26-20020a056808159a00b002bce1f1c045so990768oiw.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 18:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDAstI6DIL9UfbvksL4gr0n/7nHn2PQecVhugGjIupQ=;
        b=jcdEuXz5NkmFLVnIZumEIOYcpPh1uzLFDmhXvown8VCpXc+lRQGnZeqEgt/gB+yhR+
         tlGTTWNg3qpxokkOgYwFV9hlW95wykjqHz+aCYFidVqL2exPR5itH6hc//JQ11qOUqG4
         oGrnUGdi+sBnKv00JOc9DQv1lYlp2TYqF2LyXLgceNEyIk5wh9H+hHM0MqlcIlhUCBGl
         jXiuaKe9QHQRHnNh+QtaXlSH3keb3BELTQBh0Om7AxPZIW6DBzXbUQSEZwXhYUA9o4f7
         JriS1kVsKKdPi6Hc7g5n3jFvx56ywgbw8BeJZAaaf2m3cXsdNGaB52d+E8BBwnNpNGUC
         Rqig==
X-Gm-Message-State: AOAM532L0qtMRBlJxC3npd1G7gQuguGwUM1bXsd5IoLhjH1GHXIY6A0d
        eiWR+lbfeP8rqA/jVcUAf+j8G2DU2nNSHmSp6melcta2ODLOqJkWJGszUu0GfUnsIz3iO8U3xBG
        qGC/cnzSHtlCxl2bpuEzco26lYTr1+pXJ8FGyJQil/g==
X-Received: by 2002:a05:6830:25d4:: with SMTP id d20mr14480135otu.143.1638499633049;
        Thu, 02 Dec 2021 18:47:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhvmsZ9uP4iST+5v+2YQgJz4fxTD7lkuQNSN+Aaq46H6JYE7tj9XMThgNR4o3MjXZvoX2lvg==
X-Received: by 2002:a05:6830:25d4:: with SMTP id d20mr14480122otu.143.1638499632877;
        Thu, 02 Dec 2021 18:47:12 -0800 (PST)
Received: from lukenow-XPS-13-9380.attlocal.net (108-249-109-234.lightspeed.sndgca.sbcglobal.net. [108.249.109.234])
        by smtp.gmail.com with ESMTPSA id s26sm452642oiw.19.2021.12.02.18.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 18:47:12 -0800 (PST)
From:   Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/memfd: include <asm/types.h> in fuse_test.c
Date:   Thu,  2 Dec 2021 18:47:06 -0800
Message-Id: <20211203024706.10094-1-luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add <asm/types.h> include which eventually includes __u64 typedef.

The __u64 typedef is sometimes missing depending on the system headers
installed, leading to compile errors. Adding this include makes this
test more likely to compile on a wider variety of systems.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 tools/testing/selftests/memfd/fuse_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index be675002f918..725561ac5a38 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -32,6 +32,7 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <asm/types.h>
 
 #include "common.h"
 
-- 
2.32.0

