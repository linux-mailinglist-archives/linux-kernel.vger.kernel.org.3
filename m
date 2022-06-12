Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E08547BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiFLTYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiFLTX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 15:23:58 -0400
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550692E6B7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 12:23:56 -0700 (PDT)
Received: from player735.ha.ovh.net (unknown [10.110.208.43])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 5775122761
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 19:23:54 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player735.ha.ovh.net (Postfix) with ESMTPSA id 0C6A72B3DD8AF;
        Sun, 12 Jun 2022 19:23:48 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 12 Jun 2022 21:23:47 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Dianlong Li <long17.cool@163.com>,
        Wolfram Sang <wsa@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: use simple i2c probe
In-Reply-To: <YqSnwf7paZa1+uuh@mail.local>
References: <20220610162346.4134094-1-steve@sk2.org>
 <YqSnwf7paZa1+uuh@mail.local>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2bd6ab78f649ba282c5369d0e969fea2@sk2.org>
X-Sender: steve@sk2.org
X-Originating-IP: 82.65.25.201
X-Webmail-UserID: steve@sk2.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4416342386368415366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudduhedgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepkeffueehgfegteelveeigffgheegkefhleeukefhfedtiedvvdekgeehfeekffegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhe
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Le 11/06/2022 16:48, Alexandre Belloni a écrit :
> On 10/06/2022 18:23:43+0200, Stephen Kitt wrote:
>> All these drivers have an i2c probe function which doesn't use the
>> "struct i2c_device_id *id" parameter, so they can trivially be
>> converted to the "probe_new" style of probe with a single argument.
>> 
> 
> I think you should explain why you want to do that as the trend is to 
> do
> the exact opposite to allow support for those RTCS on x86 systems.

Indeed, I should have given more context. The idea is to continue the 
transition started with 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8a1a4cd5a98a2adf8dfd6902cd98e57d910ee12 
(in 2016...). I²C drivers using probe() involve a call to i2c_match_id: 
in drivers/i2c/i2c-core-base.c,

         /*
          * When there are no more users of probe(),
          * rename probe_new to probe.
          */
         if (driver->probe_new)
                 status = driver->probe_new(client);
         else if (driver->probe)
                 status = driver->probe(client,
                                        i2c_match_id(driver->id_table, 
client));
         else
                 status = -EINVAL;

Many drivers don't actually need the second parameter, so instead of 
having probe() with both parameters, the goal is to switch to a probe 
function with only "struct i2c_client *". Probe functions that *do* need 
the "struct i2c_device_id" can call i2c_match_id themselves (as is done 
currently with of_match_id).

I discussed this briefly with Wolfram beginning of June at Kernel 
Recipes, and as I understood it the plan was still to continue with this 
transition (in fact, the plan was for *me* to continue with this 
transition).

Do you have an example of a change requiring id to support RTCs on x86 
systems?

Regards,

Stephen
