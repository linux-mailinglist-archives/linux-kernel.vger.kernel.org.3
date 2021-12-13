Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1D472C12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhLMMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLMMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:13:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so52063132edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3YHcdlMvuKgq7HaJmpfp0QyKXxqSrxecQL/MMOxBX8=;
        b=hgSnPAnmPDu+2DHilBic/sXva+two2ZfG9arjT6Aq9Q2DBR0lh/VsBO1WMXWl2vIVl
         P0QvHeE6UohrBzAL8C3rUo2zGHWUvpFZvfwrUiO/bkntfA6TBxhj7vDi2pEmQH4iou8Q
         ufjf5cIkm205uDOtYBln1aTtRv6aKaqdjQ5cQF80xiHc6I5fJysUNifRBKqz2pLAHM3i
         aSDEo6s1juDd3yHByMTe/OIhBVUquhCKnCaVx+QmhPii6cDN3FMGRQqayCFRo1EpZ8kd
         x0tgHrD1/su/TaSHu9EbneK65K2u6TxgJgLq0hTrSwiI3IflkUG++uxPsEYYnM1LEKvu
         zlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C3YHcdlMvuKgq7HaJmpfp0QyKXxqSrxecQL/MMOxBX8=;
        b=7FIpokdmi28ULBvMBD3zud8zPyJsri+dJDIEkGBP3qJzb05Ju3E7Gr7MSrNzzEBDxp
         ME1H8rkcV2MCyNzRbosieixfsO4QyfKNSSJBhjcDYk6M1S6UiV+Ir8YrmIEd3eItgBZN
         81HU3S+23oV8UTAQrz/cuQUhiiv3CNwMd3KrFExm9qJsNe7itu+ht/FyXKN+6jCcS0xW
         acpegRBQSo53TV9BdX1mFgVObDi5F0ElyqFCzfR64pPq4tK12ujcFAngusiReaz9zPEg
         OctBoG84W46x7M+TPBx1sLWvux+FqWP2ic+1uDv561D8ITF7QYcsHH9iHW3ue3IGe0E6
         rYQA==
X-Gm-Message-State: AOAM533sFJXItxW6tTUbq6A4Lvr4zHu5AZSJForWU2noYqKGatVFwOEX
        4qch+lcCl04YqTjlg2qwJoXZ8A==
X-Google-Smtp-Source: ABdhPJy0KIN7Gv+pjJ0V1cN7GadCR23vOqjlswFJhkPKhj+o88vyEwM+f99Mb5hfYuYxJ2EqDLrZhw==
X-Received: by 2002:a50:ee19:: with SMTP id g25mr65845189eds.162.1639397627880;
        Mon, 13 Dec 2021 04:13:47 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id gn26sm5725814ejc.14.2021.12.13.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:13:47 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] coresight: etm: Correct PID tracing for non-root namespace
Date:   Mon, 13 Dec 2021 20:13:19 +0800
Message-Id: <20211213121323.1887180-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a profiling program runs in a non-root PID namespace, if CoreSight
driver enables PID tracing (with contextID), it can lead to mismatching
issue between the context ID traced in hardware (from the root
namespace) and the PIDs gathered by profiling tool (e.g. perf) in its
non-root namespace.

CoreSight driver has tried to address this issue for the contextID
related interfaces under sysfs, but it misses to prevent user to set
VMID (virtual contextID) for kernel runs in EL2 with VHE; furthermore,
it misses to handle the case when the profiling tool runs in the
non-root PID namespace.

For this reason, this patch series is to correct contextID tracing for
non-root namespace.  After applied this patchset, patch 02 doesn't
permit users to access virtual contextID via sysfs nodes in the non-root
PID namespace, patch 03 and 04 stop to trace PID packet for non-root PID
namespace.

This patch is dependent on the patchset "pid: Introduce helper
task_is_in_root_ns()" [1].

[1] https://lore.kernel.org/lkml/20211208083320.472503-1-leo.yan@linaro.org/


Leo Yan (4):
  coresight: etm4x: Add lock for reading virtual context ID comparator
  coresight: etm4x: Don't use virtual contextID for non-root PID
    namespace
  coresight: etm4x: Don't trace PID for non-root PID namespace
  coresight: etm3x: Don't trace PID for non-root PID namespace

 .../coresight/coresight-etm3x-core.c          |  4 +++
 .../coresight/coresight-etm4x-core.c          | 10 +++++--
 .../coresight/coresight-etm4x-sysfs.c         | 30 +++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.25.1

