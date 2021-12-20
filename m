Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9F47A8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhLTLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:43:40 -0500
Received: from foss.arm.com ([217.140.110.172]:52884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhLTLnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:43:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0B61042;
        Mon, 20 Dec 2021 03:43:39 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.37.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0D463F718;
        Mon, 20 Dec 2021 03:43:37 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 0/3] Fix stuck overutilized
Date:   Mon, 20 Dec 2021 12:43:20 +0100
Message-Id: <20211220114323.22811-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overutilized signal indicates when one of the CPU of the root domain has an
utilization above a certain threshold (0.8 * cpu_capacity). Its sole purpose is
to disable EAS on asymmetric CPU capacity systems in favor of CAS. Under certain
circumstances, described in the following patches, this signal can stay stuck.

The two first patches of this series intends to fix this blockage, while the
last one is an improvement.

Vincent Donnefort (3):
  sched/fair: Make cpu_overutilized() EAS dependent
  sched/fair: Fix newidle_balance() for overutilized systems
  sched/fair: Do not raise overutilized for idle CPUs

 kernel/sched/fair.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.25.1

