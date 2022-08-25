Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF915A0E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiHYKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241012AbiHYKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:44:43 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00380AA379;
        Thu, 25 Aug 2022 03:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+ute7BmIJUGeVxLlKt5RjYPRsBxpzSn7wQCwwZ6vw9wR/vl0Cv1EKjhKPFje0hi7MBjn1Bwv/uSvhB1VxTkgk5jDisz+wPyrC6y5emrJF9BiSBn+gvNTjHtvVROUhltcaPZlFPxHglUuR1y0rmcK3vMPwxukjNGwan0V+DuBkXBC0lGEZ7dP3rQHMPWEi0ctPmC6oYLcQnBo5SoOv1voxWzXZ3o1xJZlJVeXFEyGvdt1Csz7XzgrXwEp5Pp+lsYKocnOQUil87mWXvHTy3rr8WKeemgQzW7otbfLiMIRs4Q9yq1AhzpBOJ7qFzhk4QHQE3268YNdU0SOyjufWiZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPspITurg2A+BaNKbzPvJIdPgrq91y6R0VCwzAHhGvs=;
 b=SKZsHnhuE0mU7WH8kQhsyGMYgT80uVaWSkdVe8O+it32vKQ+dNF51s2qbdzsKFfrsEehgK+CvwJkjuJ84upfX7TrTGmXS7gvI+6GdH/w0aogO+6syNmLTGtBoC3nLvb7fqPa59ZgZoKXWx77VROOwG6bXE3uMIvJSfCirkCl+uyd9urz7ecu4ltwA6MBhBH1Z3h0zs2goQooNadBhyioJFP6Vu1LnTxaOpLhB7VJjhztZ+1wKaZhPC2md+DgXlTWTbTGdWApznH3gc+FJXGrvrLfVX3BPxgEea+mQOsAv78TU3H3Sl9YbpalwvwuaPe4hFwQIl4QPXhhz+P4kMnaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPspITurg2A+BaNKbzPvJIdPgrq91y6R0VCwzAHhGvs=;
 b=rERMH+xD2D7UWKOG2BMJ3hvLL7pEh0+FvAeSgz7yn+h7pbfgk8OsR9UHSH6gemx+QmBy0ZYvLNXW1hgofNS8ZqXzzVIpa9Q+jsKIHOyIrZHOvWwDYnCkHYNAa4I6aT/oECszk7f0lEErQpURkzunxrLiA/Yy+aDnD2HPa9YhlaHLlydGNkf/U4Yfhs6c/sJfLK52qDSy8TZ71RKYW+EjcA32NGkiarSzHotrtS19ZjM5dsmhrYUfWzg558o0K7gPuAnIyojCp/PFJSpJnDywr2JfV5MqvSWpPZHEK4+C88d8iiV7a4/uaHmJuLG8gjKXGFablJLVwozhF1eC2RtpMA==
Received: from DB3PR08CA0025.eurprd08.prod.outlook.com (2603:10a6:8::38) by
 AM0PR10MB2161.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d9::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Thu, 25 Aug 2022 10:44:39 +0000
