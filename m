Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9F490C22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbiAQQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:10:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51308 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbiAQQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:09:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B7216111A;
        Mon, 17 Jan 2022 16:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1E3C36AE3;
        Mon, 17 Jan 2022 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642435787;
        bh=JxpNXSlQMmHd0k4NTwu6UknzIMZN4MLp9hQbzYlBdkQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pn4SHXuktfY32p4Tip/BGRjm0C6WTtja6PqSPJRFqKzbwdNvz1D6ht/Iuf7T6P+n6
         qs4URseAxH6/lXkO8Q0bgm+p6VPa4Pq4+imeCyXuipsLzggvAu85s/Gc+ZRzf1hKV0
         eRtNXUQA/5s0fwceHNxJgGS1msjwSUsbDQ/0ghtlMgJKNK+73i6cjB3+Ds3PTKrDNr
         Eu7DcSOMx/s2p/1eQja5VRVhsOEkpgvEorDhIXcl5rQUYvU0Y+WhU8RPqNom77qEXl
         nDb9nns/Z1/RIaJR7prUwQH3/O+ei8+OOt81ZR9ubNw+wAwLiEMgwnQ48y97/1ruiH
         grrKkhr8FFqjg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/4] perf tools: Remove needless affinity setup/cleanup for pid targets
Date:   Mon, 17 Jan 2022 13:09:27 -0300
Message-Id: <20220117160931.1191712-1-acme@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Continuing with the removal of needless affinity setup/cleanup
for pid targets, please ack.

- Arnaldo

Arnaldo Carvalho de Melo (4):
  perf affinity: Allow passing a NULL arg to affinity__cleanup()
  perf stat: No need to setup affinities when starting a workload
  perf evlist: No need to setup affinities when enabling events for pid
    targets
  perf evlist: No need to setup affinities when disabling events for pid
    targets

 tools/perf/builtin-stat.c  | 17 ++++++++++-------
 tools/perf/util/affinity.c |  8 +++++++-
 tools/perf/util/evlist.c   | 28 ++++++++++++++++++----------
 3 files changed, 35 insertions(+), 18 deletions(-)

-- 
2.34.1

