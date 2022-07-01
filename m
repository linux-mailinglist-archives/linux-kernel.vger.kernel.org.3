Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D15562F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiGAJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiGAJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:03:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E68B41;
        Fri,  1 Jul 2022 02:03:54 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4702766015B2;
        Fri,  1 Jul 2022 10:03:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656666233;
        bh=oOZf0LBfOP2Mrd3kKdfyQSfqWEThXNW2359k+fuby8k=;
        h=From:To:Cc:Subject:Date:From;
        b=g/ZoW+eXIu7Ti6gYKeb8pEQXflxFZnZtIgcDJCDmjroTBaTPeja2pKbeaIAjYymTd
         KILCpbkQSCCJXeFo58JBWy7iHoru61NtEyGNJ2bbKudDblMl7ZQ3o6ld1kTArsXvnc
         ukDXgP30Lea0adEDSIbT1mIAaj71TSffSXe6kNNPbumqNusmWLq84VCzKVf+fRvNE9
         t3FqRFroAFay5VZ0jYDkAoQyEgI/7TXu7L4ob/oaSLlQN2ylLvojj33ljEkzIzP9DF
         9YlSvXFkv2+VmP23itjJZgqQUsLsixQMR/XNII8UxlTU/Sanz/obTLqXGq84pk1tY0
         KIpg5seL4xU5Q==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 0/2] DRM GEM fixes
Date:   Fri,  1 Jul 2022 12:02:38 +0300
Message-Id: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes two problems in the common GEM code. First fixed problem
is the bogus lockdep splat that complicates debugging of DRM drivers. Second
problem is the inconsistency in behaviour and improper handling of mapping
the imported GEMs by some drivers, to fix it we will prohibit to map the
imported GEMs like majority of drivers already do.

Changelog:

v8: - Dropped stable tag from the "Don't map imported GEMs" patch,
      like was suggested by Thomas Hellström in the review comment to v7.

v7: - Factored out GEM patches from [1] since I'll be working on the
      dma-buf locking in a separate patchset now.

[1] https://lore.kernel.org/all/20220526235040.678984-1-dmitry.osipenko@collabora.com/

    - Improved commit message and added fixes tag to the "Properly annotate
      WW context" patch.

    - Replaced "Move mapping of imported dma-bufs to drm_gem_mmap_obj()"
      patch with "Don't map imported GEMs", like was suggested by
      Thomas Hellström.

    - Added r-b and suggested-by from Thomas Hellström.

Dmitry Osipenko (2):
  drm/gem: Properly annotate WW context on drm_gem_lock_reservations()
    error
  drm/gem: Don't map imported GEMs

 drivers/gpu/drm/drm_gem.c              | 8 ++++++--
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ---------
 2 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.36.1

