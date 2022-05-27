Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586E535933
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbiE0GSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiE0GSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:18:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D466CA4;
        Thu, 26 May 2022 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653632282; x=1685168282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eFYsBdd2xTTygEpA5tIuMqsLnB1/UK0Wt8rdDuTFD0E=;
  b=dVlRgGu+n4EYHGe4A2V14twIwkX2+A1TGqMOgPLnbN3GsekLelbvWW2T
   292c31xeVJFnLTcl/Tc1+QnR9JUC1raqtha2Asnc1me6PpAN+ztV6Bbol
   bJaXZegHgW+Y/2aqksdX1IvQyR4i7/9V8IQh+zYRx/RKWQ/Vr7MF0Z+wC
   l2lqcQz7zPtYSd4sDQiaOX28+HVh4PSdcJE9Nhw9OnR1mh9V/EMys5J0i
   /p3puJ9DzW/WdsWo86oTu6F8J9ImJOpKSgTxL4yo2h8GBpxaAaA5x2KbN
   fhZ/tHRVmr7wQNwbL27D7YLwmQC8Z1JHxrKhww0WxslqZ+QKSmxpSStqm
   g==;
X-IronPort-AV: E=Sophos;i="5.91,254,1647273600"; 
   d="scan'208";a="200356792"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2022 14:18:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRviZ8uuMSHwqJW4nnW7Dzn686rk8vUiWIAdUHC9jFQvMd+iI7C+ng9UhnYw+fZ/SvQePXK0290jPQiEKbocDgykEevM87jf2GMFnTyAaKdDl/bvHuj6f1jxnWhd9TPxbpOHl/NM2pfJay7I1AMW7cOs+KvAX9m73IOv5UGkcKD998NQRETmpGLG7PHWqnyeaahN4Sb3XlSLzpBvNZ7Pqs/CyLNfVHcNVnXBElrf0YAe8q9EuUCOLnZGZVLi7FKYwmi/32y3aUZRN3FUVEENTGeLoKJZRCH9ntZYMiv2lDJqAS0Ibxg+GzHBJFpNEr7usit9eP7tqo+L8bulNLKJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFYsBdd2xTTygEpA5tIuMqsLnB1/UK0Wt8rdDuTFD0E=;
 b=N/+6BLd0qnaySzuaNvh2Gj+J6+tqcR/Xm3XL8iZ+ADafSh4uYiTSUQGiQBa4WnOLDIfJVG1i/5ZZyUkIhgrTH/JIF58dOtbuywqcdmSM6ZH4brsQFhwJjJQ1ypecPV5Xsu7E0mILmZf+nTZyYnk84/iq09iy+owxbfDs/EqVOnxAY97hXlU5e3Utxb9l8JFv4/D3KEJUJuqHwrxkbTWbBsqFlf1NGKgsVgVRmV8Qkjm9USVcUf7N+We5vC6w3Kw9WaRutLXboO+0ieLA4FC+Gz8SDaFbWXzMhwSTbMlb+ZqGFvvPD404gZCCsJhPLhu8jFyIGoftQ47q7+ZeGXg1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFYsBdd2xTTygEpA5tIuMqsLnB1/UK0Wt8rdDuTFD0E=;
 b=RtsZxPcoIm8AwvOOd1SXlryRP+x19SyUzeP3TRt1TwyfHyFsI6pqlmMHWGIJkjQbkLXU9TRylKuw/zUjSEiMxJ5CbXB+6T9HcXnB+0Xs3FrcjFA7w0VCltPnjAg4eQVXjUEtbiD7cW/ZJdAnrPczOgR02JZ9Zd7cg5GKcQ91OAY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL0PR04MB4932.namprd04.prod.outlook.com (2603:10b6:208:58::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Fri, 27 May 2022 06:17:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb%3]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 06:17:57 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "a5b6@riseup.net" <a5b6@riseup.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
Subject: RE: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Thread-Topic: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Thread-Index: AQHYcFYp99UCK0BeAUyoAx4mv1ya/K0v5+fAgAGxOoCAAKiPUA==
Date:   Fri, 27 May 2022 06:17:57 +0000
Message-ID: <DM6PR04MB65752422396C86EAD4591701FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220525164013.93748-1-a5b6@riseup.net>
 <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
