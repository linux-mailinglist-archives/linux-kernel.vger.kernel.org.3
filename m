Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA36953BAFA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiFBOjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiFBOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:39:13 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978499CF71
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:39:00 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252BaI0C027523;
        Thu, 2 Jun 2022 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=dhwV5/x+mjoe52Ew6tbkTs2jMx9m4eteai3wLgcJcAA=;
 b=FeaEsDWaBaaxc2QHd4OFuGwTme/bRx9hejdrVT2S5RG5MOxtyst81ClgCX6InhOgPRos
 pNSSIB8R8VwRbDCv8AyQimvFVp1DY+DDgK0h1mpM8ckEfXIwqbSUNrtND722wNneT4h6
 fws1Fpf8l7V2mOAmoF7ApX1UMInNBHw0/3IAISf665IFn3EKTXHZV5ocgvzQddXxvt9t
 crMY1G6DKe/BY5B1aOEi/TQuBQMw5WzCmp7EdP237iaQcdo6Iyq2iBNYSNfjvgeld1h0
 tFYqiiP53eEMFMYf1YVaFSeVHjg/xQugNK6GDOxXQCzA3cpplB8zLDXpR/SUEu0ECZtM Tg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gevfuspn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 14:38:22 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id DED6612E93;
        Thu,  2 Jun 2022 14:38:20 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 2 Jun 2022 02:37:54 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 2 Jun 2022 02:37:54 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 2 Jun 2022 02:37:54 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 2 Jun 2022 02:37:53 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOPx+Ug/WOEo/mxW+eFxa23yF6uNIBT2LCEPi4NIeyEvqVHtXz6LWMBvLoZSw/f9rKeQRbYC+gTDGOWHLSllJuiKyAuuf4g2f8nAHaHHy6iaCiOJY2KO/HeR4yMqEOdSLx2ktdOqQSK/W/8wfEvvfrfZBM6UlIzolLaLkwGzfp9bKzPDenHsfJZ7WnrziTYzkyRQbu5CzQsQ9nUEgjFbiU0C09bv0HMSgbCG55PFsL6bVWNIbSqf7lQziPdn/84x3pLp14lVN0fiMx1RTAxB21HW+A7VN3Ic7xHG+No/PUA97wOjWCyY8VqTlc8N9aZ0Jm0LQdYEUu2VNAhM7Rlivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhwV5/x+mjoe52Ew6tbkTs2jMx9m4eteai3wLgcJcAA=;
 b=ebbixVG7W/mXzE40GF8bRFEqStrijiCvuM5xEzG3qeCLLn+tPlFkqoQZst1KgvC19HMv8+v8J4NKxXrXSZeGqBT8rjSvX4oqrK4Av7gg2puPAfiMFwgnRHZ7nY6bQ+GJv6AzGSaTGLKZPvvhnpPWZf83aarrtnll9hD1SecSpmxeRxYr9UT82/i2t6cHGwAtr5+2Bd8hoRVExbXMytbIVJTzjlVW9br0X4ryFB/p/waXFeBNpvj2lsgmQWpnjPcjFdqL6HE01mudcJFf/MXq1v7FwNklrnbA6kLdv798UT0ehHKcbOrY3L5+EMXupIkbHcpaHRldqdJ6K/k5vN/d5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH7PR84MB1533.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:150::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 14:37:52 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43%3]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 14:37:52 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: RE: [PATCH v7 1/8] ARM: hpe: Introduce the HPE GXP architecture
Thread-Topic: [PATCH v7 1/8] ARM: hpe: Introduce the HPE GXP architecture
Thread-Index: AQHYYX0xpitDmhpioUWxkMbNvoYPIK03JJMAgAOaLNCAAHKogIAAphOAgACBreA=
Date:   Thu, 2 Jun 2022 14:37:52 +0000
Message-ID: <DM4PR84MB1927D7CBD14870DF5132FDBE88DE9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
 <20220530070626.GD1363@bug>
 <DM4PR84MB19274FE59381E204CBCFE55888DF9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <20220601205723.GA10927@duo.ucw.cz>
 <CAK8P3a3J_JoM_QGD2wpXXs=PPNwrhJQiS9aA5gTRacsYRQ_iGw@mail.gmail.com>
