Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BCD4934B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351638AbiASGAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:00:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53326 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351648AbiASF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:59:59 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J5na8B031897;
        Wed, 19 Jan 2022 05:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+7fwBIjCuDbaXxS/wUx5jag1/YdsZXHrebPVLgcAeYI=;
 b=bwJNCp3B1Y/tGU6l6gxafURtbnzYpooUErSW+poHs4k2jkcghacKk3oB33iWPk3oJORV
 ri403cIpAIR2HA/fdMr6EuQl3JKUpcF3DNHy/Q5TmlBCpI36YP/4ZAGWjGQ+CIRJjaQt
 Mf+SLMPfWlzJ5kxS3xB3TaAxPpvLtsK1ND2QViqdbXfQ64ubrsqp4b5D0GFlbJ3WOy5Q
 g9NajvNbxQPJZl6w56vUqTDJBGcOw/oQks3SyYPMnD1rWqFqfUOfDM+1G+F03NRweP4r
 Aqiqx5soy+1oIRu1Og9hljpSqLAYwKX6UYkxELJ4KwFX/CR6Ha7VrMIor/Hk6Rfvv/M+ Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vm3g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:59:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J5u4Lj059767;
        Wed, 19 Jan 2022 05:59:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3dkqqpse8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuk5FDUevO3iBTT9T5ar0Gem5GKr8f+NgAG6SRFcYJ6RD4hPoqkJTI/o1iMnTKbKLV0jCdtRxVSVu0NtykEpP/AfrFxm6wD2sTzVj0nE/vpqnYio8OfWyB6x01XMbj66mhhig03KnHDLAiMZ9p5RB9kTVC01Hnjr/L8tSdKw3bGzWN+BZt2hMw8bGBXLNESO6TlpMmcFH0VMRDpdegQ8CN5JxnuZSL0IJMJSjEi1iPQh1HiY3kyzfMe2VFGevB59HB6JxzrEMlqMzwWycvXRQ5xDNt+aboep9mak/ARkLPwa2eO4C537SWHev6ZV5TOSuV5rcIMNd5LQrbcRRL/ifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7fwBIjCuDbaXxS/wUx5jag1/YdsZXHrebPVLgcAeYI=;
 b=e04p3WhQ87NqLqwsXA3wJqeU5rnKsvowoRTaf6o/mQX4eEQ14toTyA8TqmX/ntceNq0q0gxzCURe16cH3kGezUfcGj3IYSKVl6YyUxmIcHlcaLjLTjlavVv9CANse8wqxHQ9BCipr//FbDXfGFD/WsIhHP/NSya3V9/YzUq8fAKgYakZru7we3klRpy67xMvdTRZ0fQeHNBL9iCfP+Ei9mNzyrgoqYaUuobK6B51b9BmWN2vNRYipddTZbsLvCnFYMcP+7JgCtWuQAFU8RfKthQjf22w9XedygxgUfzTj0EhQ4o10AN3sV4+RMb1B7zyy/+847NShLtnOncBc4RZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7fwBIjCuDbaXxS/wUx5jag1/YdsZXHrebPVLgcAeYI=;
 b=dY0iOvd8CPliAnpivKeq7JiaXQtikjunZ4CQWefZaUKaKgeDGXQk+mU8WuZ0zfLv6I1O4XD0nRJKLh9NOxos4F5f1kRl8H/vekmy0yVwrG7MJJ6lzybupaEVJncmVdsx5B8D1XPbQYjkRT/EVyyKCG6NvUuerjt40m+LLwLRtmk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2784.namprd10.prod.outlook.com
 (2603:10b6:805:d7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 05:59:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:59:43 +0000
Date:   Wed, 19 Jan 2022 08:59:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: use GFP_ATOMIC in
 dpcm_create_debugfs_state()
Message-ID: <20220119055922.GK1951@kadam>
References: <ed322b8821fa787907c1a4cce879564d1281b69d.1642331884.git.christophe.jaillet@wanadoo.fr>
 <s5hwniy21cl.wl-tiwai@suse.de>
 <bbe18490-fba4-9307-fe5f-b02c00433d07@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe18490-fba4-9307-fe5f-b02c00433d07@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac0f6e28-65ca-4506-8269-08d9db10e32f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2784:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2784B5F61D0400043AD227CE8E599@SN6PR10MB2784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EwaGDjsGtBO9PMQqAA/PVHZHQZqP5yukR0Ds9Pf1uPlWZVaspXYeoKgAxvV7rROIZqC8tW/6JUNkTH8gdXDhMLOuSZoRStzFKQjR9FWgR9Yu/9qEcsnXUi0ioYnMUqFVvmMXCThIhyg0f6dnpQATyKGpIM0aDzb263/f8g4UonZwZp7GSnx/gGtScZM+nk2WoXW84xpsA5Nru7O7oCsOgUCS9+IAgizRAJjwGRH65421Nxm69dhWEQtRec/jqCnCRUK90GZ/Eu2XuuxdwyqJY9aTjJSmWywpr6WcbIlSh+W6pq/pqKoZYUXSV706gWsM5dzjibpYTkaO7wfb3lGBWjkxUj6xS1QAL7R+7datE3k4BHZrqKkzmBU154/rdrspBDJfVbVPQ4VKngDleNhYHYMzpBTltjlimoAzBAButmVjdq+FQASqQBI+C6gf0Lf8Llvh6iUSnOD9oivoKqYf3h5QJNXK68wERFtOCJTbfiqVUWMnzykffJZ/Y3IoUxXQMscxZin6M/FUa+vFyGDdZuyGGBs2T2CsG09iDLy3vNJmAJEVNXprCtG8lBY032fXmMfDjLnMqYfgz/MmpnOrBaovt//1i7WxtbOPsElfTX+b2O5v57jXjdHHlWv22KVb+HLjtaQeKah+J81N9nFckhnm02/WOuYxMWGet83l4UEQXRt3hOKifJW238AW4h1teoZM24qkrClBLMrf/t18Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(186003)(83380400001)(5660300002)(2906002)(86362001)(54906003)(33716001)(316002)(38100700002)(7416002)(6486002)(33656002)(38350700002)(52116002)(8936002)(6666004)(4326008)(66556008)(6512007)(8676002)(44832011)(66476007)(53546011)(6506007)(66946007)(9686003)(26005)(508600001)(6916009)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+irAB+RZYA7EFNNW8Lzoy7HfveY5KFmILnCyIc9Lk1dTXS3pfha5QRpBSgD?=
 =?us-ascii?Q?cLXoU7p2WJDQUMlj1IEQ5hGMc4lag7srKvNmr5TJDNs4OKdc6kQL3Nq2dvgr?=
 =?us-ascii?Q?836Bl70KmUMSNyznXHh3QNM63cvCJqIxBoAOFtn8+H+2xjL8jrZ/zkAycqxJ?=
 =?us-ascii?Q?9/eVdlS8hB8SPt1BSK7M38iNhKTfQ+Cu8SHYHmtRsdOWhAkd3Ic/fHT57v+U?=
 =?us-ascii?Q?DmytnhKmh2Suye/JTOtfCCb+LcmKKnvxo9TI5QtyXiOSGsen00gjiJ+EElp1?=
 =?us-ascii?Q?MMiHqGxLms0L96DtiNiG9byuc6VPZkk8xV0WUnBu98DSN6aofuFrc6ZdUUFz?=
 =?us-ascii?Q?rpeppc0sNES54U13iesc+oldIaknyAaEkrIQ128NCLbIIU161c2ZBkyACkjr?=
 =?us-ascii?Q?RcgxmdspS3x/OQa+h2hQf3ywNPx3ChGygRtew5h0YcU3XXl3luxOQh1ErQBO?=
 =?us-ascii?Q?EzlXTyeN+1ITjJW45qKzvAXTIwxA3XvYmmdWnOFKI9iif6lCLeDBzvG2P0jR?=
 =?us-ascii?Q?F2vOUka9fHRZQ6ukD2wlypL9R7G7jbo8nVPfeX0K1U8K617xVYambSeOWor4?=
 =?us-ascii?Q?EKrqGNZtse1swTmYVed7af7wL9CLFNyRttm/a4MyoDwIfR4h1WqyZRNYvFwt?=
 =?us-ascii?Q?5n8BGxmTSVLOGtZHPvXiN9Tj1TBDbSp8hgZxmDcLag9MrX1uHzaNXlAJvs7P?=
 =?us-ascii?Q?tClxXXmvxykRc0toai6BtH8LhzCS11J1EyN7agAxsJw1U8zh06LI4JIp3d/5?=
 =?us-ascii?Q?kCcM7Vlgu/pbzM+S/vT7TwUh55DPegi256360uLOLaH3YSpkOfJNhDJYU6Sn?=
 =?us-ascii?Q?6udtDOY05jvp6XG8zwUJQM3w/ZPZRmuCT7cep7Mlw9GrbR2wrw7kV/cC1giQ?=
 =?us-ascii?Q?bKs5Fs+tL2+2cnjKO83wKFRSV+W2EeBz63GJIH7/H94CTbR0KedIlXTuK3rn?=
 =?us-ascii?Q?S1ft4gqzY56NY7l/AGrDmee7d4iTbOrbtbB5QpYRuvLoNuc7MGJ9hMg/6zvs?=
 =?us-ascii?Q?heaDp+37rwL5j6LRnlxCWvhGWYjFdngYGGg//Uc3KZjfIP8M4iYpEmUI+5Mt?=
 =?us-ascii?Q?BxEqnPT+IVHXVYJPK47v128ZarXU0EFF63vMC3Yd7X/vgQHMwMHmNRECo7v6?=
 =?us-ascii?Q?MjoL+fv7r70IV38iUp33CkOGCJDdiTUsjN3Lo6xp3j9KrLrTI2qvtfkFSKvx?=
 =?us-ascii?Q?xKbpZMVVuniFbu5IVZUA7bgqN+tTobQtJS4p33d9H0EUcMqALF+j3XFHHFCF?=
 =?us-ascii?Q?k1btGXxBT+SE3i5aRe5wTI9vfaGw2gGMxxWnWFHH/kwp7U6IfHAqUnFWNXIm?=
 =?us-ascii?Q?ubjb0tNXbo1m2FWo6f0iCCz4e+K0mWpqpBdcqnLaKn9Df9QV6JZvfE+551Fo?=
 =?us-ascii?Q?N/gFrDyORMDF2K5Spgi/kSxOz4SKVXdi/BXJTm50++JGlt+xI/PrQyAb2PUx?=
 =?us-ascii?Q?RyJLw65skRR2ce8MZJPMrJOl1hqU47Zb3+qIEEie5lV4xnBIw7/sZvID92uo?=
 =?us-ascii?Q?UbDlKfGEkmWD9Qe0sApj/7Z5mqBSMgsC1ICoVXIOLnsSIaaamXEi7lITS1N5?=
 =?us-ascii?Q?pCpbLeFmlJKTKKVQ1ZdxYoj4wxMrnL82AajzCmuG4/TPM0Mr+UQkdw/FTtZV?=
 =?us-ascii?Q?UJzpc08nLZLuGotNcgZisyrrNQAJI7ScZMtpWXOo2X8DT+9lenHiasVpwhLQ?=
 =?us-ascii?Q?/HhE2MJeE8vzsw8mTuGWpi055WM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0f6e28-65ca-4506-8269-08d9db10e32f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:59:43.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34KrumOtXeuJYvgMGRD9LeLO3fQKYpvGVJS2tN9HQl2GahaAK5hT+A8v7TKzQq8rYJiss4GTeo6AoHPt8JoLsbR6bQXlAWFQ3nJx7G9Of5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190031
X-Proofpoint-GUID: Oa3bYDuFnV8ygfNH6CNAH-b7xiyjmNGr
X-Proofpoint-ORIG-GUID: Oa3bYDuFnV8ygfNH6CNAH-b7xiyjmNGr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:11:42AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> On 1/17/22 2:49 AM, Takashi Iwai wrote:
> > On Sun, 16 Jan 2022 12:18:17 +0100,
> > Christophe JAILLET wrote:
> >>
> >> The commit below states that dpcm_be_connect() may be called from atomic
> >> context. It changes a GFP_KERNEL into a GFP_ATOMIC to deal with it.
> >>
> >> Another memory allocation is done in dpcm_create_debugfs_state() which is
> >> called by dpcm_be_connect(). Also use GFP_ATOMIC there to be consistent
> >> and be compliant with atomic context.
> >>
> >> Fixes: d8a9c6e1f676 ("ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >> Not clear to me how dpcm_be_connect() can be called from an atomic context,
> >> though. But better safe than sorry.
> > 
> > I don't think this no longer valid for the very latest code.
> > The commit b7898396f4bb dropped the spurious dpcm_lock spinlock, so
> > the code path you touched must be always sleepable.
> > 
> > Similarly, the commit d8a9c6e1f676 can be reverted now.
> 
> Can we really revert d8a9c6e1f676?
> 
> We did propagate the non-atomic FE property to the BE, but if both FE
> and BE are both atomic that constraint would be required, no?

I have a Smatch check for these now, so I reviewed this and came to the
same conclusions as Takashi.  If there is really a bug, let me know so
I can figure out where Smatch went wrong.

Unfortunately, I still have 64 sleeping in atomic warnings that I have
yet to triage.  It kind of takes a long time to look through the
warnings because of the long call trees involved.  Also Smatch the check
needs to be updated to warn about sleeping in IRQ context.

regards,
dan carpenter
