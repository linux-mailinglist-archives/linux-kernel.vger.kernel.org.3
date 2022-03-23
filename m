Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD024E4A47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiCWBDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCWBDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:03:35 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2DB6EB25
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:02:06 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MH0ru0030747;
        Wed, 23 Mar 2022 01:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=PditBcro0KXcXHmSsc+25UUdbdImgY1/D8BwhHzRxOA=;
 b=TZnQTAmRmg4gpuezniMcUigwLm1i+TyvoeTiA3fU8CfL4c0J5M6Y0wI/KA28VAkvGA7p
 bp8qcIL+iSwIno1zQfsP+iHxIqVamGaYJCfMbLFqNo0YVOSLCbl/l18jTiSsCuU2HqqN
 oNJZw15fIrl/fOphTovdb4vFBqhhYO+Ie6BKlqfWGe7AXnxxJenge2VwOotLWGYIsJW3
 PRhsRbhxdyQywxZ7JxEvDOvqc+dKWdpT/yNCq0QWVRvUpGoKs9mL5BF2Aak2ypStVaqq
 13KDyrn0f+hI/b/D748yP3HH1gAPXPf1Ai7aaNAl8wxOcONtDgXq0YEcbyV3aIKBWWjB yw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eyhuv3hdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 01:01:47 +0000
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id DEA7159;
        Wed, 23 Mar 2022 01:01:45 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 23 Mar 2022 01:01:45 +0000
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Mar 2022 13:01:44 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 22 Mar 2022 13:01:44 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Mar 2022 01:01:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlJIRt4dZyFqLIHhkYqJhv8WlFiJrCitABILwMu6B7NamgraKDI8/xWzun9kDGF3fmMkaf00LYegqhwcA7sZ2x5OHhSuaBwOIVVMyASpPGleMP448XiJTT+ovc65gRl32Ni3reaQLppYiJMnk1VSzquHXdQ2r83ScPzkSUgVpUQk3dgKptpUiDG2G+5ZD2+X+cSU75j8OPAmnk43h+F+EEGFNuvyQflbFCqJsGka14rg+9xYm329wb2x6I05YBTEsXwJ0FNmiiumwWdxvGj+TiOm0nPL6X5MJEtQ3TnGYuB04dAar099qVkuGp0T6CCuNd1lrVwY3IUhPltybIE5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PditBcro0KXcXHmSsc+25UUdbdImgY1/D8BwhHzRxOA=;
 b=V+yd9kFuorxTxlsaq4TVyGYh637qQDbN+8jmgy6gsDR7lI/6osD4vQyYE5t/e3aY6GXZMu1vk8q+ProDsVYlDUt96z392kc9T5y2gXhjDZwNJNCygjpW00PJCkKYPUNiDUeOVS1dqUFPeV1V9ldvUwlQKSo3gW94x/wXe5VMiP+AijcC8LvknIph14wXI55T/+vbtWtwIMEBQoC+0t/4UDsM0bVpcl8skkecOd1QbTZK9AXZYxzLNLc1dOEjD0iCfnG/wa763SHiSyWzmCXKWKFc83JRK06e0OfthKAjqNfdXMihBA1wHinJDFofBSjbv1RHS4BXov0V3F8ezNk//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 DM4PR84MB1832.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.23; Wed, 23 Mar 2022 01:01:39 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 01:01:39 +0000
From:   "Verdun, Jean-Marie" <verdun@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v1] arch: arm: configs: gxp_defconfig
Thread-Topic: [PATCH] [v1] arch: arm: configs: gxp_defconfig
Thread-Index: AQHYI2Pt+fLVSCbpEEG4Jh+m/2IR7ayWuYMAgCh1fQCAAQhWAIAB2wCAgACaZYCACRMtgIAAe8GA//+rU4A=
Date:   Wed, 23 Mar 2022 01:01:39 +0000
Message-ID: <7CDF8A66-14E4-47E7-A6D7-6CF0C6C62CC8@hpe.com>
References: <nick.hawkins@hpe.com>
 <20220216183704.42084-1-nick.hawkins@hpe.com>
 <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
 <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com>
 <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
 <483082A1-A464-4D3D-B994-66B09E5D54B5@hpe.com>
 <CAK8P3a2n=yVfe+QiBvxAXw=5DmVY+Mjaag2s2fq+F=sQngos-Q@mail.gmail.com>
 <4CD3E272-3C69-441E-B4DE-7004701614EB@hpe.com>
 <CAK8P3a3z8uT+0p55N_it3Mg-J08dn31S4rCLoXdK4eheyOR0Eg@mail.gmail.com>
