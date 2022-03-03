Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF14CC35F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiCCRDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCCRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:03:15 -0500
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599EDD52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:02:28 -0800 (PST)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223DxVA1013243;
        Thu, 3 Mar 2022 12:02:01 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2052.outbound.protection.outlook.com [104.47.61.52])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3ejy1xr55x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 12:02:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpM9d6w+S8ZtVRPPAWEzadEEUasVhRsHMrcdWrGuzLECYUqMhvUNoJfjyeVCRESbMZ4JtbN8jRoPzAZokodZtcedD+rJoPN3LWFHRNiaTUA16FuTn0kkgWywEZ+mykhseEyJ+4aQwZxayE9AG8jN4f042B4AqX3vnLYOD7b53t7UUEaQaLEs11OnEALZ7dtS93p98/dPLgmzoLKgOkGkbKG5/tB/6uTmQhhjHRBc4+FredA1AJqRonWr9a0d+EOu4d3czzClQzjmXjzQGdIxy9iLpjeoIKwMrPxWCNCKatln+aUcyHDC/UmCbLkudGAZxBzBHuQ+ZAsUSu/yTcxL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86vgRR8OSOyznlUcNqJr/vzT5YD+DdExjrPkE6Hny2o=;
 b=ec41X0M+zSgemu7tS2nreXiItHZGhl4IbMcxEqBeGyAnwXggdWL3r78us8lsjTrsjgkT7sBXjuOxfnKmkxBi1pWOG2Qkos6loJSLdT8Fu6ZBy+32B6g+zxYbmUvaV3NIB9AqWZ5hJeS+f/RAKvAMA7LLijBZdnZmGfjXFV+qSiA/7qucy6f8P7amQCltcSoltHUFPVMNtHGlIGBzRdU47T/WKZcXYT1oP+vkLaDQFrVxd8ODhS/NvZa3kVUT2zeMfQKF5SLdVEK2U0a9vVJk2rfB+TfsrdIN70p62q5aifghXCCAIJkrQiUN/pAqQc1jT35ZwWFR1SNrZah0oYOoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86vgRR8OSOyznlUcNqJr/vzT5YD+DdExjrPkE6Hny2o=;
 b=Ve0tokCmaTvbKPfm6kiei4Qjbp2vWVn6A9QoTYivzEtV65+P5ODGowQ8DwQ/fmi2j645eHYpUdnWAOtgRFtIsGZgxlxryTkeYENatJfGjbW/Mor3kB5PpoNoihP38Qvm6bZfFBL40s6FHg1sWthxz8kzAw5pXEacirt1sUzCX10=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT3PR01MB9233.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 17:01:59 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230%7]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 17:01:59 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "stefan.asserhall@xilinx.com" <stefan.asserhall@xilinx.com>
