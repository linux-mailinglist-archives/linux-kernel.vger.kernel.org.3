Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688958331D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiG0TKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiG0TJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:09:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B27170E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:50:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f3959ba41so59519377b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BEk69dNG70BOHgb0SXLFWzzFpDyu+7tq1YolDhZdyzE=;
        b=B7uDYX/Cr97zFSRCvB7/fn1gKg5skiOo3orS627VXpMcYo8QEZ7oIrvYBjLdXKLvyw
         oxhx2F1iCRsyE1gIZ2hQTPsAZ46+3sYZ0ox/pMmaN1heCLPhTeZtrSP1HwOFBi+LY5w+
         O36Puictr1H9b2lkfo4jRR0Mo/xQr3nN7QsINYg+iKLGVrHaFtsRNdO2iKXWdHOJB+yI
         aOHHjRJdiN1hTtvuovOpKu1BWxPbokvLEXrXizIHGlzJb61Z0JET3FdTJLeRJ+YjUkgx
         ZtsTrJIP/RTGLKgls6kpdVgkFafVspj0h5Ad++NOeAflXkUYcUYlzfpi2vBLdxNvt1Jf
         7KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BEk69dNG70BOHgb0SXLFWzzFpDyu+7tq1YolDhZdyzE=;
        b=8JyMS7qvD5gY2Nho2LMFXlwsCS3U0YrtP0Rvs6DHj1x91O4KnW7xsa9sI936VbU/Ah
         8+FkZmO6ero9stH845F1lOnZNQ2wa4mwW1XteYYRFQbolOA44AuHi3JhuvHb72bCecCu
         rJY5nIr1/Ls2K6wkMJgOl+yU0x5qgxzdRr+K3i/syKqouoTW4C0jTcHWv3ete0OLqnYT
         PH5yjhij/RdAvzKd+9+VySbvFweC0rRcEBF6G+hTpx1JR3KzS/b+4oAoVy7kCJRx5EMJ
         CoozcznS7qudbT75O9N/MA1Oprqa0826vRCNFIhQXHW2i2+n8+h/3IoZaGfvxRdaj+Se
         Y3+g==
X-Gm-Message-State: AJIora+DDUqZ4XY9NS09dvOWL3Jb1Dy8tTI/tU3IOcNThWDUya8HHzDs
        zOYLIJv9fHwbG7g60gWIypOIPBqF9DK4mWU=
X-Google-Smtp-Source: AGRyM1vBbGCvhJnuNcqNxmyfgvBqU63X92ObJ+fmmE6nsBM1EgRJPhCmvWH4pzIt7pOBmOkC8sjtqMGkHE01FH0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:40ee:bae0:a4fd:c75b])
 (user=saravanak job=sendgmr) by 2002:a5b:502:0:b0:66e:206d:15f6 with SMTP id
 o2-20020a5b0502000000b0066e206d15f6mr18796823ybp.160.1658947826888; Wed, 27
 Jul 2022 11:50:26 -0700 (PDT)
Date:   Wed, 27 Jul 2022 11:50:11 -0700
In-Reply-To: <20220727185012.3255200-1-saravanak@google.com>
Message-Id: <20220727185012.3255200-4-saravanak@google.com>
Mime-Version: 1.0
References: <20220727185012.3255200-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 3/3] Revert "PM: domains: Delete usage of driver_deferred_probe_check_state()"
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Saravana Kannan <saravanak@google.com>, naresh.kamboju@linaro.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a.

There are a few more issues to fix that have been reported in the thread
for the original series [1]. We'll need to fix those before this will
work. So, revert it for now.

[1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3e86772d5fac..739e52cd4aba 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return -ENODEV;
+		return driver_deferred_probe_check_state(base_dev);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-- 
2.37.1.359.gd136c6c3e2-goog

