Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA60558990
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiFWTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiFWTux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:50:53 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E693B5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:50:53 -0700 (PDT)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NHrMoq013526;
        Thu, 23 Jun 2022 12:50:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=Wv+GR2zu4GZyPmu/qz/5UXZ8HiitxZ8J3sjA0dR0G5M=;
 b=zk8tK0iM+HW6qgbAz9FzTNsrJsQbMTgpTbk7M/Q5fpw7wwfB/DP77jjq9q4tYUprg35r
 OEXqG0thZ282DKdPvINfQ1YIIWgs9vxLGwQ4ztLCe3FR54CpSxZke6/sP5K3I/hG2gbg
 J2J8fzM6fD93bHj9XOF3uvXpbtqg5jSolID7MLZ+CNfoZymlDroQxjYRHrf+vwnS0++Z
 UrvnmeYFOMtKpwSCShqbUY9ytK3+paTOdblSoAU3kAf7cwVWUTr73mPdHyPMbNaG3ys5
 M04wnE+I/8tsx61RFdEJ9XSpUCGlDYCKu7bnN3I3LgXvqIszV987myo0FVO32TGSIoVc 3w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gsamacjcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 12:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmQ9TiSMm7wWGm3ysy2f4obQRKkJa1gLZKWYb6Z0dIRhBDvKyCPBQOHRBZOQnaPQ9zPTUJu3HVyWWoDGGRgLB13C8ks7BrpA6M8iiSBwWzu0B/GRJXCkuPd3wRKgQ6+qq1ZZUvZTaPldaQaPQGAEpdvgZtwkh0z+jcvIRJZfEE+HhL57b8Z3m5MWQOcA2wch/txEuc3TDQl0vKK6lAeygNP9uP1bCM6iPBQR7Wx2qGXPsyFULeGdvNmtqQMJkQo+UgJ/n4NGWDj9WB5qWpqs1x+me9xdj0qWDD2AB/fA4KZQJ7iAYVb1zkcmwXzXPfWdEjkBLMV21dqegY6nkg6Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv+GR2zu4GZyPmu/qz/5UXZ8HiitxZ8J3sjA0dR0G5M=;
 b=iJBjSJX+Wlihr9b/NystHzvhrP/dWpqXw7vdY/dHmNj+q9+qYnQLhF2mNXyDEuMR44uk53q2vC+F9eFzOgqtcW1EfZ1jLo2ULBk9MF3um9g5+MB0v2+v7wB/K2/cGlUlezOVhlCAx/b861O7NX79gEskZhT+thlv7EU4w+Vfz2+paoZH5F47Vk4R210udsKS0+wTD9P76EyrkkD5TYRBhyH6BqUsgxrn8GcQqrc4P/cBGr7x26ipAMgc9u1EbV4w+/zXYD1MlXiyM4ngeb1Y3HQwop0etH7QCguaZSZwyN46ucmrMNKX0E3vEpFJPP93dY5R1HPbvCxAKIo2/ZsjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by BL0PR02MB6529.namprd02.prod.outlook.com (2603:10b6:208:1c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 19:50:47 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::c17a:381f:c32f:5a54]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::c17a:381f:c32f:5a54%4]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 19:50:47 +0000
