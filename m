Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8365A5813BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiGZNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiGZNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:01:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2094.outbound.protection.outlook.com [40.107.20.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1A1901B;
        Tue, 26 Jul 2022 06:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPLMT0TPcyhPQBzBmXNZeNKG+V6ekgMhlDPaXanaNVWy3Zml3S58xCR/a8aRaRyFcoyLWbFjKEj563rr0Z2V5HkKTM82kL/7mf+R31GmBDxAYsxsYlebP2KGvDYm1ES9/oqF11g/ilbn4C3P0dBL/h4R60ynrNv/GG5jciGwcrkBh2Obscgan8ZAy8CIbkdqqtEPt2OhwfaF2REVlci2JT78qIBSlYgbajWnK6244bnNn1ajZDuexH41Pn6AdNVZBqxHPxNUCabynE4ZB0AKBDj4+us7A2GX0V8GCtoThEPZQzOcFUlXXrqzZkAwwPzuz14Q3ecp9oXQ5Y+FcZni+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5CIMY5p7i9TuyHIc/EiOUjNqoswjjRIMh/YcqKpBAs=;
 b=BusTMuztEv+vS2IeTHV8CHsYLgFDicVOHNTzx+Osy4eOVp/Kf2Lj/OcSak9G3SkTh3foSUSJRwEzbgp59dkuDK/d+p9CXXL0idVygR+C2o90JDy2UNIwTngtGuq9g3xvhtT7KCsEfr3V+cdR+iCnc8qZunKDLv/B4ffh1KW8DEuDoWtQl6KlOp0S20iTiHaxBxoT+y2KmhNl9Vsw6wy6b0RR81Mx2fPRgVwiaVwrKT1oFZZtai6vg8I9DPi8oZr2eXEHGJA7O0O3ZYWdPehZfrV1ULchvGHYJkVTo9CLD12x6nNb4r3atwuORTBdo0n9S24jtSzPywXRe0IfMFJIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5CIMY5p7i9TuyHIc/EiOUjNqoswjjRIMh/YcqKpBAs=;
 b=FwbAP2Gx5UUYdVJQz9gGMv325vcWeo4uw/YsqScd/mllrJfZGVAUkAse/ra/RIcjwrPrhUipA8kyzXTbYkxZA2wcqpDpmPORWIp3AYClip58UXXB/6AYXUNDl93OQcuBf12KCqQrlRzEUmkWKdSJNJL5ek8euaCDm+sxa1h/xcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by HE1P190MB0172.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.21; Tue, 26 Jul 2022 13:01:26 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76%6]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 13:01:26 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>, Noam <lnoam@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2] spi: a3700: support BE for AC5 SPI driver
