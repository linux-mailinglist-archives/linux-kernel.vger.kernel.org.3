Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523DA48EF40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbiANRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:33:03 -0500
Received: from foss.arm.com ([217.140.110.172]:36206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238659AbiANRdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:33:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CEF6D;
        Fri, 14 Jan 2022 09:33:01 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.38.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7ACC23F766;
        Fri, 14 Jan 2022 09:33:00 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] coresight: Fix TRCCONFIGR.QE sysfs interface
Date:   Fri, 14 Jan 2022 17:32:53 +0000
Message-Id: <20220114173254.1876151-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was working on refactoring some of the magic numbers for the register
accesses and I saw this issue with programming one of the values.

I don't have any evidence that someone encountered it not working, probably
there is no hardware where QSUPP==0b10, or it just didn't get used yet.
But the issue is that this silently writes a reserved value even if the
user provided one was correct so it might ruin someones day if it ever
comes up.

It's a small change so I didn't see the harm in fixing it.

Applies to coresight/next f9809d565135

James Clark (1):
  coresight: Fix TRCCONFIGR.QE sysfs interface

 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

