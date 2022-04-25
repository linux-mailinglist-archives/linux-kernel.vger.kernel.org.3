Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906E150E3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbiDYPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbiDYPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:03:54 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189052AED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:00:49 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P9cIPe005229;
        Mon, 25 Apr 2022 15:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=M55foqo+wK1hJQH987n36SHwMGpdS/f7Z5ehY3LmriM=;
 b=C0nnJoUcb5+djk6g7JmbOXTivr6ljpenVBoXvTOMvDztI/AbpVosGcmuoEf1Rk3FKtrF
 G8MHaIh6yduL+3h1QwG8xbl//ng6Oy27csemvem0IOe6T4ccnJMG09Z5ozAq8wadlIQC
 f0QrbaF9gVKszVEdDkZ2ybB79vFiHuOvvQi346eUWrXPzzWAfXlHUF9QjDFPDoHyqspw
 sTA8C+Z2X9dJ/+n+0VRxCVmy/dWFvF2m30n0ckTDK/Cskx3mQPcgQY7HeSfatn580P8A
 qKI/RgLwlN6FDn3Isq+ab2liAil0gX7AKFIVigfdwTfGGMvnPX8ofHgFNVkj995IXcHO 7w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fns6fk1vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 15:00:07 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 957FC13084;
        Mon, 25 Apr 2022 15:00:06 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 25 Apr 2022 03:00:06 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 25 Apr 2022 03:00:06 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 25 Apr 2022 03:00:06 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e64u8uo1lwCn18HzAdM/ECTw+9ZyiLKF0aQEfKveTLiYXg/2234LT/Ag2sg1fi7KZDytV6SHTUynpDOgByGUWv2XELUFsBO0IprO4dsgQkciQP5UdbsnBQIUUShBpbwdJfZYkWtelY07Y/UI83+kifaklfdG41OFy9BkyME/ncSJCICJ/DtFqW/EqBF0RcgAdL8hP61VvkRdneQvmuuzYJ8dnPbedPaQyXiXH8sbTUFPAPBZqvsVQ/6sZup56H8lA36iizlHI+VlckieX59Kjf4p70ID/o9asetNHKSIandAOsO8wjLy8niuD50cZsg5cEvI5OpayOhhs6jV7JVvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M55foqo+wK1hJQH987n36SHwMGpdS/f7Z5ehY3LmriM=;
 b=hD7OVo2X4/2J4ksT1lHUbwMG/9O6dsj4h+By5S4S5PXl10zrpKZAqi4mQMMrq+IrjVDzbByGt+GsgQlhVKe6NgXsh45dm9zY2ONBanFOm5K1sbK7qU9Y/D02e9gG1ZNPmlg38oaOXbBEjqLH6ktOM9b5BFxrTXCiobZSnHkTFQOWPaYblRd2O1BE2MHF8DLwUCt/O77egkeUUpz5jfKnkLXpAIEY8pn+R3Vn+TdAV7N9qRai9o+myKda6B2pxsEQo4UNHkY8wlc+TlpkaGpfW0Sdj+czvtX1rKbMM0/4mUQEumKXyszBlKRPd8DE1p33p88o+F0cLyCGNThVTja+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 15:00:04 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:00:04 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC:     Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 01/11] aach: arm: mach-hpe: Introduce the HPE GXP
 architecture
Thread-Topic: [PATCH v5 01/11] aach: arm: mach-hpe: Introduce the HPE GXP
 architecture
