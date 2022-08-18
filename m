Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854EA598C07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbiHRSwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHRSwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:52:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F1BFAB7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63C06B82216
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7129C433D6;
        Thu, 18 Aug 2022 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660848754;
        bh=sX4h/KO/9pKaDjJzRRN9cRKPg/aFjmdCh2FeIZpqjFs=;
        h=Date:From:To:Cc:Subject:From;
        b=SBpxz7S2w133hIZPKiV5PBCsXyI6Zuzpm5xVbO0PcjPB3NE7AcAzyzFHGnDWMWoXE
         uwlzKAXOo3hOpL4Uw+qUviDGmz15aD8c7GFwXjy3UN8HmImz/N3I5QI3rJe7M6o3U/
         UYQ7qPPL0eK2x2iuMwKsZpHoJOPKyOg6FaYKeTzAiXgYuvfOJ5mH59o+4C2zrnpF4z
         Qmc68PZKDzWg+4S5tJSoQL/Acr55z1z3r2rI4TCP0H9GMWrHi1jFyliB+4b9UKhaV4
         I6izilw3moYlB0p3UJlFw70am9wUnNxaEfRJ2rYu1JUcBz/VaKYJudod/ca76aqNim
         hhxCLDnpMUKWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 104054035A; Thu, 18 Aug 2022 15:52:31 -0300 (-03)
Date:   Thu, 18 Aug 2022 15:52:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH FYI 1/1] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <Yv6Kb4OESuNJuH6X@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
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

  f345a0143b4dd1cf ("vhost-vdpa: uAPI to suspend the device")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

To pick up these changes and support them:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2022-08-18 09:46:12.355958316 -0300
  +++ after	2022-08-18 09:46:19.701182822 -0300
  @@ -29,6 +29,7 @@
   	[0x75] = "VDPA_SET_VRING_ENABLE",
   	[0x77] = "VDPA_SET_CONFIG_CALL",
   	[0x7C] = "VDPA_SET_GROUP_ASID",
  +	[0x7D] = "VDPA_SUSPEND",
   };
   = {
   	[0x00] = "GET_FEATURES",
  $

For instance, see how those 'cmd' ioctl arguments get translated, now
VDPA_SUSPEND will be as well:

  # perf trace -a -e ioctl --max-events=10
       0.000 ( 0.011 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                        = 0
      21.353 ( 0.014 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                        = 0
      25.766 ( 0.014 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)            = 0
      25.845 ( 0.034 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70)            = 0
      25.916 ( 0.011 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)               = 0
      25.941 ( 0.025 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ATOMIC, arg: 0x7ffe4a22c840)               = 0
      32.915 ( 0.009 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_RMFB, arg: 0x7ffe4a22cf9c)                 = 0
      42.522 ( 0.013 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)            = 0
      42.579 ( 0.031 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70)            = 0
      42.644 ( 0.010 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)               = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index cab645d4a6455564..f9f115a7c75b8a30 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -171,4 +171,13 @@
 #define VHOST_VDPA_SET_GROUP_ASID	_IOW(VHOST_VIRTIO, 0x7C, \
 					     struct vhost_vring_state)
 
+/* Suspend a device so it does not process virtqueue requests anymore
+ *
+ * After the return of ioctl the device must preserve all the necessary state
+ * (the virtqueue vring base plus the possible device specific states) that is
+ * required for restoring in the future. The device must not change its
+ * configuration after that point.
+ */
+#define VHOST_VDPA_SUSPEND		_IO(VHOST_VIRTIO, 0x7D)
+
 #endif
-- 
2.37.1

