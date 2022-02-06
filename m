Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D922F4AAF70
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiBFNWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiBFNW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:22:28 -0500
X-Greylist: delayed 1859 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 05:22:27 PST
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8587C043182;
        Sun,  6 Feb 2022 05:22:27 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 216CUTfQ004702;
        Sun, 6 Feb 2022 07:51:05 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3e1prahv7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 07:51:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lxyp7UM6D6PzzqPsQC9sQo+fV5PkBOocrZn//HhWQCixA2ZROP2f/LOSyr9eFGjR+4RnQFojU9wbbm5Wst9tpPkvu8ZdrSBxtiZmk/H2sW0tZqT1VY1Rs0G7egQ5Zl/VEj65scAKVAHpZk5ytjx5yHLeOCNdDc1i8TWia1nITBz6vyq3dToArK0zEdoidDlLJySfYVNtLJ9ESrwCCP44MaH0MzPmE2m7lo/ZSpFgVPWuPcK2o56IOercr5Siwaf80tsSHClbwrzsNmXmuVGCDByQTN2X8bxhI7tP38upwMaM3QNdxMmmcG4V3Glc1nOrgyk9p4K931fp7iN+yfGtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlleXgQSmR8jBzGBrSQremahWp1pDQ1E5usaSF2RQc8=;
 b=llliEzRY5HLQkgDSVGz0630UF5gFkwnKcOpsEkwRu7wEJJSepM1OOcQKkCbmM9tVyc8PVGWwJEnP+0rCVMIRXUqrjAeVtISBbm8EfYqCNXkJC9Hy3uGGnbgexpb3PrChn1XGlulefFR3+53QEGuSEdaW1XZUCW0adrGwBV7j7J9JWEKxi8WXVKfDbBABJxHE3M7addb56GWnCt9SrHSvTtYr/fdYtahZDQQc5sqQ++G13+77YaqwZLajgGRUmTKjF/7LsXu9YxNO6NKHIr0UfT2b99sLua34rl6zMxeDcVvM0tZFiyHdKFK/pSl3nTw0HEmFbYnnKG8tYCoXfmgxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlleXgQSmR8jBzGBrSQremahWp1pDQ1E5usaSF2RQc8=;
 b=yv2k2Binz7WdM2lZyIoegtbZSOJP96OtnXImvd8T++CEc+lR2zzCqFounaxHhYgy29X+z4om4WgwjFwqOaUehIryj69SimNBVbJ49vg2NjZVtlE1ITrmS8zh5Fw+yKGk+XlAANlDv9Ifgr3r2lfrYC2A80rCnxMvGlR0T+UY5pA=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MW4PR03MB6508.namprd03.prod.outlook.com (2603:10b6:303:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 12:51:02 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%6]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 12:51:01 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of device
 properties
Thread-Topic: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of device
 properties
Thread-Index: AQHYGPN7UgnVJVVaykahp8u/ZY/uwayFNeEAgAATOoCAATK/UA==
Date:   Sun, 6 Feb 2022 12:51:00 +0000
Message-ID: <PH0PR03MB6786C5F8E528249EBA938070992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
 <20220203114506.53904-2-andriy.shevchenko@linux.intel.com>
 <20220205171454.49a7225c@jic23-huawei> <Yf7ArwPrN34drkcv@smile.fi.intel.com>
In-Reply-To: <Yf7ArwPrN34drkcv@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNzA2N2U4ZTMtODc0Yi0xMWVjLThiYzAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDcwNjdlOGU1LTg3NGItMTFlYy04YmMwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNDMyNyIgdD0iMTMyODg2MjU0Nj?=
 =?iso-8859-1?Q?I5OTUzOTU2IiBoPSJxcWFsazVwR1BtWnhBVHhkZDh5NHJBSHM3R2M9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNrSWNBeVdCdllBWWhvbnJadmtnTHRpR2lldG0rU0F1MERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23c0a46c-5d62-4e92-1e41-08d9e96f5439
