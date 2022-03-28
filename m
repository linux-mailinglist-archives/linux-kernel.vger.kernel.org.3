Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0204E9C40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiC1QbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiC1QbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:31:18 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592437035;
        Mon, 28 Mar 2022 09:29:38 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22SA4cUM011168;
        Mon, 28 Mar 2022 09:29:35 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3f206p7xrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 09:29:35 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22SGTZAh026691;
        Mon, 28 Mar 2022 09:29:35 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3f206p7xre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 09:29:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrW1rJZ+94welYuqT1j37V0ty/d3taDmUbONGxGayaCQBrxFT+HHp1S9+IH4voxRcDADPs+yuwqFQ3YQp3c4+2tvmSAWDNB3yWkvuaQbKruvIlYqKaQKS+ep6stsjqcLoOl6D2ocudikLHZJ4wHhEuU8XIf84o9fIlOpP1V5Ty6l1yzuDIPsVGyQATNAPtwGZniUnDTpvxQSsDtwy6cY38G5tTGePQUGJ1U6nWJl5VlBPcMBCGx+HWW8IEj19b0SB8zQ48FrxwZztUdOiO2PgHViMpnH/CDI+bKWkG9p+zb7GDkV9zMIFz/QDGupVMug0ZVgL3xccvS3Yb3rukk5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYRXnxu1fhkyPYj07BPQSdCQVUhwrbVef2mK12GSp3g=;
 b=c1GzhcMCWiHg4AlK2SeZdTwtSwjqPgl/2TtTty/lW1Eh/tFraMp25F364fvjD3yDN/h6SqFKP4IDXXiYw8uIzw+uQgm+6lKsUvGK7wrIISxDexwLnMvZDC9hB45q7OQy4poiLSMSRyrVUSJF9o83aRvoMLC06fKsdO0eRCmB/+ED6ZhTte3s+Xfv6/bKOHc0DUao2Y6WWHJMS48jedtX8ZDdxl5SVo136xT+oAGq89yyEOruxfwhzLVB89TwZuBgnaX5DfXYolWxPJvUHZZ2WGUnMLtzytFPGBMvq7ZIXmcR28SpRaB8XcwynQf8fH3HVgtJJfH+aLyKjDIH6OW9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYRXnxu1fhkyPYj07BPQSdCQVUhwrbVef2mK12GSp3g=;
 b=CzL1bsi/MDVBwVBGg4LfGoM9RcFgupOl+DBMZM7aGzONXZVxe4q5UgdN4krgFv/I9uKXO9OWFXxACH8nmOiSUZ0zunwrVSPqNUvCnItQf/epKyEcssvWgPdJqwhBFH0hblPXREgjBmEJwOMGTgKAU5SfSAEPgJMLInG6M6ue0Ag=
Received: from CO6PR18MB4419.namprd18.prod.outlook.com (2603:10b6:5:35a::11)
 by DM6PR18MB3292.namprd18.prod.outlook.com (2603:10b6:5:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Mon, 28 Mar
 2022 16:29:32 +0000
Received: from CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::48eb:b18:5fe4:1b59]) by CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::48eb:b18:5fe4:1b59%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:29:32 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] scsi: bnx2i: Fix spelling mistake "mis-match" ->
 "mismatch"
Thread-Topic: [EXT] [PATCH] scsi: bnx2i: Fix spelling mistake "mis-match" ->
 "mismatch"
