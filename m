Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D555717EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiGLLCv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiGLLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:02:42 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77B6CAEF77
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:02:40 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-8egSj0wXM66e4YchLHW4iw-3; Tue, 12 Jul 2022 13:02:37 +0200
X-MC-Unique: 8egSj0wXM66e4YchLHW4iw-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0317.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:28::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 11:02:35 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 11:02:35 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v1 0/4] mfd: stmpe: Probe sub-function by compatible
Date:   Tue, 12 Jul 2022 13:02:28 +0200
Message-ID: <20220712110232.329164-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR2P264CA0155.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::18) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b4f078-4d66-45f1-0544-08da63f6063d
X-MS-TrafficTypeDiagnostic: ZRAP278MB0317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 7TlWnweyNgBozulw0oJRj3XllAaJA22S/jUKNZVzFtxzFkdiC5hikR/w7qq4KVeJVdbL4gfJItbC97A3MzTZ/yVhjiycDlS19n0Lc/VLVE87/Oep5q+e6qJERSgLZofAWpdKYnz1FMeu2GQHQ017WrONagvmB2/yoK5xPk0u+QHBrl9tmTf+j5Gua3fZBH87Ae256bh1r9XCamAJit979O2xTdUKcImWV+qhDlhVMpK37LMuswBbxMnucTzIeOb5yE7KmUPcuiCcvxbeUz8QKWXeVl5tCygASMLS9Szbj1nZ9CgCdONNtJD2NSreMQONBIDbZMYo96qcPnuJ0pGD/iTJetZ4ABjkCW7BrOOjqRkw8S1RBegs+WApoMudabQ8fPAba+ud9EecuaPndUt7oBydYfCQl/XLNRS3FdwogYxQq+7duzCA5EaCh272P3qCn0DJ/UhD3IXDNGhsW9TGFga6Jz/XOF0d4RGHvXOfEoA56BNSp2D0p0eWaZEw6ZrWRU9kd2nkOWeca3bGnorg4efWinNbGYT4IaiIrY20xWsXmX8Tw0vfBIcMLN6K2rJ18WUrssaYEHYCurdPpYJlnIsgshFYjsf0mRyfXR2FmBTGsE/0XCL4BIBf82IkaC9YGcMxJP6pmHvYF3sIqnUExb7PjD4pB9IScd/kr5uJ6Sk4JKqv1nE4cFI+nU92J41W5hSnfyP8kESAKJRjbXN+MRb+J065veIMSQ0yhh1Q+okYhrETdfGfEKu4aqzvt2ah0hvBHF8bHMHh+nNiB6g/O3u0TXGSB9r7u+bW4snWcanEkjbK9E9ApgUNR/oD9nS+4e8eVJmfFCSyr5SjHFLKF8iCneGxBFlBCJ/3V+69SqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(66476007)(38350700002)(1076003)(52116002)(41300700001)(38100700002)(2906002)(54906003)(186003)(6506007)(6666004)(44832011)(36756003)(7416002)(66946007)(316002)(110136005)(8936002)(478600001)(5660300002)(26005)(86362001)(83380400001)(66556008)(8676002)(2616005)(6486002)(6512007)(966005)(4326008);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6u4bJOghPj68epIr1gEzdkYM6s0guGnmOAVKOXHxceNFrlhxT8rate3j9jSr?=
 =?us-ascii?Q?+4AEq9zLAvKTqXXcjOFlPOxF5c/lv4HVxnBfGcJ1xJ2O090qKTV95AWPCw23?=
 =?us-ascii?Q?AmHPEel/SravNh7ZmHld8gbk6SSt+QNfZA6rvHKeRptVcKqbGgebNBKDDYux?=
 =?us-ascii?Q?aUq6PmqL+vn2jxsrpKoXV+Pg2vNUn645TaGEZ7OzcA4pOzKbOxGA2brt+Nq5?=
 =?us-ascii?Q?9JnUu7oKnW1q8f4DbWjq3/A6nE9FdjhBYxLo963cXH7PErxajiRjSacIFPag?=
 =?us-ascii?Q?SRFDrjeRt+Ca5qwJKY0skG0wKsBZXO2i72u36MQPN51EvwhRAESOdVT5zuVV?=
 =?us-ascii?Q?Gty+NnbGS/Ml738TQrZg766k5r2xGMPfOmhWqAnECdItjtGJ0Q9C88tadksM?=
 =?us-ascii?Q?pZjHD41304lERB9BHXQawP9nQDnq3uhb0dMvI+OwdWnod4h4Z4QySCVpAp5P?=
 =?us-ascii?Q?alql2iDAwccvhjjFY0/CpSjVD2XaHwwpvXpvyaJ4QMBRFoXwVk4EkTxvmVKI?=
 =?us-ascii?Q?pIg5+GbLeMCbNDC8BxYOL+UtIk2gGCfZBLBYiO41xVqcu2TvXSqIzScTRaTT?=
 =?us-ascii?Q?+HaZRyIzMrgNuoq17f8glbXTJ08KEXg10hvrnJpl/uJwLuyB8yopcGR7DCL1?=
 =?us-ascii?Q?E+WhDurlJU1B0tg+iMaBqVktNNOQ3yT6IxBEogjL5QlSh4NpRlPbSB7+MuM1?=
 =?us-ascii?Q?n5h3dlaOE83Bhi1akXPcK/0lsCF3zTd8T9yGBz8veOJBjmSyFdIWfcCwcQH+?=
 =?us-ascii?Q?jsMJ7I49cxEMhl56IFs/F7EMOpygXSUZvKAZ5gJ/Bmi9SWFVya43JUbb/kBn?=
 =?us-ascii?Q?UOFCfRt/Z64hd+XhyfQvopHuLdLW1fZ6C4WjiohPtlDaFNsdfWcW5umrhYV0?=
 =?us-ascii?Q?PTTpAIZH4MU9ftYAGNJPTZhenj/idevnZtDrKk5nBopKaXvUGf7LouUgTMDD?=
 =?us-ascii?Q?PsxlBiK6LV5feZdeL2inZeQTHW3AanRMGD/0Y+L67VzQeY8WSFRFf1rAZ7w5?=
 =?us-ascii?Q?NHyJdJXJ78yln5P3pJRmcxAG04rXP0GQKXpoUgKQFzlaywIzz8Mgx2xLk4aY?=
 =?us-ascii?Q?IZRaqs3b+Ip+tkjq6NTF/b3l3arUEcOiis5Og8kKt5SQaooluTcLoqg+x5Q+?=
 =?us-ascii?Q?QHHWu9rsCIaZ2ad8ib8rkD9EzM9+VWxz672vzL764Mq+BLbAoERn+Eyhr38k?=
 =?us-ascii?Q?OoUj4vVd+rxlwTh8ddVHRkxwQ/cweUOv260zW2VbcKSnmCzGVpVzgZ3o5YeO?=
 =?us-ascii?Q?ucxVF8JxcYwLsFMxldjzORVHtpaHjVlpCwbAsnW1bhzvKK50C5uXsofWGYbw?=
 =?us-ascii?Q?gyF/xJG65WvFfCcJOdz4bWbD49aPCAndZJrZPQzaorfOOBWEJfa+5dES2YJQ?=
 =?us-ascii?Q?Tw8bP/sinWe0X7RJQeMpuOCB+3daqSk80PC5vLoX/wlReZC7hf2qMr1lZGHW?=
 =?us-ascii?Q?wXwxTdyrs3bqm7qyrDHRkxHgS1g2W9H3bZK0VHqDER5Bp274mf23zpsE84kt?=
 =?us-ascii?Q?NusVKbafO7uOkfA5WLiONATG7h1F/V6OoWNaFRZOPNQS1OLmhzGHxVdo1ZGG?=
 =?us-ascii?Q?xleSA2pf/TQNKRjIGfSTVkQxhJGlhdgzuqdGZ8ItkZSO0l9OTKDbVCiCQ88f?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b4f078-4d66-45f1-0544-08da63f6063d
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 11:02:34.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdTwzhkTSKyZSKkn2eGA9TTDGz8aIydtnh7ltMkmsozG7APWGiNq12JUejio1kkqpDYOt3NcBbP1m4Eu9KuaSvr7skzg7Tydg6d0oZnBmUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0317
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series update the STMPE MFD driver to use of_compatible to probe for
sub-functions instead of using hardcoded names.  Matching by name does not seems
in general a good idea, in this specific case it is even worst since the node
name are not compliant to the current naming convention (they are not generic
and they do include underscores), and because of that recently
we had a regression introduced [1].

This change was suggested by Ahmad Fatoum [2].

[1] commit 56086b5e ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
[2] https://lore.kernel.org/all/86815346-209e-304e-3565-b4160afa48e8@pengutronix.de/

Francesco Dolcini (4):
  mfd: stmpe: Probe sub-function by compatible
  dt-bindings: gpio: stmpe: Remove node name requirement
  dt-bindings: iio: adc: stmpe: Remove node name requirement
  dt-bindings: input: touchscreen: stmpe: Remove node name requirement

 .../devicetree/bindings/gpio/gpio-stmpe.txt   |  3 +-
 .../bindings/iio/adc/st,stmpe-adc.yaml        |  3 +-
 .../bindings/input/touchscreen/stmpe.txt      |  3 +-
 drivers/mfd/stmpe.c                           | 31 ++++++++++---------
 4 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.25.1