x-ms-traffictypediagnostic: MW4PR03MB6508:EE_
x-microsoft-antispam-prvs: <MW4PR03MB6508D4A465719C1C705DB6A5992B9@MW4PR03MB6508.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HaVRZUwP73dWIxVvMnadAWSh/ARRd1qP9q97sLHXP6CkJ7RwLWiaI+wPsqDVKFHRvbYP/U6Yq2xoM4lOjGZKaKFD0V9XE68Y8gG8tJZZyVN1uQU7EjQW5tR3TNmAT+pPQiu0R+GHkOmjmHA4adrCXiZKgfqBzwhOygmcWa6D2A8kr4STzBCJrob+Kcea9h+6fPxOEEGvRD0r/O4DRB4yxfKfXPPKa1vXWJ2BbGIGxJvta24fvXirObwp4SwnZCEwr5aAeDv6dw756BiIDEA+n5CHUAEF+DTfkqpob7yMiaQ2mH2ZjzIizUO2yB1S7eEzS47VcxJ++d34N7H7/tUBVnXbj9LZOvtZU7PJBfJGaKm1wYo9HfizUfFiTfBzHfeLja8XvH8MdWcZsrN4qqzFlZckX6szLz3Lj9jHnncg0nIdF+A0vh4oHxqfBLuqTtBMD5KuNmcODc/I4P4agdOzLKJRCc0vG1L4iigWgb0BYfYJXPazC3Bd50FCBSy0T0TYeh6QpDjtpM+/zLRecc9TorvEPi/Ydcy02I/NKJejjDnL9T6O4czF9FBx1zzcX8ZzZ6pwtceqzOI1H3T0WlD1JPxD1fITis0Xe7p3Qsv50rqQzh8YcDWgEOduZUOurCOI02nicT9/Tew/Jr5lTpSVC8wHv7AAypXoPKN6LhgUTw+7Q/+fYDHbwYcjXT3XT/ZIyQ/QjcSdPZAoTBp9+E1B8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(4326008)(55016003)(54906003)(186003)(110136005)(5660300002)(71200400001)(9686003)(83380400001)(52536014)(2906002)(66446008)(64756008)(33656002)(66946007)(66556008)(66476007)(38100700002)(8936002)(8676002)(76116006)(508600001)(316002)(6506007)(7696005)(86362001)(53546011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fWtHoDFaZt/UtY7PERuXB6dFEY3D+ukJ+bH64ST70rS5Ho/nqr6bnmpM8z?=
 =?iso-8859-1?Q?i+gn/bjm09NnHiNXhUdD5vQUKvTOdOQHvlyvK+NXs1k4jYSnpSUw27jMdR?=
 =?iso-8859-1?Q?D017S+CBJhOBSEN9rmm1aNiUrXULcyVl5lpLdafxlhXSvyTt1WJawHcC+2?=
 =?iso-8859-1?Q?mcTqatLJqcxGU9HOnzfDLsgn+bNDPNzoCnwVtKS67K51tnXsPryKYpNaTf?=
 =?iso-8859-1?Q?2OZTYqdFVJGiyw+QJmCG188EUWFGoSqElXQk2G1Lkb2KRXGGmtuj/nZhJn?=
 =?iso-8859-1?Q?HskOMkBc0w9p/gmkgKwESvZMoPlf8ajJVaT5UQdtur4dttjL7XrtVBHjX3?=
 =?iso-8859-1?Q?ExV48EmU9YxpBcJFhFR5wUslavAIDeJzpYsgL2wY0F5nFmon9UQ6qtcRRk?=
 =?iso-8859-1?Q?4NEaa1XY9CJy7irucg7IzWMJGkx2zcASjj98WuQCngizZoVnwor1cstZS2?=
 =?iso-8859-1?Q?P6xlHHA9VmZivcQFfE2z+3LK1BXmpJFhLveJcMADONBB246LiluY0Gvedf?=
 =?iso-8859-1?Q?6OENzsRaIbDBcJ/ZLmGPzVpPW+0039WoPVTs2UHPUDnqvc5xw6pUKeJgB8?=
 =?iso-8859-1?Q?+V97jSxQvg8ileuMBiX0KiTU4mPuVnkrVmbsb2bhdrmENhwzTCtcFa/qRD?=
 =?iso-8859-1?Q?2UpYOqunxBR8NF4won0KCegNnt9Sl7lLxp7g6UW+SDXIxpws4rglqu/KVx?=
 =?iso-8859-1?Q?gOjiRmxjpnvcDhpX8y5LtwVtKHReaeU3601NoVgCjNveFAziHKo+QDL4Q5?=
 =?iso-8859-1?Q?KqZTDqbxdHIE2tjMKIO8Z+IVXFXKHuI856vVM4ppmBdKuDMSn1J7/yut/p?=
 =?iso-8859-1?Q?gi2olohalx3kXZpBb9ZwssOu4vQOS8ctc4pBwQXMYUke5oPpWsSlEUOLJb?=
 =?iso-8859-1?Q?PvaZ5lKJIrr1bfbLkfGzts5Nt6r5sCEJhnd1iPeJN5C1CcTU9EtmFYA02v?=
 =?iso-8859-1?Q?BpTKjoDD1KF4HciaaXsvjk+bJJO4avOPABSvwUF1CvzblGDTL5tscVWJK5?=
 =?iso-8859-1?Q?D18/eXeceWIjb12JX4nBPVkgo18q0qz9V9psrnGnvgKG7aNyDTk5xQFfa/?=
 =?iso-8859-1?Q?nI6hUWIiP1WsLAj+EHgPmS+bJdrzcknRzroqK4O4rf1dMi8aTfWuO3uXdR?=
 =?iso-8859-1?Q?NBhnUYl+/4fgb8GIKKq1ig0YYu/EmPWXk9iN34/6oVQmSW37tX7aqp35f6?=
 =?iso-8859-1?Q?Rn64eUbe8vpUbmiYa4TWUIeg6c3ZJ+h4CzsJu6S1lvr/AzCx3f7Uo/7pxr?=
 =?iso-8859-1?Q?I/DSx7TjjkX9puVy4kIhFkcmtCOqtQJUtJ6JVpHK5TycJ23m3iXYGuJ70j?=
 =?iso-8859-1?Q?OshsTUEO/i2I2zyVYga51J/IJqBjs/wIvlJTkaDBNiXI7uLTMY9NIFD9uc?=
 =?iso-8859-1?Q?kS/b4dWAtMCWPaKivp76pze18rtlV0WNGoLqCi8atE5M05FRUxUpP1zBlB?=
 =?iso-8859-1?Q?TiNEAnDu7uq8f1fyGWgAc5f76mTTdpWVJONd/aZFJWouCqt15cYGycUuu0?=
 =?iso-8859-1?Q?uPnfAix96NO7sRhB0rmDFeZ1O3cbUpExOiErxw0poO1ycQWjlwQpJtw4WN?=
 =?iso-8859-1?Q?a0vCKwrF5AwCet8ecJr7BtBzwn8lqv02tCVzaW0Iak5Poq6tLSmTSE9URO?=
 =?iso-8859-1?Q?PxQin1BJZ1SiqSc1mpBXZ+JQ3hsFP3y24rkzPlfB8GBm1tLlr6Ul/9Bj2H?=
 =?iso-8859-1?Q?dEuU3QKSBoVBUYzyS95UHnYnIZwxtCU4GXvZ3evK5oCWk/quB0yv40yG0x?=
 =?iso-8859-1?Q?CxCw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0a46c-5d62-4e92-1e41-08d9e96f5439
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 12:51:00.9870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T48HqCXuSPvMJnbDQ3aBvJ8Otj+D3o+7Z+66kC/bv5qUfySnikgiIc34dp9dAAUCDa12ovsZpkMuT3IZXj5JoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6508
X-Proofpoint-GUID: 2As4rr35qd_HqYjcrTZjHNTBVFw3IJUH
X-Proofpoint-ORIG-GUID: 2As4rr35qd_HqYjcrTZjHNTBVFw3IJUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202060096
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Saturday, February 5, 2022 7:24 PM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Sa, Nuno
> <Nuno.Sa@analog.com>; Lars-Peter Clausen <lars@metafoo.de>
> Subject: Re: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of
> device properties
>=20
> [External]
>=20
> On Sat, Feb 05, 2022 at 05:14:54PM +0000, Jonathan Cameron wrote:
> > On Thu,  3 Feb 2022 13:45:06 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.
> >
> > This description needs expansion as it's not a straight forward
> > conversion.
> >
> > Also, complex enough that I definitely want more eyes and
> preferably
> > some testing.
>=20
> That's fair. I also spent most of the time on this change in comparison
> to the
> whole bundle.
>=20
> ...
>=20
> > > +#include <asm/byteorder.h>
> > > +#include <asm/unaligned.h>
>=20
> > This may well be a valid addition but it's not called out in the patch
> > description.
>=20
> This is a side effect of the change. Below I will try to explain, tell me=
 if
> that is what you want to be added to the commit message (feel free to
> correct
> my English).
>=20
> The conversion slightly changes the logic behind property reading for
> the
> configuration values. Original code allocates just as much memory as
> needed.
> Then for each separate 32- or 64-bit value it reads it from the property
> and converts to a raw one which will be fed to the sensor. In the new
> code
> we allocated the amount of memory needed to retrieve all values at
> once from
> the property and then convert them as required.

Yeah, I understood what you are doing... We allocate some extra bytes so
that we can simplify a lot the logic to get, convert and put back the prope=
rties
in the table... And since we are only writing the __real__ table size into =
the device
I'm fairly positive this works. However, I do agree with Jonathan and I wou=
ld
be more confident to give this a test before being applied...

That said, I'm off till the end of the month (just doing minor stuff like r=
eplying
to emails :)), so if we can hold this one, I will test it first thing I'm b=
ack in the
office.


