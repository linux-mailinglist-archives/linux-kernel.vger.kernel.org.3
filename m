Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270BE50A376
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389895AbiDUO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389680AbiDUO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:59:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE421A3A7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaS4+tih4cftpzDJjV9L/JNkXyXdP0zVSwAe1wY2nH7mjw48/dPKYi1foWCUP/d16KFFDwDtwurGF7DjaAduZhvQ4bEjSDOuFtgma4MUx2S8wLuyXT5BdDfiWXnDijYQ5fTxtfiTGh2a7yDshOVZgxQdLa6ZrXbBSlYkh6Jpcz9VIyzP+wYzqde4rftbusKCb0OhRTiKCAnlkQaf8q0uST9xk1QB2PX6WPYf/oIuPRyWXpMg56js+hYUG0khkLiHHimn1P3cxnjrHYDwFOUFLmCZJj57mglI+d8rNCSBIrQ84zfkT9WWZKBL9F/+NAnf8ufeuw86iQs6fPlFXCUUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTver1OMwNic7oQarb1JmgW+JnkIHwOHJWhVtCcznDs=;
 b=agycT+gb7tLPK5HIK5wbjrS9vGKK2tpazrVGQDVn3twWqgUrUFfJo6WphnxZUlmoxoSHKtvW4i+98w/eQMxKvX92AdV870P0sS75wrSR/Np0CzllmuYzGtywdyJmHJwiTUqPCVIVI+2Kb7m3GeQyGUEqlMa2UbMHo64rMIaolpc4htDrC8XDk5RAaqOgsIOq4rpMpAYKhUus8FQkBoSjOUD3Jl7wW1E4caNkxjarM4wx1PjsfQq5DH/oxF1iTujWDMn2YlbJ7LXu2W7pNpypidKSdfVwUIwFwIex1lRW+1pYOHnz6Z2vXu6ihTT8FT5NUbnqW96CKWkFyUkyOExaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTver1OMwNic7oQarb1JmgW+JnkIHwOHJWhVtCcznDs=;
 b=djCH9DLhVWxQPqL/d4NbCmZWTdO5rTdLXVKrUUlL9r8VmoosvNtxlHRDO4RwUY83GFqgmVj7m1l6/xGLiNyT7Lr/QXmigGQSUTVeoivGa0b2N5tXbPuEyMMb6IsU9Wz9mO7fABGumALlralqxlmZB96mcygMYFhi1OjIzxQVaL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4308.apcprd06.prod.outlook.com (2603:1096:820:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 14:56:17 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:56:17 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH 0/2] Add complex scheduler level for arm64
