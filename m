Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651824CCF5E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiCDH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiCDH5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:57:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F33170932
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:56:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mItJHAhNrSKDhVegM4NoAHxSiOtxsXt2E5wOVM5UCchpAFZkos8hb511+aZEM3gp01JutS+BNEmTJvjvGIJgjaflh5hGs40B9y4kvgHSWC/Rdj0R6A9fuzugR3NicZv8k9aV1Y1r/7N0diR7Gs8GY3Ht9v3ESS4Pr8M+CZdjUO1Qhjswus6eu3bTrNGI/TnngnXvbviogerhe3Ik691Zz6jRaD95KwFz/gYV6NWix+vQCpubWSy67tP5PmYLbsvbEIwhekrhtyflMrBaxAkfzSlayY1lobeB+eLOy3i39JXnrNYo3Z7NBlSV21fJmpTM2YGPRW8ddIfteP98HlBlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FmBTGaUtuRmpeyy9/vSo6W3EsyNN8ZIoSwl8n7atec=;
 b=hv+Cw6WkenXIs2RD/HwsB5LPzOIxtZTPw/ZNXyianYAQyqQPbeU8At9hPRRusU1bEkE0C4gNPAn8tuuDAlZMzyi5+HMDi4G5HTHNdxW6SEdzLYli4nnMlp4LIJ3bqhZm2SkzfsGaYt3SIAdexoUtCdLeDO56vj2x6wHPZH7cNfl/m62RXgyvd6oF0wzwb3nJsFCVVz4Q/DYXDJg3Pn41qhVwPyPJ9S92e8BBn8epJZAirLcsczLhIbpex8YgSFGYCEVO5nPjfHo25J2aR5GI0BFzZMA2wAFyqZYg9QQkB5FOx3jF3sXdGsQqqAbtwxPwuMmEG+oVqqIaf51V3ytnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FmBTGaUtuRmpeyy9/vSo6W3EsyNN8ZIoSwl8n7atec=;
 b=M2Cic+YGaZ6ehi85MRXsKLFCRU5qK5B9WbUxRl5okav9AafBR4hO+kovuth+7SRUKGfY3fLlufrbWHJpgM49KLSfn2mWsBdBUQGsO0GlAomBfzZ7ejqOFfBGiZ/TPIjxLUzBd+y5cbafRTwsW1EZugmi1+D1h+zWnjKzhN6SkPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by CY1PR03MB2315.namprd03.prod.outlook.com (2a01:111:e400:c616::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 07:56:14 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::71f3:df33:af9e:a8a6]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::71f3:df33:af9e:a8a6%4]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 07:56:14 +0000