Thread-Index: AQHYO+cjG3Qco0gsc0yT6jPTPdsvuKzVCh1g
Date:   Mon, 28 Mar 2022 16:29:32 +0000
Message-ID: <CO6PR18MB4419F24DDD5B381B751725DFD81D9@CO6PR18MB4419.namprd18.prod.outlook.com>
References: <20220319231445.21696-1-colin.i.king@gmail.com>
In-Reply-To: <20220319231445.21696-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15565959-6f89-4af5-27e3-08da10d823ad
x-ms-traffictypediagnostic: DM6PR18MB3292:EE_
x-microsoft-antispam-prvs: <DM6PR18MB329217DE0FC4C86DBD89F553D81D9@DM6PR18MB3292.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3o9y3/s0gtiTGkpok7I8QtroAl1DsiR5Kl4chdGMxKBtCEl9B1Sw18mbjJz0ymKlw/ib8rXuNBSTQNh9C2UrfcdL2eCKo9MFgHeQukKRbZcb9AsQycIwfeyRle9X+55bmAhlWl69AU6TcMuGsIZ4/0WXUg4FRyOhnAOBT2tXgozMkxN1TggR4OcudZFqB5DwFhjabAm4En7rb/BRfXv9ooNPK1Q3j80ltRtzewm6RIw9Rm8fAI09bZFfs1QObs2lqy5V1PbsrIL2Jc4z1Ry6c1ld7I0mhmDfZHt03GsyTft2lzIToQgFgU9EhJChLibFBky7ukuUeudqaBEurUcf3C8Sc1Zek3pSDud3kXNIXAO5/OuaE5rGC2CDka5HP7H6mmxCl1P4oXFYRtnMIg9n4Mp77b6ajAHTfoIwIG4iJtlLlHr8davo3dvoFm1bUicGDEbJfEqh0gv0YTXWA4J8xfpVbm2dVgrCJjfHtF6JPVjwtJ2rR8o7xTv79RIW6LHCUvtSVyGsW38RKib0a/68HwbFoBd8n7me15+esL429U+Mr+HVrsMOGRDZoA0nRju63utl5pk2taedk9nQ5n9M435R3l36AjwRkIcjkGbAAgGIknwn8AmswgaGcmYS6b/xtyGIU/tKmZrcnfmETiwNGNnhtLk5V4G7iV6QMNpJH4W7LVB0mPxA8C+2kcTKy5dlPCMxZlwMrekL2dd3OYRCuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(55016003)(122000001)(9686003)(26005)(53546011)(186003)(6506007)(110136005)(54906003)(316002)(7696005)(52536014)(8936002)(38070700005)(86362001)(66556008)(76116006)(66476007)(66946007)(83380400001)(64756008)(38100700002)(66446008)(8676002)(4326008)(508600001)(5660300002)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODBJTWkwSC84U0ZaWFIrbG1PcHAvVE5ZeE91OEdpUDRWeitJS3RNNmFGLyto?=
 =?utf-8?B?RXUwRGFjalZ0YUc2bXhXUklkMWZZcXBnMVJqZWVHejhqaGhoL051RS9DaHpM?=
 =?utf-8?B?Z2NaRnhRZkhTMEpnVXhWN29VRVpGM3ErUzhKSjZQQ2haZlRjVWZqcWxMM0Ns?=
 =?utf-8?B?MnpWOEYyRjNMakdaL24rWmFEblgvK1BlVkhPcnZyYzY3MGR6dTBoSmcyaXRp?=
 =?utf-8?B?bmxudDI3b1RJZTNRSlNZN2d4Q3o5aGRwR0xPc04wdDduam1xMnJKTXJQbGdy?=
 =?utf-8?B?bVFFZm9VUGVqdTdtRHY4SUVEbUZtQ1VaRjhBQVFLZnQ0UXA1VWNvQ2VtZ1RF?=
 =?utf-8?B?OE85RzRjN1o2c0NEV1lWUzVNa1dDa3dlYlc3OWlyT0FlcTRjNFVIeWJ5UzE1?=
 =?utf-8?B?anUwWkZLR1gvWkVES2dLUit3RVJEMnZxcWtKRUFCM0JUZk95dXVlU2p1dFJT?=
 =?utf-8?B?QS9YSzhpVktVRGlrWGlzMDRCTmxLV3JuT0Njd1ZXMjFOMkpvRDExWS9FQWZL?=
 =?utf-8?B?UGlBcVkxQzdWZkQrSUg5azVOMHhGU045NnRnV3lMTDhTWkIvNDMyZ0NQWk43?=
 =?utf-8?B?YURYZldLTGdIWXdVcFlXSFA4amVYeklyaEFKTU1FVHloTlFtMXhSNDZMM0pR?=
 =?utf-8?B?QzJBNGF0Y1ZPZjNMKzdKQjBJY2NUOEtLdlhXb3llalJ3VnpObjltZk84NGN4?=
 =?utf-8?B?VW5CeUQ1L0NlRnF1WHJtWXFUNEo1LzM0WkJqckw0SjVIaWZLbFB6cWN1dHlu?=
 =?utf-8?B?ajVrZ0ZIYUdsa0RPSUNmZlNzd1pBTm1rVlVOSE5HYWYrZ3I2cVdUL29FdkFT?=
 =?utf-8?B?bzB5NEdWWklmU01La0Z4ZHhVQm51MXE2ZjVyY3l1aytLUmwzOG5YODI2NUF6?=
 =?utf-8?B?ZzJoWlJKS3Vmak42WEQ3OHZ6RDRQbGdLakUybnMyRmFZZUxIbTB6Zkp0QnMz?=
 =?utf-8?B?VzhOMVd5OWFEZlhpZFAwbVNkcjdaLzAwQTlKKzBlSDI3V0dYcW5ob3RUSWFl?=
 =?utf-8?B?TU9QSUErdkhVSDJNMmRSdXZueWZ4U1dKcmhWc2lham4wWWFQL3FoQnBWYnNq?=
 =?utf-8?B?Y1pjQVJYNFZXV01rU0I1MEo3QThFNk9ZN24vYmNSVGg0QmF1T1JHSzV2VS9R?=
 =?utf-8?B?cncyVXF4RW5xTTJHVHhYcnFCa3liZGRlRnhKZkdiSDB0YTIwbGNXbnBvSGNH?=
 =?utf-8?B?Wm9qeDlOc1M5Q0pFUFZHRCtLSGJBUktXdm1oTVF1MGVJTVlWOXFVUll6SnBY?=
 =?utf-8?B?WW9VRGhoM0xNM3RrTDhtWjBLWk01M29EY2g0Q29SQ3dyNHBMaTNOMi9CTGhH?=
 =?utf-8?B?RW9SckpVc0FHUVc2LzVENi9kdDQxRXpZdmU3QlJ5MFFWd0pIbTBiSkNNUUdQ?=
 =?utf-8?B?c3ltUWJJSm5pNkxxaHVMUmFLUGZrWkJEK1dIVHRmMlNQZnA1Z3QyOHRLRHNx?=
 =?utf-8?B?c3cwUlBZbHZldUlHYmgwSEgwcFlGdldCTXNNc2tVK1RCZU05TGlnT3FSSjdt?=
 =?utf-8?B?d0VXdGNNRkl1dnZEQ2t5T0w0SjFDSGdSbkx3cHBESVNMeWw2TmZmQS9UZVJ6?=
 =?utf-8?B?YzNTZ3Yra2w5cExkWGlBSElCOENxLzh2RE84dk5LeHVENFQzblRhWnZJTDNq?=
 =?utf-8?B?ME5kbWVoWWRxelRKaktpWE5yaEJDbmlCVmFOc0dteVM5Q1dXTzArcjAvMlNB?=
 =?utf-8?B?cmg0aHJzMzBoNU4zditPeFFIMUJKQVZPK3pVWEdzU1RMQXZlcTVCVTBWZlU3?=
 =?utf-8?B?cGNZMHlGWE5yQTFwMVZocUlRR0FaNWVYbGcrTENWbmRyYXpNOHpFbTc4S2dS?=
 =?utf-8?B?MGZxY2tpSVN5MmZ6RW1MSXZtOTVraysrc3J2enVicHVYQ3Y0aWdUc21DWTRq?=
 =?utf-8?B?TkFsYUZvbVE4a2crNlNralh5ckFNL29VYjZLYktzQ2ZUSVdVeVN0NzVGWU5y?=
 =?utf-8?B?N1RNU1dPaTR2R3RtRERuOVF2bmw0ZTNNeFg4QWhyaThZTGd6ZlZ2MnJoWFhy?=
 =?utf-8?B?aExKZjI0YXJFVFZJcThIb2RKRHlvcGszbkxrTmpZYUc0ZE1sb2Y5b3FQTzFD?=
 =?utf-8?B?ZFdCZ3BuUGcwL1Axa2NQOE45RGxkUnVZQVF0bXZlbTRHcE1DWGVtdHJFUWlU?=
 =?utf-8?B?QmUzU1FwMkJUa3hGa093YzRBdkpSRkJaTzEwNHFyUTBvc1E2MEQzQzkzRXZo?=
 =?utf-8?B?TUV6M1ZSN09VcXhTakdLREREMmk1QkxaUjlpMjhhZHA4VVlXSnhVa29WNmlL?=
 =?utf-8?B?Y1hvNktpYys5V3ZDMEVFOXdSQ2o1MUtuMjdVUTYxWkFZVWlTYW5wYnRxWk9y?=
 =?utf-8?B?NDZuLzFuOW5BZkU5bTNwU3RPMnNOY3cwZ1VxcjhnMFV2NW0ya0NXQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15565959-6f89-4af5-27e3-08da10d823ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 16:29:32.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8rK71qMHwVsRhG7fVjgq026fXaCrY9weKcElWMiNeFL3bdjACKPrxARaaypjmcutYJwkcsTcylq/9clBL3ASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3292
