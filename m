Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE21E530FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiEWLe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiEWLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:34:27 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E578450018;
        Mon, 23 May 2022 04:34:17 -0700 (PDT)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N447RE025103;
        Mon, 23 May 2022 04:34:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=frqPClyUNjWgWvNHCz0Uuuq2lbVMnn4kW6UN781WQWg=;
 b=hNnmIbRmZ7tu9K1bjb25km6DPy5KM9oeqOgG+yT4+d0TXdkY5yZRlSb8uYT7B6HjVH+O
 fNpTysPCc0nJq0a6jUv0iCj3cYthF7nyM1zDQkjQ3VQExWcVAi6msQnB/kfsT1mCA101
 eCxVuPMJ7MPTvJgBpdE49HvnHABi2Qcub/0Iwv7FXNVesC3a6QVt38j38WWIFbTlb78S
 M3vTVU9302VxbyH3eJEmjzSf835885OgmDrK4GRNKgxyvFM0dBFs/kfYBE2IHuSve+bc
 xoyWMCKDvtqnupgSnCfKsx2PQmfeRMzmpV/SDTdxh2JZOI7m9BA6OroALHUkXnRFgmVd kg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3g6v06b9s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 04:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl3jJVMe1RuLBDptayJeNenBVrc1cdEf5+Hi4EPPTjcdZPLSp0ja3crGw7CB2PvNQpacGf7XVsSA1xFetcB00DWMqpNAuWYrIYc9P+unG/Fuewtb4bC34tT+pdxQvuvN+u03nXugytydzbYH1taMq0UDpFVd8t5QI9Uu3jdi1qIVaSgJ/9YTH37QcLxnsM9N3J5WzDIrsbGn0CC4jPRZXsKzMW3QkycqRFl7rkPkNCLe7Lx3NvC2Lx/u7uNmcCHaGubB4SVHYrUrEK8Ff8MaAGUw+MEvXMs7OYJgu67vz37haByFvF8cBQ5pd2yVppSk8J+dYlAnqEysFH8m0ahfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frqPClyUNjWgWvNHCz0Uuuq2lbVMnn4kW6UN781WQWg=;
 b=kZ0XuQyRC4uJUW+WLZMfwDGvWZUkPTw97Q6nEDuQ0EYS/j+BzlHBRxDmMd5EEv2S3Odd60mEtGfmP5PnHPSTa5+b4V6e6DIUyeiILOa3LBu6MgkMJc5/h4Bq7o3M4dBClwixs2TWNMbV7Gp1QVu6+MtfWxyxySDh3E8z+jDGES6rnZRlB2VISJUm3tkssG3ShxqIB8CWUZcuFLGjKmcpiqcTijRH4a6tlC+RryWd97RhusvJogngM2t7QD1bi4/P/WGkYYfH6odExorWREN7HtbjCiHCkfLYFgMrvi7XClJGRNyB47k+XMZSkdeESQA2j8UrFETMOC3PlmNBkww92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by MW4PR02MB7379.namprd02.prod.outlook.com (2603:10b6:303:66::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 11:33:58 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::34c3:f129:a785:52b3%5]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 11:33:58 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>
