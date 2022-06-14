Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59954AD89
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiFNJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFNJph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:45:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461B39BB7;
        Tue, 14 Jun 2022 02:45:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f9so7373725plg.0;
        Tue, 14 Jun 2022 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=73S1jK2kx2ZRVydinmPVHC622te8kmk8uRqY6O2Um0o=;
        b=b7nIN9tHAbq2tdHyN5KzLdZiupniSSm8uzhn+Xc58s8rnaEF1HClUzTXEdCS4x6FqS
         3ttBOjDaGB2pSqUlQXE9TPa9D2/nf0o2bJlph3EAU8biirqgFeDmnBkG7IYE75Lu/9lw
         fC7ZQt7ydK2EEHr5ewWDunhchbCu+tvu+Q0Xh4G/pSIOedOR2cUpFOerOM25FQCsa1I/
         lU+5oJJdDKkL4Ub6mrwjS544NaY+hMA5uLWHBlk12fs9mRwIGbfN0j4RBSqWts8/vr7j
         YCasLhkkoup9Kjh3NX6XcO2Myyl9BXKOYNvlaT/e9t95Eit5xwWbAVwvdqMT8kAJ9zz2
         Z6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=73S1jK2kx2ZRVydinmPVHC622te8kmk8uRqY6O2Um0o=;
        b=6GfHVZMpiIUR3lhjORNn/Anb1B/Jr3Y0kr5PKEwbB/ILwxdqNf/UefsVpDVKzBlUl4
         z7dT2RxREvuuPvWyRtTd7fYPZuYIYtjgJxPlFVQk55gGb8PPKJKKqIkWP347R8pnlAVx
         mvth5yvQI/MmhRz9kCJF4uZScHeB6/NTGuFdumDXpatYqVkS6yhExWiqgsx39Xe+ziaB
         76UTCwRiTpnyp2AKlgQoqEfRd6doPxqEWaw3Ii4MvsFFB9diqlVIqE/6CAWeZ7WiAhEi
         q5twEO/mhOyLjc6p0xVbf4EcNdIKvTYtgQxUKIdXjDE8dIABDor3LlyO9xcBXkMMGo0G
         df/A==
X-Gm-Message-State: AJIora8MOyHLIeUvN9AX5eJD8/YXVHA9OSVocLHX7A4ntUfJn8Huq5Xk
        1O2N4qakz0ZvFUWB0CvStpMsuUxX/Ok=
X-Google-Smtp-Source: AGRyM1vixRMQqL+EKfXaTAmirAGdYWVfHwyPJSXwVJ6O1dNKU5Gy/sY6pDckgXEyw4yMy/vwvQWcYg==
X-Received: by 2002:a17:903:120f:b0:15f:99f:9597 with SMTP id l15-20020a170903120f00b0015f099f9597mr3562560plh.45.1655199936369;
        Tue, 14 Jun 2022 02:45:36 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902ea4a00b001637997d0d4sm6741988plg.206.2022.06.14.02.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 02:45:35 -0700 (PDT)
Message-ID: <2fcb021f-2683-53f3-3088-683276aa580c@gmail.com>
Date:   Tue, 14 Jun 2022 18:45:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v1 0/2] docs/memory-barriers.txt: Fix confusing name of 'data
 dependency barrier'
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a revised patch set of RFC [1].

Discussion so far is about possible follow-up improvements,
so I hereby submit this set as a "v1".

Changes since RFC [1]:

  - Rename title of Patch 1/2.
  - Remove note on the rename of section "DATA DEPENDENCY BARRIER".
    Rational in the changelog should suffice.
  - Wordsmith by self review.
  - Add Patch 2/2 (fixup of long lines).

[1]: https://lore.kernel.org/linux-doc/cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com/ # RFC

For your convenience, diff of "v1 1/2" vs RFC is appended below.

Following is the explanation of background in RFC (with typo fixes):
-------------------------------------------------------------------
This is a response to Michael's report back in last November [2].

[2]: "data dependency naming inconsistency":
     https://lore.kernel.org/r/20211011064233-mutt-send-email-mst@kernel.org/

In the thread, I suggested removing all the explanations of "data dependency
barriers", which Paul thought was reasonable.

However, such removal would require involved rewrites in the infamously
hard-to-grasp document, which is beyond my capability.
I have become more inclined to just substitute "data dependency barrier"
with "address-dependency barrier" considering the that READ_ONCE() still
has an implicit address-dependency barrier.

This patch set is the result of such an attempt.

Note: I made a mistake in the thread above. Kernel APIs for explicit data
dependency barriers were removed in v5.9.
I was confused the removal with the addition of the barrier to Alpha's
READ_ONCE() in v4.15.

diff of "v1 1/2" vs RFC
------------------------------------------------------------------
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 306afa1f9347..bdbea3cc66a3 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -391,8 +391,8 @@ Memory barriers come in four basic varieties:
      memory system as time progresses.  All stores _before_ a write barrier
      will occur _before_ all the stores after the write barrier.
 
-     [!] Note that write barriers should normally be paired with read- or address-
-     dependency barriers; see the "SMP barrier pairing" subsection.
+     [!] Note that write barriers should normally be paired with read or
+     address-dependency barriers; see the "SMP barrier pairing" subsection.
 
 
  (2) Address-dependency barriers (historical).
@@ -561,17 +561,14 @@ As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
 to this section are those working on DEC Alpha architecture-specific code
 and those working on READ_ONCE() itself.  For those who need it, and for
-those who are interested in the history, here is the story of address-
-dependency barriers.
+those who are interested in the history, here is the story of
+address-dependency barriers.
 
-[!] The title of this section was renamed from "DATA DEPENDENCY BARRIERS"
-to prevent developer confusion as "data dependencies" usually refers to
-load-to-store data dependencies.
-While address dependencies are observed in both load-to-load and load-to-
-store relations, address-dependency barriers concern only load-to-load
-situations.
+[!] While address dependencies are observed in both load-to-load and
+load-to-store relations, address-dependency barriers are not necessary
+for load-to-store situations.
 
-The usage requirements of address-dependency barriers are a little subtle, and
+The requirement of address-dependency barriers is a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
 following sequence of events:
 
@@ -602,8 +599,8 @@ While this may seem like a failure of coherency or causality maintenance, it
 isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
 Alpha).
 
-To deal with this, an implicit address-dependency barrier of READ_ONCE()
-or better must be inserted between the address load and the data load:
+To deal with this, READ_ONCE() provides an implicit address-dependency
+barrier since kernel release v4.15:
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -659,11 +656,9 @@ can be used to record rare error conditions and the like, and the CPUs'
 naturally occurring ordering prevents such records from being lost.
 
 
-Note well that the ordering provided by an address or a data dependency is local to
+Note well that the ordering provided by an address dependency is local to
 the CPU containing it.  See the section on "Multicopy atomicity" for
 more information.
 
---------------------------------------------------------------------

        Thanks, Akira
--
Akira Yokosawa (2):
  docs/memory-barriers.txt: Fix confusing name of 'data dependency
    barrier'
  docs/memory-barriers.txt: Fixup long lines

 Documentation/memory-barriers.txt | 177 ++++++++++++++++--------------
 1 file changed, 95 insertions(+), 82 deletions(-)


base-commit: 21710a691d770f8b48e2de66426fb1c1c8416ee6
-- 
2.25.1

