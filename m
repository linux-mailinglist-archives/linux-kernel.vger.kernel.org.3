Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F84A9AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359248AbiBDOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:15:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58218 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240322AbiBDOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:15:38 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214D59xg019825;
        Fri, 4 Feb 2022 14:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=HjLW61g/c/YOu8+6PzkECQs8UViMX2/vJbq+1P1dveI=;
 b=riC5BLQvoAFVfyHUoD9eHMnyrRJkRvMiD+nWO0D5cBNAPWBAAO39Hez43+Z6XKDVg/m8
 8bcq38236PrgwDwIs/SNmWF4Xni5QEA4YEPni2/nPe3/vMHcGryOeBRZo9np/KvH+u9E
 YOg+VXK4RPbOSc06ndGCONbCSqsrIVNazCHIGypQvd0KYl57QCdlgMAANT7t4KdoYxxe
 +Pi7yqw8W0+m2Tt1tSkwjusF8oBKu1DNChtcBh/vFFvPnx4PBZPPfDXFl3qkpW5seRTP
 sUE8PsZhXP74JkmNc0eLbzolQa8l0dbWujTYRaFJTTv1/w/d7ZgJ0rXcto9ZtvaTBpUP mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hetaumn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 14:15:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214E5pOO043421;
        Fri, 4 Feb 2022 14:15:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3dvumnj63j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 14:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcdI9Xm39UgV+BVPQY40NkKtvgHqVKgWETkj14v2SF/Y9Iqz4YrElYHAN8OYcKS3f0kC2fGDb8cvZvAmueuN9Eyt2IHqC3cmRxeMihImGoDC3mxgJbNPYpMNm1BK62Peo2B7jk5ZWUlfk6QIeCMflcjokT2xL2gb6UCKaBas6eZyfUcAVcFW0ZDqQYWb9Dn5hAe1CamV6S+th7qhiENkOX+T1MqSz3kPNaOywMZrrMVOdJtdd7hEqlS0wr1F5oUIwWP8mfsRaRY91HQlayAib8D5aXN2/zxzvwgQA7Oo63U3+3b+8khYhoKu4MNWs09vaAnIf67LUp4dKPqRox7vDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D49y1WuS6PaFa/aXHkA8JO9Ju36R3HbDoDKq5ZwM+Lk=;
 b=Z6sqhEebjaSsHlEQgf61pepUdUpaQFoFfmiirfGd4Xo8GzAwtjqvZ142wdOhXSyev9sP69GTEOl5XmWHechphSRYmmz6U4fGYfgfUUbjHeSdoUDbP1gQEJQN0PkEsWz4pePn4fEwloauIE1twKwk1v4Wykxts7DGsQ7xwZutCoXCri7IWwu0gfpL10oQoj7KA1XqkmJLLli0AkYY2+LU/lKNJTrkQEOUS5m/bBlxEHxtHjo97rM52bHyfq/kVl5g0ZC4tvAVjSj4M8MV5T88VAe0eENTjZ3xswaDxmEqWGR4kmCicAc5rmWl15bRZ1tBe04/1upOpjTAQsdpPX06Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D49y1WuS6PaFa/aXHkA8JO9Ju36R3HbDoDKq5ZwM+Lk=;
 b=lmexQHli6/0WzxUCa7ArUl7j2hM8xps7C11xfgZwvU1suVgPLnDiFfxtKsmRcEut9BjSocthvL+S1tqrKUcis24Kbuv7Wu2Uj345YNMYpOzC1MR1zIQlVeZQcumFEYilkDG4iJh+MnMiIz0S4B7SAeQAq5odrs0HZg1X7Eds7XI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5600.namprd10.prod.outlook.com
 (2603:10b6:a03:3dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 14:15:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 14:15:16 +0000
Date:   Fri, 4 Feb 2022 17:14:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [kbuild] arch/powerpc/net/bpf_jit_comp.c:225
 bpf_int_jit_compile() error: uninitialized symbol 'pass'.
Message-ID: <20220204141459.GJ1978@kadam>
References: <202202040124.7MMKaXXV-lkp@intel.com>
 <45bd66d4-14b8-bdb0-7d6c-096d6d7cddb6@csgroup.eu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45bd66d4-14b8-bdb0-7d6c-096d6d7cddb6@csgroup.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d67fe0-7f45-453c-079e-08d9e7e8c487
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5600:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB560025120A7AAF26B3C6234C8E299@SJ0PR10MB5600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JkUPJ31hzW1xXNY7XN0cX8DyI2SXkWGW/i6JTpXu4ofOSkys+Emc8XA0YfZqkLJ196LVGquHxG8W/gKuTdGlNg2/rM45Fx+9R0Hsagcz+ARSuQbAx+rGxo4+SS/hbVwnpWIRLgeFGyP/VMuhuTYV5o3k6K98P5aLZX92UKgsRWVnQJdioDkfNVuKWEuOzSIy/jF5csT8O8bnQ4dtnyJ1GKOtvYZG2Ii5LvfZ6mqQ5FAA3dvw6MRj0caJViilvzQZrKds/cIh2+WJT09peWnIqWynFubzMe/ttmrxc0WwoYQ2q0RVUPYz4KjH9MzVL6WZ9T/gO6bN9Mt0ZhiKD+sj7L8Dfkk/rWrvFrSvRQ88mjJa7PHeRRNpY2gt6Knr+3ORpHg27jshDbb+dKjiVIyLxb4kUJhTl9xG4/uCxjtYxqMgMJASJ8UXx7tIDl7f/er1u68lYzhL9O1DcSrNSUUq8hOQa10XlAaqR3fQaTg4M+qPQG5oN4sDeaj1p7Vifi/WOsmnihptUVQsYdpqwm2Tzyxku6nIANSM/T2wT1ybF2NcOyCZ+uJX+bG5hhyWB/X9BxHm+qsrlXw/v6AuMqNYVreYZyKPAT9MzD6QNBo1EuoGZ5M/ni94rFqcb7eAkvu/Cwrdr88T+DwvWHQbHwOLB+XUoEP3nVRjWEnN93MRwC63kPY3vCPRj+ZaA94k8jmgr7AszCg2yFn0K9FKfqlDOYiofZ09pOYwBnf4yflzKEV4BEAXxvOSTRQda+4+flNc2htW6bi/YfUhJ6RhIGUrz5bwG1MDrw9UWinXKbpP1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(33716001)(1076003)(83380400001)(186003)(66574015)(38350700002)(38100700002)(33656002)(86362001)(6486002)(966005)(8936002)(8676002)(4326008)(66476007)(2906002)(508600001)(66556008)(6916009)(316002)(54906003)(9686003)(66946007)(6512007)(4744005)(44832011)(5660300002)(6506007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4JnG8uRdRYyScjj/xPORNuhOc6f3k/MYJEE5CJqngevN50dRIuxNYB5RM2?=
 =?iso-8859-1?Q?h4SU/MdBIjJhC9LReobplNe//TCawYnQf5pgzNhYG7G/tXZ+To8tf8MXl3?=
 =?iso-8859-1?Q?/FpNUJ+TZzOOyesiGvX+dsG0InPmfQayJXNRU3lufIZiFoRCCW97l2q/he?=
 =?iso-8859-1?Q?bpv4UUxJlKmCdvOZuiBLOo1XUhaf+Qomu4qPAxOio68vlpjC9kIApEjMif?=
 =?iso-8859-1?Q?LWq5lBB/Z6tJP/LCfD5X5V+EBLH3K4ysdrKFj0CpFUOSXwr+K4Ze4enm8X?=
 =?iso-8859-1?Q?LDyJC4f4mAfrV6cyRp4dxaln2D+ICVozSOkuN4WdynL9Y55kgcwdvTC0VC?=
 =?iso-8859-1?Q?rLzjqntu0EdGnN7bIel9fkm52rJqQul+lxwPelTyLEXN2dDopct6XPLDcT?=
 =?iso-8859-1?Q?yfBkFcf1xNTV20cr01kW1vI/Jrlx9oVzmfmAslj5/japhSnD+BGIVHRc4g?=
 =?iso-8859-1?Q?y9115PohFMBHHa/1Hsw61P8TEnuX0F/EyVG8D36PG91wI00M2yhEA1gskC?=
 =?iso-8859-1?Q?QebGLegoSffSdtbJx61AgWgdtlyv/gd2VTtPzYKrS6cPtvBzIDxqY/15Jz?=
 =?iso-8859-1?Q?dycoK5edC0f3noyeCcGpba6/H6rNAAhSBpEl+VpAB1bQuieq16jOe1qoLf?=
 =?iso-8859-1?Q?rNxlZ4qN7N5nWyHpwoBW7KA6DFbJy3CtUMgP885UOSspFHwctAgTrIgbKL?=
 =?iso-8859-1?Q?GTUQAy9+NC3Hzhz6YErfB8VZ5YaP9vwnWwfjhcFegCAaF67dtQvJbBJCLf?=
 =?iso-8859-1?Q?luoZ3c0raYGoStjaym7z7ZmF52+42TpPhghNSAAYL0kdEJzig2gmMBHmTz?=
 =?iso-8859-1?Q?YV7swwUAqfk/xXMUOaQU0eZ2tNjhnmYY1Oe4lrQh47De4G+fGHqlrmvzgY?=
 =?iso-8859-1?Q?6Sk4zKXcebP3FUw7dBzqzCtgwH97jZJm9+ECq6ErxPiCEPYjhKtoAeG+P+?=
 =?iso-8859-1?Q?LngpGp8omt2qoBcKMxucs9t67thBScXEKbJf1T4n3bhJt3Yf5TkiSqTpk7?=
 =?iso-8859-1?Q?r3REEbUHmx+Ovr2f6tx0mCyVc1Aizy90SL4794DRnaRJ1aF/UF3sqnzqkt?=
 =?iso-8859-1?Q?9G2peMsNWKWJwcW0EjDK37CV7XiWsKAX1zj26YUMoOFjrhlbvnypg5IorI?=
 =?iso-8859-1?Q?NOqPNzC/yohAfCH0LCLKjwtpcvrWwAXX8cTjcBb8FRyfZLEcF+I85sGtEz?=
 =?iso-8859-1?Q?kZOIR8C8HHeLlKRJ+TxCYyzpB+PgVuMMgt6n4CI+5lzxcqFLvF9c561UbA?=
 =?iso-8859-1?Q?Ap4jjIxj3aVc49QD7bVfaqrpdNPGiJeZvoiQT6AGEMBGn25/IgWYFI5PNu?=
 =?iso-8859-1?Q?z1uEio5j5eRwpHqid1SrZtgwGxOyr2Kv5Cmh5GCGepfPw/toZwueW1R06Z?=
 =?iso-8859-1?Q?lRZnfAadZagxVAUUJ9OBm0ckkCkJa4a8g5bXESmPCuX2O3J0ZRDuYDUTO4?=
 =?iso-8859-1?Q?ZfDqS2VNiVTGytU3jOercPmEaxLy7ZNVjK8DqqF69q/whYg+8WjukcRYZx?=
 =?iso-8859-1?Q?iBtyfPVbcXk/DIWv4jASyHhqJWwqIc38aFi3QyniCt1/wzHar6hax93jgJ?=
 =?iso-8859-1?Q?EjWSvMy5zSf3LjWQSdUc1C4UbzclSso+TC5C7LXEjrxI0Xnh+w88hTzYxg?=
 =?iso-8859-1?Q?A0aOI6PSV4howeWo43EMRGPZSrrBrPkqxo8B6qhEfAOo/ru0yzwBtTwRrm?=
 =?iso-8859-1?Q?fbU5hTYLVBuA6FoYTqJvkJLA9NcZqfL0DMO+2o+Ubcrc7wD9Dlf1MP+avw?=
 =?iso-8859-1?Q?WN3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d67fe0-7f45-453c-079e-08d9e7e8c487
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 14:15:16.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCmarpLVF2B8ZnzKrOtin4YTP7IZMsgan1TcAOf6BGLvkfRYaJ8ZRq/Q2uuxU4pKDhBhM9qvIUcT8Ci8nlSYoU/LVm5ofsh5q2Q7hfTIcNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040080
X-Proofpoint-ORIG-GUID: Dyw5ZiVl1FWelzIXtZTo8N-ApPE91zNo
X-Proofpoint-GUID: Dyw5ZiVl1FWelzIXtZTo8N-ApPE91zNo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 01:18:24PM +0000, Christophe Leroy wrote:
> Hi Dan,
> 
> Le 04/02/2022 à 11:37, Dan Carpenter a écrit :
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
> > head:   88808fbbead481aedb46640a5ace69c58287f56a
> > commit: 51c66ad849a703d9bbfd7704c941827aed0fd9fd powerpc/bpf: Implement extended BPF on PPC32
> 
> As far as I can see, it's been there long before that.
> 
> Seems it comes from 025dceb0fab3 ("bpf: powerpc64: optimize JIT passes 
> for bpf function calls")

These emails are auto generated by bot.  I just look over the email and
verify it looks reasonable.  Moving the code around sometimes makes it
show up as a new bug.  Also changes to the Kconfig file can affect which
code is checked.

The commit that you mention does not generate a warning.  The warning
started in commit 025dceb0fab3 ("bpf: powerpc64: optimize JIT passes for
bpf function calls").

regards,
dan carpenter

