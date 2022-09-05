Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B75AD1C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiIELqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiIELqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:46:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B899127B28;
        Mon,  5 Sep 2022 04:46:49 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285AVGsg022560;
        Mon, 5 Sep 2022 07:46:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jc3u5vb3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 07:46:42 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 285BjZJh011558;
        Mon, 5 Sep 2022 07:46:42 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jc3u5vb39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 07:46:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksKPHfnFD9z98jQ0WQXjude5RfuuDyHj8P0PGwPlMaJeIub8Cf65OogEXWS6LjileFMPwEfkvRPUr5yVCzjYO+MjAupmSSHp/SERhAe9v5OZHvCvcroHEjys1Me+sBhpnV4nWu+v+oe5kTI6V7hg0Uz8cx1/1NulFlViHZQiNPcdurcAm07hdfSPK2DLe5YbF9kkWvZYSZkLui9GDmhjDhuuIgvlaZISLABvTwfn9jEHioKNNrLkQccrVZNjcnlqdwloK4xRpED6VtzWoeeRux8S3sHcvpOEmwnewXUF9sqVcEFbsXJCot+P5PIs+I5Xd3W9VauqryR0obETtaZt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxlB5A8tIE4PTTNliZdEi+vEK7cV+p3fkenjL4E9M1o=;
 b=R2YVkTS6+fFn8xNuS2uDjbyTtINyEAMnkknUEAcMK47XRwHWdQK6DvLADdkbOlU5toou40R50/LDL41kePS/eyW7y97XT3l5IN8F72lmEq94YLyOSV3D9vAFpSZQnQnJqcTwoBnoPn3bTpwcX0aNPX/469acrM9ZeE2kezWWjtqj9SVmJzVabsnRYfnNGqJbNNTGPeW4IVxj7oM7vshy/e6XmkBYvf/z2j63pSOOxlEl2KYMVRB/E5sQ3vCaoAcVLBCSXuoKVMDsoCqJHPzT8g/dZA91M6OkNgHV9SSQXvF2GY8+dme8lMENf0lWPLoAbmXBVdr1bVBMKtV8Mz9tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxlB5A8tIE4PTTNliZdEi+vEK7cV+p3fkenjL4E9M1o=;
 b=eaJkaomPhpaGDs9z0n5yIGdu1fcNj2QskLxbaTqyfmNJ3e+vxEZCL+0ogVuYlq1tI6jrDJQK2JraB9ycyOl992aBggEZFX+X1AzsiJ19esue0VgYo/wNrlpptljWqdWTcXXLSBj5tdRG7HuqXZG9B5Z/x+oe90O3jLkdc36sBOo=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by MW4PR03MB6946.namprd03.prod.outlook.com (2603:10b6:303:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Mon, 5 Sep
 2022 11:46:39 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::6175:a08d:5a98:10ed]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::6175:a08d:5a98:10ed%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 11:46:39 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 2/2] power: supply: adp5061: show unknown
 capacity_level as text
Thread-Topic: [PATCH -next 2/2] power: supply: adp5061: show unknown
 capacity_level as text
Thread-Index: AQHYueStfBHlGfFUpUyE3WkSK9kY6q3QxnuQ
Date:   Mon, 5 Sep 2022 11:46:39 +0000
Message-ID: <SJ0PR03MB6253C3BC80B6B55792409B938E7F9@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220827073224.713803-1-weiyongjun1@huawei.com>
 <20220827073224.713803-3-weiyongjun1@huawei.com>
In-Reply-To: <20220827073224.713803-3-weiyongjun1@huawei.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy02NWQ0YjA1YS0yZDEwLTExZWQtYjZiYi1iY2Yx?=
 =?us-ascii?Q?NzFjNDc2MTlcYW1lLXRlc3RcNjVkNGIwNWMtMmQxMC0xMWVkLWI2YmItYmNm?=
 =?us-ascii?Q?MTcxYzQ3NjE5Ym9keS50eHQiIHN6PSIxNDY5IiB0PSIxMzMwNjg1MTk5Nzk2?=
 =?us-ascii?Q?MTg4NzkiIGg9IjY4NHJnRjI3MkRhR3NTL0lkRmN4Wk9tb2s2VT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QS9FaXdvSGNIWUFRNWozTndyNlMzNURtUGMzQ3ZwTGZrREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWDVsMkt3QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e0376ad-508b-4d90-0996-08da8f344ba8
