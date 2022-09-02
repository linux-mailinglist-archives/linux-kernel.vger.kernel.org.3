Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD425AB570
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiIBPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiIBPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:38:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E710D4C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662132389; x=1693668389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wduAiUnjkJClL9Wp725TOSSCCohu/h87bE37QDlfXZ0=;
  b=HwF2Ft/aXKytGoG4gqIZjUv7DuCGp4gSxhafLFEdzdAC5LrVgnvWmcfP
   jJ1PoQ8w4cFl90/RNCVJsEFRbRNsSkl4k6pFHs1lt0L3PsY6T7Iu1eMcF
   2a7QoOlkIMPziHFUWWI4Mb8q2leFYv4JXjg1Wn9n0IKDg1c/QNOExFANx
   MnRSovi1d+gPqdpNQp69W778JvosY+van2fG9VKvFNbeE6XT7sIjKlogM
   hnqUOKR3MRtiBRUGNdeYTnVpWYMV11J+QUXxaQtEr6Ba+E5K0JX3E2rIa
   CbNq6c+pia2x5b54fkCU6cAYgyM6DTdSGMz2/pCepgH28/mYVv/h683Ga
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="189185412"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 08:26:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 08:26:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 08:26:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwrxtCEOyr0zyMQE0zMYihxzNi7yLFU87OJDB8y8QyamAloeVu6iQzb7gRivYx/ajMHVggUUVio5MEGhUZmZqo14iDyvE2jpMR1TqrcKiaDDxC6+S6OOStjedjdgO2vTZVUgdR7IvEI3a2sNcUQvdXEybIHc3tdDaoTnD3AW/Tyj1qDlz25BLp9ssllywp4OUNPdnx3R0hAktLk0T/JJkweJXPxHdj6rsxH2WrAnIaThi0MCGLtLnrENqzCY1SbBoBySbc2mm6inMCrQFtgOpDeTvGFnDIjkPnO/Yvi7zx2LlAfPb/koq9kzzxNS7q3KvozcmCZYpD8GQnz101787A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wduAiUnjkJClL9Wp725TOSSCCohu/h87bE37QDlfXZ0=;
 b=QlqaS8fmC1JgLrinffM4K9JNisxEt9TX6/YmvLOvTmKQQhqyfxuboNluAAirsvIm2kr7wKIZU5M17zb6tBsGuwdHSEprLg/dzjD6EjFT6xY68A/HghNYjPiYmjRkAsvc1zLxL44ovSBvv7mwtJOAD/8SR5dED+jy2gmEMg75WDUxPQ9F5SKWxbz1N4sIDOlRQvDAX/WFD3eEI00Dd1jOgf1HyR3Oc0dy5dYmUFFTpmJQKGkIK4SfzrMzfUSfMvi0j7vQ4didhk+lERRaqBXO3UEcSVAT0iBz8CdX41xrge+z4I5doJFv9bYK5kLUalhX9yRX+BQCpfzvr7jINTSpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wduAiUnjkJClL9Wp725TOSSCCohu/h87bE37QDlfXZ0=;
 b=eZOp3Omoq9cl4HN1erCEapE7qWHlnBzpN+TBFwxLLQsoA+8bryp7Xa0RVrzgRxZzwe4pfS8z8MzJ2k0q2DMvEb4ZFmc3ymz58QiVGC8bdNI6mUH6PiRHra61jJtgz+j47e4biYC5xni/HH6iv5H8kh5TZKg0Rx38XtMMDwzBBRQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2313.namprd11.prod.outlook.com (2603:10b6:4:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 15:26:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.016; Fri, 2 Sep 2022
 15:26:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <ajones@ventanamicro.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <guoren@kernel.org>,
        <apatel@ventanamicro.com>, <atishp@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] riscv: cleanup svpbmt cpufeature probing
