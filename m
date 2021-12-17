Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DBA479788
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhLQXad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:30:33 -0500
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:38368
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231162AbhLQXab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:30:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdAuEpOVsL8hqxAyXFGTQbe/LdRIWQst8FO85tr1FMu+L/CkD/cJFUqIf8E5AODo5jh8gqYxYd85sxEHaXw1s+H/8atjxgcrOysu0Xg/Fxet2X4aMN+daPKbCvpRWxnyfVGkV9Vit6QvEBOeE20KMc7bzLiwGYWuB/+Qr16giEGTun8FK0o2YsndmPMkAAF5BN1cuIAg0Xjf7mYKIkBG3TL8RbBJTCxW9lqKHDPDLFvQuwPrwD4bKPaEF75/DYlL5mQ9N5dDPSrFs+EMzublbqg320wZfzrEiaRk5USyQ2T0REz14nguLNLFJIuKaWdIjYTM3rEBMcQVj/MCMs6jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4eKhc7vsqyBeZi8j2OiDSlvmVMWzgD04CF12vFXpiU=;
 b=ayuBFxJmT6ZZwZId9eYAHO/YHF7GUs0Sa2rLtJwadJfYm9E8PC+UDzekTD3qbCamwUBhCdq2qg2hHY7vvZbBOnRdPAqDeK+eBR+HXW4JLbRzdKBnbauSPZogl4cocdswfdc31xbCulrlDBCdI5xEC7Y4hqBHKk7K9PXbw1qtyT+dnWZkFrqJZHgBLH39LNF+O6fQ37Klo6qudLVEXFwQPf4oTvjiB7v4s66vjjLNiWwflFX/5A4kcKYCiu4Dihd6wYijtSsICrtNiCf93CpngVRIOasLLFxqF4u9e25F8U4gnfndxWFgnTVD0RIQS+ar0tfGzEwwMoFgycuvtG+GBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4eKhc7vsqyBeZi8j2OiDSlvmVMWzgD04CF12vFXpiU=;
 b=j5CKS9lFtJ62ay/ibP5m9uwf/1EhCGG/Iz6PfHWc9NEeUQwx10/PjFCvm2d9ilL612I7HHEC0vV/J1BXw587Pr+xYNvDtFagWkpC1V+JtWbwDuXYJ7+D+wm2rjdBKFYy9LaaBg1AEN1hXQdrz94lvgjAGZErzzKcK1oPCHdKMLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5142.eurprd03.prod.outlook.com (2603:10a6:10:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 23:30:28 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee%4]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 23:30:28 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     michal.simek@xilinx.com, Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v12 2/2] pwm: Add support for Xilinx AXI Timer
Date:   Fri, 17 Dec 2021 18:30:15 -0500
Message-Id: <20211217233015.67664-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217233015.67664-1-sean.anderson@seco.com>
References: <20211217233015.67664-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0039.prod.exchangelabs.com
 (2603:10b6:208:25::16) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c95dd71b-13d7-4f00-ceb7-08d9c1b535c0
