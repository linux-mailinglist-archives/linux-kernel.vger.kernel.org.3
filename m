Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61095260D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379830AbiEMLPl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbiEMLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:15:37 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B95C5DA12;
        Fri, 13 May 2022 04:15:34 -0700 (PDT)
Received: from smtpclient.apple (p4ff9f69b.dip0.t-ipconnect.de [79.249.246.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 40C18CED39;
        Fri, 13 May 2022 13:15:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: btintel: Correctly declare all module firmware
 files.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220509163259.1513242-1-dimitri.ledkov@canonical.com>
Date:   Fri, 13 May 2022 13:15:32 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3EA82A93-D167-482D-AAF4-D781B77A4646@holtmann.org>
References: <20220509163259.1513242-1-dimitri.ledkov@canonical.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dimitri,

> Correctly declare wildcard of module firmwares to include, as the
> driver & linux-firmware ship many sfi/ddc files for many different
> devices which are dynamically calculated and loaded by the driver.
> 
> This especially affects environments that only install firmware files
> declared and referenced by the kernel module. In such environments,
> only the declared firmware files were copied resulting in most Intel
> Bluetooth devices not working. I.e. host-only dracut-install initrds,
> or Ubuntu Core kernel snaps.
> 
> BugLink: https://bugs.launchpad.net/bugs/1970819
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
> drivers/bluetooth/btintel.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 06514ed66022..9f5fc1ab154d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2654,7 +2654,5 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION);
> MODULE_LICENSE("GPL");
> -MODULE_FIRMWARE("intel/ibt-11-5.sfi");
> -MODULE_FIRMWARE("intel/ibt-11-5.ddc");
> -MODULE_FIRMWARE("intel/ibt-12-16.sfi");
> -MODULE_FIRMWARE("intel/ibt-12-16.ddc");
> +MODULE_FIRMWARE("intel/ibt-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-*.ddc");

NAK, we should just declare any missing firmwares. The tables inside the driver are pretty clear on what hardware is marked as supported. It just seems someone forgot to add the firmware files for it.

Regards

Marcel

