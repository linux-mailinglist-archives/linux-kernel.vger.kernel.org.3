Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB00253F56E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiFGFB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiFGFB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:01:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A1BCEAE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 22:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654578117; x=1686114117;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ATxPbSzvncC2UUiv4spLRj4S83O+oAgpUwBxbP2I1Og=;
  b=kUpU/xVf1H12Hi10pZ24ugbYhVtnxcYMc9nOMw9ewtyEf8Vkjq65eDkP
   CoPQBxmiKKq5mjy9O9hsRTL90vKFUboRxAcmRnYjLn1hkglCXrBt9ZubZ
   RkUTsManVETtKVxj52tiFTmwjfwcLW8qfC7aiJWzcwnhCW6sBiRGN8tN1
   VyylvS+cXCrWVjuCeYpZ/YYj0HRdr8TaZoWuxVny3jsshlzeaKnDnCYKs
   cvhDGdw7JNxKeCblnCQg3X6V1Drr1GM9NhSxZdXTZU8J2L5UqgewGERDl
   9BXA/ajEGaV6t4TZU/OLSXpIs2Wqp0zQfaalfCRiF5YJ1aB6FV6Xst+E0
   A==;
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="167021797"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 22:01:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 22:01:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 6 Jun 2022 22:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYyk+xpK6lXEROTYWshPBfh+lkcxE8zTbMc8HaEJr6GXYdwppAuD6E9LeDgL8yMj4Tja0i0VtVGGXevCysKQnOvGQ94JwhoBgNlX83jNPtR66+2mg0UvXf/IeTSmi9Hf5IYmhs5BHRp1CXKJeNqd0JGpbw4JHwpY4YNh10wh7CyIiY3OMbN93SVJp1d8ELxNKTWOpAZOPPVC89oTFKf3SGff3O0bH4A1cyfIRSZy2cMtsFJxKAGoIWBNBTWdA0fyjTj2u0nBowYgV/ettGKRLBxrv9/JICgQkcKXddipFCSV1lhWHKa9raDd8ikjLLiToQQPTvLzfjkBfyfM0i+7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATxPbSzvncC2UUiv4spLRj4S83O+oAgpUwBxbP2I1Og=;
 b=nCyQleG1BfpBXILfK9bLLTcFkE9I3Vm47yveFWuXJHJ0gt57TgBohuo+aBi+ToNtvPBwruncbCJtmReNbSd3ToFUxTWi5z+jrXU2vzBpM3I0Am6REHj00myRdkItIBYLZDJ4oCE8DVxSyfH4wZK0SsWUv9iD+yGHJvnIhmM7TtzVE4JWRi5aUyh0DzjdDkMI85zEI/m1NmP68fh1wYYdKzP83lksl8S+soJK1xLwFF3bhok+FacsXwwgEy7ou5TBUGFP9naQc0vvdRLleMi60QqxT+BIisid8sg8rMurKGeZ69UsxGZvd4/KwAS7Do/OdlX6noPPOewzfNJZ0bRSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATxPbSzvncC2UUiv4spLRj4S83O+oAgpUwBxbP2I1Og=;
 b=vENO1MuPkk/JmOwehOCFZBczhN6qGzh2w4MCtWR7nlRqs8a5Eoy1BkEjenGD7ExtA3vLWzY2+sfspnmkrRoQ4js744kBX7l7lnnz2v1nt6LMATCGzsoLngRTmWCFkJOowTRxUhtScRlPiHkDq1qh7GS5qD49hjjzzwPOB5fT32I=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB5198.namprd11.prod.outlook.com (2603:10b6:a03:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 05:01:44 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99%10]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 05:01:44 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linmq006@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Mihai.Sain@microchip.com>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: soc: atmel: Fix refcount leak in
 atmel_soc_device_init
Thread-Topic: [PATCH v2] drivers: soc: atmel: Fix refcount leak in
 atmel_soc_device_init
