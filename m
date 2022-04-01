Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F84EFC9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353216AbiDAWKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353139AbiDAWKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:10:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574712655E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:08:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x31so3804487pfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQPlkPcSMk1OtK2B+HGYKgzX/t3c5CVpNSfLCeGwYXI=;
        b=dG88sPBlup1MSm9nY78qOebtBoPpzhYqUeBvwUkyVK46goi1rVQ9sWZrkkaDk+A81b
         dA5Stj4uj5WPcOOpA/Dy7qScOVWyEi+K2RqsVeVYZLEDANUtPv8Xwjze5Gydz4ft5fY9
         1S2VO7V5dKB9bfQrbaCEAjy+U12x8+/SmkNK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQPlkPcSMk1OtK2B+HGYKgzX/t3c5CVpNSfLCeGwYXI=;
        b=0lE6NBb4STgqXiQS2gMuKesSOzHK6RGvV4WngtYuwZ337zRnFBOornBim/ImZT8ds2
         EFj4ZYU3nM+NPELu362on8GcTFYeo8XOiKfslq5lKzjmIhYkng+jUbnoqS08HzmKo7KB
         LwspaE9LkbdQVdReNN/zN/E+tarw4Q/zk0bIRrmhZ/A7RzTHYW74EeiX+IXLkKZ/zdsg
         +vtbYIj8uwkzyi8FUb0nFENVPRJCidLpjMT+J8NHmlHLp4R7yc0VRNhx17xwTPYS/dR4
         qp/49reLRkjI64kFjPDPnKyYdeRp+n7aOyYcj0S9v0zJORrmpP6rX1MTPHoTTuNPKCyz
         9hRw==
X-Gm-Message-State: AOAM530Hil2e0/rbqhSdvCF8/j5WfUt5y0LN0Hv6orQGoSEKw11M1yTB
        n31eppLtW3Yic0SFPxFZx0PQQw==
X-Google-Smtp-Source: ABdhPJxvgW2qJP/ewXdKfwTHyjObLD8DK6BW6HrEsNMpdZTGoja3sQD+JEnu+gxM4YT3YXp/K661fg==
X-Received: by 2002:a05:6a00:e0b:b0:4fa:a167:5b35 with SMTP id bq11-20020a056a000e0b00b004faa1675b35mr13034747pfb.69.1648850926838;
        Fri, 01 Apr 2022 15:08:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:72c9:527e:d936:c24b])
        by smtp.gmail.com with UTF8SMTPSA id f6-20020a056a00238600b004fae79a3cbfsm4382043pfc.100.2022.04.01.15.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 15:08:46 -0700 (PDT)
From:   Daniel Verkamp <dverkamp@chromium.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH 0/4] mm/memfd: MFD_NOEXEC for memfd_create
Date:   Fri,  1 Apr 2022 15:08:30 -0700
Message-Id: <20220401220834.307660-1-dverkamp@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default file permissions on a memfd include execute bits, which
means that such a memfd can be filled with a executable and passed to
the exec() family of functions. This is undesirable on systems where all
code is verified and all filesystems are intended to be mounted noexec,
since an attacker may be able to use a memfd to load unverified code and
execute it.

Additionally, execution via memfd is a common way to avoid scrutiny for
malicious code, since it allows execution of a program without a file
ever appearing on disk. This attack vector is not totally mitigated with
this new flag, since the default memfd file permissions must remain
executable to avoid breaking existing legitimate uses, but it should be
possible to use other security mechanisms to prevent memfd_create calls
without MFD_NOEXEC on systems where it is known that executable memfds
are not necessary.

This patch series adds a new MFD_NOEXEC flag for memfd_create(), which
allows creation of non-executable memfds, and as part of the
implementation of this new flag, it also adds a new F_SEAL_EXEC seal,
which will prevent modification of any of the execute bits of a sealed
memfd.

I am not sure if this is the best way to implement the desired behavior
(for example, the F_SEAL_EXEC seal is really more of an implementation
detail and feels a bit clunky to expose), so suggestions are welcome
for alternate approaches.

Daniel Verkamp (4):
  mm/memfd: add F_SEAL_EXEC
  mm/memfd: add MFD_NOEXEC flag to memfd_create
  selftests/memfd: add tests for F_SEAL_EXEC
  selftests/memfd: add tests for MFD_NOEXEC

 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/memfd.h                 |   1 +
 mm/memfd.c                                 |  12 ++-
 mm/shmem.c                                 |   6 ++
 tools/testing/selftests/memfd/memfd_test.c | 114 +++++++++++++++++++++
 5 files changed, 133 insertions(+), 1 deletion(-)

-- 
2.35.1.1094.g7c7d902a7c-goog

