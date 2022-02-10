Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE04B18DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbiBJWyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:54:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiBJWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:54:49 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C25555A4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:54:49 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AMm7qY012985;
        Thu, 10 Feb 2022 14:54:42 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e5134awym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 14:54:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNoNKZaKrGgfyPjR3NirA2tex+TVIaVAtGCafBjAQX5eM6yxegwhTUQKvKUA3TeQVwYfQ8FGv0RRlA6ZJn9t1USz4amIZLVahbOl+Y4tfvdqelRH7l58v2U38/XJ5MxjBERT0YbEwG4kKWYGVC2W8a0Bs5ckkOw+f30d5QDgNqtz0pNWZBMIEWDKULmyoDkDp7dI1Jpp3GZTBXpQ3J9DsA3OiTa95DCvI4Y3EFF0wpbvsB7d+By1l8vFtTHctGJzyz1TFBUgqWGgr+2H/7lcH/RV8+ZFxcsTji45lYe/Z40E2Jc8BaCviNCBHehtYUvTNCQVRlA2ymqgC0is69EJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JjUlDzNABzYg5CCkTkd2ypqXeT8i5ijZRXIVFKepp4=;
 b=lbuE94KFmL73e/wfvFK/4Jvl6r74dLIio+ORwBKMRr6EFIiF8B64aItwd6GmZF/NsbZppAZ/EHSX03AsH+9OG3H/PbK+iB5KZ7JS7USvEfPP6quVFRwHmNC2U7oLOVuGS4vvSejuR7fy1OQWiugUrfbDpi5i+gyintCOfNaIpQAnkuni/mZirneJvKzyDQJCUKutQ4uhO0KvOcJh8Ezw+3eUnq4UMDHYDAzPG4ah7mY84k1yTbE62RONIDHwaMlPtpcsO4Yvw3UBa/BEDpTq/O5BttOqgVlt2YqInrmxN9BE9XiXpLOwWbtdS7u0QAh/nC2pyFwLPfRkJy990ocZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JjUlDzNABzYg5CCkTkd2ypqXeT8i5ijZRXIVFKepp4=;
 b=oGvF/ogka5cPBRpgqc21MA0h+79N3FZUrswB93XuC2677qee0vXDpCbIxszmn/kLI0fZd75f3G2wAmC1ACDNKeXF/lm0QYBr4rMa2dlolqxNbc9IS77CcxQfTgoW0LBr5lBp+eRRfSfO0xBM4h1nJYHWUGeloelNeSO6sGRpKUE=
