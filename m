Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2804E4DCE45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiCQS7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiCQS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:59:06 -0400
Received: from mx0b-00369f01.pphosted.com (mx0b-00369f01.pphosted.com [148.163.139.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB94224755;
        Thu, 17 Mar 2022 11:57:48 -0700 (PDT)
Received: from pps.filterd (m0167463.ppops.net [127.0.0.1])
        by mx0b-00369f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HHMEGm011392;
        Thu, 17 Mar 2022 14:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mksinst.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=podFeb2021;
 bh=y3XB+Y5jsFtP07bVoh8Trzq4KbmW7Wxti1VYwIRjBu4=;
 b=DrFgCGMIa6J2ZSQxrimwZAAd1TMbJ4XkW20rqUjQ/UPbG7/pjVk+JQ8syBIGFXAvmwLv
 MCVCiXo+gUnEivUk8Izp9BGCzlySc3rGPrkJ1Es/N2Fn+POzq0K5fwYrukJpyHqoZ2Nv
 L94pKnr8eSKDJHp0J5CJ1BdsjifutjfsR93p6H1dX/PqNilRB8UFf25Rk5B++yVnQC4/
 uyug7cH/x+IG0dZdRWUC6AvWZG80Rkf4msLDDZUa8ZrJtCAMM/lfJFvL/nsIa9nnE6fx
 CTUmAwGBwscqkEh4x6TTm8d7rtJle4ORlprLoJCPtk4YqAGIoFQM3NY5b96C0bc0qvgw Ew== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-00369f01.pphosted.com with ESMTP id 3euh4q6ukp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 14:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVWZ4yKUxMYP00j+8eO8U69RH6CXfI2/wEKeaKFLPWWmbtI99u3i/DFQv+G3v3BKReLaaByZPW2LBGYqDQVEVK8zhhcYHIgJN79ZSIuQ13NwHZ4MGRKM2znPnjqB2BYwtSIlfu8wGZ2CDKTb699i3/yMUfJUNi5E0zDW2yYU4XkFi/HHUQuSxhjD+QIQng6YEuMp2f5+EunwZSTuDYPatmlNIP6f4T3FJ8diHDYYxVPUI8AHBGPQSemeZqN5PAYd+PSwQ9AuvpIPhVn3pvtpURYgW6ybHQrJqnaP2vf9Hie9pgwl+tRzNMz6lAQKpgg6B+vXg/Y0HClhy2qF+avEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gip4M71Avc/lx1moLgOvfkrvT86f3HwWXlWi9UlaPZ0=;
 b=R4Ulgu5jQh3KaBOLcRkhT2hLfY/T3s//34ukofrcq6ihoszBZWR4/1x0C8eiqlQGD8oj+40+izAYx9audL/VKz1V2bNPeWJWJtYO7XH5yxUltnTNQMke6M0lG/B+Ydzjo6JxURtPx4Gidp7hfXZnYiS3ufn8OKNPtGaN07/KN3FxJKQbQrCITdL24zQdcnFqbbvPYPxuWJTJ4KfE1Q1ye42ENxjzN2KgHrkE4IMSPnekj5Fnk/jsXCTFmFX6LINs6zsNcKpT474wk9vjQoD5ypyJZ/80DRFySf0ApZ7avkNDBq3QPl9DJLp7GjUegwEjV1ceMEWh/qV4hcGRxukI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mksinst.com; dmarc=pass action=none header.from=mksinst.com;
 dkim=pass header.d=mksinst.com; arc=none
Received: from MN2PR03MB5008.namprd03.prod.outlook.com (2603:10b6:208:1ac::24)
 by DM6PR03MB3849.namprd03.prod.outlook.com (2603:10b6:5:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 18:57:29 +0000
Received: from MN2PR03MB5008.namprd03.prod.outlook.com
 ([fe80::8d29:bd4b:20cf:ee41]) by MN2PR03MB5008.namprd03.prod.outlook.com
 ([fe80::8d29:bd4b:20cf:ee41%9]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 18:57:29 +0000
From:   "Fillion, Claude" <Claude.Fillion@mksinst.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Adam Ford <aford173@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "aford@beaconembedded.com" <aford@beaconembedded.com>,
        "cstevens@beaconembedded.com" <cstevens@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on
 5p49v6965
Thread-Topic: [EXTERNAL] Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on
 5p49v6965
Thread-Index: AQHYOEpoqMQLOkVQCEOjGSHAmfR/NqzA0z7wgAA64ACAAuAtgA==
Date:   Thu, 17 Mar 2022 18:57:29 +0000
Message-ID: <MN2PR03MB500803388839E563D29CF25C93129@MN2PR03MB5008.namprd03.prod.outlook.com>
References: <20220313115704.301718-1-aford173@gmail.com>
 <a146f554-837a-d19a-425c-b1fd790a0497@lucaceresoli.net>
 <MN2PR03MB5008F8DDC6DD934074EBBC0E93109@MN2PR03MB5008.namprd03.prod.outlook.com>
 <59ee78c2-7d05-6d97-1ff2-36ea326be188@lucaceresoli.net>
In-Reply-To: <59ee78c2-7d05-6d97-1ff2-36ea326be188@lucaceresoli.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f657437-8779-423b-fef4-08da0847fc41
x-ms-traffictypediagnostic: DM6PR03MB3849:EE_
x-microsoft-antispam-prvs: <DM6PR03MB3849F76024897FC591BED29793129@DM6PR03MB3849.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dXnoO03+U8NORJyxxwBwCK1eUfM5duovW9ebLpr5EL72rHeXyMr1YB8Paz9KTQ+0+k2taBBz2AT7zlQWR+90ksq9bJe6hwk0YOWOUuM+duISps0PO25i6XYl9SrN/XVaf8uEnBxZhxAQRW0YVjdET8YXm4WbzpJwoKpkaTZxi/uDBh4POdvqCqHkxLrywUl0q0F7Cd41skrfVufwAsLgocpU2ELDZKs7X5iWSO2UcJzQeBoCnaHxQ+J9Xqm9FKY2ER6ZcUMj8M8vxofZZTz7hdlBY6bP2YEuGVNKzQ4wZgs6BuZtSrlcYanz48/o7aAxiDTx72eaaWpoHRGNgXQ7EcBjPjJPvZllaqgW12on5449ZEoEnZr1YfXQNkZl1o+klbkKKfBRcOt2Ds4KGxmhkNo+xDOJi7qUWckAIgWXuyZidyTCkIs41u4SlsJfMAn2/e2XIqmAH0oBxXasnJdFztBrietmI4A7WdypMki0h35YfOOXd+TfaoAfR6v7IkLRFWQzORNrX2WvY7v30Ge0F+ZJWSV4zX4zFelcaCd3JqQKLb9ucCkTvN60km/DMHzhizLAkRPy/60DfJm+1X//PNMRIq3S+Zx8H8y/SMQOQsJ0jtsdihVZOEtUPXDmIoWZUHKkhgZ2W/6wJJ9d9iW8fU1WP7tdg/Zc8bW7NjT9vy5VKVlTxhK8WXoTDXM4lLvdeze7ot/q374uC+VB750SMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5008.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(122000001)(66476007)(66446008)(64756008)(8676002)(76116006)(7696005)(6506007)(53546011)(26005)(33656002)(508600001)(110136005)(316002)(54906003)(186003)(38070700005)(38100700002)(83380400001)(5660300002)(52536014)(8936002)(2906002)(86362001)(55016003)(9686003)(4326008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UC9ubkZsK1Z3djZudUxwM1RhU3U1RHh0L25pNVZCb2RFTXZhOVVnTzZFR29t?=
 =?utf-8?B?VUUycDA5UU1udWdpYWVsQ2VURlUzOWJnV2k2eDl5cTY0dW52cHNGODc0V200?=
 =?utf-8?B?NHIyMUxTWHIwbFp2bjE2ZHIyODZwL0tXNTRlZGk3dC9CL2tlVGFrY2czRFF6?=
 =?utf-8?B?MHlXeks5RVU5SE5UWjVpWUFYelhuekRBZW1ob2wzbFVtb0Nob0RqZWx5c20r?=
 =?utf-8?B?cDRKQjBSNG1mSnR4Wjk2UEdkR2E1NzZiNE1KY01nTWJ1NERrWFI2WTM2blNa?=
 =?utf-8?B?ZkpGa2F2TXNxQmRldVVVZHlDNUJ1QkxzZy9JMFNvWnNzWk5Ya1BkYUJlaWtX?=
 =?utf-8?B?U3NHMHdzdW5LMGNpQ3A4MC94VUVpcmxmOXdtYjY1aXpIM0o0S09NWXNzaUl3?=
 =?utf-8?B?bFJXQTdyQjlia2puaVZtRktnczljc015WXVCaTROQ0d3NlI5eFp2c2tHTlN5?=
 =?utf-8?B?ZXhtNnpJOWNjR0JwYTBCZmdkVW01aFRDWmwrbkN4clpxZ1o2RWx4V3ljaTB2?=
 =?utf-8?B?WkExeDgrbnB4Zm5IcFNKMXNPOVIwblZrMWpuTFFnTzhpalRqUzRvV0JUSFFs?=
 =?utf-8?B?ZERIM2tyeFpCMkE0NDBMWEgwK3dKMEFTL0lFSkUwdFh6ZWtyNnM2N1ZZaUJw?=
 =?utf-8?B?UlI1TzJSUkFIUEd1RG81UmxqRWxpZ0NrNGZUb1FBeWIvN2R0aS9SMWJubEdR?=
 =?utf-8?B?RGV2d3FoOVE3cFdmYUFDbFB4M2Q0dmJqTlY5Umh1SWN1UE5wUmkxYk95NElB?=
 =?utf-8?B?YWNmc1ZpNVY5WXhraEdNWi93UDdNd0RMckk3cWhlUzZxSFFNS3dmQThBWUhw?=
 =?utf-8?B?WmRyai9RbGFNaXdHakhDS0NFSXN0TWE4ampmU2VDaVIraUx1a2xrZllUaXNP?=
 =?utf-8?B?Ym8yZk9qWXplb3d1VDA0RjJVTngrd0duc1l2S3BBaXJhWUorZWhQd3hxSFNU?=
 =?utf-8?B?bWd2SlpLWm5QMnJiOTZFS0tGaXRHZVlaN21mRzRLcEdRbEdwQlFsYWdBYjRv?=
 =?utf-8?B?Rjl0SEFKc09DRGkycUc5YXZtQWV4L1phNDByd3VwZVEyT0FPdVNTTStkcTNm?=
 =?utf-8?B?VEVMRi9PNU1oR1c3RnZBVVFHY1pOQUd5c1pGSTFXVWNNMmlCSmQrT1Z6VHZy?=
 =?utf-8?B?OU1QVzgxMHlMemM3SDVmU2YwTm5VdWdXeHFoYzdzSmFseC9HTkxqWXpLbVpT?=
 =?utf-8?B?ajBxUDBMOW0vV3RjekF5d1hsT0c2NWJjblRxN1djVEFJanBXWXhkVTMrSHRv?=
 =?utf-8?B?OE5xQ3pLdUdzeEplSlU5NU1hZGVnTjBWeVVUN29VRmN6RVhrRHRsTHYwakFF?=
 =?utf-8?B?SXkycVdKQWN4R1gzeUhyZGFaMGxUbEtIQWkwZytZdmJTb2p6QXZqQ3ZlSWJa?=
 =?utf-8?B?NDBKQTBSRldrWTZEMzhXM0ZIaWc5TWlKcTJEYXdOTXZIbE1GcVhhWjJvYVl1?=
 =?utf-8?B?Vk5Wbzl0STlZczlObmZjYUIycVhDekJ0S2tKTVpOUlRLT05sRnhvbE83M3B0?=
 =?utf-8?B?bkl4Sk5jMEQ0YzNhbDBtZWkwdmIrUkJXSmxDQXp4ZjMvb3NXaGIwL3E2TDc0?=
 =?utf-8?B?eHpOcE9CZkVtUHRFajZrRkt5TEN5ME1HZStyRjkzR1JaU0RPVWF6cVRpYVlj?=
 =?utf-8?B?VnAzNmhvK2FKdmNtVWE3UTFJWDIyUE8rZG5hTGJQeW15NWVETkRkSXpjUlJF?=
 =?utf-8?B?MmRIMGJtakF6QXlXWlltaEFGMG1KUllkbjMzaEtxZy92NUpia2RGeHVzWnQ4?=
 =?utf-8?B?M2tVVzVZS2JZNWdsT0M2Sm52VFpvM3ppNFBSUFJ2bnBaeDJtRFMxTVZxc2JQ?=
 =?utf-8?B?dmU5Rld5SkhTcGtRdUhZR2M5VXl2TElzcWdscksxeG1NUUwwalpoejNKRGFx?=
 =?utf-8?B?M2FMUGsyYStUQWxrWFdRQ0FweHBuM0sycUljZmx1cmEreCthdE5WeVJSem9J?=
 =?utf-8?Q?wvky6ubstylVz4/a5FBbBTD1x2PuPsb4?=
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mksinst.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5008.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f657437-8779-423b-fef4-08da0847fc41
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 18:57:29.3605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34fc6b5f-c773-4cad-ae20-f226c36b7e65
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 623UY1wqKbWmOIau3B4LL5DC3qnEu36XTpZB65ktMk2ls0RqYew9bzPxlwjXvLq1wdrF5djXDnKr0S+L6GC3x+YkapHqb/cy0UCh0HaZyy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3849
X-Proofpoint-GUID: _FAD34ws635PP-JF5uSnGF0ZrjKuqe_N
X-Proofpoint-ORIG-GUID: _FAD34ws635PP-JF5uSnGF0ZrjKuqe_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_07,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=977 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170107
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTHVjYSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNh
IENlcmVzb2xpIDxsdWNhQGx1Y2FjZXJlc29saS5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNo
IDE1LCAyMDIyIDY6NTMgUE0NCj4gVG86IEZpbGxpb24sIENsYXVkZSA8Q2xhdWRlLkZpbGxpb25A
bWtzaW5zdC5jb20+OyBBZGFtIEZvcmQNCj4gPGFmb3JkMTczQGdtYWlsLmNvbT47IGxpbnV4LWNs
a0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGFmb3JkQGJlYWNvbmVtYmVkZGVkLmNvbTsgY3N0ZXZl
bnNAYmVhY29uZW1iZWRkZWQuY29tOw0KPiBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBi
YXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQNCj4gPHNib3lkQGtlcm5lbC5vcmc+OyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNYXJlayBWYXN1dA0KPiA8bWFyZWsudmFzdXRAZ21haWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBjbGs6IHZjNTogRW5h
YmxlDQo+IFZDNV9IQVNfUEZEX0ZSRVFfREJMIG9uIDVwNDl2Njk2NQ0KPiANCj4gSGkgQ2xhdWRl
LA0KPiANCj4gW2FkZGluZyBNYXJlayBpbiBDYzosIHRoZSBvcmlnaW5hbCBhdXRob3Igb2YgdGhl
IGRyaXZlciBhbmQgYWxzbyBvZiB0aGUNCj4gZnJlcXVlbmN5IGRvdWJsZXJdDQo+IA0KPiBPbiAx
NS8wMy8yMiAyMDozNCwgRmlsbGlvbiwgQ2xhdWRlIHdyb3RlOg0KPiA+IEhlbGxvIEx1Y2EsDQo+
ID4NCj4gPiBJIHdpbGwgZGVmZXIgdG8gQWRhbSwgYnV0IGEgZmV3IGNvbW1lbnRzOg0KPiA+DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEx1Y2EgQ2VyZXNvbGkg
PGx1Y2FAbHVjYWNlcmVzb2xpLm5ldD4NCj4gPj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTUsIDIw
MjIgNDo1NSBBTQ0KPiA+PiBUbzogQWRhbSBGb3JkIDxhZm9yZDE3M0BnbWFpbC5jb20+OyBsaW51
eC1jbGtAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBhZm9yZEBiZWFjb25lbWJlZGRlZC5jb207
IGNzdGV2ZW5zQGJlYWNvbmVtYmVkZGVkLmNvbTsNCj4gRmlsbGlvbiwNCj4gPj4gQ2xhdWRlIDxD
bGF1ZGUuRmlsbGlvbkBta3NpbnN0LmNvbT47IE1pY2hhZWwgVHVycXVldHRlDQo+ID4+IDxtdHVy
cXVldHRlQGJheWxpYnJlLmNvbT47IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz47IGxp
bnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5B
TF0gUmU6IFtQQVRDSF0gY2xrOiB2YzU6IEVuYWJsZQ0KPiBWQzVfSEFTX1BGRF9GUkVRX0RCTA0K
PiA+PiBvbiA1cDQ5djY5NjUNCj4gPj4NCj4gPj4gVGhpcyBlbWFpbCBvcmlnaW5hdGVkIG91dHNp
ZGUgb2YgTUtTLiAgVXNlIGNhdXRpb24gd2hlbiBzaGFyaW5nDQo+ID4+IGluZm9ybWF0aW9uIG9y
IG9wZW5pbmcgYXR0YWNobWVudHMgYW5kIGxpbmtzLg0KPiA+Pg0KPiA+PiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+IEhpIEFkYW0sIENsYXVkZSwNCj4gPj4N
Cj4gPj4gdGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPiA+Pg0KPiA+PiBPbiAxMy8wMy8yMiAxMjo1
NywgQWRhbSBGb3JkIHdyb3RlOg0KPiA+Pj4gVGhlIDVwNDl2Njk2NSBoYXMgYSByZWZlcmVuY2Ug
Y2xvY2sgZnJlcXVlbmN5IGRvdWJsZXIuDQo+ID4+PiBFbmFibGluZyBpdCBhZGRzIHZlcnNhY2xv
Y2tfc29tLmRibCB0byB0aGUgY2xvY2sgdHJlZSwgYnV0IHRoZQ0KPiA+Pj4gb3V0cHV0IGZyZXF1
ZW5jeSByZW1haW5zIGNvcnJlY3QuDQo+ID4+Pg0KPiA+Pj4gU3VnZ2VzdGVkLWJ5OiBDbGF1ZGUg
RmlsbGlvbiA8Q2xhdWRlLkZpbGxpb25AbWtzaW5zdC5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNvbT4NCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvY2xrLXZlcnNhY2xvY2s1LmMNCj4gPj4+IGIvZHJpdmVycy9jbGsvY2xr
LXZlcnNhY2xvY2s1LmMgaW5kZXggZTdiZTNlNTRiOWJlLi40ZDE5MDU3OWU4NzQNCj4gPj4+IDEw
MDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXZlcnNhY2xvY2s1LmMNCj4gPj4+ICsr
KyBiL2RyaXZlcnMvY2xrL2Nsay12ZXJzYWNsb2NrNS5jDQo+ID4+PiBAQCAtMTIxMSw3ICsxMjEx
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2YzVfY2hpcF9pbmZvDQo+ID4+IGlkdF81cDQ5djY5
NjVfaW5mbyA9IHsNCj4gPj4+ICAJLm1vZGVsID0gSURUX1ZDNl81UDQ5VjY5NjUsDQo+ID4+PiAg
CS5jbGtfZm9kX2NudCA9IDQsDQo+ID4+PiAgCS5jbGtfb3V0X2NudCA9IDUsDQo+ID4+PiAtCS5m
bGFncyA9IFZDNV9IQVNfQllQQVNTX1NZTkNfQklULA0KPiA+Pj4gKwkuZmxhZ3MgPSBWQzVfSEFT
X0JZUEFTU19TWU5DX0JJVCB8IFZDNV9IQVNfUEZEX0ZSRVFfREJMLA0KPiA+Pg0KPiA+Pg0KPiA+
PiBJZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIHRoZSBkb3VibGVyIGlzIG5vdCBtZW50
aW9uZWQgYnkgdGhlDQo+ID4+IGRhdGFzaGVldCwgYnV0IGl0IGV4aXN0cy4gTWF5YmUgaXQncyB3
b3J0aCBhIGxpbmUgb2YgY29tbWVudCB0byBoZWxwDQo+ID4+IGZ1dHVyZSByZWFkZXJzIG5vdCB3
YXN0ZSB0aGVpciB0aW1lIGluIGZpbmRpbmcgb3V0Og0KPiA+PiAgIC8qIEZyZXF1ZW5jeSBkb3Vi
bGVyIG5vdCBtZW50aW9uZWQgb24gZGF0YXNoZWV0ICovDQo+ID4+DQo+ID4NCj4gPiBJIHNlZSB0
aGUgZG91YmxlciBiaXQgbWVudGlvbmVkIGluIFRhYmxlIDI1IG9mIGJvdGggdjYgYW5kIHY2ZSBz
cGVjcy4gIEl0IGlzDQo+IG5hbWVkIGRpZmZlcmVudGx5LCBidXQgYXBwZWFycyB0byBoYXZlIHRo
ZSBzYW1lIHB1cnBvc2UuDQo+IA0KPiBXZWxsLCBsaXRlcmFsbHkgc3BlYWtpbmcgd2hhdCBJIHdy
b3RlIGlzIGNvcnJlY3Q6IHRoZSBfZGF0YXNoZWV0XyBkb2VzIG5vdA0KPiBtZW50aW9uIHRoZSBk
b3VibGVyLiBUYWJsZSAyNSB5b3UgbWVudGlvbiBpcyBvbiB0aGUgIlJlZ2lzdGVyIERlc2NyaXB0
aW9uDQo+IGFuZCBQcm9ncmFtbWluZyBHdWlkZSIuDQo+IA0KPiBQcmFjdGljYWxseSBzcGVha2lu
ZyBJIHdvdWxkIGV4cGVjdCB0aGUgZGF0YXNoZWV0IHRvIG1lbnRpb24gdGhlIGhhcmR3YXJlDQo+
IGJsb2NrcyBpbmNsdWRpbmcgdGhlIGRvdWJsZXIsIGJ1dCBhcHBhcmVudGx5IFJlbmVzYXMgaGFz
IGEgZGlmZmVyZW50IG9waW5pb24NCj4gYW5kIHBlcmhhcHMgdGhleSBhcmUgbm90IGFsb25lLg0K
PiANCj4gU28gSSB0aGluayB5b3UgY2FuIGZvcmdldCBhYm91dCBteSBwcm9wb3NhbCB0byBhZGQg
YSBjb21tZW50Lg0KPiANCj4gPj4gQ2FuIHlvdSBjb25maXJtIHRoYXQ6DQo+ID4+ICAtIHRoZSBl
bl9yZWZfZG91YmxlciBiaXQgdmFsdWUgZGVmYXVsdHMgdG8gemVybyB3aGVuIHJlYWRpbmcgaXQs
IGFzIHRoZQ0KPiA+PiAgICByZWdpc3RlciBndWlkZSBzYXlzPw0KPiA+PiAgLSBpZiBzZXQgdG8g
MSB0aGUgZnJlcXVlbmNpZXMgZG91YmxlPw0KPiA+Pg0KPiA+PiBXaXRoIHRoYXQgY29uZmlybWVk
LCB0aGUgcGF0Y2ggbG9va3MgZ29vZC4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiAtLQ0KPiA+
PiBMdWNhDQo+ID4NCj4gPiBJIHBsYXllZCBhcm91bmQgYSBiaXQgd2l0aCB0aGUgcHJvZ3JhbW1p
bmcgYm9hcmQgdG9kYXkgYW5kIGRpZCBub3Qgc2VlDQo+IHdoYXQgSSBleHBlY3RlZCB0byBzZWUu
DQo+ID4NCj4gPiBVc2luZyBpMmNnZXQgSSBzZWUgdGhhdCB0aGUgcmVnaXN0ZXIgaW4gcXVlc3Rp
b24gKDB4MTApIGhhcyBhIGRlZmF1bHQgdmFsdWUgb2YNCj4gMHhBMCBmb3IgYm90aCA2OTAxIGFu
ZCA2OTY1LiAgVGh1cyBpdCBzZWVtcyBkaXNhYmxlZCBieSBkZWZhdWx0IGZvciBib3RoDQo+IHBh
cnRzLg0KPiANCj4gQ29oZXJlbnRseSB3aXRoIHRoZSBSZWdpc3RlciBndWlkZS4gT0suDQo+IA0K
PiA+IFN0YXJ0aW5nIGF0IG15IGJhc2UgZnJlcXVlbmN5IG9mIDQ2LjhNSHosIHNldHRpbmcgdGhl
IGJpdCB0byAxIChpMmNzZXQpDQo+IGNoYW5nZXMgdGhlIG91dHB1dCAgZnJlcXVlbmN5IHRvIDU5
LjA0TUh6IGZvciB0aGUgNjkwMSBwYXJ0LCBhbmQgdG8NCj4gNDcuN01IeiBmb3IgdGhlIDY5NjUg
cGFydC4gIFNvIHNldHRpbmcgdGhlICdkb3VibGVyJyBiaXQgY2hhbmdlcyBvdXRwdXQNCj4gZnJl
cXVlbmN5IGZvciBib3RoIHBhcnRzLCBidXQgbm90IHRoZSBzYW1lIGFtb3VudC4NCj4gPg0KPiA+
IE5vdCBzdXJlIG9mIHRoZSBtZWFuaW5nLCBqdXN0IHdhbnQgdG8gcGFzcyB0aGUgaW5mb3JtYXRp
b24gYWxvbmcuDQo+IA0KPiBNZSBuZWl0aGVyLg0KPiANCj4gSSBoYXZlIG5vIGNsZXZlciBpZGVh
LCBvbmx5IHRoaXMgb25lIHRoYXQgSSBjb25zaWRlciB1bmxpa2VseTogYnkgZW5hYmxpbmcgdGhl
DQo+IGRvdWJsZXIgeW91IG1heSBoYXZlIGluY3JlYXNlZCBzb21lIGludGVybmFsIGZyZXF1ZW5j
eSBhYm92ZSBpdHMgYWxsb3dlZA0KPiByYW5nZSBhbmQgdGh1cyB0aGUgY2hpcCBpcyBub3Qgd29y
a2luZyBwcm9wZXJseSBhbnltb3JlLiBDYW4geW91IHVzZSBhDQo+IGxvd2VyIGJhc2UgZnJlcXVl
bmN5IG9yIGNoZWNrIHRoZSBQTEwgc2V0dGluZ3MgdG8gZW5zdXJlIHlvdSBhcmUgbm90DQo+IGV4
Y2VlZGluZyBzb21lIHJhbmdlPw0KPiANCj4gV2hhdCBvdXRwdXQgZnJlcXVlbmN5IGFyZSB5b3Ug
bWVhc3VyaW5nPyBPVVQwIG9yIGFub3RoZXIgb25lPyBXaGF0DQo+IGZyZXF1ZW5jeSBkbyB5b3Ug
bWVhc3VyZSB3aXRoIGVuX3JlZl9kb3VibGVyID0gMD8NCj4gDQo+IC0tDQo+IEx1Y2ENCg0KTm90
IHN1cmUgd2hhdCBJIGRpZCB3cm9uZyB3aXRoIG15IGVhcmxpZXIgdGVzdGluZywgYnV0IEkgYW0g
bm93IHNlZWluZyBib3RoIHBhcnRzIHJlc3BvbmQgc2ltaWxhcmx5IHRvIHRoZSBkb3VibGVyIGJp
dCBiZWluZyBzZXQuDQoNCldpdGggZG91YmxlciBiaXQgZGlzYWJsZWQgKHJlZ2lzdGVyIDB4MTAs
IHZhbHVlIDB4YTApLCBJIHNldCB0aGUgb3V0cHV0IGZyZXF1ZW5jaWVzIHRvIDEsIDEwLCAxMDAs
IGFuZCA0Ni44TUh6Lg0KDQpBZnRlciBzZXR0aW5nIGRvdWJsZXIgYml0ICgweGE4KSwgSSBzYXcg
ZnJlcXVlbmNpZXMgb2YgMS4yNjAsIDEyLjYwLCAxMjYuMCwgYW5kIDU4LjkgTWh6IGZvciBib3Ro
IDY5MDEgYW5kIDY5NjUgcGFydHMuDQoNClNvIGZyb20gbXkgdGVzdGluZyB0aGUgZG91YmxlciBi
aXQgc2VlbXMgdG8gYmVoYXZlIHNpbWlsYXJseSBmb3IgYm90aCBwYXJ0cy4NCg0KQXQgdGhpcyBw
b2ludCBJIHdpbGwgbGVhdmUgbXkgdW5vZmZpY2lhbCB0ZXN0aW5nIGFuZCBtb3ZlIG9uIHRvIHdy
aXRpbmcgYSBjb25zdW1lciBkcml2ZXIuDQoNClJlZ2FyZHMsDQpDbGF1ZGUNCgo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBpbnRlbmRlZCBvbmx5IGZv
ciB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykgYW5kIG1heSBjb250YWluIGNvbmZpZGVudGlh
bCBvciBwcm9wcmlldGFyeSBpbmZvcm1hdGlvbiBhbmQgYmUgc3ViamVjdCB0byB0aGUgYXR0b3Ju
ZXktY2xpZW50IHByaXZpbGVnZSBvciBvdGhlciBjb25maWRlbnRpYWxpdHkgcHJvdGVjdGlvbnMu
ICBJZiB5b3UgYXJlIG5vdCBhIGRlc2lnbmF0ZWQgcmVjaXBpZW50LCB5b3UgbWF5IG5vdCByZXZp
ZXcsIHVzZSwgY29weSBvciBkaXN0cmlidXRlIHRoaXMgbWVzc2FnZSBvciBhbnkgYXR0YWNobWVu
dHMuICBJZiB5b3UgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgcGVybWFuZW50bHkgZGVsZXRlIHRoZSBvcmln
aW5hbCBhbmQgYW55IGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyB0
aGVyZXRvLiAgVGhhbmsgeW91Lgo=
