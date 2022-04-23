Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FFC50C6EF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiDWDq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiDWDqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:46:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08olkn2027.outbound.protection.outlook.com [40.92.45.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3191B19D491;
        Fri, 22 Apr 2022 20:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUAbvjqUnrx+LMChm7FsCOnhPTG0tLrxbM9sUywIcH5F6XwtusuLNF8zMMJ0TWybuBuO5RLnT46eFo8TPJIu/MMajAuUukNqClVb9krzkCylEKci77XRT2ZBQhe2MX2GWSc7d89T2OUV5cX1O+6RxSKKwkYVZsN8DzDa6/dGTyp7L6sH68WjFjqKP42rMe5gypcwfTr4YII7r08yXuquDik1OqyXiqTzIYuESA6Cqgm1gBkzyf4N/I6CGNRp0lGdt5Q5Y2k1fn/7fwX6R8zXZd2H06MdA/LozUzKu6NZSCVjwm0BQFJQ+Ad3r4FkL6BriaKAHBoq8FT7nlIboxYOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL4dcz39su7NoOZeM1ZwxE69Y9kWjJ7OI8DGwkRHJBM=;
 b=K+HM1JZtOFNiJDiKDpJ0mg+uVCudPy0azI6IsjZs2bJXp//UJRIxzHdkJi4sbJjCyxZTzrlLrbcwEgP/+feBJiIlDP9R8DoI1M3FsfovAfMWNGS2zQw/SrkryKktR5UEsCTVM9IrFxFvRubDlEyypf0kjFfRVdycBqSxgnhKlOCzkGMc2cL4/uexVxBF1JFBbEPLrpMcw9bW/cD0LbNO/+nt2kAiC90SQJYWuXIBivPYa4u7AxOVEGS3GzZWS9ZrLX5SS0FddT8XHmXPe/4TNCheZnf6fkzXRFNYgwPbJh2Rs9MvK17P4tF6/WzwVdxpisLyjGqVtmZeQLTyOqYv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4205.namprd04.prod.outlook.com (2603:10b6:805:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 23 Apr
 2022 03:43:55 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5%5]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 03:43:53 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 0/5] mtd: onenand: samsung: Add support for device tree
