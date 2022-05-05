Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE351C7E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355303AbiEESc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384135AbiEESX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:23:57 -0400
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE6B5EBF1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1651774030; bh=vV23b489VnzdeEn4Z7rQnBMy0kazXjtap6IBmGHeeE8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=DwS7D4ptU2KXBmq0w02Ka2EqgTtUKV656G6JlQgYSAYw8k87Io2+joE37XcH+GGKJ
         ChDTo4Hu1RvjPBMcnl6Ewhw2eBnoPwN7fDGO5KdgtfAlkw1bnF0eFgfvJgyLSVtne7
         bs84FoM+oMr0MGIiQ0iqkq2hyAWYzH1Ffej0a57nI1EjQNXhxxtb2rKGJ0j0hEV+xb
         OaknqB/HKhZnt5Wu3UPs+gwWsjd8UTUyEJ+mY/fjr1qmdgBS3hisRAXQ5TnA4QYLpt
         YBI0bW9gZfQ7c1UtoCWQ5SMMNAnSRebmDEvFjGg/fy+LM83Iz8dmbTyVeVJn37zT21
         Q7c1ASv5CJ6WA==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id 955A280C8E;
        Thu,  5 May 2022 18:07:09 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, corbet@lwn.net,
        Dan Moulding <dmoulding@me.com>
Subject: [PATCH 0/1] Allow setting hostname before userspace starts
Date:   Thu,  5 May 2022 12:06:50 -0600
Message-Id: <20220505180651.22849-1-dmoulding@me.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7yxFzX1JusZoB8njsR0L-PwOAlnBWngT
X-Proofpoint-ORIG-GUID: 7yxFzX1JusZoB8njsR0L-PwOAlnBWngT
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=414 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some userspace processes may rely on gethostname to always return the
correct machine name. However, the only way that the hostname may be
set is by some other userspace process calling sethostname
first. During boot, if a process that depends on gethostname runs
before sethostname has been called, then the process that called
gethostname is going to get an incorrect result.

A real-world case where this comes up is with mdadm, which if
gethostname returns the wrong name, can cause local md-raid arrays to
appear to be foreign arrays. This can alter how mdadm assembles the
array, or can even cause array assembly to fail. I imagine there are
probbaly other real-world cases where undesirable behavior results when
the hostname is not set early enough.

I'm proposing adding the option to set the hostname from a kernel
parameter, so that the correct host name can be guaranteed to be set
before any userspace process can call gethostname.

I can imagine an even better way to do this would be to have the
hostname written to some non-volatile storage (like a firmware NVRAM
variable or such), which the kernel could read out during early
boot. But, alas, such designs require hardware support, standards, and
cooperation. This proposal is an alternative that can provide a simple
and immediate solution.

I'm sending this to linux-kernel since I don't see any list that's a
better fit. If there is any other I should send to instead, please let
me know. (linux-doc also included since kernel-parameters.txt is
touched).

Thank you for consideration,

  -- Dan

Dan Moulding (1):
  init: Add "hostname" kernel parameter

 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 init/version.c                                  | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.35.1

