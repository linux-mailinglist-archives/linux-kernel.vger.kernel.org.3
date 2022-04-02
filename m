Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBAF4F00A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354357AbiDBKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiDBKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:31:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E75FF01
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:29:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c10so10544917ejs.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2gXCGuihX3a2IVsPFTSjC6Ov7XSqayQmzmVNFvKFh4=;
        b=TRB5J3AtZz0eiJdLpuxyFGI44304XSageFQzPPKq8GveBsLOD4HTZ43Aq3JZnPqFjD
         zRFCE37gcuRq20Byg31PGBNSQivJl4HxhAuiSrjQSKIkgsHFlztWEHSscvPziJjLqTGf
         fN7k8hKkd3D450UGBrhr0a2CXfLAoD7fSLbWCy0/aenxZ03ozP7m47yGHvR5fEZfb32q
         QecuJackdqrjJzOH+cRtXBhdJUufo/yW2zf/v1/iUKF5o4yvPdRNVkNc2dMMZu+mMP28
         6qwkHiDEzC6H91l3yFnr2GQrEjruYgWGFAgHqj4uQdkP5HVVd9k7cosavpIxoNPenCix
         nTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2gXCGuihX3a2IVsPFTSjC6Ov7XSqayQmzmVNFvKFh4=;
        b=6mkWvlBw21PTc9xBDKOojvTKC5wFMu/tElqEVWNZ5Jnvsa8E2z6FfDn04IAGO23dq+
         l6GPEP1iqr18Mau2jCsDtU5gmUbvKOYEOUKjxRtlkM+Zqjneqc5PBI+J3uRxCQZsaDiK
         kfQefBfU+hku3EYwb8nQwUBa1iHE7aNDzT+6g7Ux39ucqgnXx8oeb0nPbrgzB9m7gmkO
         NFuS5rQ6nIGrpH3FXTbAJliOrqe8EuqOU26X4nJeJUjOxsKqsgcz0KzB8MCx/7s0o/36
         BDsSwDmUC9i53Z5MUlaT5PDl1d8xael2k/O2qu93zlN6PQxJ47oCigE3wBCv5R5PvBcT
         4Vxg==
X-Gm-Message-State: AOAM532z6sf9HKBCMtW8O9EM60uF/D/sSsGiW/mhBJ938w6M5rOF6vWW
        yL5oen+URJOBUJDGSb2aHds=
X-Google-Smtp-Source: ABdhPJx1VhsEXgRpJDsnM+tXjQ2BWW9voiacltRRmPn30kzdTeupenf3HF9eaObfkJSYgXa1KCaigA==
X-Received: by 2002:a17:906:5d06:b0:6df:b0ac:59c2 with SMTP id g6-20020a1709065d0600b006dfb0ac59c2mr3469624ejt.758.1648895373312;
        Sat, 02 Apr 2022 03:29:33 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id qk32-20020a1709077fa000b006df6bb30b28sm1952187ejc.171.2022.04.02.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:29:32 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: Remove usage of list iterator after the loop body
Date:   Sat,  2 Apr 2022 12:28:44 +0200
Message-Id: <20220402102848.1759172-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer as the iterator [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/

v1->v2:
- fix reverse x-mas tree (Steven Rostedt)
- rename subject line (Steven Rostedt)
- add additional tracing patches to bundle them all up in one go

Jakob Koschel (4):
  tracing: Remove usage of list iterator after the loop body
  tracing: Remove usage of list iterator variable after the loop
  tracing: Replace usage of found with dedicated list iterator variable
  tracing: Remove check of list iterator against head past the loop body

 kernel/trace/ftrace.c               | 20 ++++++++++++--------
 kernel/trace/trace_eprobe.c         | 14 ++++++++------
 kernel/trace/trace_events.c         | 29 ++++++++++++++---------------
 kernel/trace/trace_events_hist.c    | 17 ++++++++---------
 kernel/trace/trace_events_trigger.c | 28 +++++++++++++---------------
 kernel/trace/trace_output.c         | 13 +++++++++----
 6 files changed, 64 insertions(+), 57 deletions(-)


base-commit: 7a3ecddc571cc3294e5d6bb5948ff2b0cfa12735
-- 
2.25.1

