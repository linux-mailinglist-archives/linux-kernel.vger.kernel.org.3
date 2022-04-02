Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1366C4F00B1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354392AbiDBKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiDBKft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:35:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD729F55C7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:33:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u26so5618168eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6rCtHdzYgVTzWbWwvY8R1K3tYk8i64z1/WICkBQypg=;
        b=AGCHHKllvpl+ZSzTJrrEx0vD30/duhHJ+Wd3fafM80d8Kc3te3m4oolxGY7OGbSwiQ
         eC59m3zuv1dDkxVhmDr20aITERDls8sqiYsbos9a++l5OKmNpWQQOHxJevh67BNAFZC0
         UqTd+wuxm7fOC25ge1dTQK9WChEIqPW1ePS4NJuY6qIbdnKH14KUDshdfka8knWO1cLz
         krLOnrsAyCVCGw//TRc8dnqUmnk8NkVcVa/AzWU8Gq8Q8uWbAsoMSrQTn+hrGMq4+cGu
         ff6aw0ZrKmx7SRdOgYAdmy7w7dDC7uRuV1C/mDS7kiKlCAcrI6jDBGZxveAs78nTRf3/
         xrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6rCtHdzYgVTzWbWwvY8R1K3tYk8i64z1/WICkBQypg=;
        b=G5TVj6bmcI3oHnAffS9HsNGTMC5BVvB9ltXaIyVEgEaQgCTBKT/C7JNkRwKAx3MC1U
         n3XNecqbjphjnRCHmgA3vosespGMg+8IAKXBG4A5gOoBQSQQo6HrjnjbsFvCPgPC/iTI
         FbcXx+mvKnJI61DwwduPGuN7Mv9FlVSHiGLjCowb+Xw/vYX4QxtD2qaFxbwrYFNJBjuR
         ZzcxweuSlrb6dtQngmwcp9guti1nmrf8sgXWQRYnhWOLb81R7TBWt6D67sGKZg0NUA1r
         ATmBM9kdiBpNz75C6ObEMiXgjB6lpGwBX2Zb4d5JjvPw98LAQOLfa4OTFKlLJdYZRCVA
         6hIQ==
X-Gm-Message-State: AOAM533ilLA+PbyrfwXWB6pb1pusexsE6spw9HWG6n5FVpVwyY6vq9kv
        vJyLzaacEhw+kt3GOLti7t0=
X-Google-Smtp-Source: ABdhPJzYomS++UZq7B9AU/LLOQSOLn5TK5O5/yT/MVyeScO+nDKczn1auJCsaZ7nsxU418j+eGRbvQ==
X-Received: by 2002:aa7:d398:0:b0:419:d011:fe8b with SMTP id x24-20020aa7d398000000b00419d011fe8bmr25199612edq.168.1648895636412;
        Sat, 02 Apr 2022 03:33:56 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id ka22-20020a170907921600b006e4c1ab0bbdsm1886965ejb.207.2022.04.02.03.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:33:56 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 0/4] Remove usage of list iterator after the loop body
Date:   Sat,  2 Apr 2022 12:33:37 +0200
Message-Id: <20220402103341.1763932-1-jakobkoschel@gmail.com>
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

Sorry, I corrupted the Subject line on the previous send, please ignore :(

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

