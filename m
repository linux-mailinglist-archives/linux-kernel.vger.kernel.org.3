Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93171574775
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiGNIov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiGNIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:44:50 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 01:44:46 PDT
Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A359140BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:44:46 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id BuRhoA7r5bvrcBuRhoFpeR; Thu, 14 Jul 2022 10:43:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1657788223; bh=un5pkqfd2ZfN3kAgLbVdkbNuttBIuRIZqLiIVNxtmm0=;
        h=From:To:Subject:Date:MIME-Version;
        b=VcKVUrh9ALrfwKAd1fyn+xZ86elbjwsChsz6IA1WNykRl8ShfTJyq3J6Hr0AQP+Uw
         PZqSL4uMz1YUy2RPEhsYPLcCrnxHciTazcVbmZclEkQc3oyjvxKqDrDK6XlOLOkwEW
         oAANdsVYeSfLTWPNAVgh8gy7ZVt53xOnKNcqmYEbcD+VbZdd9/Jkw3l/bufTpSqMmy
         l0UQK4o7dJtCOXbnX66HvxuPRW6953oThMVgqI5cdoZXh5KS9pfiXm5YljL+OpNlB+
         f8lt/CgEP5Jra9WfHYGH1r42UAAzTuyavRCYNZPANVg4pHOt6yYaSwL8729WUGcSiD
         dAr/v/XPS0lGw==
From:   Luca Ellero <luca.ellero@brickedbrain.com>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <luca.ellero@brickedbrain.com>
Subject: [PATCH 0/3] ads7846: fix support for ADS7845
Date:   Thu, 14 Jul 2022 10:43:16 +0200
Message-Id: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJnqr8V9hEAPp0TQjknV0VYIUN0jcm5nlRIOl5/wxcXF4/OLMi5z9dAF1ZXNIlF2XJmasse8Z9TFU47LOS9Fayaq4aOUj66YbXyrCFAc3xNWNbnsX/6Q
 Baw2qTeAQ82KlwlNTok36NShF7GQkOcYFGgq74p9KXCl+s/yf/97D7KmNBJaFBFiQyrpmh6+nyuaoHuuIRW9P/Kcq/6um2HAaFTrE7IgrapKSThbgFZz6/Of
 ROT7kSwzfpNDEHAIr2yEygSOFn27d9hGJThkKcQm4/uc8LvuJnVnlPh9suS2WCLm/ttBtU9yzZxoaSD3B7JhXwEWKnMvVSMbSkaXCidiRVOF3vm+g3t/mwRO
 935XtkrAfdqV6TCTdmKsNFJoPspw+kAQCWi6s2oE5UgJK3Ww25NxPUbkoJMlhDnRaJISlRDe9JHEsc9NzGpLCx8PTDXSaS9APBAIRX1aWcBMMwG3IOl5koVg
 ornOlIEvSsuDzeExTlUfCBds4q9v293b7K/U3i5uNZuKdujtlt/IOyJi7V3oRuYuhqDZaZ62LelGKvJrmSrto6LqEIqk1/qWjeXk7+A9fobp0zDMVPKb/TA5
 OkH4AZ81FaNyWU6cL6Gi5oeW
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADS7845 support is buggy in this driver.
These patches fix various issues to get it work properly.

Luca Ellero (3):
  ads7846: don't report pressure for ads7845
  ads7846: always set last command to PWRDOWN
  ads7846: don't check penirq immediately for 7845

 drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.25.1

