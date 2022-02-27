Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7624C58F9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 03:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiB0CXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 21:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiB0CXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 21:23:34 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B105AF0D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 18:22:58 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id c7so7795544qka.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 18:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=1vfHk8IgXV9x509jvY8zplci3eeq7Q2rCPdWsLWLaHw=;
        b=ITJX+LIycQvk7DRc7SzlB5nlr7w9MDymPNVLBONq1Eqnxgho/XvwLuTjl1fsyU8hc3
         qxgWWdoQF6wdw0WNHfNLKJLk0xPd7APFoHx28rXARWrZ5/4VGU//GvlObRAPWGbSZKyd
         ue7dN8F5uV8XYOVGRKbWLLCJZ2q2QL8rWNURqceRWS8fFyJj8VbyDTLvxR1psjjOLL9r
         gpYekmdc71U9RdenOd56OPTYbYQO7lQnTwjIAsKxE+1NVHxwCGDYXHNz5jI6Au1SMwhr
         18YRLjJADJBJK8XhoICZona/j4zG6vR2je+SqO5jxiu+3majTk1VIc6S+ISD726vcbSe
         NkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=1vfHk8IgXV9x509jvY8zplci3eeq7Q2rCPdWsLWLaHw=;
        b=6uMyn0iDE8PXB6QD5xlzAy9Tx+eFlyOlYXE2rq6Xpspu+rkVZOqvneuI1tgBJBUqLc
         ci+YMZ71Wffx4fYNE5D5wdRDBPMFhrI2lgwmItmQLUWKXLGxyRraUqj5WVdiaMeBlvCX
         0LsVsPOUxd3l+Y6EsBZ66Dgv1v1JPgZj+8tOAyPkOKUotYQFaXOH71lETONKcpx+GHBI
         +7gpT9MqMkgjT3oRNyo602gS46rQFhp45duf2REoAOw7rEJc4OAkK/+YEKyyPFCFMw1f
         lr3ThKCIfND0F+0kjKUFrFBWk56IuaZSCXftT8c79DT+CPuKgkii19KMN4TUZXuy2Pwt
         tgsg==
X-Gm-Message-State: AOAM5311mTjLcFs/ajReWpYKTRislcfsGY4GIuKRDpPaplVSdNm+nJLN
        PhaIFMcFCHP8YML8XCWEgcMZtA==
X-Google-Smtp-Source: ABdhPJyeIm/PJhfj4Nk1Rv28GEm1yghQiGSJlYeDyQRtEgC4yNHFLSURoiA668n2vBiwr0kv06pmGw==
X-Received: by 2002:a37:a88f:0:b0:47e:1590:d7e9 with SMTP id r137-20020a37a88f000000b0047e1590d7e9mr8558916qke.733.1645928577318;
        Sat, 26 Feb 2022 18:22:57 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f1-20020a37ad01000000b0064919f4b37csm3140532qkm.75.2022.02.26.18.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 18:22:56 -0800 (PST)
Date:   Sat, 26 Feb 2022 18:22:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next] mm/thp: fix collapse_file()'s try_to_unmap(folio,)
Message-ID: <3f187b6c-e5e8-e66d-e0c0-7455ca6abb4c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The foliation of THP collapse_file()'s call to try_to_unmap() is
currently wrong, crashing on a test in rmap_walk() when xas_next()
delivered a value (after which page has been loaded independently).

Fixes: c3b522d9a698 ("mm/rmap: Convert try_to_unmap() to take a folio")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
Please just fold in if you agree.

 mm/khugepaged.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- mmotm/mm/khugepaged.c
+++ linux/mm/khugepaged.c
@@ -1824,7 +1824,8 @@ static void collapse_file(struct mm_stru
 		}
 
 		if (page_mapped(page))
-			try_to_unmap(folio, TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
+			try_to_unmap(page_folio(page),
+				     TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
 
 		xas_lock_irq(&xas);
 		xas_set(&xas, index);
