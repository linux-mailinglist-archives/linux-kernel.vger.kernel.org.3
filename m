Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E055A8621
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiHaS57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiHaS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:57:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE74A74F1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RpgOGnB9LPwwWBIop+LIXVU3gETzEBlTdNUDbgctxSk=; b=fyHSpVX/gtgJGgGKHgy2LmxxmO
        z+qMwp/ARW4OoB6XdzZ88Sh6VCI4kJRIUzBr6bWxKWoOO+d72RUlq6ur7Mvtr7RnivQq1fut+2tQA
        5zfqKPcPTEc3cLodYzOlELjAgRkTXeTfdMmBlz21RW6UzlYW1qoC1LcTGIgIGdLyfS86NYcM2oVRb
        zlztP5uhorEDXEYjeA/MD/Hh98wlgQ7foLI26ALiw9hHTdjB0M1sjzTevLvY3i0oCiTCd83x42Prw
        PWfNr5ryZKL8u8MX2ZzYJosLv3q37aSIhGWqB1bz+Agywa8ejJLeHK8W/DzbSeetKFieFRy+PSJym
        fxl4hxkw==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTSuI-005MHc-K1; Wed, 31 Aug 2022 18:57:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] hugetlb: use mm.h instead of mm_types.h
Date:   Wed, 31 Aug 2022 11:57:39 -0700
Message-Id: <20220831185739.21400-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_types.h does not have zap_flags_t in it so use mm.h instead
in hugetlb.h.

Fixes this build error:

In file included from ../drivers/virt/nitro_enclaves/ne_misc_dev.c:16:0:
../include/linux/hugetlb.h:414:4: error: unknown type name ‘zap_flags_t’; did you mean ‘vm_flags_t’?
    zap_flags_t zap_flags)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
Fixes: mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix.patch
v2: add Rev-by: Peter
    drop the bogus S-o-b: in Cc: Peter Xu

 include/linux/hugetlb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_HUGETLB_H
 #define _LINUX_HUGETLB_H
 
-#include <linux/mm_types.h>
+#include <linux/mm.h>
 #include <linux/mmdebug.h>
 #include <linux/fs.h>
 #include <linux/hugetlb_inline.h>
