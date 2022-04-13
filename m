Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AFE50028F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbiDMXXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbiDMXW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3822323BE5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHuuVJWlvrxXx0mO6xbXx/8ozzJANVHdMftQcW5g5Us=;
        b=gmab3WDNDduWfRfR2dVDOXgpmATKzm6yEuTmaR87h6OUk+AUvcYkPJvfpfAbC0UPSbxi68
        8vpzn9C8HEohf3KyDuQ9tY2BZeVhkT/4TNujqQuAcxLbTgHlYulejr0kn7Rhzy+7HbrP/o
        EWeAQnSbGT/tYUJugUMKBKIkYd9PZKA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-XAXNL7tBOO2xxW2qSFGheQ-1; Wed, 13 Apr 2022 19:20:04 -0400
X-MC-Unique: XAXNL7tBOO2xxW2qSFGheQ-1
Received: by mail-qt1-f197.google.com with SMTP id z3-20020ac86b83000000b002ed0f18c23cso2214517qts.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHuuVJWlvrxXx0mO6xbXx/8ozzJANVHdMftQcW5g5Us=;
        b=n8ixq/By2sHIJYv4qKop9f9F1YXpmDqMqtGqeDf1zRprAQS5rMWfgI4wYrDzhhF0vd
         fPOwHmeLQHPEH/RAb9Px2i4IrO3sZHDL1rimEH/YTfCvVgrJz34mtqCLEdtEo6E+FjJJ
         5Xw5Qzuk1BTGHKFgjRcLih1bsXtKEL2T0sNoGw930ECqpSdB8d+kHS4Gk3eaNIpEmFui
         c54db2gwtoZE+YauE1KJv+grdCphaV5Zbnr6+s80FfKcJNE7jzSCdwEuwn64/MMlpn6B
         g3M7w+xjDeh0DfSLuEhc+eIUCZ8SLhKKQlGi05nhtfoOzdcu4UJc7IggpJ48yiNEE/pi
         Q5Ag==
X-Gm-Message-State: AOAM532Pf/4aXx+bswg3LYo+B8VsyGcB0D3U5bSkKDQS5Gcdxvf40Ryk
        EVhv/WTZ8d47BMCr8ckLJcrlzDvaPTm6blNZf+78O8tqSuXab870xFFKi9fKKgYGNWzVmqgtgWa
        hXRhNtSt+RcI1o2nRZ31mSzCE
X-Received: by 2002:a05:6214:300d:b0:444:4ada:a471 with SMTP id ke13-20020a056214300d00b004444adaa471mr1037216qvb.93.1649892003431;
        Wed, 13 Apr 2022 16:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWFG0Q4OCZ9/S2OUyvhDtsAEUq0kQxxzhgvu7klVXQ4+McpzuRKD53TLydwbrR+krLLHmBPQ==
X-Received: by 2002:a05:6214:300d:b0:444:4ada:a471 with SMTP id ke13-20020a056214300d00b004444adaa471mr1037201qvb.93.1649892003185;
        Wed, 13 Apr 2022 16:20:03 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:02 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 04/18] objtool: Print data address for "!ENDBR" data warnings
Date:   Wed, 13 Apr 2022 16:19:39 -0700
Message-Id: <8208fa7edf2dc576e8f9bcf24396b128f59bdfe9.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a "!ENDBR" warning is reported for a data section, objtool just
prints the text address of the relocation target twice, without giving
any clues about the location of the original data reference:

  vmlinux.o: warning: objtool: dcbnl_netdevice_event()+0x0: .text+0xb64680: data relocation to !ENDBR: dcbnl_netdevice_event+0x0

Instead, print the address of the data reference, in addition to the
address of the relocation target.

  vmlinux.o: warning: objtool: dcbnl_nb+0x0: .data..read_mostly+0xe260: data relocation to !ENDBR: dcbnl_netdevice_event+0x0

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5bd3aa815d51..7a1a02dacb77 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3825,11 +3825,8 @@ static int validate_ibt(struct objtool_file *file)
 			struct instruction *dest;
 
 			dest = validate_ibt_reloc(file, reloc);
-			if (is_data && dest && !dest->noendbr) {
-				warn_noendbr("data ", reloc->sym->sec,
-					     reloc->sym->offset + reloc->addend,
-					     dest);
-			}
+			if (is_data && dest && !dest->noendbr)
+				warn_noendbr("data ", sec, reloc->offset, dest);
 		}
 	}
 
-- 
2.34.1