Thread-Index: AQHYVbTMAvJPhcL2FE+YX4J/HnMQs6z9WIWAgANh3eA=
Date:   Mon, 25 Apr 2022 15:00:04 +0000
Message-ID: <PH0PR84MB1718D38799A276CC8EC71AED88F89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <12902220-5f5e-4dea-1a64-da2c76d79e0c@linaro.org>
In-Reply-To: <12902220-5f5e-4dea-1a64-da2c76d79e0c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f976f0a-d3c1-4149-e3ef-08da26cc4793
x-ms-traffictypediagnostic: MW5PR84MB1356:EE_
x-microsoft-antispam-prvs: <MW5PR84MB135663A3A84A32C28EC83C2488F89@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3StDHUCGt2iOyTPLFndlGYunBHgXZmZAN8j0xv3bFI9i0yz3YhXj3yQfMrnDz03Srnp6b/jT4rxYSNjL2WH66lfTe/vxgOBT2Q2lQNsRGGXEUkuZzwawkdZdhQHubk88yc9aiCX1r7cyz0xSyrQlh8DRPWPPj4FgFjnKysGQwIGi9Hvrh/FcqYurrJgAB35HRNfMcuKkv3BcQ5/0enC38AQOiYbq4ydel2EyblCrWtOVb3kFYH7mVjYeL/uoW4YElcRnXQXLS2Iw9nAblQYbeO3nQxaLbejza7RZCM7lKQsF0uv02USy4rHUD1xQpA4lBRFCmyMnsG5nzfN/t+mIeaIn6IKbxTzIxneVJUa5sk1jsXJCVrMOyr9lIAp+5Rb5vhsrpB0JZJ3uAuo2g6E45/vxibhVe1o7Hqdp6ahLZMFX/RSYs04gMFcypF+oCXYiAWtzzsrSlUxW9TmTG1VNvXakhLZ/msJAhzEV7E3Ld0l5z8nRS6wFYLJDKVcwg8NiHJ7AEddseTtDvbY4arTqzY8hj3DINwN2h37TmHT3sBM1HSSWjOh1LPNEx/PYdA/xEceX6O2lrVnhixTMj/sMKFzsTO0le9Ul33fcIctoXGvxJefC7QiJt6YSq2qtxbUbBao+VQVIzm9Ombgwb4YKXiCpWNBYCijIH3DlZYKyNIsjUGJTmIHjAmb+njkI6kck6FBkCaSL7l8t9JAiPNCgzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(55236004)(26005)(186003)(9686003)(71200400001)(54906003)(110136005)(8936002)(53546011)(7696005)(6506007)(4326008)(55016003)(33656002)(508600001)(86362001)(5660300002)(66556008)(76116006)(38070700005)(66446008)(66946007)(64756008)(8676002)(66476007)(316002)(38100700002)(83380400001)(2906002)(52536014)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHNHUElaaHR6UExSWTNvN3h5d256ZVk3bFQyc3lJMU9Hc1dKczZSVXVQcUE2?=
 =?utf-8?B?RHVtWk40VG1qc3JEUUhMR0w1VXZ4OXU2YTlZbUl1K3p6eVc2ZHZZSk91V2Fr?=
 =?utf-8?B?OXU5bzRySXp5ck5xR1BuMHdQUk1QblgzU2xkaTdKR1YwQ1YrRURwa0RZQW4z?=
 =?utf-8?B?cTBQZTN1dkJyZU93a1ZGbWtmTzJVUFdZSU55c2FCU3ZUa213UXk5RGJlUktR?=
 =?utf-8?B?aTVtbGhhT0lxbVlXSThkMXhacXVsV0tKUWl3eFp2VUx0N3BMeWRjaHlYNHFP?=
 =?utf-8?B?ak5JczI5R0dIeW9CR1ozS2hKQ2ErTnozRnFnaEZYNTBRWU5jWUNsTnZDYUJ2?=
 =?utf-8?B?VVhORmIwOHNoOE5SelFYaXdGNkRoRVp5eGpJTjJIdy96eDgrOHdFOHNLV3RX?=
 =?utf-8?B?MFpmVHJyZTFTblZESUFPQW9zcVlObnF1UzIydzBpdXJrN25jc1J1c3ZUTUVs?=
 =?utf-8?B?TzJEL0lScDRPUlEveFRrUDJxQlVGajdIUjltUmZKcVd0MmFHR3d4Q2RFV1VF?=
 =?utf-8?B?SHZHd1lxMkh2dlVIQ0Y1KzZxeEdIVlpUVFhtNWJtWWpuMWh2UlVTa1FQaDNO?=
 =?utf-8?B?UlpSM3NMdjNMOW9ZVUFVWnlId1lSRWZtWWgrSVFDbjBtUm9OTDR3eWltT3hu?=
 =?utf-8?B?NS95bHVxWmhIUWVqZ2ZoL0F0UmY3NmFKTU5EQjhiSXFuQ0hSRzNsRmtwcnNX?=
 =?utf-8?B?WG95Vm9JbC9VUTBUNUxBZDhTd2t1dDZ4MmtYMGZQYStDTGMvaDk0ZnZaSk1J?=
 =?utf-8?B?UnJhTFM4QVgwYWFwdjg4V2E0Zkh4SnNJRWlqZ0laM0R1SEpDVmdseUVvcTRH?=
 =?utf-8?B?NVIwZm9sbDhmSDlFT2l5NEpjVWRlSnNDdmdkQ0tFWDhDVTdHRDFmQ0o0MDhZ?=
 =?utf-8?B?bWZmLzVOZHpYNzNOWWJnaysvMXc3NU1SUXVPM2svK3c5WGVtUXA2NjBHMUN3?=
 =?utf-8?B?a3VFbUMrNU5hdGZ4UXlxbHRIUFE2a2ppWUt5TTBDSG4rQmpUV1JWV1h3Q3Zv?=
 =?utf-8?B?SEoyMnArcy9nWnppK1N0Q3FIZWQrQVFaQkNqNlZ6UHFYS2Z5OGh6UEZaYWVw?=
 =?utf-8?B?dTBFdlFRZUhDQnNwcytHNjR0YWhIZ01WdFR4VmlaaUVkejI2dlFNY2EyNGpL?=
 =?utf-8?B?THN5UjRKTHVtTnJPLzNUSzRjUXp4cUVGd3EwbGNQTURzb2lCUlhYZWFhdWdM?=
 =?utf-8?B?V1dqSGRJa2wyY29FSms2Y1p1ckZuNnB4QUxNR0xaUkVDdTZxeFFWTjhIRHZq?=
 =?utf-8?B?MXAzeFhRdEpHTElPcU9DazI0ZnNicWhRcFkwb2lVd3hGWlFLTnh5L1hISzg5?=
 =?utf-8?B?L2Q0eWJNN3M2anRvYk1xT1RlcVplZWZzb0xrd3Z3N0RMTmp3dDlYaGwzbE1C?=
 =?utf-8?B?Ti9GemlIL25GQzk2S0swMDdSWFVnSUxPbm9ycEJJOFdmZklNRU1Wa3IzVGxI?=
 =?utf-8?B?OElrSWkrUUZsQ2doVWg5THV0UytMMDVQNFZOaFVGVjFMRGNJQ1ZSM0U5Q29v?=
 =?utf-8?B?aHRVSUo2VTgxZGlEdzdkRzdkdXdkUHh0SjJaVzNKTGhXTG5QNW0zZk1NMTNJ?=
 =?utf-8?B?MmQwbVQrNEc4enB1ZVJyc1ZvWWVqb3dXRDdPRUN3OTRNQnBsWm9hY0Mvc09G?=
 =?utf-8?B?bVFZZG1uK3RTR1NGR1VPYzRsc1ZHdDJ3NzhhTEVqdCtRQkJ3REZZK1l4Z21q?=
 =?utf-8?B?ams5V3NMWUd4T3lxYTRwTDcvMmR0dzdBVGpqbXJUOEo5QWt0Mkp5QUQwT1ln?=
 =?utf-8?B?MENJb2hjQkxsZWdmQnFsSmxBd0RrK1BqRjZOOTBrWFo3Q0RPWS9BMXEyYkFj?=
 =?utf-8?B?K2l6VGFNNENERERUYXcrMENNWGtGa0pXMGRYSHpJNGdIQ1FicEZ2aXlnS1Jn?=
 =?utf-8?B?TGZXUkZFOHd5dDA0NTZqcXg5aUFoczRmUXZHYW0wbFZWcDFKRXd3Y0VDVWJC?=
 =?utf-8?B?c3BCUG94S1N3cjVrS0FTd2x4OWFNUXVHTEwyME51UVFzLzgyWGRJcTF6MDM5?=
 =?utf-8?B?eXA4MVg3L2ZUS0NTQWZKT0J4RWhpVXhFdkNtUXVrWFVESG8rdEdqR201ZWgy?=
 =?utf-8?B?V01FeEF5MzFJYzlkOG85Zkp1MnNqUWZGQzRjd0tLNkZPa3p4cThuWHZ2RXcv?=
 =?utf-8?B?ZitNYWpwRDJSczFQQkxSM2RjSjI3Y01NQzU1R253cXhkRXl0YWwyczlQYys2?=
 =?utf-8?B?RVpqQWlCZzcyRW8xMTI2ZVhwVnNzVS9sd1ZLVFk3VkpsUVBveldsSVZqRTBK?=
 =?utf-8?B?cGpWRDkzT1R4YlEvUEJnWHB6Z3A2MDkyZ3Fjd25DWFVpZU5CclY1R3pHU1Yv?=
 =?utf-8?B?S01xclJvMUpXc1h5Y2x2VXo1Skphb3FYNzI0d1g3bnJWS1ZObzF0dz09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f976f0a-d3c1-4149-e3ef-08da26cc4793
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 15:00:04.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3H6X/MM2f1qhOVPAu1IzU4nIRCLow6xZJzYAtGextlSTpoAQqazugj6i/qqWh+rSip6YtSv7hwLijitUBWywg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1356
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: TvrcPNUGEXLW8YLx8PSWDUkF6uNTwdxX
X-Proofpoint-ORIG-GUID: TvrcPNUGEXLW8YLx8PSWDUkF6uNTwdxX
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=875 clxscore=1011
 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250066
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IFttYWlsdG86a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnXSANClNlbnQ6IFNhdHVyZGF5
LCBBcHJpbCAyMywgMjAyMiA2OjA1IEFNDQpUbzogSGF3a2lucywgTmljayA8bmljay5oYXdraW5z
QGhwZS5jb20+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29tPjsgam9lbEBqbXMu
aWQuYXU7IGFybmRAYXJuZGIuZGU7IG9wZW5ibWNAbGlzdHMub3psYWJzLm9yZw0KQ2M6IFJ1c3Nl
bGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTog
W1BBVENIIHY1IDAxLzExXSBhYWNoOiBhcm06IG1hY2gtaHBlOiBJbnRyb2R1Y2UgdGhlIEhQRSBH
WFAgYXJjaGl0ZWN0dXJlDQoNCk9uIDIxLzA0LzIwMjIgMjE6MjEsIG5pY2suaGF3a2luc0BocGUu
Y29tIHdyb3RlOg0KPiA+IEZyb206IE5pY2sgSGF3a2lucyA8bmljay5oYXdraW5zQGhwZS5jb20+
DQo+ID4gDQo+ID4gVGhlIEdYUCBpcyB0aGUgSFBFIEJNQyBTb0MgdGhhdCBpcyB1c2VkIGluIHRo
ZSBtYWpvcml0eSBvZiBIUEUgDQo+ID4gR2VuZXJhdGlvbiAxMCBzZXJ2ZXJzLiBUcmFkaXRpb25h
bGx5IHRoZSBhc2ljIHdpbGwgbGFzdCBtdWx0aXBsZSANCj4gPiBnZW5lcmF0aW9ucyBvZiBzZXJ2
ZXIgYmVmb3JlIGJlaW5nIHJlcGxhY2VkLg0KPiA+IEluIGd4cC5jIHdlIHJlc2V0IHRoZSBFSENJ
IGNvbnRyb2xsZXIgZWFybHkgdG8gYm9vdCB0aGUgYXNpYy4NCj4gPg0KPiA+IEluZm8gYWJvdXQg
U29DOg0KDQo+IEhhbGYgb2YgeW91ciBwYXRjaGVzIGRpZCBub3QgbWFrZSBpdCB0byB0aGUgbGlz
dHMuIEZvciBleGFtcGxlIGxpbnV4LWFybS1rZXJuZWwgaGFzIG9ubHkgMSwgMiBhbmQgMTAuDQoN
Cj4gV2hlcmUgaXMgdGhlIHJlc3Q/IEFsbCB5b3VyIHBhdGNoZXMgbXVzdCBiZSBzZW50IHRvIGxp
bnV4LWFybS1rZXJuZWwgYW5kIGxpbnV4LWtlcm5lbC4gVW5sZXNzIHRoZSBsaXN0IG9mIHBlb3Bs
ZSBUby9DYyBpcyB0b28gYmlnICh+IDEwIHBlb3BsZSksIGVudGlyZSBwYXRjaHNldCBzaG91bGQg
YmUgc2VuZCB0byBzYW1lIGFkZHJlc3Nlcy4NCg0KQXBvbG9naWVzLCBJIHdhcyByZWx5aW5nIG9u
IHRoZSAiLnNjcmlwdHMvZ2V0X21haW50YWluZXIucGwiIGluIGEgc2NyaXB0IHRvIGdyYWIgYW5k
IHNlbmQgZW1haWxzLiBJIHdpbGwgZW5zdXJlIG9uIHRoZSBuZXh0IHBhdGNoc2V0IHRoYXQgbGlu
dXgtYXJtLWtlcm5lbCBhbmQgbGludXgta2VybmVsIGFyZSBpbmNsdWRlZCBpbiBhbGwgb2YgdGhl
IGVtYWlscy4NCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssDQoNCi1OaWNrIEhhd2tpbnMNCg==
