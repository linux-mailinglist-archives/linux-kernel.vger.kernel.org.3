Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9972A49FABB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbiA1NdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:33:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55354 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241847AbiA1Nc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:32:58 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SCwqwh031154;
        Fri, 28 Jan 2022 13:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=QNJlUGENsUD/zTje2tPVvMgKyA6VZYufFT+nTjgFKhQ=;
 b=rSJu2k94Rc+a7eG/rzMTZY+LDzhMkkOaowYvvoeEdLQU8dsacThZBj47qYbZsXJFeEfz
 W0IHXytLeO0jZw58g3ac+Ay8678aJ8d1v4tgWrrKCCZEPce2UYwpooMtzlQA4zzdDKEj
 njz0+MZzGHWub131PttH4ZHRMFm0OyU+Q4QdDDO1ONdI4fKXyofvH3UUDBvtoxO8yGl6
 MilDgB0UMpMAgYdWFcPlQjvBqgbJfu2mBZ8MbY/NacUbFatVY1eiBST7HtV8FPT16QrB
 dmy9NzLWZXZgeBfqZvGiVzlj/tFzFxljVzrDv107q4sc3aIk9Rv5w+Muuc3pM4L4T4+g vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvsj36ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 13:32:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SDFSEQ190053;
        Fri, 28 Jan 2022 13:32:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by aserp3030.oracle.com with ESMTP id 3dr7yns6nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 13:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMys3MNMkuD/OrUWPtqy4EIrVIUCOwyGqIShhX6E4GROkiY8EZ2EJWUBjp1uThQ0TtGmCpQBpMjROVu4gy1egLyrXOo7eXYVlWXNi1xcVOkIF4cc1DodpAS+Dna/EAV2ZCswBaEpHZQi2lv19ZKckq8ClB/tDgXm09+j1CUy6fZ2hP99q8/gB1P4r/KFJvwWBXUJCElkdNJod3bFCU7Ztf33/Zi5Nu8ZobuLEbdDh5DBcTrXvd3XqcRkZYtAVVo94cUEA0bVjWlBFAZAafipneeSViSO0vgjWOtRDBjubFE6DFWNamnwBwlxjNZec7GMnWhh8xcr3fkNT73cDrGOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNJlUGENsUD/zTje2tPVvMgKyA6VZYufFT+nTjgFKhQ=;
 b=k3rSF2hjGWT8LRfWCHWuIByG9vq2d9AuZjNtZc5GNFs9xdyvjJQI9kM/6D9/bB0w/SoZhi8jVRIzGmTkvVKb4e0D5BDPksEeHf06JVfg9YjLVXFSsAKo6rwIHmPk64bHbINFGDQ7SCUYsQoAcB3uU+S7ZWRGnuwGNCXjMyp6mXscSwmwRMk8l2jX/3R+Oy2kRphO0gLE7gLnqGjVXB6V66rpCKdiK4oXuuEOLecDtGBFFcrN46vHqcfbgxG7rzUbQfupSLRKy2h9fwLIymg4Ben55Uyc7vO/bN1ZEET/wE4N7LLytJafRXZMLetvbieQmQNLqfoPOEaSXfu7IXgGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNJlUGENsUD/zTje2tPVvMgKyA6VZYufFT+nTjgFKhQ=;
 b=w0X1yGrc+0G6iVwCxeBfrTifd+oAmZkK+kqiruNVPKPpQeNw3nUkhVukLdQnPYp7eHsGzOXn6RmVRoZQZwa9RUOA7zGHWLbTDiqZ2rXXzWlvnKX0Wd3GYxha64WQ0gIw3Cz+pFyWW+ZHXpFEdK9ILsk5L4RraBwmtOrgcEDyEN8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4925.namprd10.prod.outlook.com
 (2603:10b6:5:297::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 13:32:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 13:32:09 +0000
Date:   Fri, 28 Jan 2022 16:31:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: ops: fix signedness bug in snd_soc_put_volsw()
Message-ID: <20220128133147.GL1978@kadam>
References: <20220128112007.GA24806@kili>
 <YfPknO6si9CpotgS@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfPknO6si9CpotgS@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60a9ff27-86f7-4ddb-c283-08d9e262956e
X-MS-TrafficTypeDiagnostic: DS7PR10MB4925:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4925168686416F0562EDEEA18E229@DS7PR10MB4925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkT4TGWbWQCun+eKdaMYFMGrLP4NdjbUcNAXgvaaZ56LG1obvp7aJ8GTHNlYuIV2fN/+buT6JSaINdH4TL0u9RuHI2had2GJWQaYZS36R90TZ+74R9Z+nRkZcH/50ELe/z7JU/15U1ikMkrtSek40EB89nQ7zXfpRACHhXbHce2iisOTLxGwqNLXeYv8NFwewSkBpktncW4HRO3YicFeS0lMXqIOtTrnmx0URsb4YI3J4oVs2jiE4m3pup3Fe1zwTwej174yqsaqJOQvVa9hcWQHPePjRU3mj+TUye4fREoA1CGz7MVJcU9d7bt9oxE0D96OKrNqBOooD191rReSzzgqND5Ca6dBH7ikcPyIErjA1gb2XmaUQP1wWVRcI5eIcQLKQUN6wVblhQ9R3+fNt3Yalyjs468kyUTMPRT+xOedSGS2ympHaZwy1goceCLeeC66awbiPHt/zjpGgl1gUWTmpjKL4oZicj3m65Xt7ce9lTuIW5+vp4Dns7buuIhPSAclbq0f0Vx/1bpO5Y3lITlDKWw7Udn4ru/AJvkOoJCwBOhCYVngGI2v2Mv8lcZ3DSliG+guUfnr6oCsK72dNctisSacNppz/kOW9vq2JtHv7wwwbjsR8vaGK4BaLGukeFXFmyBOeMTTSHy4Y3Ie7Wj7oRP/tU7LhYakJjrethzKCm+i34qLcS+NaqJn5rmfrAQCvnCBo91IvqM9AKWRNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(33716001)(4326008)(83380400001)(86362001)(2906002)(4744005)(1076003)(186003)(8936002)(8676002)(44832011)(66556008)(66946007)(66476007)(508600001)(6486002)(54906003)(6666004)(5660300002)(38350700002)(52116002)(6506007)(316002)(38100700002)(33656002)(9686003)(6916009)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5GpUI+wmEdRkUUunnllOMKURZQNUq0YTKVmAEo6Jpm7Hb7gcSJWhmPVsJYg2?=
 =?us-ascii?Q?dtuI/g3xgjnP4yeFjgHOj/UokdUixj/8dEt4msW3oYQYnegqU7yZYiNZwVXX?=
 =?us-ascii?Q?RIg/g7ES1QRzfofh+bpwoIoh0Bi33FPxeE0zAwgRW71ykZNSAtBxgSbVGfSg?=
 =?us-ascii?Q?i/n13k9VQUolRDZ/T87cupKARFwibiouxc0igLCyo+4u0o4ZzqHW0ICJp70R?=
 =?us-ascii?Q?fyifZyV6OPvGOxsJlKSFtObacxZhq4CiqpguMf0jWLvljn2txjme/EbXBoH8?=
 =?us-ascii?Q?tFj+JC0FPktVMsF5jsHEgfvSVRtGRcvtP3meD7I6lzRmTmB0lqns1mT2Nhmt?=
 =?us-ascii?Q?unYyacENVPG7Qx6enBLEKZqmQqdlNJFjw7xyimk3HkgV1RtLAeRZvVTvASBY?=
 =?us-ascii?Q?0AJ5e8f+IBGt+j+huNrX5yJJFI7uvVpYtje1dBBvfZb7e2/COVqn7qX24hLB?=
 =?us-ascii?Q?16RDq63w3PhqY2TAQYNOnkJDQZD7vrttuaIlWVxkh73Mll/PwdLICiTZ1l8u?=
 =?us-ascii?Q?pWO6Cq1KeHkz0np89Guaku1A8N0sPF36dVdL52As2n08Jj9NwzMxxbBIs/dW?=
 =?us-ascii?Q?7BcC0Q7ulrxfAIV0thAb0MR688nG/gKOJJic4SCjnB/psT8k79vADf7mP75v?=
 =?us-ascii?Q?EYfJFbisgWe549qzABeT9/ea+L+l73aMtgaOv5Vh7m0hdksg42Up2ArWgZDK?=
 =?us-ascii?Q?Cu3cL6X2JW4oHh5YjGgSTd4C2UwlUBklr2ikywSkbOFuYsBbbwSQbXlUubDm?=
 =?us-ascii?Q?I7sLzNmylyEBrQybSdrVNWIO3Is49Sf8oX113TadjskBikFr0YFAgv+7vEIL?=
 =?us-ascii?Q?H/+shfu+TmxCHy2uq1BtOwUEgbHEkE/fThcKIrO7fHKVzKOjCz643ae2K4nc?=
 =?us-ascii?Q?z5DFQk2C8dTyXRHlvMPh9a17u5s8XbL+MjgoRvc4a4UySzZU6eO+FqY04gqr?=
 =?us-ascii?Q?zKrrUhwMTHp9HeuUNbe4sTZ9S6jNv6gBYbdHNKjywLDoKYff6cmtVmq2dLhW?=
 =?us-ascii?Q?SgOf7SzTQ5dtGhLVni1i14IdqKvVHvXZ59bviccuXzgLxFhyH+Myr6mIFdR5?=
 =?us-ascii?Q?2gr/RYsM1Gzd7QI89xl9+MS5cQc0m9wAF3ExeYpx4M4UhFcw9qriJ2MPbfiH?=
 =?us-ascii?Q?q4Hgg68Mf+l+k/CBFpXrPRZNExy+OyjXCEQD70x1eG3IXSHNSALRBV4kxEio?=
 =?us-ascii?Q?gdglihuh73yDC1oDPA3WnWbohMDZJVygssJhByFitXNJaaK7G9aAiCL4NMun?=
 =?us-ascii?Q?gMN9XpF60bo1oD+JILCLC5QTwcBM+ZtTemxn1cGax930PZCG+LzCpAfPe81Y?=
 =?us-ascii?Q?EsDLT+ZBqQ6WieSdjePo2OmEalYz+6fFzNZKvxeIBSmGk4ttxNEAmzqNoTYi?=
 =?us-ascii?Q?VQMeAeTEyRo67aoYvVN1jnPkajsY5/iN0hHeJDLrPPttS8L8lfhoV5a7Jusz?=
 =?us-ascii?Q?vtCBPl8Hlt+bIWtxdHQ5hxaOklRMrdkD3OerPQJas4l/jWgEHGjRcLddLiCT?=
 =?us-ascii?Q?LTZbf8RsXeLe/2Zah/U6Ux/xAqLhvDuElx8+3WxpH+0KhK1e15NuAdUkApQL?=
 =?us-ascii?Q?dV/uijh2h0zoJHZjcxUwMDrRK45DJWzioTYOxmTOlLcGVghMicgjT3Id2uZC?=
 =?us-ascii?Q?pldNksunjmHK1lfu8U8tiXVDtv9game3wH1fweqCAP4pgPOL/rn4XYldBDZI?=
 =?us-ascii?Q?mgGNweETFfPYNcYnvYsOZjUvW0Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a9ff27-86f7-4ddb-c283-08d9e262956e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 13:32:09.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVNzULFa4ranOAeu0G5rQZl1jLm+YdOgGEePYecmmO4rvewcY+Q5HfE19DcJIIgq9WJ0YQiD0JtsErmFoxvCD+pp/yrP1s01y5FqrUeUKh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280085
X-Proofpoint-ORIG-GUID: TxC1l1Yl-oCxpfRZemAC14o5gJhOK0t_
X-Proofpoint-GUID: TxC1l1Yl-oCxpfRZemAC14o5gJhOK0t_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:42:04PM +0000, Mark Brown wrote:
> On Fri, Jan 28, 2022 at 02:20:07PM +0300, Dan Carpenter wrote:
> > The "val" and "val2" variables need to signed for the checking to work
> > as intended.
> 
> This means that the helpers won't support controls that use the top bit
> of a 32 bit register.

Fine, I can delete the checks for negative instead (I'm surprised you
haven't already received a dozen bot emails about this).

I haven't been able to figure out where mc->min/max are set.  In
snd_soc_get_xr_sx() it checks whether "mc->min" is negative.

	if (min < 0 && val > max)
		val |= ~mask;

Is that a bug?  If mc->min is negative the math gets tricky.

regards,
dan carpenter

