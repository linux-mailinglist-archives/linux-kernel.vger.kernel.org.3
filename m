Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6A576B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 05:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiGPDoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiGPDok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 23:44:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD54D4E2;
        Fri, 15 Jul 2022 20:44:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso7802806pjh.1;
        Fri, 15 Jul 2022 20:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvhfMqDZx/5Jqi9/oIuh1bgwJC6dzv6oFttrqLY1GbQ=;
        b=nXobtFIIY5a/pltN9remCAJQhSvo2v5qbXrOryONiOZCrpvldhVl9SF1Zh8QUWLIwN
         JOvZlCA14GeahXFHiho+IfuUIfFBDmq6q2AUCrYj8N/J5BnRy9dT1YwxdaBO5BRbkyat
         Xm/2ZKVuklYdBxlggZAQvo72R80/qIQVEVfHXlR2PkR+asgc+69D7s8zuwpWEtxYTLz4
         ZybU+JKb6q8nUokT2mIo31Vz4Ee8kX/FbVoWkUMd3aq7Ovo8gKIoMLZ+OQm7XaC4FAj8
         ZBQqQBoSTO2VI2TJkohXjyx5vB0JXbHiRQqfCFC2K0GHYWTbIkZcy+SuTpttAXV0Xnc0
         H8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvhfMqDZx/5Jqi9/oIuh1bgwJC6dzv6oFttrqLY1GbQ=;
        b=HHPs4dIx1O8HAt+AsqYYBQ6rwjTbSZ/8R9CtwDzHHDnBhBTdKupTKqeqhGuJKOk0SB
         fez5C9EDwcQjZq8tb2SBzXTc+RSuta3zMCEGEp0vPijsH73hUjVGrxEiwOr1b9xQyF66
         FU94W5olGbcVPETj3TfNjvQMMOEVh2mlY39v5PUC4+8+zPNL+pBOJTZrMrl9AVdLjd7S
         ZWwYUytmNARNGTshELg48XKf45dt0YcPtlcMWFWuDNex94CJ0/6HymWmZ2YNahb3vRsg
         N1QnI/CqvZR/ztBO/FFNCZoryyUd4lKHCZQFg7mSBIJolyAzeP6ZIunLZH8GIpJy14VR
         xKxg==
X-Gm-Message-State: AJIora/g+u2Nzp5yx/es1I7NGyqVSoRwmkhRlsaUa4pcDprCLPzspe+B
        8j3tARM2dNwp/XaT4w9yBcA=
X-Google-Smtp-Source: AGRyM1uv/+MMvCaei6sHImm1N1dwo3ObgVHZ7/83WHrRaTIluY5X0aT278OgP4rMFykw2YZM4t18ZQ==
X-Received: by 2002:a17:902:e0d3:b0:16b:de4d:555b with SMTP id e19-20020a170902e0d300b0016bde4d555bmr17191377pla.79.1657943078966;
        Fri, 15 Jul 2022 20:44:38 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-53.three.co.id. [116.206.28.53])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090a2c0500b001ef8397571asm6422617pjd.35.2022.07.15.20.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 20:44:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D9F14103843; Sat, 16 Jul 2022 10:44:34 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: tdx: fix tainted kernels table
Date:   Sat, 16 Jul 2022 10:44:32 +0700
Message-Id: <20220716034432.207574-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <202207150911.eR0W0c9D-lkp@intel.com>
References: <202207150911.eR0W0c9D-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported htmldocs warning on guest-filter branch of
tdx tree:

Documentation/admin-guide/tainted-kernels.rst:82: WARNING: Malformed table.

The full warning is:

Documentation/admin-guide/tainted-kernels.rst:82: WARNING: Malformed table.
Bottom/header table border does not match top border.

===  ===  ======  ========================================================
Bit  Log  Number  Reason that got the kernel tainted
===  ===  ======  ========================================================
<content snipped>
===  ===  ======  =========================================================

Fix the warning by matching header border length with bottom border.

Link: https://lore.kernel.org/linux-doc/202207150911.eR0W0c9D-lkp@intel.com/
Fixes: 7acbe4e1dcfb9d ("Add taint flag for TDX overrides")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 tdx tree is at https://github.com/intel/tdx.git

 Documentation/admin-guide/tainted-kernels.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 65c58092ec354b..1146bce7e32e49 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -79,9 +79,9 @@ which bits are set::
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-===  ===  ======  ========================================================
+===  ===  ======  =========================================================
 Bit  Log  Number  Reason that got the kernel tainted
-===  ===  ======  ========================================================
+===  ===  ======  =========================================================
   0  G/P       1  proprietary module was loaded
   1  _/F       2  module was force loaded
   2  _/S       4  kernel running on an out of specification system

base-commit: 0a555e67b143701a81612d819e693cf5786de418
-- 
An old man doll... just what I always wanted! - Clara

