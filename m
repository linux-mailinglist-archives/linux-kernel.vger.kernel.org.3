Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713F4EAB08
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiC2KJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiC2KJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:09:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296A1717B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOan2msVV3FKASCCKALe143CMfkF5PXMz95jYWrtcXRXI1RE3lwzdpDWwTDZhpMc6Zq1zOQP2tdpMtHsu3/C9fU/5u/0jnsTYVgmxEz6erVAKcDlJDU79aDi31IvKrCt7tHdl0H38uB1lBrr079mWTg8udIjo7yf1wh3h9XGnt0F/9X+4M8oCsXUdzKGuS/f2Ygfg7a6JTPFi+tz/VjUAO/r2P5XIX8Kye17Mds80ZE2h+xHa2O3aYfgBgW2TX8kzQyCkqKLJ9p+dhtL8UsgM4aZ6Ag+7bWnpxja6yH72D9lgeLJcHxelYvTRwO5Fa0X/EP3xZeSmx7mVTx2ujbfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZxaNf7M0IMAPr0ZBRtSi8vX7CC4/bJi2nNhuAiY+x0=;
 b=heBxoPCYLEkNvaYjHcoMdWe38aLaCgivI24BuUILkK6LP7h/ZLGKdbtOuF4/OBL4f5JQkx87hHS89t19Qiilk9P+/Kf7gdK6GQeC7iirWanetK54LjwmVPLACpkhQwJE8SXHUtjlL0xEKFWpyLTs+UqZrenBEoRQTX6xP7uJ9FlR8sawTPnqcJNFMfxKI0rDCk0YXs9iH10G0xf10EiGEzk9svqueNH0T8JB6/aTJFHlkwTusZmeXUVr1sudSdlzJ4F+tvtPU2YO5V3cSMz4C++ziM8C6ZDl1tYaqTWvE8d1kD4PBr4Fkz8tkxHuGoVFE3xIcWicyEHmS73s7Woq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZxaNf7M0IMAPr0ZBRtSi8vX7CC4/bJi2nNhuAiY+x0=;
 b=DfPmz8mFcLsuO+FW5AIDHrSnF8fAQiDWAzzjPxROytL3yZmbJdoxEVGQbcVLOR+U+qWZX3WWcd7tiIVv+P/uGVa1C/mdQL/iwh67bwpRe9MS1EZcQeAzJQVJRA5OuskbOWCyUr8cKvRLmg2NwNHXrAOy9SMVp7XE3S/qTCUs0GA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 10:07:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 10:07:23 +0000
From:   "Zhang, Hawking" <Hawking.Zhang@amd.com>
To:     kernel test robot <lkp@intel.com>,
        "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix semicolon.cocci warnings
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix semicolon.cocci warnings
Thread-Index: AQHYQ1SsXnXOu4CvgE+ETTv20vH4e6zWItQA
Date:   Tue, 29 Mar 2022 10:07:23 +0000
Message-ID: <BN9PR12MB5257DD322174D1C7E19F3EDDFC1E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <202203291820.47RoPjxh-lkp@intel.com>
 <20220329100533.GA65173@a6f38b584785>
