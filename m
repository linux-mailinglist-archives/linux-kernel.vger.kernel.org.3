Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8E4E593B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiCWTi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiCWTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:38:26 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016E89081
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:36:55 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-d6ca46da48so2748141fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJcULk5LiW+3kxEVzLyONlp/nuGhdfaqTTO1jX0WkCk=;
        b=W5D5UxWRsbc76QXU5ey7JhklPtG6+jZiRambFD5I4EVkP38nmIGyajfP9joKJ9O1bb
         KmCUajik7Hfq3vtLrFYDiJErihrJt6BDk1JbQElF2hY1+qyxKT441A+ZhLcSTrs4EiJ4
         4/PGZuXnbDa4iVnb4tWMwvC/NwEtR/9I/qHVvmeR1J8eBC0b/INCrbsA2LnmRO345Mnz
         Fk9C4W/R7S30Xy/Q8UPNbemYLfd17NFmt9eTtTIYkA3taFApNQEZxIvqO+0cCahTHhVQ
         8+FZugyCc+NobgQxklPLw8DU9yHvkDMtpiYKIl5Fb5BeM1uS/7xd6i2iUZjyU1Hac0tF
         H1WA==
X-Gm-Message-State: AOAM530bPP0WsLRY+1gLxOKsLn4h7JFeDHd2a8NTcKhy/ajLZgNwn9sR
        ru4zNMjzmeJzxE21EkaOSg==
X-Google-Smtp-Source: ABdhPJybQLrgsU22ju31GlpjdDUcuI5dX6+x6Gg70dIeEulgxFLPP7zD2S5h3KDjGpOaYOjubW5Ekw==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id y1-20020a056870e3c100b000d72dc87fd0mr833609oad.104.1648064214655;
        Wed, 23 Mar 2022 12:36:54 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id x22-20020a4ad056000000b003248f5630dcsm393168oor.43.2022.03.23.12.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:36:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] get_maintainer: Honor mailmap for in file emails
Date:   Wed, 23 Mar 2022 14:36:45 -0500
Message-Id: <20220323193645.317514-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to also use the mailmap for 'in file' email addresses.

Reported-by: Marc Zyngier <maz@kernel.org>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6bd5221d37b8..ab123b498fd9 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -983,6 +983,7 @@ sub get_maintainers {
 	}
 
 	foreach my $email (@file_emails) {
+	    $email = mailmap_email($email);
 	    my ($name, $address) = parse_email($email);
 
 	    my $tmp_email = format_email($name, $address, $email_usename);
-- 
2.32.0

