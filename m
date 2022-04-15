Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23E1502D50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355646AbiDOPuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355626AbiDOPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:50:38 -0400
Received: from 6.mo560.mail-out.ovh.net (6.mo560.mail-out.ovh.net [87.98.165.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B1986F1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:48:09 -0700 (PDT)
Received: from player788.ha.ovh.net (unknown [10.109.156.38])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id C3B7E220EE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:38:30 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 6317F29866F4A;
        Fri, 15 Apr 2022 15:38:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R00314cd0484-1fc4-4138-bc82-0aa4ef2f9df0,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 0/6] ASoC: remaining i2c_match_id i2c probe changes
Date:   Fri, 15 Apr 2022 17:38:11 +0200
Message-Id: <20220415153817.141364-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10481565184974554758
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series covers all the remaining changes to migrate
sound/soc/codecs i2c probes to probe_new, where the const struct
i2c_client * argument is still used. Instead of relying on the
parameter passed in, i2c_match_id is used instead.

With this set of patches, all the sound/soc/codecs i2c probes use the
new probe definition.

Stephen Kitt (6):
  ASoC: ak*: use i2c_match_id and simple i2c probe
  ASoC: alc56*: use i2c_match_id and simple i2c probe
  ASoC: max980*: use i2c_match_id and simple i2c probe
  ASoC: pcm186x: use i2c_match_id and simple i2c probe
  ASoC: tas*: use i2c_match_id and simple i2c probe
  ASoC: tlv320*: use i2c_match_id and simple i2c probe

 sound/soc/codecs/ak4613.c            | 10 +++++----
 sound/soc/codecs/ak4642.c            |  8 ++++---
 sound/soc/codecs/alc5623.c           | 24 +++++++++++----------
 sound/soc/codecs/alc5632.c           | 20 +++++++++--------
 sound/soc/codecs/max98088.c          | 21 +++++++++---------
 sound/soc/codecs/max98090.c          | 23 ++++++++++----------
 sound/soc/codecs/max98095.c          | 19 +++++++++--------
 sound/soc/codecs/pcm186x-i2c.c       | 24 ++++++++++-----------
 sound/soc/codecs/tas2562.c           | 25 +++++++++++-----------
 sound/soc/codecs/tas571x.c           | 11 ++++++----
 sound/soc/codecs/tas5720.c           | 21 +++++++++---------
 sound/soc/codecs/tlv320adc3xxx.c     | 21 +++++++++---------
 sound/soc/codecs/tlv320aic31xx.c     | 32 ++++++++++++++--------------
 sound/soc/codecs/tlv320aic32x4-i2c.c | 11 ++++++----
 14 files changed, 145 insertions(+), 125 deletions(-)


base-commit: 5d763a740e5b24e4a2ca04317255e7e941876338
-- 
2.27.0