Subject: Re: [PATCH] irqchip: xilinx: Enable generic irq multi handler
Thread-Topic: [PATCH] irqchip: xilinx: Enable generic irq multi handler
Thread-Index: AQHYLxlhN11dl8ZbHkqV3Rstc1pj1qyt4peA
Date:   Thu, 3 Mar 2022 17:01:59 +0000
Message-ID: <32881b5e94487845874b78dd36bbb5edec683e75.camel@calian.com>
References: <2a08d6c33e95d5da5d564ed3fbddc835983ef355.1646323896.git.michal.simek@xilinx.com>
In-Reply-To: <2a08d6c33e95d5da5d564ed3fbddc835983ef355.1646323896.git.michal.simek@xilinx.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22a7caee-bef5-41a8-9ef6-08d9fd378803
x-ms-traffictypediagnostic: YT3PR01MB9233:EE_
x-microsoft-antispam-prvs: <YT3PR01MB92333D99DF4F48E596DD7250EC049@YT3PR01MB9233.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Da6qLieV1RgRpFVdlH0SdsTDeksoc2QSeDsJwcM4cA78Fl34WsTZJw7hPYf8dCpB1aSHJBe4ul2BkkmC5hs9GjVchHc7yUAvDeRLnD6HEK+tI+EfST0DGgstRIfZikqQJh4xlY/+CtV8fjUwFsZPd2tEOJu+Iw2Y4Pj440VpimRR4SXMwplnE9wGoKiyBq/1/rrs3OUez5DokDr2fpzrriamHduTJPp9LK/0ToM95xOnPApRrDH+GJtqsZf5IEc7RQyNTdXNoDDb+6oZSFzZBLtECr7mWx3ddUvpUbvrSdX5JTJq/pxttsNlHfC2gLcAc9BW4w/+PzuASeL7TK7HN7ldu+qQDCS3YipGgjxbM9G/4iwz/xbLFWge0ixMVDaw79kLwS55pr9VX70Dsz4QuBBbpOVYqvTqRuaz0e1F8Q5xCYmRa0Ld491oiGeNMFFg/5wQXVH4SOpe81Y+JH4I7Et8sRigVo0yj4dppQF5t1Yy0w7V1tB7JFSilO71ZL5dV3gXlsXceC/fooB/AnTxZ7cHoXm+G7QFuB8TV3weYgGWG5IsewWJNdS9jkgWoXTxGSE1DlXp0nclg2Y5R37Vk/wKlMcXQfOhS/4vqf77EsCq74PqE3nwf+pnXhejCbkUYKO684/vFYq/QGTl3Aj/vnKdGraxanSQqjYkSNbIN1Mj+RKBxwN8+V4iarbxu8Vc5tyhlY3IWcx4qGYXwqbCQZYjj9cJtzYpQ4NkKFYj5nE7aUEf4A/Q+iK04Bd/jGqOhSK9YjVepjZbtaIJ79uf5QCMO8nS127MggjH/JqcAhJiNF/0L0ax+xdoQwJv4dqKDsfoq02OmMJbLRUYUass3OS8dS6GSEMkGmeXR/w4HLbkUlqWzg+DjwrQ+5BPqh67
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(91956017)(316002)(2616005)(6512007)(71200400001)(6486002)(26005)(86362001)(83380400001)(508600001)(2906002)(186003)(38100700002)(54906003)(38070700005)(8676002)(15974865002)(8936002)(4326008)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(6506007)(122000001)(44832011)(5660300002)(110136005)(41533002)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THpkTVRVOVd1b0NsMHF3MWlTVnVMVkUwSm50czllZTd4SFhoVUdjNXVMM3A2?=
 =?utf-8?B?STZ0SGxIUzUrUEJpMXBMemFER3J4c0cvVmcxaHdZd3ZlN2F2YzNybHdlOEMv?=
 =?utf-8?B?NzhJcFpiTldERE9LQkJzNnBIb2ZzWVUzQjFGRTAwSEJLVDRpREM5OVoxa05l?=
 =?utf-8?B?VlVBdndCU3d6eWFpREZ0Zzk5RVk5YmRmbElKNE5QWldwSmVFV2c1TVJrSVNZ?=
 =?utf-8?B?aytUcWdVRXh0NitTNTIzV0FuOEhHQ2xYeE9PcFNULzQvMjUzT3ZUZzFsNmtR?=
 =?utf-8?B?NXo0L21RUTZqbExrUlBIaFM0UUliVlVKdlV2ZnZGVmxuak1GYllCa0J2MTNa?=
 =?utf-8?B?ei9PYWpLdUhvM1ZlR1c1WUZONlVBTW5iMEdsQjFhcjkydGtoODB0OUZBR2oz?=
 =?utf-8?B?aERTdzJab2pFbWdpeGZRcFZxK2gyVXJ6bm9xY3JGU05oN1dERVJjd3JvbmxS?=
 =?utf-8?B?RTZVY1c4dXRZOXJ2R3B0WXQ4UXR0L1NWdklWTmJCd2F6dTAwZWNOOWt2Q1BW?=
 =?utf-8?B?bXladVBYSldDSnl0MnVBQWZ3YTdNd3VadlRiaFBRTFZleFNMWlc3endpSWlO?=
 =?utf-8?B?M3Bvb2QwS0ZNZmE5ZzdwZ1FUbFZwb3VFbllCTEhPRzJYOFJpaWhEamZiQmJZ?=
 =?utf-8?B?OHdKenZNNDcwak1XcnllYXZiaGJqZjBDSFlyQUFoMkp6MDNsU1FHZWFmeUo4?=
 =?utf-8?B?VGs4OHEydkhLQWx5OU9pVzVqTXNkVWFDd2kvak9pNEphYXQ3aE5JV0Jxcnp2?=
 =?utf-8?B?ZDMwaTgxODZnU01Jc3VzYW5XQkluU241aGNENmQ3dlJVbnVRRmgyd21NRGxm?=
 =?utf-8?B?cXNtM1lxTTBDNnVhaE04MVcrbzVGR3JjZW9BdkliUzE3UmxWaWZPK1dud0ZO?=
 =?utf-8?B?VHVhdGFtSEhxWUhYaEg0VENiNlpUSU1PNy9WbmdGWlgvYnMvbDdDWTFUd2VZ?=
 =?utf-8?B?cVprOCtzZ3U4WGpZMzFxb2VnblU3ejJCZEQ3RDJBcTM3VEdUZEdzeUhsQjNJ?=
 =?utf-8?B?bUxhQmpEOWU4bzF3dDQzUzVRNnExNWc3Y3l4Y0dBZUhBNE16d092czl5dmhP?=
 =?utf-8?B?blZuM2pJdEJiSEFSV243aXd1N1VzMzlTaGc3WjJNWHhUUkFuUkFaY21VM24y?=
 =?utf-8?B?cXVqUmRzUjFjL2U0ZTJSZGNYaXJ2ZnJtZldUZSs1ME9XR0FzWnQ4U3dvZi9w?=
 =?utf-8?B?SGtiaEVmU0Z5cHpEYTE4QlorMFp2RnMvSEc1M0FPUjRSRVhaTUtlVGtwQTdk?=
 =?utf-8?B?TEV2Zzlsc0ZPL0FHejFDRndBSlFwRGFOcHk5NzU1enFZQjRsL2FxemRaWXpI?=
 =?utf-8?B?M1B5YklzVHE0VjhmazV4bTdQN092YTlpTS9sN25DT3k4dUtpT011c29DZXJC?=
 =?utf-8?B?Sm9OZThWNmlEZytyM0lSVU9HeEtuRkFRbklSZk5wR2tVWkIvUUYyQ2dxeU1B?=
 =?utf-8?B?b3Jla1FvM01FN1FLMFZWMXNDUXdlTElWejRpMHRqdW8xdlI3NFBuNlcxbHRG?=
 =?utf-8?B?RkdISmYraTlCa2NCTjR5OGxmZDJNVDRGdkV2bzlVVndtakJtdzRWOE9WaXFq?=
 =?utf-8?B?UVRFcFp6OFU0eExGQTgrSG8wMy9HSkxoWUlOOHE0d1h1SFFwTHZrTGUrMzZ6?=
 =?utf-8?B?YVd4QjZnY1hIRUpVWVpSb2FOMmZVTVFKZG9MOEI1NEFxa1lPQ2hzaEZhUDRI?=
 =?utf-8?B?bGdmSDA3NGtYRkpkVjdjS2cvMFljTm5rY2hJK0tFU1ZwTVAwaG1oV2FmbDBx?=
 =?utf-8?B?YXd5bjkxSUJHN2pOWnJyVHVRQkhwbG00ZHRvYUhMOWRzWm5TQjlqSUpSYlNp?=
 =?utf-8?B?VkxYMEZ3V0t6aEIvcjVmME13WFZnNmcrbUN1RkZHM2ZmSnNnOFZaVlNrUmNO?=
 =?utf-8?B?TzJlSHB1d2VkYUVaNHJ2cUNwUXFXeldGMjBXQTFhVTIzMFBaSG9DUjNXaElo?=
 =?utf-8?B?ZWNWMS9GRFVzZ2VWUmFmbHJubzdxZEdGN0ZmMVUvM2NsNlA4U2czUEppbU5O?=
 =?utf-8?B?V3MwQjZ3ZkdQc2h2dWxSU2JKWjFKSFltbnRrckViWnl6b202MEZNY3RmNlUr?=
 =?utf-8?B?V3ZGMFVOQ1NCclZQL0FHS3FMNHJJbjEzQ2pGQkZ0c3R2Tm00MnBTRDZTa2c1?=
 =?utf-8?B?TVZlUElxcW5xNlUxWEdBN3hYZndpSmxDcWhXSmUyMnVwMTAxZG1qOGllNXhX?=
 =?utf-8?B?dGVSamg2K2RuUGdhTFVnZlRlNVU3Nlk1ODlRSTFxdjEwVnkyQmdUT0JPM1pT?=
 =?utf-8?Q?p/HHL7wtsOO75gYh3Djw6WKal7iBa/LBtVfMUVLs5E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2BAB9F0E4E5E54EAF4ABC04496E90E1@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a7caee-bef5-41a8-9ef6-08d9fd378803
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 17:01:59.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOb1Ly4E417jx8fgla90TIHO54yn/W7W8RfYb2hfmroQL8k3u8tPO/KYnpwbGC2Q7Ah5HniMsZw0cZB2Qe/3aspyxjjPXkdhYt73MdMMztU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9233
X-Proofpoint-GUID: Ukwd1QVdCWHPH6WDgY70mH3Xc-W91o9X
X-Proofpoint-ORIG-GUID: Ukwd1QVdCWHPH6WDgY70mH3Xc-W91o9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=612 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTAzIGF0IDE3OjExICswMTAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+
IFJlZ2lzdGVyIGRlZmF1bHQgYXJjaCBoYW5kbGVyIHZpYSBkcml2ZXIgaW5zdGVhZCBvZiBkaXJl
Y3RseSBwb2ludGluZyB0bw0KPiB4aWxpbnggaW50YyBjb250cm9sbGVyLiBUaGlzIHBhdGNoIG1h
a2VzIGFyY2hpdGVjdHVyZSBjb2RlIG1vcmUgZ2VuZXJpYy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+IFJldmlld2VkLWJ5OiBT
dGVmYW4gQXNzZXJoYWxsIDxzdGVmYW4uYXNzZXJoYWxsQHhpbGlueC5jb20+DQo+IC0tLQ0KPiAN
Cj4gIGFyY2gvbWljcm9ibGF6ZS9LY29uZmlnICAgICAgICAgICB8ICAyICsrDQo+ICBhcmNoL21p
Y3JvYmxhemUvaW5jbHVkZS9hc20vaXJxLmggfCAgMyAtLS0NCj4gIGFyY2gvbWljcm9ibGF6ZS9r
ZXJuZWwvaXJxLmMgICAgICB8IDE2ICstLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvaXJxY2hp
cC9pcnEteGlsaW54LWludGMuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0NCj4gIDQgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9taWNyb2JsYXplL0tjb25maWcgYi9hcmNoL21pY3JvYmxhemUvS2NvbmZp
Zw0KPiBpbmRleCA1OTc5OGU0M2NkYjAuLmRhNTY4ZTk4MTYwNCAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9taWNyb2JsYXplL0tjb25maWcNCj4gKysrIGIvYXJjaC9taWNyb2JsYXplL0tjb25maWcNCj4g
QEAgLTQ1LDYgKzQ1LDggQEAgY29uZmlnIE1JQ1JPQkxBWkUNCj4gIAlzZWxlY3QgU0VUX0ZTDQo+
ICAJc2VsZWN0IFpPTkVfRE1BDQo+ICAJc2VsZWN0IFRSQUNFX0lSUUZMQUdTX1NVUFBPUlQNCj4g
KwlzZWxlY3QgR0VORVJJQ19JUlFfTVVMVElfSEFORExFUg0KPiArCXNlbGVjdCBIQU5ETEVfRE9N
QUlOX0lSUQ0KPiAgDQo+ICAjIEVuZGlhbm5lc3Mgc2VsZWN0aW9uDQo+ICBjaG9pY2UNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS9pcnEuaA0KPiBiL2FyY2gvbWlj
cm9ibGF6ZS9pbmNsdWRlL2FzbS9pcnEuaA0KPiBpbmRleCAwYTI4ZTgwYmJhYjAuLmNiNmFiNTVk
MWQwMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNtL2lycS5oDQo+
ICsrKyBiL2FyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS9pcnEuaA0KPiBAQCAtMTEsNyArMTEs
NCBAQA0KPiAgc3RydWN0IHB0X3JlZ3M7DQo+ICBleHRlcm4gdm9pZCBkb19JUlEoc3RydWN0IHB0
X3JlZ3MgKnJlZ3MpOw0KPiAgDQo+IC0vKiBzaG91bGQgYmUgZGVmaW5lZCBpbiBlYWNoIGludGVy
cnVwdCBjb250cm9sbGVyIGRyaXZlciAqLw0KPiAtZXh0ZXJuIHVuc2lnbmVkIGludCB4aW50Y19n
ZXRfaXJxKHZvaWQpOw0KPiAtDQo+ICAjZW5kaWYgLyogX0FTTV9NSUNST0JMQVpFX0lSUV9IICov
DQo+IGRpZmYgLS1naXQgYS9hcmNoL21pY3JvYmxhemUva2VybmVsL2lycS5jIGIvYXJjaC9taWNy
b2JsYXplL2tlcm5lbC9pcnEuYw0KPiBpbmRleCA5MDNkYWQ4MjJmYWQuLjFmOGNiNGM0Zjc0ZiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9taWNyb2JsYXplL2tlcm5lbC9pcnEuYw0KPiArKysgYi9hcmNo
L21pY3JvYmxhemUva2VybmVsL2lycS5jDQo+IEBAIC0yMCwyNyArMjAsMTMgQEANCj4gICNpbmNs
dWRlIDxsaW51eC9pcnFjaGlwLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ICAN
Cj4gLXN0YXRpYyB1MzIgY29uY3VycmVudF9pcnE7DQo+IC0NCj4gIHZvaWQgX19pcnFfZW50cnkg
ZG9fSVJRKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiAgew0KPiAtCXVuc2lnbmVkIGludCBpcnE7
DQo+ICAJc3RydWN0IHB0X3JlZ3MgKm9sZF9yZWdzID0gc2V0X2lycV9yZWdzKHJlZ3MpOw0KPiAg
CXRyYWNlX2hhcmRpcnFzX29mZigpOw0KPiAgDQo+ICAJaXJxX2VudGVyKCk7DQo+IC0JaXJxID0g
eGludGNfZ2V0X2lycSgpOw0KPiAtbmV4dF9pcnE6DQo+IC0JQlVHX09OKCFpcnEpOw0KPiAtCWdl
bmVyaWNfaGFuZGxlX2lycShpcnEpOw0KPiAtDQo+IC0JaXJxID0geGludGNfZ2V0X2lycSgpOw0K
PiAtCWlmIChpcnEgIT0gLTFVKSB7DQo+IC0JCXByX2RlYnVnKCJuZXh0IGlycTogJWRcbiIsIGly
cSk7DQo+IC0JCSsrY29uY3VycmVudF9pcnE7DQo+IC0JCWdvdG8gbmV4dF9pcnE7DQo+IC0JfQ0K
PiAtDQo+ICsJaGFuZGxlX2FyY2hfaXJxKHJlZ3MpOw0KPiAgCWlycV9leGl0KCk7DQo+ICAJc2V0
X2lycV9yZWdzKG9sZF9yZWdzKTsNCj4gIAl0cmFjZV9oYXJkaXJxc19vbigpOw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS14aWxpbngtaW50Yy5jIGIvZHJpdmVycy9pcnFjaGlw
L2lycS14aWxpbngtDQo+IGludGMuYw0KPiBpbmRleCAzNTZhNTk3NTVkNjMuLmM2NzEwMTkwYzE1
MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS14aWxpbngtaW50Yy5jDQo+ICsr
KyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEteGlsaW54LWludGMuYw0KPiBAQCAtMTEwLDcgKzExMCw3
IEBAIHN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgaW50Y19kZXYgPSB7DQo+ICAJLmlycV9tYXNrX2Fj
ayA9IGludGNfbWFza19hY2ssDQo+ICB9Ow0KPiAgDQo+IC11bnNpZ25lZCBpbnQgeGludGNfZ2V0
X2lycSh2b2lkKQ0KPiArc3RhdGljIHVuc2lnbmVkIGludCB4aW50Y19nZXRfaXJxKHZvaWQpDQo+
ICB7DQo+ICAJdW5zaWduZWQgaW50IGlycSA9IC0xOw0KPiAgCXUzMiBod2lycTsNCj4gQEAgLTE2
NCw2ICsxNjQsMjUgQEAgc3RhdGljIHZvaWQgeGlsX2ludGNfaXJxX2hhbmRsZXIoc3RydWN0IGly
cV9kZXNjICpkZXNjKQ0KPiAgCWNoYWluZWRfaXJxX2V4aXQoY2hpcCwgZGVzYyk7DQo+ICB9DQo+
ICANCj4gK3N0YXRpYyB1MzIgY29uY3VycmVudF9pcnE7DQoNCk5vdCBzdXJlIHdoYXQgdGhpcyB2
YXJpYWJsZSBpcyBmb3I/IEl0IHNlZW1zIHRvIGJlIGluY3JlbWVudGVkLCBidXQgbmV2ZXIgcmVh
ZC4NCg0KPiArDQo+ICtzdGF0aWMgdm9pZCB4aWxfaW50Y19oYW5kbGVfaXJxKHN0cnVjdCBwdF9y
ZWdzICpyZWdzKQ0KPiArew0KPiArCXVuc2lnbmVkIGludCBpcnE7DQo+ICsNCj4gKwlpcnEgPSB4
aW50Y19nZXRfaXJxKCk7DQo+ICtuZXh0X2lycToNCj4gKwlCVUdfT04oIWlycSk7DQo+ICsJZ2Vu
ZXJpY19oYW5kbGVfaXJxKGlycSk7DQo+ICsNCj4gKwlpcnEgPSB4aW50Y19nZXRfaXJxKCk7DQo+
ICsJaWYgKGlycSAhPSAtMVUpIHsNCj4gKwkJcHJfZGVidWcoIm5leHQgaXJxOiAlZFxuIiwgaXJx
KTsNCj4gKwkJKytjb25jdXJyZW50X2lycTsNCj4gKwkJZ290byBuZXh0X2lycTsNCj4gKwl9DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgX19pbml0IHhpbGlueF9pbnRjX29mX2luaXQoc3RydWN0
IGRldmljZV9ub2RlICppbnRjLA0KPiAgCQkJCQkgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqcGFy
ZW50KQ0KPiAgew0KPiBAQCAtMjMzLDYgKzI1Miw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHhpbGlu
eF9pbnRjX29mX2luaXQoc3RydWN0IGRldmljZV9ub2RlDQo+ICppbnRjLA0KPiAgCX0gZWxzZSB7
DQo+ICAJCXByaW1hcnlfaW50YyA9IGlycWM7DQo+ICAJCWlycV9zZXRfZGVmYXVsdF9ob3N0KHBy
aW1hcnlfaW50Yy0+cm9vdF9kb21haW4pOw0KPiArCQlzZXRfaGFuZGxlX2lycSh4aWxfaW50Y19o
YW5kbGVfaXJxKTsNCj4gIAl9DQo+ICANCj4gIAlyZXR1cm4gMDsNCi0tIA0KUm9iZXJ0IEhhbmNv
Y2sNClNlbmlvciBIYXJkd2FyZSBEZXNpZ25lciwgQ2FsaWFuIEFkdmFuY2VkIFRlY2hub2xvZ2ll
cw0Kd3d3LmNhbGlhbi5jb20NCg==
