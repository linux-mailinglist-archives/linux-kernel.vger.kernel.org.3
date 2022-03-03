Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DD4CC926
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiCCWhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiCCWg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:36:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000BF14F9B3;
        Thu,  3 Mar 2022 14:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J60W5Q1R/DYoJ/yQpXANwaQtWhwO4wLQO7fKkxxoRvLGV7NN/mnJEkzz+C8Ryb2tAXOw7H1oC33q8XLbGVEfWuE0kIEUd/sObCpLJ4iER/+qZxZjcvIziY//FxOuPfniF5pqiCb0AopDOpgI9iz9WEK6bqMzAna09/u918VsZcd8FZEbKYdKMjeMBv/tcVFjIbJkN8flz2G3EFMvNamULv2ideDQZ1FUKxWln3rfTYbyGuLka1rRGNc0RM5ZuvysdYQH4r/A7cypfbGCG7wSPwpGC/FDgZHknsNK/MjiEw2WN/WdLARoDIyQ1J35DZYYlBcG0aHw7Q9nBC4S6a9PfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Jp2NN/ZGU1CTAHdzZk2mH4hXErpzBxjq+PKJ4Qp8A=;
 b=QN2iQnd6+ySfwxo5QHjFF/AXT+QrF5jfryrorFtDeufJWvRoU7fCJUdVfeyzONGOqcbAxfR9C9HhX0d3UA8iiK6xbK0nb37O9rBzAdF1UKg7nOA2VOORGXY2rVv6aw1awFT5QTJVYSWrXschYF18BWO/Qdxn3m5gcDNh70+iCP9mRYdxyAKLsXBtAbFrMrLVsvcvRbKmNfGXf1292xKZvnpdgMS7V9vDH91WxfgkXJgdN0lbta4E5raTX0U8aSc2Beowz76st6y6zs/xc1kxN3MCqoXvAyDkTjVJpS5KIAs5DDAnaPMjo0vbhWPob+Th/TDHMLictR31Biz7r1PRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Jp2NN/ZGU1CTAHdzZk2mH4hXErpzBxjq+PKJ4Qp8A=;
 b=1zGcLm+k8FFBJw0nizVKu3khJr2cjfTuX54EePdxt4JpDR8TEVvv+sa+dIAvFxuy7R6Ra9apTXeLTT4Eb5OyJooaieM1y0L6PZyMgNIBKZL3EtdyARcolrA0niRElkfmc7fY6vY6yLmlaYQru7EtIMozj7rg//IeRyDapcmZ97fDh1gtmDIvWgMhE1Kg9t5YvlouIXN8uGAINsZQWWinFYI9Li1TxZwnNYNnTUUHYIbZO4l8bk1KQ8jr+8f/YToHgASZQ1HGYdsIbZGIWzglFCMZlrdJblxL42ZJyxwaoF46EIbYqevYUxY2lwev5+pQ0CPmy0yi4s2Hez8RKQm2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB3878.eurprd03.prod.outlook.com (2603:10a6:20b:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 22:36:06 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 22:36:06 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v14 2/2] pwm: Add support for Xilinx AXI Timer
