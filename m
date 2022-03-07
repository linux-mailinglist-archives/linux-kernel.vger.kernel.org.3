Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA64CF36D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiCGISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiCGISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:18:52 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8432A25F;
        Mon,  7 Mar 2022 00:17:58 -0800 (PST)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22773rPH010793;
        Mon, 7 Mar 2022 08:17:47 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3en3gvrycj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 08:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0m5hstrmVYKlcQ6Q0mJPLAD6cyDOe9RSbWGiK1Yx0ucteQuKHysSI9ytho9fvWnFvHu5YNFlYPaZqHYyVUaRDcyTK/KAzpRrFNoz889JNgJeEx8Aro5vaYEPxOs33fEi6p+jXSrOA4WfNixfoPSeV0att3xKqzMx5+klsMxJnvBx+osBZvCU1bTGEhKjXA+/S2ttT0etJxViTy1zm1o4gmmLs57OC2jzaP7Fan6mgh5oe9K9bcSjnONxtvpCibaMkiEzCH3NvFhqVY8E24uj8oV0uX8uu4fgFbDPpOctL/pGO6U1TdLExSP9dZPjHo/XjOkCOAKVO1bq67rwN4ZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrM6KnPgAqMYMNb4c6yGIeawTaWsKazL45t03nF+hok=;
 b=Xb6+x0YmhSdSHd7ooIWepmrl8M/k3S/MjOgS144JH7X/xMID/BXVIqS984AYdEVxh+X4YdM/o6k+cmtRXVthWMdmrItSS/0qeHXdDKfFk1SO+LW6ghjv03XwnYFfgufNrKTwmCaKvS2FPIte11guEN9jy9+qZ04OHh44p1HqWm8uRp2cLLOCPNvhsvk8QEMnksf/OHYlMXhPkL7OH4GIcf9ngUgse661FP/eb/8IS1/lHiaPhhCUt046alJ5zH+I+i5kf0cLgadVVgBF6XLa1tkJvCs6dG67C8PLi5YCYuN/4dMmKfEVvfGrB31k/zyw5u4c5YFAbr5zgh+a4Gq8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrM6KnPgAqMYMNb4c6yGIeawTaWsKazL45t03nF+hok=;
 b=myyr77I9mBXA5pbHZI4yNmNOx9oIE48edExfmZXzJ2VTwPS/HJcakp3DqjKVcuoUIie5zRA5oHw3MtW45a1TtIHtby5MW+QpcX2ZPGyGN9En4G5fg/JYTp4FcftKkjp0lVRC29VhIdmU9/8A6Efegr8/zC3fFZLxxHNEw7AVS0u+eU3OoU413jTxJe5DXSK5bs7H/JS5XNsjPEB9U78lcBnvM9f29XExIhvEH2D2reUiGIEl2LOPjDYGltpntupjinqb8L83IDys6QqslVf9k4IjMufrLDPVFk4hm5tYdtUmHhz73hzQF8vode96OiYp3ik05aUgsOteIf8iG2PqxA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB6PR03MB2887.eurprd03.prod.outlook.com (2603:10a6:6:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 08:17:44 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:17:44 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Xen hypervisor
Thread-Topic: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Xen hypervisor
Thread-Index: AQHYMfvSuP8YiJuDk0OiMGC/BZe6Bw==
Date:   Mon, 7 Mar 2022 08:17:43 +0000
Message-ID: <aece6fd976980131120456800de3558e1e2308a0.1646639462.git.oleksii_moisieiev@epam.com>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1646639462.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a5aa67-8cc5-4461-49f4-08da0012f4bd
x-ms-traffictypediagnostic: DB6PR03MB2887:EE_
x-microsoft-antispam-prvs: <DB6PR03MB2887C3E0A251928610EA3FE2E3089@DB6PR03MB2887.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nyzA5XHre9YevbSphcrGoCccjPlTdQ0iHBInKDeuj303C6nVDrhrULGOMfp0Lip4/EhtgkxV2HsmjxB4sImHE+VBj4RSZ3mFYcC+PY8f7mNEwbU+l66MsdXvm/x2h1q9npUkBu6Kdd8f2iJ2TbDOhVhEk030+tcFWdRFrRYvkj+P5XIRHtT5c28/qJLqxnafai+qsXLcJdPpC8Aqd70MRp+YOdt+XeUgn5cthVCHkXrrgQteSOj4XRhxbWKJsUn1lQsM7feS/z+xXiPmp3r71Sd6csuffys/SGK35A9lVSJpyKtiwRG0ME6IxUBuA9PAlpzbVlcn1MnnciVHJTMIXXDLIKnFNdrE8fQGI/fEkoydbOu+5hGJkw1lduGic02LwozOjqBPmJfZ+w2JUpFw/F78rK8tlR9GdZztgFDC7VqLzj0swnoI6CO93bQPjgmgfm74ESSze5E+1v+VQBz3wWAocRBgQVHKvCKmFnDkAdY46wKS4pa3qDx69BfaN3o/1ZvQ+a93/KBXAPJi9qbHhDV4x+1usUo2Q/hjGuQG/n4FW0WA4jWyZxOTtJKbVijbzXzL1bf57ST8W7EFO2/382xxP0xURp1mCzpQne3RkKf+ImjPEkyaCHVs1DhF277FyFlmY3rz+VC9mgJl22ZgCsh18tr299aUcjcB6I1AoygIiOlu1qHlNF/a0pLcW1ZJodpuf5Jh2BC+V+64poKkbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(91956017)(316002)(64756008)(86362001)(66556008)(66476007)(66946007)(66446008)(122000001)(8676002)(4326008)(2616005)(71200400001)(6486002)(38070700005)(508600001)(6506007)(54906003)(38100700002)(186003)(55236004)(26005)(36756003)(6512007)(2906002)(5660300002)(8936002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWJOenp3ZnBTdlhBbk9pZ0x5WEoxdTNLNnBwNDBiMkpCTGQ1R3N1RFJaUXNo?=
 =?utf-8?B?UEpLMG1iUzRtTGNYYTV4eEhWbStQdVYwTk8rVzBMZ01MbGN1d1owb1RpNkZX?=
 =?utf-8?B?Z2VhRXpZcnVMVFdza0VncEhxRTJvazB4emhpRlB2SEZlQUwzcTRUZi9TeFgy?=
 =?utf-8?B?dDlrS0ExTlhseDZlL3dUSzFTK2NiTm1lUDJUcWpNbHFXMzFNQk5kMXBzWWdE?=
 =?utf-8?B?S2NzcE1oWlI5RjEyTTJvZWNKZ0xzL2ZwN056SkxEbVdiUDBkVjJyUXVKb2cy?=
 =?utf-8?B?bVNDK3FsQkNRNEJucEo4N1BIa3M2RUpyYVp6T0ZXc005V2pHUjJySS9Mdysr?=
 =?utf-8?B?RTBzWGVMd3NGTHc4ZWhUWjFRTi9EWHFDTW5IbTRoNlJmR2NSWFBwTEE4VStS?=
 =?utf-8?B?L1h5d3FKd0xYTXc5WWJhbldiNkNPcnk3ZE5iTlpOdjlMVjdDbHA5WVhYdWhM?=
 =?utf-8?B?MUZIRSttcWJBUWM0elZBcUYvQ3gzZWNuaUFjbnFVRFBxbmV3TDUwTE9KUGFa?=
 =?utf-8?B?bU9VcUJEUjJiSXlSY3hBaUNSMEh1dWRabjRIaEhHdWVNaGdYSDdJNWZSSTdz?=
 =?utf-8?B?WUhaVXZoSmZYRnRiRmhUbzM0SmhIaFBBVllaUkxqNGo2UVlUaGVWTFFsVGlP?=
 =?utf-8?B?aTdYUFQrdHZFQ1NFblRoT0FlUkJWR0tQMmdjTnNkSkZXUDhqK0dCVTltdGM5?=
 =?utf-8?B?OUdHZ3VGcXBnQStrQVB4TlQ5c0FCZjc5Y3Vab0k2akhhOFZUL3RsY2N6NTNy?=
 =?utf-8?B?WHRDOWxYLzBlWktNVlBMTkFCUU1VcWxmdUQrL3BBNVFMMXh4S3FOajJHSFd6?=
 =?utf-8?B?UkljZFRsMFRYaFBEaHpGeUEvaHlYZGdPOHRaUUV0OWh6QzFqQUdmYU51THph?=
 =?utf-8?B?V010Ryt3d0RuUm4yOTI2dWYwV1hPenJJSlIvbFlZLzFueE9nT0c4Y0xWZDBa?=
 =?utf-8?B?czFjeUd4UkdmWDFoMFNWV1FKZDlCdE5aWDZwcGpPSVRqS25QMVN4OWhMRmlj?=
 =?utf-8?B?cUhjdVdmeGFlQnJWUUtaeTJRQitkZWNhWUZrRndSRTREamVMSFB4S3I5amZR?=
 =?utf-8?B?NHFOMHdXUWNlaFFHUGw5WkZnTW9BY3lZWm5oYnowSGhrMkdCQnBQbHBWWnZD?=
 =?utf-8?B?amE2VU1PaDNUNW94dk9RRkxnUFN6WXBoelNMdTZINFpCTlZiZ281YkNlanBS?=
 =?utf-8?B?NjFRbVdXNGpqaWJKV2lqeC84a0hQcHRWbU81MTFBMzRndXY5VUltWXZtclYv?=
 =?utf-8?B?V1AwY2lMd29Rd1g5aTVxejRRbUtVcGZLM3E2TVVxOFZSNGFlZ0YxL21Vd2xy?=
 =?utf-8?B?SXJKQnJubmMxSGJDaEF3OGdhTDFlYnJQNWRlVlI5Y1Y2U2sxNS9mdGJSWCts?=
 =?utf-8?B?aGZoTmN4ZkYwU09uN2YrRkcyZVcyWEdSaWY3bkRlTTdVSEZrUlVjYnIyc0l2?=
 =?utf-8?B?c1JvZzZIdEpjbHUxbm5ZcHNrUTVQUzBFMmVhT3NtMXp4ZWxJbDgwWUEzQ1V3?=
 =?utf-8?B?RVk3MXNFQW55ODNUakpTS3hBdEM3TTU0SHlPTk5EUFZsMVBwRDlxY3grWkFV?=
 =?utf-8?B?bUVCT2xUQXFreXZwamtTZlJoanh6eHl2TWlNNUpsQ1RXQk5YalpPZEZJSjh4?=
 =?utf-8?B?YUo0emtSajd6RWc3cDh0UGdXLzFnVW9OOGw3YkFwNFlobFMwd056QTJ1MWdX?=
 =?utf-8?B?cTFoNXBQY3lWS0srUW9BR08waVRBYTRZdHhMejQ4Zk80eEs3TFdIdWNBTzly?=
 =?utf-8?B?Z25pNjVXdm5nL3dPYWJ6MUNDbEVjSElxTE5KT0tqUjJobGpqZ1pHR1dEb2tZ?=
 =?utf-8?B?d1BHblVORFl3N29vYW1lYUNWYkVqYnhFMmZWbVlsRG52YzMrSEgvRVVVemNO?=
 =?utf-8?B?ZHBmRTh1cnNrT0dzUmRXRUcyaEs0M3VLS0VTNmZjQlc3UkZ4djdwcm1kdUN0?=
 =?utf-8?B?Rjh5V3kzQkJFLzI1QWxLVWh4T1Q5U1JKTG13UXphdzhqOTNtSUxpa1YwTU05?=
 =?utf-8?B?SXRyQ2J1RDVaYWFOVXkzOXFqZHFXeTd6eWVjUk0wblRlWm05bXNqbkNOQWdO?=
 =?utf-8?B?dzB0SWVpa0JFS2NXSEZDMWtBVUwvdEJxbW4ra0tiWnlobHR2a3FsZlBmL3Zh?=
 =?utf-8?B?cHZrS21MQzBMU3FURDFSbHRpeTVtRUJPZVN4ZW9vTzZNSDF6SSs5eWNrN3RX?=
 =?utf-8?B?em5JcFgzbDBvMDhzTHI4TElUdXE0MVN5emh5OEtHR3l5cDQ0dHM4R3V3MFJP?=
 =?utf-8?Q?IdUyToILAgJpZ9nfkj5naDgwbKzYw04rGvseCrGdDE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53DD991A711E964793F14CCF563B3AE8@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a5aa67-8cc5-4461-49f4-08da0012f4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 08:17:43.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaTzJF2cYkp9CumziAkNb7CW2BVbn0zVual8tErC65wj2FD2j84h7BXxwihygI7jgKdSQQPNKWRtdwIr4M9MTpOrhRr3TLvNaG0TshG5pRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2887
X-Proofpoint-ORIG-GUID: c6qSwAPDac8D_anS13q1Zy1X58T9Uf7D
X-Proofpoint-GUID: c6qSwAPDac8D_anS13q1Zy1X58T9Uf7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=828
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WGVuIGlzIGFuIG9wZW4gc291cmNlIHN0YWdlLTEgaHlwZXJ2aXNvci4NCg0KU2lnbmVkLW9mZi1i
eTogT2xla3NpaSBNb2lzaWVpZXYgPG9sZWtzaWlfbW9pc2llaWV2QGVwYW0uY29tPg0KLS0tDQog
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sIHwg
MiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbA0KaW5k
ZXggMjk0MDkzZDQ1YTIzLi4wZDEwYTU1ZGY5MTAgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnlhbWwNCisrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbA0KQEAgLTEzNjAs
NiArMTM2MCw4IEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KICAgICBkZXNjcmlwdGlvbjogV2FuY2hh
bmdsb25nIEVsZWN0cm9uaWNzIFRlY2hub2xvZ3nvvIhTSEVOWkhFTu+8iUNvLu+8jEx0ZC4NCiAg
ICJeeC1wb3dlcnMsLioiOg0KICAgICBkZXNjcmlwdGlvbjogWC1Qb3dlcnMNCisgICJeeGVuLC4q
IjoNCisgICAgZGVzY3JpcHRpb246IFhlbiBIeXBlcnZpc29yDQogICAiXnhlcywuKiI6DQogICAg
IGRlc2NyaXB0aW9uOiBFeHRyZW1lIEVuZ2luZWVyaW5nIFNvbHV0aW9ucyAoWC1FUykNCiAgICJe
eGlhb21pLC4qIjoNCi0tIA0KMi4yNy4wDQo=
