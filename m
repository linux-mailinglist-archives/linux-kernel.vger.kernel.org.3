Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F7505CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbiDRQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346504AbiDRQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8390632EF2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+z2MPBv/e2lR6vUSjXOOBYhDsRJwrJcmF+Ul0MgCJ5c=;
        b=ga8y2jFbwYk4nPuX+BSdq1Fywn5256Jh4DZCvGpcW9jTAolAouBxtAXPymE9MjFLZaTGki
        hRGNyLGi1XgBSzuIeBwqHlEwcZKqFYTw+Y9M3vULoQrbHm3YbnKeacRi57zZvKIcXNjo+Z
        83uZcaBaTyNOiCuZqSBp++NL26e9iGk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-G33F1QaVNnCl9tLKisHn_A-1; Mon, 18 Apr 2022 12:51:06 -0400
X-MC-Unique: G33F1QaVNnCl9tLKisHn_A-1
Received: by mail-qk1-f199.google.com with SMTP id k15-20020a05620a142f00b0069ebc91caa2so452003qkj.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+z2MPBv/e2lR6vUSjXOOBYhDsRJwrJcmF+Ul0MgCJ5c=;
        b=y1m3LL7UZuthdoINHfhWBhPsCuRI/IL0zuzG2Nn2EVWBvzwTn6ooijERz0ZEhyvvTB
         WvCENuxJ2LCTTo7isIBK4ff+aGqquRAfX++hXcwER0iuNR15PmJAQaekuV4HX4e+Ip5w
         lKknKXRFk4qUTyBjCXAi81yYCP9ZbZ1slBF4Vo2icMNszuC1gTd22s6lSJX3y8DkwZAB
         nAd4NX9nLayNk+G3a1QW9v154NLQhsRMoyj5Yy/9+zKruu0CY1sp6NP7HJNQdvGpw03K
         JXV95LCjDzusqnd+sCplIDiSPqjtxVYN9woZ1V4b/VP9JZlJ14Iiz1A3ybYdn8AVgQbk
         JFeA==
X-Gm-Message-State: AOAM532zbsEB2kaY+/9nDMHkKH7zwZ6shYlC2bUqA3Xkjc7B0ApeT9dp
        EO2GONZulTIL8+7dHDIcPNm1P769MBmkozUp+kBvawrUM+rBDLGeWtMgKD6Zkqu0Sd3QFBwFzHG
        7TYUfRhXOUyvNHvQ16Wnm4cW2
X-Received: by 2002:ac8:59d4:0:b0:2e1:f86d:b38c with SMTP id f20-20020ac859d4000000b002e1f86db38cmr7769236qtf.285.1650300666141;
        Mon, 18 Apr 2022 09:51:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdVA7/K8OZ0nFQVm4BMkXURcMzdC3LqGe0snrLttVMZreeXixseyMcC6SBMVhvhwGWuymR+Q==
X-Received: by 2002:ac8:59d4:0:b0:2e1:f86d:b38c with SMTP id f20-20020ac859d4000000b002e1f86db38cmr7769224qtf.285.1650300665915;
        Mon, 18 Apr 2022 09:51:05 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:05 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 09/25] objtool: Don't print parentheses in function addresses
Date:   Mon, 18 Apr 2022 09:50:28 -0700
Message-Id: <f2bec70312f62ef4f1ea21c134d9def627182ad3.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parentheses in the "func()+off" address output are inconsistent with
how the kernel prints function addresses, breaking Peter's scripts.
Remove them.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/include/objtool/warn.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index 802cfda0a6f6..c4bde3e2a79c 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -33,11 +33,7 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	}
 
 	str = malloc(strlen(name) + 20);
-
-	if (func)
-		sprintf(str, "%s()+0x%lx", name, name_off);
-	else
-		sprintf(str, "%s+0x%lx", name, name_off);
+	sprintf(str, "%s+0x%lx", name, name_off);
 
 	return str;
 }
-- 
2.34.1

