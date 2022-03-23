Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856BD4E4D37
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbiCWHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiCWHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:19:51 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D1B72E12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:18:21 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22N7ICB9014462;
        Wed, 23 Mar 2022 08:18:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 0/2] nolibc: fix two build issues at -O0
Date:   Wed, 23 Mar 2022 08:18:05 +0100
Message-Id: <20220323071807.14413-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

please find in this series two build fixes to apply on top of the series
you've already queued:
 - gcc errors at -O0 because it doesn't eliminate non-inline code and
   keeps the reference to the external "environ" from getenv()
 - clang fails at -O0 because __builtin_strlen() calls strlen()

I don't care about optimizing at -O0 by definition but at least it should
build and work correctly! I've verified that rcutorture still runs.

Thanks!
Willy

---
Willy Tarreau (2):
  tools/nolibc/string: do not use __builtin_strlen() at -O0
  tools/nolibc/stdlib: only reference the external environ when inlined

 tools/include/nolibc/stdlib.h | 22 +++++++++++++++-------
 tools/include/nolibc/string.h | 11 ++++++++++-
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.35.1

