Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639552E70A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346853AbiETIOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346837AbiETIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:14:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2106.outbound.protection.outlook.com [40.92.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2E56F98;
        Fri, 20 May 2022 01:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1Qb8kIjUcmdMMreuoZZIoMIdGkWMY1pooEwUgcLWhyneyPNLPkc3clhxqU8ivWwucCMF9YTEs52dvlndWjf6PS5aK0ZHNTAYjmIPB24kEAwIv3Ue75qmPmsubnYdDgaPxG6k6XrhC39NfKFDb75+qq7XUavz4vP5mRaRzXt4bJ9UQJw0prCGAOziQlfc/lEYAOL+XeeCpswIBAcR1zSI+FDBilAWavzGI2vgun9iaZlMLMFYZ7BYWBY8LALgZ89tYLAbkZPL/6q1CoU3gjWHH20tCahT6m2WtM5a5YqGpWTjydSqE43IsOoMI7Az1OtF9E/QIIkqpTZqmTXBu8KRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDSy1FVSdamf9xS4CkrUCcpHSx04Z9aII9Am2RuteqM=;
 b=mO8JIbFwGZh9jRD36aofn73i3paoh3tV7Y2qsg2b06UT5gr3y0Lq/ZQ6XUqoXJ//VE4J33wDHZ+ioV0rktXx0xd/evURfNivQE91Q3pjjhdvt+JcCPv10bGVTOWG4+/dYVtkxB5aES/e8uh/yJeJg8EX9R9l/SNMM0YIBn01ypFno5MLUVO+fpcf279R/cwk4xLRAwi8LjRIAfQ0IGTBmygmXxsKcupeknOj95zIz+pE7Zckj/k8qIGjBf1aotiCUgrYJwhEOg5k58KbtuesIxtFoFNy3abXhP5dnsxFFPuwuXPpMau04HDEyuoBaQVvzNt7kBcNCpb5rH9jD/7Dyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDSy1FVSdamf9xS4CkrUCcpHSx04Z9aII9Am2RuteqM=;
 b=L9N2CqxZS37kg+uFzB4hKgdQzCFKfW1jhfQZRxbK6qYfKcRdAfgiFFEIfTSd7JzQio2Vs8cbg6UoJ5Ko3T8oTMsHYSZx6PYENCwjpOVLjzZDg2xVLS0Sna6oyGyQqjJfbs/O/W2i+cBrNvqbizwN+CEaFLb8Kv87c7KuIN3lzxmIZ7Eubz0yybaLfqJJJDwcL+J/OexYgPyEMj0v+nqXYpeS3Q7G+ANhndJIuWPgjjK5mJwaOMWv/96Na8XI62QJMcbliVfXFrl5XGOBm9JFK5ZPOEM2bbOhSVLHrCCB3USXzxt+r/p3bCJ414YRIkO5oJG01UWpWU7QCHqV8/EA+A==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by HK0PR01MB2962.apcprd01.prod.exchangelabs.com
 (2603:1096:203:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:14:29 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:14:29 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: dwc3: Fix typos in Kconfig
Date:   Fri, 20 May 2022 13:43:41 +0530
Message-ID: <HK0PR01MB280191E3251D52856A01727BF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520081341.16768-1-kushagra765@outlook.com>
References: <20220520081341.16768-1-kushagra765@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [sbVLiwQup+7SfpezjC1W77Z7EKHcXOJZA1WGBJzATzkdYdlmacvWcFsW4pPiWd7R]
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520081341.16768-4-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17d9bca-3f5f-4273-acfa-08da3a38c328
X-MS-TrafficTypeDiagnostic: HK0PR01MB2962:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMeGfL5y8Qr6viauoTspTzoLTejto4uE52ApD16gZxH3cW8xSbl8SikE+oBTl1Q5aQ8R+84w2sOaYuAbS15OelFecSv+xYw584Qco2LZaW4qWlI3pjc78GJJcJiq4boTeUSWMhYJ3qtSdbE2rYYoOGNhZ8xeN0p/uiOMc8xC0UOVUvLV7RRdgT1iIFCVsevbF/V5ub8bJ8HSSRf7+WsKFLPTJ59KFH5Zrcy/wVyCB+BdkS9a8rKVcuhP9flwOCBcliYFQzUYNrwb6cKKKM3A0J0raMvgA0sQTVzOMLxdq3Org1qELeitgtjTGSvlUo7IUAwOWMO8sfqQPyHorMTH0/+t+rHYIO0u0Vz5fus4hS/JuTSnU1VyYrVZiNEkcYWAXl0sySDanTrRenaWGXPkiJTHgfIJQvxyLzzsYJx146pI8RlsAvyqPuOiRQIZgiL6wpK+tp66XnLPkA8NgaG0OZ4seXWCInBbH8Ie+PNHLyEZkRM60s2qA4XnZB83EKANCwRt3kr5iaZFw3XGLWUYt4U07bCU2/mulmBEAysI9sTkQcAndCEx9J+zMJPNH5cZ0loeKtlUHo9cvQO6pMyMkQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PD4yp19Ih3gvIUnPmNiyksyVwxy6aSODcJ4qA3wJxSoGldzSe1d/aDVAtmnt?=
 =?us-ascii?Q?SLG/xxTg4iEhQoeI1+Z1JoUlF6xtt3cZH6f1snQOxgcFD21PPTnpbXRFhSjN?=
 =?us-ascii?Q?T15cPbZjM4a10ETfZHv+k8Lq+MmXskSJysZ7vAx95kK0+Mw6blqx4I3HY6Vk?=
 =?us-ascii?Q?YLperhS3HBoW7PbxtMGXBLuGl1XDjdyc2GuEES0YKGsTO0aQhOtT0HAuwoCV?=
 =?us-ascii?Q?tm61djeDkI7usoaeOJxZpjrkfMu9+oAhaJggPSIO5X5gl02sIltvumBY0Muj?=
 =?us-ascii?Q?SdFmxGHthSy59r62e2iMrVSd/CASRWzSUNVy+Un5j8AJnuSJ5ZoWw3nKet4g?=
 =?us-ascii?Q?2XGs6K7LBcD2yl0YkLPdF+nz8t6lJSgM3DEHxUMh7aUyujDAPykcsXRGahbb?=
 =?us-ascii?Q?wgfznRFxkxcBp3f8q8DCHza8vG7pzMU0qFWg6uWLVFTTvUADwf29yRn6iIED?=
 =?us-ascii?Q?HuiettegjfOUuIe1qAB0Rss8h/ufnmJTud8Bs35xuCCjBYKbmyJIYGoP67CT?=
 =?us-ascii?Q?KZRl+eY8rQziqKlk/GLckRjtDHfNU5Xjqt0lmk+CDODPoe/E0HPHhkQIXwih?=
 =?us-ascii?Q?njcEBtHIwC7xbuI9u4gCEscrZz2pEXIX8+o2JF/648sXjJAUcBMXBjDH/FNw?=
 =?us-ascii?Q?lMsN5mA9qXN09A9zVDEeJR32jvn+E1oZzCNFDSCTXR2XwNvkz3Sq6kivrCa4?=
 =?us-ascii?Q?qvlD4YJTej476forzWwTPsEVAzK8y3KRvDqGTVEROM7WgoPx/Fb/zQa2T+jg?=
 =?us-ascii?Q?h4lRDM3BEtUHucfyNF3pC5fyZeE8Iw/Ok76K40ujO/wYF+bACEVsdadXe3OH?=
 =?us-ascii?Q?hXM0xRvvD7t91Y68WvJftPKT0snpi7dStMlYP4jFFFQAL6U+NgsGEjgVlgIA?=
 =?us-ascii?Q?qn+JtEqLwpK/6UbJYdeRFGKzwaXmnXtjgILJ871D5PWGoa0co0430apae/HW?=
 =?us-ascii?Q?UMNxbxQ07divNsetxmNonJpFpbASA7mmL9w476Zu7ZRRV/kuQNtWaaPV+BsH?=
 =?us-ascii?Q?hQ4/x19mbzkAkp2KLY87XMpMeYOtLa88rVYAq+sfe6xOpot8yBNWsuvnt/pX?=
 =?us-ascii?Q?noDd4ipQ20FUYknBLPxpNpX5hGTIo7JaqW/rSnQi/b/eyZBwIdvZZGtMafsx?=
 =?us-ascii?Q?jAnq06Mx696+/2WrCBWvCuiK/g8aogo/FrFfLG9bddmTJFIpk8W4kG7v66BN?=
 =?us-ascii?Q?/Pc77zPr0D3R9KLcJy8XfAgnBR5zISnwDIjvy/JgW7pIdpQi1/m19uWV0aw8?=
 =?us-ascii?Q?MxWrnA+tsf59Ab6wOVbGwTk3+NnCTkHV28lue1oCqowg+yKvCxuRHhRhc7iK?=
 =?us-ascii?Q?/tZ93CXJciK7kV4ZdIdTZ9cQt9hVysUM68TrSBuHHrtb01qUGl8q1oqKMSiW?=
 =?us-ascii?Q?6vIzeq0vFTEEtsvYpCTAnZRtUAIcrLBG10HuLQvNH+vQF/w5SKGaWm8SsJzd?=
 =?us-ascii?Q?tBHVhOepFM4oA2evI89z+ht2gmSxfsxdqmWQBUtjstlmNcCWtNUfHxj5bzTN?=
 =?us-ascii?Q?6nAFBjDJyjJYlBjYwYs6fh6bDIMGyfmLVlWX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d9bca-3f5f-4273-acfa-08da3a38c328
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:14:29.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2962
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following 2 typos in Kconfig:
	1. is -> as
	2. progammed -> programmed

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index cd9a734522a7..03ededa86da1 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -9,7 +9,7 @@ config USB_DWC3
 	  Say Y or M here if your system has a Dual Role SuperSpeed
 	  USB controller based on the DesignWare USB3 IP Core.
 
-	  If you choose to build this driver is a dynamically linked
+	  If you choose to build this driver as a dynamically linked
 	  module, the module will be called dwc3.ko.
 
 if USB_DWC3
@@ -165,7 +165,7 @@ config USB_DWC3_AM62
 	default USB_DWC3
 	help
 	  Support TI's AM62 platforms with DesignWare Core USB3 IP.
-	  The Designware Core USB3 IP is progammed to operate in
+	  The Designware Core USB3 IP is programmed to operate in
 	  in USB 2.0 mode only.
 	  Say 'Y' or 'M' here if you have one such device
 endif
-- 
2.36.1

