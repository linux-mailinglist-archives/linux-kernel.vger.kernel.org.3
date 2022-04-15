Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95265501F79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbiDOAQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiDOAQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:16:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB571ECE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:13:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x132-20020a25ce8a000000b00640812b1ebaso5580853ybe.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gevz/8s4aTZa7UyionFqz1/O0wnMKNH0sOq9DFAK64A=;
        b=cHodgi5G8YDwnd+F/sUNqeULiv5a2otEAcRL114qBW2xlh/SRBZdEjfgDO6fZYvM9R
         GtJUidXJWIGyT1Zh7fpPTknVt1yHFQuF8CFz6t7PG9weYbfNqhof9A9p89iBAkI8y6am
         LSuEfH52/f6DDWKQ9Jsx6fwiO8Xs+rfy+L3Zvt5WbTTwi0r6ydjYRJNAG4WL37wtwl2g
         4i4oER60OYbZN2a8k5A7ZeCxDarZ1wQh6jy7gCtcHBTG1gDTqUriLYsr5e7L8BmRU+gi
         XNaDNDKN0Dbqv23g+jRYNirSlFXxOeDq+JuwLn6yngSyjxEafTxEIguTTRcBwof4Cvjr
         Y0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gevz/8s4aTZa7UyionFqz1/O0wnMKNH0sOq9DFAK64A=;
        b=VTv2wsAcfm0SigQYyGmiiOXI2odOcJBAKAqod9b+sKtbLSJOUiMauExCqUz2s13ni6
         E8NcxDEJkf0ICwYatyUZlhh5asZTZjHZ4FDbfdH65W3F3/cqcKvwhhWGwrpGrknEaNzo
         yarhe2FsMBDSTVsKuLyX7uyMPN11aVxNvWeMiZin/QeJ0B2G4+xK7y0lKsUYFOtVXPzj
         63j4+tWJ9vyks8a6qzpjrncKcWsrOqpWQk/0rMOmbCwl+EhMkZIiPdtGsbeF/BqCa0t4
         6UD23LxgkvcFcQB4UAbhH2NsMUjFWbFIncIt1EtpGjNZCgcr2guEHUUj2e1XeM7wZDzx
         Xg1A==
X-Gm-Message-State: AOAM530E610dxNsjgThjqA0eHm3cNgLqS6KFvieoUVz6c6iC9gW7oS06
        DWXemRDZuML0SQT4xV4v+NJxZbQreG92
X-Google-Smtp-Source: ABdhPJwrid+hNYnF7HPIwgJoxOUopxCoZtb7MzlmmsoaM3mFgprbZJzVZz1qPEl6JzQ5fEmn7MaTLTvwmK31
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:7d77:8cae:9dfe:95c])
 (user=jmeurin job=sendgmr) by 2002:a25:fe0c:0:b0:63d:958d:bf5f with SMTP id
 k12-20020a25fe0c000000b0063d958dbf5fmr3696825ybe.353.1649981638133; Thu, 14
 Apr 2022 17:13:58 -0700 (PDT)
Date:   Thu, 14 Apr 2022 17:13:18 -0700
In-Reply-To: <20220207163409.19c3bc4c@xps13>
Message-Id: <20220415001321.252848-1-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v3 0/3] mtd: mtdoops: Add timestamp to the dumped oops header.
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

Some oops only have time relative to boot, this adds an absolute timestamp.

Changelog since v2:
- Add a timestamp to the header

Changelog since v1:
- Create a header structure to simplify code.
- Patches in series.
- Patch prefix.

Jean-Marc Eurin (3):
  mtd: mtdoops: Fix the size of the header read buffer.
  mtd: mtdoops: Create a header structure for the saved mtdoops.
  mtd: mtdoops: Add a timestamp to the mtdoops header.

 drivers/mtd/mtdoops.c | 61 +++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

