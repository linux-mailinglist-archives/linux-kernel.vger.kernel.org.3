Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6064DB934
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353663AbiCPUNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356732AbiCPUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:12:57 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D74E674C2;
        Wed, 16 Mar 2022 13:11:42 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GIu2AH026044;
        Wed, 16 Mar 2022 20:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=BvNeaUU6oSSrsYcB0y4zMrehSPL/QqgNp9qaUBmsV6k=;
 b=LUq7RZArGFbQW8Lt8m1yaXEL5djcsjIW2o1OoSnqXOgOy7nw8dEAT9l+LVgJFnRI1i54
 4OyNc2dJirvPu9WyuJ9f9EZ4+iIIAIwRqz1KuCGM0p0JJU1xj6SPOxvb7d0tGOeN53Tm
 K/Q35adT+6G51c5a3b1oJwkd1lxcGBzaJ7Lc4v/wojfoGpkGLyruvFMLUUbwiIiIg75v
 /kJ/jasd24S/YFjsfReg5RgebYxjr1bo/SEeUMnOCOhtopPkEdfQiWK3lbHtpcTnOHae
 gb7DCdgIR+3wg/xnpAjxZaiTIre1hJw4bpIxA6r8nb2cSMsit5U/GAxxRWqYlwhQIy6R +Q== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eunkp8r00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 20:11:19 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 72DB174;
        Wed, 16 Mar 2022 20:11:18 +0000 (UTC)
Received: from G4W9334.americas.hpqcorp.net (16.208.32.120) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 16 Mar 2022 20:11:17 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G4W9334.americas.hpqcorp.net (2002:10d0:2078::10d0:2078) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 20:10:56 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 20:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSIHx62Am3i0a52IZ01qZbss+bEsnRqCxZGuqUamTUNwhsUHV+fs2+VbX8zYOzJ/j7LEPlzkWXBucfr0Ika6Bjf3IJUSmnfHhQOqTwViWPc9kJ82joPxDltXmxbm3aSR66zEdV4D/6/rymUzV5utcah3oeIFr96Cp4WD/rbnmFX6OMwfe6OtrDqc5+0OFI3fV+88GF6/Ds8ylrMOP3JuzRzSFlc2dCxhpeVp+0dwS/dMdcXKa52IMo+HkClXs3WMc7qWMy00BHb8I6OauWzZ7oqAcp8btrU+f9egJw+AEOKVSMrzQtN8v0yxCd36rskySZdNJZ7cg7trXBGGTv69UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvNeaUU6oSSrsYcB0y4zMrehSPL/QqgNp9qaUBmsV6k=;
 b=HAxO9zBE0ksUGSsIOF7QxLAnZlz/sqOuRe8LBB5MVkg0qqDGMiIkEqopkw7uKKExPeThhwBMpDOKycCtR+Ea2N8zUc//P+hiAwoa3MpsQPWDbFZ+TEh7yeFdkMcEOU+SW2mbX1w1mA8x/y4Lx1wjdgYFJGXptqlfE3pvzdF9RGQjSUVzEj8KnYIfqi1vNn7lA/GeggtUh0eT1aQiYor58AKKPRcTaKmGgiKX4ebim6LdRVWHyW5y16h08G2UlK+nkqy2ZNwooWlG3anCzw4Q0Bs3BQkl0cVlJ9KO+t+AggPPsH6N05av/kEgqeNrvsxgapVv0nKdpCrnYLAOOxw8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW4PR84MB1370.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Wed, 16 Mar
 2022 20:10:54 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 20:10:54 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Topic: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gw
