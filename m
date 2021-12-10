Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A446FA57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 06:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhLJFb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 00:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhLJFb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 00:31:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3709C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 21:28:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so14723057ybd.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 21:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q/yA9sPgnWZ7PZbSTSePDzl+2+LX/jsSZ2aJXrNG7YE=;
        b=TyccKEm3KSuGGOeEFgiVhOkL1pOVjfDQvofDbMlnAnCOJdWaGXViu5kWfpDBQ24B9d
         8Jc0fNwAY2JZXQW4OFuZ8jhOT9IhQjzA58AGav3y1zAVzc7uJij8gkCcE3M1KgWLL/iH
         SZlOEokoqDmgIIUXFsuUGuCpjrCYJDGnT3oMajPp+/rrqP1dhSh1+04mP+wOtr6nMskU
         s0S2IMpf1Btxye0f3YN/cQEBHcahXE98NMUUgXppXRIwL6kWRkDXC+DLx358mTJhlcMk
         YPek4C5P5y2sU4A7uOBQgjn44DVnsXuQC1H/naiu2UtvY/ALgsdiwOwKvLF++27yoq5+
         hjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q/yA9sPgnWZ7PZbSTSePDzl+2+LX/jsSZ2aJXrNG7YE=;
        b=ePoWYPCKOrthQS53uoXRGcE4vpJmp0YZUe8Xck5+YN0nQau6Y4tC+znj7Ab7Tsedip
         Tymnl/34adxQUpKIAJ9aBIu6tYqu/iCoYSLbizX9pXmvK7Jq96/qexwaRJ5iGbrs+XCI
         ysd+177RJeoTWCKpWyD2KXv1TuW2fl3vEmcTtkERYjtL0wwRQPkkMUcAGu7w+obseOXq
         3CdFaAvjOkfidsxTyu4RtW9MPaLbp0Yi4+JHWpCvt6yYFkEEwTi5FjfS/8XpYtMIrRBy
         xftnjrQsb8mA6PAj7TGFBHneVe6PXLTmfKvFAcxt/mq6ebyjixERZeEik2ZUWFvCw1FX
         W8Cg==
X-Gm-Message-State: AOAM5300/xqVCYuGuOEOpz5rGVu4xOQX1mFZ6lAwU3H+a0O6ypc43hGS
        VkSq19bsudxAx/h7LgFwQiDy2O5/+PjvKio=
X-Google-Smtp-Source: ABdhPJzJHY6T8LWZYV4isxoZfxQaYtrnF/GAQA9UxnQcmeKS8QUcynJHtWWElWdJ+EnPcKpgh/pt1H1Wi+mmlMc=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:38f:: with SMTP id
 137mr12365855ybd.11.1639114102849; Thu, 09 Dec 2021 21:28:22 -0800 (PST)
Date:   Fri, 10 Dec 2021 05:28:05 +0000
Message-Id: <20211210052812.1998578-1-sharinder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 0/7] Documentation: KUnit: Rework KUnit documentation
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KUnit documentation was not very organized. There was little
information related to KUnit architecture and the importance of unit
testing.

Add some new pages, expand and reorganize the existing documentation.
Reword pages to make information and style more consistent.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211207054019.1455054-1-sharinder@google.com/T/

--Reworded sentences as per comments
--Expanded the explaination in usage.rst for accessing the current test example
--Standardized on US english in style.rst

Changes since v1:
https://lore.kernel.org/linux-kselftest/20211203042437.740255-1-sharinder@google.com/

--Fixed spelling mistakes
--Restored paragraph about kunit_tool introduction
--Added note about CONFIG_KUNIT_ALL_TESTS (Thanks Tim Bird for review
comments)
-- Miscellaneous changes

Harinder Singh (7):
  Documentation: KUnit: Rewrite main page
  Documentation: KUnit: Rewrite getting started
  Documentation: KUnit: Added KUnit Architecture
  Documentation: kunit: Reorganize documentation related to running
    tests
  Documentation: KUnit: Rework writing page to focus on writing tests
  Documentation: KUnit: Restyle Test Style and Nomenclature page
  Documentation: KUnit: Restyled Frequently Asked Questions

 .../dev-tools/kunit/architecture.rst          | 206 +++++++
 Documentation/dev-tools/kunit/faq.rst         |  73 ++-
 Documentation/dev-tools/kunit/index.rst       | 172 +++---
 .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
 Documentation/dev-tools/kunit/run_manual.rst  |  57 ++
 Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++
 Documentation/dev-tools/kunit/start.rst       | 198 +++---
 Documentation/dev-tools/kunit/style.rst       | 105 ++--
 Documentation/dev-tools/kunit/usage.rst       | 578 ++++++++----------
 9 files changed, 1049 insertions(+), 587 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.png
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst


base-commit: 4c388a8e740d3235a194f330c8ef327deef710f6
-- 
2.34.1.173.g76aa8bc2d0-goog