Date:   Tue, 26 Jul 2022 16:00:37 +0300
Message-Id: <20220726130038.20995-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b55f0e-6905-4b65-ef77-08da6f06f2e0
X-MS-TrafficTypeDiagnostic: HE1P190MB0172:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcVLGGkZu8aj2lrwridlaRJ7R915lEqZEDUjo/fm2/kg/uR+Vy9Rw35wKlo32Ngbl+AFBwwVe9E6JrmHUYwbrtnSdpQwOE/FtskZhtT4wyRtkdzBUUnq5vv8bQQvtBjXuSuqNuaMjBuFlRqeZL3+gmNQfEvHZ+89hDV6eZ6T54YgLA2uSG99ab3p2mcWUSaMZCI/eN0Q7bKc+JbjSB/PmUmhc4tNYR/6RpZyyK9G+ygEtzOOSfEC+FTxQ9bkYuthiFivZi3VAj8hrAw+0+6OUdTl6NbKZ+pJ7DsCJaAppZgSovruuxKRT2Xney4Iexxy+jlQAu6uxcc9umATyIXeYwxFeB5fpg3Lw++rhl95iC9Q3RANIlBdDR1cHtF/WLmZiBIco+t2cc6ZjHIypGHJr7KysKvj4nxRVJOwKJLja4jhP28O9z5Xpnc/upbOW2yHKyc+1XI4uCxhyfkRt3Op2uOfykZeVW7d2mE8bs6sbhW5toM9ljRpKxHkpXJRq6yzhATJFeI4j8mhXEZpWM+O+7iQH4zGqWfEf4CGBL6ud3YeADYE5SOKm+J/lkSaxaCoj9R9v05R6zTXSyF1164lnuGDxz7qTTAbS06A3yfmq7W8iC1NeC3CNpK9adtTE7e6Hw1/pKpDsXhVo8Fkt2bhlKHs957VnIM9bd2CESpeBF52UUg2z6r8relcbQ1Et9uf5G+ErV1qmHpJt/2Upd+mGXuuyh+cdcWewng36g/Ublfw9BftUFlPeoH6Oa+4y5bV8NRlQ442ZWc+UD9roffNZbgEWMSOmv/+x9ednz9AMvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39830400003)(346002)(376002)(396003)(366004)(8936002)(38100700002)(41300700001)(36756003)(83380400001)(86362001)(6666004)(5660300002)(186003)(38350700002)(54906003)(478600001)(6486002)(4326008)(107886003)(1076003)(66556008)(8676002)(66476007)(66946007)(2616005)(6506007)(44832011)(52116002)(6512007)(2906002)(26005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kqgWyuNF2W8BmoIh9QoNKjpFen0Ru6wnaGSkrrl7JM/YNWXnpVNovWtkmWn9?=
 =?us-ascii?Q?fWWWI3AtR1kyXm4AXVvfYKNr+JUiAxxojdhF/RPpUdG+Ge81IfWyl2hgOj+D?=
 =?us-ascii?Q?XE+UBz6tMGMDvJANBDx01r3LgpIAg3xGCxnmTVu63TeGpCfI5jJAOHtV1TQS?=
 =?us-ascii?Q?uMfPBlsKBTqbpGcNGmWhXGLSCo2PJ+cpJDPXUGI+62w5xZ4DcWYTBIXLnTKu?=
 =?us-ascii?Q?hlQ6bJkbYliPHszPPv2CjTI+PookHOLy7uQc048rd43HAw9VW91xEIumMI4P?=
 =?us-ascii?Q?zVTCM/628zoQF8A8dxT1NqRcBTU+69IUEoTzmCbKrFURbzwncDbw+YOYzm1u?=
 =?us-ascii?Q?vd8eYEkQUBWILmAJ2YfLHgXbVht4Fx4Z+vs2lfmoI3W4FPCvyJcKR6IbBPux?=
 =?us-ascii?Q?ehGjjmITAhobjbYGd1lXMEwGZ5XsrxI62yqaW1dHWyn9qddywdLCRWvEEWbC?=
 =?us-ascii?Q?B+B2ot5+i7SPOyMH1Xr2N1J4pTMXQk+y5JSoOG579EmYjcO7iJKTf+b79cBR?=
 =?us-ascii?Q?+N29yBMteXARhnBjRUnmmFn3VsnnQCl1BYtqgLgxQrw+U0Tpxi0WmkfrbuVT?=
 =?us-ascii?Q?xe1hBz4JhVfBy+ulE28v8S1mW5bYeRQlv8iZlDW8llS1npN2X3n/V0DfXFi0?=
 =?us-ascii?Q?J2RiICz4C+ALHrVk0x64argUMX2usf2I8IL43Uk8RmZbWMt30lpftr9UvX0S?=
 =?us-ascii?Q?XdEPG0QoEW7UjIbxPyuSXPKREK31GWyV/Ad9o+URGFp4FiH08dSokSrWWnYm?=
 =?us-ascii?Q?QePS1aADS+xjWUsTMD+FTylukmOKZeuM32/B0dxI1njQmOhan17Eu3xg0JbF?=
 =?us-ascii?Q?RzS3r4WQO8BZgHsT/N8ICfuM9Tu61Sbb2+nNJmFBaXzszAsutkb77DPB63Gj?=
 =?us-ascii?Q?7B++pgKar3KQJIhtWdkX27bUK+KgbQfxFF+5RYYuwRJqnyl19fFr7a832Re8?=
 =?us-ascii?Q?3KWOWzVDRDv4qWIGbAaQjaPGIFzlSG2xOWdnyPNJtGV4+HQR8UZd+KooIVpG?=
 =?us-ascii?Q?ayzzXKTyepaNMno9f6Pwm+Qpa41LlanKSuiUc1lj31AH2XOL2lLimcRflBWG?=
 =?us-ascii?Q?/t9Fx483eDWzwKPEqsI6U/pGzxzdXE2U7mloLnqp+3DLh5PF8EGZgnc93rLP?=
 =?us-ascii?Q?MrH/cj8pRI+8JCqQfPyYVHepTZA955/AyUmDWG5u/PKL2qIiq6EA3UnNpYfP?=
 =?us-ascii?Q?Taq6mEdSUoEAR616B8w9n2eJqeZvjkeRpDQhVagtYyx+o4G8mvzlx60NZGKB?=
 =?us-ascii?Q?FMZu0TI4uPZaVyPbDM2MdnwFGIfOYDi+6ZNtaoC0XlDFOvBE0ZtrdKwuWhPP?=
 =?us-ascii?Q?a7r1BswY1uPfAXu3xww2vjb2KvoxJ2nj2K/kcUxFOGOI+mFSnDelVz4OlID5?=
 =?us-ascii?Q?oLiaTNAdovIW7t7iuH/MWVPaE6hTpDGJYzcpgm6FoR/WQRKPG5Yi72NR6+oV?=
 =?us-ascii?Q?J9iblOlEKpM5vlGGQe1vIeLai21cKhSk6OxtiFPDpGDstIlzCbNFu99Iih5B?=
 =?us-ascii?Q?dFLvo5uIyhocxX/+aWifC7slZXcB6XK/nnlolsGkubw8cku8lI7C2JvG6QDJ?=
 =?us-ascii?Q?QNYAdxp+dhr8Mben2gltfSDqBsBy8kw3JrdmkC4V2sMj2bQpZrE8GIeILmDD?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b55f0e-6905-4b65-ef77-08da6f06f2e0
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 13:01:26.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRAtN4laY+EI7J+/jTCO4Gc7E94tBOFalAeksDl7zZIxgDpo2RpnQQM75TSsgwwnOvy3T1HO0X2gV+cW2Z+Cf7H7ZIcR9cAH7rXp56Tm0ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noam <lnoam@marvell.com>

Signed-off-by: Noam <lnoam@marvell.com>
Tested-by: Raz Adashi <raza@marvell.com>
Reviewed-by: Raz Adashi <raza@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   #1 added missing SOB for Noam

   #2 fix wrong endianess in a3700_spi_fifo_read()

 drivers/spi/spi-armada-3700.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index d8cc4b270644..9df9fc40b783 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -497,7 +497,7 @@ static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
 
 	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
 		val = *(u32 *)a3700_spi->tx_buf;
-		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, cpu_to_le32(val));
 		a3700_spi->buf_len -= 4;
 		a3700_spi->tx_buf += 4;
 	}
@@ -519,7 +519,7 @@ static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
 	while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
 		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
 		if (a3700_spi->buf_len >= 4) {
-
+			val = le32_to_cpu(val);
 			memcpy(a3700_spi->rx_buf, &val, 4);
 
 			a3700_spi->buf_len -= 4;
-- 
2.17.1