Thread-Topic: [PATCH 1/4] riscv: cleanup svpbmt cpufeature probing
Thread-Index: AQHYvlI0SQeRx9DmtEOp6XWrWDqn663L5f6AgABaFwCAAAP7gA==
Date:   Fri, 2 Sep 2022 15:26:21 +0000
Message-ID: <464dbc2b-e281-f9ad-f8c7-ba66e8247432@microchip.com>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220902094939.wvzovl6ytujtjbtm@kamzik> <2910587.GUh0CODmnK@diego>
In-Reply-To: <2910587.GUh0CODmnK@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d98b22f1-bf4d-4a2b-15bc-08da8cf77db1
x-ms-traffictypediagnostic: DM5PR1101MB2313:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPmF+h8Llbr2VCmXRn6WS5vgO19OAnQ3sE9hBGOqpQ1ZkLWjwtqZrqYNzPs11xDU3sr6K8OBhtqFcwZiPtYf36HHL93Vl0MCpuqm2kB2achlJyQg3crxB7z3IsVoaCElBd2uQQs8b8Xiq/SbJM9mZ7E8kKPXUdz/9dhx+qWY20zwR2mDt7Qf5/O144KyZfRrQSDlcFEuML0aqwaeklDl2KBR7CSy3cj17Zaxelhasfz6Qpro4UWSaGXcf1e9gCs8pUJIwsdIV6wKG5bI+8r0zmGCXrL2A8qAMMjEAOsArCfDlrstFa8PSzFPO14h6jWtWwdFqJroKhgtBIyRbSPvaeH0lmUduO+PcT95gNSEXUMWpIwjHkuiAfDgMMdeN0pDdZjqQj2pHuvpfMn6eFM786c1pIQ2v8XQsiJ1KYKjPKCgjpBI2KDNfsVSC8jB+HpuCq3GePQ2VsAPTmgaMvpXMQ7BFhg4T5OIkhiUyU5b9X1LROPZuDsht14Ku0P/rsgTiT5XRDU//5S3jjMgqM5aHHqCvG70vkgWgQDnTN71jVCD8VjIZrcX7Du4jW3JlvOveVpgdCdyFnHSc3zb/dW1xXFDFlkDKGmRoZTJQjS7mphHvA0oOIRhnSnoitbhbPZvhThw/SEXwymzzvkC7PgLIxyqqVFCl7t6kQ18v3Sv/CYGSr7Sc6Qa20I1vj6n/QzuExZzuaQ4z88y6vxyq/LUkNR3CRcC1SdbtF/14ybkNighDNUdPHe2fiK00oCUl824xJPFjUEABatjVo5adt5dWqdtIYxbeSoAOOZBzHda2ZMdjwL8TC4kdVRKNrG41eq9u5Y0fLiaJIX/x2KHAY0LtdTkLTAQBz+NJrFTnWhqdIg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(136003)(396003)(122000001)(36756003)(8676002)(5660300002)(64756008)(2906002)(31686004)(4326008)(83380400001)(66446008)(66476007)(66946007)(91956017)(66556008)(76116006)(7416002)(8936002)(54906003)(316002)(110136005)(6486002)(478600001)(71200400001)(41300700001)(38070700005)(2616005)(86362001)(53546011)(186003)(6506007)(6512007)(26005)(38100700002)(31696002)(40753002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUcwdDJlNjJ1aXN4c2h6ZWp0NXVBS1pUTDBlU3h0NkVCelhoUjhJSXVWSXZN?=
 =?utf-8?B?eGtoZkhuQ0p0N1BnVWVEdUMxVGVBcFQ3d3hVbGU3VEduRllmUmxXVG9yNnJN?=
 =?utf-8?B?RnJZZmxjdmZMREVSVFJLU0duZTRwM0VpV0JOMkNjQ0h2Yk4yZStGb2YzUEN6?=
 =?utf-8?B?SWhiYzcyNVowOUh2My92V2hDQzRlbGN5VnEzZ0JWcXo5VVd6WlBSTldNdElX?=
 =?utf-8?B?U1hjOURRZitLc2xuNGpUcDJZZVlreHZvcXRDVnNsdzA5cW05c3lNcnRiZ2pN?=
 =?utf-8?B?OHg4V2FsajVFYnRYWVNBRks4V0p1cm13NU5Wd3dBSU8wN1BneVNiVG1SUXJP?=
 =?utf-8?B?dUFoL0doelpXaDhIMGlGUWFmRlMzaVdQL3VPVERESGhLOU5ieGlyNXh4RHlX?=
 =?utf-8?B?aDRtcWwzU1pGa2NOb01kTlhta0VBRjNPMnJ2S1BvaWFIOTRKb0sxMmUxTHVV?=
 =?utf-8?B?cVIxbHBoMW04MGJUOGl2cFZMbWM3MFNDelNFZEF4anoxbGxXcXRrSFFYWmc2?=
 =?utf-8?B?bGFSVDFPSGhmQW9laEszV2tlWk51VVN2Qmw4TVBqSElsSjF5TUQ4YWpLVFpM?=
 =?utf-8?B?TlJaUmQ1aW9GWnpsOEZ6RkJ5T01IQ0ZhZlA1VXFZaEtKUnFiRm9TU3MrOXBp?=
 =?utf-8?B?YlBxNkNWaVJmTU5nSWpna01lMzJqSXJVV2w2Y2F4d3hWVG1TNzRKN3BKM2Z3?=
 =?utf-8?B?R2x0THVTd1Vield0TFR1NDZrSzFKd1VyTG5qbUpiZkVoYXNGc0NsUmtueWdN?=
 =?utf-8?B?MWZnbTZFWnZMT1E0bllxSUlPRWQvckpmYXgwU0Z6ZFdKd2xudjNnOFcveCtY?=
 =?utf-8?B?cnVxMSt1dXBFZzU1SnhNdzVjSWFOTDgxTS9MVUh6Y2lpdTBZbE00ZzJaRDZ3?=
 =?utf-8?B?akRhOU9SbFkyTmtSejJhNFI0MVRVby9ndC9wN2FBN1dJdzc3T2lVN01FNjR1?=
 =?utf-8?B?NENRQzEzcm9ER1Vwa0djNkVKV0xBT2h6OGNwbHBUd2JIM3ZpRFNvN2d5RHg0?=
 =?utf-8?B?SnI1R3VmeFFpa1grcDVoYU1wNGc4bDlZUFg2V0x4UlBKRUJPdHVKbFowOGdI?=
 =?utf-8?B?RTNMSEF6UUo4ODJGSHZUK1RkZ3NtMDdaWC9sZVpkcThKdFpXL0hVRERTbXFq?=
 =?utf-8?B?Y3VXOEs5ZWZoTmdFZUdKR3I2WHg3N1RuV0x4U1dsZDVoQnltTTRCRUlhWGo3?=
 =?utf-8?B?b2Y3N0c5VDdTdE9WR0V1ZVhrak95ZHFleVZDMExCZmFMNTdUU3UrYnAwT01j?=
 =?utf-8?B?ZTN6SU85TmFienFPelN5TDh0N0hvOEh6VUgrczNTbWJoRGovaEpCR3NTck4v?=
 =?utf-8?B?aXFSaHFkdzR3Y29GeVNMRDZKdDhFN1IvTGhTcUlmZis0enBuOFVCOXRmL3Ir?=
 =?utf-8?B?UUwwVUdvVE9vYXVlTEFpVVhzcndFWUphemx1bWxwNU9xMWpXQnVtK2d2Qzhl?=
 =?utf-8?B?RWRBNGViQnpmdy9iazN3MTdFUnpLU3gwdmNvNDJtMGRsMkpjLzlHc1ZWc3BV?=
 =?utf-8?B?d2l6WmlpSTcyUzVkY3BvNWlZMW9qZUpXZitwUVlIbHpaM3R2c1paSS9ZT3Nm?=
 =?utf-8?B?UGVsQnFRaG5TOVpwOVhRRTg3R1krL0tEWG01MWExRS9vWGJYVDdOZVExbDU0?=
 =?utf-8?B?WVNGK0Z6RnRlNU1JWG1YcDNtdm02aGp3NmdBbUJLYlJWc3VtT2x1NkF4RHg1?=
 =?utf-8?B?aytZOVNLZlljNzNCc1lwa0QwNGxXaGV3Q1Nuei90MisvQlZZaVlPY0pjeGlT?=
 =?utf-8?B?R1RMcW5pVlA0S1NOZ1dFN3NZbC9ndTVaSlVRUWtJalRqUmdKZlVuR29ZNmhR?=
 =?utf-8?B?SE5LbVBhR24zbGtlUVN1ZFNDTWZ0WTRkUlp6MHJXUkVNQkUwb0pVancrUWx5?=
 =?utf-8?B?RzJQTDVQZ01wU3RZOVc4eFQxYU12VHY0L2tCY1AzajQ0U21IZTFzNndOUHh1?=
 =?utf-8?B?OWptbVllS0lyR3BFRXplM0wvZ2tadjJLM0pQM1BxTVcrU01BZDl0dGZwQk5Y?=
 =?utf-8?B?MmtrNE1XVjJlR1BpWjJGUVJiVTRsWk9DeHUyaFpvRmhTVlg5dS9IUmhGdGFK?=
 =?utf-8?B?K2hGTnNHcHpJemFSYXlVUWNoc3ZTUUoxMlVZdTQxTjFrNkVaU2ZaRUlTdUZ2?=
 =?utf-8?Q?uUFtMiwYj7pI2F28CJGjavVu0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45BC152AB8E07D46A8A753D6CAC9B2A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98b22f1-bf4d-4a2b-15bc-08da8cf77db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:26:21.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VTGQ8h2LGYuUjtzG4SwJcEMkXAzZugSe0i8d/zE2QyMSr7h+VPOITYzQ9/4jewygDMNeij/m0X6y5wXWFfBoV/bV0CekNUknpr7N+6MDu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2313
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDkvMjAyMiAxNjoxMiwgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gRnJlaXRhZywgMi4gU2VwdGVtYmVyIDIw
MjIsIDExOjQ5OjM5IENFU1Qgc2NocmllYiBBbmRyZXcgSm9uZXM6DQo+PiBIaSBIZWlrbywNCj4+
DQo+PiBQbGVhc2UgdXNlIGEgY292ZXItbGV0dGVyIGZvciBhIHBhdGNoIHNlcmllcy4gVGhleSBh
bGxvdyB0aGUgc2VyaWVzIHRvIGJlDQo+PiB0aHJlYWRlZCBiZXR0ZXIgYW5kIHBlb3BsZSBjYW4g
cmVwbHkgdG8gdGhlIGNvdmVyLWxldHRlciB3aXRoIHNlcmllcy13aWRlDQo+PiBjb21tZW50cy4g
Rm9yIGV4YW1wbGUsIEknZCBsaWtlIHRvIHJlcGx5IHRvIGEgY292ZXItbGV0dGVyIG5vdyB3aXRo
DQo+Pg0KPj4gRm9yIHRoZSBzZXJpZXMNCj4+DQo+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEpvbmVz
IDxham9uZXNAdmVudGFuYW1pY3JvLmNvbT4NCj4+DQo+PiBidXQgbm93IGl0IGxvb2tzIGxpa2Ug
SSBuZWVkIHRvIGdvIGJhY2sgYW5kIHJlcGx5IHRvIGVhY2ggcGF0Y2gNCj4+IHNlcGFyYXRlbHku
DQo+IA0KPiBJJ20gbm90IHN1cmUgaWYgdG9vbGluZyBsaWtlIGI0IGNhbiBoYW5kbGUgUmV2aWV3
ZWQtYnkncyBpbiBjb3Zlci1sZXR0ZXJzLg0KDQpZdXAsIGl0IGNhbiEgQXQgbGVhc3QgYGI0IHth
bSxzaGF6YW19IC10YCB3aWxsLg0KSSBhbSBub3Qgc3VyZSBpZiB0aGUgbmV3IGBiNCB0cmFpbGVy
c2AgZG9lcy4NCg0KPiBBdCBsZWFzdCBzb21lIHRpbWUgYmFjayBpdCBjb3VsZG4ndCwgc28gYW0g
bm90IHN1cmUgaWYgdGhhdCB3YXMgYWRkZWQNCj4gbWVhbndoaWxlLiBTbyB0YWdzIGFkZGVkIHRv
IGNvdmVyLWxldHRlcnMgbWlnaHQgZXZlbiBnZXQgbG9zdC4NCj4gDQo+IEJ1dCBJJ2xsIGFkZCBh
IGNvdmVyLWxldHRlciBuZXZlcnRoZWxlc3MgLSBuZWVkIGEgcGxhY2UgZm9yIHRoZSB2MiBjaGFu
Z2Vsb2cNCj4gYW55d2F5IDotKQ0KPiANCj4gSGVpa28NCj4gDQo+IA0KPj4NCj4+IFRoYW5rcywN
Cj4+IGRyZXcNCj4+DQo+PiBPbiBGcmksIFNlcCAwMiwgMjAyMiBhdCAxMjoyNzo0MUFNICswMjAw
LCBIZWlrbyBTdHVlYm5lciB3cm90ZToNCj4+PiBUaGlzIGNhbiBhbHNvIGRvIHdpdGhvdXQgdGhl
IGlmZGVmIGFuZCB1c2UgSVNfRU5BQkxFRCBpbnN0ZWFkIGFuZA0KPj4+IGZvciBiZXR0ZXIgcmVh
ZGFiaWxpdHksIGdldHRpbmcgcmlkIG9mIHRoYXQgc3dpdGNoIGFsc28gc2VlbXMNCj4+PiB3YXJh
bnRlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRl
Y2guZGU+DQo+Pj4gLS0tDQo+Pj4gIGFyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYyB8IDEz
ICsrKysrLS0tLS0tLS0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9jcHVm
ZWF0dXJlLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmMNCj4+PiBpbmRleCA1NTNk
NzU1NDgzZWQuLjc2NGVhMjIwMTYxZiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5l
bC9jcHVmZWF0dXJlLmMNCj4+PiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmMN
Cj4+PiBAQCAtMjUzLDE2ICsyNTMsMTMgQEAgdm9pZCBfX2luaXQgcmlzY3ZfZmlsbF9od2NhcCh2
b2lkKQ0KPj4+ICAjaWZkZWYgQ09ORklHX1JJU0NWX0FMVEVSTkFUSVZFDQo+Pj4gIHN0YXRpYyBi
b29sIF9faW5pdF9vcl9tb2R1bGUgY3B1ZmVhdHVyZV9wcm9iZV9zdnBibXQodW5zaWduZWQgaW50
IHN0YWdlKQ0KPj4+ICB7DQo+Pj4gLSNpZmRlZiBDT05GSUdfUklTQ1ZfSVNBX1NWUEJNVA0KPj4+
IC0gICBzd2l0Y2ggKHN0YWdlKSB7DQo+Pj4gLSAgIGNhc2UgUklTQ1ZfQUxURVJOQVRJVkVTX0VB
UkxZX0JPT1Q6DQo+Pj4gKyAgIGlmICghSVNfRU5BQkxFRChDT05GSUdfUklTQ1ZfSVNBX1NWUEJN
VCkpDQo+Pj4gICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+IC0gICBkZWZhdWx0Og0KPj4+
IC0gICAgICAgICAgIHJldHVybiByaXNjdl9pc2FfZXh0ZW5zaW9uX2F2YWlsYWJsZShOVUxMLCBT
VlBCTVQpOw0KPj4+IC0gICB9DQo+Pj4gLSNlbmRpZg0KPj4+DQo+Pj4gLSAgIHJldHVybiBmYWxz
ZTsNCj4+PiArICAgaWYgKHN0YWdlID09IFJJU0NWX0FMVEVSTkFUSVZFU19FQVJMWV9CT09UKQ0K
Pj4+ICsgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+PiArDQo+Pj4gKyAgIHJldHVybiByaXNj
dl9pc2FfZXh0ZW5zaW9uX2F2YWlsYWJsZShOVUxMLCBTVlBCTVQpOw0KPj4+ICB9DQo+Pj4NCj4+
PiAgc3RhdGljIGJvb2wgX19pbml0X29yX21vZHVsZSBjcHVmZWF0dXJlX3Byb2JlX3ppY2JvbSh1
bnNpZ25lZCBpbnQgc3RhZ2UpDQo+Pg0KPiANCj4gDQo+IA0KPiANCg0K
