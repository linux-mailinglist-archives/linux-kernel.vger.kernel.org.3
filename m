Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7317851D104
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378423AbiEFGH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389349AbiEFGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:07:17 -0400
Received: from mr85p00im-ztdg06021201.me.com (mr85p00im-ztdg06021201.me.com [17.58.23.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BA66208
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1651817010; bh=0uSvfs9Z2v7njRGJQViLybeKzFVsrwm01hOR+kgXElc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=EUdQrxktd8AJnT09qpyCtwfFvowE28/1Oz2gh/Try2FQYKgGMAXZ2DKHiHHxANHyY
         nIXq4h4H77XlR42Q4WE9FAlizpoQwMUsEr9gEoQD5xjcTSa+zaVeLxWByXyrTyXiOK
         eGrOuGzTiAd5SrPM7LctxoeOl2y0xc4voXgTNURV1QGZLH0h95nYOvXwr2PLstmokp
         /Yq4428xxRoo/BY7ax3hhe9Eca7NeH1UEOl8mX7XJiBOkMmBmsvOnRRMqPOSVi8Xq4
         Msl2B+UmnTkUzaxUBoE5mcJ5BO4FPnls7DBR2Mkc+xLGosMjoMijSyVNJ+0fS5RFW6
         0549l+DNuOYwQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 2BA593208D8;
        Fri,  6 May 2022 06:03:30 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, corbet@lwn.net,
        Dan Moulding <dmoulding@me.com>
Subject: [PATCH v2 0/1] Allow setting hostname before userspace starts
Date:   Fri,  6 May 2022 00:03:09 -0600
Message-Id: <20220506060310.7495-1-dmoulding@me.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V7SvW3eXVQsdKv4GqDoxCloxC7_-oHS2
X-Proofpoint-ORIG-GUID: V7SvW3eXVQsdKv4GqDoxCloxC7_-oHS2
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=3 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=156 spamscore=3 malwarescore=0 mlxscore=3
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

v2:
* Use strlcpy instead of strncpy to eliminate W=1 compiler warning
  (assuaging it from its string truncation fears). Thanks to kernel
  test robot for finding this.
* Move "hostname" after "hlt" in kernel-parameters.txt (I promise I
  know my ABCs).

Dan Moulding (1):
  init: Add "hostname" kernel parameter

 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 init/version.c                                  | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.35.1

