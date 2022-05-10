Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9794D5227EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiEJX5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiEJX5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:57:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFF20AE7D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:56:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d22-20020a25add6000000b00645d796034fso439230ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4KvDBY92RR8WKuUjzgohCsuZSchRL19v0jjqGuoq0no=;
        b=EVnDMIpZB27MCIXhHatilUnRYlxARdcdAd7PK1rHIXFEB09aYu4tovCAvBFw8cZxyT
         gXDSSt3iUIN/1CO3fml62gvLZRGE+EMeeeLDQuSX7c4jbLENEPCC9PDIZujw5VNhH0q0
         FNlArlRA5Ob2e7UO2kZWZMCqvsuYh5DB5yxiuRlqYM4K6p8fNfkF+nvk4AffdLlQoCVj
         Iow7SxlzmL5Vq+/E0YXhlhfw88NjMLlc65QX53QBUS8PoggN6lNR+09aPb47Qcif87k3
         deyEJ4awwrFwdjAObdu51OKvcIO1OpNdSGWxV/SAb3A5rkBNGUpnsa8mp82Pi0LrZ+EP
         djEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4KvDBY92RR8WKuUjzgohCsuZSchRL19v0jjqGuoq0no=;
        b=QN+0CafaGDuqmJ4cAZm4OH7mcleK/HaxQFHH3fFmPOE0NX8wsEWn8fxxD+z0jGE3hp
         XcPyXbT56h2+hZggkNrkHcwIrt/TMSvZwaoomVv4sPMbswTmF9FU+5L5B6pl5kzXSQvy
         RGPpqkQpRE6JKuzfOulYuDG5eo4AFRPA+2dGNNwdCT6j1a46A9twV4ubmv8O/RvQpcoy
         +36YrTDNiThMIpni3q9lCpWVlZZevSmiAlAwkLtk6EfGoT6YCOQrOd5X0mcafg6cQAJZ
         +wBv59txroNUWJVqM1rLchTAsHaieJSsDBZqL1YIiF3K/3GJBVPpQa54dSZjzQuEYLGP
         HpUg==
X-Gm-Message-State: AOAM530Lfb5BXXGZcGSngRewivmVKN9rO0ZI2c2JyKJ9Nmmk0sVRbPZj
        S5yYit6wqSx6eOKkZiUEZmCBThUQ/t54iXw=
X-Google-Smtp-Source: ABdhPJxlqpgDpJ9NusV/EqUoq7QOEUS1bEXKFWa7Ps8sG0Rk4PPsvk4A1DFBh7AwydMPg9ury9ovxi429oUOWa4=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a5b:7c4:0:b0:64b:da6:cb3b with SMTP id
 t4-20020a5b07c4000000b0064b0da6cb3bmr5590895ybq.104.1652227018683; Tue, 10
 May 2022 16:56:58 -0700 (PDT)
Date:   Tue, 10 May 2022 23:56:45 +0000
In-Reply-To: <20220510235653.933868-1-tjmercier@google.com>
Message-Id: <20220510235653.933868-2-tjmercier@google.com>
Mime-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v7 1/6] gpu: rfc: Proposal for a GPU cgroup controller
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
Content-Transfer-Encoding: quoted-printable
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

[1]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@int=
el.com/

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v7 changes
Remove comment about duplicate name rejection which is not relevant to
cgroups users per Michal Koutn=C3=BD.

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
 Documentation/admin-guide/cgroup-v2.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 69d7a6983f78..2e1d26e327c7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2352,6 +2352,29 @@ first, and stays charged to that cgroup until that r=
esource is freed. Migrating
 a process to a different cgroup does not move the charge to the destinatio=
n
 cgroup where the process has moved.
=20
+
+GPU
+---
+
+The GPU controller accounts for device and system memory allocated by the =
GPU
+and related subsystems for graphics use. Resource limits are not currently
+supported.
+
+GPU Interface Files
+~~~~~~~~~~~~~~~~~~~~
+
+  gpu.memory.current
+	A read-only file containing memory allocations in flat-keyed format. The =
key
+	is a string representing the device name. The value is the size of the me=
mory
+	charged to the device in bytes. The device names are globally unique.::
+
+	  $ cat /sys/kernel/fs/cgroup1/gpu.memory.current
+	  dev1 4194304
+	  dev2 104857600
+
+	The device name string is set by a device driver when it registers with t=
he
+	GPU cgroup controller to participate in resource accounting.
+
 Others
 ------
=20
--=20
2.36.0.512.ge40c2bad7a-goog