From:   David Chen <david.chen@nutanix.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Perf regression from scheduler load_balance rework in 5.5?
Thread-Topic: Perf regression from scheduler load_balance rework in 5.5?
Thread-Index: AdiHOIYtzTENFRVgRIe5P/iKHm6Zzg==
Date:   Thu, 23 Jun 2022 19:50:47 +0000
Message-ID: <BYAPR02MB4488F89EC5DB73D1FEAE9B4594B59@BYAPR02MB4488.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b50ba5f4-5b0f-4615-bc3d-08da5551ab12
x-ms-traffictypediagnostic: BL0PR02MB6529:EE_
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/uUfi9EN08SmIN65zoMltKq5W9qvbWL6B1eNP+3zbQbIw0grHCH7CgFK7v/DA8CgmijMOvq2WwfYFJ753BWbgKlWaAxaOYhfIJe28YpFXb2oIdKr8j++UkqSUqsBAldBOJOF0BoutLcV/2WUStQ49RDUJvHno7tvU+ALT0qLs2MY6w6uh0otkwl6w7ujxlt17y8ogqSVS1IEkXgvbD4RRxwkTkH8boNkaCc9OnYxwesOgCV3UDW5NMYwCUfpJ1Mi2dvwRLT4rWW9I+2jaOB7wQQ5SdeaNtXyHuPPeLnjTMplCjtomET4+LgqWRSoYBm0/KfCP2MWV4qMySHI8nCGKib1DzsLqz2PkKg7XFUWyiLSaTC7ceSNTkYYM0bQ/vFHMfM2LJuY5I5t4a0EQS3EBxb46sVPOQ4hVymmIAXJbPeJnXZCN83CbiU/u7XL0hKUtWJKIzx6o4enJOg2nwdaCyvK16b0Ziujt/7dGkVs1rpVsbJJOXAit9dyEsVkRcLZOwWIE8UuMWq/7N39vWXnLLBrJIb9mZkZCsgZQ+5iupXPpNJfPIwSAg7ariWzqUR9YFk1zEIcjPOGmZJdgNjTUGAg5Kl/k98iR6qlmOpQxh4n2yZAXgvSHrkeupx+A9yssyjWt451uT+0pPexd1Yoh7Pjn9wh1UfIyuwalTflNRwTUPzLhvIB3VU3FxqUZFjAg9WMFDWcN6MfAMVmPGd/LHezPBMEtD0GaTLwhGCpZCt3yGBORVCcMjyHmikYmSKsFO9IK9yeDGniOG4OWRPZ8wB++5FiqRaM4F0+tmcK/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(346002)(366004)(396003)(66946007)(5660300002)(76116006)(8936002)(38070700005)(83380400001)(316002)(54906003)(41300700001)(66556008)(33656002)(66446008)(52536014)(186003)(8676002)(2906002)(4326008)(66476007)(44832011)(64756008)(6916009)(86362001)(55016003)(7696005)(26005)(6506007)(478600001)(9686003)(38100700002)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fEi7BQ95Mro+CwAf2/i5AUq1WUvDD7e7cv1tzC9XqUFsTPpUWZGAMutQ4WWi?=
 =?us-ascii?Q?LCLrzKFm0QvQj3qicrkEopHdmllBhJcznguHgGB/PM+ffS15yPxPPsXBkxtS?=
 =?us-ascii?Q?qqORONYb24i82jA39vg7QVxkOtvTRaZLmbbUJYgj+A5fQSH97pWZiQiLL6Za?=
 =?us-ascii?Q?OozW74iz3/R/+p8E4neUOEABL3c1nI+vnCdP3ysiyAswR+PBWY7IdlNphc4k?=
 =?us-ascii?Q?Orgw55ujxrYOpzJTBHzyWLxSKe5bva3KLxsZQc1nWEBBiqVeljcm7MjlA+KZ?=
 =?us-ascii?Q?Cs4roc6H/eA8B68BruKUbMyTIlZgQuQmg6ema2dxAdCiRM11vcwgZ6+yUauI?=
 =?us-ascii?Q?3mkxjQyY86QFQzKKrsw39yfZRjYV7HXPzZqBF6ZPLf9qY6o3Iqk/xRX91hQL?=
 =?us-ascii?Q?j7x3tNrPzJnL/SYoqxtAVf/VU3GBt9d8ANpS6ZLmdWpwCNwz9Y9ST1vx6TZG?=
 =?us-ascii?Q?IbErV54VOeHRi5TgUoOwGNmpDmx3pRESpirL2ZDsQ9hVE2dozpuO313waUpN?=
 =?us-ascii?Q?QA3s2BIQ2Chy7jKnGkFDc5KYB/hoUPm118cKENe/YIjTsLLXJkcuJGzhaD+U?=
 =?us-ascii?Q?RCxRpUEFpN1IXS0aiadAzB2JOTVt2XEiBwoelwg39wb50yNQ8U/uSVuEhLJk?=
 =?us-ascii?Q?W/MktPkAY908tCgZEdgJEf3Fvwe+YVAoHjSVML9ZCrUmQwrTh5skEUDh9qgx?=
 =?us-ascii?Q?vVxvcrHYHdOfU0YNsqzc6rmL6bAzw1KkJu3C/Sam0JG1EUMxER9ITTHcbxnC?=
 =?us-ascii?Q?5zOR/gaxvKDFulSSphpO/O88ckNFbgtDFfC9BKBRfrYQmq4usuC8SGCNBodb?=
 =?us-ascii?Q?ml9xIJkI3tdnclt2H/tGzSsbARB0Ntx1FOAMI40L9iko02djnSmaNn9i8/kH?=
 =?us-ascii?Q?/R/pxmAzWwOIPERe8Pxec7gVCvev288zk0pV39FchEVozjLICICE2upsvAOg?=
 =?us-ascii?Q?iLkfFuQstKasd793yvysjdMPbYiv6nmDI5zMjXpPB9U2ZZKJ8gnuyrQcBiJ0?=
 =?us-ascii?Q?rvzrlSa4loSCL4VAvMFnqhJ6fOA78Hax9g90q56N5YIouZOszpAlgIT1dHX9?=
 =?us-ascii?Q?i7DBUau7fspi2TVRVaPZ3fXtfAvzLuFACKlmul1vdF+ZVrsZXJVhNamJdb48?=
 =?us-ascii?Q?pVx9fgT0XyekIPkmijC/BTUCWcbG86vamBvoXgwwS5nUhT+W797YnfwCJ+Vd?=
 =?us-ascii?Q?u8dq+P80wYiMtf3vYqdRRstYsfjD96sKxeezi7QbpNGrnpZEwagXInVWLFka?=
 =?us-ascii?Q?Vf4K434mqAzJRKeIeA3sKG3/GzoglxRbt/K4I2wFvJbz0oc+9NBtl535pu3Y?=
 =?us-ascii?Q?wNiYB7ScHmbb7FbsFnJcqiO7Q7zPX1fDiCF/AGsGmWhX87+kl0bP/CMG6NeK?=
 =?us-ascii?Q?ZZ6UkCBZCqoWAwKCVMBJQZf6Y+WWIaiilN8n6i/Jik3UanG2K1p8n/ooq6GF?=
 =?us-ascii?Q?R27PyspRt7BlS6zq1woumySbOdpJ1iklXwvK5S87z4aKvZ6mCIR9vpumlhF9?=
 =?us-ascii?Q?l0jtRgF7Qzt77J4NX0DNfB2ZO2Rj6up4eGQ//3/MRTX2G64EzCUzc6uIAObJ?=
 =?us-ascii?Q?0eZDve1iQaHpuo7LlI6gzza1Yl9IZIEmzMqbR0MY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50ba5f4-5b0f-4615-bc3d-08da5551ab12
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 19:50:47.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkivkbTZwjWVnDYntBvX7TgJon+bwvYyeEJq490Xo8o2RbXh030K8zFyqm4S/cG4ccbRpVtoW5b6ZL1owCHo+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6529
X-Proofpoint-GUID: QSXxenyU7o3OhtPZPk7nRYvrYzje64jO
X-Proofpoint-ORIG-GUID: QSXxenyU7o3OhtPZPk7nRYvrYzje64jO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_08,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on upgrading our kernel from 4.14 to 5.10
However, I'm seeing performance regression when doing rand read from window=
s client through smbd
with a well cached file.

