Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8DB5093EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383309AbiDTXz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiDTXzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:55:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF033DDC7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:52:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so29355787b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wXmJayhij+TwqNidzBSB+0E2/eNzdXfcp3O+/c0CbLs=;
        b=OaTB0NiuNGz3gZItyS5lGwvFOV7EZfpnX61C01bWWJjrQvw2KVEzFOtQmxRdxaSqrK
         DyZu71fHPSfuIhXETJEDfwfomhHzLen7FXo4xGDixCofaw1VUz53e+6jEJsNCFKbS4R2
         b32RTlbQVSExtwz2j01qt89K5YDAARZUOHLDBkXMIjUvYc2di8K1OGvXpUpBQA9KxVQe
         VqDWByInG2C9PEoeUTqqMWo3pWkEziJDfUyj4iIBaw0drmx47/i43FMmzuAJ665mVVL1
         mu6hSBkRK9Kj23/NVYHS3v83cv/2KEOTKYF7s8dEDCyuNULl9QHRJ2FdImYzP++gH5jq
         o9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wXmJayhij+TwqNidzBSB+0E2/eNzdXfcp3O+/c0CbLs=;
        b=mdSSx5AEt6KoqVTxn9zXKBzo32JMZEG3idAsEiM0sA80GSb6+f5pQBlqJ4GQ3Sx8Yb
         wOV3IXblHz19p5OuQZPweogIQaCHBxqHUX3ADork6iYC7WF+oJJGUxpVgdCK/C9WYvGR
         h7Y8LnRvWf4k/C+dv4b3yJ4E+X/82KgCvcnmL7MTWSW+edAwv8IncYLglw7QQSlE/vKh
         dML+xR0bz7rVBVMzd+Kw0kaDOQ8XfuElr7KkzySum7RMAv0EjVZ4mCSstLR+fxVx4y79
         gq4b6pVP43i9KO0QEgRqqqmoIgrtLICJaYu1aata61KerAM5x75yDaAwy39JmyZiU6Hg
         YUaQ==
X-Gm-Message-State: AOAM530G8xAJR+qKsH3bf4Xa1fnRi8elTmrevbs68zcXlDdEnwsWusJp
        0k5OT5yZt+3nwxQ3ZU87oNZ2vSdbQC0szNo=
X-Google-Smtp-Source: ABdhPJwdyO1a59Wbmq1dxswXBXqz9W9bswYyvbTDUV+1oi//Kyi7KDzuR7vBGAHyOSEgZ4kGsGhEe+dl4K2LpjM=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a05:6902:1244:b0:644:b8a5:e195 with SMTP
 id t4-20020a056902124400b00644b8a5e195mr22014142ybu.556.1650498755305; Wed,
 20 Apr 2022 16:52:35 -0700 (PDT)
Date:   Wed, 20 Apr 2022 23:52:19 +0000
In-Reply-To: <20220420235228.2767816-1-tjmercier@google.com>
Message-Id: <20220420235228.2767816-2-tjmercier@google.com>
Mime-Version: 1.0
References: <20220420235228.2767816-1-tjmercier@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [RFC v5 1/6] gpu: rfc: Proposal for a GPU cgroup controller
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, daniel@ffwll.ch, tj@kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     hridya@google.com, christian.koenig@amd.com, jstultz@google.com,
        tkjos@android.com, cmllamas@google.com, surenb@google.com,
        kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, kernel-team@android.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
v5 changes
Drop the global GPU cgroup "total" (sum of all device totals) portion
of the design since there is no currently known use for this per
Tejun Heo.

Update for renamed functions/variables.

v3 changes
Remove Upstreaming Plan from gpu-cgroup.rst per John Stultz.

Use more common dual author commit message format per John Stultz.
---
 Documentation/gpu/rfc/gpu-cgroup.rst | 190 +++++++++++++++++++++++++++
 Documentation/gpu/rfc/index.rst      |   4 +
 2 files changed, 194 insertions(+)
 create mode 100644 Documentation/gpu/rfc/gpu-cgroup.rst

