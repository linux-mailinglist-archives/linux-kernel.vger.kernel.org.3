Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E789B4838CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiACW2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:28:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40782 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229876AbiACW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:28:20 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 203LEcSt000932;
        Mon, 3 Jan 2022 14:28:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id : mime-version;
 s=facebook; bh=Bq8EOvNu6++xIrL/a32EK1li5sER0OGzy56CMMsjbLA=;
 b=WLzc5g3R92nMkKOar3Gm8+tnmNsShmgyDxeehagE9fFjFpVCLZDok5l0NOrlZW90FBUQ
 Ik7UlN6FulYOfXdT6PNtv5uGgaRgX5uQ2G9AINUIToFUMc2J7Q7UM+2qjxtu1Nl3U+lc
 K6MCqSvNfveq/4eT4kgXWLfoTQn3zUwxM2k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3damy1b16m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Jan 2022 14:28:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 14:28:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbcvLQfCr8sX+w6yFFvhw0bvK/CBt/jHsg+mQWjfAr2nqDHlf3UKtYgCOMr/x6unmg2YfuzISa3hesoyUmkoGiqheDnx2j0/91gGl8JHzE2YG1Esd7Tm/Jd2U6wuG/I8fQOsYGvO1kC9T8w4NlM/CXwG0eWaq4dmFiLFtFZueSz3F0H/Rxy+GaHRewzriSHRIAjpZDzHwWah1EI7TmAjVWIR46pPbVh2aCBWrVBG2zarrexKgoMHmElovlcvuM/FB1PRAE+oPwFbJ45dwVcha06pKIsIW/BpcLVeMP8AaBRxx6RyWrSzjcp4s+i3l/y1I81+H3JRRCUYgIPDKCPYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq8EOvNu6++xIrL/a32EK1li5sER0OGzy56CMMsjbLA=;
 b=ZGcRpiTKzc9QjA73K0qVQJgAu6uxwVyyTO80QlmthyECb/Tf+TAXoY6r3W/WTqPoaPRobjUn6XAoIrClfEs/N8RJutf4kA4GElQVXVfJNWV0bz2GZqqJ9ku/P3MQB/2P3dKlUfwZamHC/Tp7Iz+sLe51MCWPG0fFCJF69OM5aXK9kUoObwx0+Nyb1BS8OzlYVcqVAaCC6NThO40MQvKHFGP7HC7RQFkE60L7rTo4hoi4CIcgalOtPr5SI+xyoRcxMwm+1rOceIqPRXLTA0U1qFAeOkaZJfeUpoImS+KE2HMujW3gZ3gB5gdhrRrlbGDW42s+0PbEZzhFpj6P3pOcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5080.namprd15.prod.outlook.com (2603:10b6:806:1df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Mon, 3 Jan
 2022 22:28:16 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e%4]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 22:28:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Norbert Warmuth <nwarmuth@t-online.de>,
        Guoqing Jiang <jgq516@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] md-fixes 20220103