In-Reply-To: <CAK8P3a3z8uT+0p55N_it3Mg-J08dn31S4rCLoXdK4eheyOR0Eg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96bb0e97-222a-4a15-de6c-08da0c68b01d
x-ms-traffictypediagnostic: DM4PR84MB1832:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1832F56421159408B664D0C2D6189@DM4PR84MB1832.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqcaFQ+T9ApUbo4XryjSwsPNrQ5E0Y7BCKng7ddwFsFyLct3Q8LUCC4552bc1pHrfwMClVDIvbtfQbJz01K7YJAgfT2TG9saG5gE9diLrM3qAwdEc1jwcnhtSTuKGrDWnlN4OGWu6At24a7SDSMqAbtA5mI5jVQv06thEFLJng7waqX+IbiMD+FnogzqDc6LDMjSvkbo1f7/AhaRoITPCHdGGQDr+mpZ5njXchmzUDXv1INGPR0kw8piOnhsjT94acDuYksFWsJ8U1tNtEysdx0RCt/Cqlwj0FdXTW/VwskQMEJ2y+ambo6xbAUo9fuBNtcdAVueJ1NwmvwE1IcT5JqMoQ9afA+pxNuuGRdJIB0t/MZkNoiLew2HXQaS7wHeNuJJHOBR4WLgLbi384BtmjWuoYfz/ODzTjGFt1ZBCYdpaWxWiszFI0CAWbuGVdEKoms81glPl4g9T24/RwOi3CbReo9dfORVw1u1uH0yWYdqaz1uQTnWLGOJGrYLZ669nCs8+hvOfqBYNNDY8sjGzeoeOWcj9CWBTg+3mK/Wa1e/khXcNxbkm4/CVIr1NtiO8588C8AErNjCB1HllO5Qvm8lGT5zzvmON+5RebTdlXtr/HUjFXfSQfb/PwKVh3R0Wr95XaL8NZ2r8ud6smuBBnlNNTmVvhXj5rsu2489kv451Ar+YR9Giv1Eqx8rE0nhaINrpCZjqKVHm5+vyQI9oPe5IlxWImgfYnA8nh8/m3JJnbVk9rCKHP6tmcWHvv1g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(33656002)(71200400001)(508600001)(6916009)(38100700002)(91956017)(76116006)(6486002)(4326008)(316002)(8676002)(66946007)(64756008)(66476007)(66556008)(66446008)(2616005)(186003)(83380400001)(38070700005)(122000001)(5660300002)(6512007)(36756003)(82960400001)(6506007)(8936002)(4744005)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXVRTk1OU05TMm9vR1NjeEdNdXdweXpkTk5LNldETGU3U29wZk1YaVA3TXRR?=
 =?utf-8?B?V2N6MHF2U3J2NFNnclZDYWk4c3VYL2FxdmFHNkdmalByMzJVVWcyUEgxcHNK?=
 =?utf-8?B?emFrR3lZWG9kODlya1Zwc2N5V3ZCNVdvMzNKR0dkeVBNeEtDZ25jZlhJRkp3?=
 =?utf-8?B?NDRNVHJUZHFWTDIreGo1clduK1phWnlhY0hOR2FFSXBibFFjRU1ZN3BLcUh3?=
 =?utf-8?B?aVk2U254MllSbVBMWjBPQ3pla2x6am9NZnhsV3RSMWYvdVNqb21YK0czTkIy?=
 =?utf-8?B?cHYyT0xnNTZVVThyRmlxNkp3WWtIVU81UHFaQmFNdWxYdmZtZTY3UkRkSjdZ?=
 =?utf-8?B?Sm9JRk5DRHBiQlM2UC9kRkRtdjMvWGVRN0VNQ0ZCa2dUWWk5T3BpcjVOQTFn?=
 =?utf-8?B?dkdMSUJpSHRMSWVyQjN6dWpyaUl5NXJwUE8xNlFnVlpvcS9IUnVMR1NyaGlJ?=
 =?utf-8?B?VUJOQzZSaTUrWXFvVGFZb3dPT1hVUmtlOVJHQ2cvUFRxckRhT3ExRXpPcGds?=
 =?utf-8?B?ZlJ3RU15YlpHZlpmTDhNUlBFMWJBQjk1dHpFMW1JU2dyNmtTbExPcFJ6RTAy?=
 =?utf-8?B?ZXE5Nk5LQ29MQ1hKS2Flakd4aVFpM0cxSjhyWUdOMnQxMWlrSkNYbXpkY2dE?=
 =?utf-8?B?bUF4SEFuQXJPMm1ISHJCaEhVcFpkWTVoczFMT0JUQzJnMnlON1FuVmgrenZM?=
 =?utf-8?B?UnhZOE1KZ2pWbExxVXd6WEwrWFlmMVBNb3g4aG4vZ1h3WmRKcCs5UFZCSlFN?=
 =?utf-8?B?ZGhUSDI0VE1hbndmcFFVam81dnJPRWM0czFMMDg1NWUwL0JhM2NZUitiYWt5?=
 =?utf-8?B?Y2pVSmk3VlBMTGk2OWppUXI2VTNNb3ZKR3VoU3M3VEJIamw5REVzY29NN1A5?=
 =?utf-8?B?amFDVk54VG0rb2VXZUFKbCtBQmpubXF6Qjl2Q2N1TXE0aC9MRkx2ZzVHN2d1?=
 =?utf-8?B?WFlaNzNzMVZLN3lMN1o0TDJCRWZHWnJvNWNjeXBQTWh5ZVFvU2RlWTN1dFVU?=
 =?utf-8?B?NHBRR2R3d1B6WXRhWEYwRUdOWVVrM1V0NkZScTRaTGZhNjkwdngwNUN0V2Jk?=
 =?utf-8?B?RVNvYnBHU1kwMGZUb2lheHdpSzlvbTV3aGlIMC9YTXEwT2RLREhZa0RQNWl3?=
 =?utf-8?B?NkxrQXZkc01HVW8vNW93OUM4Q1FpT3AxdElySlFWTmR0cHVKdG9GTDZiYXdG?=
 =?utf-8?B?bjEvNUREWlk5bzRjVnpkQ256YVZrcW1KZUFqdi9CK3pOeit6UmI0SlY1R1Qy?=
 =?utf-8?B?Z1pyTXppTkltMWlMWDJLd0psYldsdnRoeFU3bk9HaFN1NHdBdHFiZEh6T2hT?=
 =?utf-8?B?QUhwTnBwNTBsT003UXYxTFU5bDZnblZSZDY0RTlJZTJ1akhEaDNxN1BnUnhV?=
 =?utf-8?B?eEk4clpGNkExUmZGN2h0WlEvVE1oTHdHNlEzQ1BNQWluSDM5NWppVUhuTi9B?=
 =?utf-8?B?NXB1VUgzTGl6VXo0ZU1HaEZCRmFmb1Q4OGZOcnZFK2tZWDRnWU9NVDd0OXQ2?=
 =?utf-8?B?VTNXaHFhOUlleVhNazB0bjdwditSMnJ1VUd0ZHpJSHhUVUIzT3NlNm9iazZu?=
 =?utf-8?B?dStCMUpGTk10VHcyb0poUFlNUVltT0xraFdzdGtXa1V3NVc5TnErT3J2eFZn?=
 =?utf-8?B?Vmg0d1lwdCs1OEE3NllKcndTMGg5K1lBa1RSUlRaWk5nTEdmem4rZFJrM1Yr?=
 =?utf-8?B?Wll2KzRvRmlXK1k0WFVWeDRCVmszQ2ZFeE5ZZTYzNFNnRW55K2l0bWhRakIw?=
 =?utf-8?B?RFJuNkZNZVNkcHpwNC9OUkhzczJmMGE5Qk8xWkt1ZStJVUwxcVA5Q25iWi95?=
 =?utf-8?B?dFoxQUU4OElNMXJVbE5KdVdnMWcxWG56U1Vud0NzaHBUN2V2MkxMWk9Ia1hj?=
 =?utf-8?B?OUVTdW1YZzVVNUJuVEtqVXFxd2M4azhBak4ydmM1cnZObEZxdjFpdHc0WVVm?=
 =?utf-8?B?V3BTclJXMVRxWDVWQTJTUXoyL1JKVUEraWpGcHowek9qTVllWWJPemxkNDVF?=
 =?utf-8?B?aFdqNEdPaStKRGMvQXhIQklVSjhWd2NJdEZOZFc2NHd6UXZpaWxZRUdscGN2?=
 =?utf-8?Q?mTk2Wl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F53629B0D555184AB5A40F73ECE4F9DD@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bb0e97-222a-4a15-de6c-08da0c68b01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 01:01:39.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItVgrF2yFJVmFPbdww//CeiQAJC5zXJoueFIZxlwRiPDHV2B+eX3zF4X559eHJMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1832
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: zVceat0mpeFf19VcwbAsmmR_J60elday
X-Proofpoint-GUID: zVceat0mpeFf19VcwbAsmmR_J60elday
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_08,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=885
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203230005
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gICAgVW5mb3J0dW5hdGVseSB0aGF0IGlzIG5vdCBwb3NzaWJsZSBhdCB0aGUgbW9t
ZW50LCBhcyB0aGlzIGlzIGEgJ2Jvb2wnDQo+ICAgIG9wdGlvbiByYXRoZXIgdGhhbg0KPiAgICBh
ICd0cmlzdGF0ZScuIEkgZG9uJ3Qga25vdyBpZiBpdCBtaWdodCBiZSBwb3NzaWJsZSB0byBjaGFu
Z2UgdGhhdCwgYnV0DQo+ICAgIHRoaXMgaXMgcHJvYmFibHkNCj4gICAgZG9uZSBmb3IgYSBnb29k
IHJlYXNvbi4NCg0KWW91IGFyZSByaWdodC4NCg0KPiAgICBJIHRoaW5rIGl0IHNob3VsZCBiZSBw
b3NzaWJsZSB0byBkZXRlY3QgdGhpcyBlcnJhdHVtIGF0IHJ1bnRpbWUsIGVzcGVjaWFsbHkgbm93
DQo+ICAgIHRoYXQgd2UgdW5kZXJzdGFuZCB3aGF0IHRoZSBoYXJkd2FyZSBpc3N1ZSBpcy4NCg0K
PiAgICBXZSBzaG91bGQgcHJvYmFibHkgYWRkIGEgQ09ORklHX0FSTV9FUlJBVEFfNzY0MzE5IEtj
b25maWcNCj4gICAgb3B0aW9uIHRoYXQgY29udHJvbHMgd2hldGhlciBhIHdvcmthcm91bmQgaXMg
ZW5hYmxlZCBvciBub3QuIE9uZQ0KPiAgICB3YXkgdGhhdCBJIHRoaW5rIHRoaXMgY2FuIGJlIGhh
bmRsZWQgaXMgdG8gaGF2ZSBhIGN1c3RvbSBpbmxpbmUgYXNtDQo+ICAgIGZvciB0aGUgdHJhcHBp
bmcgcmVnaXN0ZXIgQ1AxNCBhY2Nlc3NlcywgdXNpbmcgYSBfX2V4X3RhYmxlIGZpeHVwLA0KPiAg
ICBzaW1pbGFyIHRvIHdoYXQgd2UgZG8gZm9yIHRyYXBwaW5nIHVzZXIgc3BhY2UgbWVtb3J5IGFj
Y2Vzcy4NCg0KSSBsaWtlIHRoaXMgaWRlYS4gTGV0IG1lIHRyeSB0byBpbXBsZW1lbnQgaXQgYW5k
IHByb3Bvc2Ugc29tZXRoaW5nLg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2tzLg0KDQo+ICAgIEFu
b3RoZXIgb3B0aW9uIHdvdWxkIGJlIHRvIGRldGVjdCBhZmZlY3RlZCBzeXN0ZW1zIGJ5IHRoZSBD
UFUNCj4gICAgcmV2aXNpb24gcmVnaXN0ZXIgb3IgZnJvbSBzb21lIERUIHByb3BlcnRpZXMuDQoN
CkFSTSBtaWdodCBiZSBhYmxlIHRvIHByb3ZpZGUgdGhhdC4gTGV0IG1lIGFzayB0aGVtDQoNCnZl
am1hcmllDQoNCg==
