Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D853530057
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 04:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiEVCxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 22:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiEVCxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 22:53:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F63F308
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 19:53:08 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id s23-20020a9d7597000000b0060ae566f9a1so5350196otk.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 19:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=v1DAiFT2xmj9A/ks1haZtydUQ187WcFyouSbatKulP8=;
        b=d3eGHwfEmP1AiPm26xG/Rv8vyfZDXL8vNOK8N7oRyC60AcCO/0LmcAWsGMGKEiWVoE
         RPdu2qCj8qkfrnfPC5DWsFSK2hNczcMiEqv2gwENlDhlc78IfgxBVkR9xcm2CrVHpQCx
         KmRc7AYe8E5I2NG4Ozdl1s9A6J+d8X/jOv15oLYHPW4k+3SfakJcLvSU8/cSf0DebH8C
         9ZtT7p9mH3y6IZ9BLa+p+cLmrG5tuhXY9X2D0+dQ6RnaBPOcA8Rwmhhn7/Jbx6mLwAQb
         ND8Pk7QjfX/atfPFwc6XrB1YD9r1y23LZVZmVFjp7K+6/pcRZCM4DasyX/CjHC4yPGj4
         MB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=v1DAiFT2xmj9A/ks1haZtydUQ187WcFyouSbatKulP8=;
        b=UIAeXwjWOvHRhY/RkhojFwCkMVZKu4I0MyqSZJqvApVx+ArHqMvE/f/0sa9HPIrcUJ
         k23uJ4efpSU045nXMR+9tg8gqZcIK/rX89D0BkBT2qhmZj3Mx2i2etE0JLb+YwkkZ89m
         mpTmQMqLWC5m+yv+xlYtBTKe/Z/2hDzn358kLsl/0jnBvX3R7xeHpFWakvRuwkck/aDS
         77OH+qhjE7CKtUC7Gpxrh4QVoJXizs+GhBrbPcPaPlUEjt4VvFzUkGRxeFl8PfMXnwXK
         NfOuqyAnqc2K4n7VrQr8KwbJzYCmnCIzMLnPyAgw33fJn+2ISWAunQkSzV6REbDNnehm
         +LYA==
X-Gm-Message-State: AOAM531LPirxIg5xi57d3GyZrttTeCEu9DXZ2ZGCtLfpaTMVYXXb7X+s
        xUpfJadoFEiIMseQsTUZDOTPZRcQzDKYsw==
X-Google-Smtp-Source: ABdhPJy5KpGuqJaBa7R3JvaH0mDzSSHBpqtD43dtdjVjYzW9/w8dZRgHoFiwkPsy3qXUv/nF55utvg==
X-Received: by 2002:a9d:6f89:0:b0:606:c2ec:66e0 with SMTP id h9-20020a9d6f89000000b00606c2ec66e0mr6445332otq.36.1653187987247;
        Sat, 21 May 2022 19:53:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v23-20020a9d5a17000000b0060603221268sm2696581oth.56.2022.05.21.19.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 19:53:06 -0700 (PDT)
Date:   Sat, 21 May 2022 19:53:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next] mm/shmem: fix shmem folio swapoff hang
Message-ID: <c32bee8a-f0aa-245-f94e-24dd271924fa@google.com>
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

Shmem swapoff makes no progress: the index to indices is not incremented.
But "ret" is no longer a return value, so use folio_batch_count() instead.

Fixes: da08e9b79323 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1171,7 +1171,6 @@ static int shmem_find_swap_entries(struc
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct folio *folio;
 	swp_entry_t entry;
-	unsigned int ret = 0;
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, ULONG_MAX) {
@@ -1189,7 +1188,7 @@ static int shmem_find_swap_entries(struc
 		if (swp_type(entry) != type)
 			continue;
 
-		indices[ret] = xas.xa_index;
+		indices[folio_batch_count(fbatch)] = xas.xa_index;
 		if (!folio_batch_add(fbatch, folio))
 			break;
 