Received: from CO1PR18MB4732.namprd18.prod.outlook.com (2603:10b6:303:eb::13)
 by DM5PR18MB1100.namprd18.prod.outlook.com (2603:10b6:3:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 10 Feb
 2022 22:54:39 +0000
Received: from CO1PR18MB4732.namprd18.prod.outlook.com
 ([fe80::d0ca:ef26:60b8:7546]) by CO1PR18MB4732.namprd18.prod.outlook.com
 ([fe80::d0ca:ef26:60b8:7546%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 22:54:39 +0000
From:   Radha Chintakuntla <radhac@marvell.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Satananda Burla <sburla@marvell.com>
Subject: RE: [EXT] Re: [PATCH 0/4] soc: Add support for Marvell OcteonTX2 SDP
 block
Thread-Topic: [EXT] Re: [PATCH 0/4] soc: Add support for Marvell OcteonTX2 SDP
 block
Thread-Index: AQHYHgZNBD1gpIqhuEWaau391usoLayM+uqAgABmLuA=
Date:   Thu, 10 Feb 2022 22:54:39 +0000
Message-ID: <CO1PR18MB47325CFE16B698984D6A926DC52F9@CO1PR18MB4732.namprd18.prod.outlook.com>
References: <20220209224210.153907-1-radhac@marvell.com>
 <CAK8P3a29uJF+dVVjuKmF=rRDJrM2ndbxRJPFt9ga-waQcECb+A@mail.gmail.com>
In-Reply-To: <CAK8P3a29uJF+dVVjuKmF=rRDJrM2ndbxRJPFt9ga-waQcECb+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b6ebb6-4062-4311-1c04-08d9ece85195
x-ms-traffictypediagnostic: DM5PR18MB1100:EE_
x-microsoft-antispam-prvs: <DM5PR18MB110060650440E7EA7CE13441C52F9@DM5PR18MB1100.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWZiszDlVtYvp73Gm7FVfbFc43i8ATt+fs/Rfmd/Dhgz7zWhGaRM7NVfqIm9Ea2ZyJrZGcBStd+hGDbCpydAWWaaW+3yByzdX91DGQtJIfpMTAaIYPJ9maP5ujy00nzNAL44eUh/vpnRQcbIRXuEX8YDa24oF50yXmn6kFJ8Sl++qQkSRlvuPyX0uHfEqaL2d4w7JgbPj/aamm7na72qyB5wtFUOUoNft0SV860nHQjB88G5FJCA6Sbw/8u1ky3fQrIxehDjuSD5gIkXhY4PjIognLL5WAPlE3+KwyH7Y1EpzBnPrngMJoTJFBvWs5TIxQBrajG7rtm+9TXybMozDmlOiHCW7DT1gmuZrG3roizwPVBFj9ap5ENtdT1AuIUtXiiJzhG6abVOP63N979zOqQCCU78pMcuTs60pOdOnjipz9VPWzO+0/hLxdEVTsGGH+kz2bttQy7Ygch7b3sYLqUWuoDdOCktCYRcdDCUtX2VxnECqNWmuac1xV61GELWZz5JlGfa3GdWBFKT594hn6CJsK83Jy4RJb++4g9EI5B/XyUtTYQ2PYc56H51cIUxHKGvK3melxYsxG7ggmhGEtQjIkiLO0RAaMYF+lXg1gTZf5zV+6iDpDW3hRe3tQNa5LyorI/I23IUxWYPAHCNI1qILf1TTATdJFsr1zz9CHOzQ2S3NF7g2OZtjdGIPEoruW3WyAF64ADSuHfiSsDYdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4732.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6916009)(66556008)(54906003)(66946007)(8936002)(316002)(86362001)(66476007)(66446008)(64756008)(76116006)(8676002)(4326008)(38100700002)(26005)(52536014)(53546011)(6506007)(107886003)(7696005)(9686003)(122000001)(38070700005)(2906002)(71200400001)(508600001)(33656002)(83380400001)(55016003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1U4L2swV2tsQVhvZFR1VVN1M0s1b01pVTdqclluUE1DdHVUdXpqV1VqeVJC?=
 =?utf-8?B?YndxUHIwdW8vUXVCanEzWnZndHFUeTI3cG5vOVFqRmR2NnI2Zm1SZG9lY2hM?=
 =?utf-8?B?VW1wS2JzZzJsRXJQRG5kZTVXZzFxclB0N3J1TVY4OUZ0L21BZWJ1eko1Ny85?=
 =?utf-8?B?STBUQmlhamJmano1ZHFRbGdXaUpHMzMwcEZnb3kzOFA3UklyVUdWTGVkK1R5?=
 =?utf-8?B?ek91UkNGM2VsRm5zVi9rZW15bEdBTW5jQWJXMHJTcldBM3Izd1RsSUJUYjll?=
 =?utf-8?B?ZkZqdGRjUnlMM0RQS2dmcjR6NnhLUXgyYkdsalhGajZ6YlNCUWUwMVA5Wm9H?=
 =?utf-8?B?V0ZHM0FnZXI5MFUxNDVGdG9Cb3JWc01CSG9RSERUUWdFeXRIakxyM0lUVS9V?=
 =?utf-8?B?SzAyK25YWnZGQlVFdzBwRnFaVDUyRitnT05pNnhjUW9YamF4ZmRzOGhFd2Jw?=
 =?utf-8?B?NExzT3FVRC83ZUNrTDJyZ0lWNGpNQ0dIcGVUcTd5S0VzUG5jTWtRd0xTZ3JG?=
 =?utf-8?B?azA2Z2ZDWmhSd3ZFNitJZ1cwUmd5MGhhNEVHaEdrNXMyZWJjUUxrNitab1lR?=
 =?utf-8?B?OGVBWkNLWXVSMkNYc0dieDZ3WVpQUGpNTHY4NTRHc0xBcmJVU0pCbGZYdDQ5?=
 =?utf-8?B?ODJaak84cEdEaFFSTU1QamhLYUtFSnVWSzNYUFBxV0I0VklhelhMVzVUclFF?=
 =?utf-8?B?bHNMTHpiRzFFZDB2cmRZWUZyOWpIS0xMbEo1TURvcUlEVm9jajYzVm4zblFZ?=
 =?utf-8?B?TW94VGE3NHFUWXRqT0JHODM3MXE4Z2RqOVFVUGx5YTVRUWRsTnIvWXN4RHNp?=
 =?utf-8?B?T2p2MjY0SDljOERhU1A0emJFKzI4aDBqS1ZKanRVSTlXU0xLWU5aQWZoU3do?=
 =?utf-8?B?TVprb0JBZkZHeGVMMlpldmR6am5nZzB3UkxrUkYxdnRwVEpaazZPS0tWa1h4?=
 =?utf-8?B?WjV3TVJVejl5QmFVVE5EcjBJejVlZ3RGNjN3SU9TOTRrR05STGMwK3c4Mlpm?=
 =?utf-8?B?b2ZCUk5icXpRZWJUQzRRMytQT0ZpbEh0K0lRcU9zMlNiMUZIWUkwY0dtNStH?=
 =?utf-8?B?K2Jyb2ZLNnJQV3ZXS0FRVFNqN214VXFJOXRyRjFqd2pyUjh4OEVtMVJqekZx?=
 =?utf-8?B?YWRZZUFDTXJkbEVycEdDWTN4RC8rUWovTzdmcUN3bS9SRUFMalU1SDBkd2ky?=
 =?utf-8?B?cE9DdWpjSU9NODY5dkpMQUpHcTFPVERzekw4djFpL2JGaUNadGNPbmViUHpZ?=
 =?utf-8?B?QXpIcitJZ05jNHg5cTdFaEdiNWp0NVp4Z0lUZ3k5dlJNdjNaSzdnV2pmd0h2?=
 =?utf-8?B?MmpaT1pSYkdDdmdyZGV6RUpwSmFvN1o0NUJ1dERJQ2ppMldRaEN2MERvMU5G?=
 =?utf-8?B?UHJkM2d4WHd3QWtOVXkremtMQkdEWEl0SUZjMjJ5MWoyTU82ZURpQTVqZzZj?=
 =?utf-8?B?RVRYMDJ3Z2xyZVR3QkJNNTJTbThTM1FLU2YyQVNUVjBwNktnZ3FCNFBSZmd0?=
 =?utf-8?B?YjYvcEwza0RKQmJhV1haNVJtdkhRRll0Qmg3NjJobmtjNmQ0ZkN5ajQvZ3lX?=
 =?utf-8?B?eHcwR3hFb25LOXJ0aXVQUjI1dkgyZjJCV0VxSlJJNExvR0szOTJkMFk2d0Q5?=
 =?utf-8?B?ZWNadVJxS1J4ZEczeVBXUFRGb2NpRTJWb2FMQTRTNk9nSDFzTm1sY0hOMFZT?=
 =?utf-8?B?VkFKU3lsMHZ1L3pud1F2Y04wQWRUTFQxZEdadmYwTDR2d1A2a04weTRCMkNM?=
 =?utf-8?B?MzRvc3MxMHZUZ2JLd3lBRGtMaUZGbS9VbXB2WFlQdC9KMitKTWdpMmpvQUFu?=
 =?utf-8?B?N29NVWFjaDBJZHpMcVliS2d4ZUJpQXhhNHA0SUdDQW5MQzJDNi9hWHY4bU1Q?=
 =?utf-8?B?Q2lsci9hbGtXYnNTL3VESmwwSi92SUd0aGI1aDZYd2pKT3p6SmtqamNzenVs?=
 =?utf-8?B?bVVrOUpIbmNuYUlreVBubTQ2VUpjQWZ1OVlMVCtsNkRGWHc3U05FWVA0R2JN?=
 =?utf-8?B?RXRTNy96SDkzQXp5bFFPNmFUVTBHVHlvWmZERHNUTzBPWDRRUW1vTnhKSDBW?=
 =?utf-8?B?eGowVFoxQXlaRjVzVG5YTkFRZHRkTE5sM05sNHdQV1pDNk1yZGd3ZFNmcnR4?=
 =?utf-8?B?eTVVd0xKUGZmbG81RXFtZHQ2U01iTjNlWmdQeGZOZnc4ZXpPLzh1NlpvWGFP?=
 =?utf-8?Q?L6wFUWryTNDVvZa0zTUaCEg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4732.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b6ebb6-4062-4311-1c04-08d9ece85195
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 22:54:39.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wCYqX8CSkSqtuobjjM77z+4dT9P7WkEktxnmnS/M6K8IUuqSSzdL4066qqwL+ZpDVN4qXQKLjs6/UzcFbNQag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1100
X-Proofpoint-GUID: NZ9ZyqxKNfs9or_Gma0OOHLw9QYAzmdv
X-Proofpoint-ORIG-GUID: NZ9ZyqxKNfs9or_Gma0OOHLw9QYAzmdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDEwLCAyMDIyIDg6MzAg
QU0NCj4gVG86IFJhZGhhIENoaW50YWt1bnRsYSA8cmFkaGFjQG1hcnZlbGwuY29tPg0KPiBDYzog
TGludXggQVJNIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBBcm5kIEJl
cmdtYW5uDQo+IDxhcm5kQGFybmRiLmRlPjsgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBs
aW5hcm8ub3JnPjsgTGludXggS2VybmVsDQo+IE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IFNhdGFuYW5kYSBCdXJsYQ0KPiA8c2J1cmxhQG1hcnZlbGwuY29tPg0K
PiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDAvNF0gc29jOiBBZGQgc3VwcG9ydCBmb3IgTWFy
dmVsbCBPY3Rlb25UWDIgU0RQDQo+IGJsb2NrDQo+IA0KPiBFeHRlcm5hbCBFbWFpbA0KPiANCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiBPbiBXZWQsIEZlYiA5LCAyMDIyIGF0IDExOjQyIFBNIFJhZGhhIE1v
aGFuIENoaW50YWt1bnRsYQ0KPiA8cmFkaGFjQG1hcnZlbGwuY29tPiB3cm90ZToNCj4gPg0KPiA+
IFRoZSBNYXJ2ZWxsIE9jdGVvblRYMidzIFNEUCBibG9jayBpcyBhIGludGVyZmFjZSBmb3Igc2Vu
ZGluZyBhbmQNCj4gPiByZWNlaXZpbmcgZXRoZXJuZXQgcGFja2V0cyBvdmVyIHRoZSBQQ0llIGlu
dGVyZmFjZSB3aGVuIE9jdGVvblRYMiBpcw0KPiA+IGluIFBDSWUgZW5kcG9pbnQgbW9kZS4gSXQg
aW50ZXJmYWNlcyB3aXRoIHRoZSBPY3Rlb25UWDIncyBOSVggYmxvY2sNCj4gcXVldWVzLg0KPiAN
Cj4gSGkgUmFkaGEsDQo+IA0KPiBJJ20gbm90IHN1cmUgZHJpdmVycy9zb2MvIGlzIHRoZSByaWdo
dCBwbGFjZSBmb3IgaXQuIEkgaGF2ZSBub3QgZG9uZSBhbiBhY3R1YWwNCj4gcmV2aWV3IHNvIGZh
ciwgYnV0IEkgaGF2ZSBzb21lIGhpZ2gtbGV2ZWwgcXVlc3Rpb25zIHRvIGNsYXJpZnkgaG93IHRo
aXMgZml0cyBpbjoNCj4gDQo+IFdoZW4geW91IHNheSBpdCBpcyBtZWFudCBmb3IgcGFzc2luZyBl
dGhlcm5ldCBwYWNrZXRzLCB3aHkgaXMgaXQgbm90IGFuDQo+IGV0aGVybmV0IGRyaXZlcj8NCg0K
VGhlIFNEUCBibG9jayBzaXRzIGluIGJldHdlZW4gdGhlIFBDSSBFbmRwb2ludCBjb250cm9sbGVy
IGFuZCB0aGUgTmV0d29yayBibG9jayAoTklYKS4gSXQgZG9lcyBhbiBpbXBsaWNpdCBETUEgZnJv
bSBhIHJlbW90ZSBob3N0IHRvIE9jdGVvbiBhbmQgaGFzIHF1ZXVlcyB0byBkaXJlY3QgdG8gdGhl
IE5JWCBxdWV1ZXMuIFRoZSBob3N0IHNpZGUgd2lsbCBoYXZlIGEgbmV0ZGV2IGRyaXZlciB3aGlj
aCBzZW5kcy9yZWNlaXZlcyBwYWNrZXRzIG9uIHRoZSBTRFAgcXVldWVzIHNvIHRoZXkgbWFrZSBp
dCB0byB0aGUgTklYLiANClNEUCBkcml2ZXIgZG9lc24ndCBkbyBhbnkgcGFja2V0IHRyYW5zbWl0
IG9yIHJlY2VpdmUgYnkgaXRzZWxmIHNvIHRoYXQncyB3aHkgaXQgaXMgbm90IGEgbmV0ZGV2IGRy
aXZlci4gDQoNCj4gDQo+IElmIHRoaXMgZHJpdmVzIHRoZSBQQ0llIGVuZHBvaW50IG1vZGUsIGhv
dyBkb2VzIGl0IGludGVyZmFjZSB3aXRoIHRoZSBwY2kNCj4gZW5kcG9pbnQgZnJhbWV3b3JrPyBJ
dCBsb29rcyBsaWtlIGEgbm9ybWFsIFBDSSBkcml2ZXIuDQpUaGUgYmxvY2sgZG9lcyBub3QgZHJp
dmUgdGhlIGVuZHBvaW50IG1vZGUgYXMgc3VjaC4gVGhlIGRyaXZlciBpcyBqdXN0IHNldHRpbmdz
IHVwIHRoZSBjb25uZWN0aW9uIGJldHdlZW4gU0RQIGFuZCBOSVguIEl0IGRvZXNuJ3QgdG91Y2gg
YW55IG9mIHRoZSBlbmRwb2ludCByZWdpc3RlcnMgb3Igc2V0dXAgdGhlIGVuZHBvaW50IGNvbm5l
Y3Rpb24uIE1vc3Qgb2YgdGhhdCBpcyBkb25lIGJ5IGZpcm13YXJlIHdoaWNoIGRldGVjdHMgdGhl
IG1vZGUgYW5kIHNldHMgdXAgdGhlIEVQIGNvbnRyb2xsZXIuIA0KPiANCj4gV2hhdCBoYXJkd2Fy
ZSBkb2VzIHRoaXMgcnVuIG9uPyBJcyB0aGlzIG9ubHkgdXNhYmxlIHdoZW4gYm90aCB0aGUgaG9z
dCBzaWRlDQo+IGFuZCB0aGUgZW5kcG9pbnQgc2lkZSBhcmUgT2N0ZXhvbiBUWDIgbWFjaGluZXMg
d2l0aCB0aGVpciBwYWNrZXQgZW5naW5lcywNCj4gb3IgY2FuIG9uZSBvZiB0aGUgdHdvIGJlIGEg
ZGlmZmVyZW50IG1hY2hpbmUgdGhhdCBoYXMgUENJZSBob3N0IG9yIGVuZHBvaW50DQo+IGRldmlj
ZSBzdXBwb3J0Pw0KSXQgcnVucyBvbiBNYXJ2ZWxsIE9jdGVvblRYMiB3aGVuIGlzIGluIFBDSWUg
RW5kcG9pbnQuIEJ1dCB0aGUgaG9zdCBjYW4gYmUgYW55dGhpbmcgLSB3ZSBoYXZlIHRlc3RlZCBv
biB4ODYgYW5kIGFybTY0IGhvc3RzIHNvIGZhci4NClRoZSBob3N0IHNpZGUgd2lsbCBoYXZlIGEg
bmV0ZGV2IGRyaXZlciB0aGF0IHdpbGwgZ28gaW50byB0aGUgZHJpdmVycy9uZXQgYXJlYS4NCj4g
DQo+ICAgICAgICAgICBBcm5kDQo=
