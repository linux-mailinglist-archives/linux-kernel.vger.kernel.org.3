Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8974B8281
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiBPIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:03:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:03:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439E213913
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s129-20020a254587000000b00621cf68a92fso2687263yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Aj1+/jvhiBhQfXtmmF+ZYOOgdJDt/Hruc8PhsRcVwMY=;
        b=tY3DJSychOnSosHGJuYNVv6K/mGEB6lprRwn4sq/yn5KyYvZ6gOqFdtrG+Z4sS9eKf
         dXHWLvte9O6XJ8EBuML4TIE5wVWHQj22Q+aSFK8YAd/Cq+SUQBWSqL++i9DV0ziScRDs
         05c4WnMRtyZXppZw3+W03FFd8J73MNMSOQCO6OdKGS4cCj8rguhemCfCdFNqb+Ay3lAD
         wPE5GAqgyOqx3EJ+QN4vSzu+khLqtvMTLY2oPl79Srmh89sJravucyzUbm+2clYEFqfx
         yv6HqrgXe962bTLtY/aFlf1XDxnKWgqJpW5DLHHLQGMsknwr6iLSQUAYmiFCSk8z+xDU
         Cn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Aj1+/jvhiBhQfXtmmF+ZYOOgdJDt/Hruc8PhsRcVwMY=;
        b=uMvg0KWCNeHsFAX3T6YhR1YwX249msjlUu75/KHzjc6766NzymHLAdB9oyd+P/3uvm
         9qzuxvVMYKeQfh2k31C3aA/ZOSncohrgCrnggjJSloVwcQsu2lkX7ApMKxte00xQLWx6
         tcWsiRwLiyfFwFJ+fyzOd4mBlIkt8Bjt7oAyg0SOdB1ZYRlQMTPGtYacDnDHcIiTuM0Z
         hZHzgoxXsJ3naNh18AMAdxbh/a/iCK6xigNSNuNysqcDvHqIznyOe4ubYFWI1zkTbdW/
         vIecdO1JaQZ93Yifaiy+oWOGRnJQc0tFPRbugMkSLADYi/HzPP40ZWgeg2aZ2tIlz7wY
         oIkg==
X-Gm-Message-State: AOAM533gxS59flQIqbMIUwUCoXh+pPdjx9Rk+AbqwOH0x/3zE8vFP8vl
        hX32xjf6vom+7IVlsddtFeKPSg0MxaTB
X-Google-Smtp-Source: ABdhPJz+Bg5yo4/Ca6COUQ6m7qreuAPv5o5yIDK3crQbt3NO/hYBuNfsGQF3FW64XTflf/HlITUqanJi+XSA
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a25:ef47:0:b0:622:7be6:7a0 with SMTP id
 w7-20020a25ef47000000b006227be607a0mr1166508ybm.191.1644998598777; Wed, 16
 Feb 2022 00:03:18 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:03:01 +0800
Message-Id: <20220216080306.3864163-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v5 0/5] platform/chrome: cros_ec: miscellaneous cleanups
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, pmalani@chromium.org,
        tzungbi@google.com, linux-kernel@vger.kernel.org
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

The 1st patch fixes unhandled undos in error handling path.

The rest of patches cleans drivers/platform/chrome/cros_ec.c.

Changes from v4:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220216043639.3839185-1-tzungbi@google.com/)
- Rollback the 3rd patch to older version.

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220209095703.517608-1-tzungbi@google.com/)
- Drop "platform/chrome: cros_ec: don't initialize `err` in cros_ec_register()".
- Rename the 3rd patch's title.

Changes from v2:
(https://patchwork.kernel.org/project/chrome-platform/cover/20220209045035.380615-1-tzungbi@google.com/)
- Fix review comments in 1st and 2nd patch.

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit messages.
- Use IS_ERR_OR_NULL() in 1st patch.

Tzung-Bi Shih (5):
  platform/chrome: cros_ec: fix error handling in cros_ec_register()
  platform/chrome: cros_ec: remove unused variable `was_wake_device`
  platform/chrome: cros_ec: determine `wake_enabled` in
    cros_ec_suspend()
  platform/chrome: cros_ec: sort header inclusion alphabetically
  platform/chrome: cros_ec: append newline to all logs

 drivers/platform/chrome/cros_ec.c           | 36 ++++++++++++---------
 include/linux/platform_data/cros_ec_proto.h |  3 --
 2 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog

