Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C557EC98
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiGWH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGWH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:56:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA30378233;
        Sat, 23 Jul 2022 00:56:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g17so6324784plh.2;
        Sat, 23 Jul 2022 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fHVlgOsEdU7End5l0TLqwIBY+nh49Y7umy5UF0akVQk=;
        b=VyVzoTaN3C5lhOV4/RYikj5T+8lWqLx7rEkIfCCoCQP5Pw5MoojG+bw92WRiP6Gpbk
         T/Rlsm7t/Qh5XqVRgH3lr9ZEmguNhoEpoHxk1e8YVmQdPZDRbQLoPJsuF5BXZ4tfxWoo
         /GG2ldd+LVcTz3pbpsSrnEweylkJGbBftC1SABzIV7VSm5zXAoZ4knlB7Vhdb+2I74RJ
         z6VuNjKfN1g/5/F50mtIxQlbSWIzAyob97jYYrZ3eE4TkF2Zi4lKlbmIqqh7XbK2+Ro4
         XwMq7+Uo+afm0YSBP8MoV+xpLotgxU7TGzQGzg4waIPOBUimacKVONwqV+SUiMVHXq+w
         uIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fHVlgOsEdU7End5l0TLqwIBY+nh49Y7umy5UF0akVQk=;
        b=U7YK90sr0OYJ7el2Zl5poNliAzlHsrWEkmq6kwc8PK6QWmnBPI1wgMhVZpKn/1MzFG
         TkTxhDN7Pg4HyYInV4f+geashwqiOctrlIA1adecnMXEcwDGDcWptap9P5LchHOtGr7f
         RVFkkOB4sDUpOF1WoWjhNXrnLJkipR/11tPOAv0OipeeBScqlRjF3hoztxzUd0lFixT8
         o1iq2NwDESTN/etsFpFeqzX+9WfUsWwrRD7pg80Ho4x5+ICWw1Ti4Ag+gCUt+0JYltja
         KSmxcA6Gv8i2BuyqP9kJk8Q0EplhHVVZuz0V4GGlgh8AeMpO+bLnKcq3ovheepiWj948
         g1YA==
X-Gm-Message-State: AJIora8r61iRe7y+D7YU+fXxZIsUpaxfu/znkPCNv19PxOJI1GKy387Q
        sgOKBx0B+amRcR8r56nMnF8=
X-Google-Smtp-Source: AGRyM1suKIpte1fxNWYEqpBwC170ic07x31DwlmI77FxjwFQDGoJOFGNB4J8S9iNSQh4YXo5GCsh0A==
X-Received: by 2002:a17:90b:380b:b0:1f2:5514:9615 with SMTP id mq11-20020a17090b380b00b001f255149615mr3811157pjb.171.1658562962989;
        Sat, 23 Jul 2022 00:56:02 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-23.three.co.id. [180.214.233.23])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm17347184pjb.2.2022.07.23.00.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:56:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 419911048F0; Sat, 23 Jul 2022 14:55:58 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hannu Hartikainen <hannu@hrtk.in>,
        Jiri Kosina <jkosina@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] MAINTAINERS: remove outdated patch submission guidelines
Date:   Sat, 23 Jul 2022 14:55:26 +0700
Message-Id: <20220723075525.210510-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch submission guidelines in MAINTAINERS are redundant, since
submitting-patches does the job and more up-to-date to current kernel
development process.

Remove the guidelines, while also move trivial patch suggestion to
submitting-patches.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/process/submitting-patches.rst |  4 +-
 MAINTAINERS                                  | 78 +-------------------
 2 files changed, 6 insertions(+), 76 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index a1cb6280fbcf4e..bb720c057de7d7 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -15,7 +15,9 @@ Documentation/process/submit-checklist.rst
 for a list of items to check before submitting code.  If you are submitting
 a driver, also read Documentation/process/submitting-drivers.rst; for device
 tree binding patches, read
