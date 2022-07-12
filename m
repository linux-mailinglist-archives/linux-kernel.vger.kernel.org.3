Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959F15720FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiGLQeL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 12:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGLQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:33:58 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0163F25C6E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:33:56 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-VgJdKDDGPzm1-LsY_lWKuw-1; Tue, 12 Jul 2022 18:33:54 +0200
X-MC-Unique: VgJdKDDGPzm1-LsY_lWKuw-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0173.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Tue, 12 Jul 2022 16:33:48 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:33:48 +0000
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
Subject: [PATCH v2 0/5] mfd: stmpe: Probe sub-function by compatible
Date:   Tue, 12 Jul 2022 18:33:40 +0200
Message-ID: <20220712163345.445811-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MR2P264CA0128.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::20) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ab04184-025b-4c15-3fbc-08da64244c09
X-MS-TrafficTypeDiagnostic: ZRAP278MB0173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: OMFxFegHK0/uTAiqqIwvy6M1oWZjTLJLkZm+gD7LNrIZFPYaPR8mio40yZEJqq/P2/BouEPufYcCdr517MNxCKwwnmZ5DUgqTL5TEFfrwfeiEuAVHpvi5RRt9DRnf8AzdAiziL+ETwoNVX0FNWtb9Qj+Nu+iBOuDH4AnptWq4zNC5SUJgx40O2OptcSFYcXDSVMV4o3j18xgv+/lIXffVgZN4SMOMn7xjc2INvEz1ShL7KZ4fq3+RC7dzPw1DRv+To29NNIKvNu2NfyEJ51z0V78Vjq4hYc4BLOs9RO4EobQk2dkFWe6yxYwCt36d30ta+ZH2LxlReZucCDIiEcWsOJ3xhwb48WbVFjwsMvqN4wELsB56V+yuyC7wKV8eXsLWkJ99DTtfioeoOmzgLPH1zyT7iNRZ7x1pzgarkjwIt5jgDL9wdkE14QxD1pUvfBsLxN8QGgk+hNdZX/e2j+KYKYQg17+a3KTxHbkujj9PVVcLLN7SYF7cHmAQNGEPfmhcSjM4W+vY05c3CWZMBL+wG2kIdbfksuY9XfNOGiMjQh5m9ngDlZQ4XHJ13MWTP0hpf6iycAK+2eK4Ec2Rpqw7oNQQhesEobXZt+6JGIVFasKf+CkUOHycQ2KyKuqT5Mi0q6vl+z5+3XzwP9ASUf9ZiuYt3q0QisPKEWAQJBDREqnTnXiHE3PrhMCOZYsjzPV1gJ5Xz4TAkkKO5dvij49CR8TKxjZjxfkkYtM8aa9oUxUjoJZJYdmbnDMacVmsZf0tyZA4KK8iznwy6yuIRk1N/KPRe1BuGi0dg1vYNYmX+zs9xH9crleefKDmvPvVxrmYjTVjYE6UfAr9gzkvxVwartB/reab2yk2rL184g661c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(478600001)(44832011)(6666004)(36756003)(6486002)(966005)(8936002)(41300700001)(83380400001)(54906003)(7416002)(110136005)(316002)(5660300002)(2616005)(66946007)(26005)(1076003)(66556008)(8676002)(6512007)(186003)(52116002)(4326008)(66476007)(2906002)(38350700002)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ts+Vno0wtMtrwKFqpb9t6F8Deo/DL8gO2uG+BLmkfHDdfsK2e28KD6k6Tc7?=
 =?us-ascii?Q?xLCyLBzuHhM/27T7GL44VeZb8ryx2tMHwqASbmFu3AsQ+VnfqqYdd5kuaVP1?=
 =?us-ascii?Q?6N63WUrFZdUYLLJBmCbXcREJ2exWtd8h9kIXB7rHCNWdhCTcrZ5Mpwl0zmqb?=
 =?us-ascii?Q?kyGKFyJ0ZUIdDb54U+U1guyJaVLwTHGcWD7EFJiwL4upVY6ChW+1SHMlQ0xP?=
 =?us-ascii?Q?fEsoGd80XEX79EWpjECMiYfkmX3Zqut1bt0k+RxVEqrXxFOjy3CbGXjVsFJd?=
 =?us-ascii?Q?3aillgqcKEz3epK4aU4nD36roIVLUm5m7IsZkETDgJ4DAlDmCfI4kmEiZ5W0?=
 =?us-ascii?Q?RVmqHMs7y0dIMLbbDT9vhAqI5YnNC+HP3xRf76YDWItPqQmwUh26qYZ0ReWh?=
 =?us-ascii?Q?1OuxvIhFariSKeP7p9ecywnHwNaGVKliS4neshsweMXY0dbC/jTYkXg8Y9Sn?=
 =?us-ascii?Q?etiIi8k5kOEG65TC6Sx43yM4AyvJcVjoypG7iDSNcqetvW1TT3s18Zkiivxb?=
 =?us-ascii?Q?Y7z3Ec+GNSNkaRNFd9Vr63Fk1YZ7xR1SaWi3lQzgsf2yYiuKRulGeDJSb7A+?=
 =?us-ascii?Q?QpIdRP12uvmOZP7YT89H/WDtu/raRHamTQNTCX35Vs2VOHDUatzhHhI1CJ0H?=
 =?us-ascii?Q?7n+C00WK9w0hJz9nLxbHg0BkVJ9Y8+2cQjJRZEhYa4LxF279DPVzPvF8JJbm?=
 =?us-ascii?Q?FdayncKNXCv2gHk5A4aQaPknLtOouIst65cxWK61NenJhCMmTIOCZp0UFsUO?=
 =?us-ascii?Q?Iy/ZhUSxAdA22OT3DvoVW/nmKsxyo1BtcSLowJHwM7eSEpUmr1tQ4lLrSYcc?=
 =?us-ascii?Q?K11OZy9V+u+5ZOFxxTRnATzKFoWzw9P8H8M2s1Ql1423GyPL3/FVnPYG6xil?=
 =?us-ascii?Q?FGwpsWvG9cwG8OO5ksN/LWlhe8wRxMU5QXinTGLca/BiDAUbIAjW2uMKf29V?=
 =?us-ascii?Q?LNSX6vZeYlgeJ+GL4FJUh8EDSlSQYHqutV9jo9roeo3+fCdQcYllXfiSK9l5?=
 =?us-ascii?Q?zKmWm1DoYvnZSqWZ9TouW/Fki/GU24gK27F30vDdHerTq1Rg5yHEiu0JUvPV?=
 =?us-ascii?Q?d7VoGxYGrsObeGsdwRfFl2MIDvB71bbFefgz+IZ1hfH9UGJ6UnHhL+/1K7rv?=
 =?us-ascii?Q?QUHAb/U3smj/taGxzJi0djKf9ek144i+QjF1yI5ibaIc4Ol26jCwwyqtkzqJ?=
 =?us-ascii?Q?fnfSAQ9oI7a5V0ixnhu1P+ujjG85CtQwYMdurzfKupl1dJqmpdvzWrngBdK0?=
 =?us-ascii?Q?I9VKWd8M07/a/Ke9ks/5lvJBTGbBVydieSoMaCVht24ygomdEYusTSWCatn0?=
 =?us-ascii?Q?hYBkYr+smaDBQe798DhmNtB/v30g+FFdmcoQLOsHcXUdWoFrjZOXN0iCkjkK?=
 =?us-ascii?Q?0VRQSnOsKulicAjFHj9He8lgm7hgXKf4OP+dgB5BYPQeHOJKZVIG9+76Tf7c?=
 =?us-ascii?Q?5+Gfl4wY5Vs8qJrDG40qCtCa6XIQcbX3wwkRX16t3hRDGHh0+BUKZiYwWXXc?=
 =?us-ascii?Q?HqoqKXRiHw8pc+fWmx48VhE44iBeuV3JM1u5LDfyb6DFnr1LqC9crPqaEoos?=
 =?us-ascii?Q?9nprznsx9qaoq/+tZn4CLE+9mdW32u/x2k+/YDBXNqncI/O6XmxgjWN/Gh2P?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab04184-025b-4c15-3fbc-08da64244c09
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:33:48.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+QUdCX9lgeKAB3WU+pFG8xJTbQQpZT2vMkUkpDmKqVXZOWJDbyOIwNsZp747rOLLlNib4csec1G0iBFmT2FmL13trr5ypdQg5EdCre45SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0173
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

Changes in v2:
 - split in a separate patch the removal of rotator from probe
 - remove define usage for compatible strings

Francesco Dolcini (5):
  mfd: stmpe: Remove rotator block from probe
  mfd: stmpe: Probe sub-function by compatible
  dt-bindings: gpio: stmpe: Remove node name requirement
  dt-bindings: iio: adc: stmpe: Remove node name requirement
  dt-bindings: input: touchscreen: stmpe: Remove node name requirement

 .../devicetree/bindings/gpio/gpio-stmpe.txt         |  3 +--
 .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml   |  3 +--
 .../devicetree/bindings/input/touchscreen/stmpe.txt |  3 +--
 drivers/mfd/stmpe.c                                 | 13 +++++--------
 4 files changed, 8 insertions(+), 14 deletions(-)

-- 
2.25.1

