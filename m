Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA74DB844
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357822AbiCPSz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357812AbiCPSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:55:55 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD12E0AC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:54:41 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GGue6r015835;
        Wed, 16 Mar 2022 18:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=vHungQWY+T0+T9jNpgWF2v7/H38ENf/grVpZ/jBj3Js=;
 b=PzhO+3b/msKRv3YPy3mvi7FtIVUFQloT+HSAebC+Gdgly7ll8rFikV4jOplr75Jt4Crm
 SuLkug7O9pIWj7VGw4nbGp+e0UfX7anjUzLydI3FARzGMxUm5MKiBCjWZ8rv+DlWHrIb
 IAafy84t21ecOV+bmAHNgPUOPrO1htsJFWcag33OCRXOIrTpQFkwZEq8rJuedaZhNxbR
 WnTJeUKk0n82LDGtj8TKngQ/zENYLrAm7aHbWvBcOYBKUF9xXODaqKzLQDai4raOq0Hj
 MWuouDwqlYgv5BTjQB6GtN33h///49OpsWCYdYutO/WJ0ZDylqug5PvcYEnW7iBPLHLz 4Q== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3euk8y28b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 18:54:19 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id C234766;
        Wed, 16 Mar 2022 18:54:17 +0000 (UTC)
Received: from G9W8677.americas.hpqcorp.net (16.220.49.24) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 16 Mar 2022 18:54:17 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G9W8677.americas.hpqcorp.net (2002:10dc:3118::10dc:3118) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 18:54:17 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 18:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRRoteGrBRKvwWvhIHN/I1TP/hneVk8IFVsaAZHQl+D+45TStnGV7bt+XRSfUq5riTrcAM+Va33cKEoKMyMdGDyJO9lcDb7d4Rmd2CVhK5ZuENgSCp3zCKbpZqUpAcAwzXfmaztD++8Xh2DV1VSePmNhzfX1cPNGMtu5pxwMptmR0R4VlvISaBPCvTcpUa20AIW1pXVN6EW490LblSsnuGBYi6PHjROhwQ35nWlENqAktM1E8bM3v5DY2vQT3MNRCGNutXcbEKWCDppszPj1oiIoSdo+JlSFS5usZwpJn3tiQANqD4JUKOsULVSPGVlkK5TsB2PAW8igf+oui5kRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHungQWY+T0+T9jNpgWF2v7/H38ENf/grVpZ/jBj3Js=;
 b=JmsJ4jCTGbLngUuDaSMffFH3pmYeezWKF4P0z798kmS/URgOabLBrZsC0QuPeuOQ3aY0VR8DoMK9nJC9Ijw23hdeOfeGRsNzDC4oWmwJvhpPbokLMUJulkTXmvYJreH4pF+b24GIJelsZXuUE15LnLCTRp9XeWBz59FVkL5VHH+Qli2FPvKmspkCJIet/mF1HkMveOwG2ujar7Ji6Lszne3Rd7VVPQaD3jLZ8BPiI/sFvuBOrCGDQhIZdvAVGEp2AUw9EerXYoEaPlhwhXCmBbWgP33/sw3ZmqUlAHU/++3ZhWxGo78IOERiM8LM7XSF5Z9D0Bia4H3uEEnLRKLgig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 MW4PR84MB2092.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.30; Wed, 16 Mar 2022 18:54:15 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 18:54:15 +0000
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
Thread-Index: AQHYI2Pt+fLVSCbpEEG4Jh+m/2IR7ayWuYMAgCh1fQCAAQhWAIAB2wCA
Date:   Wed, 16 Mar 2022 18:54:15 +0000
Message-ID: <483082A1-A464-4D3D-B994-66B09E5D54B5@hpe.com>
References: <nick.hawkins@hpe.com>
 <20220216183704.42084-1-nick.hawkins@hpe.com>
 <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
 <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com>
 <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5753679a-10a9-4666-fc46-08da077e5e4d
