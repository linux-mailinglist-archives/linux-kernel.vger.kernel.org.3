Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4C49EE00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiA0WRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiA0WRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:17:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E57DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:17:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a4-20020a5b0ec4000000b00615dc8c1623so8628218ybs.17
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ng6cTnLsuAPZewV+DZLtymIbJ2l6/2ZMklzgx9Cf0/E=;
        b=aK/uxtVw3OVb2dfiyvGRFtaOYM/RkdPdMTza1qGmRpTkHkeNBvFnSi1NqZ7CJB3hlx
         reiYlNPTlH7W+O4I3DUE5P4t4Y7MPVK0GBODfqdNRdrNTwgTlKDgcpQ57IzwQGNKIIFh
         HkIXxsBkFeWBza5Pg4eqZgxHmDJ5sZQXSjo9i5W5fIlD32ALqRHzqzRFaqIcR2sC65Gu
         C9JTjOchtXDWBG3EGrqC6OwY2BdgDe+3u5ZzZgCD9IAmmIfQ+CY0zVFqNoUQU6DMc27g
         IbvGnFgT2sU7ylJShQhwQZiE1ogIiZsnJdZqpuGTxKgCbg0RyDRTgrGCpr6tOm8UjMLt
         4+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ng6cTnLsuAPZewV+DZLtymIbJ2l6/2ZMklzgx9Cf0/E=;
        b=jeoyDJ5VE86As3FdqeqfeYTHdkFKaj93u8bXg5FEXZhIpW4iOkmoY3/2P5qzaIBPJO
         HMIg7OquRT3B3J+Ejf5el246xYXBaQD/hmDiUHbZMD1xMYMK4tA7u1gdHMzkS1e81ujW
         IPuWMlorAhpXRmB8Cwpp981QBr+9z3TIceM7FWjwSr39Ga+c/F82l2NmkHF67Ce4P7Eu
         wY8DAAP+sV7RXBl3U+rD5i0ZAHIbmr7UWUq/itn6fCU1G4MrfYXi6CogUexV1Sz0MOLJ
         AHM6fqm1aVr++b8VdwfTjIOxhU5eS7WPpsX9Gb7coNg5wuArHWjMJJDaeoWjg4dM5xCj
         l9kw==
X-Gm-Message-State: AOAM531Jxl+fM4dgIfbH3v6B+mZxFkyKFfBLujRTrHK45K01H10SwzbF
        k9WOLFpn5SwBUO7tumasjM7YwRLvQPdocw==
X-Google-Smtp-Source: ABdhPJx3O5plmb71BP71pNiAZH1OVetV56XjM5wtIeRSySbzFeJk2kmTSjN+rzssphFCL5a7G96JJ/WrjZjobg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5484:2aa:f5f4:a1e0])
 (user=dlatypov job=sendgmr) by 2002:a25:cf01:: with SMTP id
 f1mr8060763ybg.389.1643321838253; Thu, 27 Jan 2022 14:17:18 -0800 (PST)
Date:   Thu, 27 Jan 2022 14:17:10 -0800
Message-Id: <20220127221710.165733-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] kunit: fix missing f in f-string in run_checks.py
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're missing the `f` prefix to have python do string interpolation, so
we'd never end up printing what the actual "unexpected" error is.

Fixes: ee92ed38364e ("kunit: add run_checks.py script to validate kunit changes")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/run_checks.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 4f32133ed77c..13d854afca9d 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -61,7 +61,7 @@ def main(argv: Sequence[str]) -> None:
 		elif isinstance(ex, subprocess.CalledProcessError):
 			print(f'{name}: FAILED')
 		else:
-			print('{name}: unexpected exception: {ex}')
+			print(f'{name}: unexpected exception: {ex}')
 			continue
 
 		output = ex.output

base-commit: 6125a5c70acddd9fc1fb7329047a254c74d0173c
-- 
2.35.0.rc2.247.g8bbb082509-goog

