Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3B4A9E8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiBDSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:01:43 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:52481
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241744AbiBDSBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGrioQDjs41Lg03mQaIDHYuumOMO3fLQ5BUqyTvlI7j/G99t2JYcYzJc0xEkN/SjP0f0eADF4wVvCccLpvIrvDImlpwyW7kRctrtZXF6f9ZWeiK63lpRyj8aGYYIJAsReaBQGwF2HjvB4jCIh2w4p2i2HaUhXdJTfCEq+uvCUZHvc0yF7xIqkoMFRtMSIJT1x+WK8ZYPV0MK34/x+fPFRHDEzghO41mSNX5+TbvwUWA5vFq91GxH7F1DXnO+J48Y93LxEOPGBJMK2G5+RgRTD38VjGdSf2MK3XTg71/QoNGLUGbrJ6pryQCSwS3Ffc+cqEv9sfXoEBVeFTDeKVVqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPn8NMRCrymMl2mfyEHPNie/WnoOhkfDSDzvS1ZQLaE=;
 b=BCX7xZndK3Qaj8cwCdoC33+Z73/6JDmvlKGP5JDjzAKNMY1P69tv3QpUvpHaN6JCOQn/KesdGEYUFQpi5fxc94XAbMv/iCetVPf1pOpWXzhQOJwWsRrxHp9qJxMqJy2juRsN1U0MALswKnTI6Xt6N4pvmq9wPp9qOKys4UvbKATrleEnXRQzG495H1G2sjxbg5ZRdD0/9gE/e/2Id+iSVdK+8au6NIM6yF1tQrvYWq2fItJsVdTIwRnJLV7z9+8VToZmP6xf0sGzU1NLnoUscvFAvfeHRefhyG1UZSI3nLzJcBBrUmoanFk5bCGeTNzbOOeA6ISaePJBosfUUUjcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPn8NMRCrymMl2mfyEHPNie/WnoOhkfDSDzvS1ZQLaE=;
 b=X6cZRVykkq9jDvrtO781wnaJUKzsNWsbTblt7b+XMvd76NlOdbK8iclvw6t2xaooTh+NZV++vzZz2FPQk8/l6KEVoC+CaJhNZt0upp3fVs1D+dRryWlYd4C30ddas+L+9Ce/jIp9JJLs3LpgE6owr6Gp4BeFsgr2TH/CDJolO86ZOKjAsxvODkTbedgQZkg4qf1p7UyAL0nh6TogZzKzXARzOt7SPadpO8aH4hmpuTcYL22ElBmlmD4b9bKV2yIi/n+aqCZ48TbC6W3ZUaDpSStAERUVHQaIEeYTPcHS3M376rU3u9uZuJWH/uomp/py/oe5QHkFu+LJskO0u/bRKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB5764.eurprd03.prod.outlook.com (2603:10a6:208:173::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 18:01:37 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 18:01:37 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v13 2/2] pwm: Add support for Xilinx AXI Timer
