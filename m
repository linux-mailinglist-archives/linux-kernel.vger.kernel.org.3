Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1D4A9BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359666AbiBDPYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiBDPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:24:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE17C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:24:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 192so5389777pfz.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkiUUzVe9i6a+fIe7hk2GiLZxTBYFSj52q9QJFu9QnI=;
        b=foc/ui1c4BJKma1LKd5zOOnJH+mPze1ao2DbylYdX/0nYGsd6480mFYgd+FVOWx35l
         PS6Ld5328J8MTOA8hx9L3xZeBXcwoIbjBo2OXHozNZUoQAO4oAbkP+DfrrtHd70dSTSy
         dkdZAmn6w2GhMGUQlEpUp89NoeVI2s+IHInUcPVzUTq4l5kEvbEfHtnmveTTwf9WSfxQ
         gH0NIVFREsgOt6s772SSlG3cWoFg8CKDG9AeYGrp3Kv3uMqjiqn3blKac9P6+jBCRv5F
         pQ169oQ+EFFA+KuD7e31e2ngFbGkFiCHXib2WlI1VYQvSd7KNXeM7Eut/wWsEOlgILD+
         +xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GkiUUzVe9i6a+fIe7hk2GiLZxTBYFSj52q9QJFu9QnI=;
        b=zfbIaSh06fjVLPZwVJ+KdlW21k4VaYY3FQtUW5uSoSNCDlfsd2CcdxmiM3Zounr4Sl
         ft+fQRHSDPtCLih8MFazue/aLubky3wNZmQC97vHF3OCFEqB8ARHRJAaFteSMniFRxR3
         WHZPXD/V1WswOVgrE+ClVRRKQOKrUFy2xNRBtWYHCHSG49FHIcgv9KF+RtmZ4K0581DH
         gboB++M40BiC4n7D7AokGmRvgTD3/JjffYRLu0QJQHZ5SHqBrRB3Yn8kUD+cM1NPPHlr
         CZQar8VoD4Ju8vZ6UFZOtMO4sGvjbPbQLA4j/9hPhKU5yLJBNSaWpP/a2uFAn7fEOFkl
         ToCw==
X-Gm-Message-State: AOAM530XJ7Us7R8d0cBAyNX4wUveWsn/pWRBoNZByYYul2Q1kzoIdVxt
        JBBegwQ1OziaZ1cZUvbGGhgl8Q==
X-Google-Smtp-Source: ABdhPJxQTBk63Vvx4oy3McBFhLF0eUpHd3o6yJJxbrx1IcK15Pg2Rnh3RlZ1DlSTf96iEx9KyTrK5g==
X-Received: by 2002:a62:7a50:: with SMTP id v77mr3595642pfc.4.1643988263135;
        Fri, 04 Feb 2022 07:24:23 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id me4sm14237079pjb.26.2022.02.04.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:24:22 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 RESEND 0/4] coresight: etm: Correct PID tracing for non-root namespace
Date:   Fri,  4 Feb 2022 23:23:59 +0800
Message-Id: <20220204152403.71775-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a profiling program runs in a non-root PID namespace and CoreSight
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

This patch series has been rebased on the mainline kernel and applied
cleanly on latest commit dcb85f85fa6f ("gcc-plugins/stackleak: Use
noinstr in favor of notrace").


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