-Documentation/devicetree/bindings/submitting-patches.rst.
+Documentation/devicetree/bindings/submitting-patches.rst. Not all suggestions
+presented here matter on every patch (including trivial ones), so apply
+some common sense.
 
 This documentation assumes that you're using ``git`` to prepare your patches.
 If you're unfamiliar with ``git``, you would be well-advised to learn how to
diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903bc..8d668a0ec903e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1,81 +1,9 @@
 List of maintainers and how to submit kernel changes
 ====================================================
 
-Please try to follow the guidelines below.  This will make things
-easier on the maintainers.  Not all of these guidelines matter for every
-trivial patch so apply some common sense.
-
-Tips for patch submitters
--------------------------
-
-1.	Always *test* your changes, however small, on at least 4 or
-	5 people, preferably many more.
-
-2.	Try to release a few ALPHA test versions to the net. Announce
-	them onto the kernel channel and await results. This is especially
-	important for device drivers, because often that's the only way
-	you will find things like the fact version 3 firmware needs
-	a magic fix you didn't know about, or some clown changed the
-	chips on a board and not its name.  (Don't laugh!  Look at the
-	SMC etherpower for that.)
-
-3.	Make sure your changes compile correctly in multiple
-	configurations. In particular check that changes work both as a
-	module and built into the kernel.
-
-4.	When you are happy with a change make it generally available for
-	testing and await feedback.
-
-5.	Make a patch available to the relevant maintainer in the list. Use
-	``diff -u`` to make the patch easy to merge. Be prepared to get your
-	changes sent back with seemingly silly requests about formatting
-	and variable names.  These aren't as silly as they seem. One
-	job the maintainers (and especially Linus) do is to keep things
-	looking the same. Sometimes this means that the clever hack in
-	your driver to get around a problem actually needs to become a
-	generalized kernel feature ready for next time.
-
-	PLEASE check your patch with the automated style checker
-	(scripts/checkpatch.pl) to catch trivial style violations.
-	See Documentation/process/coding-style.rst for guidance here.
-
-	PLEASE CC: the maintainers and mailing lists that are generated
-	by ``scripts/get_maintainer.pl.`` The results returned by the
-	script will be best if you have git installed and are making
-	your changes in a branch derived from Linus' latest git tree.
-	See Documentation/process/submitting-patches.rst for details.
-
-	PLEASE try to include any credit lines you want added with the
-	patch. It avoids people being missed off by mistake and makes
-	it easier to know who wants adding and who doesn't.
-
-	PLEASE document known bugs. If it doesn't work for everything
-	or does something very odd once a month document it.
-
-	PLEASE remember that submissions must be made under the terms
-	of the Linux Foundation certificate of contribution and should
-	include a Signed-off-by: line.  The current version of this
-	"Developer's Certificate of Origin" (DCO) is listed in the file
-	Documentation/process/submitting-patches.rst.
-
-6.	Make sure you have the right to send any changes you make. If you
-	do changes at work you may find your employer owns the patch
-	not you.
-
-7.	When sending security related changes or reports to a maintainer
-	please Cc: security@kernel.org, especially if the maintainer
-	does not respond. Please keep in mind that the security team is
-	a small set of people who can be efficient only when working on
-	verified bugs. Please only Cc: this list when you have identified
-	that the bug would present a short-term risk to other users if it
-	were publicly disclosed. For example, reports of address leaks do
-	not represent an immediate threat and are better handled publicly,
-	and ideally, should come with a patch proposal. Please do not send
-	automated reports to this list either. Such bugs will be handled
-	better and faster in the usual public places. See
-	Documentation/admin-guide/security-bugs.rst for details.
-
-8.	Happy hacking.
+If you'd like to submit kernel changes (patches), refer to
+:ref:`submittingpatches` for the guidelines, and
+:ref:`development_process_main` for detailed guide on development process.
 
 Descriptions of section entries and preferred order
 ---------------------------------------------------

base-commit: 70664fc10c0d722ec79d746d8ac1db8546c94114
-- 
An old man doll... just what I always wanted! - Clara

