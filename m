Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06554545711
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbiFIWRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiFIWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:17:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8EBCA3F7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:17:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p78-20020a254251000000b006607e0a2965so16382166yba.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3yOhmb5LLQ31qT6YeyEoaX0jjcoMdHElvVNlhTaaJU0=;
        b=RBpkYSjEyD64s1FKNQbtXE7AfdgJKfYmd5PMKe66FHnMYYo7vB0Ncyw1KRR50CoJoo
         aoycDWjxbUREKPl/jCi5J+ZmN745Yr3i1ib/+VcJJf8M0JMLiwl79xnz8rJSR7GD/eD1
         lW/QxkZdjk6n9mbnb49kc1QuGbm9WiR5bRhdOxYxvavs/N1vvPSKHy30utzBB/gyWoTU
         CgiL6ug+u8f1QpKo/0EMJTNBBIk/eilNKeOEcwDZBOTEwWg6fyCqMv4cdogePUE+xetI
         whOzeQ9ub81nWd36wnDnSka41WjIxLP4QO+2B8XH0LL13vJc0ad+W0zJV+BD/RIy1FOR
         5kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3yOhmb5LLQ31qT6YeyEoaX0jjcoMdHElvVNlhTaaJU0=;
        b=aMUpqg9itjwtX2kpY/LjhUkBHEO/wEgiLFPTL1camzrwfE9l4VbQqqfGAWG+65YcAH
         3aWCY3eXnFxOCcSZ98ZSNTgDwj4q4kBMhWovv2zJ21kli0eYZkl/PvpWw1tkqz7bqQsn
         /Mv1KZMKlO03Eq542oebLkC6tkfVGaZtJfhAqjB+ih/ae1iwABYcZaNdBU5qhl6undHk
         r8cXxscEZ1DVbJWb8ualsiDzzIEWDg+GZZ3wdGbX6QQG69Ik+HyCBCcWH5ZeAufY11Xs
         jMRFVnxEcR2qG4vdnLz38AXoGYRLqFbVuGZ/ZIaoDZAqZsGSWkd+xQDfrSVgNmUzZS1z
         uZog==
X-Gm-Message-State: AOAM530D/Gddk5IJirRvafNtpnfRybdrgT1Q5aUlXdnUuRGi8K34hLMF
        QnR5CYUh5E++XT92dtgghKE0sFD9
X-Google-Smtp-Source: ABdhPJzTMnxRPuV6ZGJzvW5l0mMjxHOaj61kW/6XxvKjUl64lqYEHjJSEX/Dfo2Nrwl6bkVAjyNEv78Ldw==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a25:fe0d:0:b0:64d:915f:e73e with SMTP id
 k13-20020a25fe0d000000b0064d915fe73emr42473933ybe.447.1654813059372; Thu, 09
 Jun 2022 15:17:39 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:20 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-2-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 01/12] x86/mce: use correct format characters
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
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
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

arch/x86/kernel/cpu/mce/core.c:295:9: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
                panic(msg);
                      ^~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 scripts/Makefile.extrawarn     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..3d411b7c85ad 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -292,7 +292,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
-		panic(msg);
+		panic("%s", msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
 
-- 
2.36.1.255.ge46751e96f-goog