Thread-Topic: [GIT PULL] md-fixes 20220103
Thread-Index: AQHYAPE0O8rPXYHKLUee8SaN2Mk9wA==
Date:   Mon, 3 Jan 2022 22:28:16 +0000
Message-ID: <C0F28A74-39F7-4B12-BC8F-96E2FEBE0AD0@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2a0021e-75aa-4fd3-5187-08d9cf085695
x-ms-traffictypediagnostic: SA1PR15MB5080:EE_
x-microsoft-antispam-prvs: <SA1PR15MB50807959C9B2044F9EB385CEB3499@SA1PR15MB5080.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/zYMs8673WM0vNcwb66eZi4e+ygmCI05xOYWnnOOq9jwGBRSzZVbi+25ntADHv+2vFwOEoeDyvwIvMCjTBR97pMvDLZW1Wi3wQwsIVn3R1vGxlnah5mNswMzOo7JELFtMbPbTPPUHrpd6/YKxOAEqSAwLpKwH4qCX7ikpQLVrAsOaAleW6R5ZBLHgq7q8RVaogi3B3zYKAwQzAzR7/WNdBRzftXZ4c6BS8o+xmC387sCGjWz7/i0btWz5A/RVs7bq5uuMsKNuDAerEvvyRhY+TovJq//ryJ5WHWPjTTSR27GMFgrGtU4sA98VTAfmcTR93vfE5ZItoK07Yb6hdCXohiTwgVrxQXFP2U8W52nUt4niyKrwVZXtOVcgJbg7X4RAz2KYxFUFTTBr49+k2ZhGVo7qJALixQBfecqKYTtLiziMv0QYnwUW0aECk037UsSCGnb5aYUlGXrBlyeUD2qJQ2HJ8WOcBHxJCk8KOCYt2WQyH7Gp2qisldoOjD92ekAcK7qZMjjy1uCPJD+9tu+sSVKoS2rGsxJ3rS1FZtPrxQW3+td2/AkiHU0VF7Ns0kfL9H18gUwQ9LcOJ9iCudwy65fEQH0WzcKzjTEAfwV2zRj82YvJCEMRPB3XkuOJozHui8H8mwk+tlsmaopcqX1D2sFZnMtsp7xvZvRKmz5zdz02dTw78pCZIeZh7kJtbzZ1Y+xliwQ9qahqajL9MNUtB3f/z11KLZRQdXj5tuxUqIe6Z4DpHelaZrD3laFrpcB8ufIAxBdjGZyFUorn5ra77j8Z/6DUkWTeqyQfhaSCc13hXyZ5gEbKKxdEKLdbihXYfHYzkx9hYn0YAq4QkbIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(6486002)(508600001)(91956017)(6506007)(86362001)(83380400001)(2906002)(186003)(966005)(71200400001)(4744005)(8936002)(122000001)(8676002)(38100700002)(38070700005)(110136005)(54906003)(4001150100001)(5660300002)(316002)(36756003)(4326008)(66476007)(66446008)(64756008)(66946007)(66556008)(6512007)(76116006)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nn4eTHl21HV3EWwaOJGuPKAXUEAhJx7zZW7zZrBoJh+6MnIKa7f7zPdZ4YGw?=
 =?us-ascii?Q?aHyMMP1FO620Ec2jKZAfML2sdDXEnTPxr1kn1bAOQwazrDxP7x3uPx6IKBj6?=
 =?us-ascii?Q?OgHipFLq/XHcIg7UsCQPjd/YJkCDAackmvvoFSgflPlCZlOIMhpU3hP37UMi?=
 =?us-ascii?Q?h7htIRQdxqxkJl8njvtDj97yxUX52i72ZOYoN8INyOkiZJZHdaH0Xj7AQjcC?=
 =?us-ascii?Q?zRNuDGSeoDF39/74+EJwDs02ctMpYD19xO1qXnybg4bIfoTX8CafIkrYCzdT?=
 =?us-ascii?Q?nkjlXd9o+fRT4bdW0Fgd04mwDqzJbd0T+8HHN7oN8SDBU3x8P3OlNMR7DE1L?=
 =?us-ascii?Q?RPek7DY2yEPR35ZleKtKS8c3renzJF9t4chBFxXa5CYh2FlWYXAVEkWv0RBO?=
 =?us-ascii?Q?BeSsunUJLWG+as/zKEC7fmX8Tcpo/bs8TBrEbNP8VSoYGmmZf+FF41wwdejf?=
 =?us-ascii?Q?2si4tu+UuUzr/d8X9mIQQn8IuSvZfqXYyyHm80uMj5x7jf/Jcx6hgDrRsjJr?=
 =?us-ascii?Q?mnCMRADyXSSfCW3mp3nnueWCf8jY+Q+H3tWZWrkwBgjq5+IEuOrqug5Q4UB/?=
 =?us-ascii?Q?q18byVUncyvJeeIIdoY22hZH8iGZkcOzbbqzb4pi72fzeTWa4QdRgFZPhIPV?=
 =?us-ascii?Q?YFUMaFcJjc0p/yzgwpb1/qy10gJzv3R1UoSfEbWkgWdT7VMI7hCqwa6QJD0W?=
 =?us-ascii?Q?iiXoMKHjctMu1zHClLwNomcCT8xwO1BIfBFda39IW6qQB1HiFI/CA3iAVkxZ?=
 =?us-ascii?Q?oZDx8AHEWH2Y4BR9/or7ifisFT+o/Nz+Rz16FNjqopL0kXpw9lCwa/fsKhOV?=
 =?us-ascii?Q?y6XjMZykvcWIi8NM7MxpxaWqLkDbRAXaMyrz+smCG8BVSjNcTBUFNjs6yDCm?=
 =?us-ascii?Q?paNfKIF6bN/q83bkx7Tk7stxlXGBC/+wo5kW3sXOeqTpRsE0aO01theC1AEL?=
 =?us-ascii?Q?61I1/q78A9C1bEsIt0WRZMCBY8hlIq8gH2lyPK4urdO+Fn2JJ4sR7iosijIt?=
 =?us-ascii?Q?9jeWfmIcrXvX2sslZgCPaPspv8SqimFPkSvurYOK3/MYAWZEigCie4CpOHJU?=
 =?us-ascii?Q?rxFsE9PYbQ2ybqQ3tuY2z0AKfTBptglBBE9IjcKXOHJxC72FoY+xhzRxrQTi?=
 =?us-ascii?Q?yIMPJsFijKsAATSmZ44XpaWVbUkBFDgQUBOPkhtjPDDQMTEwGZmj0uWVjRy1?=
 =?us-ascii?Q?k6KBPk3BwWfnl2LUeUxRl9Pd+n4NKnY5WkAl3CZqr3zuqSqrWOchUsf4Dg6K?=
 =?us-ascii?Q?hsmqFR5AldDLTwsYiIb9OqYkU+wTH4XoLCgAKdNxLVrc7mz4gU1lmATse0BU?=
 =?us-ascii?Q?7mYzcAp/Qhpjb1j0azzZXxcJ0rt5J+ktTL9B36nvLnqp31tuf+Zy0mUpgsqL?=
 =?us-ascii?Q?lS8mj2tWVpK9veCx3/Egf5ecICF8V/v1SBi2tPucwjgyRnKf4FEb/DJuay8Z?=
 =?us-ascii?Q?z3uKuF5evvAqB1TbzAySy3I1m4GPmzo8ecy9aWFnVzbmxG8nd5BoGLwQlVUG?=
 =?us-ascii?Q?gGAs3opD1KHu4n9XI9ab7r6Bh751LzC6KeKoy3/6/AGyuspUjQMDc9+iAGvM?=
 =?us-ascii?Q?XcDwhmL83/WMCCYiAZpGlpczqf5K8g/aKsbQOatfhHxF5L9sTVtjORnH5bPV?=
 =?us-ascii?Q?YdsWNJvwmDunjkpcURmNtSDEbl/DnvC5hy3kkLAPKHtcKkDop1KDYPbxoUBz?=
 =?us-ascii?Q?tQ9jdg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8BA264CDAFDFC4A93A3208DCCAAE55F@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a0021e-75aa-4fd3-5187-08d9cf085695
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 22:28:16.8012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqqE1etU1nSt3Nh57VYF7Ex3mu4z1SG5saIpSZqEyK0wIc/EkfQ9f8Y6GBXRP5oIsk5qXAy/UyrZfU4VSi7dOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5080
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EO2nOmCESUBC9s8lC3jVkjn5YeGSvKZf
X-Proofpoint-ORIG-GUID: EO2nOmCESUBC9s8lC3jVkjn5YeGSvKZf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_09,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=998 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201030151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, 

Please consider pulling the following fix on top of your block-5.16 branch. 
It fixes a raid1 regression with missing bitmap updates.

Thanks,
Song


The following changes since commit 87959fa16cfbcf76245c11559db1940069621274:

  Revert "block: reduce kblockd_mod_delayed_work_on() CPU consumption" (2021-12-19 07:58:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-fixes

for you to fetch changes up to 46669e8616c649c71c4cfcd712fd3d107e771380:

  md/raid1: fix missing bitmap update w/o WriteMostly devices (2022-01-03 14:13:48 -0800)

----------------------------------------------------------------
Song Liu (1):
      md/raid1: fix missing bitmap update w/o WriteMostly devices

 drivers/md/raid1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
