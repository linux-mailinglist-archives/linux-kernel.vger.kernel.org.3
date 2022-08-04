Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E88589BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiHDMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbiHDMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:41:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EABC2AE3C;
        Thu,  4 Aug 2022 05:41:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f28so11000441pfk.1;
        Thu, 04 Aug 2022 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Jxp/ZZ2IP/r5wdh/E9VL2sjWN7cCRv4O2EVI3aFNd88=;
        b=mB1b1iZj1jk6+iE3H8+0/DIUxhsUtKMmi1cUlKktRqiKRdQl6wcVCaH0fxiKE5L1St
         Oo0ssMdoZK+r/XpROJQAL4ajPnwpPXVyS3osq1JaxsveNY7yOUdGfwwVcgyxRjB/7+rD
         TatDIZp8jwH4Q892sSBKqahFwQjQh0tcbDYNmkFOpnl+GyaYDpreX6AY0LN/kjjWFVOp
         KjALY8HLg1vivHOSjiIKxVIuoT/K5JZwwypcojJ/gbMP0ILl+YPZy1lNDvz2V6+ybajI
         5yjS77Vurc+ZDrE4mltLD27p3SSiNZrMPLy3NaQgwQ2c6Z6lz5tAfKQFxCDcvZoz+4o7
         K7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Jxp/ZZ2IP/r5wdh/E9VL2sjWN7cCRv4O2EVI3aFNd88=;
        b=h9zk69+U3nMJjofMCydSWGm8Rz295uBFKGmF7/Xzg68xyzzZ8PazD9dSuX90LlDcB4
         cuGlEHd9MgOsFOd95b+oUgnzOV6RUkq/6zX5RGeDi6yVxTn9hSmow+JrmYahFmVl+RLB
         iojKZLiDNSMk64m+ZDakltjeD8TYl7nzTFRNEC1uMIdmqZosY3jwT8OGoDYLlHllcT1Y
         ewTWyZqBr106JWZepoPp2iC8VRxzFB8NyEpjXfoF9wQJXJqrt4qzPhqxyjwUJWXtToxi
         vKET+dn91jqfgHV8zxyCWo9iL7ES9E0H99tYOVqVvfIZ3G/HmTIPIZbOy4m/uikVYi7h
         jlKQ==
X-Gm-Message-State: ACgBeo0eM7uUYGWwa4NCULvnMpRYCENGNMux2PPR1Wk7p2BlS4aN8YGO
        D2TPWvH/6Sa71ARNChIAe+6XEFEMJrpOWVA=
X-Google-Smtp-Source: AA6agR7OCkCZOlQGd61Gl4vRVugbgIJJG5uCOjm6CCDU2oMYjrbQ4/YazeoSktpsodzeVz9eh6wGsg==
X-Received: by 2002:a05:6a00:1c4b:b0:52e:6c05:8f1f with SMTP id s11-20020a056a001c4b00b0052e6c058f1fmr1746153pfw.7.1659616900533;
        Thu, 04 Aug 2022 05:41:40 -0700 (PDT)
Received: from localhost.localdomain ([166.111.133.51])
        by smtp.gmail.com with ESMTPSA id i8-20020a63bf48000000b0041b672e93c2sm1070769pgo.17.2022.08.04.05.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 05:41:40 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de, adaplas@gmail.com, santiago@crfreenet.org,
        akpm@linux-foundation.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 0/3] Fix bugs in *_set_par() caused by user input
Date:   Thu,  4 Aug 2022 20:41:22 +0800
Message-Id: <20220804124125.3506755-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function *_set_par(), the value of 'screen_size' is
calculated by the user input. If the user provides the improper value,
the value of 'screen_size' may larger than 'info->screen_size', which
may cause a bug in the memset_io().

Zheyu Ma (3):
  video: fbdev: vt8623fb: Check the size of screen before memset_io()
  video: fbdev: arkfb: Check the size of screen before memset_io()
  video: fbdev: s3fb: Check the size of screen before memset_io()

 drivers/video/fbdev/arkfb.c    | 2 ++
 drivers/video/fbdev/s3fb.c     | 2 ++
 drivers/video/fbdev/vt8623fb.c | 2 ++
 3 files changed, 6 insertions(+)

-- 
2.25.1

