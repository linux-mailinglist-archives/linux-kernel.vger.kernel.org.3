Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB846F3B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhLITRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLITRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:17:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475DAC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:13:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso12196309ybj.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 11:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lTAlULbaYci8mNxOh4U/y4HSmlvqptug37kJk1cA9ng=;
        b=pRDHRPMcYrCxtGkxB3Ng0Xbc+SMpiniSXxGbkaAfCCuWQBd/P2JVPToEUkZbjjcfSJ
         nItLlVga0Su1GkumFrTGn47hWXeln9W5o+GgE/OUu/k1oisNGMGiPHtzwodRa/fTgrcl
         R9YYrb0MBVbP5EEpU6YLpzbe2va8FK1QxpX/UZCezgajCHwS9h/FhlWqavV3V1Jrg2j1
         KOY+FhUPMAOuEH+Gc0gnDh8Dt5MzgPa7Zgt4LGxUBu7Dn7ubuleriyOnruNicSNad2K6
         lmU8xmvgcXci3Sa9QRq0bPAIuTZusIogJ/8NsaQ5Ttft5ca946nIDT6HIhylUjww+hKP
         hMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lTAlULbaYci8mNxOh4U/y4HSmlvqptug37kJk1cA9ng=;
        b=K9wK1rbEIYSyuIZqzu6H/iNjUazzOJIUjDQn7a5Jeh6Ux8NdBytbOqyc+vZQ7n5yUh
         vgSr+fcOWbAmVkaO/UVZRbgcw0f+MoPDf4r3uv1XfG7xvkvqmubkz5oYmgKn7ZpBbIha
         pjMcuzqoyu7tTeC/Fs2heZput3cC74zQrj3LAGz2BgzHX+koHyX1U3wTvSGdOA2V5l/d
         GGnIPU2CHYJ9dJzui5NQJ62NeLkrXgHV0Isaw/TNn4P8ihvFkRYer8DRc2mHweeCe1TT
         mmfzdN8RZNbTkAGKsC+CWIJgNlCxlnrXZNRVO6j6FEps7imRRmMHGjRMZE158dyfhBmO
         6t3A==
X-Gm-Message-State: AOAM533MaoLWL6OGoZ9t6n1kgvUhUS56ybFOkYRp3elWSY9/bItkesV4
        JwyJm7QRd3D81sH6bFl/HCGhhdWvHJc=
X-Google-Smtp-Source: ABdhPJzdHuDBifYPK8J3huuoeyqyaXkFbtBIuADiDD9zw4LaQT8yMC0PnA9+BPHRhPDjzcrj566dkfet9Bo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:8b23:8fcc:c6e4:3a65])
 (user=surenb job=sendgmr) by 2002:a05:6902:552:: with SMTP id
 z18mr8451407ybs.318.1639077212444; Thu, 09 Dec 2021 11:13:32 -0800 (PST)
Date:   Thu,  9 Dec 2021 11:13:24 -0800
In-Reply-To: <20211209191325.3069345-1-surenb@google.com>
Message-Id: <20211209191325.3069345-2-surenb@google.com>
Mime-Version: 1.0
References: <20211209191325.3069345-1-surenb@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 2/3] mm: document locking restrictions for vm_operations_struct::close
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments for vm_operations_struct::close documenting locking
requirements for this callback and its callers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
changes in v5
- Added Acked-by

 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..b9b88ba7564b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -577,6 +577,10 @@ enum page_entry_size {
  */
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
+	/**
+	 * @close: Called when the VMA is being removed from the MM.
+	 * Context: User context.  May sleep.  Caller holds mmap_lock.
+	 */
 	void (*close)(struct vm_area_struct * area);
 	/* Called any time before splitting to check if it's allowed */
 	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
-- 
2.34.1.173.g76aa8bc2d0-goog

