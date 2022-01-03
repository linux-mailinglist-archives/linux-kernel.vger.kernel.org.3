Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01A84838AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiACV7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:59:30 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41674 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229525AbiACV73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:59:29 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 203Kw8kN005730;
        Mon, 3 Jan 2022 13:59:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ZCjSTPaYCtjelYgTV6udlBi0ldBlB/W/OS+GGorfM80=;
 b=lg9sIjgLRC5BolxH4L4bv8lA9MmegVkxhZcXwyB218h6IhxBXT4g1rX8oIH7zRxsbeX9
 IO+Q57E6gRwp0fJZLuzviO9DUJfFLYXY/Z83RFnqO9PoSrVbaFKp+PQLDEa7lNIvMZZr
 RWbtLss2gfztcrGKfGhLCgvzNP75Rr+dNew= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dc8mxr6wf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Jan 2022 13:59:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 13:59:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L53ZVVv6/tPfeVH2A/4u6k6NwXiD31CQh1VZxLbNTDhuwk9h6203oq7AUMNSgZTaCRuNEKAm0ohZ08/rnONBPZtSGFrkmG9z/PSvtQJRwtfchjDLgrePStGmZwOcNNcdJBUO25pG4wRhKSGqBejFR5LRszX4GVjmEW5r3JVHf0b518yoUCigoEXKw8MdGOx2nD+Dk4dE7I4zZt3azzyq0DKiP1OgilcAwvliu7V8afD6ZbpFxu8haLIArW481HW2U2ELCPEJAgqEN1UeDk5qGQmVUxn+GJ8xO1yLU6fWRmpiWedRsxMdnEvz5VL6OQRfPSgRkBpft16+746luWqjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCjSTPaYCtjelYgTV6udlBi0ldBlB/W/OS+GGorfM80=;
 b=jzEEAk8v5ZxDh+F0Vydo753FGbLff7G6fM08BZ+XafiXLzK3aEjukWNJPywpagrzajRdWZjBiWclZ6lqyEvfBguN01I7sIFbqZciqQpgcSi+CddpFSpCIcu4MC+E+UED7IkNIVRZfb1+U0v4t7RJEVoTVwj1Xw9ZeaonvQAB6mpIB9NZWCl0Q5RO1ZwB6oxyhKwjo8/rsBQ6dcg7Nyy+O0ZXFq6y2UvOpBzoM/Y2l6DnZeXYkRKEU7qj5XOEWHQ5btWZpLHT3nM8zVJaSzn50Op907K8xEuouu6T62N8lou+uZKBvxsRfy+1FT0/LeSMFJ/Ubd3ARUuL6TZnnBBJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5096.namprd15.prod.outlook.com (2603:10b6:806:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 21:59:26 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e%4]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 21:59:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Norbert Warmuth <nwarmuth@t-online.de>,
        Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] md/raid1: write-intent logging/bitmap issue since
 fd3b6975e9c1 - v5.16-rc1
Thread-Topic: [Regression] md/raid1: write-intent logging/bitmap issue since
 fd3b6975e9c1 - v5.16-rc1
Thread-Index: AQHYANhvwyU+bNCYN02TTWmpx5kZnaxRtWoAgAAjOQA=
Date:   Mon, 3 Jan 2022 21:59:25 +0000
Message-ID: <D0600716-A336-4622-9A99-6EC4BA4D3B58@fb.com>
References: <m3tuekbos5.fsf@nogrod.ivcecceob.t-online.de>
 <CAHk-=whzdxBuoeTP1uJrxRQYtwOxPDYuP92c8e=_K5T1xHy7Ug@mail.gmail.com>