Date:   Fri,  4 Feb 2022 13:01:06 -0500
Message-Id: <20220204180106.154000-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204180106.154000-1-sean.anderson@seco.com>
References: <20220204180106.154000-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1da5ca7-ad87-4641-d0a6-08d9e8086388
X-MS-TrafficTypeDiagnostic: AM0PR03MB5764:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB5764FD4D28369CE0B872275596299@AM0PR03MB5764.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNGsMAMxDUPKBgTPsyaXXRpU8zpKq583uUKXVjTMub0jNzVwwOBQI8iiwS247s6nnrLmplqWiNQV3jKxNHZ+HesU2fwo30gF9ZTZeqaaGNfmd5wZnz8NJttAgTLWVo8KGw/bS2xld6i6hJCjeuhFunVe0zf2/ZtEzErJx2pN/ZeVfgiklcXXN5OPjD3nT8SmR74uyD+xDUeqfG5jj9WmW8FZLjiU58rremnSDl1nMZZ4rTAWVbMviWUdE/+Fqf7ZtB56n9r9HZcHU+BaTanmGOVAQt4a+fV1cibPVWUM6biRCKVotFe4NOtD6WqFY149Lcg3HxRMimy0zJ94nogAvnmQ9yfzEGXiWIaAjSK0kb7pG29Vxfx6mmy9TInH12vFkOjQM60bx1ErGs1VDcyZvE+EUQB0e9F1w0tC2Xx0AXk5mt2zM8hkC8FlLBtGs5dVOwuhNwlKmrb+GW/jDXQSZYz5wGUpNIEUlKSdzUaWuRqA60XTFWFVV8do1KlP085l7IlXHct+lvGy0GLfzJG3iKOaNREq2pD9p3POibzvRE8T4cUF0G6JVXytHBB+W40No3H5ed74o3b01g/IjGec0uR1s/Jt2dkzzXSvmvrRgx/cmqGhMKvXgePo6j0EoRjPzOM4lNkqK7/gnqyMVkJG9EycB5UFGl2SEyjMoz61taO2w06ws0EkG8LgAjXrxP6QHEB06+m+0NCNziGGbIlYJuq4XQ96qdF/j2MIJInGUcJSxLWgqTZ82F680hcTcVgUXOY2+jo05+jNp5qNdMfxCS/eZNhlPfKVhAW4wu6Kkso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(52116002)(66556008)(6506007)(38100700002)(66476007)(86362001)(36756003)(8936002)(4326008)(6666004)(316002)(38350700002)(8676002)(66946007)(7416002)(5660300002)(107886003)(2616005)(2906002)(26005)(1076003)(186003)(54906003)(6486002)(44832011)(6916009)(966005)(30864003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmQwcThZTWJpOWlkVUR3M3dIalhnOGRYd2NXREdrd2prTkIvSVNkalBLcHl3?=
 =?utf-8?B?Q1U2QUc3SVJnV1pHd3V0c1Ztdzl2WDZ2YnJucGgvSFZnYURuZ0ZpWCt1RHUz?=
 =?utf-8?B?SFExU2hoaFRpL213bGdKTEY3OTZHOEwvQVFMS1JsQlpBTjFtamJvNEJZc1Ri?=
 =?utf-8?B?cmhoaFU4VllTd3o2WFZGdU1DQ3lzTm5BTnF5UTN3N2xiOVNtSjBZdFVXdXhS?=
 =?utf-8?B?d3VXRHFSMnpNK0tseGdBTnArMHF3QUczeHBMTENPcmxwby92K2VBZjl0Vjc2?=
 =?utf-8?B?YW5UWldiQ0NDYWxYUVdzdHZnTzY5TENhOUdyQ1hSR3VyVjJoVG9oU0xiRmVk?=
 =?utf-8?B?TlRCRW41SzMxZ0dpNlp0OTkyZ0pNMys5TzRQc1FHNGNLWlRybGswdjI3UVhy?=
 =?utf-8?B?WHVpZ3V4WTFNaFhhVEdnSU1FMTcvSlZlUkxITUYzSUdTbVQ0aUcyYlhlUEFC?=
 =?utf-8?B?L3RyYkJYLzJycGZwa2tibXlqUnpTcjk3MHN5Z3dRMDVTVTQyanhqaUU3SFFh?=
 =?utf-8?B?ZVRRQVI5ZXJlUXJRRzkwNGxKYXMvU3U2bklxSlFsbFA4VldJb1ZBbEorYU9Y?=
 =?utf-8?B?MU5oRjZLcVVsVFpUYmNkQ2VCb3ZSeUhIeDlWUlVIUXpJNTRJU0dJUXVJK0V0?=
 =?utf-8?B?ejJCU1FKYWt0a2tVZ0ZMMnJ4OEdZYjBuS0s1c1YybzByMUJpcTYrWUFodC9N?=
 =?utf-8?B?eEJ3MUlVc2RCcmp5SlNkdytIVk9WM1ViRm54Rm8zMXlZRURnb1dFbDZBQ1Yw?=
 =?utf-8?B?VFAyYnEycW0zUVQrRmY2eEx3WkttTmtUcDhaU2N5WWhKb1JFVmhuNXV6N0xL?=
 =?utf-8?B?ZnVxZkxZTEJzc1U5b3VmV1F2TWNXdEdFTWNEQUdkdXozNHVqRkFzQmZYT2Vz?=
 =?utf-8?B?R0FMWEdSQlZyWEowT1hIbzBzUDdlTld3azlSSHpTQm1FNVBINVVqZVFQTmtV?=
 =?utf-8?B?VTg2U080RWxodFpjWFNxVnRiaTY3TURROTdZOTh4cEpDR3plQWZiMzBwaDcx?=
 =?utf-8?B?dVRVbCtUWnBQcnlIcVQ5RDBKMjN5eEpaeUF4KzJUa1VKZzhpanA0VzVjMDZa?=
 =?utf-8?B?T1paZ2FyUVJtVGJielBlMWN0Uitpc2FUWFJOa3Y1d1Foelg5SXlSeFY3ZEk4?=
 =?utf-8?B?NUIvWTQwRkR4MWl1T0lsRWllLzBydmM0YW84aCsyMFhvOU9VSnM0WnoreDJ5?=
 =?utf-8?B?T0tWSzJSTVJwU3pGWDNDWXJvTmVmcjEzdy9QOTluOTBNQXZJT1JWSlBvTHRC?=
 =?utf-8?B?R25ielNha0FtK08xVkN1U0w3ZU5lUzdORytTaUczMHEwS0M3Wm1pUUdzYXc3?=
 =?utf-8?B?M2N4cytIS2w4ZlNuZ0pGeTZBR3UwSC8yOHJaZElncm1rOVZ3UVVSYUNnRWFs?=
 =?utf-8?B?cU8vK0tLdmYwdHZDQ2VwZ0FuTzNFNzNKTU0wcEtRMEJCZXA0dytoM0hLWEZu?=
 =?utf-8?B?RE9yQmM3MnhtT1NudW90VEFBSU9OdktOZHlnb2N4NVJITXhzbUMvKzhtMXdx?=
 =?utf-8?B?R2NLMTlRTmRBU2tnbVE5QmYxdjJiRXY2U1R2c3k4cm5EcEJER2ROUlBJTFpx?=
 =?utf-8?B?ODI1YWdldHFsM2lRb05ZUll4L2UyYkRwMGpQVkpWUC8zYXd3cWtFN1JlSkpl?=
 =?utf-8?B?am1zYkgwRWlyTzNpSExqaXo4aTJ0TnVYcmlrNUFkVDdxN0p0dEdDenYyYzFo?=
 =?utf-8?B?aXBwK0Z5bjlEb1I2NCtHdWw4Tmg1ck1WeElKWHVkcENLWExFZGwxR0ZlVFlu?=
 =?utf-8?B?MW9NSHE1Y0FZMlhrTjNSczR3Qks4QURkSHlNd0JRY0l1S3hOSFRaaC80cytQ?=
 =?utf-8?B?cnp6RlZlWnU2WTUvcTBBNVdGZTFjZ3cxSjBTdkxJQjd4ZFk5cm00V3dpd3RS?=
 =?utf-8?B?RE83bFJaRy96MWdnNkErN2FuUzlya3J5TFZuOE5sR3lwMHNQTkl4WUJFWmRn?=
 =?utf-8?B?SjhvalltdGtDeG55RmdPY3BtOXhHRlRYUm1YQXlPSEJIZWlLQkV3dVQwRStR?=
 =?utf-8?B?Q1pSRDFHekFQV1R4SkEvVnJVc2l1b3l3NGlvZ1FwTkRjVHVJZExteThMT1gy?=
 =?utf-8?B?SDQyR3VhaVloSkpTOENiazA3QkRLdnZ5WE9FQmtTa0tQVzRsV2hsTlJlejVl?=
 =?utf-8?B?blBGWitucVJHWTI0WWVlWmdJZUtiMWRRWVpaQ2IrVzhiQWdEeE5PbUU4Y2xR?=
 =?utf-8?Q?wbFCChg7GP+wasgd8JNBKrM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1da5ca7-ad87-4641-d0a6-08d9e8086388
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:01:37.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn48CtCeH5W8VbvvgsPotRCS5qxjJnainZJIDgjMPCey3qhANxYdU2R5AKJn9SBSuOTmmj6NS5UGbXs+3wbACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5764
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
 drivers/pwm/pwm-xilinx.c           | 322 +++++++++++++++++++++++++++++
 include/clocksource/timer-xilinx.h |  91 ++++++++
 6 files changed, 438 insertions(+)
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
index 000000000000..1e7a38bd9b34
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,322 @@
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
+	 * 100% duty cycle results in constant low output. This may be slightly
+	 * wrong if rate >= 1GHz, so fix this if you have such hardware :)
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

