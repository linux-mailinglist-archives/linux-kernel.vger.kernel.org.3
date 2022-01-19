Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8388B49348B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351543AbiASFel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:34:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23264 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbiASFei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:34:38 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx6EL012828;
        Wed, 19 Jan 2022 05:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=55sWditpuwnpjGlbI6VBBv5sCDsJUxHBCnUpITbXutI=;
 b=v2t3Ply21jPtJC3PuMbRgTWvh99sS2hhBAAOvga+tnVQ9Za2zg4KKEk/zW4aD9PYUwTf
 rn4UWSy3Hb8OndrwmHtcouRi3ZNxMR2oyTzT5yODWs9HLadI5XShu/QkdegPAWdLfHxi
 vrEavbPc5UvETwOSDx63dJqTO8dvJvu0spT/0qULIio/J/sTB5YMiBV3eT0RGwPLZ1M9
 fc5oE7hQQVBjxIXo++t+cQNCUWTRu7paxrXGQgCyFeM33MvZXi9u+Mu4XH4gzRW34/xs
 4ck0XXko+cY+tlU1Oyqunt8hVX9v418scD+hqy+YYZtwAMIyAUOL3VjZzuButeXdAnBg UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q42v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:34:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J5UZKj086018;
        Wed, 19 Jan 2022 05:34:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3dkkcymaqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9SXRyVmLNsLxKc/vMvTIFmCC2Xpu8Vmmziuw5wsCLcM4mMyJGrFX7BpkeQQHZMZGkjSRwIL7lUAbbnquB76NmrttwBtxR2qgQun4IeHKh/okMUM7ZO9PBgAcX3oUvRuQL980j8J8gd+l+TXuX/E+kRam0EWsvKImcixhTQeEty8AzgdSfl2anA1e97+jaBbghWcvvr59RjjAIXmPwNPAh46mmDhWCaq3HjTrU8A7IRSaCfvjob0FOv64Bn/Jk5vZXKMvAJllneWK5j6WsqMozfaEuCNfkuhYxmNJSMF3+ZvWe1G/MwiJMvejS1K8IOzJoRJ/KzE1tb6oRNxpzMP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55sWditpuwnpjGlbI6VBBv5sCDsJUxHBCnUpITbXutI=;
 b=i/UGmFAuQ1OKriRQKty+UhC0ETVkBR+tA7kiTYjg/+5QNiPrb19Zi9JMMDHGmhkm3iKEKz95SRSky38tsXL+H2B1ErP93W/bxtc4q2g0QhdKIHt+q0zrKJUXJxSr8pLqea7vJfrm/KMfjbaHykPutsdiQcCPN7m8MRrW3H4g9h9s/sWCD89NjV5QtqzaoNavuqkpTQ2P6q5E+MTCGn8XVxT7HKHVXX62gt8JnSMJoiU+HrhAD4RKGStAUcXb5u1k+HdrpfdKczqYo0K7lWo9fqcpX7agyPjS7Y8PoU75QZ62Z0lcPA+ZDPO2sTx7fOboY43iZVmIWhb+WZ/0AsKzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55sWditpuwnpjGlbI6VBBv5sCDsJUxHBCnUpITbXutI=;
 b=zUZZthHsHyBcIboL4C/fQJCvd9OVZFE/2cO8iE5R66zq6wscu2sKWplEJaXosofx6Ev+RKTZz4h8R2Olg515GKkR+UYeYrYE2bykDaPC/ovtljsyRXQ1WBlTpsiy+NXtjFKwqm848Z4JnjVlRkcjxYH50yFgyiEMeljdiwtOed4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5253.namprd10.prod.outlook.com
 (2603:10b6:408:12f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 05:34:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:34:30 +0000
Date:   Wed, 19 Jan 2022 08:34:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: pi433: validate max bit_rate based on
 modulation used
Message-ID: <20220119053410.GW1978@kadam>
References: <20220117055849.GA10644@mail.google.com>
 <20220117060220.GA11202@mail.google.com>
 <20220118135902.GH1951@kadam>
 <20220118193422.GA3155@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118193422.GA3155@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a0488c-c73c-45e2-3865-08d9db0d5d85
X-MS-TrafficTypeDiagnostic: BN0PR10MB5253:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5253060F23C1ED394AF734058E599@BN0PR10MB5253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixXTzoEVRMeDQE0Ll3gnRVrE7oCzIEEa56H6UjUCsB3MjRPTwO7rxhPydfd4V2FsQEp2HGDoHZjBetcVI8HjTaEHnksePAr0/QodfIbp5E3iZjT9mfkC/7tsU1Byr0wiI31YiWT8qyDGDfOVQ1+KvYkCB131JOLLKY8ujerMG/jZS9EbOyLHllV9eKjlb5N0QFEaUjr9uxjZnzDPGGfOOcSHYHbwbcnUtch21NvaOigbX3GO/GcjSzsgc4ns5dkixM65sETrArwki2zk3ftE6Helnjuamccgqm7vfkTQarTTFO4BDlKRVIIRNziXODCvJnW7d/trSGUZ+bkNRufsa8jR3wHojMc1wrKC+sDNRH6NxV8I21/k/IdmmlEPyhW9LEkbRhTD11V/wgyYXoSBRTcwGCXe7LHw3ih/XGCuWyl10zyK0vVlYXos8XG63KgIyOjJe0VNAwcvFB1YIrOE8QK6O4l62+ttdcyknthLAdazKNAxPoAaDavXegjyHYTnQVO+fw+LZyafpKVIIGCZK76sdJxffANc0ooVTbnSxzvURhmWeJowTySNvt3hN+8ZKyIrOeGGAiD0UZt4aX18JTvV5rArSv3CTy4VoZD1/aLmx9XOq0/+J7hwyljR4tTrJWV4Kn/EbfYs7sZgkCYm6lqF8/z+LmGxD7iYVNc/YKDrv6nN86/UfDP2rJLWXOHyAW6FglxW22IRGSeI2PAOQLB3lyNWb9EJwP2UbWFiMN6PpqIOHD1uHdcsuDqVdcHNoKxz6TnusHFJzMJKFGvfWNi6hisyepcbmMNZNeNEHnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(66556008)(66946007)(6666004)(38350700002)(2906002)(5660300002)(66476007)(6506007)(1076003)(6486002)(6512007)(9686003)(316002)(52116002)(26005)(83380400001)(33656002)(186003)(4326008)(44832011)(508600001)(8676002)(966005)(6916009)(8936002)(86362001)(33716001)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMKLC278/bkXdUtnOyJjHTf5/Cl3qLxYF3W03Iz7QtPalKrpNtMt0x4uEdKg?=
 =?us-ascii?Q?VKUFmmWzDFe87Hji1YUcMC0k56NuNxMdsAkiNHSmILPmAx49Q9I8gzdWfTbH?=
 =?us-ascii?Q?33BRGfiAPUctdJFPt2cgcHWUEYLRqLj+zXU4QMDbsVq3nfBI+SZ8LjEwUB3z?=
 =?us-ascii?Q?zVNjDDcluKLYX4EjwYP9ffQmIgbkcGIBYVHKPtvsUUEIB7AcQjNTokR6GnKo?=
 =?us-ascii?Q?qU5scqObYOWg7lw+GBw9AXKnhLQNG9VYZ/LlmR/2LvG17PZAQRcS6ET+Js3X?=
 =?us-ascii?Q?8RmyOwAc6EWeXTuupeXRy8j4H6OhOCp5ybJ7WoZcJBKHt74hw8vjVfWvEqwQ?=
 =?us-ascii?Q?UcF2XuVAa/1jjkpH7mKaU9tj/09eLUnu81KidCIE+VTxo3mlgTlPMFuwFW6y?=
 =?us-ascii?Q?ZrJVVqD8GqF0VgqBGhsTE+C0xbQjlFdOw/mxMPaPUtSYdLV6XNvkfjAnUI62?=
 =?us-ascii?Q?7KQ6RigRGcxMWPEj96Frkwq1idvyfDgLFBewHjfEGI4a2yejs/dPTSLc13k6?=
 =?us-ascii?Q?pjP8B6FUfk1qzn/TMOIxUaZxIGd8LIQbL34EfCWsyhWuLc+C1GXEMzvB/f6V?=
 =?us-ascii?Q?lQm8kD/HAdfIdqPj+qFkwRPL/gsF79Dz9JHklh+DYlutmNPw6blwhWZIobmr?=
 =?us-ascii?Q?wn/+OPI4f0xKBKaale8i2eKyymwUU92FRmDqimsuKXVn/79ppRpWkyg6fXZH?=
 =?us-ascii?Q?MhblW4FfDdGRRBw52CkP05lGi7RWczPkE4OKNJ4iklVegPgKOCTrK/wycyZy?=
 =?us-ascii?Q?F4H1llli24S4LjmqCxawn4Fmnw8EZwhO+1pdi7br2KqTmcV1EHoTDLj8WJLe?=
 =?us-ascii?Q?99/5100vqpCn3Ltvs4QbK/x5q91Ocbwa7nK6K9e275o4k1ix2p8Ab/j86leG?=
 =?us-ascii?Q?kwJ6pJCb1U3OjKapaPRjqgileYntd4R7fkA6/+o3k+7ydQfrvBl+wyMlsaVN?=
 =?us-ascii?Q?Px6sIAjgbRPFdN2NcGo02bTLQ+J0e15v/yaciyY8XRb5E1GgObLL+1O8vyeQ?=
 =?us-ascii?Q?FL3QMBjbRaHDO4rDUsEJkPGbjYrBJT7kOx1DAWA0Mjw8KyKRNLOgO+lt6UOD?=
 =?us-ascii?Q?x1ak6a7cdfRz9OH+biAJTOQ4WurtPABVSGTBIh05vaxVmWzl6fhT9ZhfbAAj?=
 =?us-ascii?Q?RRChaZ0+9El8pQk4rhUUJxKAHPq9BiRQAUUr2qB+cAhiuRaM4YBGPSNpuHmE?=
 =?us-ascii?Q?KtZjsrns0dfPNiA9rotdhDDexOhACN5DJQbav0YJTZFklujRPBRCH9ULs9d+?=
 =?us-ascii?Q?2pJLOomo6ChT740Jj3avxej/6fh2TCWy+zHKbZ7YlbW0G901qWTqafXTYcU/?=
 =?us-ascii?Q?NmeydMYCay8/fPrlmCNTIKL0q0nNe0dUt+w02+Yh0O8aRbnbuW/T9k3NLrs+?=
 =?us-ascii?Q?6QtCH/I3d9TTd0T+P3q9kFZ5nXv93Ooxl9b0zIDZHdHh7XhXI5j1I17V627Y?=
 =?us-ascii?Q?sTXs4rzQl3p8jsHPcGbzDl2/mSiozKIi0NzBbl/eqxd78DZnZ5TBBbloMA+d?=
 =?us-ascii?Q?9zrN8ETPDDpHuuYyPgwAB7bDynsab3eAf+3Qd3mhEIusRTyz5YZe0pyTHBpj?=
 =?us-ascii?Q?TIpYnn6jG6aSwVMiXvM2ouu63ZAMqUiCDZ40sb/N3lbsBT9rPWMUFYXFtapY?=
 =?us-ascii?Q?GHfxfcw9OJDhdAXdq4bNQLtp8anL7dQ4auIytKB5OxvdE8ziayWm/j9dM6HS?=
 =?us-ascii?Q?dQEB3UhRL701VZk6EiJS0dVKlEk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a0488c-c73c-45e2-3865-08d9db0d5d85
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:34:30.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WgbAS7MfeF8ccAggi6yb8PhDznQIv8s3VpYhGYsPzUQZjtAAe/Hz2nxW9jYnv2C/YFAZFFixIvdx/OnE8Xiki+jSZ6muJJjsXmrNqlG14U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5253
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190028
X-Proofpoint-GUID: v3HAgcLvFdq_hqG3NprAHH0pejedSA6r
X-Proofpoint-ORIG-GUID: v3HAgcLvFdq_hqG3NprAHH0pejedSA6r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:34:22AM +1300, Paulo Miguel Almeida wrote:
> On Tue, Jan 18, 2022 at 04:59:02PM +0300, Dan Carpenter wrote:
> > At the same time, this is a GCC warning so it will break the build.
> > 
> > Instead of applying this patch, I wish you would just make a note of it
> > in the drivers/staging/pi433/TODO file.  
> > 
> >     "Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can
> >      support bit rates up to 300kbps per the spec."
> 
> thanks for taking the time to review this patchset.
> 
> It makes sense to me. So essentially for this version of the patchset I
> would only validate OOK max bit rate as it fits within the u16 boundary
> of the current implementation, right?
> 
> Something akin to this:
> 
> // check input value
> if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
> 	dev_dbg(&spi->dev, "setBitRate: illegal input param");
> 	return -EINVAL;
> }

