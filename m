Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82054F993
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382358AbiFQOrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiFQOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:47:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10657427D0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 184so4230158pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5N+8KCowyqZRNZ7vTw4m9NdGwB8bBd3Ii7+WdPJ9As=;
        b=QmqjE+ET9LH2TybmyoABnVijArR93RQ9RTCIbNa0idxuojBQSuRJmw7T/4311JlEm0
         NidNnq/eY3bttx4fDLE9drZ4uQnxvnFYAK/Yd5IHRRZGGghHZImUgvBXQ4NuL/iDC81v
         fI+C1Tb4T0ndTSA0PQHyqci7iBqQjvMeDz19lYSr9z0W9OG3nu95qMC6Bm/1v2DqyaIk
         HPxd9MEjudGIKZ5ii39uR7Of69zVL5ZDxn6ryl4EA1djYYGossKbw2DRmBv80g23NAPY
         RBSDgN/QVjmlaZ6NbiThkn5GR5F4dQbyrW5FCThdeppQ8J17LDNV6J3X1ytWy3J+MJ6y
         9VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5N+8KCowyqZRNZ7vTw4m9NdGwB8bBd3Ii7+WdPJ9As=;
        b=euiGS3tVtmmRDEBjDYpVz5GT7ZvPoCaJQQPGXIfN2t0/rx9d8kORUm8xYiuacksZBZ
         RnyKdz34VIlZXMxeht/SQMBwXZzehTva5Vb9yXMTx/lWQVOew0Q6rjT8X3icXMggMjRb
         mQ/lvNUsrRZiNY1cRh43MH6A92x18qDAMCFoTDv6WXw9a+Xfnz7pf6KglnjYgLcCXrD2
         dgak05hoIaRWQiHenA1SshgxLE9J0+tUpvEHGGJb4BvDICXy9VOFsaI0v5VS9qpbv8UG
         tvp+yq20oCOQfJix53KUhV3o0nuPTYqg8AnQFHVpTR/S9aEkVhpa6Bt7+qg4P36ZZWg/
         2JoQ==
X-Gm-Message-State: AJIora+FYN+3gacH7I8MEQvmm1MccGvrk6wngozQhFpcuU6LAel1UN/n
        Exs06Fq1MoY2EXSYFKOUCMOWETE4pkuAww==
X-Google-Smtp-Source: AGRyM1vwyOr0pxz9T9hqeEPcia/apCBzxMZUCLKLRxNuFdc/fX72cl41sXHf+QgTK26m9lLsQ/NrYA==
X-Received: by 2002:a05:6a00:a21:b0:522:9134:c620 with SMTP id p33-20020a056a000a2100b005229134c620mr10488475pfh.68.1655477224599;
        Fri, 17 Jun 2022 07:47:04 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id o12-20020a63a80c000000b003db822e2170sm3832453pgf.23.2022.06.17.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:47:04 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Ivan Djelic <ivan.djelic@parrot.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: rslib: Several improvements
Date:   Fri, 17 Jun 2022 22:46:19 +0800
Message-Id: <20220617144624.158973-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Hello,

I made several improvements to reed-solomon library.
Please have a look. :)

Thanks!

Best Regards,
Zhang Boyang

===

Changes in [PATCH v2]:
Added more patches. Removed init_rs16(), since init_rs_non_canonical()
can do the same job.

Changes in [PATCH v1]:
Added init_rs16().
Link: https://lore.kernel.org/all/20220606101901.83538-1-zhangboyang.id@gmail.com/

[RFC PATCH]:
Link: https://lore.kernel.org/all/20220605073857.126497-1-zhangboyang.id@gmail.com/


