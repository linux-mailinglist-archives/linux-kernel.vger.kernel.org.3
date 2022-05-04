Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93CB51A10C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350692AbiEDNkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350674AbiEDNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:40:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99893B549
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:36:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so2076414wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:cc:content-transfer-encoding;
        bh=bu++xSk9S8GRGmlH5GsI6es9SClwEAo1FD6rz8cK+go=;
        b=fRnO9sm54iS/qr621PjI32v6sWAjMqv01u1e2HCln/DGaL71KodkjRYM1YVfIPUzv3
         JuNBJznV4KaGgYxqNOUz7jhmFaR/YPKo39OlP9xkvI0moqtXVthBUQta4Be3Fo0OT0dB
         8KibqYbJOMu9URA4eOElG0ojLnz1bfktw1pCULwiqS6WT6Y7PmavmtUhqd1ESFB2iArG
         PyjnhX5dhgahbMyDo6p9Xoblyfi640BvRPzLL+tWsliEH6poR//BwUlr4blcaPR7Cf/c
         DEaXNPvH0WpYACMg5gXaVoL+P6u/LhrPhZxPiacw+4GFT6CZgBYSZCyzPq1Hy72JJoJj
         3wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:cc:content-transfer-encoding;
        bh=bu++xSk9S8GRGmlH5GsI6es9SClwEAo1FD6rz8cK+go=;
        b=HuUcKM6mAVc9BFzIPbYLqyFab2NKukkCLqx/Zm9U/Jkjs50PyTJRCcETzCSmcoQKxz
         gDxHZXONAAdrSTfA/f7qOE5gNtCooc0hGjzZAreYFPIgBQdbd5Iz8I3fOVU8CT9OOK6g
         Hwv1C3TJiVCSv1qecATS3IUmY7uHdcreojD+BWWuXYDhEviC3XpN3j2DICffrFjB0fom
         iB7Xy3wVR802VZ/SlfwCWWyTh89ug5U0wZjK6+AZFfLeDSuKySvvDTtrrftdFKgiiFVb
         9pQm5IEdrpyNDvwOF/8vneXKFcuC0ad3DbgiPmMyfQOmX8Rc9SnaFL/gWH8cynhTEycy
         qXgA==
X-Gm-Message-State: AOAM532B+BMId1FjjRm3Makmp/CBSKC6pkcSOmIhyEf7kZrq3ixkkg7u
        zJdbAVCHvNf2/UV2EqHZll4=
X-Google-Smtp-Source: ABdhPJykRbvC4+oHRIq6O3oIuG2ht/akttjtjdQ8Xf8QUi04ZuSc2/tpAKwlbVXS+7gojwdWoiVYEw==
X-Received: by 2002:a5d:414a:0:b0:20a:d5f9:8b62 with SMTP id c10-20020a5d414a000000b0020ad5f98b62mr16875525wrq.492.1651671397953;
        Wed, 04 May 2022 06:36:37 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id h29-20020adfaa9d000000b0020c5253d913sm11597769wrc.95.2022.05.04.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 06:36:37 -0700 (PDT)
Message-ID: <9a206b6b-bb60-b86b-666d-c75748237cf0@gmail.com>
Date:   Wed, 4 May 2022 14:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: mm/shmem: turn shmem_alloc_page() into shmem_alloc_folio()
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with clang scan-build found an issue in the following 
commit:

commit b0bb08b2d5f399369a906eff0287e64b531881d8
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Fri Apr 29 14:43:02 2022 -0700

     mm/shmem: turn shmem_alloc_page() into shmem_alloc_folio()


The issue is as follows:

#ifdef CONFIG_USERFAULTFD
int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
                            pmd_t *dst_pmd,
                            struct vm_area_struct *dst_vma,
                            unsigned long dst_addr,
                            unsigned long src_addr,
                            bool zeropage, bool wp_copy,
                            struct page **pagep)
{
         struct inode *inode = file_inode(dst_vma->vm_file);
         struct shmem_inode_info *info = SHMEM_I(inode);
         struct address_space *mapping = inode->i_mapping;
         gfp_t gfp = mapping_gfp_mask(mapping);
         pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
         void *page_kaddr;
         struct folio *folio;
         struct page *page;

         ^^ page is not intialized

         int ret;
         pgoff_t max_off;

         if (!shmem_inode_acct_block(inode, 1)) {
                 /*
                  * We may have got a page, returned -ENOENT triggering 
a retry,
                  * and now we find ourselves with -ENOMEM. Release the 
page, to
                  * avoid a BUG_ON in our caller.
                  */
                 if (unlikely(*pagep)) {
                         put_page(*pagep);
                         *pagep = NULL;
                 }
                 return -ENOMEM;
         }

         if (!*pagep) {
                 ret = -ENOMEM;
                 if (!page)
                         goto out_unacct_blocks;

                 ^^ page is being referenced but it has not been set


The commit in question removed the assignment to page:

         if (!*pagep) {
                 ret = -ENOMEM;
-               page = shmem_alloc_page(gfp, info, pgoff);
                 if (!page)
                         goto out_unacct_blocks;


Colin
