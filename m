Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5044E5FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348805AbiCXIJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244942AbiCXIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:09:00 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414B9A9AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:07:29 -0700 (PDT)
Date:   Thu, 24 Mar 2022 08:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1648109245;
        bh=UNIlZtorBwDxmxW7dS0fY2nCfeZ/SRYko7r9l5a3fkc=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=Agy+j2pw3E1W0niYTL0ODqrCtAIxleKJxvowAEkv2bDfHSQ67MdHP9IQ7GAVGIUin
         VesPVK7cE1WOKnO2pt5W/NyOUAOAfvAqdlVccATAFMr63g+iwS1YM8Q7oFk3wWgZg/
         p1cbCVZz4YqWnmEZun11/vutRDBHafuaGha2cNCklzGG4/SILE+tFUDWnHbMANiPiR
         1lOh8LHDETRq2KSgqO4FjE4L+d13NaN/00sYa6YtlD17xEN1C2H1SfA2aAGn5ErGr8
         PcICyWP7BFK0Dkov8hLSbMDGI3mEMXA9+nRG/GeEb8rEYbr+w5WKyIcsMQiIu4u5UT
         noaVKJ+6xKI4A==
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz
From:   David Cohen <dacohen@pm.me>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Cohen <dacohen@pm.me>
Reply-To: David Cohen <dacohen@pm.me>
Subject: [PATCH v3 0/2] PM: refactor pm_pr_dbg() to support dynamic debug
Message-ID: <20220324080653.454333-1-dacohen@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently debugging an issue with s2idle on my laptop where in a
rare occasion instead of sleeping, it gets stuck in an infinite loop.
The pm_pr_dbg() is placed on very useful functions and it helps me to
debug it, but the current all or nothing enabling mechanism with
pm_debug_messages_on flag is causing the suspending mechanism to be
disturbed with so many debug messages to the point it becomes extremely
difficult to reproduce the issue I'm debugging. More granularity when
enabling pm_pr_dbg() in this case is very welcome.

These patches I'm sending introduce dynamic debug support to pm_pr_dbg()
while still maintaining the pm_debug_messages_on flag behavior if
dynamic debug is not used.

Regards, David

---
David Cohen (2):
  PM: narrow down -DDEBUG on kernel/power/ files
  PM: enable dynamic debug support within pm_pr_dbg()

 include/linux/suspend.h | 44 ++++++++++++++++++++++++++++++++++++-----
 kernel/power/Makefile   |  6 +++++-
 kernel/power/main.c     | 29 ---------------------------
 kernel/power/process.c  |  3 ---
 4 files changed, 44 insertions(+), 38 deletions(-)

--
2.35.1