x-ms-traffictypediagnostic: MW4PR03MB6946:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8bR5sOAXiKi+hZXOuVV5fpngrOTTOgmcPPrlPgENYwC7VS5lklQyK/kLccmOiYj4voPJNzUxzWxBSFSaniHOgpZzYBKpuMN/HtUDj3uPQodhZC1g+zj/3YLWll3fjBNP2jS3jUvgPaKsEXEgAZrbKLmuXvk8ofRQV5zOAAegLGocTID4hoEv0SA2YtaQhn5OC3ndupfWkCJNgmT+Di1sLZTG0CLlI6n+DQ3aWCO7d9oznGXP/h+4LvRYY4JOUS0dApM6clFFo4P0X88pjK5AmemuLECDdUKBX5+/C2Fxu2mhsBb8wEXAQAaUS+xAde0NkVCpfqtU2ZbERg9R9fSSOTh9s8Cg4VthjITnnJHvOI5haxRPiVLXonPCdKb1C0UZVGjzMVFjZwZp/3b8TIJqnYQVk3oyzDEgcEdxLn6MaW/AQYry7cPiYf0VPk9OM+klqZrL1157T4EJaL1KGEZ/F8mdTUr8EvOrR+oG0pIU6FO+WpGu/D1NyPkyD6b+AdVh2BruW4121UpuXbedRkC/2JscwVIgryOAa2123kQXeU3Z9c7TaH2fBfMHhEhjcTCE8raVAL6gPSLemyEGN7MX8mCRHxLgJ40I/vT3IyvDvgTLLe2BpfZcBqdEchZzQt322tcyvvSIrjjOdMaY60XuFW0Ia/GOYI2wiVli+TkmCtfEtbY998LNhyTcDeP0jRejjwhwYN+QWP/GuP8Py5QU7rawezECg2N/Sg137ua5EtYUIh3a5Mha4jGeFj1S0x356D73h/9azCu1DS0E4WyHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(316002)(54906003)(4326008)(71200400001)(66476007)(9686003)(66446008)(38100700002)(66946007)(7696005)(5660300002)(64756008)(26005)(8676002)(66556008)(6506007)(76116006)(122000001)(53546011)(55016003)(110136005)(2906002)(38070700005)(33656002)(478600001)(41300700001)(186003)(86362001)(8936002)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QzXnKldBlSQ9ZkuX9nvWCFJZeNT48dBtpzB9H8Imf8QpHqf4bsnevCqMzmSY?=
 =?us-ascii?Q?ha2DS8FVVgRNYESViciyGv0NMyYUrQtXlgW7C5Ub07EWb98XA4UrOZprd0qT?=
 =?us-ascii?Q?LqRJisZ33OH/lvpi4r4eBJguadfk3/ctzcwywiZoD4SaH5Xf24cyW84pHpQK?=
 =?us-ascii?Q?qLfG0hj43MM3ZHWUel3GolvSlKMnf2FOIeDzeqYeW1YFV++f5V5dB0JXEWuz?=
 =?us-ascii?Q?BdRItMXjf2Ac3b6fjL1Xu1cit1FAwQthJGe/lCqIjK7Y7a8XgliXXeLEr3qd?=
 =?us-ascii?Q?NLk0GrLZtSGxnlJoYM7ZdrvrBTlD4XhE9kqbRQ3KaRwt8ryCIHWuTDrAN4Kr?=
 =?us-ascii?Q?wU7ThIHcYQIGo9a11AiITUJqB6MGzBrgJi2wm9Yfl2PpNP4166hfbHixaNui?=
 =?us-ascii?Q?hnl1L/SWM/P/92wkutT15aCOzH2j+nLtS08NByGd4kxRFdGdnXa/8DeGrRl5?=
 =?us-ascii?Q?2hKOeRA+YyOT+if3MENkjS3EFuGjp4JM3FVYWIZrZywwfLRqLyIH6z7hSMWg?=
 =?us-ascii?Q?n7GQr59tPOiNmKJQWAjiLkRVJpaNPLnHUvMKnEJhECeHd8pCft5bRJwC+Zbj?=
 =?us-ascii?Q?stN9ytYO19ltAl25pV7IQvMyHvhtTw/nmeeZCfLrpnGqKSCUKsOhR+2mog6T?=
 =?us-ascii?Q?lq/Z1KeS+42DiWXeNTKXuYunK4A5N1/pOfxDmWtWQAksiQydRoKBKA2ASos+?=
 =?us-ascii?Q?ZQHrCNhILHMuv/EdMR2aL0zDYuFGVuVlntHvw10irYUZs/FV0EzUKVm10Giq?=
 =?us-ascii?Q?I9aJBM4A4VR4y2Vt0aFyK4B1ZW9uK25K/j7Rr9yXUCF+Urr5PdKgDfG9USHm?=
 =?us-ascii?Q?XhInkv143Gq5WEtvwQ6EPKYkuzoWhIDHKJ1mKrOppsVZyVdNE4vJ/volsIkZ?=
 =?us-ascii?Q?eCFNJuOB4wEGoffX5PrtW75MYfig3lwuTzq8OoTn/oVs9AVbYTF23/WNDTfo?=
 =?us-ascii?Q?kYLdWKIGICQ2iWzgIzALNu/2vTHhvRnKKDjkuM/knr6ohmbwUwmduFuIJv1Q?=
 =?us-ascii?Q?vazZ5gRKtVCa3bJSYn8XTQJe3jDx7rm1te1dXyDQhClZRTvdw5tm14CjB7iS?=
 =?us-ascii?Q?6uU3yAEWBHi2gON9kryWu9YnOH686dyjrVgxoRXe4tyYJ10ticGkNB8Vr1f7?=
 =?us-ascii?Q?2hAZkO9sbfUCqgodvKQ406mnvUoi6epOKTp6IxJ4rrvzVkL9ORFTc6m/HWwb?=
 =?us-ascii?Q?lk/LULL6VgqDtDZRSTjjgOUDjYxTUvpHwRdv2sAfTkR5EqK+MF02o8HJgfZ/?=
 =?us-ascii?Q?VfjqrKCovpp7xhN/VdXgn/RZN8VnzLCA73viuaJQW0Rl7KwyTAeBHCNBsFRr?=
 =?us-ascii?Q?HDhAZYaCbv4HEsGrj3svzspzfwJcoD46wLqkmp40ln+Nl1bGfZXRve0hvftr?=
 =?us-ascii?Q?HW73jAWeYj50dZrD0lbT/+6PDO2/mkehVM0TrZZpdk/kTmZ5nHg6LmS+lbC1?=
 =?us-ascii?Q?2/C1P5F+1u8vrxUX13z3dV7sbn1Hl9zLCUWMCOSSeilNICyDQC/Mlv21QRUq?=
 =?us-ascii?Q?3ix2j614LF2tPDdnXQBWws2zIbsFAMuYQUtdcko2D794do2aiixP4BMFtcU0?=
 =?us-ascii?Q?QtuAPHovKSVM01S4mhkAgSYpgzVkmmyAWvO0tD9Kc9hAe0PD7PHJYpymynlr?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0376ad-508b-4d90-0996-08da8f344ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 11:46:39.6409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUgZIJ1XI6WM7ZOny/V7V1CkYBCxDc10eqf78BQvrMwjJCdxqlO3rp7HbWIwX0zEdxZ3EmuukoRb3fZSyOchZSGLFq81vGZksRSCMqgAMRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6946
