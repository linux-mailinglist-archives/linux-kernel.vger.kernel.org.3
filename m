Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD6544D62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbiFINVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiFINVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:21:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9A2125E;
        Thu,  9 Jun 2022 06:21:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i15so3471957plr.1;
        Thu, 09 Jun 2022 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :subject:content-transfer-encoding;
        bh=rFaXek2NFszA7z8/5j/QiJWYFBDWni1TZzV01h7e2o4=;
        b=qeEbZYTwbjOcNmh18HdiG7WuRITTKr01mHLpq3REDCE07J7CR0KGGZ7jbTrLF1ZXg6
         xxVkDBVCJ154xAGhozCiQY+o0sSN2/tbL/lxceJgRv2tRW8dg7iDwxoM2DVkfsNPB5MX
         l25on4/LqLcSH5qvgQn33q5VQfgqF/ep9UNSss3+mzORvvDSmPb/IKt0QdGStLSmPBBH
         alIEFg5O5HNp4RIMxaX5M2xE8+FNWvOj7fsOyAvltav6aQHzcHk9yMqLmMcAwRjcoGdj
         KsR+x2ji/1npC2DdiZV10qEjumJ9m8io2BkYFxNqVuFLwAAI5vEwgTHsPKe8FLNIalIW
         6zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:subject:content-transfer-encoding;
        bh=rFaXek2NFszA7z8/5j/QiJWYFBDWni1TZzV01h7e2o4=;
        b=DYhCsWZol2NYvEyi2H20f6JbqR9VxgC77XdA0FqExGb1SZNdkZ4pr61Vwkf35YkaF0
         7heiZRIWf96hbEZmqdEuc+MkIyccMx1Kb02rwQsTM1ceeok0YYUdDTi6EOh4eFWv2sHc
         Sr7/w71p5E9f7fzWPxCzYtvmyXB33UO8lY2/KKQUY1gI6AASoQd9wcXHVuplwqZNenlr
         Hjm3GIHkuKn//caHQi6ubyP30LkSnvnIMvQkI8CtmedQcL5l/QAEn2M0EFA+KOuwXmQS
         /MWjQaQwBbwsDXFatx07HWp9gWdkamudkhTjxlDuC9dtHVhVtxVPBQG8sOzE4rL3388x
         uaog==
X-Gm-Message-State: AOAM532fdHLSJHe39Iid6WL8+xR3qB+1rJcRqDOyaCSgr8JGA/nHZEQv
        fDLFX7NvRBihTAm7kQ7zfqc=
X-Google-Smtp-Source: ABdhPJx5yb06Bu2N7ztWW8nQ5QKYoHUEycB1nH3sZlau3YSzdYoMb/98LtrJzuJlo3UPjulAWDgC6Q==
X-Received: by 2002:a17:902:9a4c:b0:156:6735:b438 with SMTP id x12-20020a1709029a4c00b001566735b438mr38950728plv.46.1654780908466;
        Thu, 09 Jun 2022 06:21:48 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b0050dc76281ecsm13889815pfh.198.2022.06.09.06.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:21:47 -0700 (PDT)
Message-ID: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
Date:   Thu, 9 Jun 2022 22:21:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/5] docs/doc-guide: Sphinx related updates
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This small set of patches fill in a couple of missing info and update
outdated guidelines in doc-guide/sphinx.rst.

Patch 1/5 adds a footnote on expected improvements of images embedded in
PDF documents by the support of Inkscape in kfigure.py added in v5.18.

Patch 2/5 mentions the make variable SPHINXDIRS, which is helpful in
test-building a subset of documents.  This change was inspired by
an earlier comment of Maciej.  He also suggested the update of
changes.rst to indicate the requirement of Sphinx 2.4 or later for
"make htmldocs", but changes.rst is not touched in this patch set
as there is an on-going discussion about updating minimal required
version of Sphinx [1].

[1]: "Sphinx pre v3 -- removing support"
     https://lore.kernel.org/linux-doc/LO3P123MB26810D190462B6BBBF1305F6C2A19@LO3P123MB2681.GBRP123.PROD.OUTLOOK.COM/

Patches 3/5 and 4/5 are RFCs.
The guidelines for title adornments were written well before the
transition to subdirectory based documentation.
Here, I'm suggesting a version of guidelines based on my personal
preference.  I am expecting at least a few comments from others
because I don't think there is any consensus on how far these
guidelines should be followed, especially for existing documents.
This update was inspired by private communication with Miguel and
Jon.

Patch 3/5 updates the guidelines for title adornments. The change is
done in-place for ease of review.

Patch 4/5 moves the item expanded by Patch 3/5 from the bullet lists
into its own subsection.

Patch 5/5 is a PoC of adding a meta title to kernel-doc.rst by using
the "title" directive mentioned in Patch 3/5.

Any feedback is welcome!

        Thanks, Akira
--
Akira Yokosawa (5):
  docs/doc-guide: Add footnote on Inkscape for better images in PDF
    documents
  docs/doc-guide: Mention make variable SPHINXDIRS
  docs/doc-guide: Update guidelines for title adornments
  docs/doc-guide: Pull guidelines for title adornments out into
    subsection
  docs/doc-guide: Put meta title for kernel-doc HTML page

 Documentation/doc-guide/kernel-doc.rst |  2 +
 Documentation/doc-guide/sphinx.rst     | 98 +++++++++++++++++++-------
 2 files changed, 76 insertions(+), 24 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.25.1

