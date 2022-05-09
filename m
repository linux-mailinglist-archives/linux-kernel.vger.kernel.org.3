Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8AA520010
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiEIOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiEIOnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:43:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DBF2B0320;
        Mon,  9 May 2022 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652107168; x=1683643168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4whDr0HviR+JbcUG0MJrCbuDUtiVSl5deJxlepssbiY=;
  b=Wg8wfZJR10Lsos5jaHAB3Bfb65BEWJs3l1c6/fypxXP6PEX6pqW9yR1q
   /6v8H15fKZ3JnAlIK3Iv38Kwrict5qIojtwoTsy2mC/6xznTzXcr45dAM
   hBTCurCCqh1eF+WDuQKCSg05IfSdp3CpvX1A0mVfHkTHaBJa6WVyOy/P3
   UausBSqpcqQsUVU7EiguouxYJez8jSEvlc73VkefuKYHK7imKHGgFyA1B
   7XtiHecS9c88CeB1jMoqfLOwmIDLu813V5Xybb7I6UcKOd9E2zjEBuVKs
   kBXVToYKtGmmVpXqmwR/kopzQb+xW6OwYyUsXXwUkA+zXk6+6Z9rqGLDU
   g==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="158301372"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 07:39:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 07:39:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 07:39:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlFp5v4qyvEAp5bCFbNM6E26EkzFyVz3yBW1U3omarGtDqx4SW5LkCL7lT8RguoUe5C3Kcsb0PEUDwp557ENceKrd+nbFmJPiekJEEMiwmP1bNMi2kvwIbDdQXJM6pBXieqcbfrgH/n/D85VIq9QY9bYTBDR2rHEFgHJ/Bg32TKaD4zKy2DThvOaHB7L2xq60pOibquepsCbfIv1eEH8HpONbYg14Hf4FE60HX6ChPPuIEraoTxXB8WFg81pQhTmUnSYZ3FkHyLssrywLj5oJ1u5D01c5yil9qK41tzlaIR139wJc2BGboMWwSnZuzFLGITxIIvLjEmd6PayfOY4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4whDr0HviR+JbcUG0MJrCbuDUtiVSl5deJxlepssbiY=;
 b=JVMRBKxilF810eYlusUg1g3eKcIcsmxujUWd3zKbqkAR/MHFqgywsqLikihc3/cgRSQ5QQGKM91Wn5pdSyEjD8Z0rCzokTWuA7xkuNncKJfEx1pqc7s5CPTHisdgzWvF7e+4rNr0/WXk7HwdqrYkgrKTg1JN/YH8xQ81jVWjicz/U326JJeiHnKn0GaSaIC9o+/oRv/GNFyKGMTz2uWHTi3bzbk4V9y1MHXwZ/Bpr5YbMYW4UJ9y8Y8gXySiOb2E8qHHw+qRyLNWVgmfAlsRT42gjA64Z6nNuvm/H8/NBh2CZeoGlZoFKAnqUQINmEwGMRxX4njflA+cAhVgAR4yxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4whDr0HviR+JbcUG0MJrCbuDUtiVSl5deJxlepssbiY=;
 b=AxTu/nFfM0TjVhvSBNRKYxWOGt11DyYgDhzLgnXj6RHdfZV68FNw6kk6HRLHMWteF6hLk/cd/48QlFgi3mk7aYzJ/DAFk+Pdhjn/MuP8/VlGPXZTNVTFB3I14OAgAru+dFNEcbdUDdCw7e8h+zjNAkt459YEXVFIlR4eggEZhXM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BYAPR11MB2583.namprd11.prod.outlook.com (2603:10b6:a02:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 14:39:13 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Mon, 9 May 2022
 14:39:12 +0000
From:   <Conor.Dooley@microchip.com>
To:     <hch@lst.de>
CC:     <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: linux-next: Tree for May 3
Thread-Topic: linux-next: Tree for May 3
Thread-Index: AQHYX5FrH/BqiZa6/06OwkWdFdBwha0Wk2YAgAAKyQCAAAevAA==
Date:   Mon, 9 May 2022 14:39:12 +0000
Message-ID: <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com>
References: <20220503172926.08215c77@canb.auug.org.au>
 <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com>
 <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com>
 <20220509141122.GA14555@lst.de>
In-Reply-To: <20220509141122.GA14555@lst.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bf1b162-d1fb-4eff-5ca7-08da31c9af73
x-ms-traffictypediagnostic: BYAPR11MB2583:EE_
x-microsoft-antispam-prvs: <BYAPR11MB25837C25103ACC45F14EC93298C69@BYAPR11MB2583.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5uJZIg/tjJ458StAGW3xPaJeRKGsR/zs/qxdSP4SNzRidy3gSllBHKM4XzU2Ya32gMUhCz6OQwn4tNPlhLzm6TzgoQX0eT4vQQTTfSI5vwmnDgvlCOh1xobmsTitBxaiCSR58TZRWZcME2d4AyUY3meFYT9fMOICLnFZM0MKGilFbLQt5awcrsBTGf3IrAdFCfCjx/IFWZ0hO1K4teDwN8aDVn9dvwaatr+KGDOyoDdsjGEoI3+bG0b/NxpzTNMFOA7SDuo2FUMBiB8MDO4GN36cofKs1EMud/2ZpeZTEIlx6dVmjac6iMfwFIjXZmCxQlhLKpyuJNrBi0t2OPTFL3ig1/DX6saHcMbGSs6v6b2wjEB9JzvjvDpJl853v9WhF2llpQV1C9IDp57exEjCFAx317oD2INTFsO/7PY8gxm7XboNh9UyQCEsnoHchMNvai5Scc9zrwOcRnkwjdEAsBYj9uSdGRmKKf2Dh2qTGTAIQl/lBGiIfr3EymFPUPrdW4ZDaZAzPXIG0EVTY6VpHOHy61PsJiqB8pnrm+Idq7ggufpxbX7yRTtyUulsiFoVV7RK5CqVwCjiwiRpwtnoGJ0/RLoZQm500QZwSX3pDgpn2ku6ftB87OfN2/+PDh6MxBIkNLF5oW7is1Q8i76W+vcRQjfSuGY0BU/R4BERjmeQf5p4RzH5/AP5jzevHhJc8PuPRzutEQfNbM6o5P/5vygqsdn9SxaLifaZZS1UP5IgzblF3V0DeOMjI+ZVMDWoSjodDWaO++7C9Fb4pfBXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(186003)(6512007)(31696002)(5660300002)(38100700002)(2616005)(26005)(8936002)(122000001)(83380400001)(64756008)(66946007)(8676002)(38070700005)(66476007)(66446008)(66556008)(2906002)(76116006)(91956017)(4326008)(6486002)(6506007)(71200400001)(31686004)(6916009)(508600001)(54906003)(36756003)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlQ5R3VmYWdFMFBZY0dVZXQ5L1RoL2N0QVQyc2pzZDhVMU1HYkV4MjVJSEJV?=
 =?utf-8?B?MnIweHBWZnZmeS9TQ0ROS0RIZ0dOTHBEZEpjZVJoSVpka2ZTcFlOTU1sYnAx?=
 =?utf-8?B?K0dJSEwyRzZ4YXZzRzQzZm85ckRmSHNNbXZZWEtWa1BHajRGdmRKR2RFZ2VT?=
 =?utf-8?B?cXFEZEdhbUIzU1ZWVDliMVNwVVU2ZHRGVWppYWhPRzYrUFlxTWhiOVZxV2c2?=
 =?utf-8?B?ajdIcXhkL0R1eDRBalIzem1WdGUwNytydDU4MWttK2hVTkFXSUZKZVllZzhJ?=
 =?utf-8?B?RDc4YzUrbmU3eldxTUlTSS9jMVJwSzJpeE1WdW5NMUJkZmlxVFNTUDduV2tC?=
 =?utf-8?B?N1Q4aTdPcFlzME1RcHB2bnMyYlpONFlIdVlmZFhjUElqNFhKdElKRjllcHdE?=
 =?utf-8?B?TjR1R0hKUE9sbEU5cnF4ekhCcEF3dytQRi9wWTZKN2tVRVpBSlNxbU93UVo1?=
 =?utf-8?B?TnVwaG94R0gvYzZ5QnNpQnhWWTNRSFBPbDh0WXUzcTg2b1Vlekw5bEdYd3la?=
 =?utf-8?B?VlJqdXg1QWtVYnlFQlBXSDZEU1RhNksyWVBqdCtyWmdCUytab1J4VmhxTzQx?=
 =?utf-8?B?Y1V2MnB6WXpaTndhUmZBVG5ENGRPVlZVaFNHTUJvaTF1WmFTS1pzNVhxSUts?=
 =?utf-8?B?QnBHOSsrM2o5TFhyYTNVdGh3Q2hjSXFRNmpkN3VWZmhvNHl2OU1XemlqVnVP?=
 =?utf-8?B?U1p2K2RoRitGVG5lRkFYV3NRTWgzbkhzUmVxajZ3WjM0MGJaYkZFU3UxU2Y5?=
 =?utf-8?B?RlFZN1JVN1JEZC9KQWFjWnY1Z1dMamorU2FhTWNGSVNDUXJGNWs4bTVQME4y?=
 =?utf-8?B?M2V6T0hncEI5VDErMmpGMUNFVzhNWk1ENUh4cjlZbVJqUWQ4Vm9UdHJWWW83?=
 =?utf-8?B?WlR0UW56SUpzN0RxS0RWZGk5cWp6eWh4VjJtaVNtdGJNMURxZUhGbDEwSlBt?=
 =?utf-8?B?ZGdhQXFHSkxHdUphWkVwbFJhQ25Ec01uUlVuaFgzUXlmOGlhSzlMdmxDRE1D?=
 =?utf-8?B?RUxNT29LUGtsVHVMMk41TTZtN1RERElMQ2g0bHBMVW5uMGtWMEVwNHF1eFBX?=
 =?utf-8?B?Q2NvRVVCRmlGSkFsczFKeUFhcDF2dXN2OElJbGdKN3BETGpLS1NOMkFaUEE3?=
 =?utf-8?B?YVZJcHFFdGpMaW9aNnkyb2tsQmVCeGFBUTlENDJGbmRCVkh1d3dFMzZBdE9o?=
 =?utf-8?B?UkxreDl1M2h1aDJudXJqS2wwT2JOUHBUeElKRDN2TWpqWG51Q0tlZW1QWjVz?=
 =?utf-8?B?RWt3ZEdTbkVhVHhBa0UyRTh5S1VKUkxYbEo5YmV6M3J1Tit0U2FWMkFmMEps?=
 =?utf-8?B?NFVNSE5STGpsWXlPSnpHcTg4OTdhMlROT3RtemR6aTVBSEhzQkh4VWc5SW5k?=
 =?utf-8?B?UklDaDlQSmZMdDY5MnJteS9VdURReEZSVzZmcml2cXdOdnNIRWdSb2pkV0pQ?=
 =?utf-8?B?UTA5QXpOenlMbFloa2IvZ0JYZWpaK2F1WGNvTTdTRTRmbHU4b0V4b2FQQXVD?=
 =?utf-8?B?V3NIdm9LNUlvK0EyR2hOc3hqN0d4dURtcXpNQURYVTRiT0dXTFJvVFJCVEdK?=
 =?utf-8?B?OVlNNkVYUzl6QXd1MURTWTdMN21TNE9wSU1lVmV5Ym40SnhFek85U0d3bFhF?=
 =?utf-8?B?UlNHTy9nQ0tUUHB2R3Q2eTY5bnk5eCs3NGh4ekFJVW0wVEY3YlJucE1nQW1y?=
 =?utf-8?B?a0J0cmxwaDVFQUNLOXBNOXpPT0lEVThENkViL1BEOG1jMGp5enBQOVNMOEV0?=
 =?utf-8?B?ZllQVS9MbitUbzJsUk9qNWZaOHVrMFZUNUtxK1FrMTE5T0lFMDVqMXNWcmFn?=
 =?utf-8?B?OWhoVk5YQktUUDBRakJCWDcvR3lTWStzRlYzM3JGSkpwSUt5eUVxNVpTWGxT?=
 =?utf-8?B?cVBEVklML0p4SkZvNGQ2dzUvVjlqRUtubkJpaSsrb25OMEc4RTNmMkVUZG5W?=
 =?utf-8?B?QjNYaTZHTXZTZlZTUzB0UExGM0xCd202Mm11ai9hM2hHVDVVWnNVNE9nZWdw?=
 =?utf-8?B?d0ZaU3BxNCtXLy9mN0ZXVlRwdFVxVVRoYmcrT0hjdzlNeXhRMFF2ZWNTd2N5?=
 =?utf-8?B?SHl6cXFQbFA0c2pJa0JKSENJcVFqVGtEVmlDd05aWHhsdUR4MHNDUHdNd3ZU?=
 =?utf-8?B?QnhzMDBWRFBXamxQZTlwL0Q3VXpnV09mSG5rcHZaUFFUeVlPZVZCVmZUNDd5?=
 =?utf-8?B?MlNmWEw4SjVUdkdKQ2ZuZmJXQ29uK011eG5hVEU2UitHWDRCQklXTzl0T0sr?=
 =?utf-8?B?V2pLUmE1bW8yWlFTR0lWbUdRZEhieTBaNVFwM1pvd29zL3VkYWEwZWttVDBZ?=
 =?utf-8?B?d2Z3Z3BuZlhlS25UbkVnYnppOGNHZmZ2c2liTmZvZFV5Y0g2RUtRRXRLaEhx?=
 =?utf-8?Q?EC9CWF4m76ibBdhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <625D63939E74D84D9B160137FAA887A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf1b162-d1fb-4eff-5ca7-08da31c9af73
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 14:39:12.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltml/9Q8JiXp0uedwGyvD3STWfzzIgtP0T85m67s/l1ahOoBZvnECKD2V9LeYqhha5MK8wBEuCB/4pPx+4WxWt72YDb+azlosCOWpRlADdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2583
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDUvMjAyMiAxNToxMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBNYXkgMDksIDIwMjIgYXQg
MDE6MzM6MDdQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBA
Q2hyaXN0b3BoLCBJIGtub3cgL25vdGhpbmcvIGFib3V0IHN3aW90bGIsIHNvIGlmIHlvdSBoYXZl
IGFueQ0KPj4gc3VnZ2VzdGlvbnMgZm9yIGRlYnVnZ2luZyB0aGF0IHlvdSB3b3VsZCBsaWtlIG1l
IHRvIHRyeSwgbGV0IG1lDQo+PiBrbm93IHBsZWFzZS4NCj4gDQo+IEhpIENvbm9yLA0KPiANCj4g
c29ycnkgZm9yIGRyb3BwaW5nIHRoaXMgb24gdGhlIGZsb3IuICBJIHdhcyBhdCBMU0YvTU0gbGVh
c3Qgd2VlayBhbmQNCj4gbXkgcGxhbiB0byBnbyB0aHJvdWdoIG15IGJhY2tsb2cgdG9kYXkgZGlk
bid0IGdvIHRvIHBsYW4gYXMgSSB1bmVwZWN0ZWRseQ0KPiBzcGVudCBoYWxmIHRoZSBkYXkgYXQg
ZG9jdG9ycyBhcHBvaW50bWVudHMuDQoNClllLCBubyB3b3JyaWVzLiBTdWNoIGlzIGxpZmUuDQoN
Cj4gVGhlIGNvbW1pdCBsb29rcyBsaWtlIGEgc29tZXdoYXQgdW51c3VhbCBjdWxwcml0IGZvciBh
IGJvb3QgZmFpbHVyZSwNCj4gc28gYW55IGNoYW5jZSB5b3UgY291bGQgZG8gYW5vdGhlciBtYW51
YWwgdmVyaWZpYXRpb24gcGFzcyB3aGVyZQ0KPiB5b3UgY2hlY2tvdXQgNjQyNGUzMWIxYzA1IGFu
ZCB0aGVuIHRoZSBjb21taXQgYmVmb3JlIGl0IChpLmUuIGFzDQo+IGdpdCBjaGVja291dCA2NDI0
ZTMxYjFjMDVeKSB0byBtYWtlIHN1cmUgaXQgcmVhbGx5IGlzIHRoaXMgY29tbWl0cz8NCg0KSSBy
ZXZlcnRlZCB0aGF0IGNvbW1pdCAmIHRoYXQgd2FzIHN1ZmZpY2llbnQgdG8gYm9vdCBhZ2Fpbi4g
SSdsbCBnaXZlDQp0aGF0IGEgZ28sIGJ1dCBpdCBtaWdodCBiZSB0b21vcnJvdyBtb3JuaW5nIGJl
Zm9yZSBJIGdldCB0aGVyZS4NCg0KPiBTb21lIG9mIHRoZSBjb21taXRzIGFyb3VuZCBpdCBqdXN0
IHNlZW1zIGxpa2UgbW9yZSBsaWtlbHkgY3VscHJpdHMgdG8NCj4gbWUsIHNvIEknZCBsaWtlIHRv
IHJlYWxseSBiZSAxMDAlIHN1cmUgaGVyZS4gIEluIHRoZSBtZWFudGltZSBJJ2xsDQo+IGxvb2sg
dGhyb3VnaCB0aGUgcGF0Y2guDQoNClN1cmUsIEkgY2FuIGhhdmUgYSBwb2tlIGFyb3VuZCB0aGUg
Y29tbWl0cyBpbiB0aGF0IGFyZWEgc29tZSBtb3JlLg0KDQo+IEFsc28geW91IGRvbid0IGhhcHBl
biB0byBoYXZlIGVhcmx5Y29uIHN1cHBvcnQNCj4gb24gdGhpcyBwbGFmb3JtIHRvIHNlZSBpZiB0
aGVyZSBhcmUgYW55IGludGVyZXN0aW5nIG1lc3NhZ2VzIG9uIHRoZQ0KPiBzZXJpYWwgY29uc29s
ZT8NCg0KQXllLCBJIHNob3VsZCd2ZSBkb25lIHRoYXQgaW4gdGhlIGJlZ2lubmluZy4uLiBJJ2xs
IGxldCB5b3Uga25vdy4NCg0KVGhhbmtzLA0KQ29ub3IuDQo=
