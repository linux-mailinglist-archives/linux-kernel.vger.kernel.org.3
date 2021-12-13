Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6C4732AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbhLMRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhLMRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:09:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B1EC061574;
        Mon, 13 Dec 2021 09:09:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C9A61195;
        Mon, 13 Dec 2021 17:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63ADC34602;
        Mon, 13 Dec 2021 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639415342;
        bh=ZY1m73DqRlXHz+HFBb1Uyp1tXrtkhC+V+AX5RHWZcok=;
        h=From:To:Cc:Subject:Date:From;
        b=QRFgEwJYhZGtTiymHR5pC+xfO7IxtIXjej3+2kL6CsLIVy64tVGyzMRrMT9mvx/x5
         pMZgzKYp85a7dQGZs4S4YPigiyvyUgS1+MdFOTp9U8wLlUHcQjJcBj87lWIAlNFbdf
         H8Y8Yudbu+9pymjtlX/WRM+I+23albUgZkOCg/F0esvsTxWYMqvZCwkc6mwgMw4vb3
         oMZ9RqGIWroMETXE3NEKoBV2qnT1HL8RaCFYpZFBQ/qWwJpsgp7GFLceyOYkxxUAPJ
         u63GAIvT2iIOg487HyGddd9YB6XR+yRbcHOsQ8kCO8xG80+1Gb1hcvegyoly6qlxn5
         FC4+6B/5d2ovQ==
From:   broonie@kernel.org
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Date:   Mon, 13 Dec 2021 17:08:50 +0000
Message-Id: <20211213170850.3724776-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the tip tree, today's linux-next build (x86 allmodconfig)
failed like this:

In file included from /tmp/next/build/drivers/gpu/drm/i915/intel_device_info.h:32,
                 from /tmp/next/build/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h:11,
                 from /tmp/next/build/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c:11:
/tmp/next/build/drivers/gpu/drm/i915/display/intel_display.h:643:39: error: 'struct pci_dev' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  643 | bool intel_modeset_probe_defer(struct pci_dev *pdev);
      |                                       ^~~~~~~
cc1: all warnings being treated as errors

I didn't investigate too closely exactly which commit caused this and
fixed it up as below:

diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
index 4b688a9727b39..377790393a855 100644
--- a/drivers/gpu/drm/i915/display/intel_display.h
+++ b/drivers/gpu/drm/i915/display/intel_display.h
@@ -57,6 +57,7 @@ struct intel_plane;
 struct intel_plane_state;
 struct intel_remapped_info;
 struct intel_rotation_info;
+struct pci_dev;
 
 enum i915_gpio {
 	GPIOA,
