Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCBB545720
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbiFIWSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345572AbiFIWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:18:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D046174
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:18:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id s205-20020a632cd6000000b003fdb97e6951so7120148pgs.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HlrKEzC+OauxSUT5xZtPYeK0f3N3z3B8pf9PvEyK7vc=;
        b=qNUPK/S5iHdXgPK57Bkixsq++QOQQMHfyV6r2MtPs7v9I3SUg8azHVdlWi+Vmpdk0V
         e9swXJWEpf/dXShWMQkD9tdieecIjQpQiuIyNIyGp6c4DhP+OHtn6lVN3Jb0aUWnt0zX
         6WRDoSX5skQyQJy1DXGgbB1frbSREBbKFeP8ovCXNP1nwpzQihNeuZDVsxzVVQEW/FTO
         oasKzV38q06qXK4hlfrcDIvuu6az9YMh+LOMOYwAEM/GaKPtPsyF6cfogObTYmCvxbsF
         HDhlFK8BOzg5MG7pql3z3B69jG4uxkigcwMhH0FMhZG9+AiHWiMvxTL/b/XFzI/yrt60
         XE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HlrKEzC+OauxSUT5xZtPYeK0f3N3z3B8pf9PvEyK7vc=;
        b=1kL1dyhubwH2p2MOLdkgzN5lASE585gUxZuV2dncBexry1mkU4P9PfrqnamP3k2Fl0
         o+7aQxNhXBO3X7wVYMbmmaAqIlqHSeCAJk+WgtamQsnXWne6NNRiXb8CHlTUAFxAbC/u
         fJnTd2obG2RqdVjfGROm6k4R5gd59AkevkT4ghMFTQqo81DV8aV6vK/Jhus2HNnK0FPZ
         PX/wLQtXz1btQ7Tart25W2WNuAGmQw2FAWeNiREuwOZhZXyXoKet4aPJLJ93IkUB6ml8
         rzZyl/nkczL8qT6WcJJUKQVs8ORcX48h4rr2sYY7kXgBTN/YMw7swFii2d1kfdIDInmP
         UQoA==
X-Gm-Message-State: AOAM530wGyRAo2E31yzu4Q+QbrKvv3aEkn3ogyj7Irg7dAluU6DxvqcR
        L2O5p/sLZ9inwJ5tPqPSu8ZpHctG
X-Google-Smtp-Source: ABdhPJxktSZZjGsZMg+ncs7oCo7UsGcqz2MItXnZVpN7aAWxKCb/sSBN71lrVJLJ6nxui+334t4TDARu1w==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a63:5924:0:b0:3fb:a75e:9e8a with SMTP id
 n36-20020a635924000000b003fba75e9e8amr36694755pgb.394.1654813127925; Thu, 09
 Jun 2022 15:18:47 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:23 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-5-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 04/12] blk-cgroup: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     isanbard@gmail.com
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, alsa-devel@alsa-project.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Wendling <isanbard@gmail.com>

When compiling with -Wformat, clang emits the following warnings:

mm/backing-dev.c:880:57: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
                                                               ^~~~~~~~~~~~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index ff60bd7d74e0..7b7786dceff3 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -877,7 +877,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 		return 0;
 
 	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
-	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
+	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, "%s", bdi->dev_name);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-- 
2.36.1.255.ge46751e96f-goog

