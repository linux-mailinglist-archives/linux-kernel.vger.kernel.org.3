Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787CD4C2082
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245216AbiBXAOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiBXAOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:14:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAAB5F4D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:14:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gb21so481062pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWiJqyBmHVLQbDjgYyBAcQodJ4PbnDvUmaAVoLsJS4w=;
        b=B+uh6Yp6xmTIXeSfs1JnBFk/jkkLZ1Vw3BYubhwlQbspU1RCcNeNqctn4I70RVLIol
         Si6KDKcaEODue79zVe71vc/DaykBQDtjchY9fgGTBS+KTTnL37m8tlAxIV6NsBX133xz
         Q2rkDjkA10QCxmyJQa0mMefeOF+NB5BwMJV1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWiJqyBmHVLQbDjgYyBAcQodJ4PbnDvUmaAVoLsJS4w=;
        b=dEsYeQOIJFCOBDssiqHRDeJFL6KcOslavyFM8UA/aQULQ9O0GC1Psnh1Nbv3ZQZ8cU
         KBhImSquGlBc8t7e8g63oIrtbOE0Pr3mEsapU3qO2FXs+LtY9ExmC7AwiTu6nAA8ln7O
         /oNqh70dKS2Ul46WjFSYw0CeUTUVDYu7TjEnGB1fXgDNb8FjS/GuRNXXZcCBFMEAAno2
         FJlsGtOBxFfSbU+j8zyX3eBLxJO9ZSCfiw49qn2gtgqyGW/cKj5H048fsKdFuvncz9uE
         tHTzvRt3leCqGGJ+NcmJRrGcAbMN+VAh+z1nPK4T0ouHQ210J8o8a7k/othW9++tKiV8
         rXJQ==
X-Gm-Message-State: AOAM531RtmIEBVbI9OFrnKfN1StqB3MEU62WJyUKGJrvNHqNogQLXZFL
        /7NU7n3hDRN7CSVQuKvv9DPw7w==
X-Google-Smtp-Source: ABdhPJy7IikcyjifqSeBxQRWe/5wcWscPFj8T6f6zKjKgTnz+rDNhdCaD/mPxW/d2ffvImjPoFesLA==
X-Received: by 2002:a17:90b:3d02:b0:1bc:85fa:e24 with SMTP id pt2-20020a17090b3d0200b001bc85fa0e24mr8543922pjb.239.1645661646404;
        Wed, 23 Feb 2022 16:14:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm713743pfl.210.2022.02.23.16.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:14:06 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] Documentation/process: Add Researcher Guidelines
Date:   Wed, 23 Feb 2022 16:14:03 -0800
Message-Id: <20220224001403.1307377-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9266; h=from:subject; bh=CQePDr1DFfNdm/DsFEAgI6x+RxatFwswD0jse+R0L4E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFs3KW/WPUnYzV5YGusU2EhRH8uEZL21QwjlzlBiZ rh1SwEGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhbNygAKCRCJcvTf3G3AJldPD/ 95pMS7QUNj58sTT3dZgN6WQ/qY8zYt1FqqMcySA4xyYhNon/W/vZugARYfl0RR5VBVumR1FJgvYiDt nkyH5sLSl+KIHFLgCQEGvm9l6bjv9xStfI+rj9PkMdl4PvtE8TKqDwx3pvEKhv1/pSym9frfRmKLNT YN05KDgumKd7mop+zbKrH3Orl7aInOISB5/8WU5JuWgcykH4bCMwiC5vbZyyZPZMHsXSD+aitb34Pj CcWlBHUBgijHJYsvWydqYnERQNw407IHYG4YHciRFo71dxcRZhjMwEY0YcNJKFu6LKHaTra9b49YdQ Hu6/VNxNjCofKYr7GXtZfttFTph8BQhksrVRGePE1ud5+XfykMd7sGuUdhubEeJ6GBo2gIXlj9e9hE ZrfC+LytF8c7FOUCzWmAFLpdtKp83ouvNwJVnEDm8U3Br9dOjUjvBpawFQD/fPoJfn181YDaWo20C6 hcXo59ekz1FBVMAblRCAP+18Y5Y25HvwIm3B50mKCneyMpuB/0qfaH20SPaemUkhurlWNQVW7X6r2+ UxR82X6pqbOeL4HF/EL5QgPp1eH+4bnZx4A2PKyBbk2d/7xrtgPPvq/GeZL/WyBNqJLVm0J1qtSADh vmdmW+UoPxSPsmf5U8xwMwfkEYNkplB1XLugmavmbUIFEKza6Xcmwu20G3mw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/researcher-guidelines.rst     | 141 ++++++++++++++++++
 2 files changed, 142 insertions(+)
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
index 000000000000..993f32d1166c
--- /dev/null
+++ b/Documentation/admin-guide/researcher-guidelines.rst
@@ -0,0 +1,141 @@
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
+* `Developer and Researcher Views on the Ethics of Experiments on
+   Open-Source Projects <https://arxiv.org/pdf/2112.13217.pdf>`_
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
+Before contributing, carefully read the documentation on
+:doc:`submitting patches <../process/submitting-patches>`,
+:doc:`reporting issues <reporting-issues>`, and
+:doc:`handling serious flaws <security-bugs>`. Send a patch (including
+a commit log with all the details listed below), and follow up on any
+feedback from other developers.
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
+* Which version of Linux was the problem was found on? Using the most
+  recent release or a recent :doc:`linux-next branch <../process/howto>`
+  is strongly preferred.
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

