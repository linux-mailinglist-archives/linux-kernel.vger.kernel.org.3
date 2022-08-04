Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A788F5898D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiHDHz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbiHDHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:55:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B1D8C;
        Thu,  4 Aug 2022 00:55:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d7so14222195pgc.13;
        Thu, 04 Aug 2022 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ZFLXh3fG62E+CLRdqLUZ24JGtiFtJexbAFcrINgnwzk=;
        b=Z/j2k4pBhCyfV4j1aJyJQx4WSnesszf8/8SrUNW21t0SmxC1okQppLEDNM10Kekwmy
         T2v4F+MZMsu8irGA1i9JxpjvhXDVeA89UW9BA4lrNfYBE+/t93WxMPJFIMLQyGucjFhc
         EVr7jnggbWqPjiLLEHrbByl16xQMDYZrC3JHmilcwd3VDoMRNsZKgaH11oD98ISxxcTi
         L7XYcPd/PN5dGD49x0FiMY9me/xJSCoJH8mZkN1pyrUo9ayVTO6tSgdm4XDMJFMTuUzU
         DJ7tHWkJPgIFUg4zQAll7OIrnsiyF2pr2ZHbbFj2M/f3qiXpMTqp9vrBLjQaKIN/no9S
         Yftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZFLXh3fG62E+CLRdqLUZ24JGtiFtJexbAFcrINgnwzk=;
        b=DVpCspepsR8ynykZ3tuwszmSspAGtXalmM7zYXk4ZxUNNqJVKLH38baC/kMuI+Gr5s
         I96++rpamWzZR4Ld5a88UyB//nbmXUfMtBXZjgJ0AIK6C6YjGW+jlG3Ffqdq2I1sQjUr
         YZumrU0ehiNop8fvEZ7ny/Gz+ETFekKosqFq/gT+s9mTep4tXCEKBNpUlulG4eJO+D0R
         QctA1ZRqBNxtlcwgpcDfZfTjFTYTk8puSLQ/fnWcGOC9H0imS9AWAu9qkU9dSYOLqNIW
         OImfS/GY6pfibIND6b6Dpy6yM4/pwreGJniP5cdjuDqFnBcMx20NpxJjGBmSex+t5+gm
         90Vw==
X-Gm-Message-State: ACgBeo1ZIC/bNwOjSJvJmftFPjkhYbJ3aY3gq2wFmIFtqEdBZVB3q7OD
        j0v9VGrTigwQNb2jishQuCMhvJfIeN0=
X-Google-Smtp-Source: AA6agR6wzukDh8n5t1Y10VkbQj9hQqULckqKahs8HS9Rh99K054fCDpSd5knlPRXq/FNi8d/RnLUAQ==
X-Received: by 2002:a05:6a00:2195:b0:52e:6157:904d with SMTP id h21-20020a056a00219500b0052e6157904dmr589378pfi.44.1659599711275;
        Thu, 04 Aug 2022 00:55:11 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709026b0800b0016e2309bcf1sm241283plk.13.2022.08.04.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:55:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CED22103D0C; Thu,  4 Aug 2022 14:55:05 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-next@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] cxl: documentation fixes
Date:   Thu,  4 Aug 2022 14:54:45 +0700
Message-Id: <20220804075448.98241-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=721; i=bagasdotme@gmail.com; h=from:subject; bh=GlMFLz86VtutALNPrJ7nA6IEemU3GyrcRO3h2aef9R8=; b=owGbwMvMwCn83935mHOB8QHG02pJDEmvq93fPp41XcJU8Uqom85y455+ppd7hKecmdH57Xay8/+S 1mKljqksDMKcDLJiiixvKneLcXxYebQ/+HsmzBxWJpAhDFycAjCRDxyMDaeqPnpM6T3p+aTMbtLxzP XR7337Qh5zb5R+3JZw4HZqn+Zyrbaih+Y8hmwFbBar7Q7oMdYpm2f5ebHutpiyMk+8XyRk3zSWCbcX fVz+5Y3PW+VJuRImXlviPh6csfz204601Sy29eEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=EC79BB1608F0A9C58F53F769FF4743C6437033C0
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

Building htmldocs on next-20220803 (for which this series is based on),
there are new warnings on cxl subsystem. The fixes below are
self-explanatory.

Bagas Sanjaya (3):
  cxl/regions: add padding for cxl_rr_ep_add nested lists
  cxl/region: describe targets and nr_targets members of
    cxl_region_params
  Documentation: cxl: remove dangling kernel-doc reference

 Documentation/driver-api/cxl/memory-devices.rst | 3 ---
 drivers/cxl/core/region.c                       | 3 +++
 drivers/cxl/cxl.h                               | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)


base-commit: 861397378de91c64dec69a160595b891f443294f
-- 
An old man doll... just what I always wanted! - Clara