> ...
>=20
> > >  	if (st->custom_table_size + new_custom->size >
> > > -	    (LTC2983_CUST_SENS_TBL_END_REG -
> > > -	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> > > +	    (LTC2983_CUST_SENS_TBL_END_REG -
> LTC2983_CUST_SENS_TBL_START_REG) + 1) {
> >
> > Shouldn't really be in this patch. Or at very least call out that there=
 is
> > whitespace cleanup in the patch description.
>=20
> Good catch! It's a leftover, one case became a patch 1 in this series.
>=20
> ...
>=20
> > > +	if (is_steinhart)
> > > +		ret =3D fwnode_property_read_u32_array(fn,
> propname, new_custom->table, n_entries);
> > > +	else
> > > +		ret =3D fwnode_property_read_u64_array(fn,
> propname, new_custom->table, n_entries);
> > > +	if (ret < 0)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	/*
> > > +	 * Steinhart sensors are configured with raw values in the
> device tree.
> > > +	 * For the other sensors we must convert the value to raw. The
> odd
> > > +	 * index's correspond to temperatures and always have 1/1024
> of
> > > +	 * resolution. Temperatures also come in Kelvin, so signed
> values is
> > > +	 * not possible.
> > > +	 */
> > > +	if (is_steinhart) {
> >
> > Perhaps would be cleaner to combine this if else with the one above
> at the cost
> > of duplicating the if (ret < 0) check.
>=20
> OK, I'm fine with either approach.
>=20
> > > +		cpu_to_be32_array(new_custom->table,
> new_custom->table, n_entries);
> >
> > I completely failed to register the hand coded big endian conversion.
> Nice
> > tidy up.  However, definitely something to call out in the patch
> description.

The hand coded big endian was done to not have to make a distinction betwee=
n
3 and 4 bytes properties. With these changes it does not make sense anymore
to have it...

- Nuno S=E1
