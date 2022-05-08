Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199CD51ED51
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiEHMJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEHMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:09:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7EADE80
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:05:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652011520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cx9b0wuPi2hpZUIAggEgm8DQsUvh+NwrmES9nHN4zDc=;
        b=T32z0sZuzIfz+dgVDjd+BR4KkbUztkhniEV1p3f4PfO2JWX1GB8xrwjURUFz7cf4Pvklcu
        6i83BL9usTkZkIEWSpC6sV4JcuvN5LNz+vupDQWdI8yQY9P50fdhjw3+/KIRX79Rra4FJe
        /JjCNJ4n5AMNgynj0HAvdmHShzdeWiHfOMPJAprMawm+LWE8zjsP7or327LHP9h6Qzqts5
        3XzXrSUmbLhI8jlVf7vHxAvfBFEvu3NYnyR0Y6t8ahB+7mAuvn4r/ZaHSr9T210vdyHmAV
        akAfH3L6alH+bKdab7MJBWbAMvaOwaJ9/Jkr9lCP5N5TUnrs3gJ//6mXhPLAMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652011520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cx9b0wuPi2hpZUIAggEgm8DQsUvh+NwrmES9nHN4zDc=;
        b=p2vfuxvO8kK9moib1i7BAMiWHRM1d2lSOO5iQVPPyrObKkHvW4yhaivwqe3uKVdhI6Pyrq
        8BpMpdjA7j416tCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.18-rc6
Message-ID: <165201148069.536527.1960632033331546251.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  8 May 2022 14:05:19 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2022=
-05-08

up to:  2667ed10d9f0: mm: Fix PASID use-after-free issue


A single bugfix for the PASID management code, which freed the PASID too
early. The PASID needs to be tied to the mm lifetime, not to the address
space lifetime.

Thanks,

	tglx

------------------>
Fenghua Yu (1):
      mm: Fix PASID use-after-free issue


 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..35a3beff140b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
+	mm_pasid_drop(mm);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
-	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
=20

