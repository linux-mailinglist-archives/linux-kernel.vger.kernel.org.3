Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFB5063BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348007AbiDSFLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiDSFK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:10:59 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E5201A1;
        Mon, 18 Apr 2022 22:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1650344895; x=1650949695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Gm2BEjk01dWPU9VShBSRUCoafFByXaFxgxhVeHaVOk=;
  b=eH6t1qPBe7bkTRHQ/lUxN/Iqjc+iVxkZGA22RKTJRSzUzO5KiSICEk3u
   /B564Q4qdqHkLbadRZ410She2MAa4bhO2ANHHSbu9iJdw5kloj6z4/4gG
   65p0cF11KQ2c+6l9WqN7y8BNIdqE+n9vQSSMiXfnfVGVXCkM5oLCuYt2Y
   w=;
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 05:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn3G9HbJ/jnhcC0o43GyoAIAamMP6wblbAqH93iEjXw19V5LuJC4965aTwnVNs0QBrlKDpkqf0hVhE23MWgJPBmYq3k0b/HmLk66PGJO446l+/1eJ4rlMk9kFherC1aI+VLmtKQvX7Lxh52t4+fLD8yI7lNGmOkwq7RgIPvM10S2NDibmIs+CJixCVBEbtQ8FVH6v+VoRnS+5Iu1WsTrstBwhQaoZj643iUfX8sobO4bM8kssQe7s4A8jP3CR5Y6xOzNZzfN63qpO53V+5xVE1Z9mCBpBy2frQOiwzbqymdEkuXYXUQYeg5ylwCDnWfS9964G9wjzLRfIn5l9Qol2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Gm2BEjk01dWPU9VShBSRUCoafFByXaFxgxhVeHaVOk=;
 b=OzBVb4fcMuSLRJiTirztN8LvQv57H9Qtc/DH4qWVijdmAt4rRFXQYebTXPdNWTMMZwgex4JT1gF4hLhPntt/EoV0OUb5xyxAu/K71LGbRVYKds9kHxOYUj1FoePi+Fs05fwmv4VPLWTVjcdgCzXLmOMXlH6LC/cbcOMwU4OE8d3XqG9bwLHsq45jLwYjMmv5AlP3Xef3YZ9fDOcm/OxUMAlzu1oH3CXb1mQekZv1I1Hmk3gXmqZ60aKB3ID1s2dYDduvyAwOy5VfEJ5zJtBB0cuAWeSjyzDcJURkkHkVu2ur+6HsoT2PFOhYthGalRIJWr4OFTGmCh6RajgT5jMEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB5148.namprd02.prod.outlook.com (2603:10b6:5:48::21) by
 PH0PR02MB7144.namprd02.prod.outlook.com (2603:10b6:510:9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Tue, 19 Apr 2022 05:08:11 +0000
Received: from DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::e9cb:6ab4:b2c0:5dd6]) by DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::e9cb:6ab4:b2c0:5dd6%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 05:08:11 +0000
From:   "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>
To:     "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "Maheshwar Ajja (QUIC)" <quic_majja@quicinc.com>,
        quic_jdas <quic_jdas@quicinc.com>
Subject: RE: [PATCH v4 0/2] Introduce Intra-refresh type control
Thread-Topic: [PATCH v4 0/2] Introduce Intra-refresh type control
Thread-Index: AQHYN4uuAoJtvWOorUSUOf0AwSqjm6zjeQOAgBNu0MA=
Date:   Tue, 19 Apr 2022 05:08:10 +0000
Message-ID: <DM6PR02MB5148F8DD51F2E69B6C739231F3F29@DM6PR02MB5148.namprd02.prod.outlook.com>
References: <1647252574-30451-1-git-send-email-quic_dikshita@quicinc.com>
 <3987e143-59c6-f5dc-77a5-f58043e84de3@linaro.org>
