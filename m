Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069F2517AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiEBXZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiEBXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:24:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8238B2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:20:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a253406000000b006484c081280so14372121yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UH1XfZjmWNrGFAlQeXLr7/Tn9jAIkuGUATe4oOI798U=;
        b=K8lxNnVJV2nNNR2bjZTLTTcJNcIHJUYlXV6GRGSPb8mpVwpTE0uDSNxLJ37x7XdIkA
         7c4g/6g48Saj5gUCrRd/3Rj8gGG9lWI/O30Oaj8OQnaKge5pU6gilhErbJ/1s3dhWTTj
         jVCB8aMopODYlzr7OoBjNgPRmFnZDh+5d8ajLa880AXO4pyzxsodEQd4NJ7drByormN6
         YGPn3oYgwfJssilvhWGtvms7zgucKbDBq1EPnJIA8+eEhhqyOgwnB3l2jfuSuLSXkhN+
         YSWLfr2xN4rx4KVNnu/lUGJt9jJlXjy9Hak6wJQVWFZyNM/nKUiEzyp1TZEQ4CnSowMe
         231w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UH1XfZjmWNrGFAlQeXLr7/Tn9jAIkuGUATe4oOI798U=;
        b=Ld2++4hoC25UuXa8OFoGqtf2X03c9YpSqLGzhJhF36VVEzCitEhBjoCn+1C7GRzxtX
         8bosKePwQHsEI+zCoQGk1bbdVQ4vGmS3z13RrILSrHD9F1HRKs8LRWvNkrWlA6pb3K5N
         U4wN7YaysmtgDqoItwrcbnYrYOZUMwnYhW1B2xUKUpx77NSo6geQ84xEoZp6uYGMalcw
         Sq4mFemrKP3sh0bldRTJ0NGDCFTxQvpTa/0qOZeEX7CL6CwkT0NjGKRVJyWBuYAHUlI0
         gZ7oRWJq4M5n9aZUPX7HKH3HkJrE4k93WaKygpIxo48dCHmK8MnFyUWleGYd3UsoM7Bx
         2pKA==
X-Gm-Message-State: AOAM530vabIGvIg3Au5ujlKmCXab88JVHV05+z1Jx+JziR+GfXKEDdie
        FSrex9Uwa1nAdEewJfPCM572Gcd9hXpa+5U=
X-Google-Smtp-Source: ABdhPJybHUudCB9D+8ErBhY3Xz9dCSyX1SKKeoUKTX3ComoYu9JNHba5QRe5ZczB4ktdetpR7AyQAy9UB5XyOSM=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:9d90:0:b0:648:75a5:2172 with SMTP id
 v16-20020a259d90000000b0064875a52172mr11887702ybp.319.1651533609145; Mon, 02
 May 2022 16:20:09 -0700 (PDT)
Date:   Mon,  2 May 2022 23:19:35 +0000
In-Reply-To: <20220502231944.3891435-1-tjmercier@google.com>
Message-Id: <20220502231944.3891435-2-tjmercier@google.com>
Mime-Version: 1.0
References: <20220502231944.3891435-1-tjmercier@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v6 1/6] gpu: rfc: Proposal for a GPU cgroup controller
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     daniel@ffwll.ch, hridya@google.com, christian.koenig@amd.com,
        jstultz@google.com, tkjos@android.com, cmllamas@google.com,
        surenb@google.com, kaleshsingh@google.com, Kenny.Ho@amd.com,
        mkoutny@suse.com, skhan@linuxfoundation.org,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

This patch adds a proposal for a new GPU cgroup controller for
accounting/limiting GPU and GPU-related memory allocations.
The proposed controller is based on the DRM cgroup controller[1] and
follows the design of the RDMA cgroup controller.

The new cgroup controller would:
* Allow setting per-device limits on the total size of buffers
  allocated by device within a cgroup.
* Expose a per-device/allocator breakdown of the buffers charged to a
  cgroup.

The prototype in the following patches is only for memory accounting
using the GPU cgroup controller and does not implement limit setting.

[1]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@intel.com/

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v6 changes
Move documentation into cgroup-v2.rst per Tejun Heo.

v5 changes
Drop the global GPU cgroup "total" (sum of all device totals) portion
of the design since there is no currently known use for this per
Tejun Heo.

Update for renamed functions/variables.

v3 changes
Remove Upstreaming Plan from gpu-cgroup.rst per John Stultz.

Use more common dual author commit message format per John Stultz.
---
 Documentation/admin-guide/cgroup-v2.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 69d7a6983f78..baeec096f1d8 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2352,6 +2352,30 @@ first, and stays charged to that cgroup until that resource is freed. Migrating
 a process to a different cgroup does not move the charge to the destination
 cgroup where the process has moved.
 
+
+GPU
+---
+
+The GPU controller accounts for device and system memory allocated by the GPU
+and related subsystems for graphics use. Resource limits are not currently
+supported.
+
+GPU Interface Files
+~~~~~~~~~~~~~~~~~~~~
+
+  gpu.memory.current
+	A read-only file containing memory allocations in flat-keyed format. The key
+	is a string representing the device name. The value is the size of the memory
+	charged to the device in bytes. The device names are globally unique.::
+
+	  $ cat /sys/kernel/fs/cgroup1/gpu.memory.current
+	  dev1 4194304
+	  dev2 104857600
+
+	The device name string is set by a device driver when it registers with the
+	GPU cgroup controller to participate in resource accounting. Non-unique names
+	will be rejected at the point of registration.
+
 Others
 ------
 
-- 
2.36.0.464.gb9c8b46e94-goog