Actually, on further reflection, your patch is fine.  But please put a
note in the TODO that ->bit_rate needs to be changed to a u32.  Just
resend this patch series with that additional note in the TODO.

> 
> > 
> > But you're right that it's complicated to fix this because it's part of
> > the UAPI.  I think that the UAPI for pi433 is kind of garbage.  No one
> > like custom ioctls.  It would be better to use sysfs.  
> > ...
> > So my idea is that instead of modifying the custom ioctl then we can
> > just add a new sysfs file to set the bit_rate and all the other stuff.
> > Eventually we will delete the ioctl after all the users have updated to
> > the new userspace.
> > 
> 
> Using sysfs or even possibly configfs was one of the things I had in
> mind too. 
> 
> I started a similar discussion on how to change/remove ioctl:
> https://lore.kernel.org/kernelnewbies/YeVoAlv0ubKrmckV@kroah.com/T/#t 
> 
> The tldr;:
> 
> If there is a userspace tool that interfaces with char
> device and we can change it at the same time as the kernel code then we 
> can have a bit more flexibility on how to send/retrieve values to/from 
> the driver. If not then we would be required to keep the original ioctl
> compatibility even if we move to a different approach due to the
> impossibility of knowing whether or not someone is relying on that. :(
> 
> Everything leads me to believe that there isn't such userspace tool /
> lib so I emailed the original author just to be 100% sure that this is
> the case.

I don't know which is more appropriate sysfs or configfs.  I haven't
used configfs much and also I don't know much about pi433.

But I would encourage you to leave the ioctl as is.  There is no
advantage to the ioctl except backwards compatability.  This stuff can
all be done with sysfs.  It would be easier and more flexible going
forward.

regards,
dan carpenter
