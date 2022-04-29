Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A70514E73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378001AbiD2O5t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Apr 2022 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377984AbiD2O5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:57:47 -0400
X-Greylist: delayed 242 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Apr 2022 07:54:27 PDT
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB0DBE9C1;
        Fri, 29 Apr 2022 07:54:27 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2ea3.dip0.t-ipconnect.de [91.61.46.163])
        by mail.holtmann.org (Postfix) with ESMTPSA id B4274CED22;
        Fri, 29 Apr 2022 16:54:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
Date:   Fri, 29 Apr 2022 16:54:25 +0200
Cc:     Andy Gross <agross@kernel.org>, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_saluvala@quicinc.com, quic_rjliao@quicinc.com,
        mcchou@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0D3D8346-0F64-4CAF-8BED-940F189A3E97@holtmann.org>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
To:     Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> The patch is workaround for hardware issue on WCN6750.
> On WCN6750 sometimes observed AON power source takes 100ms
> time to fully discharge voltage during OFF. As WCN6750 is
> combo chip for WLAN and BT. If any of the tech area ON is
> triggered during discharge phase, it fails to turn ON.
> To overcome this hardware issue, During BT ON, driver check
> for WLAN_EN pin status. If it high, it will pull BT_EN to high
> immediately else it will wait for 100ms assuming WLAN was just
> powered OFF and then BT_EN will be pulled to high.
> 
> Fixes: d8f97da1b92d2 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> ---
> drivers/bluetooth/hci_qca.c | 30 ++++++++++++++++++++++++------
> 1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index eab34e2..c3862d1 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -219,6 +219,7 @@ struct qca_serdev {
> 	struct hci_uart	 serdev_hu;
> 	struct gpio_desc *bt_en;
> 	struct gpio_desc *sw_ctrl;
> +	struct gpio_desc *wlan_en;
> 	struct clk	 *susclk;
> 	enum qca_btsoc_type btsoc_type;
> 	struct qca_power *bt_power;

I am really against these intermixing of Bluetooth and WiFi details. There is work ongoing to do some sequence power procedure. Maybe that is something you should look into. This is a mess.

And again, we are still hacking around hci_qca.c instead of writing a clean serdev only driver for this hardware. I have the feeling that nobody listens to review comments these days. It is just hacking patches together to get hardware enabled somehow and then disappear.

Regards

Marcel

