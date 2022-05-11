Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B2522E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbiEKIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbiEKIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:20:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2065.outbound.protection.outlook.com [40.107.113.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C948238862
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOYdx8b/815M6qhu6EmoA4NNYBcUbAQ0hrFgOYt+tvrf7NQY6u5zf483aH2rps5tzdBbI5hCSGV/nkA8DjfLm4bnraZ84bCgDi5v+DSG1vH8UD+Z2hDmssOtk8KbrVDtfL4/1nlh5Ysss2vlSFC5ca3P5/9Kn46ml3Rii9fPosSNMXoSi7Oi6+minF6MzB2FE1goXwEsmVbfFa2tse+wo/c5kHPm9RlagS1PaD38XqfMZb/Ql5JHUdPINPxF9w3yXKCC8Zhk1apz+5XJJb3jQ/keDafvDgM4QrgwCuNcLNDNtnsdP/z/56eC94lBtj10/IzDIbUus8hUbT6tAldo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru6cL67GLVxCH7xEifR7o9HW/lMYb0+/2d3xfsM6H9Q=;
 b=RWS6Mod6+CTs9nBlPCMzbnFIjkyk3A/oSgtvGMcHEftNn7RULzYsKVzkJq0EteaUU2n6QbvxCiR78peP/zNow/XTENGvNrPvAAbTrSc5ICpBZiYBdsPo33WfR/Lz6qC2q/1RL3wcP9iu+laKHWz6kmm/NxaAFTAQmrjqYOLQ4BrQXs/XIoDcDCVW61f4D5QwWweUJxnQ5l+g+JXfZKx4Sz8HoII66T/8cVY2j+mgsFgO+J3QHTkoOKgWYsTBatXJYXdhtkq8cO/12oW3Y6Ds4+P8cYl4ChTmSwERmOsA+ZoY0bSBO3iQ8CEB+BuSjVWCexgCwzA0as5Sb8zl5nkZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru6cL67GLVxCH7xEifR7o9HW/lMYb0+/2d3xfsM6H9Q=;
 b=IqSqQC2HIGCbFdKSWzpwTJg/QHQppUy7+6av3OQ4PBr3/KUQgGGDIls8sZedRVw98Ypi06xmD0fSCNFuMrCyyuZ6bxjgzPg6CyoCcHGwo0Kf6pPkueM3dJzTp3Bvnds83tSGJeHuF//QblK4KtYjq3LYpjAspGUE3OgJmFEBhmA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB3411.jpnprd01.prod.outlook.com (2603:1096:604:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 08:20:11 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:20:11 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] mm/memory-failure.c: simplify
 num_poisoned_pages_inc/dec
Thread-Topic: [PATCH v2 5/5] mm/memory-failure.c: simplify
 num_poisoned_pages_inc/dec
Thread-Index: AQHYY5Qf9nP9gjq3G0WeyT1fer6diK0ZWLWA
Date:   Wed, 11 May 2022 08:20:11 +0000
Message-ID: <20220511082011.GC211620@hori.linux.bs1.fc.nec.co.jp>
References: <20220509105641.491313-1-pizhenwei@bytedance.com>
 <20220509105641.491313-6-pizhenwei@bytedance.com>
In-Reply-To: <20220509105641.491313-6-pizhenwei@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 821d93fd-f379-44cd-2a89-08da33271185
x-ms-traffictypediagnostic: OSAPR01MB3411:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3411C72B9DB937ACB06DEA45E7C89@OSAPR01MB3411.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZ8STC2P/4iQ675N5gw0LO0V2byUsA4ERfvBOLk87zecQfEquZ1Kn/BIFiCs4jdv4ssa16a17vqzzEz7fSUXOHumVeH7RpVw6VqwPE2fxj3/e6joF6PQXJKtRMBN64lWSZ6I3kHllDCJcj8/1C5tn0MQhW5+4SIFr/uulKIg3atCKASrHtumrUgN6MW8GUQz0SWJu2ZCcPbaL3qIxq5HTZlEZ/MJ14X+F+M98Li0KcqODxQubaHHpubVbtg3DljdxBddTCI4r6v5gNIJoY5FUnBohISEmB/tykDUrYO2RcJPBIa65/nountPeYiyyCqHQPP/poamvm7F005vKOIVTV/G4Rx5YHWuN6obgITvoMM2Upu6U0mQWNl0s3Emzt6BIE0P4fTIKXc9HTOIo6anBR/OZ8kMCIfrma+FsCSn9Soa8kJlOTzTalNSBm6gzcl/rcLndrIu67cYwmDJX3gKK+Luzmsq08BglVyFpQnOPT0HafzEyA/uTcsmgyieGV20kJcWtiv6lTsj01BzEKbM8xDPIeFb9UkZE0j3hxuQalmwxXucE7AS7nRzwEWDdLgkNxhXpdm3G/E/kGVJjXk1guqVNob87rf750dnZueGqt60OqT3E2Wj5hYwoKXIvCKfWk5oBBlAYPw2zEN3wyAqlCtQNyGWnV6beviiOGdlYLVNShckNqv7o4OymQG9VVJ0UbNrIhLVb60UinLPndy/JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(54906003)(186003)(4744005)(33656002)(66476007)(1076003)(5660300002)(82960400001)(66946007)(38100700002)(76116006)(316002)(66556008)(6916009)(85182001)(122000001)(38070700005)(9686003)(64756008)(6512007)(26005)(71200400001)(66446008)(4326008)(8676002)(8936002)(6486002)(508600001)(55236004)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVNhWGlldGVaTitTV0NTc0xMV0ZMODBoYTV6bitpVWNqR1RmR0tEM0dLZVVa?=
 =?utf-8?B?UXIzZzF3cWJZcTNNTkk5dUJEYlRqZm9PTGJtMkdwcVVjeVA2dENqMXNkVzVF?=
 =?utf-8?B?NXdNYVFlV2o2TXQ4cDgzK0w3MTdLSEwrVXFONlllR25teS9KbmJEZ1R3UlE3?=
 =?utf-8?B?MGgrUm9NdU9NcVFqS3JvMktIakVLWmZQcEtBcjBvMHVhTUdCSUU4QVVZT3N1?=
 =?utf-8?B?aXAxaWFybWZOeUtwOWEvTy91dE5UR28vMU5RQkZtcVNSMTUyemVYaVJadWNv?=
 =?utf-8?B?dDhzRWluZ2R6S1djNHlVem9YRkx3aEU2WHZXaWhPZ2NrVkFtc3hCU1UrK3VK?=
 =?utf-8?B?d0hjRFVDbFVrVm82VnRlNlpBN3AwdkYzbXlqK1NyY1NxK3dDb3RLcU5wU2Y2?=
 =?utf-8?B?cDBpUEZKenJJL2I3Z3Z4NFJKTnBvYmozQUdxQ0h6Q3B0SG5NNWhQOGRFTzBo?=
 =?utf-8?B?ZVBwUjJnQm5DYm5BZTdwQmNmRzlscmdGUURkK2ZtVXRXSmVFeEFnRkNITVZO?=
 =?utf-8?B?M2pQWHlxRnQ5YXJFbUI3Vks4djRpT3MxandKNjFBWHROZ05yUkdRdWRPYnQ3?=
 =?utf-8?B?a0NiWWdmaFI4UGF5WVB3TXFNTlEyMlQwNWRwdm5sRlVZbnJqWE5LRGRZSE1r?=
 =?utf-8?B?bFZYYldiZllKWENvaUlWdUdJaDc3dlNBSEtyL3IwcHR4ZUhwVzBKeGVHZlRy?=
 =?utf-8?B?T2srNkljNCs4RVVWeTlrb25vUkRaUWhSblc3Y1FsT3RDbGpnUGJNUzhoQVBN?=
 =?utf-8?B?c2s3bEU0L3MvcGhsRzNlWGdEN1ErQkR0c2xwamZ0Q2tYQ2xTODNiWWt2b3hQ?=
 =?utf-8?B?UlZvNjBiZVJjeUNqcWM1Q1duQW91ZVJacVZvYmk1N1FMS05admdCOUxHY3Nx?=
 =?utf-8?B?Zkx2K2t5ZVlyWXdHcUtBT0hNd3lGRnNzZWZXWlNVaTVKU1hDRExpYytzZkJy?=
 =?utf-8?B?S2M0SGxNUFAvQk1LbVVoSjVrWXByQ051NzdXQ3VyRzNIM3BwWWExNDhzTXRr?=
 =?utf-8?B?VzhkaWRhVkU2YTRuQUI1cWNGcVcvT1pNb2xLVzRZL2trNmdMSklyaTRITDZK?=
 =?utf-8?B?L05YeFlhMVhJcFVQNXRvYmhVQ2dmSnlQZXFyTkJwNkpBeDUvUVJkVFZiTjAx?=
 =?utf-8?B?cGM3bVlyRzBta2FxR0VZd0FpVTlBdU1KdjdWY2pKanZwblgzUnp3K0o2Yld0?=
 =?utf-8?B?QkduTmUyaTBrY2wrbVFSdCtJVE5TWkJGU0lpb3czdmFnT2d6ZERWaDJPRjZJ?=
 =?utf-8?B?b240Q2tWUVJMV21NbVRRV1RpQnRjR3M5RC96UEFDdEpwS29NbVlNc3gwVGgv?=
 =?utf-8?B?SGRPdTVzVm82d21XMEF6MHBCZUZaSEY3a1o0Z0xodjRFdnltTHdFZzc5eDNn?=
 =?utf-8?B?SXFwdEM2MWE5dmJ2ODkwWnNnYkpoeThaUllJK3VMUzRBTS9uTEVRWnV3UkxY?=
 =?utf-8?B?TFBUWDBxS3p0U20zMGFvRTBFZlZyS0p3N2xLUzJrQUdJSU1IWXRmY05kZEo5?=
 =?utf-8?B?YVJ3M0MvdWZFTzlwTSt3UzBsdVFQeVlHSTY2dXFZYktSU1ZWYWtXQldYKzVl?=
 =?utf-8?B?dDROTDNYdlRwdEFlMlBVZk1DU3lyL21Cd3RvTVI0dE1OeGIwSGFOcFRuUDdW?=
 =?utf-8?B?WlZ3VDN2VEkwaSt6a0dLQjBoaVdCRmFqd0QxdlBJZzhoNnpXdXpLNHp5OGQ5?=
 =?utf-8?B?UE1KTm16THlsOWRiL3ozYlFHcXlSMVRmU2NwdTFXQjlkWk53K042TkNYeUow?=
 =?utf-8?B?Tyt3a0FsQzdjNFVMbm4wNURheXZVOURCdU02UzJLb3RoNE9JOTRxalRtVW5O?=
 =?utf-8?B?dExMMUlZdW53cTN5cW56Q0ZKTzZVVXJJejRaT0NpcFJFTmNIYXZTeU8yZ0Ro?=
 =?utf-8?B?OFB3bkRpWWlITTM0YjJteHVHeXBaWWdJVUlQQkJZWkRSQndiQTF5ell5dDFu?=
 =?utf-8?B?UFp0Mk1QL29Sbi84V2FlNW1BWTRpai9FYVRxektyckFFUW42OWk1MGdlaUdD?=
 =?utf-8?B?L3hwNVpOUmJTaS9xa1R4K3IxMXpMZXdpQ1JQaFhGcTB5dXl0dHhveGx6SU1q?=
 =?utf-8?B?UTJnODhvOXExS3g1c2xxVU5keVd0S3c3VDhoRVN6TnBxYjh0cERDUXJ5Y2xK?=
 =?utf-8?B?N3lJR3BEcmlaV2lMbGhRY2NRN2F2MmRVRy9DY0E2RjFBQXJ3bkY5WkptWXVu?=
 =?utf-8?B?emtvdXNBSkRPaWFnWVFCZm1Qd3F4N1VaNFVTYW5GcTRNZnBKcjRLdTk1YTU4?=
 =?utf-8?B?eEtqSmIrRmo0aXZTMEw5bVBJYk5sMHRKZnlLalVSV3JSa0paalJoNHdFYnNN?=
 =?utf-8?B?L3lrc2FwNjErUUJzdFBHSXpLL1hGZGFiUng4STYwVnRKYnNPTWtIVTVtS1dP?=
 =?utf-8?Q?LjDJLuzOYyyffMoY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6D622B98B80F4E9B1B71D298C56912@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821d93fd-f379-44cd-2a89-08da33271185
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 08:20:11.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IU22T5eQBQyhHYQi9TkeS3qp3rxBHaPrb6FTu/4XXNeDHZ9qZ3xNVIaCSwFhC+BVcAZcVORuCrq2HdujcvnhfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMDksIDIwMjIgYXQgMDY6NTY6NDFQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gT3JpZ2luYWxseSwgZG8gbnVtX3BvaXNvbmVkX3BhZ2VzX2luYygpIGluIG1lbW9yeSBm
YWlsdXJlIHJvdXRpbmUsDQo+IHVzZSBudW1fcG9pc29uZWRfcGFnZXNfZGVjKCkgdG8gcm9sbGJh
Y2sgdGhlIG51bWJlciBpZiBmaWx0ZXJlZC8NCj4gY2FuY2VsbGVkLg0KPiANCj4gU3VnZ2VzdGVk
IGJ5IE5hb3lhLCBkbyBudW1fcG9pc29uZWRfcGFnZXNfaW5jKCkgb25seSBpbg0KPiBhY3Rpb25f
cmVzdWx0KCksIHRoaXMgbWFrZSB0aGlzIGNsZWFyIGFuZCBzaW1wbGUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiB6aGVud2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT4NCg0KSSBmb3VuZCB0
aGF0IGFjdGlvbl9yZXN1bHQoTUZfTVNHX1VOS05PV04pIGluIHRyeV9tZW1vcnlfZmFpbHVyZV9o
dWdldGxiKCkNCmRvZXMgbm90IGZvbGxvdyB0aGUgcnVsZSwgc28gdGhhdCBjb3VsZCBicmVhayB0
aGUgY291bnRlci4NCkkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgaXNzdWUgaW4geW91ciBwYXRj
aCwgc28gSSdtIGZpbmUgd2l0aCB0aGlzIHBhdGNoLg0KDQpJJ2xsIHN1Ym1pdCBhIGZpeCBsYXRl
ciBmb3IgdGhpcywgd2hpY2ggd2lsbCBhZGQgaHVnZXRsYl9zZXRfcGFnZV9od3BvaXNvbigpDQpp
biB0aGUgcGF0aC4gIFRoYXQgd2lsbCBoYXZlIGEgYml0IG5vbi10cml2aWFsIGNoYW5nZSBiZWNh
dXNlIHdlIG5lZWQgZG8NCnRoaXMgaW4gaHVnZWx0Yl9sb2NrLg0KDQpBbnl3YXksIHRoYW5rIHlv
dSBmb3IgdGhpcyB3b3JrLg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3Jp
Z3VjaGlAbmVjLmNvbT4=