X-Proofpoint-GUID: ZFjWR2Qd_1rdfmoLmzG2aTRjAodncCxj
X-Proofpoint-ORIG-GUID: IBeF85XOh1gi446o3Sxlm9p8K3Oori_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_08,2022-09-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050057
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wei Yongjun <weiyongjun1@huawei.com>
> Sent: Samstag, 27. August 2022 09:32
> To: Hennerich, Michael <Michael.Hennerich@analog.com>; Sebastian
> Reichel <sre@kernel.org>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-pm@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH -next 2/2] power: supply: adp5061: show unknown
> capacity_level as text
>=20
>=20
> adp5061_get_battery_status() only defined show chg_status <=3D 4, others =
will
> be show as '-1731902199' from /sys/class/power_supply/xx/capacity_level.
> switch to show them as 'Unknown'.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/power/supply/adp5061.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/supply/adp5061.c
> b/drivers/power/supply/adp5061.c index daee1161c305..fcf8ff0bc974
> 100644
> --- a/drivers/power/supply/adp5061.c
> +++ b/drivers/power/supply/adp5061.c
> @@ -493,6 +493,9 @@ static int adp5061_get_battery_status(struct
> adp5061_state *st,
>  	case 0x4: /* VBAT_SNS > VWEAK */
>  		val->intval =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>  		break;
> +	default:
> +		val->intval =3D POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
> +		break;
>  	}
>=20
>  	return ret;
> --
> 2.34.1