Thread-Index: AQHYeiuuRm0xxdhdmUmRFTTy2dI7Yw==
Date:   Tue, 7 Jun 2022 05:01:44 +0000
Message-ID: <80d1d3f1-e168-1e6e-4020-acd3e4bdef1b@microchip.com>
References: <20220607030058.53695-1-linmq006@gmail.com>
In-Reply-To: <20220607030058.53695-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34c76e66-1af0-4eb7-b129-08da4842d13a
x-ms-traffictypediagnostic: SJ0PR11MB5198:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB51980194CC76E40308CBC0DE87A59@SJ0PR11MB5198.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GoeKd6bCE4G1GclPk0r7DKb3/enmcv5SB3eVafHBTHpSSipZlRF/tMVd6AEVv4jnghhw8OZuR+avUv68VTlxYYSuYEF43bKK+f3Mz30x6lR8sD49DoWBFL2twIguWTuPWOMd0ZVnb6T0pFcrUi1CB/jH0PwMig+vh+a/Nsg6ToDmtXXU7C7Jop2vvHFNy1bsK42IL5bDEgW1eWPlsV+9EXWpNxo/cSggV3j3b8y5aQBBSCZjpwp5gbICvZ2g+Bic0gjAytYmso0IfmlQ6jprS9Scccd/BlpPGsTVb06lv6Cy8SfHghpl9wEdnlOPkBvcdflNc1bxHDvOKfMFGMN4MsmYYk89xOp3/fYnDNmyg8OybAcYkLR+lLkLco1tgZJYvA4ywFGrR3rvZ1XHH+MNQQxqDHz083a9u/uyGY0tUAVxXp0d865hF+BessXEW3qTxilLvRWX+8iilnt4fbwMPVSVb8DKkMHpsieAl0uk0t6hNxnm+Qn/oZ2JIDj3Qczj09x1g6yYU7HpASsKieBroU+m0UQjCfqIFk2IjkktjQj7YBAoeKD9c+z4BjP3JDCVscVE74QwTs7n+reBP1YuRIzkx76IItCNdH7ivr0C8fSCc/1w7Nr+80JIikp8j/ZYDFzkOLfPBEa3w1IETAGSVmtS9HYu9FM4ETUmlgXM4do8c/+t1lJjtICmpsKexiOHJI/3HPFmnapkDdPLi+HZaSwWGjNtxCeWfpOIZOFLpQIT6W65Fk3HZvIPOkAAzYxR9Ne2AIM1EYdrXeZvSIIVDbDS0l4zPhxTEhboai/+PXWaFFLTTtnSuG9//fDRSKfoKMMnVAfMNpop+lRrY5ubErCQF+QpickcqpxDksSihG8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(76116006)(31686004)(5660300002)(66446008)(64756008)(53546011)(66556008)(36756003)(8676002)(122000001)(71200400001)(83380400001)(26005)(110136005)(508600001)(38100700002)(91956017)(8936002)(6486002)(316002)(6512007)(31696002)(966005)(186003)(38070700005)(6506007)(2906002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGdmWWVBSUJoMXRGYkthS2dJaWxnSmVTbFlmcUJaQ1lQYzFnT0VxbTdSUWRu?=
 =?utf-8?B?cFEzZDh5OWo0ajVRMTY0NUdDVDR6Y0pMRm90cHJjTFVTV1hzaXdxaGtpUUtC?=
 =?utf-8?B?OTQ4b3R0a3VMdlZCeS8rSkYyV2VaWGtVQTlZTVZ6M3ptMjkzRjh1Ym9jU1Uv?=
 =?utf-8?B?Rmo0eXI1ZGhwUXJxaDM5eFhnMytvRC9EVExKWG5xYUlWeG5ldDAvVHZENHJV?=
 =?utf-8?B?YnZtQlVqNkxOSjFGRGUvSW9peTlvWGVkWHFzcXRUa3J2UkR4V3I2ZG1iWWpx?=
 =?utf-8?B?Tzl5UnFZTDl0RkhsRW5YK3doU2ZlaW1seVBYTytQQ0YvOUlYTG5wL3J1U3dq?=
 =?utf-8?B?NTlWVEIzM2Qvajh3b2FzSkwrZytybjk4QWExZHV2azZWTGZNQ1B3UVJDMExm?=
 =?utf-8?B?clYrYVptY2NBSGRSNW1DUVZnV2kzMFJWa1RWbytqS0ZzbUt0elB2U0phRnM2?=
 =?utf-8?B?OElyVjZ2YitFZUFiUlNVajk2ZkdmTndWSW44ckszL083NHRtSExKazk5d2Zv?=
 =?utf-8?B?WGVvMi9YZGY4MUtkOWFubWwzZ0Rkb3o5QWFFcHpNUDBhQmZhRFZSNFBreEg5?=
 =?utf-8?B?cHdLOUt1N3hONDJYODN6cDg1T0VvSGNLZ0NjdTJBVngzYlcxQWVFem5XMmli?=
 =?utf-8?B?MkNoaXhTbjgyOVUrSWZqT05IYXZwRjBXb3RxcHlqb3hWUDh5UmVNN01CMFdY?=
 =?utf-8?B?aUFpQ1Y3dENoc0Rmb3pZVmdscW9mTWJ2WnQ3VHo1bU1jNmZnaG50OUNzdHcz?=
 =?utf-8?B?VEJFSFpHUUYveThPdS9RL3FWVzJXczZIMUlPOHBjZlhlek1WeDJpeHI5cnhz?=
 =?utf-8?B?Y2l5YkkyMTJBSUVTVDk5eTRnazB6aEVYT3lkQ1hGUGFWb0hEK0tjNzZoTlVV?=
 =?utf-8?B?TlNOZVpqaEI2c25QVnJwNVBaaG9zMXlEbTBkVU5QNkxWc2dOVjhDSDljYVU4?=
 =?utf-8?B?dWRJaXFBWWJ2dGdZYlFZMjlOblMxSDQ0ZTVZdmJ6VE9lNWsyem5udjFQN3dx?=
 =?utf-8?B?a3V3cVdET09aT0xIbkVUZFNzeDZwVmRlQm1BMUNpamZXY1RBdE1MRS81dWIv?=
 =?utf-8?B?ZUFzTEdVYTF4ZllDa3Y1b204WVh6cjdVZHkwaHJhaDJKYlAzYXNIcWNHNXlk?=
 =?utf-8?B?TjRpQkIrK2Z2UHcrRk4zaXFvTmU5Z2ZFckk0NzdQbDdBNDZUTXdobHNvY3hV?=
 =?utf-8?B?QXpMZGxQM1NkQnliTXl5MWlJT0tRZ2x1YU5ORWNrUUdEZW9uaWRlUEpYR3Ex?=
 =?utf-8?B?YTJXTkhZYmxVVjVZaG00NWhtTDdLdTUvczBhMVF2SW5IQldPRWVZT1RhbGJK?=
 =?utf-8?B?dFY0T3JkVDVRc0Z2NnNveklEMENSWVVPdnRxMERUVEJWN0Vkd25DT3Vyclhl?=
 =?utf-8?B?UGJHRDE3Ym5uWGg2cEdzd3g5TktQYzFWZUdLU1Bsakt6SFJXRWpWUGZ0MXNL?=
 =?utf-8?B?RW9SSS9ENlcwVms2WU9LWlNndXpQNlRocDQxeTlCa3ZqVHNuZFNuTG91M3J6?=
 =?utf-8?B?ekFBai8yVG56ai9NTkdSS01BcVNtTE15S3dZUEJEaVhVRE5weEl2YXJHMXd1?=
 =?utf-8?B?dThkbzJVSkRiRU1uVlk1V2JUZ3pwMUZUeTMyMTRPd3JXU2RFc2pQZXRqOCtx?=
 =?utf-8?B?dlZIUXBvU21BVkNFK2Q1WVEwajNmNTdkbE9rdTlIU01zRGhhWWNDUFEyYm5z?=
 =?utf-8?B?dFJHMWcxZk9MUGNRN1ZKSlQxU0U5T0ZqSkQzRjFPemNIK284eDJvbDNiQS9O?=
 =?utf-8?B?emx1eW9ISkdlREEvM09DZDFOTkxXb3IwUTRHV1dDL1dWdzZQNi9pdGx3UE95?=
 =?utf-8?B?SGIvZHRNdStXREE5ZUtYVHVieTIyWElSSDJ5MGI4aVkxaUlabExLN1piZHdh?=
 =?utf-8?B?RE5rOHlpSzRHMmt1WFZWc1Z3eWE2Q1dMeDJTaHVQRUQ2S1R5dXduYUdoL2JZ?=
 =?utf-8?B?Sk5VbkEyR2ZRdDBaaFE5QnRyRU5lRnNYUU5ZY0Z4NnMxbzhsR0ViTE40MDhr?=
 =?utf-8?B?bXljSjVaWHJBbnRVSXZoeWlsRzY0dGd6MDB0VHExTTZZMG50TGh6MkViR0hO?=
 =?utf-8?B?QTZYMGEzdjBFckJ3MkJvU1dQeGhSK1ZoTldxUm9lN3FxSkJBZjNPNjNET2cv?=
 =?utf-8?B?REtBenJwU0R0NmQ3clhUVmRTekZVQUtQby9hbXlPbTFLMStPLzd3UnpmY3g0?=
 =?utf-8?B?ajk2UWNvbUhXUjBxaEc1M1VET0dBZDByamc3TU91WVlQYWdYZlcwZUpDUVM5?=
 =?utf-8?B?Q0hXRzN4Zk5HNXN6aEdPQ0kvNEdFQ092cDNFai9QNTR2bHpNK0lZSzZGcldM?=
 =?utf-8?B?YWZybFY1S2hvOXRZeWZ1SEk2RUVYZ0k1elpqNXNwenU1Z2VBdEEvckJUczdS?=
 =?utf-8?Q?PkE4E+6qbBKC2kJU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2513AB65B9ACB48A934D7D825758605@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c76e66-1af0-4eb7-b129-08da4842d13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 05:01:44.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6oA23tmu2WlTmfcbZjWb9LPp8/F8tjs7db52UInKLPu5rgB6kzS0fIGOO1iGwAxLN6LXiDI81fne8JkCxxCh8XNvIkaYB88RCRkXph1PPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5198
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDYuMjAyMiAwNjowMCwgTWlhb3FpYW4gTGluIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IG9mX2ZpbmRfbm9kZV9ieV9wYXRoKCkgcmV0dXJu
cyBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGVkLA0KPiB3ZSBzaG91bGQg
dXNlIG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBub3QgbmVlZCBhbnltb3JlLg0KPiBBZGQgbWlz
c2luZyBvZl9ub2RlX3B1dCgpIHRvIGF2b2lkIHJlZmNvdW50IGxlYWsuDQo+IA0KPiBGaXhlczog
OTYwZGRmNzBjYzExICgiZHJpdmVyczogc29jOiBhdG1lbDogQXZvaWQgY2FsbGluZyBhdDkxX3Nv
Y19pbml0IG9uIG5vbiBBVDkxIFNvQ3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvcWlhbiBMaW4g
PGxpbm1xMDA2QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1
ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+IGNoYW5nZXMgaW4gdjI6DQo+
IC0gY3JlYXRlIG5ldyB2YXJpYWJsZSBtYXRjaCB0byByZWZhY3RvciB0aGUgcGF0Y2guDQo+IA0K
PiB2MSBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjIwNjA1MDg0MDM1LjI3MTI3
LTEtbGlubXEwMDZAZ21haWwuY29tDQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvYXRtZWwvc29jLmMg
fCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvYXRtZWwvc29jLmMgYi9kcml2ZXJz
L3NvYy9hdG1lbC9zb2MuYw0KPiBpbmRleCBiMmQzNjVhZTAyODIuLjcxNTJhMzhjNjU3YSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvYXRtZWwvc29jLmMNCj4gKysrIGIvZHJpdmVycy9zb2Mv
YXRtZWwvc29jLmMNCj4gQEAgLTM2OCw4ICszNjgsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgYXQ5MV9zb2NfYWxsb3dlZF9saXN0W10gX19pbml0Y29uc3QgPSB7DQo+ICBz
dGF0aWMgaW50IF9faW5pdCBhdG1lbF9zb2NfZGV2aWNlX2luaXQodm9pZCkNCj4gIHsNCj4gICAg
ICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gb2ZfZmluZF9ub2RlX2J5X3BhdGgoIi8iKTsN
Cj4gKyAgICAgICBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaDsNCj4gDQo+IC0gICAg
ICAgaWYgKCFvZl9tYXRjaF9ub2RlKGF0OTFfc29jX2FsbG93ZWRfbGlzdCwgbnApKQ0KPiArICAg
ICAgIG1hdGNoID0gb2ZfbWF0Y2hfbm9kZShhdDkxX3NvY19hbGxvd2VkX2xpc3QsIG5wKTsNCj4g
KyAgICAgICBvZl9ub2RlX3B1dChucCk7DQo+ICsgICAgICAgaWYgKCFtYXRjaCkNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiANCj4gICAgICAgICBhdDkxX3NvY19pbml0KHNvY3MpOw0K
PiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==
