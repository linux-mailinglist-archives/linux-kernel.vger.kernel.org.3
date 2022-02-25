Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327BA4C4F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiBYUPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbiBYUPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:15:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA2C1B84F6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:14:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n15so3461318plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxrYCXN7Z3oNbm4bQhhbEw6aBwoRcyzbaxJjoPg5IQY=;
        b=ZC3h5RJYCTEeUlM/5Qi83zM3t5Acc3EGYtbEjEVpke7uSx6S6zNsf7CbVf0lRAWMlT
         KTmVOJjLFpde01pyX4ex2XDilzu2k7TDD3qVcuR7Sb3T3XoqvNXtLBwUtG3W1OhPYb3C
         V/FeiZzCedIpLbaDidL9tAm3vMu8VHh7UNMDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxrYCXN7Z3oNbm4bQhhbEw6aBwoRcyzbaxJjoPg5IQY=;
        b=7tZtvUWgtpRu/DOULtl8/2dhEbg5K6pfw3dwtgiAhgledU5id8l9fa6mcW6M5rKJna
         gQch3M6eZj3kTfslmTwJnVXAJSSPLEb6vV0YT/EKNb+BP6IS9UEBCFweveI/38LKOhhw
         uqySGbuZoaxBLOiaVCy5QmFdlAm3fdX+K1b1yPL5fQ8s206Q7BwoGkAHheOpD38Zd1TY
         GKEm16xarS2MK6sGsAF86xr7mqOHUItd7OQqIPtRWQlEs9mOZihKM4DkFRUqYG97zcb2
         SlZIWu84COo8VM6V7rJpp/UhuTQ+5LrAFN+7gOwUPe8lc5PXNw8nvA5qduyrl8OLc03U
         UQTA==
X-Gm-Message-State: AOAM533BH8wm1CNAlAd70g4FjLwnDpVsYtUt2M2Xl03ia2jbRDHSy2cX
        gO+xcbINvzfyzSXDLA0xD44bRA==
X-Google-Smtp-Source: ABdhPJz9V3muqouZEa+fwS5dBStTRlvlUDUlmmY/cwddeUc1WKHb2KIBFHZ9uVEm7Yoqv65rx6kUUw==
X-Received: by 2002:a17:90a:a382:b0:1bc:202a:28e8 with SMTP id x2-20020a17090aa38200b001bc202a28e8mr4795334pjp.131.1645820073200;
        Fri, 25 Feb 2022 12:14:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10-20020a65524a000000b00372e458e87esm3253995pgp.67.2022.02.25.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:14:32 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] Documentation/process: Add Researcher Guidelines
Date:   Fri, 25 Feb 2022 12:14:24 -0800
Message-Id: <20220225201424.3430857-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9537; h=from:subject; bh=AEzkvfiAuEzZBHEYMclTj+mvMSAw3kiy3MO7NELDMdI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiGTig5Okbl0p8w85C4L83aAZWKWOS+DEPyiOr9FDP 4BvxafWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhk4oAAKCRCJcvTf3G3AJp+YEA CYG347M6wueJF6S64dV5Sft/S5t2k+OrQNKkzoQLvRRRvlhw4HHjWSx0MW/t8h0pDT04jyhNETwe2b Xm7qGoPpuqddFU7yL2E2t/uXLy086ugK6qIF37FgkVizmLpaCuXdgFVMYht/rlW3QXkmOg4PI1FlCz 2pciMrYy8n4oZu5HWpQDPf5FsnWgVaR49oKXecgkFfH/Vyl7hOPKPRfCobMWu2M4vpCzrCh6YZt2YG Wl/xdh/p/iG/uFvLEsiKMYoTKYo0cLTJUQZhajSyfi29/1eNe/ti4Ex9IUHUZLZ6OngjnCkVx7pa8u XpZc5bhdGJQ6VAkqKr4vqbHxcdEEu61ADbkNgzTA7WbiVgPNe/mcO31XrpkjoTSFX9kyfU0kwWNLYr HVgxOuURsS6zgx8hjdrIQsU3dRwCLPrcOGTiDy6ci1qH06inrvYr3PIU6ZSA6oaygPD8EbM7AIcyGM BAGTzTlUrMsSeZ6bXqhuCDuXKwJQq5ccwYZyZoBoRvGVYuy/MyM6MXLnfKbYYUrYAJidxz3fjMqrZb 0YMQt0Ho0SiWZcbXowys3yTadfjNXBYErGRhLdZjeVsI/j1h+6UZT3/34iz4jNN6eTO/wtTLFE/n72 yyJhSnU5ClwfSVVO4ZoZSQjmn6++9FbCaUR4fDWohn9DXE11uljvwcxj57bA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow-up to the UMN incident[1], the TAB took the responsibility
to document Researcher Guidelines so there would be a common place to
point for describing our expectations as a developer community.

