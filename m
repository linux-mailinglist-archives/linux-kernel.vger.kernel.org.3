Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7255B29B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiFZPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFZPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 11:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D57E0E6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 08:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B56446128E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21B8C34114;
        Sun, 26 Jun 2022 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656256456;
        bh=dLPUJl4bzRl09tUedmHK1x+k55z8n+7m45yrjk8LeXk=;
        h=Date:From:To:Cc:Subject:From;
        b=qam3NFp0Fat2+gvdLnmUeIhju1dZ8NE8Am80/mXUl4sETL+fzDC8A2fxc3xh9aJDB
         4s1c8WS+bNgwNOOpL+f1BEky9tS37ZdSfTOoVNmL+wxWNLhzYfjPPKgKI5LVsk3V+4
         3GsxxaAT/Eca5UuemTbGll7UesF6mKRJ06iHq0oBkIZnEhtT7IsYXV81cll4m9XdU9
         y3/CF7km33vf0OTwu3WFg06oMGsy1pekWrQhbagtKHOcRv7CrwLIDqBXd87Edqtl7x
         n3tCnoE8ttLAQTcWwIyumFq475tCKXo+Lgrqoz+eljdO5gk+/qivOWV1Rs/hvb+3hX
         d0FmhmaV9MadA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D61644096F; Sun, 26 Jun 2022 12:14:12 -0300 (-03)
Date:   Sun, 26 Jun 2022 12:14:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gautam Dawar <gautam.dawar@xilinx.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <Yrh3xMYbfeAD0MFL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To get the changes in:

  84d7c8fd3aade2fe ("vhost-vdpa: introduce uAPI to set group ASID")
  2d1fcb7758e49fd9 ("vhost-vdpa: uAPI to get virtqueue group id")
  a0c95f201170bd55 ("vhost-vdpa: introduce uAPI to get the number of address spaces")
  3ace88bd37436abc ("vhost-vdpa: introduce uAPI to get the number of virtqueue groups")
  175d493c3c3e09a3 ("vhost: move the backend feature bits to vhost_types.h")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

To pick up these changes and support them:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2022-06-26 12:04:35.982003781 -0300
  +++ after	2022-06-26 12:04:43.819972476 -0300
  @@ -28,6 +28,7 @@
   	[0x74] = "VDPA_SET_CONFIG",
   	[0x75] = "VDPA_SET_VRING_ENABLE",
   	[0x77] = "VDPA_SET_CONFIG_CALL",
  +	[0x7C] = "VDPA_SET_GROUP_ASID",
   };
   static const char *vhost_virtio_ioctl_read_cmds[] = {
   	[0x00] = "GET_FEATURES",
  @@ -39,5 +40,8 @@
   	[0x76] = "VDPA_GET_VRING_NUM",
   	[0x78] = "VDPA_GET_IOVA_RANGE",
   	[0x79] = "VDPA_GET_CONFIG_SIZE",
  +	[0x7A] = "VDPA_GET_AS_NUM",
  +	[0x7B] = "VDPA_GET_VRING_GROUP",
   	[0x80] = "VDPA_GET_VQS_COUNT",
  +	[0x81] = "VDPA_GET_GROUP_NUM",
   };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gautam Dawar <gautam.dawar@xilinx.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index 5d99e7c242a25e11..cab645d4a6455564 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -89,11 +89,6 @@
 
 /* Set or get vhost backend capability */
 
-/* Use message type V2 */
-#define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
-/* IOTLB can accept batching hints */
-#define VHOST_BACKEND_F_IOTLB_BATCH  0x2
-
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
 #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
 
@@ -150,11 +145,30 @@
 /* Get the valid iova range */
 #define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
 					     struct vhost_vdpa_iova_range)
-
 /* Get the config size */
 #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
 
 /* Get the count of all virtqueues */
 #define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
 
+/* Get the number of virtqueue groups. */
+#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
+
+/* Get the number of address spaces. */
+#define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x7A, unsigned int)
+
+/* Get the group for a virtqueue: read index, write group in num,
+ * The virtqueue index is stored in the index field of
+ * vhost_vring_state. The group for this specific virtqueue is
+ * returned via num field of vhost_vring_state.
+ */
+#define VHOST_VDPA_GET_VRING_GROUP	_IOWR(VHOST_VIRTIO, 0x7B,	\
+					      struct vhost_vring_state)
+/* Set the ASID for a virtqueue group. The group index is stored in
+ * the index field of vhost_vring_state, the ASID associated with this
+ * group is stored at num field of vhost_vring_state.
+ */
+#define VHOST_VDPA_SET_GROUP_ASID	_IOW(VHOST_VIRTIO, 0x7C, \
+					     struct vhost_vring_state)
+
 #endif
-- 
2.36.1

