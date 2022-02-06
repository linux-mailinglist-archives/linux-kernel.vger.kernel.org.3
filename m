Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C104AAF75
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbiBFNaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiBFNai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:30:38 -0500
X-Greylist: delayed 2273 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 05:30:38 PST
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE46C06173B;
        Sun,  6 Feb 2022 05:30:37 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 216BUr7D003717;
        Sun, 6 Feb 2022 07:52:24 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e1q19a0rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 07:52:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5FO3EVynhLdw72Gukl9NxUvkxczlUcEwOfIG2gBkX1HUdObuhQrT023iePw930+I5gRb8zrkMcAoafB97fxTU/XHuuQRArMe76EmO9tZ6IeRYgz69hMFGaLVjScvn/q2ae5mTV8shNOXcN1emCdq4BuwhSrG7uO4mM2rbfA6pbT6qh7PKV1HPEx4A3jy8PE9GdhdEJeQ9Cs/Nn+HQYAVp/zf36wNUYMh3cY9Qn+TkOnRcO823qcYEmI6LeGvZ4xmc2FjDY4N+lr4NyO9rKkywEq/HXeyAGG7kiEQp/ggOZmTPZa8bhPmSdjyQ7tQp1kFdtW5LOB2UCzGy/kE/EyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV7HgUJ7rHixjJROBUQ4YVwJEO70eMoUYR6WU12IcVs=;
 b=Z1zFs6PDq1C8Q6EN5PB63VVuszZxiMYLBYbPv+0EExrWgWYXoRG/sPQl1ISnCIQOkaOigbp25NN4YBCUmuvlXHujqPTyy+aQyzII6z/BErOL15+gxpU9C45kfdsSnIdjM0w44JAewIwqFH7B9r2OT50j8d//9zNccLlO7iCkAHPvGUeUpnP+NXtMNufSef85IHSasx/pubcseMZsy6tWkiD2dczRkS/34Ep8kJPuVm1JWpLNyKBdIaenz+pX9bm8X0xat9suHAqqIkwNggyfkaHoxf+3pKZpziLCivVtuuWtmkfg13mDjFOc2m3mHbHns2iEyGt/HVJ35XlSJtOWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV7HgUJ7rHixjJROBUQ4YVwJEO70eMoUYR6WU12IcVs=;
 b=h3DBCu8HZsHmFQ6FD4LhN+wCHr9QLoCZSfpPG5ji6hoV+YlqbdyeAsdcn2tXpw9JJU61+CxmsUfPKga2wNcrhuq+FTuqdDQThQd8+CDw90AOZGCi9vec1Bdmjw9vDAKeBkPfs8FT/ipYthM7frD5E1ceoBiTz0V7FYRqc7MzL0E=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MW4PR03MB6508.namprd03.prod.outlook.com (2603:10b6:303:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 12:52:22 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%6]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 12:52:22 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v1 1/2] iio: temperature: ltc2983: Don't hard code defined
 constants in messages
Thread-Topic: [PATCH v1 1/2] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Thread-Index: AQHYGPN5tzIo4T6wjEuYSYqutHr70KyGfrbg
Date:   Sun, 6 Feb 2022 12:52:22 +0000
Message-ID: <PH0PR03MB6786C178DF087745C67726C0992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYTFjYzU5ZGEtODc0Yi0xMWVjLThiYzAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGExY2M1OWRjLTg3NGItMTFlYy04YmMwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iODgwIiB0PSIxMzI4ODYyNTU0NT?=
 =?iso-8859-1?Q?g2MjAzNTYiIGg9Im1WZTZKYTZDc1ppQWtueUZiQjR2VVQ5Q2xWcz0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBREVreVJrV0J2WUFkaTA0a0JhREY1cDJMVGlRRm9NWG1rREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abef0326-281e-4320-04ff-08d9e96f8484
