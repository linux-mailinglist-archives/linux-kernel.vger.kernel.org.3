Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE11555A648
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 04:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiFYC46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 22:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiFYC44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 22:56:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6139F6272B;
        Fri, 24 Jun 2022 19:56:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jh14so3607680plb.1;
        Fri, 24 Jun 2022 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XrHry2tVpuFuNSwZ2Xy9FV9yIAwv3acwrvzWi2okQBM=;
        b=FCal6iW29d8jiQ4pEEYX8qlWdSJcOt2SNzkRN7kihICGW67MHbq1EPFx5J/XSzZNkI
         IhIdzvSk0bSc7Hfw+GSIiwSXhrTRJIIICczcPmsTGjQfEBmvXGnF3G3LnpzsIu8E41+G
         bJm3l1fAbIZwn6kzMjBAwiRggHWRcn2Ho+vWwTvNr8M6xMJ8GQWeIWPdJrZWUaLySuzt
         4oxmrAPTI3Z3GFRlFEZ+BnmdsdrCCPlw878yhY/+vQqVvTZxIViJNZ+acbZkMEo8FIq5
         JSWagjL196TJ3Rpj5kre7TQVne/2fR/egLyz7nAtX5DgUJSl3tvA2NpwEKZonmNltKBg
         I76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XrHry2tVpuFuNSwZ2Xy9FV9yIAwv3acwrvzWi2okQBM=;
        b=ipqH3UMcOpshPn3Zf0d3MpM/OpLjGhSPpHHBFcRmEXcavhCTdFLc9Dku7QbIpYjYmi
         DiPluXdWRuDsejpenjrB/eSsMSWdQCkrQjmX3b0uLBocbeeU86KpvkVpsm8KnTuAsk/f
         AddsU73cwBgVJTOdiLr97hQeiRpiiDQAFhwI/ESCOlRck7g7gqsaX/43LiiTLefATIsW
         5XZnce+z3BeSLsauzo90x9949ra8aUl/R/juwaXnYJtMg7SGskHarNxXvG+XBIE8VgXD
         fHsEtD7HPXuJIRHNga6aQE4JgTRIbkFsA9eKvyCzuRXklBWikeltsq/r8WMTyelzkVdH
         DqDw==
X-Gm-Message-State: AJIora9Ms/nZky6hntHh2WKFdVCvg+mUEBDQ8xaV6YU0uTueazlfEfSD
        E6cbE513hIyvJ9OiDp13gjQ=
X-Google-Smtp-Source: AGRyM1s9ICY6Rpgwmd1gvgJy/9te4ufge0tT3h6IxEBEylTleBaCbkM2BilF0B274hqnppKTV8I6vQ==
X-Received: by 2002:a17:903:1210:b0:168:dc70:e9d8 with SMTP id l16-20020a170903121000b00168dc70e9d8mr2279502plh.92.1656125813852;
        Fri, 24 Jun 2022 19:56:53 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-71.three.co.id. [180.214.233.71])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902bd8e00b001677fa34a07sm2508948pls.43.2022.06.24.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 19:56:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5126A102D21; Sat, 25 Jun 2022 09:56:49 +0700 (WIB)
Date:   Sat, 25 Jun 2022 09:56:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        kbuild-all@lists.01.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 11/12] mm/demotion: Add documentation for memory
 tiering
Message-ID: <YrZ5cTFOSuWxlF2t@debian.me>
References: <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
 <202206230554.5tVWF6UB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202206230554.5tVWF6UB-lkp@intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:21:17AM +0800, kernel test robot wrote:
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> Documentation/admin-guide/mm/memory-tiering.rst:5: (SEVERE/4) Title overline & underline mismatch.
> 
> vim +5 Documentation/admin-guide/mm/memory-tiering.rst
> 
>      4	
>    > 5	===========
>      6	Memory tiers
>      7	============
>      8	
> 

Here is the fixup. Thanks.

---- >8 ----

From ee8b97451b6ad1869f4d426e2d3825ac20a6e15d Mon Sep 17 00:00:00 2001
From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Sat, 25 Jun 2022 09:48:28 +0700
Subject: [PATCH] fixup for "mm/demotion: Add documentation for memory tiering"

Extend the title heading overline by one (=) to match the underline.

Fixes: 64fc925cf27dac ("mm/demotion: Add documentation for memory tiering")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/mm/memory-tiering.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/memory-tiering.rst b/Documentation/admin-guide/mm/memory-tiering.rst
index 142c36651f5dd2..0a75e0dab1fd8e 100644
--- a/Documentation/admin-guide/mm/memory-tiering.rst
+++ b/Documentation/admin-guide/mm/memory-tiering.rst
@@ -2,7 +2,7 @@
 
 .. _admin_guide_memory_tiering:
 
-===========
+============
 Memory tiers
 ============
 
-- 
An old man doll... just what I always wanted! - Clara
