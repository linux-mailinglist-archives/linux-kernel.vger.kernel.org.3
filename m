Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D864CF2BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiCGHmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiCGHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:42:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BD11C0F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:41:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so10471937pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruPMGqeWb/VXE6LVkwLB6ZypHxDSmZyVkhBDBym4xug=;
        b=jNmT5ZLEhdxgLwZ1JmjTYZohGGLcRGo5QlTctu0MS3frEiFMEUXaGpZg+jvYT3ZcvG
         M2qhiugCFpTb8YY5zAvXzNABbYJMyedEjGG3zYnfpUs0to4p7AX6pHsSqW3BknHMKdOh
         xW1pWGAMRtsELQP5p4E5e9bgCp8/34qVkyD0Hn1MMOSDagsdKCALDjXW/OSj7QTchRhj
         rBY4r+Kl2X+661AYc1ypusciDcIhm2C1OyKwJmywgPYWQzCYa8qC43k6V5tE8VxBHHNe
         t6lEhbWKb03Psjt0clvsWR350fdV+Iww1XizChuSNVETxIx0Y6qRQP4MWxcpCF+aQLWc
         KoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruPMGqeWb/VXE6LVkwLB6ZypHxDSmZyVkhBDBym4xug=;
        b=3/ltyZcO22+shJpEUq/FH4ZuCLwdHWWkY/GpKLmHM7G1otBIM0/vv3SBa2o5ield0N
         HYNC3gXh04F+S7TFjO98naVE3b7eZFTtF5cNmc71LMLv8QeAW2WeyBUN3hu3En4rDksY
         OfuvVzSX/BplqoeKKKaTPh9HTrq3bNjJDFelLMfL9fGMHvTQ9p8/4Sw60zkkLQaVwbB6
         hU/cZO7DeOQKWtAD6g8/Cr1Sd8Upm8vNkPnNG+z21jXOkSJ8bTO8BD/4lg3cgkdlJg7S
         N8BKynPEK2eXGn12LMSSkjNyIk6WMsOzkcGfoGYQT1JHFtqmABRwGjTlQxikgcFWmfIw
         bnbQ==
X-Gm-Message-State: AOAM531O5lSG7txeKNtj6i+9fUp5zO0H7HM0qdEb9oNVHHRgGXB1pRis
        5PYYHYkfXtFYCWxSijaq8Sk=
X-Google-Smtp-Source: ABdhPJzyXG3H1K4h7sx1RNb4/P08gwVfbKjVatmlGKX4TiG66YC4kzeYyunGk200Y0WZtMj76BehBg==
X-Received: by 2002:a17:903:22c7:b0:151:a594:bb85 with SMTP id y7-20020a17090322c700b00151a594bb85mr10846064plg.107.1646638875071;
        Sun, 06 Mar 2022 23:41:15 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm10878743pgn.2.2022.03.06.23.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 23:41:14 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [PATCH v3 0/2] slab cleanups
Date:   Mon,  7 Mar 2022 07:40:54 +0000
Message-Id: <20220307074057.902222-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
	Adjusted feedback from Vlastimil. Thanks!

	Dropped kmalloc subsystem generalization patches.
	I did more work generalizing kmalloc subsystem.
	Now they look quite bigger. I'll send them as separate
	series with RFC.

Changes since v1:
	Adjusted comments from Matthew, VLastimil, Rientjes.
	Thank you for feedback!

Hello, these are cleanup patches for SLUB.
Please consider them for slab-next :)

Any comments will be appreciated.
Thanks.

Hyeonggon Yoo (2):
  mm/slub: limit number of node partial slabs only in cache creation
  mm/slub: refactor deactivate_slab()

 mm/slub.c | 105 +++++++++++++++++++++---------------------------------
 1 file changed, 41 insertions(+), 64 deletions(-)

-- 
2.33.1