In-Reply-To: <CAHk-=whzdxBuoeTP1uJrxRQYtwOxPDYuP92c8e=_K5T1xHy7Ug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7fa4ac9-b3e2-4c30-0880-08d9cf044ed0
x-ms-traffictypediagnostic: SA1PR15MB5096:EE_
x-microsoft-antispam-prvs: <SA1PR15MB5096B2DC016F7A0D3915EE22B3499@SA1PR15MB5096.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqtcO8EgzXvnAHlnuOJpZTDAijWivWl3szh5YjHovEPVul6KmkyT0qFLYE9THPBsaT9zNgq6CYkUX6ulL1lx5695wobZp2Qc07ET4XdQ3GybIu/e7yEwRqfUP1KfG9Qq7mOKwpN2AF9ZTMyanB8IK/0T0kWpYNA75oErPt3qDM1I9TPUYN0D4u6uj8S0UxylM//sKJNyVSKhAo0rYpvI6EwwQSZbcdtn6yYl4+HGBf8GboEl41A2031YfOpGfb7bts/mOlQL9mnPNNrBAjM6TgU9T0FAInu7SUQCiwt0aKU7gTxSCMMXRzM2iDuYH0Y8+cDNDa/EZmEItHtL5AoBZZCXtW6IdKARHTQQpU3Kl71D8BZNkE3FA+SuNDUohSDmmbi60LIGa9QD9y4AOq/v9nwKwEhAJ5qAnkqS5iUgKeThbKVIDCOcQ1+vDUVufqOOIWKHCx5swGncEkmM2H02+IHwLynlgUNHXZca0Htsf8l76ORhU017nKi+Hm3XlK1nLm9K6cisADr9oP5oVsbN2760XeCFZ3cXjXZbHNQ4sDQ3etZAx7B3am2l2Uc5laVRG7/X6GG+qAyIr3SbV95KWGwh0sOwmeCbUMNOLBMYLShxT4QNHVSWSbvysiTubmym9YNolzmri1NoGuRbwapNrsZ1AbstXO0to/E8lmkfzOPcsyPf0bWKfJPUM9gMb8wofX7aqAgr9tJ6JPKZFiWAe58m6QIz1Ggx5ad31Hbx7JI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66946007)(66556008)(2906002)(6916009)(91956017)(36756003)(64756008)(186003)(2616005)(38070700005)(5660300002)(71200400001)(4326008)(76116006)(33656002)(54906003)(66446008)(53546011)(6506007)(316002)(38100700002)(8676002)(6512007)(8936002)(122000001)(66476007)(4744005)(86362001)(508600001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qXCx0DTaupvvXWWOY6Jd5J41UOx5r1iFqzIb+dy57x4d6bGcm5SWDuz5PvNe?=
 =?us-ascii?Q?byYSh7OQSEoOptAb5lidBuvbgH80vohUJX4RcCBw8UUPB4iqZbzLXnCdPFrq?=
 =?us-ascii?Q?5xyAzRzDlofy9k8b/4mUVRUop+WiGW9Wu1889hsSaKvOLTGEQcLTHw75X/IK?=
 =?us-ascii?Q?q4kaNctljzVYacjpL+orL0e4+npk5Da5O4ibcicZkRPY2qgRSmqViTNTBsaG?=
 =?us-ascii?Q?t4EJdkkHJBC+LqvPdb9I2vZEwNYGluesMTeX4xmRAnGBQoivo/n1sNxMshi3?=
 =?us-ascii?Q?qJd58mlMCnaXPX8mxMjteqIhcj5GC1S4mSyOsw4eAwNUbG3nAGvDMbihMf1/?=
 =?us-ascii?Q?gPSlGBSTVLUwqMC3Lu2Vgpexl/9AY28n4UTS+qUXbKk8QMOCPQvuiTRG6+kg?=
 =?us-ascii?Q?UQskuOS1SbZLB14W0V2SRme2xskySzPQyCLV/hdrX5jNze0c9Z72QmfGDUmh?=
 =?us-ascii?Q?xsYieUFf/xoVzAiWX8PPycp40ELQCh3hhLuTZ3aygP45iHeI0mRRjOr9Rm1a?=
 =?us-ascii?Q?sWRL1FF5LlLxtoAfCsUGYqH7h3lnH40JRVkhDWiZdXSC9ksqYIjIartV08T7?=
 =?us-ascii?Q?mHMrrM1JB+AUE/iPicdlzlNtIhWKlgQbN7hr73jHP4fCKn+HKpFpd1srYzT3?=
 =?us-ascii?Q?ZbxV9hcwIJc71/XzbGI2t0yBCCXnason85WpHbRbhnpWWyjDLr6mlom54wrg?=
 =?us-ascii?Q?hDLXJ93jsRqnOgRDUGLYGk2DbuN7CGgfvtIr/x5I06TwpOhUSupDiL4poE/r?=
 =?us-ascii?Q?HUaNwhxFST+ggD1VJdpQuu75o+p++MFsGu1sjzF6RkA6K07kDsrFhpv3i1s7?=
 =?us-ascii?Q?UmRTsAl/k0ZvlSwxqzvxA2n9x7IW0rGYIeIBDuyaKD3Il7yDUcq5DTPFyUL8?=
 =?us-ascii?Q?AaV29ZF/DP5Wb2hqw76VSDj4XF5Y8K3uBZuG8O2ta+VIO4nmdJUJ7CJ7uvo5?=
 =?us-ascii?Q?3WDDsX+4aWgUESJ8HTF6M/9BIILohkWx6c0zvn7Jai+R6cXa4P6Yr7gWUmYx?=
 =?us-ascii?Q?OtDcpFRd96zDewVfqicizuY/MgdEYtvrOb/WSKliZCMNbHQfCm/BZliGwefT?=
 =?us-ascii?Q?2adFPfrFG68VGetMK7zmcKccio6zWFvdpg4WspFNJXEHC7nu1pnpoK/9Ovzz?=
 =?us-ascii?Q?IJJ1K7UFWPhFE8KFQZVdToVOTnf5wBZHZiCGAwbzVGhKfi2NmT6wXFBPuXlw?=
 =?us-ascii?Q?hzS5e64n01/5RTPP9M7Vc2PrLSbjpIGYoTMAnlIl0+2x7Va3GqsQttMzuuMc?=
 =?us-ascii?Q?78sH9Rln0EqyXy/DHKYuocXsXVeiHgfKCZrGAZDcAk+3kNeBe0pVIBdlScW+?=
 =?us-ascii?Q?C05JENiPYRMSFn+VL7dVh5tNwhEXTr6UKW0dyACCybnp3GRP3YK7pFEjBaak?=
 =?us-ascii?Q?38xqiVT5KYrC/PmRIbTRRKW91WarLLpRwMoefVh9wqzYH9urIrK3/lRXvt4B?=
 =?us-ascii?Q?AEs+8uZilHqG/f5j1A88bGSFVAJA2vAHQD9//IM+0Qtj4hq/0pQbNhe0RMqe?=
 =?us-ascii?Q?2R9aZqIzsaWQnZPXmG5zadNctouuNdmBA4+GIW9qkYGwFYn0GUGhOzsPsmCk?=
 =?us-ascii?Q?3cnH1O6RaatLwbuHsXXTD21nljkUZMYi8e76aUBEuGko2KG8/8Yh1Gy190yK?=
 =?us-ascii?Q?+Ee6gWK1c1pu6gIJuoeCgKszJckwBheN/pVT9SgMtqpVJQbixt8XiDMzDlM3?=
 =?us-ascii?Q?LskQPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4F04C90A76E964FA2DDF59476368668@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fa4ac9-b3e2-4c30-0880-08d9cf044ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 21:59:25.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HHmmlr0RYjGYYfme+Z1hZcrakiZTFilDu0alyZZ2lIX9oT+IhNzm7+w6e8MbdbPPbsK7dU3o1KwbDMdQBgJWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5096
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 6q9j1MpVfzzXcSNVmvlsM_YtkrEk_haN
X-Proofpoint-GUID: 6q9j1MpVfzzXcSNVmvlsM_YtkrEk_haN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_09,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201030148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 3, 2022, at 11:53 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> [ Jens wasn't cc'd for some reason but was the signer-off-on the patch
> you bisected to. Added him to the cc. I'll bounce the original
> separately, as I also don't see this on lore.kernel.org - it might not
> have gotten there yet ]
> 
> On Mon, Jan 3, 2022 at 11:30 AM Norbert Warmuth <nwarmuth@t-online.de> wrote:
>> 
>> Please verify and either revert or fixup fd3b6975e9c1 if my analysis is
>> correct.
> 
> Can you check if moving the WriteMostly bit to the "do behind I/O?"
> section fixes things for you?
> 
> IOW, something like the attached patch..
> 
> Warning: This is very much a "Money see, monkey do" patch. I'm not
> really familiar with the raid1 code ]
> 
> But yeah, if you see corruption and there isn't an absolutely trivial
> fix for this, we should revert.
> 
>           Linus
> <patch.diff>

I can confirm this patch fixes the issue. I will send pull request with 
the fix shortly. 

Thanks,
Song