Date:   Thu, 21 Apr 2022 07:55:56 -0700
Message-Id: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e1283b7-6f8c-4fc4-3b1d-08da23a716ae
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4308:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4308D0477B8DF05655417709BDF49@KL1PR0601MB4308.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRnN8rT9SfhFaJVQm0a1YEDTla1LJ6qzTZdh4Wa89fIhkpN2Bq2qntqWkYGTOoCycrWO9Axj7/EdGIJ4fdPvdyvrmaEpXM8KRWEep/FYMoa/u8fWsP+KBTizh+EjA6KZkZiUcZH+n+3L6YGz7IWmAPQ+6RhyoXuWxoTtlzb/nxfFLbteGptluc4GFQ0nXYoT8WPRMeZePsCpQ9+tllY2IwgG/XkWMClsPMFFQBp5ByWxj0mpM/II1Zy4HULxDD0gTqoitYwB88hirOm7QS62FNixTBnyiib3Zdh08Khz7DxpE5/rTMC3eNBsdFfOonsfam3m7W+taTV6zNLV6OV2+rtcIPpNkroKnFT+jMvKXj44lNsb2bgotXuJoOfCPYNvsRIkAKvgaiOunoYHPto1lQRL+9evVbcTzNv6LOku+xAUwOvwMv4MPXJuYYStgIxLShvbQVx28lMh5n3yL5EGXlRHsUSQfVRiYrHRPoUgjjr8creAxYihfcfE8bNTSaQcsz9udjw5tvVygZWtR3ILFNO2fgoiPaLf2PBNt6NM1JmQdCvBYeajPdwHd+/p2ATFgTaq5uAUkOIjhQPJ3qnTwhNkWlhz3N31LuSHn+cZlxRwmYkLw2VCvnUZO5vsYiEUC8dhoO2CsItKFA3kBhNhzKWeoq+UdrUwjUxtydq2ULspg7RoFrV14J/RW+j+oSeJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(8936002)(508600001)(26005)(86362001)(316002)(110136005)(52116002)(107886003)(4326008)(186003)(66556008)(36756003)(4744005)(83380400001)(6506007)(66946007)(6512007)(2906002)(5660300002)(66476007)(2616005)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2pxeHgrQ2k3OCtPSWJLaTgzNGVhdmlsc3o4d0dTZnpRcHVWQm1ETW0wU2RF?=
 =?utf-8?B?bE83TE8zMDNZUk9zR2MwVnRZNnVDWkhiUW1zdE43Z2hLOWd6dXUvUUljTzFV?=
 =?utf-8?B?RVhobWhXa1JNaGtqQkkzWE5rWWwvZ1N4d1VsY3ZoeHNKWVlydlEvYmdqelRq?=
 =?utf-8?B?NDNWVitBdStlRWxLWTV1YjVUQkZhQ3Brc2M1dVVJajZsN0FxNmJscTc1L0Rj?=
 =?utf-8?B?TlFSTnhJbGpmTlZYaDI5SitGanRtdzVCMUpoZ3YyLzJQd2FhR3hUY2oycytL?=
 =?utf-8?B?UlZPQ1Bid3RJZkJiYmRkYnh1WEtSemdzc1FYN1h3QjFXYysrNm1HSndtSlhk?=
 =?utf-8?B?VDdNOVFxbjhJZVNOaFAxeFRYRU9XaDRHT0Q0TndUN3MycGxqamlUQ3h3Sm53?=
 =?utf-8?B?WGZQMGN2dmdrZXdodGFsdm5qdjc5cHdINm9xbkJSckRpTTBQQjdMNHhwQ0dh?=
 =?utf-8?B?SnBBMFdvWFFYcEVTMUEya3QrS0lnWkJzUzVNNlBLdkkrUDVaN2djQWlsdUFZ?=
 =?utf-8?B?czNJL1JPcW1jbExFUmdVMWUxL2hpSXZtL0V0V1NwNEJIRncvcU5FcC9LQWE1?=
 =?utf-8?B?V1UxU092ZUhQd0M4NlFOV1pOcDRma3ptTjRBMGdhU0dFcm52blM5WVdwL0VS?=
 =?utf-8?B?QVRsWEFScjUyVGZpdTZpUFlGR2d1WVM4Z2RScFhVajBtZldoMHY4SktXV09l?=
 =?utf-8?B?TXBzUm15dnpJeDVaT3RObGZ1R2ZQQVErOFdXbU11dlNvSzUvQy8rUitPVFk3?=
 =?utf-8?B?bEd2YjQ0MU9FMUE1L2ZjRzhkaUtpU2FzSCt1NkFLTGszM2JuVm1ieE1aQnRT?=
 =?utf-8?B?Vjk1bWFFU2Y3WHR3WUlyM1ZuczBkcU0vNEVickl5VDR3b2lqNHExT1pHSjZJ?=
 =?utf-8?B?d2p1WjBoWlp2Zlptdnd0eTE3WjJlQTZZTmhTcTNJNHc1SURlWC9uWVRLMWd0?=
 =?utf-8?B?QUtJVmZtajFycTIzWnVxWHh5UHRObk1GT1o3WjY4b1JxNzh6V0h2ZXlsdndV?=
 =?utf-8?B?bWdGeHNCUVNTYmJLREVrc3BxNjl0Mnptd1lnUnE3M1dEYVVUbkJQYkJVWEtr?=
 =?utf-8?B?MDh3N1p3d3c2UnU5dlZjZUVKRVgrWWNseTIyaVNlUk5STVFVV0thcVRJTkRm?=
 =?utf-8?B?SjhCRkYvcSswQzlTc0ZzRlZZWEk0RGZWSHhQUFRRejExbytGM284cTlqRGZU?=
 =?utf-8?B?M1ltbzVBbjlFbkI1emVrVTJSTmppOExxQjJqQk1IandTV3BnaUE4K2ZRTkQ2?=
 =?utf-8?B?dVZqYmpoMjUyYm9pSnJBQ3BnclFEU2xhR3lZTFNWSTN6aDEzSUkzRHBUMUV2?=
 =?utf-8?B?M0NtWFlPcTlVUXE5cjNSWTAvUmVkMFR6NmtiUEdOaUM4TXF4WWRKTGpxRXBp?=
 =?utf-8?B?VlZwYW1IdkVvdGxVblFlZXBaeHJaUUN0SEZKWEJqajYyTW5EajU4ZTF5NUdS?=
 =?utf-8?B?SXdXSndPcmthMVlUNWUzdnNJYWpuRzVkdzMzdVJISGdTQXRHZ0J5cllxSEli?=
 =?utf-8?B?UWRLVG5Oc1ZXcTBVbDNRK0pJRlZsVEJzOVdoaE50MUFNR1BaOTJQYzFITXh1?=
 =?utf-8?B?OWs3Wm1EZEpWNVhMNTRsUUZ5RmtQanBuSGxVTWV0Z0tIeFhjSWZzMExaNFpI?=
 =?utf-8?B?ZExyMnUrc3VUcEUvWnhBKzE0OUlFS0xIS2xYT0JoWFgrTEVwQ1ZBRlhJcC9u?=
 =?utf-8?B?aHZZTERRYUsvRko5cnFUSWZUUmQza2RWa2oyY3Y0azc5WEx5TUtHVUc5S2dP?=
 =?utf-8?B?KytWOHlzRGx6bGVYT2RQMG55cml5Z0VDZEhtTGQyemlUQTVzWVB0NmhacnBt?=
 =?utf-8?B?Z1FNSERRbkRTaDFOK0plLytxdHVvaWhVc2tvOCthV01Sc25KZWVvSDdIdFdv?=
 =?utf-8?B?T2xnWkUwcGp4NnVVeTZYVDZ1LzdzQzBFeUJKS2JYWlVFVDg0K3IwZ2lWZWdk?=
 =?utf-8?B?VlhacHJTbzJRUFZCZko0VDBEbE5OL1lLUWtXUXNMQjdtVHZORnV0eUlWNTYw?=
 =?utf-8?B?L3ZMN0Jsd0t1bWx5WG5waXd3bW5reGNWNVFJazJBLzJRNGJ5SkQ5NGk3amFq?=
 =?utf-8?B?VmNrUitLcHRIa2lhK2dQZVFXVk10UGNPNkQ0d005cnBERnR6ajIzaDg1R1Vt?=
 =?utf-8?B?WGNJakcwUDhXUVRKNGtkTnlGNTZtK1BPV0h1RFMzcUhDMVpPYUFZMmRrWnlj?=
 =?utf-8?B?Q1hCcStwWkxUUWR1enZpd1h0dDJPVk1odHVFQndoYzJlODVLL2MxdlhhL202?=
 =?utf-8?B?dldpUE9CcGhPSkRjN2ViaFhZQitGNTlmZzFjUFhQQnpiZXlCcU5ZN2RYVC9p?=
 =?utf-8?B?WG5INm9ISERybnBaZ3d2VG43dmFnZ09JTjBOR2lob21JS3JoS2xEUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1283b7-6f8c-4fc4-3b1d-08da23a716ae
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:56:17.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V66yCmXDeWzgSO4uc/Vd+AJHmRRUgvG1hjniqSh6AhizIppMN1sGOKJGKvTB1p14bv0lPVqxyOHLuX1qO1wBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4308
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

The DSU-110 DynamIQ™ cluster supports blocks that are called complexes
which contain up to two cores of the same type and some shared logic.
Sharing some logic between the cores can make a complex area efficient.

This patch adds complex level for complexs by parsing cache topology
form DT. It will directly benefit a lot of workload which loves more
resources such as memory bandwidth, caches.

Note this patch only handle the DT case.

wangqing (2):
  arch_topology: support for describing cache topology from DT
  arm64: Add complex scheduler level for arm64

 arch/arm64/Kconfig            | 13 ++++++++++
 arch/arm64/kernel/smp.c       | 48 ++++++++++++++++++++++++++++++++++-
 drivers/base/arch_topology.c  | 47 +++++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h |  3 +++
 4 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.7.4

