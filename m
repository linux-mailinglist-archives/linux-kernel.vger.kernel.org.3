Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D257520A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiGNPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiGNPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00EA328706
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpFwBg17MPLedEeXsKR0g11KSb+p+AI/SVxHMocug7Y=;
        b=im3+HXNiGhqsGk95vksTV3nLDDlrMfH7TZ4WYTU8TDxB58D3CW8NQuS2BPTI/OykRSNNic
        TwlQv288U+JCoqsTHG50e7QS5zy6x7FQNOAx4+lrkWCPvvvz17wBtVhnIl2cpUjq/yGdBQ
        1nEeTFAxoV2R0TY1zwnIIDob/dUmh0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-_YV2GfGVO_yHwy21RbcE5Q-1; Thu, 14 Jul 2022 11:39:40 -0400
X-MC-Unique: _YV2GfGVO_yHwy21RbcE5Q-1
Received: by mail-wm1-f71.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so899023wmp.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpFwBg17MPLedEeXsKR0g11KSb+p+AI/SVxHMocug7Y=;
        b=QBHceKDOXFU715s+Iz677PDkig61umlWQxxhm2rdMXVOg7VwOSFw+kiTBJwI8pAqgN
         IHbIG8cXSMYNiM2ZoP9nHwVcliWgWbbvLgsfoUUnE81SVW4egKK7WJ27KEDzscIJ2tOJ
         oY/IXhB2GXZhYc+Wvss0aJ0BSKaXqyrQ5Xjn+InVXn8rfxRyXZOAIo+fpDQuk09DB2nY
         k2q10VZuIzNDzfQmNJV5R6KDknGN6pYK74yu0CRSVQ14wGKZ2ienHATdvUZgarE01QVj
         jMoLdPnnl1866HKt+Lw6HPUJWmiOY+r+W4BB9U6ejnD9DdNFg5OcEsCeOQ3z9c3g/xwI
         /MdA==
X-Gm-Message-State: AJIora8cQkG8RPSAXUyitT5EnM3MZZKaUskFz6M/NqUDKTYp7XgSPiXZ
        SC5j6suCFkYyPiVwl9O8YiPTgzyINOb6aJQVjFw+cyCmP/PbCEtIAmfGKVsed6iGIl53WjGsMn2
        bbNahwGtuv4cGhRlYVzM/s8A=
X-Received: by 2002:adf:f746:0:b0:21d:6afd:b7d3 with SMTP id z6-20020adff746000000b0021d6afdb7d3mr8680745wrp.501.1657813179272;
        Thu, 14 Jul 2022 08:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5tKhmAkul9pcobJT+isErEbVQ/CkLfg6Gb+rF4t/kzbOpZtS1pgsyb94YxSH6cD9DrPkr8Q==
X-Received: by 2002:adf:f746:0:b0:21d:6afd:b7d3 with SMTP id z6-20020adff746000000b0021d6afdb7d3mr8680732wrp.501.1657813179045;
        Thu, 14 Jul 2022 08:39:39 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id w10-20020adfcd0a000000b0021d888e1132sm1729356wrm.43.2022.07.14.08.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:39:38 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, oleksandr@natalenko.name, neelx@redhat.com
Subject: [PATCH v2 2/3] module: Use strscpy() for last_unloaded_module
Date:   Thu, 14 Jul 2022 16:39:32 +0100
Message-Id: <20220714153933.2095776-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220714153933.2095776-1-atomlin@redhat.com>
References: <20220714153933.2095776-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of strlcpy() is considered deprecated [1].
In this particular context, there is no need to remain with strlcpy().
Therefore we transition to strscpy().

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4d23b0ebbc0..c5db13d06995 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -754,7 +754,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	async_synchronize_full();
 
 	/* Store the name of the last unloaded module for diagnostic purposes */
-	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
+	strscpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-- 
2.34.3

