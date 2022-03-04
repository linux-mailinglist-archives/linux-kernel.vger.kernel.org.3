Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9954CCC7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiCDEQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCDEQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:16:02 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D417FD2C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:15:14 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so6425431otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 20:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=hiQtnrOduuW7BW90xYXmhrv/eSP4mmgn+idI2n3K9fc=;
        b=QU/lW7kQkitT6k7Ffnu4URV7kwjP3KK0xNFeOXJ1jO1EuFikMFRNg/96S4t5Hwtind
         41T9ofu0g++aS8z9C/cHnafXFrcWNH3fIHbilVVO5j5mczlSYDyODv/Pv1ewtEYS/r2n
         ueiK3J38Esi6Csl3Bc87xXV6Ch/rH6UZliuxEfnmwqJidQReYJQIrM99P3Zxfnf4l3Db
         68ER8sxiUu0NgfU/08piqEG4PSMUFpAEyZaCXcdCajeqCiXVf+8wMy0cmfdYJVekVMeM
         008oSSCHOgKAV827TsdRt2VYJqqvx2CMl2CutyHFvukKxY9rZ+cdozxwW9tlGz+UoZdh
         rMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=hiQtnrOduuW7BW90xYXmhrv/eSP4mmgn+idI2n3K9fc=;
        b=SmIh9Cl8o5ekqPtt8BwHDS4P43chZYnNCVZ2Rib1/qJv0nlJSVSlrpPYEq6r0fDJ37
         WwLVa4zTC6nELkyrIoO+I1GuE7ggB7dIQyVnjRYeOrJ3WMt6ZWDCS7ZlmMes6HXKN/Bc
         4vHExHDu2JcLjaqiMwDJeaQlcNwZC4pJulKZ97bBaowWDgZ0O9Ynzr9D41snb/2+Shon
         yFMHr/eYRkrHlA7b2L8LDkC6oQ8uev/1Lr0jW8uNv3oOGUuWYM24SRxxFY/Y6xZvByU1
         iB9srsUUqQ+NqxJ/6HK91D7/5PlEi79JRu6QjFfBb2z1YrpQ4MJDr6BtIl85dBvSgI91
         mSPA==
X-Gm-Message-State: AOAM53297QxJxFiJC2HYp3nu1l0EOM+jHTnmo3tYEP4wkqN3RPIwpPWO
        uDHlbodhWRpiT0fxuHnz2LO+eA==
X-Google-Smtp-Source: ABdhPJwfmf/SyXiLX1p8JjJdtL8b+QTmNlZ1aWE5uD7cx+QyTZ+kc6QhmHbz3Eo9hdrTZRBgGqEV1A==
X-Received: by 2002:a05:6830:1cc2:b0:5af:f66a:55bb with SMTP id p2-20020a0568301cc200b005aff66a55bbmr16601690otg.224.1646367313924;
        Thu, 03 Mar 2022 20:15:13 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h5-20020a056870170500b000d17a9b25d8sm2073735oae.26.2022.03.03.20.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:15:13 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:15:11 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] shmem: mapping_set_exiting() to help mapped
 resilience
Message-ID: <beefffda-6326-e36d-2d41-ed15b51af872@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I added page_mapped() resilience in __delete_from_page_cache() for
the mapping_exiting() case, I missed that mapping_set_exiting() is done
in truncate_inode_pages_final(), which is not actually called for shmem.
(Today, it is folio_mapped() resilience in filemap_unaccount_folio().)

So the fixup to avoid a memory leak in this case never worked on shmem:
add a mapping_set_exiting() in shmem_evict_inode() at last.  But this
is hardly a candidate for stable, since it's only useful if "Bad page".

Fixes: 06b241f32c71 ("mm: __delete_from_page_cache show Bad page if mapped")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1129,6 +1129,7 @@ static void shmem_evict_inode(struct inode *inode)
 	if (shmem_mapping(inode->i_mapping)) {
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
+		mapping_set_exiting(inode->i_mapping);
 		shmem_truncate_range(inode, 0, (loff_t)-1);
 		if (!list_empty(&info->shrinklist)) {
 			spin_lock(&sbinfo->shrinklist_lock);