In-Reply-To: <3987e143-59c6-f5dc-77a5-f58043e84de3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dd87cba-76b8-48ea-2f6e-08da21c2999f
x-ms-traffictypediagnostic: PH0PR02MB7144:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR02MB7144A30514A5011A9A2B50168FF29@PH0PR02MB7144.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XtZBWdxCqp5hVIIjo/Kg6On4crBQdtTQDJxl6McxvkCKQe5HIbZ1xe3ljBd8m3AjsHU+Liv4UbxPA73Vg2BhNTkMqaPyAPQTh6uIyqu2QaSft5CMfiin9ctTiB0rqHKpHhvT4ZTiEoH9hXl4KnxGXtfMtlUQJoMXhKseehOQAr0wwkHMYkCBxrOWJJ2En5Rxq4sAykHZGcM9YHY2vgPJ4tdlrwB++mdiW45UEYZQpsTLN7dLieRSAsFJv4wcBIm126xng00eKE0EquAeWwYdzVmIOkAfwuyYLKJBgySXQdaGSvma0fmls1GBl0d/PXU7faXn+fLwada/rrcZ1HBo8F8bouw2bHt9y+N+uPCA8eR34GIG7FUbTRVpIoawKj8q/plyuzzlnxK4rpPGwYML54y/w56XN3lIgMz/0whWbTSSoVfKL1tkZmeVQZGvpp8ibKZIbZu9dHjkVmXZ3FYEY1epifbdrwR6wHOXdARTYA2T4tv6HqiSnHrRizoPBEOy01SmJ6pJT7FcfbxSGLaA2ps+qIUcAbUM5gmx5fikBA8pwF2KaXFw5QYVlr8oPWWRQ3opRPxTDYAKuCRs9CIi4PshsRQfWQ3eHX4CYENJ3nPKW5VuUSbdMEoY4+KQDNHL+UNoIhCzIELlxAe+h5koCVuS05W5OQePMMQqhfDGqjhuAjWOQGb0d+fV9TW5Gxq2OFFK7PsVm1VLwkkUXL3kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5148.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(71200400001)(66946007)(76116006)(64756008)(4326008)(8676002)(2906002)(33656002)(38100700002)(5660300002)(83380400001)(122000001)(54906003)(110136005)(66556008)(66446008)(66476007)(86362001)(52536014)(8936002)(26005)(186003)(107886003)(508600001)(53546011)(9686003)(38070700005)(6506007)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFJWODJ0NnJNaXJ3V0hhSmJRTnM1ZktRYm45ZzdZNHlQOHpORng2c0Y5WVVr?=
 =?utf-8?B?NzVJZTBsNGtxV1pGNitSZkYwN0J0VHRhaVJUOUtkNTVOS0d6Z0tRZWwxTGp1?=
 =?utf-8?B?L1RJT0RKR0pvdFYxa1RNVGZ0d09XYjhHQzJ3VGJscTdVVDFVdUlQS3BWMi85?=
 =?utf-8?B?QTBZOUhVS3J2R0MzcGFTenYzTnZTZ3gvd0lrQU1mbkRZekYvamt4RnQ4eFdk?=
 =?utf-8?B?UVBmSUt5Rnh0OGJ0TTcvY0g5K2laV0RMRDJsUnlZeHIwMDRDd1BzeGI3NTUz?=
 =?utf-8?B?UlZqVnBHZitrdmluM2xHZjRRckZ1Z0pFSmhLRnB4M1FkVXVFcGw0VzJFdVJi?=
 =?utf-8?B?WXNwREpLN2xtdGgrVmJtaEw3bHdMM1MvQmV5S3FQTjBEd0ZJcU1Na1UrejE4?=
 =?utf-8?B?dk9tVHBxZFAxZGRYMU9uYWt2MmxGVmJqQ042QkxYUGRwVWVaNDgxTUlMSk5n?=
 =?utf-8?B?ZEFEYzlha2NVZlBpNmtmRitjY25POUhYeFptYTBXWE9tZUNPSXpRazNjNzAr?=
 =?utf-8?B?SUxGbFRCQ2E2cmJsbFZPZTBqRnljT2F5WTV1SUZ6bXExU2tXZ1VMQll2bW9Z?=
 =?utf-8?B?SVhmV2k4MzAzRDNUcGY0QXV0djF1K0FxUkdTaGplUzlpenF2d1duTTF5UC9V?=
 =?utf-8?B?WnhDVlR3T1RicDROODVFeVc5dG91L05WT3hlbHZlSzRHakZaYW05RjdVZXBh?=
 =?utf-8?B?cXBiNUdiVE9wUVhXdkxvdzl6K0NaVWp6WGp5UE0rWmpHMGJOaE5FbUszNlhP?=
 =?utf-8?B?d2hwWE53WG9tSzZWSmdQam1pR3RrY1pmM2JZdDlLTVBYc05JNnhoUDZ1TGNK?=
 =?utf-8?B?YVowWVR2VGMzYVBjZHVXdTltN254MVduOE0vVEFENUdWTjR1UmZ2TU1iaVR1?=
 =?utf-8?B?Z3JVK3ZZUHQxSEpHYlUxOCtpMTFZRDZnbDRZd0hwdEJGUWNtbkdUK0UxRHB0?=
 =?utf-8?B?SGVzUTFIbEN2bFFiRkRqQTBRcldYLzd3ZWFiVWNBVEdlRGlkTTFMamw3WWhv?=
 =?utf-8?B?SUlmWXhsQjBObUtDd013blZ1NVpqT1hBSS9aaEkxaGFZNXUvUHk1VHZ6cWlu?=
 =?utf-8?B?TnFrMXZGNG9PYW1kUmFIQTBoUDl2dFpvdDd0T0dpQjNVMWFJLzJKb2xWMFEr?=
 =?utf-8?B?NEVmaEtubXRYWlhxVmdNRWY4QXdLdEpLN3F6MjZrU29Ed2UycXhyNDJUaTdF?=
 =?utf-8?B?bWZWb2tZRHEzQnFwL2tQVml2aENzOEV2MlFwdUZnOUMvVGpUeVFNeVl2VDZG?=
 =?utf-8?B?SUZOUExVTlB1RWVZcXAwWVRld2FuZlRDRHZqU25KOXVoTTlEc0JKQnBUU1FI?=
 =?utf-8?B?a0ZMdkFTUU9aSGVRWWlTYlNFYlB1dUFYVGV2anR6aERFK0U0eFplRDNvZWlC?=
 =?utf-8?B?c2FpdElEaEdZeXcrWUhwQ2Q4OHA5d3FPVGJMTy9hbEpBdXdlSFIzdFlnYW1y?=
 =?utf-8?B?U2VFMEhXQVVaeHA3NUdpcWlCak1ud3ZvMGNCNW1meFR1TVZ2bFdDVlFhZ0Fs?=
 =?utf-8?B?YTNtQldYZEoyTFdqZXdObW1kcTFtTkZ1SHFUY3NIREVEK1E5cTNUamQ1RUI1?=
 =?utf-8?B?WW1GRy9lMzU4ekQ5OERIUGYwRUNuendsMnhCRUVNdXR3ZlFSK3pZc2ZDNTBh?=
 =?utf-8?B?VXExWTcxbDRKd01oZmN4emFScTJveUNGbStTdmt0S29USkJnc3dvWmxYRmJh?=
 =?utf-8?B?SzhqUnluRUpIbm54dnZ0bVAzVXRCMkFmeG9xL2xuOUFwVktsWklwd2tzNE1B?=
 =?utf-8?B?MFNCSHU0ZUY4L0xxdDA1dEtVaG9OSEZZTlp5bklaZlFuM2F1ZGsxb05uMWlP?=
 =?utf-8?B?TTJEZFBKMGp5d0FjNHZiUlRVOXFSV2VPNkFidWdwRmowTHZ3dXQwNmRtRjVV?=
 =?utf-8?B?RnNhMWJrTG9ObDd4VUxTQlBTM0d5MERtck15Y2g3MWpJQUpXTjhiZnFvTHNX?=
 =?utf-8?B?OHE1OFV3bklFMGNrNUxvOWpnT2tsTzVrSlN5WUdJaFZCRGU0d3IzQ1hXM3Nh?=
 =?utf-8?B?OXIwUDc4Skt2a1VaWVdFTEwrV1JDVjI3VkllMWR5cU02aDJtbGt3NDlFN21N?=
 =?utf-8?B?MFpQQm5wbnJZaFhwdVU1MzBad1o5MFBtYXhCMis5THFRa1lPRVNkcW9TZGcz?=
 =?utf-8?B?d0psTWdBN2tQbVZhZTJDSkFOUkRiQXU0K2JVaytKWXBsUVdVK0dVM1AxemZI?=
 =?utf-8?B?SGRQNEU1WHRhbFZrREdWeFFGeE9YazdCSlZEWXFCS0FoYURtRHRKZDM5amMy?=
 =?utf-8?B?WG9zQnczdVhzN25JMEU5MEVnWExyOUYzN2ZyNEVwbm55WEVMNFk0YktxbnM4?=
 =?utf-8?B?VEhIZ2RkSmtyZ21TS2dIVE9SbVNGdkVtTmxCbXh2MHFUQjgyZE40Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd87cba-76b8-48ea-2f6e-08da21c2999f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 05:08:10.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvKnoXDyZvSSEXEf3iMKD9XN9H1h2RQozRarxE2JG/ZSwlFaY8vYB5w20BQi9uWoV+iePijss3FxIpXKN5I9Wx2tuo6hnqE7j6A8oPFrXhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7144
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RhbiwNCg0KSSB3YXMgd2FpdGluZyBmb3IgeW91ciBjb21tZW50cyBvbiBWZW51cyBjaGFu
Z2VzIGlmIGFueSwgc28gdGhhdCBJIGNhbiBhZGRyZXNzIGFsbCBjb21tZW50cyB0b2dldGhlciBp
biBuZXh0IHBhdGNoLg0KUG9zdGVkIGEgbmV3IHBhdGNoc2V0IHY1IG5vdywgcGxzIHJldmlldy4N
Cg0KVGhhbmtzLA0KRGlrc2hpdGEgQWdhcndhbA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogU3RhbmltaXIgVmFyYmFub3YgPHN0YW5pbWlyLnZhcmJhbm92QGxpbmFyby5vcmc+
IA0KU2VudDogVGh1cnNkYXksIEFwcmlsIDA3LCAyMDIyIDE6NTMgQU0NClRvOiBEaWtzaGl0YSBB
Z2Fyd2FsIChRVUlDKSA8cXVpY19kaWtzaGl0YUBxdWljaW5jLmNvbT47IGxpbnV4LW1lZGlhQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaHZlcmt1aWwtY2lz
Y29AeHM0YWxsLm5sDQpDYzogbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGV6ZXF1aWVs
QGNvbGxhYm9yYS5jb207IHN0YW5pbWlyLnZhcmJhbm92QGxpbmFyby5vcmc7IHF1aWNfdmdhcm9k
aWFAcXVpY2luYy5jb207IE1haGVzaHdhciBBamphIChRVUlDKSA8cXVpY19tYWpqYUBxdWljaW5j
LmNvbT47IHF1aWNfamRhcyA8cXVpY19qZGFzQHF1aWNpbmMuY29tPg0KU3ViamVjdDogUmU6IFtQ
QVRDSCB2NCAwLzJdIEludHJvZHVjZSBJbnRyYS1yZWZyZXNoIHR5cGUgY29udHJvbA0KDQpEaWtz
aGl0YSwNCg0KSSBjYW5ub3QgZmluZCBuZXcgdmVyc2lvbiBvZiB0aGlzIHBhdGNoc2V0IHdpdGgg
SGFuJ3MgY29tbWVudHMgYWRkcmVzc2VkPw0KDQpPbiAzLzE0LzIyIDEyOjA5LCBxdWljX2Rpa3No
aXRhQHF1aWNpbmMuY29tIHdyb3RlOg0KPiBGcm9tOiBEaWtzaGl0YSBBZ2Fyd2FsIDxxdWljX2Rp
a3NoaXRhQHF1aWNpbmMuY29tPg0KPiANCj4gSGksDQo+IA0KPiBUaGlzIHNlcmllcyBhZGQgYSBu
ZXcgaW50cmEtcmVmcmVzaCB0eXBlIGNvbnRyb2wgZm9yIGVuY29kZXJzLg0KPiB0aGlzIGNhbiBi
ZSB1c2VkIHRvIHNwZWNpZnkgd2hpY2ggaW50cmEgcmVmcmVzaCB0byBiZSBlbmFibGVkLCByYW5k
b20sIGN5Y2xpYyBvciBub25lLg0KPiANCj4gQ2hhbmdlIHNpbmNlIHYwOg0KPiAgRHJvcHBlZCBJ
TlRSQV9SRUZSRVNIX1RZUEVfTk9ORSBhcyBpdCB3YXMgbm90IG5lZWRlZC4NCj4gIEludHJhIHJl
ZnJlc2ggcGVyaW9kIHZhbHVlIGFzIHplcm8gd2lsbCBkaXNhYmxlIHRoZSBpbnRyYSAgcmVmcmVz
aC4NCj4gDQo+IENoYW5nZSBzaW5jZSB2MToNCj4gIFVwZGF0ZWQgdGhlIGNvbnRyb2wgbmFtZSBm
b3IgYmV0dGVyIHVuZGVzdGFuZGluZy4NCj4gIEFsc28gdXBkYXRlZCB0aGUgZG9jdW1lbnRhdGlv
biBhY2NvcmRpbmdseS4NCj4gDQo+IENoYW5nZSBzaW5jZSB2MjoNCj4gIFVwZGF0ZWQgdGhlIHZl
bnVzIGRyaXZlciBpbXBsZW1lbnRhdGlvbiBhcyB3ZWxsIHRvIHVzZSB0aGUgIGNvcnJlY3QgY29u
dHJvbCBuYW1lLiBNaXNzZWQgaW4gdjIuDQo+IA0KPiBDaGFuZ2Ugc2luY2UgdjM6DQo+ICBBZGRy
ZXNzZWQgY29tbWVudHMgZnJvbSBIYW5zIGluIHY0bDIgcGF0Y2guDQo+ICBFbmFibGVkIHRoZSBz
dXBwb3J0IGZvciBjeWNsaWMgaW50cmEgcmVmcmVzaCBpbiB2ZW51cyBkcml2ZXIuDQo+IA0KPiBU
aGFua3MsDQo+IERpa3NoaXRhDQo+IA0KPiBEaWtzaGl0YSBBZ2Fyd2FsICgyKToNCj4gICBtZWRp
YTogdjRsMi1jdHJsczogQWRkIGludHJhLXJlZnJlc2ggdHlwZSBjb250cm9sDQo+ICAgdmVudXM6
IHZlbmM6IEFkZCBzdXBwb3J0IGZvciBpbnRyYS1yZWZyZXNoIG1vZGUNCj4gDQo+ICAuLi4vdXNl
cnNwYWNlLWFwaS9tZWRpYS92NGwvZXh0LWN0cmxzLWNvZGVjLnJzdCAgICB8IDIyICsrKysrKysr
KysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9jb3Jl
LmggICAgICAgICAgIHwgIDEgKw0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVz
L3ZlbmMuYyAgICAgICAgICAgfCAgNiArKysrKy0NCj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
cWNvbS92ZW51cy92ZW5jX2N0cmxzLmMgICAgIHwgMTAgKysrKysrKysrKw0KPiAgZHJpdmVycy9t
ZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1kZWZzLmMgICAgICAgICAgfCAgOSArKysrKysrKysN
Cj4gIGluY2x1ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmggICAgICAgICAgICAgICAgIHwg
IDUgKysrKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCg0KLS0gDQpyZWdhcmRzLA0KU3Rhbg0K