Date:   Fri, 22 Apr 2022 20:43:11 -0700
Message-ID: <CY4PR04MB0567451F82EEBED23A7559EFCBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [oHP3j3Exn+1rF6bz4+niH2QFQiO9/w71I0JahMnzCuDIaBjtLpfeaHABtma9lTat]
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220423034316.366488-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e32a0330-3a2a-488d-2126-08da24db7c99
X-MS-TrafficTypeDiagnostic: SN6PR04MB4205:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhN4ZC1ILRhdUhV8/YAQ0rNJP+6H304QgzCH77K4HvJlkn1I/76VQt0g9R2NjsMkZJkpaxM01NloHXz0SPxpcSbqXwuIKE9jBZzZKbsBs4gqLyyRj9IYqLo6bXEJguVvczSqUPrj10SdCjDXlyBAQsdLtudGVyS2XQIV284V4XtAexaAlaPAVP7tB9Jxp34/31kaEuXsQHVwC31pcVc552U77+qAOeDZrg9K9kxm4brpQOsM7A4MYBN3kDg0pMoB2te6A7Dd48a15GqML9FaJFsmf/oQ8U+o7KBDDdN2EUlkAxb6MueWCxpVpjj+ZHEMxQDMCD3nWWIyN8j06rOxApt3tF3v2gJN1fsiYxKkG+egSI6lbAQQFALVu7WQopHUQ1zW2uCorHUWqDcaTQCoWC3E0HYe9rhD2oAZzcdKJfRTZ/NmywENRRCgGHJ6TjiYhF/GV5feD2z06ypZynD0hk71u4LhQc2VMJHc1yVxgzmKOdu+KqI5N3s/g/MixrK5uFB7Qi96s25T4D9IFsAJ9Uqegszp9o/eZCIypiAhKBkmFSqTSbNaDdMmdAY99XMj6KHzF4MACWxMimG3A0Ol7KkqgwrKcqZXCA/SLf5HDZjPmRmsyMSZbJYg00WFtjux
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTRhUlVOMmV2dGRQOC9odUNTMGVSS1A1d0JlT2hRWEJCOXM1d0hjaFRlS1Fj?=
 =?utf-8?B?OG9EeGY2bGM1V05FYWZKeUdKUVdndVpuTW1vUlB0bS96QmF3Y3g4c2ZEaXVN?=
 =?utf-8?B?TTVvMzk4Wm5ZbEtxaWZUbEl6NFFXbkVuS24vMUFnZkxJTUR6KzVwM09xOFQ0?=
 =?utf-8?B?eXVFUWVGMnc2aWxyMjNOMWM1dHFPRUNGQnBlWVFRU2ErY3laeGxoV0V0R0t1?=
 =?utf-8?B?c0lIMlArMUNReUk3bXVRdFVuMTVmNVI1WDMwRTlXSzdwTTc4TTVNenZBNjBY?=
 =?utf-8?B?QlU3b0FET096bzlKQ25Zd0R3SVBrMVREZlZ4TDRxNk9URFRJbUpra2tkU2Vp?=
 =?utf-8?B?eFcxRVBTdEdWTmxEcDk1ZE1GOFVwVytVVW85dW5kWmhFNWUrVFVpZUpIRGRM?=
 =?utf-8?B?d09Pd0U4MXdrWHZ1MlJoZ2lmaHhmckN1NGVTQldtUkIxeDVML3MxWlpmL2pm?=
 =?utf-8?B?N0JTN0pTRERnQmI4aFp3a2FHTTM4RXdhdGFYZTJDUXBZd2YybGhqTHRBcXhl?=
 =?utf-8?B?UmhJK0xEcG4rcWV1RFY3dFloLzZwV2t0aXRlWm1mUHBsRWpHVnNwWjgra0JC?=
 =?utf-8?B?L3dUbngya1FNRmhNT0tVTXpMeS9VTHpJRUtaWFZtSGdNYUEweHZzZ1lHakJ3?=
 =?utf-8?B?M2E4TGFUU1ZkY1RIUHJVaEZvUlJlSHhvYWNtbFdYcW5ISEpRc3RvMDBWZjF3?=
 =?utf-8?B?RDdpWk8rZlpZSEFiazBFS3FRdGxXME9xdFVOUDlHaXUvUHp2dlQ5cUFXWkQ2?=
 =?utf-8?B?UDZJTDVwVC9kYUYvLzF1dUFmT25RL1N5OFFOK1F2SE44eitaNnhEb3pjb0xJ?=
 =?utf-8?B?K29OOTJ0N05adU5IRHk5eWNlWGNtYWkyQnNtdEhEUTFOd0JvUzJrU0wrbEdV?=
 =?utf-8?B?Q3R0R2ZnZ3o5bDVLQ0JBWWtmSTBuc3dWWDJFaEo0YUVwblh2VlpJazl2Wngy?=
 =?utf-8?B?VVcyRnpMQU5ZYWhxNVMwUE5UcWViazBzdFFMOXVaZnJTL1ZZVnFlc05FVVJj?=
 =?utf-8?B?ZFl4UURid0lyd0NmaGpndExlVEJBQVdJSk13MmdoZi9GVVM3cXJvRUJsUHI5?=
 =?utf-8?B?aktUdG95OW52QUUxSkFqQ2dZejcxMWRZOXhXU1g0cEsxVlVLZjFyc25hU3Fi?=
 =?utf-8?B?UmJjU2dLNHpQQll6UFhQbU9zdzUvRFFzRHJmT1I0YTAzcXY3ZWtFaTM4cHI1?=
 =?utf-8?B?T2RhNVA2TE9sZ3Q5ejZaNUpnbEE1K0tCbFp0RWhRbFhmeFFiNWUwK1dCQmxS?=
 =?utf-8?B?TVRxN3Bybk4yb2xWVndwSEN1NVpmYWsyNkJLRHFualBFSllqZEJIUWNzYndV?=
 =?utf-8?B?b25hQkREeXM1ajZHekdGd2lRNXZuZ3BxVGExbTk1bWlYeDdXRFJCV3R5WklK?=
 =?utf-8?B?MG93U2ZncFozREZkYURmcVVCYmkvMkFnQmNEb2RnTk13NWJzdTM0eVRPMjdv?=
 =?utf-8?B?UERtQVZpTU5Rc0NlTS9CZjUvcWZ3MUJsT1BRN013elR2VnFaeDFsRW1ZRm5s?=
 =?utf-8?B?c3VDUkZ1WENWQzNtU3pLTzZYeHFFd1dETkNHUVZNNzBxcFhQa2FiMWFmcU1V?=
 =?utf-8?B?M0hTTHM5QzlGZzZDRUNaZE9TNmk5cWJ3YlcwVTBmUXg4RWFDd3BiRlRyS1I3?=
 =?utf-8?B?WHE2aXNTN3RvMStnY1FhOFdHeldFa2dPcG1LTWFQOWFubnRCT1lSWm5jMnpn?=
 =?utf-8?B?UjRSditwTkJkZUlVSUVNRkdXajdLM1RhcjQxMDFSYlcvdi9wVzlrVkhQVHky?=
 =?utf-8?B?R3pXM2lNelpaS0hOWTJnNzg4YzNQeVd6VXF1a0lVeDN5V0NUaVlNZUJBcXl6?=
 =?utf-8?B?WEZyRjNmeUtpR1dDTXBqWHlHd1VmYmRWMy8xbERsZ2tIZjFES1FKY25hUGZL?=
 =?utf-8?B?ZmxwUzBML2ptR1NpOFdmTk5SR09kQ2pkN0JrOStMVm5DenhQSjlWdlNFQ2g0?=
 =?utf-8?B?NXBwbFUvb3k2eWdjdmYxOWJWc0kzTHV2bzZQdzF6UGh0Y3Z2c3VVYnJ0ajBV?=
 =?utf-8?Q?CDMjH/CprrPPhqpjrRkl2b2aQKNzrs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e32a0330-3a2a-488d-2126-08da24db7c99
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 03:43:53.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4205
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This builds off a patchset submitted in 2019 [1] and adds support for DT
initialization to the Samsung OneNAND driver.

Compared with the revision posted there, the binding document has been
re-written in yaml and changed to have a separate nand node below the
controller.  The patch unifying the resource order has remained unchanged
despite feedback - I don't seem the point in splitting it into a rename
and a unifying as the renaming would cause the variable name not to be
representative of what it was.

I've collected the R-b tags from that patchset, but dropped the one from
the commit adding DT support as it has changed due to the different DT
layout.

[1] https://lkml.kernel.org/lkml/20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com/

Jonathan Bakker (1):
  dt-bindings: mtd: samsung-onenand: Add new binding

Tomasz Figa (4):
  mtd: onenand: samsung: Set name field of mtd_info struct
  mtd: onenand: samsung: Unify resource order for controller variants
  mtd: onenand: samsung: Make sure that bus clock is enabled
  mtd: onenand: samsung: Add device tree support

 .../bindings/mtd/samsung,onenand.yaml         |  89 +++++++++++++
 drivers/mtd/nand/onenand/onenand_samsung.c    | 120 ++++++++++++++----
 2 files changed, 183 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/samsung,onenand.yaml

-- 
2.30.2

