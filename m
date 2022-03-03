Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1D4CB46D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiCCBiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCCBiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:38:52 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BB24BFD9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:38:08 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id y7so3478540oih.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=DbiPq8ZLkGlerWGYBOSuQst5nwpKXHlgov1TDG2JIo8=;
        b=dmQCaMCThZnF9rFjvRp439A4ZfsAXEDnPRR6S6trppe8EOffC7OqfLXdmu+Z1R1VPa
         0twTqz8/Hxy4ZEMJOP6Y/F9dIjhC+vrPnViWVPbBGyN/DHGog1csi8qEqKcL2OE+x9FP
         tujnQoKwZqEpR+Mh3QvVvLFiJBJzIGGFuZh9zb7ntRUur13jfQiygkwHpqWuVPPBlgGz
         KHOvzCVB10CBLXvjp9X01fg6gx/Vpm/yAxpXUr7V/SdTeA/NrwfQyy5NhdxOxaWMQdCp
         PbB5fentoNuMRNoNVcpW+zUScUBYne4vPyqXgX67YzQ8niOGD0JSHeBWKqHlesJVHos9
         Qpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=DbiPq8ZLkGlerWGYBOSuQst5nwpKXHlgov1TDG2JIo8=;
        b=Fu6DE5c++Fxwi9KCPLWcH4rg1BzTp362ZZCfSlI4OLSDD+cXR0i4X0S6NXIBlHF6/1
         v6ekeK3EFgxYF2pJzo/+NMAvzBcY+p8odRKKXfKvvupbTBRNjYi189rcnhwjPH0Lu9Cq
         eJgwG4faDDBOLyRhU3gbEES+WZqtYVOBcMRvnC97OhE5PcO4U3z/G8zuIng9cyZJNnfm
         Hv8Nyx+PNccWPPHPQnD76b2vtlMMxZsBH0ORa+KFOWAyyM9cdimyvhEcRrcxfWT7J1jM
         oIqIcRlxBAMyvW9fMNe24hdJ+fiEGRQIu5B0kGOrue/eocvoPRV3il+uj05MSfABSwE0
         X9mw==
X-Gm-Message-State: AOAM53274YKYEk28Z3yGRQXJppL++bS8KUPnC28JJw8nFzeIRsIRD1cf
        I1qS2xyyIap+xJKwzvMRbq1Zqg==
X-Google-Smtp-Source: ABdhPJwHctsCmBMX1tLO6LBR0LlQfUanQU20847/+pc3K6EFzauBbqBCn/YaS/vohELLSsPtTC9IUA==
X-Received: by 2002:a05:6808:1646:b0:2d4:428c:659e with SMTP id az6-20020a056808164600b002d4428c659emr2589390oib.20.1646271487661;
        Wed, 02 Mar 2022 17:38:07 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w1-20020a056871060100b000d9a1c283e8sm404851oan.37.2022.03.02.17.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:38:06 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:38:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm: _install_special_mapping() apply
 VM_LOCKED_CLEAR_MASK
Message-ID: <a85315a9-21d1-6133-c5fc-c89863dfb25b@google.com>
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

_install_special_mapping() adds the VM_SPECIAL bit VM_DONTEXPAND (and
never attempts to update locked_vm), so it ought to be consistent with
mmap_region() and mlock_fixup(), making sure not to add VM_LOCKED or
VM_LOCKONFAULT.  I doubt that this fixes any problem in practice: just
do it for consistency.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Noticed in doing mm/munlock series, but not needed as a part of that.

 mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3420,6 +3420,7 @@ static struct vm_area_struct *__install_special_mapping(
 	vma->vm_end = addr + len;
 
 	vma->vm_flags = vm_flags | mm->def_flags | VM_DONTEXPAND | VM_SOFTDIRTY;
+	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 
 	vma->vm_ops = ops;