Document best practices researchers should follow to participate
successfully with the Linux developer community.

[1] https://lore.kernel.org/lkml/202105051005.49BFABCE@keescook/

Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Co-developed-by: Stefano Zacchiroli <zack@upsilon.cc>
Signed-off-by: Stefano Zacchiroli <zack@upsilon.cc>
Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Steve Rostedt <rostedt@goodmis.org>
Acked-by: Laura Abbott <labbott@kernel.org>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220224001403.1307377-1-keescook@chromium.org
v2:
 - fix typo (Gustavo)
 - reformat links, add links (Thorsten)
---
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/researcher-guidelines.rst     | 143 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 Documentation/admin-guide/researcher-guidelines.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 1bedab498104..7fff0730204d 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -35,6 +35,7 @@ problems and bugs in particular.
    :maxdepth: 1
 
    reporting-issues
+   researcher-guidelines
    security-bugs
    bug-hunting
    bug-bisect
diff --git a/Documentation/admin-guide/researcher-guidelines.rst b/Documentation/admin-guide/researcher-guidelines.rst
new file mode 100644
index 000000000000..afc944e0e898
--- /dev/null
+++ b/Documentation/admin-guide/researcher-guidelines.rst
@@ -0,0 +1,143 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _researcher_guidelines:
+
+Researcher Guidelines
++++++++++++++++++++++
+
+The Linux kernel community welcomes transparent research on the Linux
+kernel, the activities involved in producing it, and any other byproducts
+of its development. Linux benefits greatly from this kind of research, and
+most aspects of Linux are driven by research in one form or another.
+
+The community greatly appreciates if researchers can share preliminary
+findings before making their results public, especially if such research
+involves security. Getting involved early helps both improve the quality
+of research and ability for Linux to improve from it. In any case,
+sharing open access copies of the published research with the community
+is recommended.
+
+This document seeks to clarify what the Linux kernel community considers
+acceptable and non-acceptable practices when conducting such research. At
+the very least, such research and related activities should follow
+standard research ethics rules. For more background on research ethics
+generally, ethics in technology, and research of developer communities
+in particular, see:
+
+* `History of Research Ethics <https://www.unlv.edu/research/ORI-HSR/history-ethics>`_
+* `IEEE Ethics <https://www.ieee.org/about/ethics/index.html>`_
+* `Developer and Researcher Views on the Ethics of Experiments on Open-Source Projects <https://arxiv.org/pdf/2112.13217.pdf>`_
+
+The Linux kernel community expects that everyone interacting with the
+project is participating in good faith to make Linux better. Research on
+any publicly-available artifact (including, but not limited to source
+code) produced by the Linux kernel community is welcome, though research
+on developers must be distinctly opt-in.
+
+Passive research that is based entirely on publicly available sources,
+including posts to public mailing lists and commits to public
+repositories, is clearly permissible. Though, as with any research,
+standard ethics must still be followed.
+
+Active research on developer behavior, however, must be done with the
+explicit agreement of, and full disclosure to, the individual developers
+involved. Developers cannot be interacted with/experimented on without
+consent; this, too, is standard research ethics.
+
+To help clarify: sending patches to developers *is* interacting
+with them, but they have already consented to receiving *good faith
+contributions*. Sending intentionally flawed/vulnerable patches or
+contributing misleading information to discussions is not consented
+to. Such communication can be damaging to the developer (e.g. draining
+time, effort, and morale) and damaging to the project by eroding
+the entire developer community's trust in the contributor (and the
+contributor's organization as a whole), undermining efforts to provide
+constructive feedback to contributors, and putting end users at risk of
+software flaws.
+
+Participation in the development of Linux itself by researchers, as
+with anyone, is welcomed and encouraged. Research into Linux code is
+a common practice, especially when it comes to developing or running
+analysis tools that produce actionable results.
+
+When engaging with the developer community, sending a patch has
+traditionally been the best way to make an impact. Linux already has
+plenty of known bugs -- what's much more helpful is having vetted fixes.
+Before contributing, carefully read the appropriate documentation:
+
+* Documentation/process/development-process.rst
+* Documentation/process/submitting-patches.rst
+* Documentation/admin-guide/reporting-issues.rst
+* Documentation/admin-guide/security-bugs.rst
+
+Then send a patch (including a commit log with all the details listed
+below) and follow up on any feedback from other developers.
+
+When sending patches produced from research, the commit logs should
+contain at least the following details, so that developers have
+appropriate context for understanding the contribution. Answer:
+
+* What is the specific problem that has been found?
+* How could the problem be reached on a running system?
+* What effect would encountering the problem have on the system?
+* How was the problem found? Specifically include details about any
+  testing, static or dynamic analysis programs, and any other tools or
+  methods used to perform the work.
+* Which version of Linux was the problem found on? Using the most recent
+  release or a recent linux-next branch is strongly preferred (see
+  Documentation/process/howto.rst).
+* What was changed to fix the problem, and why it is believed to be correct?
+* How was the change build tested and run-time tested?
+* What prior commit does this change fix? This should go in a "Fixes:"
+  tag as the documentation describes.
+* Who else has reviewed this patch? This should go in appropriate
+  "Reviewed-by:" tags; see below.
+
+For example::
+
+  From: Author <author@email>
+  Subject: [PATCH] drivers/foo_bar: Add missing kfree()
+
+  The error path in foo_bar driver does not correctly free the allocated
+  struct foo_bar_info. This can happen if the attached foo_bar device
+  rejects the initialization packets sent during foo_bar_probe(). This
+  would result in a 64 byte slab memory leak once per device attach,
+  wasting memory resources over time.
+
+  This flaw was found using an experimental static analysis tool we are
+  developing, LeakMagic[1], which reported the following warning when
+  analyzing the v5.15 kernel release:
+
+   path/to/foo_bar.c:187: missing kfree() call?
+
+  Add the missing kfree() to the error path. No other references to
+  this memory exist outside the probe function, so this is the only
+  place it can be freed.
+
+  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
+  11.2 show no new warnings, and LeakMagic no longer warns about this
+  code path. As we don't have a FooBar device to test with, no runtime
+  testing was able to be performed.
+
+  [1] https://url/to/leakmagic/details
+
+  Reported-by: Researcher <researcher@email>
+  Fixes: aaaabbbbccccdddd ("Introduce support for FooBar")
+  Signed-off-by: Author <author@email>
+  Reviewed-by: Reviewer <reviewer@email>
+
+If you are a first time contributor it is recommended that the patch
+itself be vetted by others privately before being posted to public lists.
+(This is required if you have been explicitly told your patches need
+more careful internal review.) These people are expected to have their
+"Reviewed-by" tag included in the resulting patch. Finding another
+developer familiar with Linux contribution, especially within your own
+organization, and having them help with reviews before sending them to
+the public mailing lists tends to significantly improve the quality of the
+resulting patches, and there by reduces the burden on other developers.
+
+If no one can be found to internally review patches and you need
+help finding such a person, or if you have any other questions
+related to this document and the developer community's expectations,
+please reach out to the private Technical Advisory Board mailing list:
+<tech-board@lists.linux-foundation.org>.
-- 
2.30.2