diff --git a/Documentation/gpu/rfc/gpu-cgroup.rst b/Documentation/gpu/rfc/g=
pu-cgroup.rst
new file mode 100644
index 000000000000..0be2a3a9f641
--- /dev/null
+++ b/Documentation/gpu/rfc/gpu-cgroup.rst
@@ -0,0 +1,190 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+GPU cgroup controller
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Goals
+=3D=3D=3D=3D=3D
+This document intends to outline a plan to create a cgroup v2 controller s=
ubsystem
+for the per-cgroup accounting of device and system memory allocated by the=
 GPU
+and related subsystems.
+
+The new cgroup controller would:
+
+* Allow setting per-device limits on the total size of buffers allocated b=
y a
+  device/allocator within a cgroup.
+
+* Expose a per-device/allocator breakdown of the buffers charged to a cgro=
up.
+
+Alternatives Considered
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The following alternatives were considered:
+
+The memory cgroup controller
+____________________________
+
+1. As was noted in [1], memory accounting provided by the GPU cgroup
+controller is not a good fit for integration into memcg due to the
+differences in how accounting is performed. It implements a mechanism
+for the allocator attribution of GPU and GPU-related memory by
+charging each buffer to the cgroup of the process on behalf of which
+the memory was allocated. The buffer stays charged to the cgroup until
+it is freed regardless of whether the process retains any references
+to it. On the other hand, the memory cgroup controller offers a more
+fine-grained charging and uncharging behavior depending on the kind of
+page being accounted.
+
+2. Memcg performs accounting in units of pages. In the DMA-BUF buffer shar=
ing model,
+a process takes a reference to the entire buffer(hence keeping it alive) e=
ven if
+it is only accessing parts of it. Therefore, per-page memory tracking for =
DMA-BUF
+memory accounting would only introduce additional overhead without any ben=
efits.
+
+[1]: https://patchwork.kernel.org/project/dri-devel/cover/20190501140438.9=
506-1-brian.welty@intel.com/#22624705
+
+Userspace service to keep track of buffer allocations and releases
+__________________________________________________________________
+
+1. There is no way for a userspace service to intercept all allocations an=
d releases.
+2. In case the process gets killed or restarted, we lose all accounting so=
 far.
+
+UAPI
+=3D=3D=3D=3D
+When enabled, the new cgroup controller would create the following files i=
n every cgroup.
+
+::
+
+        gpu.memory.current (R)
+        gpu.memory.max (R/W)
+
+gpu.memory.current is a read-only file and would contain per-device memory=
 allocations
+in a key-value format where key is a string representing the device name a=
nd the value
+is the size of memory charged to the device in the cgroup in bytes. The de=
vice name
+should be globally unique.
+
+For example:
+
+::
+
+        cat /sys/kernel/fs/cgroup1/gpu.memory.current
+        dev1 4194304
+        dev2 4194304
+
+The string key for each device is set by the device driver when the device=
 registers
+with the GPU cgroup controller to participate in resource accounting (see =
section
+'Design and Implementation' for more details).
+
+gpu.memory.max is a read/write file. It would show the current size limits=
 on
