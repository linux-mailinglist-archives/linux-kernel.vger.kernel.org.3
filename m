Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1657FE22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiGYLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGYLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:11:26 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C7E1403B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658747415; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fByinlQtj3jM8pGcdQhkBTz3yEYHgopvAsss8Fvbd1iNfVZL1SjjIWrKRmIUAxtngJT/GxkBIhv4VL1w95A2C1f3trDCyAkexJk/TAaLewo+jSfiC53UznPZ/XuTELDSdpIWTapKrBNF819937vW8Kzn7UuM6NXwgRR5HPkYwFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658747415; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Vw8o+PvqiksN2gP8/VvlaOtw5GwqSrnHaBqgfUiELlY=; 
        b=n7NI7C66JvDd8m+LljyeWkLLfom/IbMYRYG5kqpbfondXP3S7TIapce9R+Uc3couwN5GJ7tyYXOfe1joQ/BXf1WngNld91SYk6tJDDkQWkW0djWhaOP7iQ7xDUOn2o37w7C9YG9u05jotOuCxlTw31ZdUnpoodYZmCDbD+LqfuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658747415;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=Vw8o+PvqiksN2gP8/VvlaOtw5GwqSrnHaBqgfUiELlY=;
        b=IUt4JzvZIwxHEvuj94kvZVinjoTDaWc8aiizDGKJV6kDZGzCmASJJhQ4HuMtdXnI
        aNfwfHm9/5KIucBttU/sqrYg7wb9h+i6E3gvWsgY5veBpyPHeH42uag9+ymBDQ+IOg0
        ZFWXkqvYErEBUFDR+BxXHjtQGoCIkfKF8c88OiSo=
Received: from edelgard.icenowy.me (59.41.162.230 [59.41.162.230]) by mx.zohomail.com
        with SMTPS id 1658747413181482.9075417342268; Mon, 25 Jul 2022 04:10:13 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] ASoC: Intel: Skylake: fix error message of NHLT blob selection
Date:   Mon, 25 Jul 2022 19:10:01 +0800
Message-Id: <20220725111002.143765-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The query to select NHLT blob had been changed to use parameters of the
pipeline instead of PCM, however the error message returned when it fails
still uses PCM properties.

Fix this inconsistency.

Fixes: 87b265260046 ("ASoC: Intel: Skylake: Select proper format for NHLT blob")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 sound/soc/intel/skylake/skl-topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 9bdf020a2b64..19994ec8bba1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1864,7 +1864,8 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 	} else {
 		dev_err(dai->dev, "Blob NULL for id:%d type:%d dirn:%d ch:%d, freq:%d, fmt:%d\n",
 			mconfig->vbus_id, link_type, params->stream,
-			params->ch, params->s_freq, params->s_fmt);
+			pipe_fmt->channels, pipe_fmt->freq,
+			pipe_fmt->bps);
 		return -EINVAL;
 	}
 
-- 
2.37.1

