Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FE74F1B95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380295AbiDDVVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379726AbiDDR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FF34BB9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F1260DC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3646C2BBE4;
        Mon,  4 Apr 2022 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649095077;
        bh=80bTl5vvvHrdNwh0hzRyV7X+VwRq0OLEE8K3/p30eT4=;
        h=Date:From:To:Cc:Subject:From;
        b=TiJpc6RpKGWs+b6fNEHdHum/cCv5zhWLBHT8so7KcIrVQAnKWS/EHayBm+cbXJWt4
         GYjeqEbGsDZHXrDVmlUFOLy+PXxH7m4GVhmCO/BxA+m5ySm9k+U3j5mCrCKFVxpKlB
         4EvYIJjwWA5fAzK0ryXyqyEQa0uKrSGnCNk3RLgDXwWtzk+Ta7yLa25AclbPuB3rvB
         7BawJn56BcR9OzqTvNyupXYXDH7661XTk7+INZ3jXffsgHEBMrq0KgPjQq6Uu+waWV
         azAkfbjzPRpyps+wedADI6F3wzEM4DCKpKuy/Bf79GBmXbUcd7WhQ2CB/HzO1hXFHX
         gMb3iqgL3liig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1D8E40407; Mon,  4 Apr 2022 14:57:52 -0300 (-03)
Date:   Mon, 4 Apr 2022 14:57:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Longpeng <longpeng2@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools include UAPI: Sync linux/vhost.h with the kernel
 sources
Message-ID: <YksxoFcOARk/ldev@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

To get the changes in:

  b04d910af330b55e ("vdpa: support exposing the count of vqs to userspace")
  a61280ddddaa45f9 ("vdpa: support exposing the config size to userspace")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

  $ diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
  --- tools/include/uapi/linux/vhost.h	2021-07-15 16:17:01.840818309 -0300
  +++ include/uapi/linux/vhost.h	2022-04-02 18:55:05.702522387 -0300
  @@ -150,4 +150,11 @@
   /* Get the valid iova range */
   #define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
   					     struct vhost_vdpa_iova_range)
  +
  +/* Get the config size */
  +#define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
  +
  +/* Get the count of all virtqueues */
  +#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
  +
   #endif
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2022-04-04 14:52:25.036375145 -0300
  +++ after	2022-04-04 14:52:31.906549976 -0300
  @@ -38,4 +38,6 @@
   	[0x73] = "VDPA_GET_CONFIG",
   	[0x76] = "VDPA_GET_VRING_NUM",
   	[0x78] = "VDPA_GET_IOVA_RANGE",
  +	[0x79] = "VDPA_GET_CONFIG_SIZE",
  +	[0x80] = "VDPA_GET_VQS_COUNT",
   };
  $

Cc: Longpeng <longpeng2@huawei.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index c998860d7bbc4351..5d99e7c242a25e11 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -150,4 +150,11 @@
 /* Get the valid iova range */
 #define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
 					     struct vhost_vdpa_iova_range)
+
+/* Get the config size */
+#define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
+
+/* Get the count of all virtqueues */
+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
+
 #endif
-- 
2.35.1