+memory usage for each allocator/device.
+
+Setting a limit for a particular device/allocator can be done as follows:
+
+::
+
+        echo =E2=80=9Cdev1 4194304=E2=80=9D >  /sys/kernel/fs/cgroup1/gpu.=
memory.max
+
+In this example, 'dev1' is the string key set by the device driver during
+registration.
+
+Design and Implementation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+The cgroup controller would closely follow the design of the RDMA cgroup c=
ontroller
+subsystem where each cgroup maintains a list of resource pools.
+Each resource pool is associated with a device name via a pointer to a str=
uct gpucg_bucket
+and contains a counter to track current, total, and the maximum limit set =
for the device.
+
+The below code block is a preliminary estimation on how the core kernel da=
ta structures
+and APIs would look like.
+
+.. code-block:: c
+
+        /* The GPU cgroup controller data structure */
+        struct gpucg {
+                struct cgroup_subsys_state css;
+
+                /* list of all resource pools that belong to this cgroup *=
/
+                struct list_head rpools;
+        };
+
+        /* A named entity representing bucket of tracked memory. */
+        struct gpucg_bucket {
+                /* list of various resource pools in various cgroups that =
the bucket is part of */
+                struct list_head rpools;
+
+                /* list of all buckets registered for GPU cgroup accountin=
g */
+                struct list_head bucket_node;
+
+                /* string to be used as identifier for accounting and limi=
t setting */
+                const char *name;
+        };
+
+        struct gpucg_resource_pool {
+                /* The bucket whose resource usage is tracked by this reso=
urce pool */
+                struct gpucg_bucket *bucket;
+
+                /* list of all resource pools for the cgroup */
+                struct list_head cg_node;
+
+                /* list maintained by the gpucg_bucket to keep track of it=
s resource pools */
+                struct list_head bucket_node;
+
+                /* tracks memory usage of the resource pool */
+                struct page_counter total;
+        };
+
+        /**
+         * gpucg_register_bucket - Registers a bucket for memory accountin=
g using the
+         * GPU cgroup controller.
+         *
+         * @bucket: The bucket to register for memory accounting.
+         * @name: Pointer to a null-terminated string to denote the name o=
f the bucket. This name
+         *        should be globally unique, and should not exceed @GPUCG_=
BUCKET_NAME_MAX_LEN bytes.
+         *
+         * @bucket must remain valid. @name will be copied.
+         */
+        void gpucg_register_bucket(struct gpucg_bucket *bucket, const char=
 *name)
+
+        /**
+         * gpucg_charge - charge memory to the specified gpucg and gpucg_b=
ucket.
+         *
+         * @gpucg: The gpu cgroup to charge the memory to.
+         * @bucket: The pool to charge the memory to.
+         * @size: The size of memory to charge in bytes.
+         *        This size will be rounded up to the nearest page size.
+         *
+         * Return: returns 0 if the charging is successful and otherwise r=
eturns an
+         * error code.
+         */
+        int gpucg_charge(struct gpucg *gpucg, struct gpucg_bucket *bucket,=
 u64 size);
+
+        /**
+         * gpucg_uncharge - uncharge memory from the specified gpucg and g=
pucg_bucket.
+         * The caller must hold a reference to @gpucg obtained through gpu=
cg_get().
+         *
+         * @gpucg: The gpu cgroup to uncharge the memory from.
+         * @bucket: The bucket to uncharge the memory from.
+         * @size: The size of memory to uncharge in bytes.
+         *        This size will be rounded up to the nearest page size.
+         */
+        void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_bucket *buck=
et, u64 size);
+
+        /**
+         * gpucg_transfer_charge - Transfer a GPU charge from one cgroup t=
o another.
+         *
+         * @source:	[in]	The GPU cgroup the charge will be transferred fro=
m.
+         * @dest:	[in]	The GPU cgroup the charge will be transferred to.
+         * @bucket:	[in]	The GPU cgroup bucket corresponding to the charge=
.
+         * @size:	[in]	The size of the memory in bytes.
+         *                      This size will be rounded up to the neares=
t page size.
+         *
+         * Returns 0 on success, or a negative errno code otherwise.
+         */
+        int gpucg_transfer_charge(struct gpucg *source,
+                                  struct gpucg *dest,
+                                  struct gpucg_bucket *bucket,
+                                  u64 size)
+
+
+Future Work
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Additional GPU resources can be supported by adding new controller files.
diff --git a/Documentation/gpu/rfc/index.rst b/Documentation/gpu/rfc/index.=
rst
index 91e93a705230..0a9bcd94e95d 100644
--- a/Documentation/gpu/rfc/index.rst
+++ b/Documentation/gpu/rfc/index.rst
@@ -23,3 +23,7 @@ host such documentation:
 .. toctree::
=20
     i915_scheduler.rst
+
+.. toctree::
+
+    gpu-cgroup.rst
--=20
2.36.0.rc0.470.gd361397f0d-goog