Date:   Thu,  3 Mar 2022 17:35:43 -0500
Message-Id: <20220303223544.2810594-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303223544.2810594-1-sean.anderson@seco.com>
References: <20220303223544.2810594-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:d4::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a972d15d-5740-4803-7ee5-08d9fd66348e
X-MS-TrafficTypeDiagnostic: AM6PR03MB3878:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB387877988C3E6EDD3663CC2596049@AM6PR03MB3878.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2tDNciObQg2Ll/w0aR1sJB4Z8WLCV7VuOraJ6wxujqfJWUD4cOZ+Hi4sCP0wgG3A3sQb8o6Ww0cYbxNs8wBTEss/viJlZZggdHPkb0gnRrMBmP97e+Ln+x1egGaDDWyL7Ejd3eY6cr2J8LaGQgrEOHE2oHgsI9pzBb3b9MVElQiZcsmh1WCbs9j/KURElfm3QjDU1sXZdbEP5guOj3qqifs1l/TXqUqeitUD5DU6P1meofhqFF19uCG+rcWi+H9tHgUO0KdtkBnNMPQscKM0cWMCQvYIBW5Ksm+MPh6K+xtvLWPrUcMxecc8+E5QqWrvJi033uZbllh9PilIYsdA1P9B34+DtiATzJ9TUEjkQ/cbzIBLXdPH2g6ha7vQKR3IIujW9QIWGL72L4BIM6dKoJxH7v89l0rvJ6g21J0DWHla/rIoHiMRD6QxIh+KnH+fH5RyWwysZkI5KsHurGjHsN6Bd5dQp6GCtx6upClOxISVQUi6IYpwd3j7UAtp2i6x1fjqvzXqFMYGsCIPSzNl4z8yXxAJMO0CoQUnFMhrvbNjpCTG+AwdnwTPd0ytZx76jxEAc3M1sN5ESU7J8cps62n0sGKAj9S0e6Tg0GtDcLZ+V2WujKS865zCiYEHRRbPckxXXsxZNDcy42xyA0V0JjcTBQn++leDDCu1JCZw40RP3MT0eUWdqJ0AAFO4flaO8qcHmaykmjSQVnSN2YbKVinAQcCrqMzT3lSAWHBddFF01ekBV5wNkChx/P8ImTlEK5NAyc2cLeSPvXIY3EsXzDPz5J1xEyPmQSlXT/XM4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(26005)(2906002)(1076003)(52116002)(6666004)(83380400001)(36756003)(4326008)(5660300002)(30864003)(44832011)(8936002)(7416002)(8676002)(38100700002)(66946007)(86362001)(2616005)(66476007)(66556008)(38350700002)(508600001)(54906003)(966005)(6486002)(6916009)(316002)(6506007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emI1OXhHeDcvQ3RJQWlxK1RCdlpQNi9VL0hoVmpMa09rd25GcGtydHppb0cw?=
 =?utf-8?B?TFBSQ2R6RUdRVDZnY0dKaENHMGdwNEYrSkRydGZuZ3ZnNmJGSG1xZzVzakhr?=
 =?utf-8?B?UHhaSTMvRTJrTFNxbFNUTGhMdWZKcWdtOW1ESFpsY20xallFZmdvRmk2RFV4?=
 =?utf-8?B?ckk3bFNWdHVSWGZTU1RpV3ZQUy9VN2tINW5yTE9TQ1E0UUV5bG5BQ2I0aVRZ?=
 =?utf-8?B?V1VKUlhGUGMvN3Z1RVFvcUdzc2Z2T2U1Wk5xZWhiTGtjd3YrRmN3Yk90ejRt?=
 =?utf-8?B?VXRqTjNzOEFRNktraXRHNTRXdzRETE1pamRJdzJvc25MOGpyQzMrZlMxQnBm?=
 =?utf-8?B?ZFBaOExvanNZdE1ncENCMjJBTGQ1ZjJubzVjK1dqZ3lpTm02UWorU0hyYnZY?=
 =?utf-8?B?cVlHRnNGMzJqbHBrUnFhV05KNnAvcTUxUklYTzcvUFZabHloSmpTOXAvMDZ4?=
 =?utf-8?B?S1JkZHh1RUp2M0pQUDd4NlRNVWFjejVKTkZETHJMbnlMaFRIemRTQlV0cW03?=
 =?utf-8?B?bkxzSkVwSjJWMTlmdGVQU3JKZW40V20rakIyUUt3K2RlaWZUV0krYzhBNWhw?=
 =?utf-8?B?ajU2WVZEcUY2cjVtMnpBTnlWa0JOZDJLUzFyeEU2L1R4QysvNGY2MkNiVnNn?=
 =?utf-8?B?SWhabmRXUk9GYmJML0kzcW16YnZUTWhocnlTQlF4eENvTElPY0FMY2pBc3Uv?=
 =?utf-8?B?Mlg5RFZoait6UEY2V3NaM21lRnd3cUsyVWFTeEt4bGRHdUhzQ0oxSFF1WStE?=
 =?utf-8?B?cE5OSDlKcWxERmExUXNDUUp5NGZvd3lUVFBaaUpmWjRMMm9mdW1ic3UxYW0y?=
 =?utf-8?B?WlNBNVJtZmZKYUpyQmFWblBJbG1rc1R5Q2tOY2hyYjdiYmh3UURPSlVjK2JG?=
 =?utf-8?B?OEw5NWxPRXo4TG5VY1VSRFhEME5TbWR0bWVOY1k3VmVSMDJ2NkptaDhSOXcx?=
 =?utf-8?B?dWM0cFpxTi9mZnBCN2x3dTNiRk9qL2lLMWpLV1pBdmhiWms3RGMrMGxLMXBi?=
 =?utf-8?B?ODdmU2lma3kyTEJsVzBLa0xVMWpXL2VWTDNwYVBERWVTdVNwUXdxMTFzejFL?=
 =?utf-8?B?cDJ0WnY1VVM4QUpDb1RrTnc0L0pRN3FzNlgxYzZINnJHUlJNOTZYMVF0OXVm?=
 =?utf-8?B?UzVicXZzdUdlbGlGY3I5cjhMdHBESkNrWngvM2pKVkZKb3JwMm1od0QvN0JD?=
 =?utf-8?B?S2VLSVNJQlVRQjU2bWdVbklsaTRYYklyTGc1QXFSc1hpQnRFVXNsNmVESXBB?=
 =?utf-8?B?YnViTlZuOGp5eVBoWVdHOXp4WWdmNzBFNkRuNG9KclpwUkNYWmNCZkFxR3BO?=
 =?utf-8?B?ekFmRHQvelRKTHp3cnpKZENRQ2ZyTHNRcHVxOHpJa0JyV1Z5Zmt3T0JNZmtu?=
 =?utf-8?B?emRpV3phR1AwZXZZc2V4NHRCMXVab01jZnVlNm1CQ3E4MlpxQm9EalFqQ3BF?=
 =?utf-8?B?TTFlRzBCblRMSEVtMkFnaXptc1JUcDg5aFcrTmM3TzFQWDlqQXQ5SFFoeVRk?=
 =?utf-8?B?RDJJQlJEVDBtYXFFc2JHeUxRL3l6Z21uNUpUKzBvTWlkakhEZXVxQi9OQzAx?=
 =?utf-8?B?RHZ1bUllWCt2Q1lYTXgzQ1pocGFVampLa2htU1JhSnJLYUpUVnVTWVNGVGVj?=
 =?utf-8?B?VFNqdUlJckZKZzd0MmdJN1F1eGFsbVpKcTdwbFJrRjFIRlpuc0xPU1ZkejhD?=
 =?utf-8?B?V0hxamVLM1JqY2hHdlc1dU1SNG5hVmxwOWRadVJFTTJhd3lweCtxUGlnM2to?=
 =?utf-8?B?MklLQlRIV0ozRVVQRnVvaWpPNUMzcU13MTlkeFNnWEhMUUJaVHRWcG9zMEZM?=
 =?utf-8?B?SEFvaW9FSE1ramhuZVhOMzkvRWlTOUJtdEtkbGQxL0tiZlFhYWV2K2kvZ0Mw?=
 =?utf-8?B?bWJGSE1MdGhrNGVWTGtQN3RSZ0FJOVE2c3VNMzlNZTdXMHFxaklFN1g2VCtw?=
 =?utf-8?B?MkgzQmY2bldsUnJnZEk5S2YzTGo5ZEhjNW5UeWY2bS9WL0hJNlkrNjQ1MmZw?=
 =?utf-8?B?M0dKd1c0aHhGTHRUelNOL3dvY1BRc1c1YUZZRDhKOTA3SldEUlROdHB2dXhC?=
 =?utf-8?B?VUxJZzhHMmQ1MkhUbXRUQmppUFpvdXBxTFZzNXQ1c1VkUlVnaytYTjJyNG0w?=
 =?utf-8?B?VHdmNVhpaTZjWHZ2dHE1VXlMVzlGYkRpZVU5OUc3SE54UkptTWhCNWlCZ1Rk?=
 =?utf-8?Q?MLCA8ti3WrLwcqnSf1i2W+M=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a972d15d-5740-4803-7ee5-08d9fd66348e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 22:36:06.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLv9SGHPK0oRvU52ITUj7zS0TiZTQDsqaJyySL+eLsR75ULtZ8Q2+MKWezbs4e208XDAAECZQQrsadgNzZk7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v14:
- 1GHz -> 1 GHz
- Clarify that we will give a very wrong estimate for rate >= 1 GHz
- Remove duplicate blank line
- Remove forward declaration of xilinx_timer_common_init (which no
  longer exists).

Changes in v13:
- Clamp period/duty_cycle by assuming rate is at most U32_MAX
- Expand comment in xilinx_timer_get_period
- Note that the 100% duty cycle calculations may be wrong for very high
  clock rates

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
 drivers/pwm/pwm-xilinx.c           | 321 +++++++++++++++++++++++++++++
 include/clocksource/timer-xilinx.h |  73 +++++++
 6 files changed, 419 insertions(+)
 create mode 100644 drivers/pwm/pwm-xilinx.c
 create mode 100644 include/clocksource/timer-xilinx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..54709e3f09a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21201,6 +21201,12 @@ F:	drivers/misc/Makefile
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
index 000000000000..759c703364f5
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,321 @@
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
+	/* cycles has a max of 2^32 + 2, so we can't overflow */
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
+	period_cycles = min_t(u64, state->period, U32_MAX * NSEC_PER_SEC);
+	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
+	period_cycles = min_t(u64, period_cycles, priv->max + 2);
+	if (period_cycles < 2)
+		return -ERANGE;
+
+	/* Same thing for duty cycles */
+	duty_cycles = min_t(u64, state->duty_cycle, U32_MAX * NSEC_PER_SEC);
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
+	/*
+	 * 100% duty cycle results in constant low output. This may be (very)
+	 * wrong if rate >= 1 GHz, so fix this if you have such hardware :)
+	 */
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
index 000000000000..c0f56fe6d22a
--- /dev/null
+++ b/include/clocksource/timer-xilinx.h
@@ -0,0 +1,73 @@
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
+#endif /* XILINX_TIMER_H */
-- 
2.25.1

