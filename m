Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0B5A4C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiH2Moe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiH2MoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:44:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556B79E881
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:29:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so5752871pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CQmPQiZbqJl3F1hmW3HEOlbIzS9LIPFvPFvLkS4xj3A=;
        b=OYKzSZaMCxX4OXsRl1egB+pH2XdaiGlHR5RdNXaCcpG2JWVN+/X1Gg4jhGTuCDsqS3
         xQieVSf1ZVHuHezy46Pz4X+r+auMgAbjBZQqJIJUUjOFGfo9M/1BecpJdnVqVzJcQR+D
         5zpoqRsdzwxL0jC6akJ2u4RWY514EZfImXJpiUfHPxD8xYpSL7RelRug948NB8icEPdU
         h+9D5swl8uKtXhJfYIVoX01taLqe2M+7S8YYVOcxB2yXMSrKBBir5LhqjRq8b+spCs4S
         okHtMa1GHZFw9vgDHKKnENsXw1j2uNmLPbCla5eOLzm56Wev5V7DrzTS5rWp51z6BaUh
         Tbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CQmPQiZbqJl3F1hmW3HEOlbIzS9LIPFvPFvLkS4xj3A=;
        b=VGKr5xCc+SI4AzUNRMMqErhNw5K0Zt9VTABAjfwedkjzCaKn9Lm4AOvW6gnrzEaVxw
         behAWu0H4t7RPrIMQeuLK9YyrZR8EXcGPsdnMzxpJ6ytCKKgNh8lWqfWOIeo0i4tXHIP
         54JxhNU48LC8H/S8IUqDTfQ1WgqIES94Q9KwPcLvcpLrNbul5kzPRIF9DlUj0cI4Zle/
         i/dmHuhMSRPiWlmT+8cFf4cjH9veDkY+LTlKPdawtX998JQoDdkUBoxCr29UzVaA7gCd
         iJMfxWI3caJFp3clTRDRcEEnMNuyoZs/5mhvDibX6EJUOUW8ecRVHIP/f3L+VQY2cLhE
         JzQA==
X-Gm-Message-State: ACgBeo0WUHP8G/Z0pvlDx1XMPNgSlnQqD2rbAKoQpMgyth+eBZpmddCQ
        xHo5ejON+hAftvrSoWHqEfI=
X-Google-Smtp-Source: AA6agR4ERp49BkEJRZeAPhtidKBWr2tA9X2Jqu9y5S2+tKQ9seYBETGT092ViFsKvqltgF+DFoNh7A==
X-Received: by 2002:a17:902:be16:b0:170:8ebf:204c with SMTP id r22-20020a170902be1600b001708ebf204cmr17047264pls.47.1661776160098;
        Mon, 29 Aug 2022 05:29:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b202-20020a621bd3000000b005377c854b50sm7109553pfb.1.2022.08.29.05.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:29:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amdkfd: remove redundant variables err and ret
Date:   Mon, 29 Aug 2022 12:29:14 +0000
Message-Id: <20220829122914.268251-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value from kfd_wait_on_events() and io_remap_pfn_range() directly
instead of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 664e8b5d82c0..84da1a9ce37c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -876,14 +876,11 @@ static int kfd_ioctl_wait_events(struct file *filp, struct kfd_process *p,
 				void *data)
 {
 	struct kfd_ioctl_wait_events_args *args = data;
-	int err;
 
-	err = kfd_wait_on_events(p, args->num_events,
+	return kfd_wait_on_events(p, args->num_events,
 			(void __user *)args->events_ptr,
 			(args->wait_for_all != 0),
 			&args->timeout, &args->wait_result);
-
-	return err;
 }
 static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
 					struct kfd_process *p, void *data)
@@ -2860,7 +2857,6 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 		      struct vm_area_struct *vma)
 {
 	phys_addr_t address;
-	int ret;
 
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
@@ -2880,12 +2876,11 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 		 process->pasid, (unsigned long long) vma->vm_start,
 		 address, vma->vm_flags, PAGE_SIZE);
 
-	ret = io_remap_pfn_range(vma,
+	return io_remap_pfn_range(vma,
 				vma->vm_start,
 				address >> PAGE_SHIFT,
 				PAGE_SIZE,
 				vma->vm_page_prot);
-	return ret;
 }
 
 
-- 
2.25.1

