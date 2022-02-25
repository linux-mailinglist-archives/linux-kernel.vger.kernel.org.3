Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90B4C46DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiBYNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241635AbiBYNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:46:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F08210D70
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:45:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 83DA71F4107C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645796740;
        bh=Jse5jslyQwK8jYrGmsf8TVyXCyfWaI4dN1Xg9g/UKcA=;
        h=From:To:Cc:Subject:Date:From;
        b=gc1+GTNX4IdQTjOQM2VQD5ijDrvyUPUpqyrQFN0haUjKHtHW0sNDisvEDtU17qO46
         bigv6hv4lf6EzHG5cLoEnnD//MUgMcFWQJQNA6pJB7qyus7PPI3jYDFa6XZUchQOsF
         BoUAJqJxSzl2U50ux1ZNInoIRGQ7sN8xEw9JuG3JQdokodMBPz4PK26qenZpfwRyiS
         BdPmG6p0EvgIyZ0iaU3W1pdk4lCqFjUd6RpScWwzbgXHbgaZgq4zFRECK+3yNvp6jI
         pK9lmNlAohPakmyxW8VT2umSKzX/PvIHVAom67c/lItl2j6WJXzcddmsYjtJoCaaIw
         nZayvxyFFqCwQ==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: [PATCH 0/2] Mitigate race condition problems when unbinding DRM driver
Date:   Fri, 25 Feb 2022 14:45:02 +0100
Message-Id: <20220225134504.457245-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm sending these patches to try to improve the current situation for a
particular corner case (DRM driver unbinding).

I could reproduce a specific race condition during the unbinding of the
mediatek-drm driver that caused an invalid memory address. The race
condition is triggered by a userspace event (gnome-shell requesting a
DRM GET_CONNECTOR ioctl) while the encoders and drivers are in the
process of being disabled.

While I tried to mitigate this by making a small change in the
parade-ps8640 driver (for the bridge I'm testing on) and by making a
couple of functions in drm_bridge.c more robust, this is only a symptom
of a larger problem that might not be getting enough attention,
understandably, because this is an unusual corner case.

The scenario looks like this:

<userspace>: unbind mediatek-drm   --------------------+
              |                                        |
           <kernel>                                    |
              |                                        |
             ...                                       |
              |                                       ...
        mtk_dsi_unbind                                 |
              |                                        |
              `- drm_encoder_cleanup                   v
              |   |                                 gnome-shell
             ...  `- drm_bridge_detach *<------ ioctl (GET_CONNECTOR)
                                                   |
                                                <kernel>
                                                   |
                                                  ...
                                                   |
                                                   |
                                      ps8640_bridge_get_edid
                                         |
                                          `drm_bridge_chain_post_disable

which causes drm_bridge_chain_post_disable() to walk the bridge chain
after the bridge has already been detached and removed from the list. I
guess a more radical and subsystem-wide solution would be to not allow
or to block certain ioctl calls once the driver has started to unbind,
but I'd like to hear your opinion on this.

This was tested on an Acer Chromebook R13 (Elm, MT8173) running Debian
Sid, the command that triggers the race condition is

echo mediatek-drm.12.auto > /sys/bus/platform/drivers/mediatek-drm/unbind

Cheers,
Ricardo

Ricardo Cañuelo (2):
  drm/bridge: parade-ps8640: avoid race condition on driver unbinding
  drm/bridge: Add extra checks in pre_enable and post_enable

 drivers/gpu/drm/bridge/parade-ps8640.c | 6 +++---
 drivers/gpu/drm/drm_bridge.c           | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--
2.25.1