Date:   Wed, 16 Mar 2022 20:10:54 +0000
Message-ID: <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
In-Reply-To: <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a86448a-d38d-4f09-43ee-08da0789136e
x-ms-traffictypediagnostic: MW4PR84MB1370:EE_
x-microsoft-antispam-prvs: <MW4PR84MB1370103135DE046BEE795F4D88119@MW4PR84MB1370.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lnekwu1xHtlqhw8cll13l9xxmZ64RaVVNTVNyCP+xw17a+0AA49jAgM6MjAzjxj0RtIgf6j2lBPuzLh7s81+g7/IiBC3SHyrPjjAAV8XeT1nQK1JXfiCZwefAIV5K4FGSTvaPiwocTNMqHM1oKX5jhB97R8/LhN9rH61NVXLdFZ6hq/a+c1yGoXCKF5NhIVmDR/TxD+a2/vPSnL6z8uJ3rqI18n26Pfi48UoAQwGm4BAgrwpzjXgSv8JlqcqYFHqbWicEL23cWW1g36UwAeTQhorQt8dhWDdoY44IpI4hyo5cx9jIOjvQwAcANvMN+7GCKbehy7C1cCg+fRgHSzC1xCq8eg68kGXH2vsV0OrOAFGsmlR/8l9z1Uqa2yZ9DkBIxPZCyFw3F6Ui531wzfuqMuH8HxftUBDjqinh2/oZF1gC5kHNrip1g13LBnGuSZAVc9LsK0RDjeiesjABnE8YZJCHL7GpOPWJKPdxe41UOMab/Va2jCD7bM+hGqNgyMYXTsT9uUnNIIojvYdMSJXl0+2tdMysjx05slD5Dn1AygfV/R9MBwdY1n9Cq9Ks76k4VkeFkPpb2Jubqb3GsqvTqtu3WV6vINFzjhe+EU5vt+ThfsaNaqzL5JBv+mEplJY+lh6uIveL9QitIYOL8SZGHZzjCFZU8g3BhCA+3abgLYRYY+9aXIxT2uYMT0h7lf27eYuHRl2/+MKeAA59HLJoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(76116006)(52536014)(64756008)(508600001)(38100700002)(66446008)(2906002)(6636002)(66476007)(38070700005)(33656002)(54906003)(110136005)(66556008)(316002)(7696005)(55016003)(83380400001)(5660300002)(86362001)(9686003)(122000001)(26005)(4326008)(186003)(8676002)(66946007)(8936002)(55236004)(53546011)(82960400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXFUTDA3djlEb3hVUkVBaVFiL2s1azVTbi9pYldJcTVHbWd2NHU5NDBGb0Fw?=
 =?utf-8?B?ajZWaWlITTNxa1ZpQ21VK05jWkZyOU9sS2QwNlpKL0NmWlREbmVKOGF0WWJy?=
 =?utf-8?B?dW4wSmNuV1B4L2tpd2VMSGlhSkVnQVkxbEhjTnNPVEV0VjFKSXM3RUd4Wmp0?=
 =?utf-8?B?TGNyYmFDWGNHWmlmU2ZEb2llNUhNSEJldWNUVEptODVnRUlFV2M2eExmZDhy?=
 =?utf-8?B?L291djJrVTJwdi9UZjNIRXY4eHhEUVIxRVVsRWY1OXBqdmRkM0U5YTBqRkVS?=
 =?utf-8?B?UkZTWUI5ZE4rMlZHR3c1Qk40azdtTStObWNsTWlnUmRYS00rNGFPZ3BUWmVE?=
 =?utf-8?B?YXpZZHRpNGE4NS9rVStVZENaMVZNSXFHSkx5VXIxT1FKNkV2V2VSQkFRUTVH?=
 =?utf-8?B?V2QyZlM4b1VNZ3c4N2ZGNFNneFFla3BYeUFjMmp6TTBhVkwzKzZCSEpJSUZM?=
 =?utf-8?B?ZzhEV3JNNFJ4K3NWczQ0UCtGK3ZObnFKdkJiY1pQMUZrd214WVUxbmdJanRl?=
 =?utf-8?B?b3hzSlNlbkp5L3B4Q3R6Sm50a1lkRTNDT2NvREsvTDJsTjVFOWJCTklHam5t?=
 =?utf-8?B?cUp6bDJEVERpa2h0UWNHY1h0MVVBSnk5UTZBdE1GUmFSNXJzbEZudTduQzhT?=
 =?utf-8?B?UEZkSVBQeFhKOEJQemk5MHFSQS9wRHg0RVZ4TWk1ekVCdjNiT29HVW5tcEF0?=
 =?utf-8?B?R3pvMVdSbnNxNlN3c0VnS3pUYUxlbTVmVVBHVU15VmRQMzBnVGwxRTFyYldY?=
 =?utf-8?B?eEgzczl3SlVaUURLUzhRYXJsVStIZkcwNFZQYlRMNUVrSnQ4Y1RrRDdWTXhK?=
 =?utf-8?B?OXhVeGtLaHlLVnZZVFB6amRkMjkwUDd0ZGlXNWRsNGhZYVZlUWNUNTdoK0I0?=
 =?utf-8?B?VlBRTUFLdENHdUJ2bWlIREhneGdQR05YLzRLMWt0S3Vha3dBMUJnVGJOY2Ru?=
 =?utf-8?B?UXp0NklXZEdXZXI0ZWZyS21zYUxueGdNTXJjU09lVUhndHA5aVhBMEFwcGFG?=
 =?utf-8?B?c2F0c1F3SFhnbWhNUkJpak45ZVBRa29UTUxkTDZ2V2VVaWtnNnNFQjh2ZFJM?=
 =?utf-8?B?Z0pwdHIveGdsdjlXamFFcDJZbmtkaFZpdGlVQmdTY0pOQlB4cU1uQnpjeG1u?=
 =?utf-8?B?aTBtdTNJUmozdnBDcFZrU2VZQ255WGprc0I0Mzh3cy95cEZ0YUlwTWN3bngy?=
 =?utf-8?B?ZkRyUVM1RVVQOEpOVjhLTVRNY3JUc0JpbWg2cDE4dExIZndlVmNpZE9pUldu?=
 =?utf-8?B?cGxJVVFhdktOWm5aenZTMlZ0dGlwRWVNZ3lRbFBEUDNxaFJzWi9MNkpZUXBG?=
 =?utf-8?B?dGhnTTl0Y3phOGl4UDZMOVlnclpiOVp1Mm5LRytOSUZzL2d1cUdZa2k4UE9p?=
 =?utf-8?B?YmIvYlFhaGx2Y0RETEVETjduRVFlajdQMDYzUkpqb0FublBBdzZWRzMwZFdM?=
 =?utf-8?B?UE54TnNhZUlwbUI5UW9kQkdhN0NKUjFud21kT3ByWVFVbGpENnhSMHBPNjBO?=
 =?utf-8?B?VWNrQ1grQlpEOG9aRUNjSlQ1UWN2U05Vbzk4SmpacitwL0tQWU8zcFdic1lt?=
 =?utf-8?B?SVMwMVFLQlJQRm54UE1VS1ZzYWh0Rkp6dzA1N1l5MnVpVzFOUE9OMjhha3ZS?=
 =?utf-8?B?SGhwRlBLZWY1ZzFkTm9vZk8rekpMZU5teFZMZjZaMjJUZFY1ZFJTa2NJTk11?=
 =?utf-8?B?V1VzZUh2Y0QvOGR1dHJibnRYV2JGR202b1QzSVZQU21sK2xPNllHZEpCekE1?=
 =?utf-8?B?aVBmQ1FsNDVoUFh5OUp6WUJqR3Zib2hMVjd4WWZEeVNoRE42cDVFSitRRGhN?=
 =?utf-8?B?VDRSTEc3M05GSGFoKzR1NWpjbTJoOEhKYU5TMVFqTHNodWR3Nk1rUnhrVnBE?=
 =?utf-8?B?OXR2ZzM5NXdIK2lkMDBuQnhMZVFYSVNKS0s1MGx3RnBZQktJaWNkWUZxL21i?=
 =?utf-8?Q?anQRSxCoR2Ddydk+Hm1vCdKqgntj57W2?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a86448a-d38d-4f09-43ee-08da0789136e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 20:10:54.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbfkEquuCIEChvYQaUPqGH2FDztc2KZfl7Bm6Qs778DskWmliYXt6MR0SgVwAU7tzHp67H1eHeouyYU4Bt8vmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1370
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: _aBuUhrcEgIBOMY0DyYdY-KTvF4i4WK9
X-Proofpoint-ORIG-GUID: _aBuUhrcEgIBOMY0DyYdY-KTvF4i4WK9
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160121
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgW21haWx0bzprcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb21dDQo+PiBTZW50OiBG
cmlkYXksIE1hcmNoIDExLCAyMDIyIDQ6MzAgQU0NCj4+IFRvOiBIYXdraW5zLCBOaWNrIDxuaWNr
Lmhhd2tpbnNAaHBlLmNvbT4+Pj47IFZlcmR1biwgSmVhbi1NYXJpZSANCj4+IDx2ZXJkdW5AaHBl
LmNvbT4+Pj4NCj4+IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPj4+PjsgT2xvZiBK
b2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0Pj4+PjsgDQo+PiBzb2NAa2VybmVsLm9yZzsgUm9iIEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4+Pj47IA0KPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgDQo+PiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA5LzEwXSBh
cmNoOiBhcm06IGJvb3Q6IGR0czogSW50cm9kdWNlIEhQRSBHWFAgDQo+PiBEZXZpY2UgdHJlZQ0K
Pj4gDQo+PiBPbiAxMC8wMy8yMDIyIDIwOjUyLCBuaWNrLmhhd2tpbnNAaHBlLmNvbSB3cm90ZToN
Cj4+Pj4+PiBGcm9tOiBOaWNrIEhhd2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPj4+Pg0KPj4+
Pj4+DQo+Pj4+Pj4gVGhlIEhQRSBTb0MgaXMgbmV3IHRvIGxpbnV4LiBUaGlzIHBhdGNoIGNyZWF0
ZXMgdGhlIGJhc2ljIGRldmljZSANCj4+Pj4+PiB0cmVlIGxheW91dCB3aXRoIG1pbmltdW0gcmVx
dWlyZWQgZm9yIGxpbnV4IHRvIGJvb3QuIFRoaXMgaW5jbHVkZXMgDQo+Pj4+Pj4gdGltZXIgYW5k
IHdhdGNoZG9nIHN1cHBvcnQuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEhh
d2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPj4+Pg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICBhcmNo
L2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAyICsNCj4+Pj4+PiAgYXJj
aC9hcm0vYm9vdC9kdHMvaHBlLWJtYy1kbDM2MGdlbjEwLmR0cyB8ICAyNyArKysrKw0KPj4+Pj4+
ICBhcmNoL2FybS9ib290L2R0cy9ocGUtZ3hwLmR0c2kgICAgICAgICAgIHwgMTQ4ICsrKysrKysr
KysrKysrKysrKysrKysrDQo+Pj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTc3IGluc2VydGlvbnMo
KykNCj4+Pj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2hwZS1ibWMt
ZGwzNjBnZW4xMC5kdHMNCj4+Pj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3Qv
ZHRzL2hwZS1neHAuZHRzaQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgDQo+Pj4+Pj4gaW5k
ZXggZTQxZWNhNzljOTUwLi4yODIzYjM1OWQzNzMgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4+Pj4+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9NYWtl
ZmlsZQ0KPj4+Pj4+IEBAIC0xNTUwLDMgKzE1NTAsNSBAQCBkdGItJChDT05GSUdfQVJDSF9BU1BF
RUQpICs9IFwNCj4+Pj4+PiAgCWFzcGVlZC1ibWMtdmVnbWFuLW4xMTAuZHRiIFwNCj4+Pj4+PiAg
CWFzcGVlZC1ibWMtdmVnbWFuLXJ4MjAuZHRiIFwNCj4+Pj4+PiAgCWFzcGVlZC1ibWMtdmVnbWFu
LXN4MjAuZHRiDQo+Pj4+Pj4gK2R0Yi0kKENPTkZJR19BUkNIX0hQRV9HWFApICs9IFwNCj4+Pj4+
PiArCWhwZS1ibWMtZGwzNjBnZW4xMC5kdGINCj4+IA0KPj4+PiBBbHBoYWJldGljYWxseSwgYWxz
byBpbiByZXNwZWN0IHRvIG90aGVyIGFyY2hpdGVjdHVyZXMsIHNvIGJlZm9yZSBDT05GSUdfQVJD
SF9JTlRFR1JBVE9SLg0KPj4gDQo+PiBEb25lDQo+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaHBlLWJtYy1kbDM2MGdlbjEwLmR0cw0KPj4+Pj4+IGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaHBlLWJtYy1kbDM2MGdlbjEwLmR0cw0KPj4+Pj4+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+Pj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kYTVlYWMxMjEzYTgNCj4+Pj4+PiAtLS0g
L2Rldi9udWxsDQo+Pj4+Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaHBlLWJtYy1kbDM2MGdl
bjEwLmR0cw0KPj4+Pj4+IEBAIC0wLDAgKzEsMjcgQEANCj4+Pj4+PiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4+Pj4+PiArLyoNCj4+Pj4+PiArICogRGV2aWNlIFRyZWUg
ZmlsZSBmb3IgSFBFIERMMzYwR2VuMTAgICovDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsvaW5jbHVkZS8g
ImhwZS1neHAuZHRzaSINCj4+Pj4+PiArDQo+Pj4+Pj4gKy8gew0KPj4+Pj4+ICsJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT4+Pj47DQo+Pj4+Pj4gKwkjc2l6ZS1jZWxscyA9IDwxPj4+PjsNCj4+Pj4+PiAr
CWNvbXBhdGlibGUgPSAiaHBlLGd4cCI7DQo+PiANCj4+Pj4gTWlzc2luZyBib2FyZCBjb21wYXRp
YmxlLg0KPj4gDQo+PiBXaWxsIGJlY29tZSBjb21wYXRpYmxlID0gICJocGUsZ3hwIiwiaHBlLGJt
Yy1kbDM2MGdlbjEwIjsgSWYgdGhhdCBzZWVtcyBva2F5IHRvIHlvdS4NCg0KPiBZZXMsIGV4Y2Vw
dCBocGUsZ3hwIGdvZXMgYXQgdGhlIGVuZC4NCg0KRG9uZQ0KDQo+PiANCj4+Pj4+PiArCW1vZGVs
ID0gIkhld2xldHQgUGFja2FyZCBFbnRlcnByaXNlIFByb0xpYW50IGRsMzYwIEdlbjEwIjsNCj4+
Pj4+PiArDQoNCiguLi4pDQoNCj4+Pj4+PiArDQo+Pj4+Pj4gKwkJdXNiMDogdXNiQGNlZmUwMDAw
IHsNCj4+Pj4+PiArCQkJY29tcGF0aWJsZSA9ICJnZW5lcmljLWVoY2kiOw0KPj4gDQo+Pj4+IEkg
dGhpbmsgb25lIG9mIHByZXZpb3VzIGNvbW1lbnRzIHdhcyB0aGF0IHlvdSBjYW5ub3QgaGF2ZSAi
Z2VuZXJpYy1laGNpIg0KPj4+PiBvbmx5LCByaWdodD8NCj4+IA0KPj4gWWVzIHRoZXJlIHdhcywg
SSByZW1vdmVkIHRoZSB1c2IwOiBlaGNpQGNlZmUwMDAwLiBJIHNlZSBub3cgdGhhdCB0aGlzIGlz
IGluIHJlZmVyZW5jZSB0byB0aGUgY29tcGF0aWJsZS4gVGhpcyBpcyBvdXIgZWhjaSBjb250cm9s
bGVyLiBXaGF0IHdvdWxkIGJlIGEgbW9yZSBhcHByb3ByaWF0ZSBjb21wYXRpYmxlPyBEbyB3ZSBu
ZWVkIGhwZSxneHAtZWhjaSBwZXJoYXBzPw0KDQo+IFllcywsIHNlZSBvdGhlciBjYXNlcyBpbiBn
ZW5lcmljLWVoY2kueWFtbCBiaW5kaW5ncy4gWW91ciBjdXJyZW50IGNob2ljZSB3b3VsZCBiZSBw
b2ludGVkIG91dCBieSBkdGJzX2NoZWNrLCB0aGF0IGl0J3MgaW52YWxpZCBhY2NvcmRpbmcgdG8g
Y3VycmVudCBiaW5kaW5ncy4NCg0KRm9yIHNvbWUgcmVhc29uIHdoZW4gSSBjb21waWxlIEkgYW0g
bm90IHNlZWluZyBhIHdhcm5pbmcgZm9yIHRoYXQgZmlsZS4gSSBoYXZlIGJlZW4gdXNpbmcgIm1h
a2UgZHRic19jaGVjayIgYW5kICJtYWtlIGR0YnMgVz0xIi4gUGVyaGFwcyBJIGFtIG1pc3Npbmcg
YW4gaW1wb3J0YW50IGZsYWc/DQoNCkluIHRoZSBjYXNlIG9mIGNyZWF0aW5nIGEgaHBlLGd4cC1l
aGNpIGJpbmRpbmcgd291bGQgSSBuZWVkIHRvIGFkZCB0aGF0IHRvIHRoZSBnZW5lcmljLWVoY2ku
eWFtbD8NCg0KDQo+PiANCj4+Pj4+PiArCQkJcmVnID0gPDB4Y2VmZTAwMDAgMHgxMDA+Pj4+Ow0K
Pj4+Pj4+ICsJCQlpbnRlcnJ1cHRzID0gPDc+Pj4+Ow0KPj4+Pj4+ICsJCQlpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZ2aWMwPj4+PjsNCj4+Pj4+PiArCQl9Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArCQl1c2Ix
OiB1c2JAY2VmZTAxMDAgew0KPj4+Pj4+ICsJCQljb21wYXRpYmxlID0gImdlbmVyaWMtb2hjaSI7
DQo+Pj4+Pj4gKwkJCXJlZyA9IDwweGNlZmUwMTAwIDB4MTEwPj4+PjsNCj4+Pj4+PiArCQkJaW50
ZXJydXB0cyA9IDw2Pj4+PjsNCj4+Pj4+PiArCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmdmljMD4+
Pj47DQo+Pj4+Pj4gKwkJfTsNCj4+Pj4+PiArDQo+Pj4+Pj4gKwkJdnJvbUA1ODAwMDAwMCB7DQo+
Pj4+Pj4gKwkJCWNvbXBhdGlibGUgPSAibXRkLXJhbSI7DQo+Pj4+Pj4gKwkJCWJhbmstd2lkdGgg
PSA8ND4+Pj47DQo+Pj4+Pj4gKwkJCXJlZyA9IDwweDU4MDAwMDAwIDB4NDAwMDAwMD4+Pj47DQo+
Pj4+Pj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Pj4+Ow0KPj4+Pj4+ICsJCQkjc2l6ZS1jZWxs
cyA9IDwxPj4+PjsNCj4+Pj4+PiArCQkJcGFydGl0aW9uQDAgew0KPj4+Pj4+ICsJCQkJbGFiZWwg
PSAidnJvbS1wcmltZSI7DQo+Pj4+Pj4gKwkJCQlyZWcgPSA8MHgwIDB4MjAwMDAwMD4+Pj47DQo+
Pj4+Pj4gKwkJCX07DQo+Pj4+Pj4gKwkJCXBhcnRpdGlvbkAyMDAwMDAwIHsNCj4+Pj4+PiArCQkJ
CWxhYmVsID0gInZyb20tc2Vjb25kIjsNCj4+Pj4+PiArCQkJCXJlZyA9IDwweDIwMDAwMDAgMHgy
MDAwMDAwPj4+PjsNCj4+Pj4+PiArCQkJfTsNCj4+Pj4+PiArCQl9Ow0KPj4+Pj4+ICsNCj4+Pj4+
PiArCQlpMmNnOiBzeXNjb25AYzAwMDAwZjggew0KPj4gDQo+PiANCj4+Pj4+PiArCQkJY29tcGF0
aWJsZSA9ICJzaW1wbGUtbWZkIiwgInN5c2NvbiI7DQo+Pj4+Pj4gKwkJCXJlZyA9IDwweGMwMDAw
MGY4IDB4MDg+Pj4+Ow0KPj4+Pj4+ICsJCX07DQo+Pj4+Pj4gKwl9Ow0KPj4+Pj4+ICsNCj4+Pj4+
PiArCWNsb2NrcyB7DQo+Pj4+Pj4gKwkJb3NjOiBvc2Mgew0KPj4gDQo+Pj4+IEtlZXAgbm9kZSBu
YW1pbmcgY29uc2lzdGVudCwgc28ganVzdCAiY2xrIi4uLiBidXQgaXQncyBhbHNvIHZlcnkgZ2Vu
ZXJpYyBjb21wYXJpbmcgdG8gb3RoZXJzLCBzbyBJIHdvbmRlciB3aGF0IGlzIHRoaXMgY2xvY2s/
DQo+PiANCj4+IFdlIGFyZSBpbiB0aGUgcHJvY2VzcyBvZiByZWRvaW5nIHRoZSBjbG9ja3MuIFRo
aXMgd2FzIHRoZSBvc2NpbGxhdG9yIGJ1dCBubyBsb25nZXIgbmVlZGVkIGZvciB0aGUgbWluaW11
bSBib290IGNvbmZpZy4NCj4+IA0KPj4+Pj4+ICsJCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2Nr
IjsNCj4+Pj4+PiArCQkJI2Nsb2NrLWNlbGxzID0gPDA+Pj4+Ow0KPj4+Pj4+ICsJCQljbG9jay1v
dXRwdXQtbmFtZXMgPSAib3NjIjsNCj4+Pj4+PiArCQkJY2xvY2stZnJlcXVlbmN5ID0gPDMzMzMz
MzMzPj4+PjsNCj4+Pj4+PiArCQl9Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArCQlpb3BjbGs6IGlvcGNs
ayB7DQo+Pj4+Pj4gKwkJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPj4+Pj4+ICsJCQkj
Y2xvY2stY2VsbHMgPSA8MD4+Pj47DQo+Pj4+Pj4gKwkJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJp
b3BjbGsiOw0KPj4+Pj4+ICsJCQljbG9jay1mcmVxdWVuY3kgPSA8NDAwMDAwMDAwPj4+PjsNCj4+
Pj4+PiArCQl9Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArCQltZW1jbGs6IG1lbWNsayB7DQo+Pj4+Pj4g
KwkJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPj4+Pj4+ICsJCQkjY2xvY2stY2VsbHMg
PSA8MD4+Pj47DQo+Pj4+Pj4gKwkJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJtZW1jbGsiOw0KPj4+
Pj4+ICsJCQljbG9jay1mcmVxdWVuY3kgPSA8ODAwMDAwMDAwPj4+PjsNCj4+Pj4+PiArCQl9Ow0K
Pj4gDQo+Pj4+IFdoYXQgYXJlIHRoZXNlIGNsb2Nrcz8gSWYgZXh0ZXJuYWwgdG8gdGhlIFNvQywg
dGhlbiB3aGVyZSBhcmUgdGhleT8gT24gdGhlIGJvYXJkPw0KPj4gDQo+PiBUaGlzIHdhcyB0aGUg
aW50ZXJuYWwgaW9wY2xrIGFuZCBtZW1jbGsgdGhleSB3ZXJlIGJvdGggaW50ZXJuYWwgdG8gdGhl
IGNoaXAuDQo+PiBGb3Igbm93IEkgYW0gcmVtb3Zpbmcgb3NjIGFuZCBtZW1jbGsgYW5kIHdpbGwg
anVzdCBoYXZlIGFuIGlvcGNsayB0aGF0IEd4cC10aW1lciB3aWxsIHJlZmVyIHRvLg0KDQo+IFlv
dSBzaG91bGQgcmF0aGVyIGhhdmUgYSBjbG9jayBjb250cm9sbGVyIGRyaXZlciB3aGljaCBkZWZp
bmVzIHRoaXMgKGFuZCBtYW55IG90aGVycykuIFRoZXkgY2FuIHN0YXkgYXMgYSB0ZW1wb3Jhcnkg
d29yay1hcm91bmQsIGlmIHlvdSByZWFsbHkgbmVlZCB0aGVtIGZvciBzb21lIG90aGVyIG5vZGVz
Lg0KDQpJIGFtIHRyeWluZyB0byBwaWN0dXJlIHdoYXQgeW91IGFyZSBzYXlpbmcgYnV0IEkgYW0g
dW5zdXJlLCBJIGtub3cgdGhhdCBvbiBhIHNlcGFyYXRlIHJldmlldyB5b3UgbWVudGlvbmVkIHRo
YXQgdGhlIGd4cC10aW1lciBuZWVkZWQgdG8gaGF2ZSBjbG9ja3MsIGFuZCBjbG9jay1uYW1lcyBp
bnNpZGUgdGhlIG5vZGUuIFdvdWxkIGl0IGJlIGltcHJvcGVyIGZvciB0aGUgZ3hwLXRpbWVyIHRv
IHJlZmVyZW5jZSBpb3BjbGs/DQoNClRoYW5rcyENCg0KLU5pY2sgSGF3a2lucw0K