Received: from DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::ab) by DB3PR08CA0025.outlook.office365.com
 (2603:10a6:8::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 10:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT064.mail.protection.outlook.com (10.152.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:44:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 12:44:36 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 25 Aug 2022 12:44:35 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v6 0/7] add support for another simatic board
Date:   Thu, 25 Aug 2022 12:44:15 +0200
Message-ID: <20220825104422.14156-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.202800-8.000000
X-TMASE-MatchedRID: KROSFzfRYnQVlsvFGmNosYG6B4FcvVR9+JollBGk0D4SEYfcJF0pRQKf
        lB9+9kWVSGBrI0fho7JyeGGH696bJJc8Pge/ETnw/KB3arlp4NS9TGmwrVcPSx2SZrzmQZgRBGv
        INcfHqhciXE6jAom+xSN8fQ5fIHdgDidmK6/mdug+ASxdfL9SYpzDsl2JUMqfEVuC0eNRYvLM/Z
        tiuMwxAMz/SxKo9mJ4NFZRXtDJ5V5zUhUGDp9t1FkI2xroFUG54afNKAaJdCuGOUGPCmibUycTr
        dpVQn1FYAwzRYoPhqwBSrA72lIhPUDyAOiFfe2+HxrocO46s+5O54ONIeLU90RWpBb0G+2pAgvM
        6h73BtpLxCuBTCXaKtj9pJv36IrJF6VEy4BTWvFVEca0nFZLQQ2qw+l5gxNFyPPRU9ScEDVrTWa
        Gefu3pJe4rIe5ItN8edwDxP7+evcI0u4+15EMd/WJifqwo44Rr78SC5iivxwURSScn+QSXt0H8L
        FZNFG7bkV4e2xSge7srkkoNOsr6zcJujyI2Y6+HxymAOw7wwdtyiG/1FRZZ2gGZNLBHGNe
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.202800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 632738A6DF2D2820CE7739CE377C970F7FBE0A2634C2D359DBF28403C08C08302000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fea29e0-2aae-4d71-ce06-08da8686cead
X-MS-TrafficTypeDiagnostic: AM0PR10MB2161:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ozw/yB/qJjQweuAE2T7usYxcHNBk9LXYhaN1+GgsSaeHHk3HXTEDJ5RDUdcrNLGnantL4dUTNjYy/DqdQ6TJXraZrOtX3tOvJ0wLBuDqUh8/Mg/La7nTYY8KMWwQ279E0F6MPZux+yxxzsTrCCtCS+G5N1HMJoTGsu8npgGKvr+iL1hbt1YphnK1Z/XeyTlsRH9XtF/2YGNjBtfzcqp5SetRsEQqy1ivSodFltjPF0sSmc+6u2Nf3KWAOayanFvhSxvVybNTVg55xz9UaQ98x+2f+jXhyBo3CtwTvEbSj5xbBpAlTTGk8T8mTeLvvYcKpKUZN4cEmw2eXembiU6s011lQOajhB6LU+oRiAYkr02KPyv7yht7F6P2B8as0Fo7U6lzsjSSy0gDMEeXzL7TZ3ztONxn8bZWYKq538xcWm1TUwTTS+eyZMgYKV6oM5N+rnfaEU3MQeyn+gkzjvBsOFcO3djFfD84+KvrSc1Hx+LDXl4glzSvFrw3xDlF0xyxre9M2mSHDP9dPkm22FdD14GgA+k/dmQwJe93e80CVkv09ckd2BMWy2B9uIYKhWL2I58VSaG8NuQQaMbsuMXK/q6rnbFevBWFWwTTJrUCOEZ4eUu07GqLreXnpgOoSXAyM8RXz4FOVPC27sFTb0SA/oBLNJEduRwDxIgXMteNgMpJ48RWkkh3qOY89NcELMHftnU0+6pyBRUou3n3x7x6iALMzd8EfBN+WytYhD83v9jFWa1O5EA9yyvMCuHKIvFvxNOtdvMnLcZP1vwgRnjuwJh2GU1sRJPC9EOBrnYtNE4FlK4ExKGre4iLYhSQvN9b2lxJsj4VWQxt88B67ng2hA==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(478600001)(26005)(316002)(7416002)(8936002)(5660300002)(86362001)(956004)(16526019)(107886003)(186003)(1076003)(2616005)(82960400001)(44832011)(2906002)(54906003)(336012)(47076005)(6666004)(110136005)(41300700001)(356005)(83380400001)(7636003)(40480700001)(36860700001)(7596003)(8676002)(921005)(70206006)(4326008)(70586007)(82310400005)(82740400003)(36756003)(40460700003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:44:37.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fea29e0-2aae-4d71-ce06-08da8686cead
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v5:
  - adding patch to convert to pr_fmt
  - adding patch to prefix macros with "f7188x_"
  - rebased p1v4 to be p3v5 and added tag

changes since v4:
  - remove int case from a printk in p1
  - include tags into commit messages

changes since v3:
  - update Kconfig as well
  - drop chip names from comment in driver header
  - add manufacturer check for Fintek again, Nuvoton not possible
  - drop revision printing for Nuvoton
  - restructure defines again
  - add new model 427G

changes since v2: (p1 only)
  - rename macros that change behavior
  - use chip type not device id in the macros
  - reorder defines a bit

changes since v1:
  - remove unused define
  - fix bug where (base + 2) was used as second data bit
  - add macros for "inverted" and "single data bit"

The first two patches apply some style refactorings before actual
functional changes are made.

Later, This series enables a SuperIO GPIO driver to support a chip from
the vendor Nuvoton, the driver is for Fintek devices but those just are
very similar. And in watchdog and hwmon subsystems these SuperIO drivers
also share code and are sometimes called a family.

In another step the individual banks receive a label to tell them apart,
a step which potentially changes an interface to legacy users that might
rely on all banks having the same label, or an exact label. But since a
later patch wants to use GPIO_LOOKUP unique labels are needed and i
decided to assign them for all supported chips.

In a following patch the Simatic GPIO LED driver is extended to provide
LEDs in case that SuperIO GPIO driver can be loaded.

Last but not least the watchdog module of that same SuperIO gets loaded
on a best effort basis.

The very last patch enables a second model of that same board type.

Henning Schild (7):
  gpio-f7188x: switch over to using pr_fmt
  gpio-f7188x: add a prefix to macros to keep gpio namespace clean
  gpio-f7188x: Add GPIO support for Nuvoton NCT6116
  gpio-f7188x: use unique labels for banks/chips
  leds: simatic-ipc-leds-gpio: add new model 227G
  platform/x86: simatic-ipc: enable watchdog for 227G
  platform/x86: simatic-ipc: add new model 427G

 drivers/gpio/Kconfig                          |   3 +-
 drivers/gpio/gpio-f7188x.c                    | 275 +++++++++++-------
 drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 ++-
 drivers/platform/x86/simatic-ipc.c            |  10 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 include/linux/platform_data/x86/simatic-ipc.h |   2 +
 6 files changed, 216 insertions(+), 117 deletions(-)

-- 
2.35.1