Message-ID: <ce7213bd-28ac-6580-466e-875e755fe0ae@synaptics.com>
Date:   Fri, 4 Mar 2022 15:55:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH] MAINTAINERS: Update Jisheng's email address
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22fd7b21-9b6d-42c7-042f-08d9fdb4748e
X-MS-TrafficTypeDiagnostic: CY1PR03MB2315:EE_
X-Microsoft-Antispam-PRVS: <CY1PR03MB231577505861308F3EA8D883ED059@CY1PR03MB2315.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1e+F3cq7OgJ9HOp+yJtkATMNmSG1dF32PCFSvbsNWVInwPVG4MS0hUHN0plwvs4d7H4dYT41IeUOY/PXEPAtRvJVVKc2X6TP8mnL0Cjr5lZ4xHi41uZkN2BEU0qDJfIDnQRJ8nJyDltUAKt+YaYyJsNlsElQLrad+07BH+lSC79YVq0dV3TwVQy4pUzR7Uks87e+ZivJoXJgQcuE1q6f1lN4uOVtV/Fyjs1KAuBeyPSy/wuxIsrSW/nrUfCIjiKQZwO61xGzS2INBG/mDVev4cHRTf+tOSXqcP6shR/GpsZ8QVPogcW+dnU6b/bmdlMvuRL1nUCzqSwTdb4PA3FzQV5z+ngSv3fwNCJf/Tz74vRrSpDyrtbbFZ37L3oXnov4AQS0Iz/S+SuuIiH2iJBp2cfcyIGN/5Q0GR17PF3+I74lx+zxsoyB8nyrmbs01HzzWQYK+1/JJSlxq0XkakoXIxlfFbSvhUwh8F9zY2L+TMQCJJ8D8/WBOPx6jkJkpfG+MKxdCIaKSFom86DP+VTTPkDXoi1FHMXzHODRy3LxhfDsXj62rpqFDHqvrK+yr/IjgkB2zUApcqVmEGPwlIwp8SzIi0xrF6fF3CoNsRwNxGsBb2ezFcFTdYyy5cuU5ac1o6o5N9cuFcc+ud/vSrG5LrUsM/5MRZLvJXiZckV5Kji7OPBwc5QK7B59Nipb39g6XMl4F85P6SmFyRMGnuHmxsYUet4Ihs9GBNEEL83TcyFKU9iYCOiObg8v1dGsWULSTOQCmbxcgzr7g+sDNbcbnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(186003)(26005)(66476007)(8676002)(6486002)(66556008)(66946007)(4326008)(6506007)(31686004)(15650500001)(52116002)(6512007)(83380400001)(2616005)(6666004)(2906002)(86362001)(31696002)(38350700002)(38100700002)(6916009)(36756003)(508600001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3E5Yk9MQXVIZ3ZSNXI3MW9RQ01pODd6QkJsNFBYRWY2Zkhvemc5Y1VXd0ZB?=
 =?utf-8?B?OTI5UEdybGpMZUtielF3Y3NlN01oSFpHL1g0NjNNUFQ3ZHp3am82Ry9kc2RJ?=
 =?utf-8?B?T3YzZ2xnZVVub2JOMXkrdWFhL3E0SndrREZ5eWQwaEhLN3BVQkRIQTRCaHpH?=
 =?utf-8?B?VEVoSWdNbEZXS3F6Qk04bE4rbjAzZ2hRZHVmelRnVFdnNVJuOUg2dFBpclVY?=
 =?utf-8?B?elR4cFh6OUI2enNLQXhUZktpZVFiam1vOTRvUVppcVpMbldGdHhDOU1Fam44?=
 =?utf-8?B?V2ptTHJlcTRJdzNIZWZHd3dLRlJMQStwQVVvRDRjWjNpSGp0ZEQvMitQbnZ0?=
 =?utf-8?B?TTVVMHhLclIyL1dld3Y2bHhEdGVJNG9CVFBzdVZudjNsTEdjb214UFNkVnRo?=
 =?utf-8?B?WmNKZUhkbzlTYW8rVERNS3duSjJ6djZKcCs0YUk3QXNhWHZiZGNQUFJMSGdh?=
 =?utf-8?B?R2swbHd5Y1dzTUpmQjlFRkNtRk1NNTRpU3RBQXROa1hDbGVwTmpnVUlTaG0w?=
 =?utf-8?B?WGNocUxaRVhHYTR3S1g2eVp6Nmo0N1I5Ukw0YzRHYVIzSUVHUVFaSWtoVm1h?=
 =?utf-8?B?NkV6cU02aXFUUWxpbFVYb1VQaW8xWE1FS2IrcGM2bUtWU1gwc1FJdzJDMW0v?=
 =?utf-8?B?SDZET3FFL3dLNy9EKzM1WDlpT0VFVldVdmhCNUphQkFLc2JNWDdtcTdDdWh3?=
 =?utf-8?B?Wmxwdktvd3U5dHNXSVZqNTJZQVlCbjR2cCtTdnhoVGZpQlJ5YkRMaTNabHZi?=
 =?utf-8?B?MGZ0Qlk4cDFkaktoMmVZSi8vekJUeTV4SUdxZHg3ckN6TlBBSkRKVkt1UVlj?=
 =?utf-8?B?THdEcWhEei9kOXVYOG96NC9CWVluQUlzTFJ6T2F5WDYvemFkenU5Mm8zb0U1?=
 =?utf-8?B?MThBanBrdDJFNlVEdTEzcHNhTXpYYUdldXRKK3ZjQStyWEJMQUt3R3psNzhy?=
 =?utf-8?B?amFxdGJLRDdsZWZZcEJwYmwxekJOaXdkMkJKcGZUZ3NvWUhQS0VqYU95VDdq?=
 =?utf-8?B?TlcrQ2NYME9IdlAza1lOcXhGU0s2a2w2NUthdzlQeDhjbW44QUJmQ2F0NHZq?=
 =?utf-8?B?eG5kbXk0SUdOVURXa2p6WDRrVkhNNzl0RUdoQ3N4WUkrbm9WcFp1d3dkQ0cw?=
 =?utf-8?B?N2xTWVRJMW15V09VY25sd1FJU0pzQ2RTSGE5Y0NjMnBXSVh5RWVad2FBTVAx?=
 =?utf-8?B?V1hJbGcxQXI0ZlRDZUNPUXdxL00ySDlnMDBJdy9PYkxqankrekRpYnZ6NkxL?=
 =?utf-8?B?VEQwMTk4T3F5Vjc4Y3ExcHJMOGpaNEdUWmVOSEN3S3o2czFXUE9sUUZjSWFn?=
 =?utf-8?B?bzVoWXBJY3gzT0tzYmZHV1JDRXpRWnVoUHNvN29yYlA5Z1gyNStYWFFucmlR?=
 =?utf-8?B?azQxWlNGRlBTSnRWZEoyVmpCYWVKcGJsUXI1WHg5RzBkZUs0Y01lbWNvRm5O?=
 =?utf-8?B?ZU94LzhTRjJmRFhmZHNEbHBNeUtJUHVLczFoNDlwWjhHSTA1SXBtYTFtcnNm?=
 =?utf-8?B?WEp0WERNc2oreFVDUFRmczEvaVMyVFJZWXJrbDJJTmYvM010S0FOOFhYMEw2?=
 =?utf-8?B?VFAyRnRpYnNjTEVJeE9tcTZ5WThrSlEwY0tNdGw2S2g2eGpUWW41Zy9pVlpx?=
 =?utf-8?B?OVRpQVlyNFJyVDBlbXpOck9pbVNSQmNETWJpK2cyRS9mOE1WVU40cTkxOTN3?=
 =?utf-8?B?L3pqbEovbWtkWkNaWUt2ZHova1EzMUN6TXZzK3B1QXNNbDBJL25WWWh0NGNt?=
 =?utf-8?B?K3hoTkh1SVM3YmE0ZHppcmpRVmRYVlF6dWlhYjNYV25LRTZUN0JPY0owTk13?=
 =?utf-8?B?UDZuMlk2a2F1ZW5scTlSbDZheE9JdFVmVmZ1NEFXUnBQMWFESkhLSFRjbkJs?=
 =?utf-8?B?MXlmYU9tV2xrVllkcU5tTkRLNXFPWkhDcFRHWHJZZkRtdXRNNnZHeUxRRzJ1?=
 =?utf-8?B?d2VYZGZIaS8rN1RIa1dMeUJuYnl3RTFhK0kzL0dRNmJXZ2FqQmJGbUJUK01m?=
 =?utf-8?B?MVJ5bWYrN0RESVByeGFHVWxzTWVvOXd4alFOSGhjOElEdFB1dWhLMDhTYURk?=
 =?utf-8?B?cll0SmhkWldiV1Z4dTU4Zk8vc2d1NVh5YnhhWGdVTW84aTI5YVZZNk05Y3N2?=
 =?utf-8?B?VUFTalBLcUpEelRmaEdLY1BGSk9YY1E4NmlmaE5wRGhjb01zcTM3b2FCbkho?=
 =?utf-8?Q?Ibrf2pKXgGCYWy8q1fWdjrs=3D?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fd7b21-9b6d-42c7-042f-08d9fdb4748e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 07:56:14.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mc0b7Ymj/wwSO2JrGF3Y9qbgzNLwY7BeRmeKTJCvQ4NINhL2MqKTar3Hwm+rPP11xRrnJIe+2bhZFasbsZA33w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2315
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm leaving synaptics. Update my email address to my korg mail
address and add entries to .mailmap as well to map my work
addresses to korg mail address.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 10ee1103c823..4e9dc453b893 100644
--- a/.mailmap
+++ b/.mailmap
@@ -187,6 +187,8 @@ Jiri Slaby <jirislaby@kernel.org> <jslaby@novell.com>
 Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.com>
 Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.cz>
 Jiri Slaby <jirislaby@kernel.org> <xslaby@fi.muni.cz>
+Jisheng Zhang <jszhang@kernel.org> <jszhang@marvell.com>
+Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index d2b39f444abf..bfaa3aa685cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2739,7 +2739,7 @@ N:	stm32
 N:	stm
 
 ARM/Synaptics SoC support
-M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
+M:	Jisheng Zhang <jszhang@kernel.org>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.34.1

