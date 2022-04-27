Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB12512138
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiD0RL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiD0RL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:11:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9FA2F01A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so2689317ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KzJMoZjWVKvEwV/GJNINKsGUom0afQp6p2J9kR2X+1A=;
        b=lC3FpZJZChRNp5v8Tjj2ytKLNkOo2nrzVgqDJDx9y8C3aVrk2qTWYs4lU+JelF0tcN
         n3OXD0ZI0MompxoG3ZfX8y+BNXuGt1lGMipvWHfnYCGOo+vj2/NtD1iyW0mFracMd8OQ
         OGMtsYexxrVZOkKSS4DRdVEZKuN8Z7/xo81dE1Fcmc6xMXKyaG/hw3up/nT1OGLwLA3s
         7FnTW9FTxchyVRZr2KcYebg28OC5Z0qj9xKGKo4zjwVdDgilpLw8P6NYHsXEQHZk4hk6
         3a4Nzy3tV+11mhjkJ0UBoJqbLTWVtcP8k2hqPJ+l8UK/crbi189hi/EbjL2fCi8PZifL
         NRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KzJMoZjWVKvEwV/GJNINKsGUom0afQp6p2J9kR2X+1A=;
        b=DX6mYJ/5fy4gfJp0yfSPqisNF49v8yiPUdlmlYAObaWCMOqLXFnuh+1+BCHVZtx5bc
         Ev8CLrXuBp4vhlqs1jRRo1b6SNq5G0ujUEpUQBICEqLjSemYDeY7A9XJUuGQIxfzsnry
         fv0SySZepZ/6iN6dkVyHi21LrsYnF8eQbKC5e8D4Bn9+Py0+Mo9HCGKnaJJO4PCY81ea
         4DjH52aAYPXh/941zB4ylFXTLsT5UQz//rq39Wy8j40QWQFLHuznSGe7ns7u9zO5OdpA
         dYbC4LFW2WfODS5d3+w3kXabwomWHdeBGK8VbxgRfxJc/W2BpCkKg7lQndFeZPPKV2qw
         8auw==
X-Gm-Message-State: AOAM530wcv4TGIiaEBZM6iFUV5DCR9IIabzEzFPd/aAirKS8TfoDG4y5
        VHXlbx+hMtikqVDcEWG+xes=
X-Google-Smtp-Source: ABdhPJyr6N0TZmVqDtMJcdyBPm5EYN24uMLo9VfJXz06Zq3clP1xnPbCdKJPUN3QtoiFci9SqFNLGA==
X-Received: by 2002:a05:6402:26c5:b0:425:f7f0:fb6c with SMTP id x5-20020a05640226c500b00425f7f0fb6cmr11705055edd.133.1651079294833;
        Wed, 27 Apr 2022 10:08:14 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z3-20020a50cd03000000b00425d72fd0besm6694359edi.97.2022.04.27.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:08:14 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 0/4] Remove usage of list iterator after the loop body
Date:   Wed, 27 Apr 2022 19:07:30 +0200
Message-Id: <20220427170734.819891-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to limit the scope of the list iterator variable to the
traversal loop, use a dedicated pointer to point to the found element
[1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]

v1->v2:
- fix NULL ptr dereference in subsystem_open() (Steven Rostedt)
- don't use the iterator in PATCH 3/4 when not necessary (Steven Rostedt)

Jakob Koschel (4):
  tracing: Remove usage of list iterator after the loop body
  tracing: Remove usage of list iterator variable after the loop
  tracing: Replace usage of found with dedicated list iterator variable
  tracing: Remove check of list iterator against head past the loop body

 kernel/trace/ftrace.c               | 20 ++++++++++++--------
 kernel/trace/trace_eprobe.c         | 14 ++++++++------
 kernel/trace/trace_events.c         | 27 +++++++++++++--------------
 kernel/trace/trace_events_hist.c    | 15 +++++++--------
 kernel/trace/trace_events_trigger.c | 24 +++++++++++-------------
 kernel/trace/trace_output.c         | 13 +++++++++----
 6 files changed, 60 insertions(+), 53 deletions(-)


base-commit: 46cf2c613f4b10eb12f749207b0fd2c1bfae3088
--
2.25.1