X-MS-TrafficTypeDiagnostic: DBBPR03MB5142:EE_
X-Microsoft-Antispam-PRVS: <DBBPR03MB5142D3F27B8C9C217C9B4B8496789@DBBPR03MB5142.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYlXGrTX99Z9htb0fkPhNXODFBCYwTMCoUYHevVXVpNau5bMDAdJpPSDxPj3199Nt54sNWy7VQea5m/j04W0fDwLHG4qYNEYYPvaR3als/XhmdsW2uEr44F7ELHTPHlJQ73yuwcYXDO8+oJL/lwg2o95IcqV1adaVfIvSlPZiUUwDy7bQEEhH6qAL+jC3T2Z4pUYHrcS2tSk2d15pweTwZPcr7YtFlgxNteTzz+LG37JvvbtgKma1E00b9ssvR4dgOzY9jGTNPqD3ll7qPAjKFma+JeaPwuy8iRDE4FBoVjfiPd7pcJQ65LqokhvD5n3yc7brRGBrqH00bf+M1kQH+Rcf3o3pTcAtwnm0lrkGMY1KtPvTZ9GST9eYUdTfrreJQC+uopJEnnvr7NFmIdHK5Yb2X3qeE2Au86dMmtsJd2t+aoBQntK1bNAwcJtLgHNFKAtwXAmap1JUpcWb87kXGWDyAvsSwR1L3Y64BsBC7iJocOdW8Rh8bq6K8g6jXrRKhj5Xm9BxPwKlJQfxYOgcJYNyHsel0ISRkIbUBuvtFA76lsKra/P0Brl2P2Db/MsbrnZek8qakzyK+LsK5y7w5l/jd0CHw3j+uQgG7g4ZVgeb+eNbFPrYs+el5RFZh1M3Tw64eQIydvzNxFdV3RlJV7JPBp+lK5datVz66jTfm16q48a15DrjmnmRk/06BJEancu8j4i8TNTwsVavsu3FYFUxxnMLhDMugo4ml19VeFq7MyDDCVxccVWz8l9DDdhnULXOtt1yJQLHETBYim5mSpQBB64sXYaUQAad3TBoWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(8936002)(6666004)(52116002)(83380400001)(316002)(6506007)(66556008)(107886003)(6916009)(2616005)(2906002)(86362001)(508600001)(66476007)(30864003)(7416002)(186003)(4326008)(966005)(5660300002)(1076003)(66946007)(26005)(36756003)(6486002)(6512007)(38100700002)(8676002)(54906003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRlS3VjZzBOQkE1NnlERlpONEYzN3VpVi9zTG1UUEdjUDRBbkYvZkxnSlJt?=
 =?utf-8?B?RjE3bXNkSXNZSmVESWVrdVptTm5lc0U0bFZpZXJTY3dadEZlQ21nZnFpTDgv?=
 =?utf-8?B?K2RPRkU0WWFEZ2RybnI0TUs5K2JkVkNKemt5TUVIUUQwYUVQbEZoWmlPSGhN?=
 =?utf-8?B?emFUN0dsNmpERGQwdXNnM3Z2TFN2eVZLNGlxSWVxbVdqd1AwRkFvOWVKYmFH?=
 =?utf-8?B?dmV0RDVIbU0vR0gvd1p1UEhHQ3FNRnEzb1ZuTFh4TllKN1Q3NmZ1SURYMU1F?=
 =?utf-8?B?aDhWdE5Jb09yRlZhV1V5dGEvcWlKVVJWb1UrbS9EbFhEYUc5dlRaSG8xanJk?=
 =?utf-8?B?V29Td3pZNWdRc0QxVXhna1I2TnpCRUgrb3hEbHJaeERxUUZuQkpOL1NqcEVY?=
 =?utf-8?B?Y0plU3drdklWOElxUTVYRkNYZFlua21kd01tSE1RcXZVVW84UG05WDFvVXdJ?=
 =?utf-8?B?NWhTc3VlcEtJSG9kaHBnZXdSUkJVc0pnWWxDK01mK0NlTjErZDY3Z1pVR0px?=
 =?utf-8?B?RllLdE15ZFR4WE53LzUwaVpHZHQ5RDFsQW1yaEdLL1pSNXNEWlVubExMbmtP?=
 =?utf-8?B?S3NObXllaXVia01CTTR0T0xEc3l0WmFiT01UTGQyUkFRZ3k5TkNKU0JFeW5D?=
 =?utf-8?B?cXY5QTY4c3JTUHhaUkRkVkVPK2tiQ3pMczNoNW83TE5QaHpTdkNQKzNEQ0cy?=
 =?utf-8?B?My9aa3lsVm9TRFB1ZUJycm55cXNLQi9jQUxvZ1dTb1BNQ2pKZFdydnN3NWNT?=
 =?utf-8?B?Sy9pTzJDZ09UK05TQ0VyaFliYWpsOTlha1YxZC9YQzlhS1VZeWV1ZC9qem9v?=
 =?utf-8?B?WGlzTzNvbzJObXdQTUNYek82NzRsWEhQUkNmWnZYcVg2aG0yRER1Z3ZMQ3Az?=
 =?utf-8?B?L2E1VEErQzdERHNVTk92dzVkUU5xcmtLUTgxWkhHTEdwM3dyajRONm5mZ3kz?=
 =?utf-8?B?Wm4zbVhLNzl6QlFHNHBOcEpPcHIzQ0hQK2lNVXZzbDNWamNpZUd5bjNTZG5x?=
 =?utf-8?B?VVM0ZnNDaUdSeFh0Um9ia09iZkc4RExZWXMvRkFZNkNoaGhtaFpUZDRPSDIr?=
 =?utf-8?B?bi9qVjJ3cC9XWXhLZGxOeXE2ZTI2bXhYS3RnVVNNM2paRm90OXpTa1NqR0JK?=
 =?utf-8?B?WWpaRWtrVHd5YXV1STRxRzAybENHOFZLWGZod1drRG9JTG9ZUUxGRmpBTzZE?=
 =?utf-8?B?S1Z6TGd0S010Nm40UjVtQ2dGQUM1NU43Znc0cHRPWmZ2dVRpbW53QktEUXo5?=
 =?utf-8?B?MUE1RzNFZTJpTG1YS1NZbFNiY1ZKemlPYW5GZFVjS3hjaW5Ga0djSkhqWjA2?=
 =?utf-8?B?VDFtcGx3ME9FQ1h3NjA3aUd6Y1h3Q1M1eUlYVzlYUFdvcDRmSjRoNHV1YmM1?=
 =?utf-8?B?VUJGV0lxSkJWbkZBNFU3dnJ0YzRUa1RZK2VzY3JyNVErRE1tZXhBdGk1Ykdw?=
 =?utf-8?B?ZEVXV2UyWVdsNnRpYndNSEFkZ0hCazczbk9hRmRXMDJXTENhZk1MNUxFZW95?=
 =?utf-8?B?Qnc0c2lseGJ5YWFYbTlMTEhqOWVEVlZHNFpmckl5WTJMNFVCMTl4Z0tOUVFZ?=
 =?utf-8?B?QmtXTFFnQURCaEthZGs0YUh1OENYdkhFNU54RlZTYm5tUlg5c3hnZUVLT0FB?=
 =?utf-8?B?TGJvbE1oSG9MdXA1SmhsVHlwUlpISTJJVm5kZ2dBaTZHays4Y2JxcC9XdXNH?=
 =?utf-8?B?LzB5RnZvK0R2djBSeTc4WkM3dkw0UWQvbHZ0dUJTbktWTTdaZUpmb1dsZE9s?=
 =?utf-8?B?SDFqYmJ3OVNvd2dDQUJKQXRUNzU2ZVJRTUIrWkdoQ0NTbS90bUZ6TVNRNFVQ?=
 =?utf-8?B?bHNNZUIxRm03d3hJRXd3bzVGdUdIQ0FFTzdWV05SZENMcXg4Nlk2ckRIcjR0?=
 =?utf-8?B?RUFFL0Zid2l2TXYxNmY1a2poK05XSmRrSkNvZDdTS2gyOFR0TWdwUTJIbzNY?=
 =?utf-8?B?dmRCakJMZHY4TGFWaFhSclRESXRpM3lTc1JJUDlYOW45ZzhybXJjcEtMRWoz?=
 =?utf-8?B?eTB2Z1dCU3pVZS9BUWZzazFETFR5a3JVbFlxU1JiYTJrMDBQbFM4U01QS2Ex?=
 =?utf-8?B?eDlabldvd2lNdHJmNkNxYk1nSFI2bWlpTkxpakdBcms4Z2Z6SS9KL1NCTktJ?=
 =?utf-8?B?bmwreDJ2QlZZdTNiZFg0MUV5VWY2eGdnaS9Pc096VnFIdno4QkU1TEFXaTVP?=
 =?utf-8?Q?kPYuxWCwm0RS2JkaZPk+jTk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95dd71b-13d7-4f00-ceb7-08d9c1b535c0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 23:30:28.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlak/v7xx2ZEs95MtdskbP3jpgaBiuSje+gMfk5oFLzoQZq5MqypKbbzNlYpMMzYmSXANXpzRmkr9TnK3goQcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
found on Xilinx FPGAs. At the moment clock control is very basic: we
just enable the clock during probe and pin the frequency. In the future,
someone could add support for disabling the clock when not in use.

Some common code has been specially demarcated. While currently only
used by the PWM driver, it is anticipated that it may be split off in
the future to be used by the timer driver as well.

This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v12:
- Add a comment to the timer driver about #pwm-cells
- Combine/expand comments on rounding in xilinx_pwm_apply

Changes in v11:
- Add comment about why we test for #pwm-cells
- Clarify comment on generate out signal
- Rename pwm variables to xilinx_pwm
- Round like Uwe wants...
- s/xilinx_timer/xilinx_pwm/ for non-common functions

Changes in v10:
- Fix compilation error in timer driver

Changes in v9:
- Refactor "if { return } else if { }" to "if { return } if { }"
- Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
- Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe

Changes in v8:
- Drop new timer driver; it has been deferred for future series

Changes in v7:
- Add dependency on OF_ADDRESS
- Fix period_cycles calculation
- Fix typo in limitations

Changes in v6:
- Capitalize error messages
- Don't disable regmap locking to allow inspection of registers via
  debugfs
- Prevent overflow when calculating period_cycles
- Remove enabled variable from xilinx_pwm_apply
- Swap order of period_cycle range comparisons

Changes in v5:
- Allow non-zero #pwm-cells
- Correctly set duty_cycle in get_state when TLR0=TLR1
- Elaborate on limitation section
- Perform some additional checks/rounding in apply_state
- Remove xlnx,axi-timer-2.0 compatible string
- Rework duty-cycle and period calculations with feedback from Uwe
- Switch to regmap to abstract endianness issues
- Use more verbose error messages

Changes in v4:
- Don't use volatile in read/write replacements. Some arches have it and
  some don't.
- Put common timer properties into their own struct to better reuse
  code.
- Remove references to properties which are not good enough for Linux.

Changes in v3:
- Add clockevent and clocksource support
- Remove old microblaze driver
- Rewrite probe to only use a device_node, since timers may need to be
  initialized before we have proper devices. This does bloat the code a bit
  since we can no longer rely on helpers such as dev_err_probe. We also
  cannot rely on device resources being free'd on failure, so we must free
  them manually.
- We now access registers through xilinx_timer_(read|write). This allows us
  to deal with endianness issues, as originally seen in the microblaze
  driver. CAVEAT EMPTOR: I have not tested this on big-endian!

Changes in v2:
- Add comment describing device
- Add comment explaining why we depend on !MICROBLAZE
- Add dependencies on COMMON_CLK and HAS_IOMEM
- Cast dividends to u64 to avoid overflow
- Check for over- and underflow when calculating TLR
- Check range of xlnx,count-width
- Don't compile this module by default for arm64
- Don't set pwmchip.base to -1
- Ensure the clock is always running when the pwm is registered
- Remove debugfs file :l
- Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
- Report errors with dev_error_probe
- Set xilinx_pwm_ops.owner
- Use NSEC_TO_SEC instead of defining our own
- Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe

 MAINTAINERS                        |   6 +
 arch/microblaze/kernel/timer.c     |   4 +
 drivers/pwm/Kconfig                |  14 ++
 drivers/pwm/Makefile               |   1 +
 drivers/pwm/pwm-xilinx.c           | 319 +++++++++++++++++++++++++++++
 include/clocksource/timer-xilinx.h |  91 ++++++++
 6 files changed, 435 insertions(+)
 create mode 100644 drivers/pwm/pwm-xilinx.c
 create mode 100644 include/clocksource/timer-xilinx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 13f9a84a617e..373757fcc8c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20925,6 +20925,12 @@ F:	drivers/misc/Makefile
 F:	drivers/misc/xilinx_sdfec.c
 F:	include/uapi/misc/xilinx_sdfec.h
 
+XILINX PWM DRIVER
+M:	Sean Anderson <sean.anderson@seco.com>
+S:	Maintained
+F:	drivers/pwm/pwm-xilinx.c
+F:	include/clocksource/timer-xilinx.h
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index f8832cf49384..26c385582c3b 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -251,6 +251,10 @@ static int __init xilinx_timer_init(struct device_node *timer)
 	u32 timer_num = 1;
 	int ret;
 
+	/* If this property is present, the device is a PWM and not a timer */
+	if (of_property_read_bool(timer, "#pwm-cells"))
+		return 0;
+
 	if (initialized)
 		return -EINVAL;
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 21e3b05a5153..cefbf00b4c7e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -640,4 +640,18 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_XILINX
+	tristate "Xilinx AXI Timer PWM support"
+	depends on OF_ADDRESS
+	depends on COMMON_CLK
+	select REGMAP_MMIO
+	help
+	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
+	  typically a soft core which may be present in Xilinx FPGAs.
+	  This device may also be present in Microblaze soft processors.
+	  If you don't have this IP in your design, choose N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-xilinx.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 708840b7fba8..ea785480359b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
new file mode 100644
index 000000000000..b4d93e8812c6
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we may end up with one cycle
+ *   with the old duty cycle and the new period. This is because the counters
+ *   may only be reloaded by first stopping them, or by letting them be
+ *   automatically reloaded at the end of a cycle. If this automatic reload
+ *   happens after we set TLR0 but before we set TLR1 then we will have a
+ *   bad cycle. This could probably be fixed by reading TCR0 just before
+ *   reprogramming, but I think it would add complexity for little gain.
+ * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
+ *   possible by stopping the counters at an appropriate point in the cycle,
+ *   but this is not (yet) implemented.
+ * - Only produces "normal" output.
+ * - Always produces low output if disabled.
+ */
+
+#include <clocksource/timer-xilinx.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+/*
+ * The following functions are "common" to drivers for this device, and may be
+ * exported at a future date.
+ */
+u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
+			    u64 cycles)
+{
+	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
+
+	if (tcsr & TCSR_UDT)
+		return cycles - 2;
+	return priv->max - cycles + 2;
+}
+
+unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
+				     u32 tlr, u32 tcsr)
+{
+	u64 cycles;
+
+	if (tcsr & TCSR_UDT)
+		cycles = tlr + 2;
+	else
+		cycles = (u64)priv->max - tlr + 2;
+
+	/* cycles has a max of 2^32 + 2 */
+	return DIV64_U64_ROUND_UP(cycles * NSEC_PER_SEC,
+				  clk_get_rate(priv->clk));
+}
+
+/*
+ * The idea here is to capture whether the PWM is actually running (e.g.
+ * because we or the bootloader set it up) and we need to be careful to ensure
+ * we don't cause a glitch. According to the data sheet, to enable the PWM we
+ * need to
+ *
+ * - Set both timers to generate mode (MDT=1)
+ * - Set both timers to PWM mode (PWMA=1)
+ * - Enable the generate out signals (GENT=1)
+ *
+ * In addition,
+ *
+ * - The timer must be running (ENT=1)
+ * - The timer must auto-reload TLR into TCR (ARHT=1)
+ * - We must not be in the process of loading TLR into TCR (LOAD=0)
+ * - Cascade mode must be disabled (CASC=0)
+ *
+ * If any of these differ from usual, then the PWM is either disabled, or is
+ * running in a mode that this driver does not support.
+ */
+#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
+#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
+#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
+
+struct xilinx_pwm_device {
+	struct pwm_chip chip;
+	struct xilinx_timer_priv priv;
+};
+
+static inline struct xilinx_timer_priv
+*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
+{
+	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
+}
+
+static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
+{
+	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
+		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
+}
+
+static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
+			    const struct pwm_state *state)
+{
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+	u64 period_cycles, duty_cycles;
+	unsigned long rate;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * To be representable by TLR, cycles must be between 2 and
+	 * priv->max + 2. To enforce this we can reduce the cycles, but we may
+	 * not increase them. Caveat emptor: while this does result in more
+	 * predictable rounding, it may also result in a completely different
+	 * duty cycle (% high time) than what was requested.
+	 */
+	rate = clk_get_rate(priv->clk);
+	/* Avoid overflow */
+	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
+	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
+	period_cycles = min_t(u64, period_cycles, priv->max + 2);
+	if (period_cycles < 2)
+		return -ERANGE;
+
+	/* Same thing for duty cycles */
+	duty_cycles = min_t(u64, state->duty_cycle, ULONG_MAX * NSEC_PER_SEC);
+	duty_cycles = mul_u64_u32_div(duty_cycles, rate, NSEC_PER_SEC);
+	duty_cycles = min_t(u64, duty_cycles, priv->max + 2);
+
+	/*
+	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
+	 * the duty cycle count by one.
+	 */
+	if (duty_cycles >= period_cycles)
+		duty_cycles = period_cycles - 1;
+
+	/* Round down to 0% duty cycle for unrepresentable duty cycles */
+	if (duty_cycles < 2)
+		duty_cycles = period_cycles;
+
+	regmap_read(priv->map, TCSR0, &tcsr0);
+	regmap_read(priv->map, TCSR1, &tcsr1);
+	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
+	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
+	regmap_write(priv->map, TLR0, tlr0);
+	regmap_write(priv->map, TLR1, tlr1);
+
+	if (state->enabled) {
+		/*
+		 * If the PWM is already running, then the counters will be
+		 * reloaded at the end of the current cycle.
+		 */
+		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
+			/* Load TLR into TCR */
+			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
+			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
+			/* Enable timers all at once with ENALL */
+			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
+			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
+			regmap_write(priv->map, TCSR0, tcsr0);
+			regmap_write(priv->map, TCSR1, tcsr1);
+		}
+	} else {
+		regmap_write(priv->map, TCSR0, 0);
+		regmap_write(priv->map, TCSR1, 0);
+	}
+
+	return 0;
+}
+
+static void xilinx_pwm_get_state(struct pwm_chip *chip,
+				 struct pwm_device *unused,
+				 struct pwm_state *state)
+{
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+
+	regmap_read(priv->map, TLR0, &tlr0);
+	regmap_read(priv->map, TLR1, &tlr1);
+	regmap_read(priv->map, TCSR0, &tcsr0);
+	regmap_read(priv->map, TCSR1, &tcsr1);
+	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
+	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
+	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	/* 100% duty cycle results in constant low output */
+	if (state->period == state->duty_cycle)
+		state->duty_cycle = 0;
+}
+
+static const struct pwm_ops xilinx_pwm_ops = {
+	.apply = xilinx_pwm_apply,
+	.get_state = xilinx_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static const struct regmap_config xilinx_pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.max_register = TCR1,
+};
+
+static int xilinx_pwm_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct xilinx_timer_priv *priv;
+	struct xilinx_pwm_device *xilinx_pwm;
+	u32 pwm_cells, one_timer, width;
+	void __iomem *regs;
+
+	/* If there are no PWM cells, this binding is for a timer */
+	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
+	if (ret == -EINVAL)
+		return -ENODEV;
+	if (ret)
+		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
+
+	xilinx_pwm = devm_kzalloc(dev, sizeof(*xilinx_pwm), GFP_KERNEL);
+	if (!xilinx_pwm)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, xilinx_pwm);
+	priv = &xilinx_pwm->priv;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->map = devm_regmap_init_mmio(dev, regs,
+					  &xilinx_pwm_regmap_config);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(dev, PTR_ERR(priv->map),
+				     "Could not create regmap\n");
+
+	ret = of_property_read_u32(np, "xlnx,one-timer-only", &one_timer);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not read xlnx,one-timer-only\n");
+
+	if (one_timer)
+		return dev_err_probe(dev, -EINVAL,
+				     "Two timers required for PWM mode\n");
+
+
+	ret = of_property_read_u32(np, "xlnx,count-width", &width);
+	if (ret == -EINVAL)
+		width = 32;
+	else if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not read xlnx,count-width\n");
+
+	if (width != 8 && width != 16 && width != 32)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid counter width %d\n", width);
+	priv->max = BIT_ULL(width) - 1;
+
+	/*
+	 * The polarity of the Generate Out signals must be active high for PWM
+	 * mode to work. We could determine this from the device tree, but
+	 * alas, such properties are not allowed to be used.
+	 */
+
+	priv->clk = devm_clk_get(dev, "s_axi_aclk");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Could not get clock\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Clock enable failed\n");
+	clk_rate_exclusive_get(priv->clk);
+
+	xilinx_pwm->chip.dev = dev;
+	xilinx_pwm->chip.ops = &xilinx_pwm_ops;
+	xilinx_pwm->chip.npwm = 1;
+	ret = pwmchip_add(&xilinx_pwm->chip);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		clk_disable_unprepare(priv->clk);
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+	}
+
+	return 0;
+}
+
+static int xilinx_pwm_remove(struct platform_device *pdev)
+{
+	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&xilinx_pwm->chip);
+	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
+	clk_disable_unprepare(xilinx_pwm->priv.clk);
+	return 0;
+}
+
+static const struct of_device_id xilinx_pwm_of_match[] = {
+	{ .compatible = "xlnx,xps-timer-1.00.a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
+
+static struct platform_driver xilinx_pwm_driver = {
+	.probe = xilinx_pwm_probe,
+	.remove = xilinx_pwm_remove,
+	.driver = {
+		.name = "xilinx-pwm",
+		.of_match_table = of_match_ptr(xilinx_pwm_of_match),
+	},
+};
+module_platform_driver(xilinx_pwm_driver);
+
+MODULE_ALIAS("platform:xilinx-pwm");
+MODULE_DESCRIPTION("PWM driver for Xilinx LogiCORE IP AXI Timer");
+MODULE_LICENSE("GPL v2");
diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
new file mode 100644
index 000000000000..1f7757b84a5e
--- /dev/null
+++ b/include/clocksource/timer-xilinx.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#ifndef XILINX_TIMER_H
+#define XILINX_TIMER_H
+
+#include <linux/compiler.h>
+
+#define TCSR0	0x00
+#define TLR0	0x04
+#define TCR0	0x08
+#define TCSR1	0x10
+#define TLR1	0x14
+#define TCR1	0x18
+
+#define TCSR_MDT	BIT(0)
+#define TCSR_UDT	BIT(1)
+#define TCSR_GENT	BIT(2)
+#define TCSR_CAPT	BIT(3)
+#define TCSR_ARHT	BIT(4)
+#define TCSR_LOAD	BIT(5)
+#define TCSR_ENIT	BIT(6)
+#define TCSR_ENT	BIT(7)
+#define TCSR_TINT	BIT(8)
+#define TCSR_PWMA	BIT(9)
+#define TCSR_ENALL	BIT(10)
+#define TCSR_CASC	BIT(11)
+
+struct clk;
+struct device_node;
+struct regmap;
+
+/**
+ * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
+ * @map: Regmap of the device, possibly with an offset
+ * @clk: Parent clock
+ * @max: Maximum value of the counters
+ */
+struct xilinx_timer_priv {
+	struct regmap *map;
+	struct clk *clk;
+	u32 max;
+};
+
+/**
+ * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
+ *                             in clock cycles
+ * @priv: The timer's private data
+ * @tcsr: The value of the TCSR register for this counter
+ * @cycles: The number of cycles in this period
+ *
+ * Callers of this function MUST ensure that @cycles is representable as
+ * a TLR.
+ *
+ * Return: The calculated value for TLR
+ */
+u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
+			    u64 cycles);
+
+/**
+ * xilinx_timer_get_period() - Get the current period of a counter
+ * @priv: The timer's private data
+ * @tlr: The value of TLR for this counter
+ * @tcsr: The value of TCSR for this counter
+ *
+ * Return: The period, in ns
+ */
+unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
+				     u32 tlr, u32 tcsr);
+
+/**
+ * xilinx_timer_common_init() - Perform common initialization for Xilinx
+ *                              AXI timer drivers.
+ * @priv: The timer's private data
+ * @np: The devicetree node for the timer
+ * @one_timer: Set to %1 if there is only one timer
+ *
+ * This performs common initialization, such as detecting endianness,
+ * and parsing devicetree properties. @priv->regs must be initialized
+ * before calling this function. This function initializes @priv->read,
+ * @priv->write, and @priv->width.
+ *
+ * Return: 0, or negative errno
+ */
+int xilinx_timer_common_init(struct device_node *np,
+			     struct xilinx_timer_priv *priv,
+			     u32 *one_timer);
+
+#endif /* XILINX_TIMER_H */
-- 
2.25.1

