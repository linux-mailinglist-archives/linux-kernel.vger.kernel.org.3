Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4804B5A561A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiH2V00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiH2V0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF4870E60
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:49 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id x8-20020a17090a1f8800b001faa9857ef2so3894749pja.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=knlkft8CSs4ctk+Wf5EGoFcT9IapAOL4+B6Ai/+T1Ew=;
        b=P37RAGhPa0fj1eu5oWQ75AvAaLtugohQsYRWKzKsYPy82nTGbYS2huH/UiZNVvoE/s
         88nyZ5hMCHsleX96EzwxSRzBq/7CUKc/bHbJ31Ts1GLCvmDOU9CmcQD2WQXDTk1c+h7j
         3oIUBNbln4Bxomo0AKLbatKVQNVrzgPz+A4aQoGdDS5LbHfkkFmAcE6pV6uk/ymeBjbJ
         1nc4oAeG1urj8/jUSameTDeH8ziLxBTZVHP9LQuagPlJAxjluMekWoC6NIdC1YJBWEbt
         nn2+QyaYYhDKNwmBnD8p146GgfwAnKteHIAkGMz5qwPGMxUQt1Cd0qMSAU4DAqNB0mVB
         aVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=knlkft8CSs4ctk+Wf5EGoFcT9IapAOL4+B6Ai/+T1Ew=;
        b=hY5S5bMd/JZYq9RE32ihPedbkWPG7PCCRMym9mdGI4Uci7RTcqJtbERTxylkmtSKF8
         WAR3wklTTrgWrQ4fzg6N30Zqe72kLTpEUtQff3Yne/0pl6wCVhmW8yMaAlBlHrLxuBf/
         PYGkNypsAN8cgshtSA7Cscn4U3VIu6sYrYABkUclXKn0gYgtCmh4c98tYkYMdhwaMriT
         e/EbWSm1mSftx9rzPhlJMf0r2XqBd1+lK5S6AZ8UpX80d7+g1K9lqIysRefdxPa3ftv4
         +/2e+RzS1rh8BJo11Cd2F8uUYiU0fikYuBT/tllcWYTh3Z/Oo1BhrpCt29M11VohPhLp
         0kXA==
X-Gm-Message-State: ACgBeo2g4G0mfzNvDld+iHgc23k7Nv3Rb3cmh84MNGym5QCFX6CJOu7x
        8MFfXlT4sY5lhnaz6HhkDeWEye179Tc=
X-Google-Smtp-Source: AA6agR7ucJtBhSAnuB+PqV9qzppZFKeEkxBUzS6um9UDd2r/XYBs5DAVo1iLh4VL9E0CKz9mlSvmLd+h5RQ=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:aa7:8d08:0:b0:538:105a:eb6a with SMTP id
 j8-20020aa78d08000000b00538105aeb6amr10112054pfe.42.1661808348114; Mon, 29
 Aug 2022 14:25:48 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:10 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-8-surenb@google.com>
Subject: [RFC PATCH 07/28] kernel/fork: mark VMAs as locked before copying
 pages during fork
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protect VMAs from concurrent page fault handler while performing
copy_page_range for VMAs having VM_WIPEONFORK flag set.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/fork.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bfab31ecd11e..1872ad549fed 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -709,8 +709,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
+		if (!(tmp->vm_flags & VM_WIPEONFORK)) {
+			vma_mark_locked(mpnt);
 			retval = copy_page_range(tmp, mpnt);
+		}
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
-- 
2.37.2.672.g94769d06f0-goog

