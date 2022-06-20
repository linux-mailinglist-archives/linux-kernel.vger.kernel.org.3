Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5855232F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbiFTRzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbiFTRze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:55:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4713615A29;
        Mon, 20 Jun 2022 10:55:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e25so11826933wrc.13;
        Mon, 20 Jun 2022 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Dx8kHYChInXA05yvjMTh5hDqDoL/JwqTYniVb/CEJw=;
        b=RWKEkdXq+lSk+dmdI6Iot8rAZyvslodnYkpKOvXWK2K1boPyqJvZE44FF88y2Emvbm
         +yXvUSTM8IH/gOAuYmyJYphk7VLlg7HcDGNSypDuEOXopHleVoqItdbjuY63AZUlEiKq
         eruxK5ScWYaLkwaR/E9jz8q8dmkHsUHfErc9XoD9L806hmBH7bC1TOB5kt1f2+K5PPHM
         YdpP1Gb/liecVdKNGquPCsbpStcSZrlH5QL27wGGjHxrEVclvULkCb07YHNXt1YaQIge
         Cj6PwnXTktHdBFWyPTrHDx2tW2JM7jmqXrLFwX8qtRxQTLXjrtYRrlwdMkAGuFZ3whhJ
         EesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Dx8kHYChInXA05yvjMTh5hDqDoL/JwqTYniVb/CEJw=;
        b=vxUQnQlAscfa/PxYM8ZC1coEN7NRJn7wvH9xlvStNisEkc7HkxatX4n0t/XksWs99C
         Tu1quOZ7B7VY7vscEjPoYtEifYRPry+JkfbOc51IZcAIQ+FKI1iJf3PkDHq9wi9UqkTU
         2jbVwFpgAXy0oMAC4ZzjBSGM+AfnSrqiF9pOqKfvNCp6KAlBOLRQXYP3vqEEEVD/dbDC
         Q78/QUpnzeQqkMb4ls45jFPVK8bjasuF08fTwXbsYa61AZorHDIi0N2J/FRVJHbgi+yi
         Ut63rkbqTwC9G93pvdeFHJrqYlM00zqFQQnhUs8OJDenUlM1jT/hW77s3N2SgqNAqGwF
         y+5Q==
X-Gm-Message-State: AJIora98BVGYiqCzsgg2SKaopqvK9pl5TSLqv3W054u6klt225Ev4sqy
        Zus7pLhvo6362hhyLTzuNLE=
X-Google-Smtp-Source: AGRyM1tf6dHvP/4piBoIAhMdMxtYQKzRiL3AmGmYpf47aENlwuoGJoCvcq7wTdgbldWLXnoiTG8NnQ==
X-Received: by 2002:a5d:5250:0:b0:21b:8b4e:ee54 with SMTP id k16-20020a5d5250000000b0021b8b4eee54mr9248694wrc.624.1655747729719;
        Mon, 20 Jun 2022 10:55:29 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 184-20020a1c02c1000000b0039db31f6372sm19620752wmc.2.2022.06.20.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:55:29 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/7] media: cedrus: h265: Implement tiles support
Date:   Mon, 20 Jun 2022 19:55:10 +0200
Message-Id: <20220620175517.648767-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have full and stable HEVC uAPI, let's implement last big
missing piece of HEVC in Cedrus - tiles support. This is done in
last patch. Before that, there are bug fixes (patch 1 & 2, previously
submitted separately in [1]), error handling improvements (patch 3, 4)
and added helper for dealing with dynamic arrays (patch 5).

These patches are based on top of [2].

Final fluster score with this series is 125/147. 11 bitstreams are
MAIN10, which is not yet properly supported. 5 bitstreams need better
memory management with auxiliary buffers (wip patches exists). 4 are
too big and 2 probably fails due to ffmpeg implementation.

Used ffmpeg source is in [3].

Note - Cedrus driver currently supports only one slice per request since
HW takes data for 1 slice only. This can be improved by loading data for
next slice automatically after HW signalled end of decoding. Something
for later.

Please take a look.

Best regards,
Jernej

[1] https://patchwork.linuxtv.org/project/linux-media/list/?series=8187
[2] https://patchwork.linuxtv.org/project/linux-media/list/?series=8208
[3] https://github.com/jernejsk/FFmpeg/commits/hevc-mainline

Jernej Skrabec (7):
  media: cedrus: h265: Fix flag name
  media: cedrus: h265: Fix logic for not low delay flag
  media: cedrus: Improve error messages for controls
  media: cedrus: Add error handling for failed setup
  media: cedrus: h265: Add a couple of error checks
  media: cedrus: Add helper for determining number of elements
  media: cedrus: h265: Implement support for tiles

 drivers/staging/media/sunxi/cedrus/cedrus.c   |  28 +++-
 drivers/staging/media/sunxi/cedrus/cedrus.h   |   7 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  25 ++-
 .../staging/media/sunxi/cedrus/cedrus_h264.c  |   5 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 153 ++++++++++++++++--
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |   4 +-
 .../staging/media/sunxi/cedrus/cedrus_regs.h  |   3 +-
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   |   5 +-
 8 files changed, 204 insertions(+), 26 deletions(-)

-- 
2.36.1

