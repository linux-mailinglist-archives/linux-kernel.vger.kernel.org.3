Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0694ED0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351969AbiCaAHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCaAHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:07:21 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313313CF0;
        Wed, 30 Mar 2022 17:05:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648685129; bh=HXScMbGBfgV0fbImwE4gIcpKqpz7fQkb4L1fzYH+Fso=;
        h=From:To:Cc:Subject:Date;
        b=B0fRJWdALfz7GcETLruf1Gh/cLy3aSP/crDVyreGkMZfOtu6HnzaB4V9e/4lj23u6
         ZaoczdY+elmFiZNsL+VSd+ioKCPFA5vbBqWIhIWskd4YdNeOjyMbdwvFsVgHEZr74/
         JpiuhFfXnbAsgIxgDJvcF2+TMHBIyOzTwF6hFDMQ=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
Date:   Thu, 31 Mar 2022 02:04:44 +0200
Message-Id: <20220331000449.41062-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I put together a machine-level ASoC driver for recent Apple Macs (the
ones with ARM64 SoCs) and want to gauge opinions.

Commit 1 is the binding. It is some subset of simple-audio-card with
the extra distinction of allowing multiple CPU/CODEC DAIs per a DAI
link. I want to draw special attention to the issue of describing
speaker topologies. The way it now works is that the driver expects
the speakers to be declared in a fixed order in the sound-dai= list.
This populates a topology the driver expects on a particular machine
model. Mark (in CC) has made the suggestion of keeping the topology
descriptions with the codec nodes themselves in some generic manner,
akin to how sound-name-prefix= already helps identify codecs to the
user.

Commit 2 adds a new ASoC card method (filter_controls) to let the card
prevent some codec kcontrols from being visible to userspace. For example
the TAS2770 speaker amp driver would be happy to expose TDM slot selection
and ISENSE/VSENSE enables which is ridiculous. I am all ears on how to
make the patch acceptable to upstream.

Commit 3 makes ASoC tolerate N-to-M DAI links, not sure what the right
(simple) approach should be there. Commit 4 adds some utility function
and commit 5 is the driver itself.

Let me know what you think.

Martin

Martin Povišer (5):
  dt-bindings: sound: Add Apple Macs sound system
  HACK: ASoC: Add card->filter_controls hook
  HACK: ASoC: Tolerate N-cpus-to-M-codecs links
  ASoC: Introduce snd_soc_of_get_dai_link_cpus
  ASoC: Add macaudio machine driver

 .../bindings/sound/apple,macaudio.yaml        | 103 +++
 include/sound/soc.h                           |   7 +
 sound/soc/apple/Kconfig                       |  10 +
 sound/soc/apple/Makefile                      |   3 +
 sound/soc/apple/macaudio.c                    | 597 ++++++++++++++++++
 sound/soc/soc-core.c                          | 125 +++-
 sound/soc/soc-dapm.c                          |  34 +-
 sound/soc/soc-pcm.c                           |   3 +
 8 files changed, 860 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/apple,macaudio.yaml
 create mode 100644 sound/soc/apple/Kconfig
 create mode 100644 sound/soc/apple/Makefile
 create mode 100644 sound/soc/apple/macaudio.c

-- 
2.33.0

