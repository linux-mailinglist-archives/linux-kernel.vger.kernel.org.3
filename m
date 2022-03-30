Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69BD4ECC59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350430AbiC3ScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350125AbiC3Sbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:31:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08F5BE65
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e5a3c1384cso176664827b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ysfkn8590uSwiZlCj0dUf9b84jhm3+YPx7U6wcF1Lh4=;
        b=Ec80YCYBr3+7x1dgVlMKktNo8EJlr6iPYG0vTk8LWgCyoQP+XN9M1gzNkurZEEaMcj
         S78oygo+a/0db+2wSn3eVgplMSdrZG+n2X5aw7yL8YZzxgEqHqGDPyZThvThA2B6GoG2
         ct0/Rt6/nROfnrFCDxmArktdywO+QKCq3JmmhVjDS4yT2e8CkY6xCGgSGHgb400XPAcC
         t60jjmZCLi5eoGzVOvw5vbl+9zEXtLLQm/sMMj9uPIyBCgIuWLvWleTSpsgAYMZmNMe+
         BSjgeGkNVpTq0p3Z8d+U8Dzr2nWFPF1uLCyCJgxjasTT7s9O6DB1Mb4G1xIU4Izfn1SL
         7Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ysfkn8590uSwiZlCj0dUf9b84jhm3+YPx7U6wcF1Lh4=;
        b=MI4ECmgP+aPj0fj+EJ33wNZPgRH7wOVj42M8vKNlCAYtN3x3VxmO/YyZ1EqDkrjJqB
         kIMB0iOdX35E5rWvtKvbAQNS8bUQGAseARzRoeeFVdxgxunJzWwT+w50SvXJ6yTHpKmJ
         ACEuWmhXrzaLknelznQhA2UK89ZOt6I/0PMadqP67zDqRsq9dldweRkeNXjkKPo5MRWv
         n6lQOB8Ue8BxNAM+N8joMNSx3ZZQpZInyW+ZX61yrDT049ehRFhwy9f08DPsLbUchafq
         5GfgJss5CQkyjrnQ8SfWKpK57zYk6RyXyFrftHo6JoAASddPVnG+5Oe/FeepdFqz9GsK
         bAWQ==
X-Gm-Message-State: AOAM533+rKckc1/MnUOkqJss9uJtf6AEwM5LI5bOr4RVp62GQjT3vcxF
        vUA04cA3ZF6kM04Sc1Doqx7BNhZyz631
X-Google-Smtp-Source: ABdhPJw0Duj6d5LABUuiiO1V+ipIt5z0acafBXL2Y3+v+mwd4Jvo8mt5MynPoHu41wYCZvlDqtw6v+bLefA/
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:1db:3f32:3ad1:f38])
 (user=jmeurin job=sendgmr) by 2002:a5b:7d1:0:b0:628:d9f7:c5b8 with SMTP id
 t17-20020a5b07d1000000b00628d9f7c5b8mr990898ybq.347.1648664909434; Wed, 30
 Mar 2022 11:28:29 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:28:14 -0700
In-Reply-To: <20220330182816.1177341-1-jmeurin@google.com>
Message-Id: <20220330182816.1177341-2-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13> <20220330182816.1177341-1-jmeurin@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 0/2] mtd: mtdoops: Structure the header of the dumped oops.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current header consists of 2 32-bit values which makes it difficult
and error prone to expand. This creates a structure for the header.

Changelog since v1:
- Create a header structure to simplify code.
- Patches in series.
- Patch prefix.

Jean-Marc Eurin (2):
  mtd: mtdoops: Fix the size of the header read buffer.
  mtd: mtdoops: Create a header structure for the saved mtdoops.

 drivers/mtd/mtdoops.c | 53 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

-- 
2.35.1.1094.g7c7d902a7c-goog

