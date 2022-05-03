Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54651862F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiECOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbiECOMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:12:44 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB83879A;
        Tue,  3 May 2022 07:09:12 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243DK3lO000871;
        Tue, 3 May 2022 14:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=pKwh5hyfKZ6wyu4Xfjkyfg6iLbTDZu0l8wrYdjJKM00=;
 b=PHJESw4X8+7L7OE7IiWFMfAs8Izuxj6izsmDbDt9uXoMj8rJxug1IHW+SHTmYDvNsvuY
 h/5x0WT38/r7SAMPBENI1f4v3Cex7Xtnm7SkKkSiuOBWDU4JgGBftuUI+2Yt2nwzAqUM
 AKfiEuqEHv0gXXGczhDl9DxXLVgkSld3Ua0NMYN9b4VkGqOvbEP9kA68XaAKTpBnZCV+
 dgyBVsOoKYOY6CvkwmRBDp149ZoXtcy3HSI+AFK61EHs58MLP6/87TO1Ev6oHKL5DwHf
 gmLbvh95x4+DN8I3BZwJDoo9BVQ/Y+lvM9j5iP8g22k/vDuveJ9RwRwnFmVMi4GYOs0u sw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fu1f92b57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 14:08:58 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8DE98805E0B;
        Tue,  3 May 2022 14:08:57 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 3 May 2022 02:08:51 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 3 May 2022 02:08:51 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 3 May 2022 02:08:51 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 3 May 2022 02:08:33 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuSu/tpGgpAFGyA0nvvE3B2KNlhXltwcEEkpYmqhM0EGzkpA/zKzquG2oiIKTkSvi9HSVOtfOBfEdXrndB8ANs2SolukUgqRV0SCkwQj2HcENQlh6Y1WZILk9dYPwkr0n9E8U55YBPDT/6UTgFO3d1T/bf+lrXPMrSKFyyiX+tNktSocNu0LKzC/lBvTTa875g/LoSxqzwHZlvxuGKMCSFWJ3aDqdqYSJDh2vwgYzm/CBlhxCK6HltWxJIY8Ct9ixMewn883USjn0+07MpPANXnI2/34SSMheu8adUzie6g+8YKMlSrL5YCZPF72G0J8ZiyzArT1BAIavA+5cVTSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKwh5hyfKZ6wyu4Xfjkyfg6iLbTDZu0l8wrYdjJKM00=;
 b=MKKxeJxztIqcP7ud1syyjZ1CsAT7hAJkoQDl4PZdlkQekFh5aV+lKHbV13QI5P9D4dpa++TH7ScILz0TukQDugKcS1yMUpMP54Z8gKIE4IYi/i4J6ClXTwzjjK/G1MpHNRgV4oZ5m37QbGajmXz1tlwsl5xerPChCLomNT23CmQbv9b3B6WIYh/dlkXFZbt05b61k/8IgnhEL2WTqieYdNjwJmh435fI+phEZ9MFPVQNuUUklSkP3KQTZM9Nq63F7zG97DfftVjxw4DMhyVGqj2vy+d9ciFuBCVkJDq4UzTVM48s6P7w/Rtq9hKSc3QXUZmY7uqrl21Adbn0Ny6f5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by SJ0PR84MB1387.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 14:08:32 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 14:08:32 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Olof Johansson <olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 7/8] ARM: dts: Introduce HPE GXP Device tree
Thread-Topic: [PATCH v6 7/8] ARM: dts: Introduce HPE GXP Device tree
Thread-Index: AQHYXmTKMgAnIeG/Tk629X6tcmENZa0M7HeAgABB+qA=
Date:   Tue, 3 May 2022 14:08:31 +0000
Message-ID: <PH0PR84MB1718A4E67E6B7585099B84EB88C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-7-nick.hawkins@hpe.com>
 <c4d85ebc-05f1-95d5-ac71-ba92527a32d5@linaro.org>