In-Reply-To: <20220329100533.GA65173@a6f38b584785>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8512a9b7-7981-4f9c-bb35-b1dec6e42ae6;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-29T10:07:06Z;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36bfb77d-c5b5-4b7e-52db-08da116beb50
x-ms-traffictypediagnostic: DM8PR12MB5495:EE_
x-microsoft-antispam-prvs: <DM8PR12MB5495E43E1209EE5474E31581FC1E9@DM8PR12MB5495.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W95yUI3tiRCtzLLmZ7n6KxwfdFu3F+rSQQfOZzNjTqnGHeLF+YFgqH8qVFErQNBFf5kCBIdUJZmg9a2yyszhNyDWof4hQgc/ArVnBx7zp+uvD80+npOsg5FBuYDFxk1it97EtccbE3lDm1EqlG4FRfdCjE4tN3AEwuhpcWK7lABxNHXz6N3g01N6kPCLUof4J92oH9f4wDkRUHpk32856y/MWp5MxodO3fNzq+L9e7IrqSw703S9MrfYAybhFxwSPlVHcDZHSbARgSTjqz281dpD1p71dnmvMF3xfChgqImrC7FbZONuNmDW8olr2JrGq8ayRHtf3vSWg6Xgbpc99ZRZQCFwSrmS0ep49Ecby9SSBGgbzO8BTYKuI1JOT+ku/AicYq550kpjU94kChK4wYZoJZ5bf/DUXnAXCCrX0RNsJ3PwpmvqHj2vZ7qYJATMRFBxbpQv+WjPfNhG2cSMHztiPyRQc/FNHDwsmJFJDLqaCp2BDsFkueNdh57MrGD01JUVtAGWoQUgqobtV18gdv0EL2rEFgvgOy72Su+oZjVh0hFS7cPIgefGNgBXPd7TjMlybHwHopWgGo8QAVfdsFvmZaBIYx5fn47ROoPiCjJXz7tHSQt+MSWtgW49O/tG4hUZtQDSV+7/vYaumd/i4e3z6u6bww7FGbc2J3FtXjNRQJZdBO/9/JzahPGJeMuJ84As8RJSI/iS69tJkVHc/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5257.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38070700005)(110136005)(6636002)(316002)(122000001)(5660300002)(966005)(54906003)(33656002)(38100700002)(66946007)(76116006)(66446008)(66556008)(8936002)(2906002)(8676002)(52536014)(9686003)(508600001)(66476007)(83380400001)(64756008)(71200400001)(6506007)(7696005)(4326008)(53546011)(55016003)(26005)(186003)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6C3z6eEvoIrgUsmUWxjCwZVHyCS4sKtKB1Sq0Trk+MinQhYcQIi13VmgWkTk?=
 =?us-ascii?Q?JaU9DTHSCAvlgRH2X6SGrcph8HlgvX0ciwA+yNcGd6aK3HJl64drmoq/32ag?=
 =?us-ascii?Q?31muRBT3LGyJ6gRPV1uAA6KRhRMStpi1DPTlgPGiGLOKZ3mXOY1ll6ArG5yh?=
 =?us-ascii?Q?f3jjXE4PcgijeBiKWGcc81dK6C0rrkceo5Qx8HGnWWe7ykk9sH1/PCCc31Y7?=
 =?us-ascii?Q?dRF/36lbDurx3Mva59fkH8IGhmFnvjv8DzphK5I/R4kletk2FyUQths1wPcV?=
 =?us-ascii?Q?/fA2WFWkMImG26RFEYhN1ikDPmGXPpZAIWs8FuKtK7YAYRWQecAAhMZHFwCQ?=
 =?us-ascii?Q?7M5diF6PgFjnsUG8qtXF+8YrBmQjTnCa8TyDzs+DmcDo2dp3gvmY8dC1iQdS?=
 =?us-ascii?Q?QrVBixtHUmo5iJeQq8/zcvXtff/EPmzVmGWGVXXv1x1N4LVufHHth3A1iqYs?=
 =?us-ascii?Q?LAXOhyk1DuevD0iYiMq5VmhJ/VceXEE2g/bQr01KTRsGgp0KDbpbvhwKNRMC?=
 =?us-ascii?Q?QkpP/KyWDyM6Q65btqludMN+w966sWGzXMRlAanUYoOIHQNkCl7LYcaqlXrC?=
 =?us-ascii?Q?oN1g2+dp6//di7YYQ/CGHxvTOSs5CtOg0twD+riwGjnJTVWtuA4pWQonYCeP?=
 =?us-ascii?Q?wsTIVmwSR4jxh1V8iMF7H/OfTjYiu7FeW6XLvYQ1qFLkXOy+jMeFkMA1sIo0?=
 =?us-ascii?Q?Xqe6tp76a9far0uYdldoCaMr0SAc6p+iWfVhgjxzAmT/h01T9rQkVKkNahOF?=
 =?us-ascii?Q?OHub4Bx3Muma+tdKoKNkj4J5pZ9acI0jNVvOLqhrjoWI3fhyfag3ogbg/7Wr?=
 =?us-ascii?Q?Ci1HzHC9E/HdWkgjrvFPVQlf2S+3zzUYlPi1F4I9zsZ04/hV/9t95qk4hABG?=
 =?us-ascii?Q?Xkc+xSJUVERkPFRVYshPoO8TK9fqpueT20DdlUP89Z9Uh/LHgvCGLnDhYxPQ?=
 =?us-ascii?Q?HsQ5Mos/r3OKTzd3b+mOCMd9skYW3fX+G4B6joTPdTdKl8BQMtENIMT1vCl4?=
 =?us-ascii?Q?4DXMT8iyvw+LuFd1c8KafMb1G9bakz/Nu1WGlRotxzbvcf/PeVH+JRUG8ycz?=
 =?us-ascii?Q?U5zjZyZ6t4wTS1wo/I/E5+ZlXKU0FUc9EyT26Y6B4xXxUaH4Tw5NfSQQgfh3?=
 =?us-ascii?Q?xwX8AFt9Sx5rx4ZqAEXqtUv+gDuF21/VWJ81LJ0elF2s2+8DZVHo0lj0+1wb?=
 =?us-ascii?Q?sqzzTUxOE/YaCyWsjOABxYMlU9X5NlZdFpaNuxPQohPnk39JBiwKuvl3ryXn?=
 =?us-ascii?Q?YCqWhViTqDkag3oSNlHJC7F4htosUsfnwowBqH33y5tpC5yH9hoOBgVrlgD2?=
 =?us-ascii?Q?lXAjrPg0ElOmRfD7vWfkU5YspnVjJIRHbDJ/N4SmNWpgQF/6W6C/gr6CFyBs?=
 =?us-ascii?Q?0MU+zzjNR3zEEWPuD01AH+KQuJopXPU5IvvieYwEd2Vw5M/Kp1IS/41L8ZIn?=
 =?us-ascii?Q?CShhRzrqaA+uDFPQHlKo1DSHHLJO+1SjLpUIebu6eXCXodmSq1kqHZuaAh/8?=
 =?us-ascii?Q?S/bJOc4qNq4w20jNKiixhVqEhAw3XCA1NxePP+bzK/wYBw0AV3NNLfbOmguk?=
 =?us-ascii?Q?tfRtVheR9jLu4/qsJAGB4qRvfN5DMJF5IKklpiOxI7TtE3yuFTMFPkNCGnrz?=
 =?us-ascii?Q?ZFAtTKOA1LhDKvLJv30hB+RFBCeJzzjLT2XHFATG0mRm5lpBA+fPEnQ6Luft?=
 =?us-ascii?Q?vxlqNpy2lQX+TK5CttJpVvqwmEtLmc3/BeOnd5sN0QGZNLVLMNoodvdRxK9A?=
 =?us-ascii?Q?DP3kQwgKDw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bfb77d-c5b5-4b7e-52db-08da116beb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 10:07:23.2335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bv/Bl0KU2e4Csns93KTRvC322KhvN1Zmbx4aNjzL+GS77G0lecNp6kBBTofxSZ1GXpQ122oQFitbXSln2rM7bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: kernel test robot <lkp@intel.com>