x-ms-traffictypediagnostic: MW4PR84MB2092:EE_
x-microsoft-antispam-prvs: <MW4PR84MB20921174E3B5744B88C63BBED6119@MW4PR84MB2092.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2vjZJAeG3YGfcNh7z3o9hHPlGGWbHk4SKt5g/HivB40sokoRqRy9dQZpT1MrSTtv/gqjmCFdLymG8/pIuUjUa4L9fjRtOZ18yx+UH6YQ+KChpOa7fAr0zViyg0ZeeBZx4IT7j301kjHayULhpNbW/G6YERw1enQ0oLDyZumF7vdqX/iwFNUZQMyCMvpVw3V2oUMCPsA8g3FqU/ljjD+YL2baL1cPjLJFurcmUgddB9n7HNLP422GwzIC+oTRym0yZefTGdjMwIc7nFoiJxB23b7Y0lB3kkc3WDHhzN+qvcOUiYfe3nxXajKxHfNLuwVWNaZdkl2HTDj1BBt48wbw2IYK7hAoquDR260//5Dr34iocHvf6OTGzl48WH1H+QrW+PEaP4TWIcsSFlfcojRHVoRdUYUctNLzZrHGHU5jvO6igS4p/br6k1nO16A2uLBWQltaKQUG9DnQN8LY92ncsZL7balF78ItVggk8PlfgzsUSnebtTWF0lcGJk32fjCcGmYdBvO40cXi4xCd+dvI6X5XGdHPd6qSvw5U+lsP1uvuzbZVCunOVTWRCFReLyPyTBz9KPkprLR9A5LPm8nJuqfl0if5kswgXhFbxOhsR3AO3GZEkJc7dKARiq8wGrG0WLyWd/jCDAQJwOVWbl3EtkYcGiDxJxz21kcfrswyp/w9cW5VpbLeqPHsr+7endgGJ/o9G6pS7UWQyecO6dIAZoc53jYMN8rElMmCg1bS5oKBsqdEHPE4q91jSq54x0/JK5SciiXrPgQjJLjR6BIYi+dgzYtrHS5VkDPbdvxqHlwtj0eekGXmCjhorRO4DqAVH6WYpTpzbOlbxdTW3XfFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6506007)(6512007)(36756003)(186003)(54906003)(6916009)(66476007)(66446008)(64756008)(38070700005)(5660300002)(33656002)(8676002)(8936002)(38100700002)(71200400001)(91956017)(508600001)(2906002)(2616005)(82960400001)(76116006)(66946007)(66556008)(86362001)(966005)(4326008)(6486002)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3pJSlFHaUxYeC9zalBjRjREV0xXeFR4b1pPNHp6RTVuUUoxOTE2aU5XMkZu?=
 =?utf-8?B?MkxzcDJHWFhCaE9xTTlEVHZIM0VlckRKQlMxT1R2bzBVK1pnSXJHL09NNzFW?=
 =?utf-8?B?L2Y3K3BkWldsQlJpc1ZWRE5aVXRMS3NveUlBOGduVStIMSt4SFBRLzNTdXVW?=
 =?utf-8?B?TXJseksra3lzZnhNbjh2QXZUZkhLZWxDK2w2K3RFMk5aVFo3d0lKQXZFOW01?=
 =?utf-8?B?N1VrYU5nWEkrVm8wejN4R3ZyaHluS1J1aFBtMjIwUDhXYSs0eFhaR3RZd3hh?=
 =?utf-8?B?WkVySm81Rko4V2d6MXMySnkvTlQyZUZUUnN3eGhhK1M1QXE2K1BEdUFZWStI?=
 =?utf-8?B?Um80WWtXU3BUM1hZNzN6MEZFYVVkTjNKbUdKVklNc01WMUcrSWdpZnZKV1Vt?=
 =?utf-8?B?OGdqUkRvckwxZDlncWFMSEphNW5xbG4wZnQ1c0RMQmdEZ2FzNlZVYkk2RE9P?=
 =?utf-8?B?cmxuQlFXTXBxV2JFL3BvUExkK3lWc2dsQWc3NnVhK1RIRCs3ZG5MMnp3VDJq?=
 =?utf-8?B?enhyMWgwWC9aMzJYa2ZqQzFBU2lCK2FjSlNLRzFkbVJ3QWZvTEptRTQxbWQw?=
 =?utf-8?B?SGp0bjRPTjE4U1JCQUZMTFhJWkp3cjhDK2t3cyt0czB2N3o0UC9OaW1EK3Q0?=
 =?utf-8?B?RWY2Nmgzays1alpWaysxWlhsVWQ5K0tZbFBadTd4YmpHLzljaEhvRWRzZzZn?=
 =?utf-8?B?Z2wwNU92aFJsNUFKWGRXNGZZYU9qRVhJUlVGS1ViTnJwVlptQzNHYkdaejdE?=
 =?utf-8?B?NXN2Umo1dStqL2ZVbVdHcUpudnY4cWVVenoxV1FZOTZmdE9vUWdoZDJMV3BQ?=
 =?utf-8?B?d1lMQmwxYnJvcStpWlB1MkF3T2VZdlNMZDlYU1Rsem44eVlCQnUyZVJjUktH?=
 =?utf-8?B?b3NuZHVKSHdBdXpyU05pVnBzMEJVWUNQS0ttOHlrVVdIVjVZYmEyRUErdXFD?=
 =?utf-8?B?STA4UjE5NVZyZlVmWmVZNHF1VnEyaW9qUjJ4eUhoeVlmZkJqWUVScGRiUSty?=
 =?utf-8?B?U3JlRHdkYjFFM3RlWDRTa01Xd096blRqQmd4TTBpM2RSVzZEK3V2WEYyYm0z?=
 =?utf-8?B?ZUR6b2dSVXZYWnppRDhtZDA2M0dVUWMzUEVYeVZuSjRPUzBUS2JiUm90Nlpz?=
 =?utf-8?B?ZDA5MWwvWmYyVkI4YXU2QnBPRjNEU0JUQU5KeWVLanE2Q0RmVndYOGpsY1pk?=
 =?utf-8?B?ZWN6aHdMYWp3OHVtS2x4WitJQ05hQXQyTGZOa3BYNjBHeTZrM3JjbW5Jd2NZ?=
 =?utf-8?B?UXI4eXQ3My9HTE84ekRsN3lkeE1UcytaSEp6TldZWEFVRytmTXpFQk5QczQ3?=
 =?utf-8?B?cUtGRDlWSVFGQkNtdUNxckd1S0hqUzBwemxEeWU5amV1SUJQWlJ1U3JyRXFs?=
 =?utf-8?B?SWFRdjhjTnZlRTcrbmpJZk9FdGNacGdrUUZ6QzJQbkdHOStPNTdBMVU5aDkr?=
 =?utf-8?B?dlVtcTJjd3VNc0tIZFI4M0x1dXVuRy9HM2FDOXBvbTlvOC9zdTlxTVl1ZCs4?=
 =?utf-8?B?UmNLeitGY3BtRk9CVHN6TFRKRi9oS1BuS2dHUUhtL0pQa2RIeEd0aVp0MWhM?=
 =?utf-8?B?eHdMVXpDUlJxdnZrWHhzamVCUk1NZ0xqNk50RTArVVFsVEs2cGdiNGFqeXJ2?=
 =?utf-8?B?V2tXSXdHSEdBbXkxVERyRE5iTERjZFdndzNRMDRrM2dqRE1hcCs5VUhsV2tm?=
 =?utf-8?B?allONTJpaHdtYlVPb1ZpY08vQnNaeU1XRHZZUHlmYWlQcWRLa3dkNCs1eEJl?=
 =?utf-8?B?TG9Sc1ZxcytRaU9LeVFhcDJGZktnMW5yVHVONjJna1VGSHRKdG1jOGtWV3Zx?=
 =?utf-8?B?UmV4aWdSeVhoMVRmRnpWK0NMTWhIUHhqQjRxTnlwaUEwcC8rc2E0dnZQT0ln?=
 =?utf-8?B?bzdkRWp2NEFHeDNwblUrdzBQZlllb1JxWS9Qa0xOYVJOeXBTTHZNWU9LRWJC?=
 =?utf-8?B?eTJLQisxRjc3NDhhRmliMExWUUUrK0F0NVJzUWVibEJDZ2MvdloyVHhxb2p0?=
 =?utf-8?B?QTVTTDdJeWF6REkrRWE2VmNnZXZyL09iaWFNYjIvVnpYbzg5NmxvSVF1c3cx?=
 =?utf-8?Q?KWtWDB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F73A5D8A66FCE64CA1F5E027BEC892AA@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5753679a-10a9-4666-fc46-08da077e5e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 18:54:15.4383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zacdDua8+GZWcO6B+BHu/Q1EhY8uhwYAMASaNpwOGd7vwjQ72j69rCMOEtyikhp0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB2092
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: KsCtCi847Zk3UPeOLjKLt21mBFMksjeh
X-Proofpoint-GUID: KsCtCi847Zk3UPeOLjKLt21mBFMksjeh
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=853
 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160112
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gICAgSWYgeW91IGdldCB1bmtub3duIGluc3RydWN0aW9uIGV4Y2VwdGlvbnMsIHRo
YXQgaXMgY2xlYXJseSBhIGJ1ZyB0aGF0IGhhcyB0byBiZQ0KPiAgICBmaXhlZCBzb21ld2hlcmUu
IFR1cm5pbmcgdGhlIG9wdGlvbnMgb2ZmIHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5LCBidXQgd2Ug
aGF2ZQ0KPiAgICB0byBmaWd1cmUgb3V0IHdoeSB0aGVzZSBjcmFzaCwgYW5kIG1ha2Ugc3VyZSB3
ZSBoYXZlIGNvcnJlY3QgcnVudGltZSBkZXRlY3Rpb24NCj4gICAgaW4gcGxhY2UgdGhhdCBlbnN1
cmVzIHRoYXQgYW55IGRyaXZlciBjb2RlIHJ1bnMgb25seSBvbiBwbGF0Zm9ybXMgdGhhdCBoYXZl
IHRoZQ0KPiAgICBjb3JyZXNwb25kaW5nIGhhcmR3YXJlLg0KDQo+ICAgIERvIHlvdSBoYXZlIGFu
eSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGhvdyBhbmQgd2h5IHRoZXNlIGNyYXNoPyBNeSBmaXJz
dA0KPiAgICBndWVzcyB3b3VsZCBiZSB0aGF0IHRoZXJlIGlzIHNvbWV0aGluZyBpbiB5b3VyIERU
IHRoYXQgZGVzY3JpYmVzIGhhcmR3YXJlDQo+ICAgIHRoYXQgaXMgbm90IGFjdHVhbGx5IHRoZXJl
LiBXaXRoIGEgY29ycmVjdCBEVEIgZmlsZSwgdGhlIHR3byBvcHRpb25zIHNob3VsZA0KPiAgICBu
b3QgY2F1c2UgYW55IGNvZGUgdG8gcnVuIHRoYXQgd291bGRuJ3Qgb3RoZXJ3aXNlLg0KDQpJIHRo
aW5rIEkgZm91bmQgcGFydCBvZiB0aGUgaXNzdWUgcmVnYXJkaW5nIHRoZSBQRVJGX0VWRU5UUy4g
SW4gLi9hcmNoL2FybS9rZXJuZWwvaHdfYnJlYWtwb2ludC5jLCB0aGUgZnVuY3Rpb24gY29yZV9o
YXNfb3Nfc2F2ZV9yZXN0b3JlIGlzIGNhbGxpbmcgdGhlIG1yYyBwMTQgaW5zdHJ1Y3Rpb24gdG8g
ZGV0ZXJtaW5lIEFSTV9PU0xTUl9PU0xNMCB2YWx1ZS4gVW5mb3J0dW5hdGVseSBwZXIgdGhlIEFS
TSBDb3J0ZXggQTkgZG9jdW1lbnRhdGlvbiB0aGF0IGNhbGwgaXMgbm90IGltcGxlbWVudGVkIG9u
IHN1Y2ggY29yZQ0KKCBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRp
MDM4OC9pL2RlYnVnL2RlYnVnLXJlZ2lzdGVyLXN1bW1hcnkgKQ0KDQp3aGljaCBpcyBsZWFkaW5n
IHRvIGFuIHVua25vd24gaW5zdHJ1Y3Rpb24gb24gb3VyIEFTSUMuDQoNCk5lZWQgdG8gZmlndXJp
bmcgb3V0IGhvdyB0byB3b3JrYXJvdW5kIHRoYXQuIEkgd2lsbCBjaGVjayB3aGF0IEFSTV9ERUJV
R19BUkNIX1Y3X0VDUDE0IGlzIHN1cHBvc2VkIHRvIHN1cHBvcnQuIFdlIG1pZ2h0IGhhdmUgZWl0
aGVyIGEgYnVnIGludG8gdGhlIHdheSB3ZSByZXBvcnQgdGhlIEFTSUMgaWQgb3Igc29tZXRoaW5n
IGlzIHdlaXJkIGludG8gdGhlIGtlcm5lbCB3aGljaCBpcyBhc3N1bWluZyB0aGF0IENvcnRleCBB
OSBzdXBwb3J0IHRoaXMgUE1VIGFjY2Vzcy4NCg0KdmVqbWFyaWUNCg0K