In-Reply-To: <CAK8P3a3J_JoM_QGD2wpXXs=PPNwrhJQiS9aA5gTRacsYRQ_iGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c20fcfe-7be3-4209-cefe-08da44a5797d
x-ms-traffictypediagnostic: PH7PR84MB1533:EE_
x-microsoft-antispam-prvs: <PH7PR84MB15332AC8B56B191FC4DE7C6688DE9@PH7PR84MB1533.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RylHYtjukiw0+dzYNBvw42u9u/7DsnV8p6PKUmbcV9VretlY6dcB2CMBg1Mp1ZpPLATE6VQXQGVME94mXC5mROOqs38DSjMR1cDGtKebSDFy0qO9D/CcSR97BuPNbh1QGj1i1ntEXhi4Dnm3hzGLyqu/aAFTOF9/ZGsYwIzIpsCIbDYKtGE965nsudEXntMrHaCP7oHnwrA9kVnhquUOwIU91nPijS4nCzfMkiuDWE2l1BMQ0QXfuKdjDYzKEgGI1eO9aSFFF8TiK5wlJb3/i2Yq3GpPkU5TiSWLsqqDMvQsc4bl/qvmYXysCiTEu0OIjvGo0AlLIeDnNunXLZZXSW/wdrAumgiyjzW7WKl0rgGujnCLmLiGapJZgSH/S462EHCo49YqvsqiARaVCHAojMD+CNTNpcZMB7kWwX8gg2xLV0ICrAJum4pJv016mL79tzQiSPGdYLNBcl26p9t7X7kW4gxj4fqove8+U6Th63qnlq0f26SFEqfojkb/NLrcyxdSIatxpvo4w8E9aqLPbVJxBMBAIMC6x21nkorIDhnUl2Mt1IUfr89XQ4+Zko6ahZy2HcusSlzlhMvw3DLT824DxREb57IMKKTZ3Z5xCBdyfyJ10VexsW+f4wtFogsp1cJJnD9L2lBH9t8wlX2JUDjTRqlXdk1rnUK78NrgZoB+zCJ5xqWoe8AwBamVCLKoawhVtr+Q8nG72T1WD/o7gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(2906002)(7696005)(26005)(9686003)(186003)(55236004)(316002)(4744005)(8936002)(33656002)(52536014)(122000001)(86362001)(82960400001)(76116006)(4326008)(8676002)(38070700005)(66476007)(64756008)(66946007)(66556008)(66446008)(38100700002)(54906003)(508600001)(110136005)(55016003)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3RVUFFLendVdnVrNHZUYjZEV1BWNzRzbWhRNStmTHcraHMxMkxIcDRYRHYv?=
 =?utf-8?B?Wm5WWWlDVHYybkp2clp3bVkxZXBaeWVxM1VWeGlZVzRINjdGTTF0WmdUTzRp?=
 =?utf-8?B?Vno3OHJYdWd6b09VU3VlQWo1aUhjdGlyT0F2eVl6YjlJcDA3Y1MxMVBaRzRL?=
 =?utf-8?B?Y01NSUJ0Nmd5R1VKSkNsaFhpTkVhQjYxOFRwdGc3eS9HRHZMdWVqUzlPUGxj?=
 =?utf-8?B?MGI3WENsSWx6Ym9GZ1U3WTlLeWRMYS9keEZUdGU1eFlBQ1RYSWg0SW1USTFY?=
 =?utf-8?B?RVhKTk9iMnpUVzgrTzVBUG02d2dKeTV6K0RGY3NuWi95QW8xZWM3OUR2blBL?=
 =?utf-8?B?TkVmMDJ3VzAwQmFwdC84RE43ZUh4bTZCbkZuMDh1dTI1Q1E3ZS92RmJwYU5v?=
 =?utf-8?B?U1M4V1BYcmlFZ2c2Z09jUzM5L1JFUERicTIxOWsxVytqVndlMWdpeW9RK3hH?=
 =?utf-8?B?Y2F6ajZjdTVhRUZwWWpndENYVk5VeHBpQ3gyaG51cTJTSVBGblhCZTMxaE1Y?=
 =?utf-8?B?Q0NaNkZrbmxmREhjMGQrTEdna2U5cStGWnFZakRadXNqUDh6OTdMVWI5aU41?=
 =?utf-8?B?SnYyUmVuR0s2M3dEK3kyRXoxMmQ0YVRaeGxmV3dyaFM4eW1IZzVhakR2bkp1?=
 =?utf-8?B?b3dkYzNJNy9xdFFuaW5LY3lIL1ZaYmw1ZGk1VkUxWWRsR25WZzU0RE53NHJS?=
 =?utf-8?B?M1QwVEZ3MWxWdWdNd0x0b1pGWmZhNkFqaFN1QTFxNHRmUDhGUUpjVWN2WCtD?=
 =?utf-8?B?b1Q2eTB4d01KdTBFcTJYWnR4WE8vUEt4aFZJUm5WVlAvcVowUHJvQlRGdTFK?=
 =?utf-8?B?ZERSV0gyaWZuOFRadUY3SFFlSEZaT0pTcDIzdm8veFFKRk5ZWW44djd3OEd0?=
 =?utf-8?B?QzJFTithSzZJeWNSQm9ROTU3bUxWWEhOYnBvYU1URTlESTRYNDdJRFBpMlNh?=
 =?utf-8?B?dTl3Tzg2aG9ObjBEY1RYRUhGbUxWR3dhL3o3UW5zQnFNOHE0MXlvR0lpcFpY?=
 =?utf-8?B?WnpEUWtTdUV5MnpzaXl2ZW9EYWFiVG5WaHFzRFRnUGJ2OTl3YmNNdVptTzl5?=
 =?utf-8?B?Y3BVRVVQYmJSSkxTQ0JRVzQxM2pyNFBVT2oyQXlGN2w0ZkxhMUoxYWJjK0w1?=
 =?utf-8?B?elhLamp3dkEzSzlmU2NDUEVpOFNiYzhkQ0F4alRsRWJHb0I2bGtGVitBaWU0?=
 =?utf-8?B?NVJta05DbHVIRlRLQ3l6N0g0d2RTTWNWbG1LeWt4Ym9HVjhBS1FTRjdPRTlj?=
 =?utf-8?B?d1FlRnlIODE4cWNVSHlROUhUR2hGd2JvZUllczNVNGF1ZWJnVlVJTElkeU1j?=
 =?utf-8?B?T0JubGtoUzBsZzIwMFFpRitKazExb1orMStCaGRiRmtyZklJazFUK0J1ZW10?=
 =?utf-8?B?L1Nrd3p6anV5WWV5b3JRbmRkNkV5ekhOK3k1d3BkOEV6TzN4SnFVeUJLUXJG?=
 =?utf-8?B?RHl3WmQ3WTZxVHBob0s5M2pDeU5ZZHgvVnhMQ0pFZ2kxa1VpNnp2NUx4bjA3?=
 =?utf-8?B?N0tUQlFMMElHeUovU0UvVndkNXJyMzBHbE9XaVFVc1E0dEZLRUtGMk9RSit3?=
 =?utf-8?B?WndSWVkyb1FzazlMLzNVVHB4eHdadTh1UlVSbmhqQVlkZ1gzZkhzanBHdGNq?=
 =?utf-8?B?a0JTNjE0QWh0dkVBVXFCbzdQZU5hcWNLODRXWjAyQ1cycUdGbU9iaVFPZEw2?=
 =?utf-8?B?ZzIwK2c5VW1BTGdVS2ZjbjFaU0hmWEpXbWEyL0M1bVlFR3JZTHFGcEhJb0V0?=
 =?utf-8?B?QUdNY1dveTNqbTNsZ2VmbUU1SVVHWUYySTFGRTRtTGViQ1RlQ1lPYnZBQVZz?=
 =?utf-8?B?M1BpbVFsY21Od3QvOUR5NXpMYXJwQS92blFxRDF3cS94TVdIM2hFOTdobkEy?=
 =?utf-8?B?RVhSbkoxUURzVVQzM2U0OGJERThERzhGTEREMllLWGhUS0V3eDJEZTNrRjc0?=
 =?utf-8?B?bFExc0JNbmJkaGNGRkw5SjNaZ1lESFAwNFhEUWt6UUF1SEVOa3JrbWVNbi8y?=
 =?utf-8?B?MlpqVEZ4QVV2Sk9rajU4ZG14Y3l2U3QyUlg1QlMrWGpwZkkrRFQzaWljTjRF?=
 =?utf-8?B?RXhhQkZhcWpjUFpTT3ZNYVdocjRHVFIxOWRJaFpMV3BZcHJIUW8xV2RQeWJE?=
 =?utf-8?B?aUtZV245YjZWTGIyMUxxbmt4dFpBRE1RaHRDR2EremZzVDgxcHlyRlQzMkNS?=
 =?utf-8?B?QmUwTjhuNjVTR2syQ1FqQmQrRzIyMlRGL1RzRnI5UHUrV0dOelV0TDJuVnBk?=
 =?utf-8?B?VXhaQmZ1ekZUbEtSck1lNWMzazJWOWNOcGZPV0k0cUljTUFnQ2NNUldMdFB3?=
 =?utf-8?B?MmpXT2tQY2UzN2tDeWYydkp6eE5la01KSnhxTzFBVHE5ZkpXN0V6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c20fcfe-7be3-4209-cefe-08da44a5797d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 14:37:52.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5t8TEpGSDlYHO9pdjbE5flKU76R10X6PZk4M5Fu9z+RLyc3BAGlP9ct88LAKULKrT2qbkeOIWpIdtn85jObnZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1533
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: L7KAFWYfb8lB_hEjGpQHJosUHbF3NZrT
X-Proofpoint-GUID: L7KAFWYfb8lB_hEjGpQHJosUHbF3NZrT
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_03,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=404
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020064
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFRvIGNsYXJpZnk6IHRoZSB3YXkgdGhpcyBpcyBub3JtYWxseSBkb25lIGlzIHRvIHByZXBh
cmUgdGhlIHNlcmllcyB1c2luZyAnZ2l0IGZvcm1hdC1wYXRjaCAtLWNvdmVyLWxldHRlciAuLi4n
IGFuZCB0aGVuIHNlbmQgaXQgdXNpbmcgJ2dpdCBzZW5kLWVtYWlsIC0tdGhyZWFkIC0tbm8tY2hh
aW4tcmVwbHknLCB3aGljaCBtYWtlcyBhbGwgcGF0Y2hlcyBhIHJlcGx5IHRvIHRoZSBjb3ZlciBs
ZXR0ZXIuDQoNCkkgc2VlIHRoYW5rIHlvdSBmb3IgdGhlIGluZm9ybWF0aW9uISBJIHdpbGwgYmUg
c3VyZSB0byB1c2UgdGhpcyBvbiBmdXR1cmUgcGF0Y2ggc2V0cy4NCg0KLU5pY2sgSGF3a2lucw0K