One thing I noticed is that on the new kernel, the smbd thread doing socket=
 I/O tends to stay on
the same cpu core as the net_rx softirq, where as in the old kernel it tend=
s to be moved around
more randomly. And when they are on the same cpu, it tends to saturate the =
cpu more and causes
performance to drop.

For example, here's the duration (ns) the thread spend on each cpu I captur=
ed using bpftrace
On 4.14:
@cputime[7]: 20741458382
@cputime[0]: 25219285005
@cputime[6]: 30892418441
@cputime[5]: 31032404613
@cputime[3]: 33511324691
@cputime[1]: 35564174562
@cputime[4]: 39313421965
@cputime[2]: 55779811909 (net_rx cpu)

On 5.10:
@cputime[3]: 2150554823
@cputime[5]: 3294276626
@cputime[7]: 4277890448
@cputime[4]: 5094586003
@cputime[1]: 6058168291
@cputime[0]: 14688093441
@cputime[6]: 17578229533
@cputime[2]: 223473400411 (net_rx cpu)

I also tried setting the cpu affinity of the smbd thread away from the net_=
rx cpu and indeed that
seems to bring the perf on par with old kernel.

I noticed that there's scheduler load_balance rework in 5.5, so I did the t=
est on 5.4 and 5.5 and
it did show the behavior changed between 5.4 and 5.5.

Anyone know how to work around this?

Thanks,
David
