Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB84F8470
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbiDGQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbiDGQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:00:15 -0400
Received: from 13.mo582.mail-out.ovh.net (13.mo582.mail-out.ovh.net [188.165.56.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F1D39B1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:58:12 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.111.172.176])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 345C923A8D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:19:30 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 9BEC22932FE43;
        Thu,  7 Apr 2022 15:19:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G003fbe37ff8-48bc-4f04-b220-b5b9d6c02b3b,
                    5995496A90EC26C6A3824F4C00BBD29EFE55D398) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 00/10] clk: switch to simple i2c probe function
Date:   Thu,  7 Apr 2022 17:18:21 +0200
Message-Id: <20220407151831.2371706-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 72620546474870406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejkedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches updates i2c probes in clk to use the simple
probe variant (simple as in "single argument"), probe_new, following
one of two scenarios.

In the first scenario, the existing probe function

int (*probe)(struct i2c_client *client, const struct i2c_device_id *id);

(see struct i2c_driver in include/linux/i2c.h) doesn't use the id
argument, so it can be trivially converted to

int (*probe_new)(struct i2c_client *client);

and the i2c_driver declaration updated to use .probe_new instead of
.probe.

In the second scenario, the probe function does use the id argument.
In this case, the relevant part of the calling code,

        /*
         * When there are no more users of probe(),
         * rename probe_new to probe.
         */
        if (driver->probe_new)
                status = driver->probe_new(client);
        else if (driver->probe)
                status = driver->probe(client,
                                       i2c_match_id(driver->id_table, client));
        else
                status = -EINVAL;

(from drivers/i2c/i2c-core-base.c) is moved down into the probe
function, typically along the lines of

const struct i2c_device_id *id = i2c_match_id(ids, id);

where ids is the i2c_device_id table. The latter needs to be declared
before the probe function; as suggested by Wolfram Sang, the full
definition is moved above the probe function.

Changes since v1:
  - the pair of patches have been split up into a single patch series
    with one patch per modified file, and the commit titles adjusted
    accordingly
  - renesas-pcie has been added


Stephen Kitt (10):
  clk: cdce706: use simple i2c probe function
  clk: cdce925: use i2c_match_id and simple i2c probe
  clk: cs2000-cp: use simple i2c probe function
  clk: max9485: use simple i2c probe function
  clk: si514: use simple i2c probe function
  clk: si5341: use simple i2c probe function
  clk: si5351: use i2c_match_id and simple i2c probe
  clk: si544: use i2c_match_id and simple i2c probe
  clk: si570: use i2c_match_id and simple i2c probe
  clk: renesas-pcie: use simple i2c probe function

 drivers/clk/clk-cdce706.c      |  5 ++---
 drivers/clk/clk-cdce925.c      | 24 ++++++++++++------------
 drivers/clk/clk-cs2000-cp.c    |  5 ++---
 drivers/clk/clk-max9485.c      |  5 ++---
 drivers/clk/clk-renesas-pcie.c |  4 ++--
 drivers/clk/clk-si514.c        |  5 ++---
 drivers/clk/clk-si5341.c       |  5 ++---
 drivers/clk/clk-si5351.c       | 24 ++++++++++++------------
 drivers/clk/clk-si544.c        | 22 +++++++++++-----------
 drivers/clk/clk-si570.c        | 24 ++++++++++++------------
 10 files changed, 59 insertions(+), 64 deletions(-)

-- 
2.27.0

