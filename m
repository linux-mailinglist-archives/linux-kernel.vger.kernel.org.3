Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C262546338
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346359AbiFJKL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiFJKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:11:27 -0400
X-Greylist: delayed 1921 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 03:11:26 PDT
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449AF59952;
        Fri, 10 Jun 2022 03:11:26 -0700 (PDT)
Received: from [77.244.183.192] (port=62076 helo=[192.168.178.39])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nzb6u-0005wd-FV;
        Fri, 10 Jun 2022 11:39:20 +0200
Message-ID: <0fd31531-63a3-46a7-cf0b-9641d7f32a1f@lucaceresoli.net>
Date:   Fri, 10 Jun 2022 11:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/8] clk: vc5: Fix 5P49V6901 outputs disabling when
 enabling FOD
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
References: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
 <20220610072124.8714-3-Sergey.Semin@baikalelectronics.ru>
From:   Luca Ceresoli <luca@lucaceresoli.net>
In-Reply-To: <20220610072124.8714-3-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

thank you for your patch!

On 10/06/22 09:21, Serge Semin wrote:
> We have discovered random glitches during the system boot up procedure.
> The problem investigation led us to the weird outcomes: when none of the
> Renesas 5P49V6901 ports are explicitly enabled by the kernel driver, the
> glitches disappeared. It was a mystery since the SoC external clock
> domains were fed with different 5P49V6901 outputs. The driver code didn't
> seem like bogus either. We almost despaired to find out a root cause when
> the solution was found for a more modern revision of the chip. It turned
> out the 5P49V6901 clock generator stopped its output for a short period of
> time during the VC5_OUT_DIV_CONTROL register writing. The same problem has
> was found for the 5P49V6965 revision of the chip and the was successfully
> fixed in commit fc336ae622df ("clk: vc5: fix output disabling when
> enabling a FOD") by enabling the "bypass_sync" flag hidden inside "Unused
> Factory Reserved Register". Even though the 5P49V6901 registers
> description and programming guide doesn't provide any intel regarding that
> flag, setting it up anyway in the officially unused register completely
> eliminated the denoted glitches. Thus let's activate the functionality
> submitted in commit fc336ae622df ("clk: vc5: fix output disabling when
> enabling a FOD") for the Renesas 5P49V6901 chip too in order to remove
> the ports implicit inter-dependency.

Sadly, you have been through the same troubles I had on the 6965.

> Fixes: dbf6b16f5683 ("clk: vc5: Add support for IDT VersaClock 5P49V6901")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

(not sure which address is appropriate as I sent patches to update to
the Bootlin one and they are being applied one y one on the various
maintainers branches)

-- 
Luca
