Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589157DCED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiGVIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiGVIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F931DCA;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d7so4029039plr.9;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMLMbhzpQ8BYCKUc89U899ul04BiM4aI/9He03oT5uc=;
        b=duF24r2Mh/zRTYtQOAshatj9u415FRbTrhKlEf3cjpV57Heczae2zKForLZUgVcTIj
         ibUj2DTGe4mcVs5yOgqhngG7UJ4mKzxnEzebg6MChYG8DHwJtj2SE+pMyC9f+d2AKaxl
         yAXXf1jgaFSXRAVzm6KnetZlKLwPn0fvUcVbYgKsalOoKvVYi2/dpaOT8GWMLBvbuoAa
         IL7qRg7ghT5+z3OFTSXzs3i+Oq+3s8SMCR6c70kxPvNLlfC26d+jmpUuBREDvsHQMNRw
         p/0doIb4Z2iLKRfBiWQCnfITS6Hc4/kimbOb4IaWD84fCdzFFDwV7RH9XjrpI3LD+HAp
         1cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMLMbhzpQ8BYCKUc89U899ul04BiM4aI/9He03oT5uc=;
        b=zyUslw7Lc8Hm56nJ4q5r6mvhjMXTqcQyjZUeBc/BmI+/k3mJvosqFKfl7iewifOSBG
         eCysyUjfXhuQlHxta8bQJWWPFiHlhBmRygfn0lGZp5jBjo2TxBx/BmwnLTl/1Vl1xFxJ
         Zju1N5MC3sa7o1GCdbIp7M2EZ7mRIouPhQvwmA+kKo9yGdkVELN4P3qdR153ZklONPYc
         7QKkj2cnoMwvRxf5stEIosuwSQUzEBdtedUiBEN7Wo7hLponPQzugGzC9DwEWqATwZFe
         i3CZ4mp2DyrUpTvB5BWGP2k7CKQLgWD9Jgfmxq/hhFHDHhDsPhST0gj7ztFuVW0mG80N
         9RQA==
X-Gm-Message-State: AJIora+sDJ+PBwQ0vgE5YoMdg+bGHEehnIdV2uqweLuRHEMqpMH59jrG
        0oZyh0vLDR/PoWI33QIYrR8=
X-Google-Smtp-Source: AGRyM1ulLh5mC4aId6RvlA5MUpQyoZ+n5mnzh95GyZAc0cRin4lIZGT5yP5tox1MRsNbRAOatdEjyA==
X-Received: by 2002:a17:90a:9409:b0:1f0:e171:f2bd with SMTP id r9-20020a17090a940900b001f0e171f2bdmr2867699pjo.245.1658479833324;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id i7-20020a056a00224700b0051b8e7765edsm3227658pfu.67.2022.07.22.01.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CEAFC104986; Fri, 22 Jul 2022 15:50:23 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 8/8] Documentation: s390: add vfio-ap-locking documentation to table of contents index
Date:   Fri, 22 Jul 2022 15:49:47 +0700
Message-Id: <20220722084946.22965-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722084946.22965-1-bagasdotme@gmail.com>
References: <20220722084946.22965-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfio-ap-locking.rst documentation is missing from s390 index, so:

Documentation/s390/vfio-ap-locking.rst: WARNING: document isn't included in any toctree

Add missing documentation to the index.

Link: https://lore.kernel.org/linux-next/20220721201058.2a276286@canb.auug.org.au/
Fixes: e32d3827f3d5b2 ("s390/Docs: new doc describing lock usage by the vfio_ap device driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/s390/index.rst b/Documentation/s390/index.rst
index b10ca919255738..73c79bf586fd60 100644
--- a/Documentation/s390/index.rst
+++ b/Documentation/s390/index.rst
@@ -12,6 +12,7 @@ s390 Architecture
     qeth
     s390dbf
     vfio-ap
+    vfio-ap-locking
     vfio-ccw
     zfcpdump
     common_io
-- 
An old man doll... just what I always wanted! - Clara

