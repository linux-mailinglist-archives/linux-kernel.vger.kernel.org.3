Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FAD5ACF0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiIEJmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiIEJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:42:38 -0400
X-Greylist: delayed 7798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Sep 2022 02:42:35 PDT
Received: from 10.mo581.mail-out.ovh.net (10.mo581.mail-out.ovh.net [178.33.250.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83C4E856
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:42:34 -0700 (PDT)
Received: from player778.ha.ovh.net (unknown [10.111.208.76])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 00D9E23C28
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:15:36 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player778.ha.ovh.net (Postfix) with ESMTPSA id 8380C2E205F4C;
        Mon,  5 Sep 2022 07:15:28 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 05 Sep 2022 09:15:28 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: iproc: Do not rely on node name for correct PLL
 setup
In-Reply-To: <2cd712a5ae4fc0bf93e5b16ea640f1dc@milecki.pl>
References: <20220803025836.107886-1-f.fainelli@gmail.com>
 <2cd712a5ae4fc0bf93e5b16ea640f1dc@milecki.pl>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d2ad5cda0e9786e43d5cd235e5dcec59@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11680085637051165659
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelhedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhgpofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgfefuefgleeffefhvefgueeffeeftdeljeevkefhudffheffheegvedukeejlefhnecuffhomhgrihhnpehsphhinhhitghsrdhnvghtnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekud
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-04 17:00, Rafał Miłecki wrote:
> On 2022-08-03 04:58, Florian Fainelli wrote:
>> After commit 31fd9b79dc58 ("ARM: dts: BCM5301X: update CRU block
>> description") a warning from clk-iproc-pll.c was generated due to a
>> duplicate PLL name as well as the console stopped working. Upon closer
>> inspection it became clear that iproc_pll_clk_setup() used the Device
>> Tree node unit name as an unique identifier as well as a parent name 
>> to
>> parent all clocks under the PLL.
>> 
>> BCM5301X was the first platform on which that got noticed because of 
>> the
>> DT node unit name renaming but the same assumptions hold true for any
>> user of the iproc_pll_clk_setup() function.
>> 
>> The first 'clock-output-names' property is always guaranteed to be
>> unique as well as providing the actual desired PLL clock name, so we
>> utilize that to register the PLL and as a parent name of all children
>> clock.
>> 
>> Fixes: 5fe225c105fd ("clk: iproc: add initial common clock support")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> 
> 
> Thanks for looking into this!
> 
> In the past I debugged this too and even developed a simple fix:
> clk & clock-controller@ DT nodes: __clk_core_init: clk
> clock-controller already initialized
> https://www.spinics.net/lists/linux-clk/msg63855.html
> 
> For some reason my old fix didn't work with usbclk clock.

I compared your changes with my old attempt and found the missing bit. I
forgot about updating parent_name.

FWIW something like below would work too.

Thanks again for taking care of this old regression.


diff --git a/drivers/clk/bcm/clk-iproc-pll.c 
b/drivers/clk/bcm/clk-iproc-pll.c
index 33da30f99..af9ca32b8 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -783,7 +783,7 @@ void iproc_pll_clk_setup(struct device_node *node,
  	iclk = &iclk_array[0];
  	iclk->pll = pll;

-	init.name = node->name;
+	init.name = node->full_name;
  	init.ops = &iproc_pll_ops;
  	init.flags = 0;
  	parent_name = of_clk_get_parent_name(node, 0);
@@ -809,7 +809,7 @@ void iproc_pll_clk_setup(struct device_node *node,
  		const char *clk_name;

  		memset(&init, 0, sizeof(init));
-		parent_name = node->name;
+		parent_name = node->full_name;

  		ret = of_property_read_string_index(node, "clock-output-names",
  						    i, &clk_name);
