Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09847798F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbhLPQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:47:35 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44028
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232590AbhLPQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:47:34 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 665853F044
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639673253;
        bh=UJoL1Inyw8vu/KLNbBVbc+OxgIDQlc0M+xAVjgBLGQY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=awLkskXEYJwxNobBKbVfCvLmy3SUvIJybvaCyYBqqHOsWv2nZQhrygy95qPrJlzUj
         u7gmjpPdvOqBGtTJDUgI9OjUgmZovHf15QVZLfTra+8h8IJshnJciMvX5idWX/M1wk
         o4RDVee1gh5RJa2Qmkk3hTK6defRdIbtIzHoWoyoODbxSnq3VrD/nRC0ruI6eCudCq
         xzQEIUlCwzvtG4GhX15FmeiWvBtXXzI5Oo56Kk9onSQC8sEVhxkue9QeJFJq27RUw4
         tBKcMihcTP0om/56LaXAqpBvCQLhs+wg0BX77Tm7frb9w0QW8sOAthDSLvaHfvqDuA
         hLTF1fd0W/kPw==
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so1536262wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJoL1Inyw8vu/KLNbBVbc+OxgIDQlc0M+xAVjgBLGQY=;
        b=5YIOBwBwuqNzQioyTP8H7Dg7je4bbXeCzU6Hibbgy/1JnZ1pNWVqub5aCdbBY3rkWO
         Rfp1fWTnD5QIVIEz3+FWOF9ZMthDE8DK2ndNVYBkZ3glJAFgWUT0ZUWaOOn+OXbfxXEj
         blsgYWdlb3vUiPCeTg/ZAyTb+p751YnwWXUqt5ePvq3es/tv/fsR9leFRapniRrMN5fn
         lv45Ns2jIVSTM9+Nb2UgQj5IJlS9YOaKSNVaNBwl8RAPQgI3dF19wDx1mS9l9VSK/Iv4
         B2wzL9KThD/PrPI0gRjshsrFRpP/ji2P0Iq7Ssix0Mh7W1LjrCAKXWcoBlnw3lvIp3Bm
         aTKQ==
X-Gm-Message-State: AOAM531Oz/KbjU8rxfvpR9fOynAMUJWSItGGgl6C0CdTfmXXoqzARiJ6
        daba3VekegOgZMSYBHfzZgmixNmrfMFTln6Xnvx9M72yTk4/e/5kcY8ZsrZ5XDvSyTGSBJeQbbE
        Dg6i2/Sbx6yWUh5uDHzMJI98Cbbf6ggi+j7ThC7Ibdw==
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr5888866wms.186.1639673253057;
        Thu, 16 Dec 2021 08:47:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSS7rjab89jQAa03AtLuhGWfMnnTjqjL82jdXNrlyrN8nt24cOgkR/2XukFsqAxO08PB4brA==
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr5888850wms.186.1639673252902;
        Thu, 16 Dec 2021 08:47:32 -0800 (PST)
Received: from alex.home (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id t8sm5323151wrv.30.2021.12.16.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:47:32 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH] Documentation: bindings: Warn about yamllint and dt-schema before submitting patches
Date:   Thu, 16 Dec 2021 17:47:27 +0100
Message-Id: <20211216164727.2888916-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure people know that yamllint must be installed and dt-schema up
to date before they submit device tree bindings patches.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index 36a17b250ccc..3553e90bef5a 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -25,6 +25,10 @@ I. For patch submitters
 
        make dt_binding_check
 
+     Make sure yamllint is installed and dt-schema is up to date::
+
+       pip3 install dtschema --upgrade
+
      See Documentation/devicetree/bindings/writing-schema.rst for more details
      about schema and tools setup.
 
-- 
2.32.0

