Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F547565E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGDTv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:51:54 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1C10A7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:51:54 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264B2Wgk001284;
        Mon, 4 Jul 2022 12:51:37 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3h2kcrf1b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 12:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJYI2PvG4vhOSwDvkb39Q3bRDUnt3YNIFe0t5QvZPyWyko1Roar3+YAFbb6ypLhvad0ty2oyveO9aZNzpsH8/CQsYUDktfhpmgGjmS5teMlU+oFdBhKdnRO6Kdpp7UYSVva2kELRMKKGd+30I/5KM0LlzBdGfy3xIFu8AErweE8yYfulT4mPREoeuZWfzyOQTroW9LhXthXbXZdpEw7NKyTvOH62UI2ESbzqMON+Z85naqqUWzzwehLhA3V0ZrrajC6wvZk+EPv/x5jBj4EcigGoBLpwe9C9t40ANgxWBYfWvkst0x4kvTLB0MZ9b6ShMiwu/pZyKsTCFeuzSqz1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zO/EIqqDEv6LIk8LmjbZkIS9PM+H56OMC7BqPPieNk=;
 b=eveAlxCTtr5ZpETsfQDrtAmQcgGikAHKyjU+oPax3rCc+xpx50KNu5p7cA36R8err2/0zlc6gCLu7DgE9lKjx2twvCk1sbmRssGoPwn7K7fUZzgSzUs4trJh3m5RUxBeUxVlyXmM3G1anWSfdPGBLkTZ7K0H7mSvlmOsJCraz0+z6CoNnHPqpIQ08FnV/NCaCY/Xv4ZpX61WIR7K6U/+vq35LNTuSnpmXWhBuWsL7UVwxryYvPcWx3LpeZlBog/krMSRoCkxuC7ACzyq/me7SlUrta3wlr2HO+1g1bkfXUfUxKY3VUTXLOTPUm4sJm6EJ88ze2WXq5xVeTzT03O/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zO/EIqqDEv6LIk8LmjbZkIS9PM+H56OMC7BqPPieNk=;
 b=g4OdFvOaLrlz164y23ValFU0do6Yjg4ej0wv5sRWtkUl7Yh3isow840IMqxfdavJ2EZT3Z9Q0/2ifzlzkr2oS4EcKJNyX7fTQQCKhSRaCJZs95qsKS9WhdXoCMcchm3RRoOOBVj7ZyK1cBuB7Y7s78zEhH3bDjhIOxc+Dyac79Y=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by CO6PR18MB3891.namprd18.prod.outlook.com (2603:10b6:5:346::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 19:51:33 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::15b5:8cdf:3d3b:7db9]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::15b5:8cdf:3d3b:7db9%7]) with mapi id 15.20.5395.018; Mon, 4 Jul 2022
 19:51:33 +0000
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     James Morse <james.morse@arm.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: RE: [EXT] Re: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for
 TAD PMU
Thread-Topic: [EXT] Re: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support
 for TAD PMU
Thread-Index: AdiKGL+qdIGmUPyiSb20urpSVOcBWgDVg5eAAJsY8vA=
Date:   Mon, 4 Jul 2022 19:51:33 +0000
Message-ID: <MW4PR18MB5084F3F8E960CD0643A5A218C6BE9@MW4PR18MB5084.namprd18.prod.outlook.com>
References: <PH0PR18MB5017CB19D896DADFCEAB6ED6D6B99@PH0PR18MB5017.namprd18.prod.outlook.com>
 <72856daa-ef83-caee-b0d0-6b5018d1bafa@arm.com>