In-Reply-To: <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dd145ff-61ea-4792-4cc5-08da3fa8a4be
x-ms-traffictypediagnostic: BL0PR04MB4932:EE_
x-microsoft-antispam-prvs: <BL0PR04MB49320A06B939E88476A23FFCFCD89@BL0PR04MB4932.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WXXELPBVVyxLbl53dXG1fLnPD6aphCOb0fQZZuwEcRN1S+wsIKmMOxy2f2jfNqwxAHWbtQiIox4X9EkhR2lx5sj/pSWLgthGaEjx5z01BkehnDVmL4y0PsG0xqzIdxtpXhDx+w4cGkgbbeM0oopl/HFSoQGzS1EO7evvSrBJo9V8IoftzwOr4e3Q+lHFotmL30iyeJwDKbhDt3vyFod3OYG0Sqdyx7mw6uAU7yDH0N3THd6/L3fJ3gCJbMuTO6NZTUPoytJo3pKCoghixqszxeNbTP6Qm718x4MCa6GOW9h3laKFRXeguJNkkl4rsKC0hMDekWKWLJg95dB+WjJxsrK5J6qu+gTkJACwu3xvUx79k18/KTKFBFIXzS8GbSnohc8+tpzrLbwGjjL44CuejuIV3LnZp8A+mg9vKT/ROU+pLRO44l7lVDMekH59+OT4Ahta2pR1fJFHXA5K3HqHfQw3amwJpptTpD3qac//nLqvpd3uU0sC3YR7lJQLI/eoyuCFvR6lY+keo+Tt5ITkCjVJwGNaR+0PU0nJJ0S25Dm7WscKdTeHhyQ4n8Lu4c6QBYI6W2cGxeAHRz6ktvk9czKn4eB7bwqc3yCdu5tADvbE1Qf50AKl55U+iFKjEyAFnXodxMJsgRZach6H9bMifw0Stc7+Ck1SJH06hQcoOSUnl1C9ul+pO1sJ3HyKdE7n4CcLqf6IuNgiVFvVnEEpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(9686003)(6506007)(316002)(76116006)(33656002)(8936002)(82960400001)(71200400001)(508600001)(122000001)(26005)(54906003)(7696005)(110136005)(8676002)(38070700005)(53546011)(4326008)(38100700002)(186003)(52536014)(64756008)(86362001)(66446008)(5660300002)(66476007)(66556008)(2906002)(66946007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnAvSjk4OTlhVHFsVG5aKzRrK0hWSkg5bStzQ1dLMFkxNXRhNWthRHFZbWtR?=
 =?utf-8?B?dzl6OHoyZ3YrSTJrczlrem4ySXowZU4zZkdkc1dSTDVVUW9CZUFVTnVTMjVx?=
 =?utf-8?B?UjR1UUNCOE1qWWJDTEhRbndKVlRzRisrd1R6MHhTdWR1WlIrSWNqbGxmWXNp?=
 =?utf-8?B?U2twZEl2a291Rmpmb3hBeExMUUthcTBWeDIrM0xxaUhNZWVKdENUd2g3aTk1?=
 =?utf-8?B?ZStiTzBud3pyZ3BjKzgvQTRKa3FPQUdmRGZQdVJ1MTJYQ3NDYkllbUpOOVBQ?=
 =?utf-8?B?ZmdiV3BLZmw2djZFWHZrNloxbmhGQ0RwRXoySGZOU2dtV1M3dGdGVUxDN0wr?=
 =?utf-8?B?bUloTFhrK3c0YzNSbUxRZGwzajlQQnkvR2wxTmFnL2ZJbGdvTmZ3anBlSmtS?=
 =?utf-8?B?RW1DaXRMd0U3bWZsQUd3cThaWXNjMGdKZTR1TWVpK0tSS2ZUclYweVRZN2ZK?=
 =?utf-8?B?QVF2VEpINHBuUG96Um5mVDR5VWhPaUwxVTdPcGlEZ1NHUFJoY25YNndXa2Ja?=
 =?utf-8?B?VUx3b1UzR3hyR3FzM1JsSzdFZW4wbXU3L09rRmlnRGNDaWdrazM4M2VweWYw?=
 =?utf-8?B?cTBHaEZ4Q2hlUXJnVXpINFhFZno5MU1QbnI2SXhYekNkTDB3dG1GNWc3OVFZ?=
 =?utf-8?B?VlNreW9MWU44WXpqT0VqN0VRMGRpc3htZkdwRFUyS1FmQzlld3JFdGpsWGhx?=
 =?utf-8?B?Nm1aQTZGWnBUNnRITlh3cnFCaXN0QURCb2JjaERqOVpKUkJXRzUxOVFKa3pI?=
 =?utf-8?B?bEZLUm93OUx3dFM5QTdFQ1oxbERmdVRDUTRldHlDK254ZVNvcm10TWw5SURF?=
 =?utf-8?B?eEF2YnlQUVdiYjlGNkJEdGFQclNHZG1yR2ppZE9wOUVKWmdCTlo5a1E3UytU?=
 =?utf-8?B?aVFVRDgvSDFDOStGWlpQWHRndG1MMnh6UkNkYldDd0ROREtYSDZ3NWc0OUw2?=
 =?utf-8?B?dGJFQWx2eVJxNUE4c3FzamZDbXNVTU1xbjlBRk9henBBLzhmelBFYjI5RUQ0?=
 =?utf-8?B?ajU4Qlp1Z2o2aUcranRGam5qU1F2U05yVmdMcUozY1hIK0E1ZjFQN3l6aUtQ?=
 =?utf-8?B?cGV2eFpwZjZxVEpKWUFMVUt4OHVsTTZsdmlBNGhlYjE0d1FXNENjMEVaVEZq?=
 =?utf-8?B?aWhhTTdYdHdXSVVQaG5zQjhLblhTSTUyelJwNVNZd280cnBZdXFoK1NTeDQx?=
 =?utf-8?B?akFmSkZtWGF2eFRGdGNvRXhxWjQzald2aktEV09QWHA2aGtHaGI4L1p1eGZX?=
 =?utf-8?B?RjRTQi9XeVV1aEVjOEgxeEpHMW4zSnd0V1Z1MlFxRjdldXB1ZloxUUR0Q04w?=
 =?utf-8?B?TTRTdW1YOGMvbndETVRybGlabjVIZGpQcURJcjRiNGtuOS8rbEh6WjRaZVY0?=
 =?utf-8?B?QWJqM0RFaFNXUkE2bnpscGR6WTB5WTdRRlU3bkJNbXF1STRjenRIQmFuekox?=
 =?utf-8?B?MXo0ZEppcm9zR2N2MmxkZTk0Y3o0NUdub2lWQklZcHZXWWFBamZQQkhMNzVp?=
 =?utf-8?B?dXpJZkd2MVFBdWNGR0dqQTNTV1RCVlduSlZ0T0hXQjljdkFWY25kc0Nmekp1?=
 =?utf-8?B?TElJeG1mc2JNeWNRM0RYdFVvNE5aQ3MwQ1MyK0hGNkc0VStPMjNQWVM4Y0Yr?=
 =?utf-8?B?TTN6Rll5bGhXWkp4N1o4a0FLQ2J1RWhkQVhkTUpmc05mamF0YjBCVTNsOWRk?=
 =?utf-8?B?KzNFb3J1UWV2YkxzRTZYTnk3VEtrQmNRV0FtNG1HOG03dkFLR3dvLzlSQUJI?=
 =?utf-8?B?NDcrSnNZRnlLVFJPOFBwQ2FFWlAwRGt1Tk9oenNJaFN0d0ZLTEpQNGNvdEE5?=
 =?utf-8?B?S0loaHRPNVZxU09MSjJRdEhxa1h2cjdSclc3bXEwenBDWDU5L1p1NGhxUmcv?=
 =?utf-8?B?T3lpUnIwN1J2d0ZlK1pEeWlneDVsZGVJZ3hCUlRCRkwxNUkrbzZ1SUVnY2F3?=
 =?utf-8?B?K0lUU3FRVVVqZFhNTHpRZTE3Y2VsOURSNE9LZUtFNmJVKzA5d1BJUU5ZeE1Z?=
 =?utf-8?B?U1NPY01QaHdqVkh2cU1PNzF0M3ByQkFtSjJmVUFRNDVjL2F0dVdmWDlTV3hk?=
 =?utf-8?B?b0V0K2pmYzk3YWpJZ2RBa0FlMFNVT3QwM001dVRWWnZrc2tyZ0ZjM0dsMEs1?=
 =?utf-8?B?YzhLZFJVdXNmNlY0Z0pxTkJ5ODlBU3NOOVF6a3Vwbjdha1Z1OXhOeTZGTSs3?=
 =?utf-8?B?UzNITExjbnlWT01KRUZwajFWZUFrblkwUk1jbXBadllQME1kRXh4TUwvUFd5?=
 =?utf-8?B?S243MzNVV1k5RUJST0N5SVl5WkdpMEM5OEVaRFdobk1WQWR2MXJ4czJVTXJ1?=
 =?utf-8?B?VGZnak4rajFlTHdOYVB0LzhsZElOYzJKUS9uRWVhNDZGaWJ5UDJjdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd145ff-61ea-4792-4cc5-08da3fa8a4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 06:17:57.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9ULo6kva46RcEPSZmH+ODzGxlfUDz7Q5ntMOerhq8OCFa24EYXkIjUuqyzXmfXTO6IMsVupnC4eKQi0NrG6Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4932
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSGksDQo+IA0KPiBNeSB1c2VjYXNlIGlzIGVuYWJsaW5nIGJvb3Qgc2xvdCBzd2l0Y2hp
bmcgb24gQW5kcm9pZCBBL0IgZGV2aWNlcywgd2hlcmUgdGhlDQo+IGFjdGl2ZSBMVU4gaGFzIHRv
IGJlIGNoYW5nZWQgaW4gb3JkZXIgdG8gZmFjaWxpdGF0ZSBlLmcuIGR1YWwtYm9vdGluZyBBbmRy
b2lkDQo+IGFuZCBtYWlubGluZSBMaW51eC4gQSBzaW1pbGFyIGludGVyZmFjZSBpcyBleHBvc2Vk
IGJ5IEFuZHJvaWQsIGFsYmVpdCB2aWEgaW9jdGwuIEkndmUNCj4gdGVzdGVkIHRoaXMgcGF0Y2gg
YW5kIGNvbmZpcm1lZCBpdCBlbmFibGVkIHRoZSBuZWNlc3NhcnkgZnVuY3Rpb25hbGl0eS4NCj4g
DQo+IE9uIDI1LzA1LzIwMjIgMjE6MzQsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IEhpLA0KPiA+
PiBFeHBhbmRzIHN5c2ZzIGJvb3RfbHVuIGF0dHJpYnV0ZSB0byBiZSB3cml0YWJsZS4gTmVjZXNz
YXJ5IHRvIGVuYWJsZQ0KPiA+PiBwcm9wZXIgc3VwcG9ydCBmb3IgTFVOIHN3aXRjaGluZyBvbiBz
b21lIFVGUyBkZXZpY2VzLg0KPiA+IENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3aHkgaXMgaXQg
bmVjZXNzYXJ5Pw0KPiA+IFdoYXQgdXNlIGNhc2UgYXJlIHlvdSBydW5uaW5nPw0KTkFLIHdpdGgg
cHJlanVkaWNlLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBO
aWEgRXNwZXJhIDxhNWI2QHJpc2V1cC5uZXQ+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvc2Nz
aS91ZnMvdWZzLXN5c2ZzLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnMtc3lzZnMuYw0K
PiA+PiBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLXN5c2ZzLmMgaW5kZXggNWM0MDVmZjdiNmVhLi43
YmY1ZDZjM2QwZWMNCj4gPj4gMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZz
LXN5c2ZzLmMNCj4gPj4gKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMtc3lzZnMuYw0KPiA+PiBA
QCAtMTA0Nyw2ICsxMDQ3LDcxIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB1ZnNoY2RfaXNfd2JfYXR0
cnMoZW51bQ0KPiA+PiBhdHRyX2lkbg0KPiA+PiBpZG4pDQo+ID4+ICAgICAgICAgICAgICAgICAg
aWRuIDw9IFFVRVJZX0FUVFJfSUROX0NVUlJfV0JfQlVGRl9TSVpFOw0KPiA+PiAgIH0NCj4gPj4N
Cj4gPj4gK3N0YXRpYyBzc2l6ZV90IGJvb3RfbHVuX2VuYWJsZWRfc2hvdyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPj4gK2NoYXIgKmJ1Zikgew0KPiA+PiArICAgICAg
IHN0cnVjdCB1ZnNfaGJhICpoYmEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPj4gKyAgICAg
ICB1MzIgc2xvdDsNCj4gPj4gKyAgICAgICBpbnQgcmV0Ow0KPiA+PiArICAgICAgIHU4IGluZGV4
ID0gMDsNCj4gPj4gKw0KPiA+PiArICAgICAgIGRvd24oJmhiYS0+aG9zdF9zZW0pOw0KPiA+PiAr
ICAgICAgIGlmICghdWZzaGNkX2lzX3VzZXJfYWNjZXNzX2FsbG93ZWQoaGJhKSkgew0KPiA+PiAr
ICAgICAgICAgICAgICAgdXAoJmhiYS0+aG9zdF9zZW0pOw0KPiA+PiArICAgICAgICAgICAgICAg
cmV0dXJuIC1FQlVTWTsNCj4gPj4gKyAgICAgICB9DQo+ID4+ICsgICAgICAgaWYgKHVmc2hjZF9p
c193Yl9hdHRycyhRVUVSWV9BVFRSX0lETl9CT09UX0xVX0VOKSkNCj4gPiBDbGVhcmx5IGJCb290
THVuRW4gaXMgbm90IGEgV0IgYXR0cmlidXRlLg0KPiA+DQo+ID4+ICsgICAgICAgICAgICAgICBp
bmRleCA9IHVmc2hjZF93Yl9nZXRfcXVlcnlfaW5kZXgoaGJhKTsNCj4gPj4gKyAgICAgICB1ZnNo
Y2RfcnBtX2dldF9zeW5jKGhiYSk7DQo+ID4+ICsNCj4gPj4gKyAgICAgICByZXQgPSB1ZnNoY2Rf
cXVlcnlfYXR0cihoYmEsIFVQSVVfUVVFUllfT1BDT0RFX1JFQURfQVRUUiwNCj4gPj4gKyAgICAg
ICAgICAgICAgIFFVRVJZX0FUVFJfSUROX0JPT1RfTFVfRU4sIGluZGV4LCAwLCAmc2xvdCk7DQo+
ID4+ICsNCj4gPj4gKyAgICAgICB1ZnNoY2RfcnBtX3B1dF9zeW5jKGhiYSk7DQo+ID4+ICsgICAg
ICAgaWYgKHJldCkgew0KPiA+PiArICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gPj4g
KyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+PiArICAgICAgIH0NCj4gPj4gKw0KPiA+PiAr
ICAgICAgIHJldCA9IHN5c2ZzX2VtaXQoYnVmLCAiMHglMDhYXG4iLCBzbG90KTsNCj4gPj4gK291
dDoNCj4gPj4gKyAgICAgICB1cCgmaGJhLT5ob3N0X3NlbSk7DQo+ID4+ICsgICAgICAgcmV0dXJu
IHJldDsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiArc3RhdGljIHNzaXplX3QgYm9vdF9sdW5fZW5h
YmxlZF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXpl
X3QgY291bnQpDQo+ID4+ICt7DQo+ID4+ICsgICAgICAgc3RydWN0IHVmc19oYmEgKmhiYSA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+PiArICAgICAgIHUzMiBzbG90Ow0KPiA+PiArICAgICAg
IGludCByZXQ7DQo+ID4+ICsgICAgICAgdTggaW5kZXggPSAwOw0KPiA+PiArDQo+ID4+ICsgICAg
ICAgaWYgKGtzdHJ0b3VpbnQoYnVmLCAwLCAmc2xvdCkgPCAwKQ0KPiA+PiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gWW91IG5lZWQgdG8gdmVyaWZ5IHRoYXQgbm8gb25lIHNl
dCBiQm9vdEx1bkVuID0gMHgwIGJlY2F1c2UgdGhlIGRldmljZSB3b24ndA0KPiBib290Lg0KPiA+
IEJldHRlciBjaGVjayBleHBsaWNpdGx5IHRoYXQgc2xvdCAhPSBiQm9vdEx1bkVuIGFuZCBpdHMg
ZWl0aGVyIDEgb3IgMi4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBBdnJpDQo+ID4NCj4gPj4gKw0K
PiA+PiArICAgICAgIGRvd24oJmhiYS0+aG9zdF9zZW0pOw0KPiA+PiArICAgICAgIGlmICghdWZz
aGNkX2lzX3VzZXJfYWNjZXNzX2FsbG93ZWQoaGJhKSkgew0KPiA+PiArICAgICAgICAgICAgICAg
dXAoJmhiYS0+aG9zdF9zZW0pOw0KPiA+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsN
Cj4gPj4gKyAgICAgICB9DQo+ID4+ICsgICAgICAgaWYgKHVmc2hjZF9pc193Yl9hdHRycyhRVUVS
WV9BVFRSX0lETl9CT09UX0xVX0VOKSkNCj4gPj4gKyAgICAgICAgICAgICAgIGluZGV4ID0gdWZz
aGNkX3diX2dldF9xdWVyeV9pbmRleChoYmEpOw0KPiA+PiArICAgICAgIHVmc2hjZF9ycG1fZ2V0
X3N5bmMoaGJhKTsNCj4gPj4gKw0KPiA+PiArICAgICAgIHJldCA9IHVmc2hjZF9xdWVyeV9hdHRy
X3JldHJ5KGhiYSwNCj4gVVBJVV9RVUVSWV9PUENPREVfV1JJVEVfQVRUUiwNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRVUVSWV9BVFRSX0lETl9CT09UX0xVX0VO
LCBpbmRleCwgMCwgJnNsb3QpOw0KPiA+PiArICAgICAgIHVmc2hjZF9ycG1fcHV0X3N5bmMoaGJh
KTsNCj4gPj4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4+ICsgICAgICAgICAgICAgICByZXQgPSAt
RUlOVkFMOw0KPiA+PiArICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4+ICsgICAgICAgfQ0K
PiA+PiArb3V0Og0KPiA+PiArICAgICAgIHVwKCZoYmEtPmhvc3Rfc2VtKTsNCj4gPj4gKyAgICAg
ICByZXR1cm4gcmV0ID8gcmV0IDogY291bnQ7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gICAjZGVm
aW5lIFVGU19BVFRSSUJVVEUoX25hbWUsIF91bmFtZSkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4gPj4gICBzdGF0aWMgc3NpemVfdCBfbmFtZSMjX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+PiAgICAgICAg
ICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPiA+PiBAQCAtMTA3Nyw4ICsxMTQyLDggQEAgb3V0OiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ID4+ICAgICAgICAgIHJldHVybiByZXQ7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4+ICAgfSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4+ICAg
c3RhdGljIERFVklDRV9BVFRSX1JPKF9uYW1lKQ0KPiA+PiArc3RhdGljIERFVklDRV9BVFRSX1JX
KGJvb3RfbHVuX2VuYWJsZWQpOw0KPiA+Pg0KPiA+PiAtVUZTX0FUVFJJQlVURShib290X2x1bl9l
bmFibGVkLCBfQk9PVF9MVV9FTik7DQo+ID4+ICAgVUZTX0FUVFJJQlVURShtYXhfZGF0YV9zaXpl
X2hwYl9zaW5nbGVfY21kLA0KPiBfTUFYX0hQQl9TSU5HTEVfQ01EKTsNCj4gPj4gICBVRlNfQVRU
UklCVVRFKGN1cnJlbnRfcG93ZXJfbW9kZSwgX1BPV0VSX01PREUpOw0KPiA+PiAgIFVGU19BVFRS
SUJVVEUoYWN0aXZlX2ljY19sZXZlbCwgX0FDVElWRV9JQ0NfTFZMKTsNCj4gPj4gLS0NCj4gPj4g
Mi4zNi4xDQo=
