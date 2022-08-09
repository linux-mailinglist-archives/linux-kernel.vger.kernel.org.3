Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C353F58D4EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiHIHyf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Aug 2022 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiHIHy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:54:29 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C774321275
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:54:28 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2113.outbound.protection.outlook.com [104.47.22.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-gq6XmYScMu-XZXBk43DfZQ-2; Tue, 09 Aug 2022 09:54:20 +0200
X-MC-Unique: gq6XmYScMu-XZXBk43DfZQ-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Tue, 9 Aug 2022 07:54:18 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 07:54:18 +0000
Date:   Tue, 9 Aug 2022 09:54:16 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 0/5] mfd: stmpe: Probe sub-function by compatible
Message-ID: <20220809075416.GA7736@francesco-nb.int.toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
In-Reply-To: <20220712163345.445811-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0032.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::20)
 To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ceb634a-9b5f-4b10-2e90-08da79dc5c97
X-MS-TrafficTypeDiagnostic: ZR0P278MB0027:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: XtA9Yl/F9q26mjSNccKpCl2fLmTjduNkRAQS/KL6QcX+fJpKRPcalB8NFhPMyxpf+UjtnFKsyycLBumekZ4/UH5WbagPQYc2fT5Ed6/uor+TbiPy4+r8LcnsZYY/6erjjY3Kv1ZbrohXrKZeiHuamr6DwzMTrYGlN10bmeTsBYSW780gtGNjarGqzhB64fIYr0xrDpJYgxZ0JgfbzvEF/kInUmKInUOzp0FooRiEv1M0Kh0SCX5O6HMPJSJtfL5LuYLd60TCiE6nuzVlBwZuO/WgKjW8MFOvTyssQS464Rxzcetp0lJu+jp2TmXW36ncaJcYGv7NgieVQbFNc0eNzEHSYtY9iEbX+5p/i/TEtzUEYy+3+c+3XfKYAOUXfF/kX99X/IIM02ka7mQsHNWpXQxCLA1xf9bj9uE2tzd9PqGMq+Zz0TeZdNyzDK7xxFUY+7g0vkBmOk0Tx1PyJXOOD6RBVCOClooozprbPqAYVfJxWdU80bNKmyLRs3ODmfmE6TimdnkkFUI8uf0SEfPmwsXcR8jVdBPx2LH2qciYsxf3n54E7JpF2a2tzLyQ8aQlGZT7UmNvVdOFJs1cgTrX3aBFhLSbZhnCiGQjQVjEGgFkzNFJYP43qzOmGHlXvdDIo7e5L/MzWC6OXjn4fmJpLn7ygZ/cH6AO52kTEJ5x8qLPYbZpsMP4oBSbuSxa/EmRnBcQTxj/W3+J6wu3bJpRsAvWEGYgFscN4DQjEgl02fJ9xnpip1hF5ZLiVQFEn/oAuJCBKkcfM7LAJoK691A4V8aajIn/ursyBqf0nTlJoxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39840400004)(346002)(366004)(186003)(316002)(107886003)(1076003)(6512007)(26005)(54906003)(110136005)(4326008)(8676002)(86362001)(33656002)(66946007)(66556008)(66476007)(38100700002)(38350700002)(478600001)(6486002)(41300700001)(6506007)(83380400001)(52116002)(4744005)(44832011)(2906002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WTyKcGn21he3esUKip+IXOmstR1G+5u3MCjkH3P5uTGOBPT+Ik563qG7WIV8?=
 =?us-ascii?Q?nXL6yQMOrueKLYOZGFrzO8f+X+hAN7ZiimQB8BL0UBWWAaCKuw0nCq+8XOoH?=
 =?us-ascii?Q?wgfbCieUzJ+JBORj6NsL6rdZ3/DZ8MHeX4ysU3nHdHW86vVtgqjIKsvv7xpm?=
 =?us-ascii?Q?NH19Y5gRtwYE3PPEZUCeboDrxQShIevdIWcyNZh20PDteOUDOQYUudk1U9YY?=
 =?us-ascii?Q?OLU8AuyskQoKjHYQbbIcAKYcm2pCdceh7EDFZfqwpG8JmdVmI5hd3lnbgWPK?=
 =?us-ascii?Q?eiLsoMRV7/o7dbBBMEEHjYYYaAmNPrl+X+88UQe+cTFLe9HnM0YU0ySdmK7Q?=
 =?us-ascii?Q?4BmxUUmxu56Km6I//Cr86qa7t+oOQ7yB+ML7ZBFCmPzmkAihbIuMQdUuwOac?=
 =?us-ascii?Q?6XmLT/0CAVzqE6zuAubkIfTAdcJG0pD8AkJeZYCCgpevgEZdoTZ3qWtJJFEl?=
 =?us-ascii?Q?q9jfEph9Ew/DPXCX9u7hmHibwJR6LTJ+8CReSHYQzvwiC959Un/CmkwhsASk?=
 =?us-ascii?Q?c6Il0aMiNbiTf2i5hN/ibDxUyPOrPlzvC0YbVnn1pAfAT8B3rsG9RNCZo5o4?=
 =?us-ascii?Q?+BqPPgx4CZ7v4/R6bGMKZPf6EVMwJnY5xA9uEDyVnX9XPWbGC8nNtJxL4h+B?=
 =?us-ascii?Q?geM03YIo+8fHRwd2Lx4KfSNObTBhnZXfsZyPDAyo++86uRrtM0VXaJkSBMyq?=
 =?us-ascii?Q?5zmYtjluhq0hdUh1utcC9AdCvCSvO15lyJwwfna2hf/qCaBuHAvXw2LdpJIe?=
 =?us-ascii?Q?aw7AQt5IAEPjhNwOQCQNBKyLlNa9B59snOAzdX43egk0m4G+CFmHYagwxxTr?=
 =?us-ascii?Q?5Kr1N7Y0Ev6oPqrq7gE/Pg/Fil9TEth6oomO7jTB2jrkTwFfFF9PS24cTt5C?=
 =?us-ascii?Q?Svb/o2/o4Tw2AW0Olph4BYQ0hlbPJmFMuF4U9xoHY3uxMvMPbyINPQDVFR8/?=
 =?us-ascii?Q?uIvbkMlnhrEEl6615Ca/DWGCzzda5B5/fJI2UQL9eRLCCvDbgG3snPU9oamT?=
 =?us-ascii?Q?nnpnNPBPj0znsg8+TzAp1KbpJfJjpHucVe+/3DTYyS+3yhzXp5RkpaDwd6mn?=
 =?us-ascii?Q?RqCqw9PtxKNtLDQedAaZOxjdITHqGvzlz9l2TqTIJ1QuXa6JYYbkKJsAanhl?=
 =?us-ascii?Q?m0ERFuKQjM7q9nYxd2xCLBFloXK+xH7qPsBrNI+XGEvvYTUcgiPG/KozeWb2?=
 =?us-ascii?Q?x7XYlPMurl25Pd30Qhr/lv0T8iZCPIA1VDgcWPVrGOevCys9Nix7PlGasiXA?=
 =?us-ascii?Q?wQSGmzZCF6FRy7+mDonZSMI6QaB01bQYh+pzznEugDxECFtpzoA5JeyRQGKy?=
 =?us-ascii?Q?jkcQhpN/jpiz1UjBndQHim0KY+FEYKBKi5C2QhjcujA29+UO0pCG+ObGnAWp?=
 =?us-ascii?Q?cjji+/abkcQ5nF6ijZgFRXgaoYO/4k/9nludH0y9GEITxq2/XEy0CJCV9PBK?=
 =?us-ascii?Q?KjLFikzeBTs6WmZgLXyGVFKxZRd4yjWZY9KD6zqNL8G1doTvAlhPs7XC0ASO?=
 =?us-ascii?Q?0PnVX4GllyrmSnJfP25KPV6gyhIYq0h331uhWmg6HRurI2b6YTOeWmFDCzef?=
 =?us-ascii?Q?E+M9GGFnwJJ0YjBuYcOxPJWZ96JJDoTKvegoGDbf0n+D6G1Sz/w2X+g8unJB?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ceb634a-9b5f-4b10-2e90-08da79dc5c97
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 07:54:18.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQTNtcqtQqAoiKFN3Z9xZZ3YqIhHoTY2l4waA8B+E253rARvr6YBpFZXUaTHjWejGVFiojUTlIGe6yG0AR7IGP67kSHkm/+25Saqg9TX0eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0027
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,
thanks for picking up patches 1 and 2. What about the others, should you
pick also those? 3 and 4 do have all the required acks, I'm not sure
about 5 however that has the ack only from Krzysztof.

Francesco

On Tue, Jul 12, 2022 at 06:33:40PM +0200, Francesco Dolcini wrote:
> Hi all,
> This series update the STMPE MFD driver to use of_compatible to probe for
> sub-functions instead of using hardcoded names.  Matching by name does not seems
> in general a good idea, in this specific case it is even worst since the node
> name are not compliant to the current naming convention (they are not generic
> and they do include underscores), and because of that recently
> we had a regression introduced [1].

