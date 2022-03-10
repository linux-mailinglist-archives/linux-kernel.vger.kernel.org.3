Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6704D3EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiCJBRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiCJBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:17:43 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91B125591;
        Wed,  9 Mar 2022 17:16:43 -0800 (PST)
Received: from 1nS7Py-0008LB-Vq by out3a.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS7Q1-0008O6-Te; Wed, 09 Mar 2022 17:16:41 -0800
Received: by emcmailer; Wed, 09 Mar 2022 17:16:41 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3a.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS7Py-0008LB-Vq; Wed, 09 Mar 2022 17:16:38 -0800
Received: from tsdebian.Massive (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 1A9591AAC;
        Wed,  9 Mar 2022 18:16:38 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH v3 0/2] gpio: ts4900: Do not set DAT and OE together 
Date:   Wed,  9 Mar 2022 17:16:15 -0800
Message-Id: <20220310011617.29660-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=jKCdU384I5hqfWrPI4Nn57HKMO5xV5vRsz52SSYuEro=;b=CpE4fMQXaTu7lWEox7S5x8F85VW+P5uqijVib1MElgI2LFEC9FlHYgd6WgHMhfNtWnksDH6/xEXm2E1JaQVrhukvqxkYWDC0+HIslRC+19eIDZENaiFPA2ue+6jF/dQVNlYVXsJKCoop8bFRKoVgt66L9pL/rpI3O9r8sVxkl88GI44+uJuAa9/Y3JXfLEJauBHuoqIyOt36gE9l5WikFeSgqzbY2qzVNps0KNs56hpQ35soMwQLn1ssYLpK4MNzUtq1FS19qkZR+BI0FTB6hohfe3nW3DUOmiWTI23v4mC4YH5YOvp9T2j7RsnCGUTly5TRxL8NKYwcpdltdUaPGQ==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work around hardware race condition when setting DAT and OE in same
transaction. Also clean up license boilerplate and use SPDX.

I was not sure if it was preferred to make it a series or individual
patches. I went with series because "gpio: ts4900: Use SPDX header"
cannot cleanly apply by itself due to copyright year changes in the fix
commit. If this is not preferred, please let me know.

V3:
- Move addition of SPDX identifier to separate commit
- Remove license boilerplate in file

V2:
- Add Fixes tag

Kris Bahnsen (1):
  gpio: ts4900: Use SPDX header

Mark Featherston (1):
  gpio: ts4900: Do not set DAT and OE together

 drivers/gpio/gpio-ts4900.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

-- 
2.11.0