x-ms-traffictypediagnostic: MW4PR03MB6508:EE_
x-microsoft-antispam-prvs: <MW4PR03MB65089F47DFE6D18E3A21123F992B9@MW4PR03MB6508.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9EjOjJJq8bs5Fc75BUAA59djCTcVnrmYezwdTN68OfJcNLSCkIURFP5KChs6CWCHFaDxS1j6XnfWTo35+Pvr0GBXKVhJWRcyFr2d1l5QcYjJNQ3wzBJvJ+IqAoXr6YdAcM089mN2yeT8p66wjzmG0qM+l4fHMhUR/Ndk/LU1y70jmjjNeI9sDOQRZ6Mnf65IiwleF5Cn2nQV7Ba61wGgc+bUgStH4k8gvBMhUyk7C+LYqYrH5GgtSxmwd/9NlP/UQV034DoSqhiEUxZx/Rug6UWAaprSeqeHlFWWX3STEVr5MzshnCo03t94gcr+ek7fBWywcva4rQ6G6SJQU7EmVjHEGGA1o0IN1Wh+1ScJD/6DklLIfn77tvBow5f0dniXF89VhfIbjBPLkde5KRNM7KHAhJm2crGVIA2j5kq5CPpv9y8iSZ0kGPToy/DEgi62MID+K/gmXxfcMNqCfgUChgzjWIQdTiDVX7b2x7emOnr9HiaV9Gp36orz5PnfpsAbPP/ulsjZN7YtHiJRlWdXEsqiqITb1tkTV+hudPor/oxv2zOMSaI9NlFoQUZ090Qxwm4JxUD6/TXBjS/Gh+rDmZ2DG/1ZOncmw8Zj3dDa2SU11g7hy8uYTx3fI50awpiYBAZRP0gh76JrAhgF72FWUfIdDEYoOpW4zssiJyIt16pQewgelX5oZEJk0YOqtswYlUQY44pfrEztnU2O+KSEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(4326008)(55016003)(54906003)(186003)(110136005)(5660300002)(71200400001)(9686003)(83380400001)(52536014)(2906002)(66446008)(64756008)(33656002)(66946007)(66556008)(66476007)(38100700002)(15650500001)(8936002)(8676002)(76116006)(508600001)(4744005)(316002)(6506007)(7696005)(86362001)(53546011)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DA1FatqMTUImLQtY7kXUTmlSYRFMzGteFWLfrfveMqLYvSpm22+Nd4rAZr?=
 =?iso-8859-1?Q?S7wff2+ZLcm4jvXqkYZgEiUHgi05Pi7zkZ0U7qkXwMEnz4uo6j9AJQFz3r?=
 =?iso-8859-1?Q?i9vhMNw4h7KeTvopZXFI00sHR9kxbzHUUkL6pOeWzWu8gC8pA0S62HLU5R?=
 =?iso-8859-1?Q?54poq+SsOXSSqldK56v/N0uitqUBTaVQa62DoxauJElavu1INlp5xF6L3k?=
 =?iso-8859-1?Q?Mbqoj6KJct0oaKgrsUcEa13aU9wDAHw05bxRHFa8EvE5baTwDogpMpPZhV?=
 =?iso-8859-1?Q?bJeByUMPxFrrqBbu2qrfSEw2YGFQwuehy6ZvuQp/4yugjUKIicJaeZym0U?=
 =?iso-8859-1?Q?rswu+bm0me8x0WvNeUnTlGW2g0uWT6IewZ59OtSr+AdGTb2Go217gQ2Q2x?=
 =?iso-8859-1?Q?2ip8fkgg43D30L9d6TKixAXU1nkcjd7RjIHiCuoSPnuFdwGS9pUljs56EC?=
 =?iso-8859-1?Q?tOHh+0vAKvRbcRiJjxfkhhBa49uiPSbOtFK/Q2WbpmIn//EigmrTQreDwP?=
 =?iso-8859-1?Q?xMa6n5shy7U6XOlkZvu+7qBIMxN4ZtftFA+qcRow84EvUaPnbeMf5F2lQ3?=
 =?iso-8859-1?Q?9A/bH/Nds4v1FdRxucBo1j9q4m2wP3ue/G5StCYvNYk1W+JnslzOLJUHl8?=
 =?iso-8859-1?Q?Mnd7tDG5raobup3alrvLyke6CwTmlfjBfaDZs09alKxsJekqooTxqH6OTH?=
 =?iso-8859-1?Q?VQBWBVd78/Uuo9U2VV5KDfNA7TV1k7CMCDaf6Uy8xDv2V0cnokwaEUAi4X?=
 =?iso-8859-1?Q?ERBV/5vPt1U+ThgEi4GKmQqGpJGfTMXBgb5Je1prF1oTE/SXbxalsoefWu?=
 =?iso-8859-1?Q?o+SPp1JGE2JvhbZ0xczFOCWGCzKNZ0Yg3mCIWKPRl1WgwhwP8EP1+zFVAP?=
 =?iso-8859-1?Q?djJw+V7cHM9Sg046UK5YgG3mp1/Sik848kO5j5C34Wmnf1mW1IJlFl5FAb?=
 =?iso-8859-1?Q?BKbQwVC+F09GmeprIdm7u6ipB5kf5NFqBGTOR6Su4e2YWj+15TQaIDMv4Y?=
 =?iso-8859-1?Q?IAKTvAbRG3NEZV4oFu3eGmLQHTjb3SqAIOcdoIXcrduY21Q/5Uw8PTgGEH?=
 =?iso-8859-1?Q?FavMuiYZh5wgz7YozzAe85RZpHhLEzTzevcHuH7HES8JNp2WzBdt8NT3D9?=
 =?iso-8859-1?Q?AcJa/TJi85InpLsC+yPjxjwGYRhru5pLLLX4iermw29awWnD62LtFjnOPV?=
 =?iso-8859-1?Q?RdDzWKGIaht3YSkeA1BJvx4D1wvtwqAb36genMOf5evoagXgVgrD/JQiG6?=
 =?iso-8859-1?Q?Os9iP8m1zE+DTWnEGqvHA2mo+O0FpUw8/hQ7eC/D0VxuDqP1kYtdgn7Ib6?=
 =?iso-8859-1?Q?mtFGimCWfRk0PD7adDzd6EJk1iVRaVsgyQ2/Nv0gejMWayZdjdgHq0SIjg?=
 =?iso-8859-1?Q?ofKRpv6RakGG9QnnJvGEQoLwC/wiPW4PtguHhQI0dZICx8U7UPBUe2F8aP?=
 =?iso-8859-1?Q?wGg5pSPes1I9G9VdFOW6oJiUUOap54TQ8YfpscpXdwJpGf8JcEv+553+l0?=
 =?iso-8859-1?Q?h/Xvta35JKcwcz0/Z65coyt2hflIYQ/ZEVNYV+QUX9Jg/0LtenGdf3dOD9?=
 =?iso-8859-1?Q?sdluhOCfpjTsXBGhZ3QckZIknrP8ab9HT7c37uqkiffn9+cHwm2z/cz32O?=
 =?iso-8859-1?Q?Wwr3MnSybrCZJZ0V0VIXdslqHVcHMKs8rJ8WpjlNG8hFX4Q2jQobPBJnAb?=
 =?iso-8859-1?Q?5rTOb7hFkIkVfR+uYqwiSH8Yzd/4WiYoHvTrgzAU8Q6O+YFC21UQDYuvk7?=
 =?iso-8859-1?Q?W/rKEIgemY1Dmblyt4SR3txtk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abef0326-281e-4320-04ff-08d9e96f8484
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 12:52:22.1959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IqUzH84SlxISn9XWMXIkQBx+oVLthC65x+hZu1gLGcucEVs/Osc6g+VDIr8p2HvGBgIPHMzryBty9CK2Agscw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6508
X-Proofpoint-ORIG-GUID: u1NL15ne-4xnzqZg1q-x-zI8Gu3o8VyV
X-Proofpoint-GUID: u1NL15ne-4xnzqZg1q-x-zI8Gu3o8VyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=603 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060096
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, February 3, 2022 12:45 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>
> Subject: [PATCH v1 1/2] iio: temperature: ltc2983: Don't hard code
> defined constants in messages
>=20
> [External]
>=20
> In a couple of messages the constants, which have their definitions,
> are hard coded into the message text. Unhardcode them.
>=20
> Signed-off-by: Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