Sent: Tuesday, March 29, 2022 18:06
To: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Zhang, Hawking <=
Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix semicolon.cocci warnings

From: kernel test robot <lkp@intel.com>

drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:1951:2-3: Unneeded semicolon


 Remove unneeded semicolon.

Generated by: scripts/coccinelle/misc/semicolon.cocci

Fixes: dcf23795ffe2 ("drm/amdgpu/vcn: Add VCN ras error query support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---

tree:   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D04%7C01%7CHawking.Zh=
ang%40amd.com%7C6b53d08bb6724b9d007d08da116bcd64%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637841451950060344%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DvZ=
9J8CUPC1w%2BQfqE7gsUpuYVKEAtLKDhLScDQP88Wtw%3D&amp;reserved=3D0 amd-staging=
-drm-next
head:   fc0c15fb4751de221eeb82b7a83fe3935f56b931
commit: dcf23795ffe2e1235a22c24260157086d2da38aa [5/6] drm/amdgpu/vcn: Add =
VCN ras error query support
:::::: branch date: 25 hours ago
:::::: commit date: 25 hours ago

 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1948,7 +1948,7 @@ static uint32_t vcn_v2_6_query_poison_by
                break;
        default:
                break;
-       };
+       }

        if (poison_stat)
                dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\=
n",
