Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA858F72D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 07:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiHKFGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 01:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHKFGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:06:36 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD6D74E3E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:06:35 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id bb16so20152502oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc;
        bh=quvX6z6poO5keYLoKw9+FS7nc7zJzPFptxa1p4PFcJI=;
        b=J3VozWdW72TUWrtZoiUsG9StCKcnf3uW3XgsbLoxPrWFIqWUQK1L8X+mKwlM3iMSmX
         eHaVVoo9rEGnZxajxECSwZac/cp2LkMEtWqkLG9YCU1SwYJaPstqdSn+oz9voOzxl2gR
         56h/i17y0CoEZp/rX4i7/fi8kuIr7TTWjf9onouPzPTWKYVP01RmW/JNwIHL84j9qiTe
         H8sYzYI5Pf9wSSYlvoNq9fu7erTXBcfKN+JEmJ0z0CekMa5YBYweigdWcaLIhXQouxWq
         hv0BCzaFJh1mxy9mgv41kiAoTaty0KKWgRLKXf6A9nrG0lR178D/5lC6Gl0O9bR+OBgZ
         jjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=quvX6z6poO5keYLoKw9+FS7nc7zJzPFptxa1p4PFcJI=;
        b=5zN0JxSEi6lYszbk4LD+VgTF5M+wwguSN1V0dvBDCImNQwd5AQ+w239NqA2mxLDtbD
         4+F/gilzmn4gCien8DkUVgOCNkEsl5qoEJzAf7x8bZdnXtFMPHfY4+KPx57djWF3WRS7
         mXM45EY93L1Gku1BR9/ma/yU6fe+b9Y4MRLP3sk5Yq9LXxiAKyc0P922KQk6CGHFcgJ6
         ITPbHvmn1jeeTRm6JeqhYUIpttvab4j/TfwSk4UQCGiDKzA61EwDfuxq7cKw6yWoueNS
         qsUFlpcxgAIQoReTnNOA5T/xR23mKxib4pvM8mztXLTNDNLOQ9RM7IFkBa67IXwv+2mq
         TIIQ==
X-Gm-Message-State: ACgBeo3ETvesa28dqcNGhYfRB7oD1p4Z0i2pUoaz235/JaFiJHx9ZwsC
        kSzs86iGXqynCA+PSR+G7A0fnQ==
X-Google-Smtp-Source: AA6agR4zrYfHGR/cCGz5xRQTkDcDxPPuB6aVkKAnB3WW6LfbavZT3ojs25742RS1BdfGRBX23XKgEA==
X-Received: by 2002:a05:6808:1598:b0:342:d044:2afc with SMTP id t24-20020a056808159800b00342d0442afcmr2857509oiw.235.1660194394565;
        Wed, 10 Aug 2022 22:06:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id eh23-20020a056870f59700b0010d910ffc3asm4134807oab.18.2022.08.10.22.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 22:06:34 -0700 (PDT)
Date:   Wed, 10 Aug 2022 22:06:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/shmem: shmem_replace_page() remember NR_SHMEM
Message-ID: <cec7c09d-5874-e160-ada6-6e10ee48784@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elsewhere, NR_SHMEM is updated at the same time as shmem NR_FILE_PAGES;
but shmem_replace_page() was forgetting to do that - so NR_SHMEM stats
could grow too big or too small, in those unusual cases when it's used.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
This is not terribly important, and will clash with one of Matthew's
59 for 5.21; I don't mind if this gets delayed, and we just do it again
on top of his series later, or he fold the equivalent into his series;
but thought I'd better send it in as another fix to shmem_replace_page()
while that function is on our minds.

 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1659,7 +1659,9 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 		new = page_folio(newpage);
 		mem_cgroup_migrate(old, new);
 		__inc_lruvec_page_state(newpage, NR_FILE_PAGES);
+		__inc_lruvec_page_state(newpage, NR_SHMEM);
 		__dec_lruvec_page_state(oldpage, NR_FILE_PAGES);
+		__dec_lruvec_page_state(oldpage, NR_SHMEM);
 	}
 	xa_unlock_irq(&swap_mapping->i_pages);
 
