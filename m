Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83B5356EB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbiE0AA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiE0AAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:00:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9669FD0F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:00:22 -0700 (PDT)
Received: from sequoia.corp.microsoft.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 08A0320B71D5;
        Thu, 26 May 2022 17:00:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08A0320B71D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653609622;
        bh=fd3AmZ5c2EXp0lmLUJ+sKREKqjhalZD5/f8lKuTHF04=;
        h=From:To:Cc:Subject:Date:From;
        b=qJlGTFzmxbhCAfoUYXyQLf7yxV9+Iz1ehzDKm+m5Y5ApGFNte7W+R061JcEXZkQ4a
         x6KxIV9If17zFo0QtHclwlk1HiQichWF2Nq6lgG9KiavxCUglCzcHxUJ4wn2aa1sRW
         jVDpMWhqPnbTznn/FsYMgkFbYX/NGX7d+OGEZSDk=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] 9p: Fix refcounting and improve readability in lookup
Date:   Thu, 26 May 2022 18:59:58 -0500
Message-Id: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Simplified the first patch, by removing code cleanups, to reduce churn
  and minimize regression potential in stable trees
  + The resulting changes are *identical* to the v1 submission when
    patches 1, 2, and 3 are applied
- Added patches 4 and 5 which are additional, minor code cleanups
v1: https://lore.kernel.org/lkml/20220525182530.266068-1-tyhicks@linux.microsoft.com/

The primary motivation for this series is patch #1 which fixes a
refcounting issue in the path walking code of
v9fs_fid_lookup_with_uid(). Userspace can cause fids, which are created
for use during lookup, to not be clunked and make the mount unusable.

The remaining patches are code cleanups to improve readability. They're
not critical.

I tested v1 and v2 by running fstests against 9p inside of QEMU to
ensure that the results were the same as without my changes applied. I
also backported patch #1 of v2 to linux-5.15.y (v5.15.32) and ensured
that the 'fid not clunked' issue did not occur when running against the
Windows Subsystem for Linux (WSL) 9p server.

Tyler

Tyler Hicks (5):
  9p: Fix refcounting during full path walks for fid lookups
  9p: Track the root fid with its own variable during lookups
  9p: Make the path walk logic more clear about when cloning is required
  9p: Remove unnecessary variable for old fids while walking from
    d_parent
  9p: Fix minor typo in code comment

 fs/9p/fid.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

-- 
2.25.1

