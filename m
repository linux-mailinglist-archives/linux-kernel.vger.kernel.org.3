Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444535658A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiGDO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiGDO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE50D29D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656944928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RfGDyGyf0h7jOOxTntBYYgzFfxJM0cp4xXoHrS6OslQ=;
        b=fPM4jsmjv5L+Bl8mPaMRsBbUlHz6R8YtsZpzM2jU9CASnzHINKTJEt5Kdz7W01xdF6n45V
        Cw/StUaah3tfSpKiY3Zpai553pc++SJtWLuqn/CB/p/cPOXpjaq0BUp3RoAh7JBSNRqlQ0
        edZD536aPNcwEU1+eppGOR9QVzpdnOc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-i1p27id3Ogqc2HR9-bm9Pg-1; Mon, 04 Jul 2022 10:28:47 -0400
X-MC-Unique: i1p27id3Ogqc2HR9-bm9Pg-1
Received: by mail-qk1-f197.google.com with SMTP id e128-20020a376986000000b006af6adf035cso8824961qkc.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfGDyGyf0h7jOOxTntBYYgzFfxJM0cp4xXoHrS6OslQ=;
        b=6jdrWEoS2MLBrZBYUTnlVpFdeiZuogBx0vXj9l/rb6YSFQlHDY+u/bCHCnsWbQ6b04
         2H+wJW19Wer+a2tNEepBA99lLNI8zh2fsW6LE4CsR5QggCzP8E13y/qxjkBHUhSDT3OT
         nTdrjLWCjIf8BUeXwzkv+lbuBAirjTuFxesA2Du7m/wUKxtC3r3mKW19iUIkuJO1Ax31
         YtAq5AHXxlPH8trrap9tu85c9SbEV7rZQy3gwUfKt5vc/RfIALT0oHCwhejVuvshzDKH
         QJdfVroQqIGLHN3/KAKoIvxZISDMsAeqnWTpZRENfcU+Hsn4W+kQgFmFFLZ1TtZrUQSF
         CHzg==
X-Gm-Message-State: AJIora+zfmCaf1l3CKswmDXbcDS7c6P/ZSWYeAOD31K6gAXd05pVnJQO
        wbNuBctROisyfWNpNq+73NRCTw/FhP/O+OXpS1v2+LXibqNYlNQf34nfn7JSr0BDqOmGt66/1Hv
        siuY6p67zdvxpNHq5n9dkecx+
X-Received: by 2002:a05:6214:1cc7:b0:470:5371:26ff with SMTP id g7-20020a0562141cc700b00470537126ffmr27195888qvd.9.1656944926519;
        Mon, 04 Jul 2022 07:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s+cEeW2gwRYkbbRPlZwD0FkOkBtidH1s2JRvmcGTy0BEjr0apvXTfAN7/HCYrLoY47LtCk4Q==
X-Received: by 2002:a05:6214:1cc7:b0:470:5371:26ff with SMTP id g7-20020a0562141cc700b00470537126ffmr27195865qvd.9.1656944926191;
        Mon, 04 Jul 2022 07:28:46 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x2-20020ae9e902000000b006a6a6f148e6sm24374082qkf.17.2022.07.04.07.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:28:45 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     perex@perex.cz, tiwai@suse.com, vitalyr@opensource.cirrus.com,
        sbinding@opensource.cirrus.com, tanureal@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: hda/cs8409: change cs8409_fixups v.pins initializers to static
Date:   Mon,  4 Jul 2022 10:28:36 -0400
Message-Id: <20220704142836.636204-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
sound/pci/hda/patch_cs8409-tables.c:79:25: warning: symbol 'cs8409_cs42l42_pincfgs_no_dmic' was not declared. Should it be static?

cs8409_cs42l42_pincfgs_no_dmic is only used by cs8409_fixups table as an
initializer for the hda_fixup element v.pins.  Both are defined in the
patch_cs8408-table.c file but only cs8409_fixups is used externally in
patch_cs8409.c.  So cs8409_cs42l42_pincfgs_no_dmic should have a static
storage class specifier.

The other v.pins initializers in cs8409_fixups table, though declared
extern in patch_cs8409.h are also only used in patch_cs8409-tables.c.
So change all the v.pins initializers to static.

Fixes: 9e7647b5070f ("ALSA: hda/cs8409: Move arrays of configuration to a new file")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/hda/patch_cs8409-tables.c | 6 +++---
 sound/pci/hda/patch_cs8409.h        | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 4f4cc8215917..e0d3a8be2e38 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -68,7 +68,7 @@ const struct hda_verb cs8409_cs42l42_init_verbs[] = {
 	{} /* terminator */
 };
 
-const struct hda_pintbl cs8409_cs42l42_pincfgs[] = {
+static const struct hda_pintbl cs8409_cs42l42_pincfgs[] = {
 	{ CS8409_PIN_ASP1_TRANSMITTER_A, 0x042120f0 },	/* ASP-1-TX */
 	{ CS8409_PIN_ASP1_RECEIVER_A, 0x04a12050 },	/* ASP-1-RX */
 	{ CS8409_PIN_ASP2_TRANSMITTER_A, 0x901000f0 },	/* ASP-2-TX */
@@ -76,7 +76,7 @@ const struct hda_pintbl cs8409_cs42l42_pincfgs[] = {
 	{} /* terminator */
 };
 
-const struct hda_pintbl cs8409_cs42l42_pincfgs_no_dmic[] = {
+static const struct hda_pintbl cs8409_cs42l42_pincfgs_no_dmic[] = {
 	{ CS8409_PIN_ASP1_TRANSMITTER_A, 0x042120f0 },	/* ASP-1-TX */
 	{ CS8409_PIN_ASP1_RECEIVER_A, 0x04a12050 },	/* ASP-1-RX */
 	{ CS8409_PIN_ASP2_TRANSMITTER_A, 0x901000f0 },	/* ASP-2-TX */
@@ -279,7 +279,7 @@ const struct hda_verb dolphin_init_verbs[] = {
 	{} /* terminator */
 };
 
-const struct hda_pintbl dolphin_pincfgs[] = {
+static const struct hda_pintbl dolphin_pincfgs[] = {
 	{ 0x24, 0x022210f0 }, /* ASP-1-TX-A */
 	{ 0x25, 0x010240f0 }, /* ASP-1-TX-B */
 	{ 0x34, 0x02a21050 }, /* ASP-1-RX */
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 260388a6256c..2a8dfb4ff046 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -358,13 +358,11 @@ extern const struct snd_pci_quirk cs8409_fixup_tbl[];
 extern const struct hda_model_fixup cs8409_models[];
 extern const struct hda_fixup cs8409_fixups[];
 extern const struct hda_verb cs8409_cs42l42_init_verbs[];
-extern const struct hda_pintbl cs8409_cs42l42_pincfgs[];
 extern const struct cs8409_cir_param cs8409_cs42l42_hw_cfg[];
 extern const struct cs8409_cir_param cs8409_cs42l42_bullseye_atn[];
 extern struct sub_codec cs8409_cs42l42_codec;
 
 extern const struct hda_verb dolphin_init_verbs[];
-extern const struct hda_pintbl dolphin_pincfgs[];
 extern const struct cs8409_cir_param dolphin_hw_cfg[];
 extern struct sub_codec dolphin_cs42l42_0;
 extern struct sub_codec dolphin_cs42l42_1;
-- 
2.27.0

