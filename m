Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2250C9A4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiDWLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiDWLli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:41:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3821A1BBFAF;
        Sat, 23 Apr 2022 04:38:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q185so3304607ljb.5;
        Sat, 23 Apr 2022 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QY0mU5IQPj8GUMEzISz7+Bwc6i+ATuzEN8MJe22534Q=;
        b=OJaPQBzpJJf272sB2uLtTOPemnNlOXU6YeasEZvihIG1rPvnz3sH+b9StAe+NSxYEC
         0sx3HSg6Rr5+DFTPpqe6oc5cCMZNCQTrFWRhZV9tlBXXcmcA16V0c5Z6V5fDYsKk6b55
         zhXYFYUJnBsiIVEpjK0tChNiDy13HXcsbJm81ffByrGzYxTQIlBzSYWVbxhvhlkclwtD
         u+QsazlgFIaGx7RhWNe2Do9yj5+zoQbs129/65wkiwkXqQMX+QTXFZ4fiOoRUuPr6uPt
         L+1c38G8j5vo3MpRN7JF+8XW/kjGwysK3y9puLcJqAH2+mDrVoMQsPzuGpSiuQJ0m5tm
         68eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QY0mU5IQPj8GUMEzISz7+Bwc6i+ATuzEN8MJe22534Q=;
        b=c60xljU3NGcwQHE3Wmp/VDMwNEtGnJdHEe5Kd3xQcPu8Iqtx9sgFcNnK448nTP5k4s
         JxXYYDYm4wZCu6R5g284g6UH628IYII1g8D7lThQBvbYNUBzOyK161LD/d2SRZ9KTL+C
         GgMXIn+neGGxXzT9HhDUgfZPgzW24VUmpnwjm+IWLvMGyWn38PFwXrGCwx2zGnirYwsn
         Ay5c7m0jV/U0eYHBVzxhb+URP3A9JYYBmtNY0BU+qlIczJxkn31O0rwTMTdBhcJBVRYX
         bBO+B5Er0xXHTxkTCjIJPShoE2zQnxDNPs8/2xDsj8ugEqUXkljaOMAfR1gB/o0EHpZb
         JgtQ==
X-Gm-Message-State: AOAM532dJo8h+IdT35h37CEQymx6WoWvuWym2VkhpEB8tLeYZGNq+95P
        L0suLR0wh2fKs8q9+acw0GA=
X-Google-Smtp-Source: ABdhPJzkPXL24FJCVC+QG+e6xitqgwC/AInXdEr713qRfRkeELiYX7ajov9hzfkCPLUx/YjM2pjsMw==
X-Received: by 2002:a05:651c:210f:b0:24e:ec3d:6b8c with SMTP id a15-20020a05651c210f00b0024eec3d6b8cmr5443531ljq.321.1650713920541;
        Sat, 23 Apr 2022 04:38:40 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id g17-20020a2e9cd1000000b0024db538c2absm526411ljj.7.2022.04.23.04.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:38:40 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH RESEND v2 5/5] block/partitions/ldm: Remove redundant assignments
Date:   Sat, 23 Apr 2022 13:38:11 +0200
Message-Id: <20220423113811.13335-5-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423113811.13335-1-michalorzel.eng@gmail.com>
References: <20220423113811.13335-1-michalorzel.eng@gmail.com>
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

Get rid of the following redundant assignments:
- to a variable r_cols from function ldm_parse_cmp3
- to variables r_id1 and r_id2 from functions ldm_parse_dgr3 and ldm_parse_dgr4
- to a variable r_index from function ldm_parse_prt3
that end up in values not being read until the end of function.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 block/partitions/ldm.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 27f6c7d9c776..38e58960ae03 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -736,7 +736,6 @@ static bool ldm_parse_cmp3 (const u8 *buffer, int buflen, struct vblk *vb)
 		len = r_cols;
 	} else {
 		r_stripe = 0;
-		r_cols   = 0;
 		len = r_parent;
 	}
 	if (len < 0)
@@ -783,11 +782,8 @@ static int ldm_parse_dgr3 (const u8 *buffer, int buflen, struct vblk *vb)
 		r_id1 = ldm_relative (buffer, buflen, 0x24, r_diskid);
 		r_id2 = ldm_relative (buffer, buflen, 0x24, r_id1);
 		len = r_id2;
-	} else {
-		r_id1 = 0;
-		r_id2 = 0;
+	} else
 		len = r_diskid;
-	}
 	if (len < 0)
 		return false;
 
@@ -826,11 +822,8 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 		r_id1 = ldm_relative (buffer, buflen, 0x44, r_name);
 		r_id2 = ldm_relative (buffer, buflen, 0x44, r_id1);
 		len = r_id2;
-	} else {
-		r_id1 = 0;
-		r_id2 = 0;
+	} else
 		len = r_name;
-	}
 	if (len < 0)
 		return false;
 
@@ -963,10 +956,8 @@ static bool ldm_parse_prt3(const u8 *buffer, int buflen, struct vblk *vb)
 			return false;
 		}
 		len = r_index;
-	} else {
-		r_index = 0;
+	} else
 		len = r_diskid;
-	}
 	if (len < 0) {
 		ldm_error("len %d < 0", len);
 		return false;
-- 
2.25.1

