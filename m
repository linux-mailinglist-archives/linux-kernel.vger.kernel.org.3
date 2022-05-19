Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7A252D740
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiESPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiESPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:18:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2102.outbound.protection.outlook.com [40.92.52.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1A0606ED;
        Thu, 19 May 2022 08:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5KW/bc1AmvR9URy6rX16DVoLGYgFYe3GqBOh87jq+GZ5lnNJPqWZ4G2Uf/L0+KjmLQipYYAGiNwY+tqkq3Sk50UOTYiNvVMTdxgP63FCS2VjL1Ls3OKpU1P12k1C/qUTHR40H13aEsRr4xvFtzLAuHnQyIhqr1JMtGP8XUBCY4UEU4JnrD0ndS5AW5e2Fp9/QiLQpZwNDepElEduQRAiErHARRDy5+f/a35noaSwYX5m5EBKf5qKcESjItg/2dG/IG0YAMnVsl/9+glxt93QvN7SS0ULcaOxEU7/7YvKq3eH7/lZDL8XAIyYf8YjwDI3q/NC1bPJLUUi9Rm/BNWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdPRfZyZ8DUPFSd6YPYlPxi2mxfJDsPaX4KQ61phZ18=;
 b=LsrzST2x0r2wKl2Bzxh9r1zV/rPl1GbqFznqBo5Uv9pNWUIaO5L9cPCxJfOczdlcsfK7yAMUKmVKmCW990c3A5B5QMeFk6sQtJr4oAvIIQyPej8/OMkZK1WpYvcw9e6c5wnv0Q5JdPdQ6fZt+oMbFCWzMFBi6UL7X3MQ/P5pXvVfAbo0ZNeybsl0fz4Pd9dzsjrQ7knDl9CBJUhVrZHbARtgIzcQIwq9MV++S0UXJifNa3AuNASzYGk9QJIMKBpI22aySrwksbGOMlmx/8pNqNmqrJPOSd6b1JsE0W5xUb9mvpK/KP4Wn06MqimF4gWJr59hYsuUCiQJkLUXp5lkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdPRfZyZ8DUPFSd6YPYlPxi2mxfJDsPaX4KQ61phZ18=;
 b=F7x9N1B2KSTs9TBzDNT5Etm3ZKgtA5xGbrruEgz0OPPeCIqnSwi/RoR+qHEBtkfrv9rILYrR9g7Mp5BdseQ1946tw+nxBVQl8bt3hEu23DKxW2LWnQa0lfjPezKzvJ45KC4UYsCBHeCsXLqyLIBNuhYAlmhX3qbKrBxyoiyWrbGr++xKHvUhVSVOvkPm+2l1jjVASti5uT9OBpn7XsQTP8Jj8VxvC0BoOizTlRuhUbq2db0mOXDGwlqmQ5Lsa9ze+woGB3q9E/b2j2Ryc7hnLtbN8jYJviw0KsJxZbAkdpMc+BQprONu4rUX53vT0nwB/6YwfLby+5V8lgfsfFs42w==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PSBPR01MB3733.apcprd01.prod.exchangelabs.com
 (2603:1096:301:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 19 May
 2022 15:18:28 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 15:18:28 +0000
Message-ID: <HK0PR01MB2801538F9FA06A3B8F2B59CFF8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: [PATCH 0/3] USB / dwc3: Fix multiple checkpatch warnings and typos
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 20:48:22 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [nKhRSQu3rudRphq0OJ/GIabttgxpvyLVSVHFsyM+WYlSdireaCpsK2CxlW31HnPRPGcWMl69LG4=]
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <d986bb1ccf903124a4b54679bd5d80dccb16a270.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a3a43cd-60ff-450d-3c6a-08da39aad33e
X-MS-TrafficTypeDiagnostic: PSBPR01MB3733:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5+R9YAyFwlW3OwWwAPih3sQt+fQk+KYkNX+p13SKJjRYr/YhlB4sWBLhFOvFGepfw0Hv3/oHJV9YQE0LWfb6BOzIwovfG5ESCznTM4txpQeOSIiw8aZ5Ri7pNRhbXNYvjt/QK5ukeRoCOQAQeP4d/jkHyN63EQaC9rLpmsrNyL42ZZQhnx2OmF2hzFCU8Gqo2hJmYTGhKYdZTS7E5x62qC3LrA4FMNaPPwnJ65vh9TH/Xh+WNyjuW6qivfNLWRkjYyufcft2QlRbQ0zg/eTPiP9RUlJm/AGtqKAZPyOW+Fe1nIn45pSjB0Rz90wIrNKhjGwBfH+qYyh7lpqrTlzwbtartNY5pdVlf1tOkiY4L9rLr8scXvHFWenp5da5v8chjPSNx4MbrR5RA9tKVfqKhVw4u+KhoRBlPY6pgtME/bOY04EnzjMIVA6bzxZjAQeCMZR20NyHECACYlqSx/W6D4sdNsACnlxGSGOwMogc4WZynIKZumjKrr1CCe4HCCEOI7WOX3fivzBUh4PowqlEAh7E3KXf9hZxYl2DEIZ5FxynOaRURmbfGPVssccT0D8K0cLCVQ1Wh6NqCuGywH/qQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkxZUmhhT25objZWSWtqV21lN01zR3p5U2dPMEVJR3JUUmt3SGdVbW9DeVdZ?=
 =?utf-8?B?VmxGa1NxTVNacGw5MmVUbHF3WFpYTjhUNmdJTWgwU0RNcWZiZ0VKMWhOYXp0?=
 =?utf-8?B?NG5vY3J1dDhacnhJOVpISzhvZW5GY3Q0MXU3TTFZQ0tWYmNTOGtCL2hsVDJ1?=
 =?utf-8?B?anc1MC9ic2FoV0YwVWgvdmV3RkE3Qi80Y2lGczlHOW5RYWtmUjlrYm9OTHg0?=
 =?utf-8?B?NzZvaG1wdDBrVkIvQzBHT3dNTzFITUl6cFZZWmt4WXdzL2gwOVp2RUZRaDhM?=
 =?utf-8?B?Z2hRa3g0R24zdkZpSksxRFJaUkFqaXlNbXB2NWlVZXlOdElsbHRoM0pjQWlH?=
 =?utf-8?B?TVZ5WWtWeXZNNHMzdXV5OHpHRDBNRDhUSjgxcGFjeG11ZTkzWk5IMkszR3VM?=
 =?utf-8?B?c000TkxRSGVXK2IvcVVJNjkrdGxWdmZBNVdTSWdmdS9aVXVBektLYWdPajZJ?=
 =?utf-8?B?S1ZLR1pDVzlXMUx1VVFFNWcwdzRMY2p0THUzU1hWMzBmdUdyY0xhLzM1SlY4?=
 =?utf-8?B?UkxzOGdjZWFaSFVjZ0FIZ2drbU9HRlY0MitrZ08zS0xtUWZndXFyRE11RldS?=
 =?utf-8?B?QWNHcDVvdlVCYWVNVW45c25wMWFIR1pJaEtyWS9YTHBsaVg5QU9PVlVobFhs?=
 =?utf-8?B?VHVBby9abmxMczZUMGxIUEN1bkJSL3JONHl0bzQ0aGJ5ZStrNWlxakhEeFhr?=
 =?utf-8?B?cmdXU1grZVIwK1c2NnVyR2JIREsweGxKaGNvS0dyZkp5YmQ5ZlVvdGdFVWdx?=
 =?utf-8?B?NGZjWWZuZ1FtYzhVRTM1bC9wTHc1bkZmZXYvK0JwV29OYTVTSDhDV0luNHFh?=
 =?utf-8?B?ZERxYXRPakZ3ai9BWEtWK1dSalFOclV5VnpxS09sc093WkpHalEvNFRiS3Y3?=
 =?utf-8?B?endQV0tiRkNtQ04yaWo0c3ZxR2JSUjhjeG1VTEJ0LzFBOHB2UzQ4U3QvTERs?=
 =?utf-8?B?TGQ2b3NZTEFzK3J6WFpHVmJiVXIrRkdOR2VZci9MUjQ2OGlKR1VpZ3RYb1FR?=
 =?utf-8?B?bTZkMjgwaU9lVDAzZVNMNENzNUJpTHhGS1luaHhER3p0MENNaVNPRGgzRnc3?=
 =?utf-8?B?bXZmQS9oS1ZvajBmeXpxdDV5cCtrdCtrQ2w0OTVDRXNmK3R3VEVYR0Nwc2NF?=
 =?utf-8?B?N21qOE1qUXo4UVVWbzVYY0xpcjQzRDRPWDh5UnNvRC9ydmVEMGE3WEViV0Zu?=
 =?utf-8?B?OTBWdFFNWXRFU0NDSCtVWGdSMDdENitoSjU5QzVHYUhpWlRhRWRCdXdWanBs?=
 =?utf-8?B?TjFlZVRLRERreW52eXZ6VVh5UTlvMXVVNng2ejhCaFAvQVYrZ05rMmF6YWdx?=
 =?utf-8?B?M2gyaURSY0dLL0JjdUJmdThsbW02bHFSclBjdWVaR2sxV1FidzhPdGdrR0tP?=
 =?utf-8?B?SVZTV1hHZisyc21vZDFicFd1TFh1Vy9USy9IV1lTa2w5c01GSU9DQVA1NTB6?=
 =?utf-8?B?TmhJTUUyVy9GOGxPVEFCY1l6T0dTUGFubDU2MHN6azlnd1d3U1lKamFkeTVM?=
 =?utf-8?B?YU1xNDJlZXBoMzBTeEFtV0cwZVNHMFBZRGd6Z2RpcXY4S25PeUFURUphUHVN?=
 =?utf-8?B?dDlpc0M0dHdRRWVaR3d3eWJhK1E4ZTh3YWhVdm5tMDNuTTlod3NvZVY3aHRx?=
 =?utf-8?B?Qy9PRThkUTRhb1cyMEhEdGZrODlCU0l0NUNCSmczdmVCNm1scGt6WHJCNWtS?=
 =?utf-8?B?VEwwTUhUZE5kV2ZOVEdRSHhmd0VPclNIZVBScGc4Q2tRUU9CcXo0K2FwK28w?=
 =?utf-8?B?em4xNFB5ZWg2SjFJRElET2NUOStQYnZnaUw3T2tXSlVmQ09nelpmOWZBWlZ2?=
 =?utf-8?B?YWxZRVNnN1J1VTdmMG93VUxBbDMrUG5OdUR0TVNmYWh2RVBlVE9vUmg4bEt4?=
 =?utf-8?B?ejZjc2NSMEtRcXpIemhUQ3FhOXhMMzN1WDRDbUVTOGp0QWgyQlNDd3VWajJB?=
 =?utf-8?B?YnBpUldnckZkbmRrSXpWOG5qdzJFclFINTJjeHczR3JDVFpoc1ZkM1RjQURL?=
 =?utf-8?B?akNMaGJqVUo2dStSVmlVOTBsMlUwSENaaUI4UHBoZHFrMDlsMThaU053MEFx?=
 =?utf-8?Q?AMVpcZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3a43cd-60ff-450d-3c6a-08da39aad33e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:18:27.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3733
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes multiple checkpatch warnings and typos in drivers/u=
sb/dwc3.

Kushagra Verma (3):
  USB / dwc3: Fix bare use of unsigned warning
  USB / dwc3: Fix a repeated word in ep0.c
  USB / dwc3: Fix typos in Kconfig

 drivers/usb/dwc3/Kconfig | 4 ++--
 drivers/usb/dwc3/core.c  | 4 ++--
 drivers/usb/dwc3/ep0.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--=20
2.36.1


