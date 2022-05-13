Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C96525B26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377135AbiEMF7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 01:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiEMF7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 01:59:34 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2186.outbound.protection.outlook.com [40.92.62.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D1297431;
        Thu, 12 May 2022 22:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDtPd/imJiyI9o6ueO5xFQxdXO3VXKxSqByR4rzhqoydCqfBbS5fntuQbfWJIx4fJOS7bSNlU860OPFOPo2egfJZ5/81viq89BFI8EWwhx4TslzUgFHRqLwBtE/oEPqtQbspwl1nl+Lln/7aWnUwqmnxn4eJvDK9wJJTMaZASoTbkxdIf9ri0hCLkLMN8DVGG+TECY2xHgdFLQ3+Yamd77CSflyttD5ZjqAD1k08t7DPeiqKp4UusFS+2XLubknDnBkHYoGZFAom/AojeLXKHGfv11r5DT7llFHSvc/qdXh6CfEVPqx8egi3slOi1SlLkE6Y3ZRUS7X7I1P1ofILiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3aI7BtxtOFOiGWjIFVohoqtYW+2ewbsjGs5XiSlGlE=;
 b=k5jU68TmaZ4HwHAzkHHZ8LzvZ+pXKWk/lXPU3Dn5tbdqezpg9UCtj7gMKPNakA8OIYKrkeeHfvtwsDAeHsR5nOiV/+wIFNtR2xY1jedpg0XyqS3irGu/FsE9qOYh01qYcF4L72KwMocwPq+vcJe+8jzRcPGDgEz1P329zZ+SC6jIIbuORUzEc5h4kuyJf4RctdtnyxyWOdEy9njiHGZ67laB9XHtx7vFm7EEDUKnhb6JssxXYnE0xQu9tLHVTH9TK9iQnBbqFagrBp9tUcmfckbNmXczl3ugYfKbSxdgE8O00pIVCMhyKE0zvUWRDZcdWqqvAshrchZji21Lq2nReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3aI7BtxtOFOiGWjIFVohoqtYW+2ewbsjGs5XiSlGlE=;
 b=BG6+C6YTtSmosNPkP2yYv9WEgmzQgOciHHmaTgOdnx0P4B6HL0Pvi0+ubQtt9wGiQuxWB29iYJEKCVki7nwTDbA/TCBs+UQm8XTfDAzsivUtAQmSznpbM0URcHqADrD+gAe46hWghogTJtn8J9aVfoWC3/14TtwDVX2/1L3FkySBPwNsvjw0Co38rVkrc2ddngtobIYMbFoSk6ioQFGFbU0W2oN9g2QqlGB5eZ++Jpy2a0DoOrxCBdgKkkMimHz01Cg4Y5Pwn2DaFdmn4qcwBOgAhn4dkHP+RDMXQpBckpFEPysBunyYkO4gJIg+/65TQjzhJDSF1p3WluAwwQXJPA==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SYYP282MB1038.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Fri, 13 May 2022 05:59:29 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 05:59:29 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com,
        gregkh@linuxfoundation.org, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ylintan <yonglin.tan@outlook.com>
Subject: [PATCH]     bus: mhi: host: Add support for Quectel EM120 FCCL project.
Date:   Fri, 13 May 2022 13:59:11 +0800
Message-ID: <MEYP282MB2374B995796DE1B2D23FFA02FDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [5zvmm/VNVZO13bbaZGWXei/EGptzNTmL]
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1652421551-19299-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e4e7d5-7eb2-4b13-b52b-08da34a5bdf0
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiT0P0goehyhtndtljGfqCAf4laybNcKyd/GIiqF5pyVRwJl5CD7FeNbY464JO2NAUPUuxRIQz/nA6/DWus1KjkaDFjLGztH9eCiAfmPyJEzljbVnhGTTXmN4tNs2PB9x0ONlTkTceyG3UPNrjR698qDg2LctDVEDGJv/8+yk/01RKr71/fKS98AIlDhvOQCxvOyYrg2GQF9KeZxRJUA0lIcHe42EWUBc+tvC5Xt5uh2faPBqL5DQ8SLQbTe+m5lH3GG6IMw/HP0V16NaSYair0mBHap9CsHRSUhrYM0xL2XyP//qjO81XOEdgpzRHTqcLzWdMKe4m7JLBfz3v1IsW8wtY1WP9D1J50nnM6L4yzeXpcEAz0GO0PMrPiq6lFEnQy9vJrUZjiXyl2s8x1lfmqy0K30gdCS7xH6QKWHsYDLpBWCYM9GX9VXmdXI3SYY+84zcha4lm5I4sYgfubR93hY8DBaVTLN5nyaFXw5ef0zn4oZxVLGCIHBff4cwPQLVtKeE7JXtQS7G0/cxVxY1rqTk++k14Fun7AHPjxfOZtFjihboemK3XFQvbOGMlpP+azFMG3GZGblDqIKY/bdEPpA+tFNZwRGx3ucURxt8nSMfHRQl5Gn7dya63pquLDESNWhet/y4YKxE3h6iSVEC0PowtuHdKfwxIa14b8nN25ZV/+e4RbHYas2l3sMjdf+OnwW3pfP1mAAHBY3iVhbNKIXI0vOzkMeQExMOBxw0wyfJoFUh3ZPKKOg7Ry2nddk/2M=
X-MS-TrafficTypeDiagnostic: SYYP282MB1038:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vwPfJHtD/kSWPk9ikuYb+xU/rXfEFhv2VM0v3OjhgjfWmoQNZQNdlFOotjWUzdLjvOkHtP9l8Bqo+POHVz1Y8E0gewtNr4CYTl8qV5ED29FPKB6Esr0X2fdQvc+g6nCr/MXn3t2HR2SRtl8/pJU2kwMSL2V0hc/itysvUbUR4dXwQ13EQ/e9aq+z/qSdexc1HH7hIIDcbZ3MFOsyJTRRNWDwRHFjSYcoHlNNuJkx6bb3UlS69195EGyqTOGNh3tUW7O4jl7/SKKaUSKO2BBa234LMO6+X99M8f8xlSp4AUXokZNjyqKj/spWMUXU8YO7W75D1vjeheQqY9kTg3edVnLZtrLRcB6ZaKQy7yCLAPImIj/BzvSv5r4FCgB4MZCjL3S93GLEE/zPOmLVrGROz0W+/QdCwctWZ40uaMbFJ0WHUiBzTU2d514MFDpe75ECrG26D2E1kG5mmmaK1mHUSF8yTBXyOSWdJKsqZJ7t8LCd3I/NOuHowvFbwwpc10QOFS9XxGuEXYgfUDhYm34JtKsr5rqU5DeLsVBmZn779bKjF38pOPA2oA/+Pph+r7U/nXmoXPy60W10/gR/lt6BS5EO6IbDKCRx8rjcGc6MVIaaJCYPKHMqNnF4t6PhOYLB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYcYgSgH0suvmPqbJTrKY0e68Otrvnd5k1SuavdkHyam50W++lqmTxqVP34i?=
 =?us-ascii?Q?pAubvukwvW9OVCNENHtNS1BL/3TQXScQejcSd8efUSc0AuTHdXjOe4N17+wk?=
 =?us-ascii?Q?HL62k5YoBVc02TqQbMyi+oIvbU9QjiFVQ7aQo79qo+DdU+5tKI2fewxOAc5i?=
 =?us-ascii?Q?Gqay5D7e70GMU/OeNYs9sl2Pfi8jtJI0v5CeoAOFbz9oIDohTCmWKo9Uz7hL?=
 =?us-ascii?Q?S+ijn5hiEfwxStAq4FlqzcG68AxB6Yn4hnLibjQXgrqbO1/8U93us71RHxHC?=
 =?us-ascii?Q?wUFPH86pqmaRgckITbp4Nq0KnQDk5lyXBDENthBUQmKOoZSvOAx/1mVikoWN?=
 =?us-ascii?Q?FlgdOmms4lnwsiVskiJqK22RVLtO4FaNjomGQqh3Y1pMJsZbI5J0LvIVxyy+?=
 =?us-ascii?Q?LvKjniruc2cP6kY4nDf0BbiC8nHAQTFFfWzL7857LwbXLJqD4RbMmQ6q95H5?=
 =?us-ascii?Q?qjQC6VlBLF4iwjF0Rfg4H4I4eAdEdkIjf/37IvsXC8rkHePrlPwJDX55B4J6?=
 =?us-ascii?Q?Xhc7XO+Q8B6fRrHSYf4jML/Tg2JVOJIYMt7sRWTUUhCCud7nLdbHwMqq8E7K?=
 =?us-ascii?Q?o2S7jBXpuubgEQYiQ2iBRDTOhUAOrMtjAm6rV1IbsGvAOwcqsKvmjHivXPrl?=
 =?us-ascii?Q?YKCIz/xk+ZtHgEMgG5lXJeLXdLstBpKUXNi0KHM6F/JClSowb7v7m03EU5Xu?=
 =?us-ascii?Q?oVsCb4JB52qrF1c5Gq/EaKnWlpWvp3vlyE1O8ZKWyiR9tq8RK/rDxLjP/Gaq?=
 =?us-ascii?Q?AY9tanbzCjHLDtlZB0S0U67u2INHdw3CaA7JWdLEs3zQmIarviXpjA2oY0+j?=
 =?us-ascii?Q?oMOep+N+zf4Yspg8ZNrArlPKKXJn2cvKiY//8OFGMJX25OIFR8xJJAHRjKEZ?=
 =?us-ascii?Q?MmkEiqM2gOMVTIV32jDE/AKMF84S+avUmlgIqV/HmUwi5m9Lqu1eu+CXOO5R?=
 =?us-ascii?Q?vpJEf/o7dubf2s4eq5u+A6bE+RdmlXicgPjF4i+ALAL7EU5Myy1fiP1lMDKd?=
 =?us-ascii?Q?o/OTuUBJgeyFxCTE+0Vn+1R2xPOksLM9WWxWYXcGFX1MZkJahY8BV0OfiA68?=
 =?us-ascii?Q?bn6vuwisqBevqpXWRmt1zyCvjmGoRzhln5Gs2qhBrFBN6YXW8VOKrYv+wZcD?=
 =?us-ascii?Q?SnSebKpx9KQ6YkVgYAKvtih+0qVy4mhmGZLqnHHNnpDKsvO59O26c0CHSrvY?=
 =?us-ascii?Q?h33Y0VzAFw5KQp1lE5lm1rw8MvI5HtUkXm3aBhHQq6zCnjXN3KwYazReEN5c?=
 =?us-ascii?Q?/w1nhxW7PYta5cWlw/htMizPbPzmKWf/SmLJIFtiP10TnljMmSquX0VosSUC?=
 =?us-ascii?Q?XgR2k/tsAtjokrWSTUnbkufTMvJk7JYx8g/AF9Xn2fsvHTc0fDzP2NSQ/4kL?=
 =?us-ascii?Q?k+AG+K4EomM0ZYZ2iiXWnRsr0nOqkfJM9PYwlsflMA8H9IuTx7v0wdTGUkgu?=
 =?us-ascii?Q?eVtY/f/nCwM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e4e7d5-7eb2-4b13-b52b-08da34a5bdf0
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 05:59:29.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ylintan <yonglin.tan@outlook.com>

    This patch add VendorID/DeviceID definitions for EM120 FCCL project.
    It has the same configration as Quectel EM160R-GL and EM120R-GL.

    Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Link: https://lore.kernel.org/all/YnzRcFy1zwhdSP5D@kroah.com/
    Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
    Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 8416267..0a6469c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
+	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
+		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-- 
2.7.4