X-Proofpoint-GUID: ZG3jh-QDR9uyRy1pJAa15hZhITOHrp0R
X-Proofpoint-ORIG-GUID: Ljv6hNF2DNoVl0Knu5y79DQrCyWJ9zjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_07,2022-03-28_01,2022-02-23_01
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gSWFuIEtpbmcg
PGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTWFyY2ggMjAsIDIwMjIg
NDo0NSBBTQ0KPiBUbzogTmlsZXNoIEphdmFsaSA8bmphdmFsaUBtYXJ2ZWxsLmNvbT47IE1hbmlz
aCBSYW5nYW5rYXINCj4gPG1yYW5nYW5rYXJAbWFydmVsbC5jb20+OyBHUi1RTG9naWMtU3RvcmFn
ZS1VcHN0cmVhbSA8R1ItUUxvZ2ljLQ0KPiBTdG9yYWdlLVVwc3RyZWFtQG1hcnZlbGwuY29tPjsg
SmFtZXMgRSAuIEogLiBCb3R0b21sZXkNCj4gPGplamJAbGludXguaWJtLmNvbT47IE1hcnRpbiBL
IC4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPjsNCj4gbGludXgtc2NzaUB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gW1BBVENIXSBzY3Np
OiBibngyaTogRml4IHNwZWxsaW5nIG1pc3Rha2UgIm1pcy1tYXRjaCIgLT4NCj4gIm1pc21hdGNo
Ig0KPiANCj4gRXh0ZXJuYWwgRW1haWwNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gVGhlcmUgYXJl
IGEgZmV3IHNwZWxsaW5nIG1pc3Rha2VzIGluIHNvbWUgZXJyb3IgbWVzc2FnZXMuIEZpeCB0aGVt
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFp
bC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zY3NpL2JueDJpL2JueDJpX2h3aS5jIHwgNCArKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9ibngyaS9ibngyaV9od2kuYyBiL2RyaXZlcnMv
c2NzaS9ibngyaS9ibngyaV9od2kuYyBpbmRleA0KPiA1NTIxNDY5Y2U2NzguLjdmZTdmNTNhNDFj
MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL2JueDJpL2JueDJpX2h3aS5jDQo+ICsrKyBi
L2RyaXZlcnMvc2NzaS9ibngyaS9ibngyaV9od2kuYw0KPiBAQCAtMjM5OCw3ICsyMzk4LDcgQEAg
c3RhdGljIHZvaWQgYm54MmlfcHJvY2Vzc19jb25uX2Rlc3Ryb3lfY21wbChzdHJ1Y3QNCj4gYm54
MmlfaGJhICpoYmEsDQo+ICAJfQ0KPiANCj4gIAlpZiAoaGJhICE9IGVwLT5oYmEpIHsNCj4gLQkJ
cHJpbnRrKEtFUk5fQUxFUlQgImNvbm4gZGVzdHJveS0gZXJyb3IgaGJhIG1pcy1tYXRjaFxuIik7
DQo+ICsJCXByaW50ayhLRVJOX0FMRVJUICJjb25uIGRlc3Ryb3ktIGVycm9yIGhiYSBtaXNtYXRj
aFxuIik7DQo+ICAJCXJldHVybjsNCj4gIAl9DQo+IA0KPiBAQCAtMjQzMiw3ICsyNDMyLDcgQEAg
c3RhdGljIHZvaWQgYm54MmlfcHJvY2Vzc19vZmxkX2NtcGwoc3RydWN0IGJueDJpX2hiYQ0KPiAq
aGJhLA0KPiAgCX0NCj4gDQo+ICAJaWYgKGhiYSAhPSBlcC0+aGJhKSB7DQo+IC0JCXByaW50ayhL
RVJOX0FMRVJUICJvZmxkX2NtcGw6IGVycm9yIGhiYSBtaXMtbWF0Y2hcbiIpOw0KPiArCQlwcmlu
dGsoS0VSTl9BTEVSVCAib2ZsZF9jbXBsOiBlcnJvciBoYmEgbWlzbWF0Y2hcbiIpOw0KPiAgCQly
ZXR1cm47DQo+ICAJfQ0KPiANCj4gLS0NCj4gMi4zNS4xDQoNClRoYW5rcywNCkFja2VkLWJ5OiBN
YW5pc2ggUmFuZ2Fua2FyIDxtcmFuZ2Fua2FyQG1hcnZlbGwuY29tPg0K
