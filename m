Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AEB551259
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbiFTIQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiFTIQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:16:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A012011824;
        Mon, 20 Jun 2022 01:16:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id a14so39427pgh.11;
        Mon, 20 Jun 2022 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=4QYQFic1fCpjkC2fARyR5V/mb/MhdFZS52myk2AI/EQ=;
        b=etuIwQ57azbaro1P/Lys40ARKWFqA2SaKHsVc/n5RmGcn5ttk3zm0wZTlN8/1d4209
         sf6utg3vgZdhZ9bKFf6POTfuZ4hL9YoW29Prsw+NIUqNFpYtRE/ZCvtiJL9a7iVWE3YN
         arZIAx70KvuAE7XEgOSpwMTcViBSmSbRtyPFB73FD5OC6YAXnCZgyp4FICHfZ5Mzx4tb
         zfo8jsLUFbAd5/SGCmx1Y1wXKjzkXUNelP+r7EG0Jiwvm1YCfotChFYlbFjTXh6DFGm4
         3oAlCXkdi0FBxSCePC80HCh1Kh5TzGUTmVapENYjIPgkDrGFCuK0LMAwdq8ckFBbPyf0
         jqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=4QYQFic1fCpjkC2fARyR5V/mb/MhdFZS52myk2AI/EQ=;
        b=bq4A6fUuwoc8rF0MEqfAPq5KAXdOd2e+rq4mOT6ZAhmP1j12nZxLTIzfibZROLV9ZU
         /aXbCZAN0NI7sbuIFGrL3WxaZ91DDWgmdHkAVCnfkWRGwtxASaQdbwcehARarTS2jq+w
         7GC0aMtCrjiYAuJu/UyPhGNvc/aKTCQxObIn0JqGvHa6kgSMGuT4hax7CHkE2wRmnCaO
         bZOF17uTDpDOTafhI0e5OwTdP5nzmaRlms51RUW1WfuCWieHJsoaMXnLAVC8jiiwbI3g
         uK5jWwaYE3sLeOay5uoCbv9BP+vUGlpNC/VYz+Nrgge+tHZxvCTSlMoVbgYnDac8tImR
         hshw==
X-Gm-Message-State: AJIora9NbQ4pk9HZd43evaGCafXhD/qRLXBKcPAWHIgFEqWkO6z2L4ru
        rFz3+paQ9pFMIjeo9XLrM0M=
X-Google-Smtp-Source: AGRyM1vGgW1jby8SVrJ+pwEkaSbBcuVs6MF5ipAdO7GUDCdxO+KTi46obswg8IPZBdl0RVY1vG4B8g==
X-Received: by 2002:aa7:904e:0:b0:520:73d0:5b11 with SMTP id n14-20020aa7904e000000b0052073d05b11mr23155112pfo.9.1655712970062;
        Mon, 20 Jun 2022 01:16:10 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z13-20020a170902cccd00b001616723b8ddsm8034222ple.45.2022.06.20.01.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:16:09 -0700 (PDT)
Message-ID: <a84435e4-5342-f886-4388-e4c5909298a7@gmail.com>
Date:   Mon, 20 Jun 2022 17:16:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>,
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
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH RESEND v1 0/2] docs/memory-barriers.txt: Fix confusing name of
 'data dependency barrier'
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

I used Paul's old email address in RFC and v1.  My bad.
Sorry for making noise to other recipients.

Paul, please see RFC [1] for the discussion so far.
There was no response to v1.
-----

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
with "address-dependency barrier" considering that READ_ONCE() still has
an implicit address-dependency barrier.

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


base-commit: c09ca10d879bae4a8df842dbe8d6bd8b87830633
-- 
2.25.1