In-Reply-To: <72856daa-ef83-caee-b0d0-6b5018d1bafa@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e9478cf-ff7c-418b-425d-08da5df698ab
x-ms-traffictypediagnostic: CO6PR18MB3891:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JJ6yD0UxZHbpxwYJQPynWJFHhF/js4CDr15JONJNJhkx6rFiUZiXOr7gOTTqDIbMuBzzR/qYK591pge9MLk9BLa1h5+1rbNAKid7IHpZz3rAG69Q/kdtZhNW74Ubzghdj3MK0Y0CnVYyqjVce5UHPbPuo13ww8oCK3UrCTHkqLK3F1z8Nf5ZAYgpU0b5QbCGbKbOJ2jLDu3ZjOtFsy5Zj4itA3owstIOJGamuq+ijtU8Ge3pSJY2ploYgKssqK+ya7k1SV7umpI5OoU3CaYWsurLVKZx/nFOfMycfgth5fOA52IJL8jPD2smou/16n9BQwEqCUAXM3F78yfSsLCngG2mJ9Mij8OqQtd2nW+3YB+4EuXR3Lo+ZE6sWLVcfNBHYEd6j8x00hYuctKP/5IwD/4MUkf7ivdGdvZ/SP8DQ1Q5Wk3mOCwjWzO2DGbAX0mH/1fm3YYyE5fx+/NJzEynm2sgJyVYr1LBuqG2QFLOmideTRP+DcY6h9MmqQ90ITHJBytzRYPGK1PnNsac3fSlN0sS9tbnmf/VkRdHVxFdv46LZgB0/6bTCMh226aXy8OCTrVDySVk++rJ2hOU53xGbFNQoEd6NasIGKl3MR228pi4JF0gmTYP8If2XrJCwXwbJFl+Puzvdi5MWU7NGK2QI0yQFE24Y0GRT6spL8IdKWz1+LlvT9JXs1xbKXXaf2cA8tS5zqTaSHKL/a3IqMhQ0UqfwzlOfhprYJJoOv70L20/KVFsFSkSED5WNaIOO0tJtuY3OXPJ0nnHiFzT2UBJHyheGJPnPUOBPzyYODw598NY9sBP5CB76iT9DR/PiP2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(66556008)(66476007)(110136005)(54906003)(66946007)(64756008)(86362001)(8936002)(8676002)(5660300002)(107886003)(52536014)(38100700002)(26005)(4326008)(66446008)(76116006)(316002)(53546011)(9686003)(6506007)(7696005)(41300700001)(71200400001)(122000001)(478600001)(38070700005)(2906002)(33656002)(83380400001)(186003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a09BRmJFRVhOK09OUUZHOGQrY1VkVU9PSms5QUIzaU1Zc0JXY2dzdnBDNVhM?=
 =?utf-8?B?SUpONlcwVTJEZlpoaTZuRXBFNVhwN2tIcExVRUtJS05sbHFlUzMvNDU4NTZX?=
 =?utf-8?B?U1ZmRzVyWG4zQzFlQTVqcG4xckRLSVl0OFVVeVMycDJzNmFyYld5dFhZYlZK?=
 =?utf-8?B?OHROUEdaZGE4cThOM1k0anB1aEhDMUY5UDIzS3kybDlENWNhNlhXa2tvdzI1?=
 =?utf-8?B?UzdCejdiMzh3dml6OGRtODF0SCtqTUw2M0NxcXUraXpETm1FbE9SdFJPelFF?=
 =?utf-8?B?TUdKM2JFejIybHZFUDFBQkRiVGhsYmVYZWpPUy9EcnlDMnFEYTF2aFNrOTVI?=
 =?utf-8?B?dk91RGhRZWJWMWxXaVhwY0VpaGFrK0hSaUhGZ3ZYZEw4a0FLdjN4Njg2WjRU?=
 =?utf-8?B?Q0kzcmt5UmJQNm42cGFuSGF5bXg4R3gzNFZqNDZwOFBXd3FKaDhpbENJbjht?=
 =?utf-8?B?RGNVSHJsdkJyMUJiQnVnOVMzcFZBWm1XY3dKbmljemlIQ214YlNuYi91Mkhk?=
 =?utf-8?B?WitxTE1QbFd3UUZFVW8rSDFSU1RxNUYrTEpBQ2hLYjFrZGRsN0RocGVXekFj?=
 =?utf-8?B?NHJsVVVQTyt5cmszVll6dmR1YXdOUGltTDBzem1GZnNEamxmM2Z3MS94TURO?=
 =?utf-8?B?aFZ6UkNLaDhsbEUwb2Z4NUJ0NDlHV21qNlIyc255SFJHTGE2bjJaR3dYaDB5?=
 =?utf-8?B?ME1FaXh2TW5xRGpjRVNaMTB5Ymd5aEpiZmdTa0VqZnFrOHgzV2NiS21DN3hv?=
 =?utf-8?B?M0J3bXFEWCt4WjBHRkd3OVFRUEZmbGVRdWVBOEFUcWpEMUt5anV0SW5CVmZV?=
 =?utf-8?B?RGkrdW43N0pmVWxSY25PNmdsd0xoOWl2bGMvYXMybi9LQytoRjNYYVFmeUdz?=
 =?utf-8?B?OFJRbHFoTC9kdDhGTGxTMHB6Nkk4bzNlTEw0QU9yTVZQZnZucWx0ZWcvYlZl?=
 =?utf-8?B?bG0ra3dLTG5lUlNrVEo0MXV3N3NXdVg0OFpucXlOVy9UdHh3S2o0cVdMRHQ0?=
 =?utf-8?B?VUhBeWRpT09xYnpXRjhNTDE5VUlHS29JRW93SHNRWWdSd2tlOU9FeE5LMEhU?=
 =?utf-8?B?ZEk4Z2JNRVNtajVSaUVzK21rNTdHbktVL1ZUVVFoQ2lLUDY3VTFEaTB4UC92?=
 =?utf-8?B?WFhlUDEvdTRDRGNHZ0RiSkR3MGE3Vy9qM3dUMFpzWjE0SERTckVmNEhIeW43?=
 =?utf-8?B?djFuVUZmNGw4NTdEMEFXc1BxekJ4UWNZcXg4MzNtckhmaVJxeHJ0eEE3cDlz?=
 =?utf-8?B?Tll1aFlWRWFObHY3WUx5a3puZXBUemNrYkJWVmJ1Sko1NjdsZnpEZngwejZK?=
 =?utf-8?B?YzVrK2ZTL1lVZENxTzRWVmx3dDdCQlZzOHJJMzlwd3dxUFlsV1hiNDduRWRX?=
 =?utf-8?B?dGlyZGs5NGY1NUtEOENUQTlDL3B0ZWFwVENIQ2duSWxGMHROUkxCa3ByYWJY?=
 =?utf-8?B?MUtQVysvNHZ5NERRWlExUzUzN0V3YkVMQWIzYTBOcUliVVE0WDNCVUkzZWFk?=
 =?utf-8?B?eXZBNldyaW1CV1hQemlQZ1BlblJ6dVFJbE5neS8yeGRTdlZBdjk4M1dSZlZ5?=
 =?utf-8?B?MFNQUEg2blJ3UVNuRm9vdWI1SUVTcFplOWRLOE9FVkpzenoyZ1lGTzU4QVRL?=
 =?utf-8?B?V0hCM3NRbHlkT1VxNTN0N3p0WGxYZTlKUzR1TG8vNUlVYlBrNXplTExkTFZp?=
 =?utf-8?B?N0UrVTdSb3l4NzhIUklFVkE0YWVYU2RVTkVUQW5sNHNvbTA2dnB2cG51enB4?=
 =?utf-8?B?Zi9nNXJIRGpwSFU2eHFPVWUzbnRVS2l3ZFJCYW9RL1BzMUNRc214N2g3Z2V4?=
 =?utf-8?B?YjBadjRtVEJlMFZvR2VEZVhaUUxwN3ZjRUdmR1J6alJKU3JocDJuT3FJWXlS?=
 =?utf-8?B?Y2V2M2lrcTllSXA3Y1pJK1h0UDNWa1ZzWDZ2ME1IaG1JaXV6T2F6bFR0MnFM?=
 =?utf-8?B?akJGMXloZ21wQzFRbHJ2Yzc0bFMxQ0gyeUl2S1dJYzZ0QlFOUS94dGVSKytV?=
 =?utf-8?B?YjRNZ1l3QlN5eGt2ZldhanVOQlJoSFYwbjhYaWNyYlJUYStYUncwK29XMnhZ?=
 =?utf-8?B?Ykp0eVF3SS96ZlFaN3YvMkFvWW04OEl6VzBDM2FuMXBsaUtQS1VNYXhWNUJN?=
 =?utf-8?Q?+HPWZTXI5mRi3gERRZoB7sofg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9478cf-ff7c-418b-425d-08da5df698ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 19:51:33.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrDU6LQZfRneskdZeixo2kNUrBthUqxpBhchhmJpSsWWHKf5wZXrpFH3HeoeeQQ7gEmlMcHb1CTWPMTcOvgwtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3891
X-Proofpoint-GUID: e5g7onVT4SWFE8FiyCdtsAMz4ExEgAl-
X-Proofpoint-ORIG-GUID: e5g7onVT4SWFE8FiyCdtsAMz4ExEgAl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_19,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW1lcyBNb3Jz
ZSA8amFtZXMubW9yc2VAYXJtLmNvbT4gDQpTZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiAxMDo1
MCBQTQ0KVG86IFRhbm1heSBKYWdkYWxlIDx0YW5tYXlAbWFydmVsbC5jb20+OyBSb2JpbiBNdXJw
aHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4N
CkNjOiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFN1
bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBMaW51IENoZXJpYW4g
PGxjaGVyaWFuQG1hcnZlbGwuY29tPjsgQmhhcmF0IEJodXNoYW4gPGJiaHVzaGFuMkBtYXJ2ZWxs
LmNvbT47IEFtaXQgU2luZ2ggVG9tYXIgPGFtaXRzaW5naHRAbWFydmVsbC5jb20+DQpTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIFJFU0VORF0gcGVyZi9tYXJ2ZWxsX2NuMTBrOiBBZGQgTVBBTSBz
dXBwb3J0IGZvciBUQUQgUE1VDQoNCkV4dGVybmFsIEVtYWlsDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkhp
IFRhbm1heSwNCg0KT24gMjcvMDYvMjAyMiAxNDoxOCwgVGFubWF5IEphZ2RhbGUgd3JvdGU6DQo+
PiBPbiAyMDIyLTA2LTI0IDEzOjE0LCBXaWxsIERlYWNvbiB3cm90ZToNCj4+PiBPbiBTYXQsIE1h
eSAyOCwgMjAyMiBhdCAxMjoyNjo0N0FNICswNTMwLCBUYW5tYXkgSmFnZGFsZSB3cm90ZToNCj4+
Pj4gVGhlIFRBRCBQTVUgc3VwcG9ydHMgZm9sbG93aW5nIGNvdW50ZXJzIHRoYXQgY2FuIGJlIGZp
bHRlcmVkIGJ5IA0KPj4+PiBNUEFNIHBhcnRpdGlvbiBpZC4NCj4+Pj4gICAgICAtICgweDFhKSB0
YWRfYWxsb2NfZHRnIDogQWxsb2NhdGlvbnMgdG8gRFRHLg0KPj4+PiAgICAgIC0gKDB4MWIpIHRh
ZF9hbGxvY19sdGcgOiBBbGxvY2F0aW9ucyB0byBMVEcuDQo+Pj4+ICAgICAgLSAoMHgxYykgdGFk
X2FsbG9jX2FueSA6IFRvdGFsIGFsbG9jYXRpb25zIHRvIERURy9MVEcuDQo+Pj4+ICAgICAgLSAo
MHgxZCkgdGFkX2hpdF9kdGcgICA6IERURyBoaXRzLg0KPj4+PiAgICAgIC0gKDB4MWUpIHRhZF9o
aXRfbHRnICAgOiBMVEcgaGl0cy4NCj4+Pj4gICAgICAtICgweDFmKSB0YWRfaGl0X2FueSAgIDog
SGl0IGluIExURy9EVEcuDQo+Pj4+ICAgICAgLSAoMHgyMCkgdGFkX3RhZ19yZCAgICA6IFRvdGFs
IHRhZyByZWFkcy4NCj4+Pj4NCj4+Pj4gQWRkIGEgbmV3ICdwYXJ0aWQnIGF0dHJpYnV0ZSBvZiAx
Ni1iaXRzIHRvIGdldCB0aGUgcGFydGl0aW9uIGlkIA0KPj4+PiBwYXNzZWQgZnJvbSBwZXJmIHRv
b2wuIFRoaXMgdmFsdWUgd291bGQgYmUgc3RvcmVkIGluIGNvbmZpZzEgZmllbGQgDQo+Pj4+IG9m
IHBlcmZfZXZlbnRfYXR0ciBzdHJ1Y3R1cmUuDQo+Pj4+DQo+Pj4+IEV4YW1wbGU6DQo+Pj4+IHBl
cmYgc3RhdCAtZSB0YWQvdGFkX2FsbG9jX2FueSxwYXJ0aWQ9MHgxMi8gPHByb2dyYW0+DQo+Pj4+
DQo+Pj4+IC0gRHJvcCByZWFkIG9mIFRBRF9QUkYgc2luY2Ugd2UgZG9uJ3QgaGF2ZSB0byBwcmVz
ZXJ2ZSBhbnkNCj4+Pj4gICAgYml0IGZpZWxkcyBhbmQgYWx3YXlzIHdyaXRlIGFuIHVwZGF0ZWQg
dmFsdWUuDQo+Pj4+IC0gVXBkYXRlIHJlZ2lzdGVyIG9mZnNldHMgb2YgVEFEX1BSRiBhbmQgVEFE
X1BGQy4NCj4+Pg0KPj4+IEl0IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZCBkb2N1bWVudCBz
b21lIG9mIHRoaXMgdW5kZXIgDQo+Pj4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wZXJmIGxp
a2UgbWFueSBvZiB0aGUgb3RoZXIgUE1VIGRyaXZlcnMgDQo+Pj4gaGF2ZSBkb25lLg0KPj4NCj4+
IEVzcGVjaWFsbHkgZG9jdW1lbnRpbmcgaG93IHRoZSB1c2VyIG9idGFpbnMgdGhlIHJlcXVpcmVk
IHBhcnRpZCB2YWx1ZSANCj4+IHRvIHBhc3MuDQoNCj4gV2UgY3JlYXRlZCBNUEFNIHBhcnRpdGlv
bnMgdXNpbmcgdGhlIHJlc2N0cmwgZmlsZXN5c3RlbSBpbnRlcmZhY2UuDQo+IEV4YW1wbGU6DQo+
ICAgICAgICAgJCBjZCAvc3lzL2ZzL3Jlc2N0cmwNCj4gICAgICAgICAkIG1rZGlyIHAxDQo+ICAg
ICAgICAgJCBlY2hvICJMMzowPWYiID4gcDEvc2NoZW1hdGEgKGNvbmZpZ3VyZSA0IEwzIGNhY2hl
IHdheXMpDQo+ICAgICAgICAgJCBta2RpciBwMg0KPiAgICAgICAgICQgZWNobyAiTDM6MT1mZjAi
ID4gcDIvc2NoZW1hdGEgKGNvbmZpZ3VyZSA4IEwzIGNhY2hlIHdheXMpDQo+IA0KPiBIZXJlIGRp
cmVjdG9yeSBuYW1lICdwMScgY3JlYXRlcyBhIE1QQU0gcGFydGlkIDB4MSBhbmQgJ3AyJyBjcmVh
dGVzDQo+IDB4MiBhbmQgc28gb24uDQoNCllvdSBjYW4ndCByZWx5IG9uIHRoaXMuDQoNClNlZSB0
aGUgS05PV05fSVNTVUVTIGZpbGUgaW4gdGhlIHRoZSBtcGFtIHRyZWU6IFBBUlRJRCAwIHNob3Vs
ZCBiZSByZXNlcnZlZCBmb3IgdW5rbm93biBoYXJkd2FyZS4gSW4gZmFjdCBhbnkgbnVtYmVyIG9m
IFBBUlRJRCBtYXkgYmUgcmVzZXJ2ZWQgZm9yIGluLWtlcm5lbCB1c2Vycy4gWW91IGNhbid0IGd1
ZXNzIHdoYXQgdGhlIG9mZnNldCBtaWdodCBiZSBmcm9tIHVzZXItc3BhY2UuDQoNCg0KPiBSaWdo
dCBub3csIHRoZXJlIGlzIG5vIGZpbGUgd2hpY2ggZXhwb3NlcyB0aGUgcGFydGlkIHRvIHVzZXJz
cGFjZS4NCj4gV2UgbXVzdCByZWx5IG9uIHRoZSBzZXF1ZW50aWFsIG9yZGVyIGluIHdoaWNoIHdl
IGNyZWF0ZSBwYXJ0aXRpb25zIHZpYSANCj4gcmVzY3RybCBhbmQgdXNlIHRoYXQgdG8gZGVyaXZl
IHRoZSBwYXJ0aWQuDQoNCklmIHlvdSBkaWcgaW4gdGhlIE1QQU0gdHJlZSB5b3UnbGwgZmluZCBo
b3cgSSBpbnRlbmQgdG8gc29sdmUgdGhpcyBmb3IgZXhwb3NpbmcgdGhlIE1QQU0gY291bnRlcnMg
dmlhIHBlcmYuIEJ1dCB0aGlzIGlzIGEgdXNlci1zcGFjZSB2aXNpYmxlIGNoYW5nZSB0byByZXNj
dHJsLCBzbyBpdCB3aWxsIG5lZWQgdG8gd2FpdCB1bnRpbCBhbGwgdGhlIHJlZmFjdG9yaW5nIGlz
IGRvbmUgYW5kIHRoZSBidWxrIG9mIHRoZSBNUEFNIGRyaXZlciBpcyB1cHN0cmVhbS4NCg0KWz4+
XSBCdXQgdGhlc2UgYXJlIG5vbi1zdGFuZGFyZCAoSEFTX01TTU9OPTApIG1vbml0b3JpbmcgY291
bnRlcnMgdGhhdCBqdXN0IGhhcHBlbiB0byB1c2UgTVBBTSBwYXJ0SUQuIFRoZXJlZm9yZSwgSU1I
TyB3ZSANCiAgICAgICBzaG91bGQgZXhwb3NlIHRoZW0gdmlhIE1hcnZlbGwgc3BlY2lmaWMgUE1V
IGRyaXZlciwgYW5kIGV4cG9zaW5nIHRoZSBNUEFNIHBhcnRJRCB0byB1c2VyIHNwYWNlIChtYXkg
YmUgdW5kZXIgcmVzY3RybCkNCiAgICAgICB3aWxsIGhlbHAgdGhpcyBjYXVzZS4NCiAgICAgIG9y
DQogICAgICByZXNjdHJsIGJhc2VkIFBNVSBkcml2ZXIgY2FuIHN0aWxsIHN1cHBvcnQgc3VjaCBj
b3VudGVycyB0aGF0IGFyZSBub3QgY29tcGx5IHdpdGggTVBBTSBzdGFuZGFyZD8NCg0KDQpUaGFu
a3MsDQogLUFtaXQNCg0K
