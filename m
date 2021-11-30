Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC964628D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhK3AJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhK3AJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:09:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:06:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38BF7B80954
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 00:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522B7C58321;
        Tue, 30 Nov 2021 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638230779;
        bh=lYhzlhKARfaov7ychHRylbwZBTbCYlOzT1a2yNoU1h8=;
        h=From:To:Cc:Subject:Date:From;
        b=RACxxlvC1VspiNCZYubIkHNtf0IsNWwZ0lA+AE1L7OpKnpYfFGRAfEOEsai7D0d9h
         oEMbU6HZtQBMVn8cQKcNSvRHjRO6P5S7op0luKg2/hEnyk7AA55r186Llc5znSBJuY
         fwNJQrkLHHpoUndKQ7RrQc2E8pAWUTrTWejfWKyQT9x0v1VgP8pGTWGz7XmH09Bq8O
         qLIdKcgXKY7Kqmz+chvoTgWT1YZLIPt+jJ4eeHYvBd+MHEt8dCJ5M80ynIHfW5xc5I
         ezmRUY4YT4jsPLARQOnQwOHxcSznyw/sMeakbkUY3hUCBU8cxHMVISCFmbagAzn0+9
         d5+LXBBbXWNlA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [RFC PATCH 0/2] workqueue: Fix hotplug races
Date:   Tue, 30 Nov 2021 01:06:10 +0100
Message-Id: <20211130000612.591368-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While triggering rcutorture splats, I couldn't trace down to the exact
cause due to the issue being tracing-unfriendly. But looking at the code,
those two potential races look like plausible causes and also after
these two patches, I couldn't reproduce the rcutorture issues again (yet...).

Frederic Weisbecker (2):
  workqueue: Fix unbind_workers() VS wq_worker_running() race
  workqueue: Fix unbind_workers() VS wq_worker_sleeping() race

 kernel/workqueue.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.25.1