Subject: Re: [PATCH] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Thread-Topic: [PATCH] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Thread-Index: AQHYbm+UA1e/KWx/QUazBlfDuzNMCa0sVRcA
Date:   Mon, 23 May 2022 11:33:58 +0000
Message-ID: <C4795509-E6A9-4587-BC82-001781D0D963@nutanix.com>
References: <20220523063543.99335-1-eiichi.tsukata@nutanix.com>
In-Reply-To: <20220523063543.99335-1-eiichi.tsukata@nutanix.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aecd54c-0d27-4002-4c36-08da3cb02094
x-ms-traffictypediagnostic: MW4PR02MB7379:EE_
x-microsoft-antispam-prvs: <MW4PR02MB7379E88BDDE485E1D620EB4180D49@MW4PR02MB7379.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cl7AVE5oqq93dfDTuB1ARWKipnmdwfXqKCO/WlFcGMWzQM8Z8T62qE2c5rEyWWs5y6mL+8n5CLLTLUE6fZs0x30lnQMG+JWZry2KkS4tQR1eqLL1xGPpTh+B16TZ9uBJbVmHwMGY6EzuxdmUsRHz6ZNB2WXxUQvU0rHbuapg5sSt4bojs38l3xvNd/k2qAcSiZe8uFsD8p5cnYpk3mqtkFzV79AtYX1CbRzEZZ4rilHdpVyXwDy95aX/kBdFnkUUsDGeSRY5KQYxvjngqpXX+Lijgp7AmSnAKVFfO9e8RdWw3/vNo7pzX78ao97PMF4+6+hX06e/JOeOdLhzC8SGTmI6JctYWeunNPry+dCjx3wk75vRAtwIwzEu66RBgkBPxdl8hi0HGeP8i39vTtTZJITkVlp96jrNG8gIiqU3XlGrnozJ4iAIqyOH64KaY7XXtkLP1JU7jBKMIrJePCkqdlmXloRPZX0icdcaV/lHMoC5wb3AsO5RyZiUsPPt9sK2i7gqpGHN9ZoENhQYgJ1eIXeolsgTITXxeYcNQUQfclKtREjWsN2ra4I++ww7kTcTzn0JHi+hfdgqXXePaNJbXqkp4yinnns3+56ILdN0jaVuYy47gcwcaa+P9HlKYdTm7DOorOWIOjlx2PFRM4/+AhU8j8bd1s6pp5oOhOdjVrmse0N7DtnyDFTcpZ/wu8EeYr0E8LLOTnmAGJUpFTDHenl+OdN5mUyLlYMvN+v7TOs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(64756008)(2616005)(66946007)(8936002)(186003)(83380400001)(44832011)(8676002)(110136005)(2906002)(36756003)(5660300002)(66446008)(316002)(66556008)(66476007)(76116006)(91956017)(508600001)(38070700005)(33656002)(6506007)(53546011)(38100700002)(122000001)(71200400001)(26005)(6512007)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gkyh0GVnZmxXec1qGBBSobJZH6CDigMowCBK1otwYozpzcnemxN8GuUWy9Ac?=
 =?us-ascii?Q?H2BS/S4pUb/7ygeJyW+rjyRA1h5p/El9J5P0l7U77XBoi66grrDLbU/nPkAM?=
 =?us-ascii?Q?1yqw+3J6Xat2wkcBZCvNPVUZbP1EhIH/7jm789DBx6MDkM9vDyKgqVtGY6NE?=
 =?us-ascii?Q?qkviD9fiiQjDWbDVoFVXv6+TTbB6w4f23eY2UP9HyzjZeAHST/TiuzHBZ2hY?=
 =?us-ascii?Q?+Z7nmiYWBFQ36IObIui2OD2hG+T+hlHMm8iVuWgUpr3KMOD0XIJFOcgMCZPP?=
 =?us-ascii?Q?+ANovV/AkRV0CXErY9W1FM93DnHBB3PkJcNwHgs418G88nNcoRYUZZs2xnLX?=
 =?us-ascii?Q?0m1Acw8X0InK5sUgAA8VvRmLzHqqIgcWDIzjA9c83WrhgAgK0x9WSLgi4S5P?=
 =?us-ascii?Q?gR+86D86efhwlDjxqMflH9PgMUsgKsNGcRv9Zy7ynRRv1StnDeyPzkuCOMED?=
 =?us-ascii?Q?+qV4DHsAc6iM7AaHjfyvt5QAGyYtUICw9imVUqd3SImuGTor4EROeH96yTsc?=
 =?us-ascii?Q?lyqjfhqDaxCS1CoItUXpHELY3jxj/ql9pt477aXNOXvSXinaFvhaM2ug33jE?=
 =?us-ascii?Q?aMLiS8Iyv7zNWL4WiGBaghUD4qYDcsSzn/TUriNLYELtBt1K5ubADAM9kHz5?=
 =?us-ascii?Q?K1DazxqpUCNcixoILUWqhvlIFZh4T1EnoCS+nxhVAkbg5oh9Wx/jSIECG+Sq?=
 =?us-ascii?Q?zN2Aihg0vFKIhVyP8FXCLbcgM6l50IId7+3KCtOSkN0JCHIPVIXS3Kx5X59S?=
 =?us-ascii?Q?MAmwskAxIFm8OgQdLe+UmqJf7N3ZHVaxRZucaGO5dp9CnpLYFgMv0/KlfpgV?=
 =?us-ascii?Q?DwwNuPpfKPPk4T9tRSpenMOeVciYqzVZMxhtIn5qm6rwVcLIJjuQ/bnnIIku?=
 =?us-ascii?Q?8TMMgjoYSXcZIV7j8NHlk4aCuAJ6fl3wB1KXPxE1rdANNlMHtNOLsezFQMMk?=
 =?us-ascii?Q?b08vUH4hc+Uf9CJWGLdCpY3/u9NKFgd9rCfmffAKz6IOf3OIofBas0C8E3Al?=
 =?us-ascii?Q?5h4v+J53sacxm7bBwa9fShm8XQpB/oo391MIt6V+XTLNIVntHCb0vjBhQUUt?=
 =?us-ascii?Q?dBE2cujJP8xxF7trrchc9yTNUS24mgP3tlkWwpA3gpufxLDMe5RY6/e3AT94?=
 =?us-ascii?Q?4ugICMjEnMLsZ+MsUT3KLFz5CI6mXlueWKN6P6ocgJQVawH07gLaLZUDDDgf?=
 =?us-ascii?Q?zfunnScRbmh3jLbF9/zwkxtwX3Jqqw7LXoPZps/CY3aPpKlFZZIvsKbafjdJ?=
 =?us-ascii?Q?+bH6XGQGac8r7p4XgYpN73CgKEAcZMAqN+wlJOtQVjY8FvdCA41Jz1vsjKNL?=
 =?us-ascii?Q?MeOur34KTsW1m6SlU4qBxs+PSeH9ZWzRQsI7LbdZYE2Rx2n8/NaX8VlWaJnB?=
 =?us-ascii?Q?Akb+enD9mDO+tzBTWDGnqaKw9UpEi6xxAcLVg5+6SZsm4rOKYfG0x6LAYBV+?=
 =?us-ascii?Q?Bxu9/HrAaoC7up+on6cgecZJbuZAs8aJKeM89C6zTPTbQ6E4lk6AJbbIXeE+?=
 =?us-ascii?Q?G7cgKizQ/PEUYrWNP5cf/IzVAkq/9GbdfjsSMOI3nV9prIIgXzPN1rFe7uaS?=
 =?us-ascii?Q?lHgOSnQx+yk8WSl2DCnAMkHOPPZWfTcNQBTLLJfzNStkGMed9W1G+FWpZ9tE?=
 =?us-ascii?Q?rND2isgKSa5wp+gedTbJEraXSr8w2VI8cOoW2Xo0hS1oiGCYTFrKWiF5LyPT?=
 =?us-ascii?Q?TVlueCDgmtG4jaIEigBFN08Mu57qExZouQoknRqMq/FKO4uJ0jIk7XSKhgqx?=
 =?us-ascii?Q?6J91lb/iED9kPeXOVYJiopYMj9+xOFw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB12388BEE067B4183BC6DF7BA890F2B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aecd54c-0d27-4002-4c36-08da3cb02094
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 11:33:58.4378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJsjOvJpUq1YEAROxTm9PfYhGSB3E9dQqDNGMKlSszph79ZPkhx4EBhtS0CdswJJDt1/fg91tleM8hDafBoFkQyXVSV6hTKXkBq8NPkVGD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7379
X-Proofpoint-GUID: Wv9OtyCt14SFpEmW8jguP2h5wY9R6fng
X-Proofpoint-ORIG-GUID: Wv9OtyCt14SFpEmW8jguP2h5wY9R6fng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_04,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 23, 2022, at 15:35, Eiichi Tsukata <eiichi.tsukata@nutanix.com> wr=
ote:
>=20
> Add trace points as are implemented in KVM host halt polling.
> This helps tune guest halt polling params.
>=20
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
> drivers/cpuidle/governors/haltpoll.c |  7 +++++-
> include/trace/events/power.h         | 33 ++++++++++++++++++++++++++++
> 2 files changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/gover=
nors/haltpoll.c
> index cb2a96eafc02..9a6eca41a484 100644
> --- a/drivers/cpuidle/governors/haltpoll.c
> +++ b/drivers/cpuidle/governors/haltpoll.c
> @@ -19,6 +19,7 @@
> #include <linux/sched.h>
> #include <linux/module.h>
> #include <linux/kvm_para.h>
> +#include <trace/events/power.h>
>=20
> static unsigned int guest_halt_poll_ns __read_mostly =3D 200000;
> module_param(guest_halt_poll_ns, uint, 0644);
> @@ -77,13 +78,14 @@ static int haltpoll_select(struct cpuidle_driver *drv=
,
>=20
> static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
> {
> -	unsigned int val;
> +	unsigned int val, old;
>=20
> 	/* Grow cpu_halt_poll_us if
> 	 * cpu_halt_poll_us < block_ns < guest_halt_poll_us
> 	 */
> 	if (block_ns > dev->poll_limit_ns && block_ns <=3D guest_halt_poll_ns) {
> 		val =3D dev->poll_limit_ns * guest_halt_poll_grow;
> +		old =3D val;

This sets wrong old val. Will fix it in v2.

Eiichi