In-Reply-To: <c4d85ebc-05f1-95d5-ac71-ba92527a32d5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9939ce11-7264-44a1-07da-08da2d0e67b5
x-ms-traffictypediagnostic: SJ0PR84MB1387:EE_
x-microsoft-antispam-prvs: <SJ0PR84MB13870F0D143DA3B3B5DC008E88C09@SJ0PR84MB1387.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 16k/HtEaZk7Hr+ayLHOdvDx+Urs/JD+Xqe0CrFRzzPvlqVI2xWhqFjSH0+Z05HIsp3W1wF7KyV/r5HtJywOCiBGEvDfFN1I3rWZ4W+6M3P6K0/DCYNkWCrd7LpY9JnhtjgZp832H/3i3gWqvtbPZVf9kIbqtiw8Z70ORFvQO32WqVR4drljtYCFEI9jdFONlLIvLylQZXWaoHx/nD92K+kD5sk5e/He+pltLsDQ5TRRLqkizma8TSfV5uwGpxBdua1kgiJxcWgNd8DOVbjxdFBnNN2ejoZG0116DNm0kTrsaCQrtfwkSv1+3U74CIu9D1XoTSuGtus/ozL1WqzC5g9VTO+dGqm1d24NIOZLj76MoBkBLez18/Uv4+rIyYIG0j/TH7gQNMEaPhToByzKaE8AFFXPP9+f/S8JKTJyF6jRRHok34xzGubeeuqiEV6CZQUyCxj3dYO5knuvTocMPONy3ry9XMEK+E5YiY15HgDKBFjOTmsslYr6TKr1GkmirF9LTTixjNjzTQz4c98f9Ex43sUy2wCXBt7LvflqyAkYvN1Rez0BiIHiTX6Q0fLi/J9pfp/fK6aHy4vSh2F/KE60f0GXyWc8/eohJEQ/TTGkHBETd37P38pf8IEdhZKxGhShilZ/JanPlTyluAXQ4SR6w2lPnolWL6NWQdtS1JA6Iq7P9ARu3dgdB7XRhNCTtyT11ntm57ZLN2qK98BM1ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(64756008)(316002)(76116006)(4326008)(66556008)(66946007)(8676002)(52536014)(66476007)(66446008)(5660300002)(83380400001)(54906003)(8936002)(508600001)(71200400001)(110136005)(55016003)(2906002)(7416002)(9686003)(26005)(86362001)(55236004)(53546011)(6506007)(122000001)(7696005)(38100700002)(38070700005)(82960400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckRpT010WjNlb3dtdHlQNzJ1ckZ5dytCd2NWYzJVMlczRnhzTXptaVY1MGVj?=
 =?utf-8?B?WjlPQXEvdnNsWTdJTnE0T25TaXNtajltSW85ZW9qR2xGUnpVZk5vbHh3akNS?=
 =?utf-8?B?aEMxTmoxZStnM1FWNVVoMmIrS1B0ZWx3RzlBcWNOVkxwZmE0L2hBdnJrQkZX?=
 =?utf-8?B?aHROOFEzVDJoTlRXelRZeDdHNnBZZ0RlSkV3a2xGN0RSR2pvZytsdHNpajVP?=
 =?utf-8?B?d2tkTWZrRUxPUUdkVWNpdHIrK00wcGNLUXJBVE1GZ0QvQ1ljc3d0aXAzRGox?=
 =?utf-8?B?SlNZNDdsYzVZRUMzb3J0dDFuZFIwblFGMW4zZW85WHZuKy83THpEZFVmeGJm?=
 =?utf-8?B?bDV4cTlYZjFjT3ZwOWVxWnFTM2xKQWMzRVlPQnU2RWFJM1N1bm1waVdkaTNE?=
 =?utf-8?B?UVZ0TDFHajZBL2QxYWU3aGRaUk85RWpHWWNvV01hYUhvQzlybE1CaE1qKy9D?=
 =?utf-8?B?UzlLMms1YnRDRFBJUUxhSkRZZXgwYy94UEw4NFNoQThaQ0VWN3oxZkRvWTF3?=
 =?utf-8?B?YVJodmZsTDRVMXU4TS9qN0ZrVVBaK3MrUTgxeVYrY3lZbFZUNXpsU0ZOVUFG?=
 =?utf-8?B?QkgzOHhlNkpKWk0rdk94QzNxdE41SGtIek5ERWd3bFd0cHRzc2NUbGxDKzJ6?=
 =?utf-8?B?cS9samFlLzU0YjJ1bGJwU0habmtYcnFTYlhCTDF4dlBhbFhsQnNKVXRXeDQv?=
 =?utf-8?B?Z3dDWWlVQlFrb1lVL1ErUGJZTkVjS1hEd2JIYWpVSElpME8waTQ3WTVlUmZ3?=
 =?utf-8?B?K2NuTUpmdGlxUmsxZXFFTmtXTVlORjBnTEF0SUlobkI3Zk9xRlpRMTY1MTVQ?=
 =?utf-8?B?cndhN1FiNEpmODloOEZFVGgwd0ZBYUhZUE9vSkVBam5jWXJrYno5dUZnUzlo?=
 =?utf-8?B?ampLNlM5OEFudUZxdiswQTZEcmp5TFNWTmIxbUlyTnd1eW1oRjZieWkrTGtx?=
 =?utf-8?B?dHdLM0ZWOG4zdVBaVXN3ZmRoMjhiMWFXT200NzNSakxmamhWemRQZHVxdjFv?=
 =?utf-8?B?b1Fzd25EcXhzRnluN0hRbzR0SUgyUTBLWDFUVFBIZnA2YmhjT3pPUW41QUNF?=
 =?utf-8?B?bmMyakN0aUNmaUNCb0pHZHF4emxZTk5TVHcwV2tRa0JuQ0E2SW5GL2dwRkJt?=
 =?utf-8?B?TlMwQnRUdTQyNnJSMkYzOTBINUpLck95Tk1KWVdVZXo1ditmdmpyVzNHdWYy?=
 =?utf-8?B?M0Z1bUl0MlFOMWM3RHVaVDNuR3cxYWt4eTBoQVFqSWxYWVZaR0dNeXEzTWY1?=
 =?utf-8?B?dndEd25DRjdEdnh2UjJnYkorMWJ5U1hpcWU2Si9mSCswWG5veERNYnNWSnR0?=
 =?utf-8?B?TGtDNVVtVjRHblpneDRhTStFTER6MVduWm9wQkEwSkljQlV2K1ljQUtiSzRn?=
 =?utf-8?B?NVlyRE0vc01mcCsreDFqR0dDaThoUTI0bFB2eVhOdVNLQy92VWtnQXlpeUla?=
 =?utf-8?B?UE1QNjVWUy9jRDVmUkR1cHRMNlFOTTVhN04ranE0NElRRnhlUmxuY2wyQ0Q0?=
 =?utf-8?B?bVZacnpZTUM3eW5GNzNTWi9VWTgzQnd2SmgwRjBuS0FjT3ZwMksxblcyakRG?=
 =?utf-8?B?a05aVnlEWGxyTmpUNURNYm5GL1M1WC9xNGtVSVBKcmgxaGdBOEZwS3JUVlVI?=
 =?utf-8?B?bEpxbTZLTjdXS29uSnR3OFludTN0bHJtRzlwVkl5TzRRUG1ldUczYkdPVjdh?=
 =?utf-8?B?dzlmaDhHa3JaLzcrUkc2cVd4RnBQdDRIV0FibHV3czhYMHUrZERPOStPNmJR?=
 =?utf-8?B?YTVHNHc0WSs2N0FSaVJFR1ZKVXRUWDl5bCtUVFFuVzNUcEFXdWowNFBzNDhT?=
 =?utf-8?B?MlA3dEUyMHdTWUZKaDMrZkI2cksxN0crY21xWGJWeFVGdEN0WFVKbElKUWhD?=
 =?utf-8?B?UldWK2xlc0Z1L1hQcmxnVFZQWnB3cFd2bllrczFXMUxYZ2RpME0yZEd5azha?=
 =?utf-8?B?dEJvQjY1TWtlZzRLQXVtY1ZyNWF5OHpicHhicUN3RzN5ODJMZUVrNEdmNjBO?=
 =?utf-8?B?MHd0bGFISk1JNVhiQXVydi9OOXN0cW45R2dTY0M3VldVNDFBTHAwOU1pQ2l5?=
 =?utf-8?B?MHdrZDl6c1BOKzM2Zy9JVG1yWGIyUjhPTjROUjhhaWR2d01qTjRTQ0pYSWdR?=
 =?utf-8?B?MTVlajVWKzU0QmhSMEFkd29VaGlQYkM4K0xDVEczRGE5RGpEUkczRVlrR1Fo?=
 =?utf-8?B?QzVwRTRLdk96QnhGdG15dEU0b0RMNVUrcHB0NzJKQUhtb0lZZGRpeC9WWkZO?=
 =?utf-8?B?aWNwdFJnZlVuZTBaZE5yamZhZWY0Yit2UUYrU1ZrVXR4N2htMkUwVytyOEZI?=
 =?utf-8?B?Z2p0K2M4Nlp0eURid04xMXNGTVM0U1NQY1dUSkdGR3UrWC9rRjRWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9939ce11-7264-44a1-07da-08da2d0e67b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 14:08:31.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzwFA8NZ7dMMK3lD/LefJ88fh2g9Cnx1BwwVCFlnKlUusa67/Z9Y9bS3x8vWZkpBnMmorTCoqDeBQTOggwTfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1387
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 7vQBehy7XI2PraCZFK_tbAirsc-cG05k
X-Proofpoint-ORIG-GUID: 7vQBehy7XI2PraCZFK_tbAirsc-cG05k
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_05,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=760 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205030102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDUvMjAyMiAyMjo0MCwgbmljay5oYXdraW5zQGhwZS5jb20gd3JvdGU6DQo+ID4gRnJv
bTogTmljayBIYXdraW5zIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4NCj4gPiANCj4gPiBUaGUgSFBF
IFNvQyBpcyBuZXcgdG8gbGludXguIEEgYmFzaWMgZGV2aWNlIHRyZWUgbGF5b3V0IHdpdGggbWlu
aW11bSANCj4gPiByZXF1aXJlZCBmb3IgbGludXggdG8gYm9vdCBpbmNsdWRpbmcgYSB0aW1lciBh
bmQgd2F0Y2hkb2cgc3VwcG9ydCBoYXMgDQo+ID4gYmVlbiBjcmVhdGVkLg0KPiA+IA0KPiA+IFRo
ZSBkdHMgZmlsZSBpcyBlbXB0eSBhdCB0aGlzIHBvaW50IGJ1dCB3aWxsIGJlIHVwZGF0ZWQgaW4g
c3Vic2VxdWVudCANCj4gPiB1cGRhdGVzIGFzIGJvYXJkIHNwZWNpZmljIGZlYXR1cmVzIGFyZSBl
bmFibGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pY2sgSGF3a2lucyA8bmljay5oYXdr
aW5zQGhwZS5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gdjY6DQo+ID4gKiBBZGRlZCBjYWNoZS1j
b250cm9sbGVyIHRvIENQVQ0KPiA+ICogUmVtb3ZlZCBocGUsZ3hwLXdkdCBhbmQgcmVtb3ZlZCBz
aW1wbGUtbWZkIGZyb20gaHBlLGd4cC10aW1lcg0KPiA+ICogQWRkZWQgc3BhY2UgYWZ0ZXIgJywn
IGluIGNvbXBhdGlibGUgbGlzdHMgY29udGFpbmluZyBtb3JlIHRoYW4gb25lDQo+ID4gICBpdGVt
DQoNCj4gSG1tbS4uLi4NCg0KPiA+ICAJaW50ZWdyYXRvcmFwLWltLXBkMS5kdGIgXA0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9ocGUtYm1jLWRsMzYwZ2VuMTAuZHRzIA0KPiA+
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaHBlLWJtYy1kbDM2MGdlbjEwLmR0cw0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42OWU5YzY2NzJlYTgNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaHBlLWJtYy1kbDM2MGdl
bjEwLmR0cw0KPiA+IEBAIC0wLDAgKzEsMTMgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogRGV2aWNlIFRyZWUgZmlsZSBmb3IgSFBF
IERMMzYwR2VuMTAgICovDQo+ID4gKw0KPiA+ICsvaW5jbHVkZS8gImhwZS1neHAuZHRzaSINCj4g
PiArDQo+ID4gKy8gew0KPiA+ICsJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkjc2l6ZS1j
ZWxscyA9IDwxPjsNCj4gPiArCWNvbXBhdGlibGUgPSAiaHBlLGd4cC1kbDM2MGdlbjEwIiwiaHBl
LGd4cCI7DQoNCj4gTWlzc2luZyBzcGFjZSBhZnRlciAnLCcNCg0KPiBXaXRoIHRoaXMgZml4ZWQ6
DQo+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmc+DQoNCkkgZm9yZ290IHRvIGNoZWNrIHRoaXMgZmlsZSB3aGlsZSBmaXhpbmcg
dGhlIHNwYWNpbmcuIFRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcgYW5kIGFwb2xvZ2llcyBhYm91
dCBtaXNzaW5nIHRoaXMuDQoNClRoYW5rcywNCg0KLU5pY2sgSGF3a2lucw0K
