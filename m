Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84658CC61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbiHHQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiHHQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:50:18 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2618BDC1
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:50:17 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id u5-20020a6b4905000000b00681e48dbd92so4913662iob.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=zLBaz1rNilIGO1w+9okx/7wDlrqzaB/ECodczQmMqDg=;
        b=SXN40bs60VueldknoEZRL/zUqMBFiRjOvb4xJhRznmyY/q9g2eYGWHAywR4iPzWBdZ
         jYKk6cgBVhi18CnymR5cBw1u5UnUUNBsuPV5fwvHrbBChNADVsHh/qwt8qIaYv875CFj
         QxHnBSC6kAsq6SXAQg6Xm/SBtu2+b5suCjkT86tKVQ9Wu3qIR9SNNMyXXO+T4oR0HaB1
         XGEQshCSROF00CTXxEUQoFbTVa2spaxjgM4pgrv9vtZK75OrpIuRtMh45v11QTpnLh1i
         ILJWSq6H2brclpmghkvHvAHIcViBO9laXfCpJ7tST+Jv1a3XlJuL4F8T/7sg4plu94GE
         GNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=zLBaz1rNilIGO1w+9okx/7wDlrqzaB/ECodczQmMqDg=;
        b=hCR/z7y9f+QR2q3WMlulS7qeKt0n2e+N6nw213wUz4H2LEBVCajhcCj9Yr0pParri4
         HHc8ohSWSXujtXRNuHfZYz71nrryuxyWyf2qk177Ci14uTd6Oj7X/iOepiE3XoZmqz68
         +QqXR+WPxfCo8blRoKhHhhle97T7ONbzZJzKw866d3+9QnAecN2m6FD61OkC3e356oeI
         +CLzawfnSiU9PhYG8B9Y8OvkBijIO61tN63DYihQU33/VbpOonOfoaacvbOpTqZ8LEy6
         UrGDHJFZu+uxHd8fLy1IudDnX42qUJum0m1u5Edl0r/qjVxhtZoEKYAV+DF9LDNoLPfv
         YW6A==
X-Gm-Message-State: ACgBeo1YVaCQYVS/Lr2yNYHlZAwTtFGI7/rz892UAvrKGk/3HOe8EfvK
        1ealn2dWH9emQX8qvg508GuvQQfVELNd
X-Google-Smtp-Source: AA6agR6rGaBdFqljWoc2AjWrgUPT0W1bS8nnDdpxj9ZrEccxsyQk44igzgunmGfT413qVkMCkZ2lcPed54ro
X-Received: from bg.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b4])
 (user=bgeffon job=sendgmr) by 2002:a05:6e02:1caf:b0:2e0:cec1:9f17 with SMTP
 id x15-20020a056e021caf00b002e0cec19f17mr4074872ill.5.1659977416534; Mon, 08
 Aug 2022 09:50:16 -0700 (PDT)
Date:   Mon,  8 Aug 2022 12:50:05 -0400
Message-Id: <20220808165006.2451180-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [RFC PATCH 0/1] zram: Allow rw_page when page isn't written back.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today when a zram device has a backing device we change the ops to
a new set which does not expose a rw_page method. This prevents the
upper layers from trying to issue a synchronous rw. This has the
downside that we penalize every rw even when it could possibly
still be performed as a synchronous rw.

This is just a proposal and I wanted to get feedback if people
felt this was worthwhile.

The motivation comes from what Minchan noted in the original
change which introduced the synchronous behavior that it enhanches
swap-in performance by about 45% [1]. So it'd be great if we could
still get this benefit while using writeback.

1. https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/

Brian Geffon (1):
  zram: Allow rw_page when page isn't written back.

 drivers/block/zram/zram_drv.c | 65 +++++++++++++++++++++--------------
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 41 insertions(+), 25 deletions(-)

-- 
2.37.1.559.g78731f0fdb-goog

