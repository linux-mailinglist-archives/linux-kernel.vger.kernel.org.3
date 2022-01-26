Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A7749C49A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiAZHgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:36:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33368 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238007AbiAZHgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:36:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q4oNkA007704;
        Wed, 26 Jan 2022 07:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=vs2HUQxWTgx+DBO2EJMXHINQT+ZGYfLtbUBRShlDViw=;
 b=V9yDlGt8RDhz7zyzRbK2s/icAufn1+JijM7ZblFpjIPhghqA0awrYaRjEDF0gJWceQBO
 5/E9agVVaqtOjB7ccb2w7fYqP67O7xvtcdNfYRz0dQkOmbLipKyNogHl0ujvnGTweF4u
 SO6E1VD70ZdVfvicO2FWzubPVk7aUdvvpxQRattdBTGrQ9wD3tQZ8CCJZPsVVW8Rjj8O
 bETQ0qWXSf+yhIsq0Cmy2ehnwLIp/4q6Ek24f64ubVl/SwYUKhaOhKwTdJ2kliykS3nz
 IOkWdxiG7C/ciJJO/dRtqiKexQ1TCEqTwAPZJmlBG1qRqnAkFsB8WG3ZbqyRoRVL2P/p EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s5d6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 07:36:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q7GmZU007173;
        Wed, 26 Jan 2022 07:35:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by aserp3020.oracle.com with ESMTP id 3dtax7wcnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 07:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK5Ba3GG5+/0u5y7zKBIECym64jrUZVog/WoxEdIgj80V3EDla1779Z6TiNRsKvo/l0oAUz8ojUiNzlKcNqKjEjcZGVwAweXVCZEpoPzVhUM9zsm83xC8XWlkUlG+nkKzGKpOMGVoNfEjuxX/SBEUeRjMT1EsDamCXnZNIgI6x/UfXl2SU7GUfXQytj7zOGVDH0EXaIoJ7TAHK+0+cqxfSfk4zhSvunKUQUgUftKBAWOXZ6HLXTOBh7p8Vws9k/yuT9rnBTso6cCLXEzI28chzDusUGLeiu1PUM1KBBB3GAhkJvrLNI9UYhUc9nUZI3QNwxmJ6iZfa/jrLk+1Hd6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs2HUQxWTgx+DBO2EJMXHINQT+ZGYfLtbUBRShlDViw=;
 b=nw/E52lRiJB4nisgmvTBrj2lEZUXZHCQhBdkJ6UqsZ11oL5ZJHAoynSQKkb74uIXlk4iAkvz3Kq1qXrr5OVCurkn6taGnZJ1J91WT/4skcfI9tyj6D7FH0Yo3pqCdc83dRMvICu3SSpqWlzNDU3w0lNMgmcftNmgeM4VClHDnKgXL+/cqTMmk4MehNPhGW0ds6eedcOZZeTKek1TLUrmHUgToj+UTa8fkD2+XsFOixdwm5QmiFdgpdtlOI/HUmZVDJVF8QLDV2/Px9wj9rqR3s/puKyxVkURQWszLRK82QlOmQw95xKnMI0QS+rmHphvDZOc4RHVMgJ9OCHQf/gr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs2HUQxWTgx+DBO2EJMXHINQT+ZGYfLtbUBRShlDViw=;
 b=PQ0xcIJQw2xWMNc6WqEvAclQT+GuhaIE+y+ezsRhKpKh25pyG0fbo5T4xw0FhlFfr4Sfwh+jiyUoLYm5EXF6cMwueeZG9mhKshlCVQ1rwDpH6x6PunfKcQGX1Ns/h4RGOamiIaegIKOaTd0oZb04pRgAovZGVXfwmlIUsRi5GoE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3545.namprd10.prod.outlook.com
 (2603:10b6:5:17f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 07:35:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 07:35:57 +0000
Date:   Wed, 26 Jan 2022 10:35:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [ammarfaizi2-block:paulmck/linux-rcu/dev 80/83]
 kernel/rcu/srcutree.c:1426 srcu_torture_stats_print() error: buffer overflow
 'srcu_size_state_name' 10 <= 10
Message-ID: <202201261439.SqXHa4LN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: ATG4KQ5EX4EKBJRPMB3TYEJWTG2EM5AP
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: affbe3ab-9e21-4258-be83-08d9e09e7de1
X-MS-TrafficTypeDiagnostic: DM6PR10MB3545:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3545F31B200D70AE5D54AA3B8E209@DM6PR10MB3545.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:80;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWGZ9ZrXbw3RfYmvUY9XBFuZqTWoE3caXytFM8pmFI5T1zwt8gOhO+GkIUSuOkoeoBrbZ6srGMkJKEcoGPY1ATd8xqH9EPTX4HUmoJEx9v5aBsVYTk8WyVscFZSWuSET/L4AAozsuJN1basRVLCRMIPLHzdME6AheSRZyihMpQWKPp8kuOupU1xe34koWXunfe08Hf8oF0qQ6o5PjWrM2RKObxPpWwRIdJYUfI38bPebWwbOFqxiPHUzjFwbeCEq9vXluptgFDejeoRWmD6FLGutVolhF5QOpmwdiHiLZFQpVGouAHsI0TDbCm2ltqH5y7pFj/2Qs9kDgsZ9IoHVdImdqViFp4S2FvRtVeZHaoeC3saOKlIpNRjURfdQzLxbxn7+m2fhbFm9Z2SNxUarTmshLPoH0HjRBFN4SwadL4iQzFgB1tXnpu2TNvZgdZgzQtanUH9KX8tUzOFhc2BOfRYJtVNlBo8N8gxIFgRsSq+dECt0QeIYOa7o9dYSlkoKCchXWQaMaFpx/SEroIv9dmSGiJ8jbIF8ciLBpNnjMhKm89p392pGPbJVqIcZsy3Eo6VfRony1OGX008bd2dAxzjyzwUPhDD8VlUnpuY2IAWyiqlordkEc24NeiHl2+xSS6mfb7d2twE7VTek2I5JpBDLRajydcFFWp3Lzx/PS/zih0wXZPdOqoQve8igQ6f3zqfiC1Fky419Mxed/a6qcjCumY8eTeD7jNWxnN5hMxuM/LAOrIyRhe+no+JnHoaagnSGYrCZRXVdcjoZctC+Abthh0803+8ksazew7H5PNuOLWfpD5xEkuGxLMSkXewFc2Jy40KeHkaAGamTCAc3n83pNMNSow6j66o4n8INMaLGKC0bnz7ayRUS5/5nypx6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(1076003)(186003)(26005)(8676002)(5660300002)(8936002)(6916009)(508600001)(316002)(966005)(6486002)(86362001)(36756003)(9686003)(6506007)(38100700002)(6666004)(6512007)(4001150100001)(52116002)(66476007)(66556008)(83380400001)(4326008)(2906002)(38350700002)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eX0DZWA6SDIWhU0bYIZdTG1X8c/a3h4W0yuYBOAxZv1W/2KxvLbu/epL9OL8?=
 =?us-ascii?Q?oa434c85ANgfHzk85q7Sfy9QjIn/Zsid18OCVw7fk4gQyS5vTHUd6f/JYTpy?=
 =?us-ascii?Q?s+l8nSTD4C6S1wfryZR1wD9Rg31/RqeLqmCQY10+v65xrqUm3XtZz76ySaap?=
 =?us-ascii?Q?qimWeKv2fjPNTF3YHEpMzQu+0e8Vi7Qgu0l02khiOZyLRoLBweklenjNl1gD?=
 =?us-ascii?Q?FYdewohE18n3ErYJ+2WtWWmg0LYGz+UAlSBrJKybEOMjbELwX8vWExRm0UEs?=
 =?us-ascii?Q?X3AocdKJWKNhrZ6wlgQSIZksFk8zk9yCzxR04l6gJ752nluPtPjV8tRGYeQI?=
 =?us-ascii?Q?eMCV8Oprn5QwJNunm9DD0zWksDsWzRnI8mKgBcT25Rndif8J0flAgjwouBPv?=
 =?us-ascii?Q?wL8jO4lTVhY9TQggg797ss5Sv7wa4b6JnBe1XRpspVzfq5sfhTkuGxY7XCaP?=
 =?us-ascii?Q?9UR1gCu3c1vmlUKW65zyiCG7xV5rF6pLQfSrBzaJU0Yuj3p7BVR5UM9ab6OQ?=
 =?us-ascii?Q?LqFjFTYA6plaQA+LBBDxq9Nep5USp43v9oUpVDVmY52uYQbZyCMRvYiLBJyG?=
 =?us-ascii?Q?0bfLbAkAfTGzxPLbo+rfQSGksmLZXVzib0mXxYjIcjoLz2gChMaKzHQDhOOw?=
 =?us-ascii?Q?WHt94E3NLkueQbgGqyU5m9A/zYQ9eS+jcpNNypCp403SuTErrcel+dwDt3rm?=
 =?us-ascii?Q?eQVoyEdc+PB5X6RLPQXG+OtbH8i3tguDG5c7rGQVhTBhRpzYz93wc1fvR8iL?=
 =?us-ascii?Q?eZ2IweTT1Cwlke0JM7cZjeYR3/pjbPPnQcUNdz3wL8OsI8QnT3PwMlLi/XHG?=
 =?us-ascii?Q?riQeTgVJkrYd9+aRGwsUGB0St+vc9ZQwpcwcmJdEdT0ljvoxliApvYRbm3Xg?=
 =?us-ascii?Q?4UDylASyKqaNO2Q3ODiMYhM/uKGwd0d7tQ7bVVDLxuXHzCiPe+9dHMUaGCT9?=
 =?us-ascii?Q?dVSJ6pE0d0/xKtVSm2xgvnp7GRt9mmTFYLb5n5l/NYjBFGwcfn9HNER42Nyr?=
 =?us-ascii?Q?gldx3YIOWBf7NBja7T89TJljC9BkG2dGsMkvlCSgZhdv50F7CO3YkTTftPp1?=
 =?us-ascii?Q?PRux0RdaZ+X7rUhaOpk0oiAokgspr7LT0edlFt3CYxAq+atCmgrGdSEWzds1?=
 =?us-ascii?Q?kfPgH2pCmUukeXDKsh7Pg6YQXMW8e2/mds5LqPeVC06QKsiygXyjFWHzS8Wk?=
 =?us-ascii?Q?8a+zmJ4WWq9TX0gaw05r2Ktlr6rYVwxIKw5EpWAJxbFqgywDIBDrh9IP6D2+?=
 =?us-ascii?Q?B8i1O+gKNGYOAPtkpsmIyRUrM9rp9XedRVP/WAzuzdOjpdzwGErRSAUD1YzC?=
 =?us-ascii?Q?oyCl+RcLm/VBsmErjZbT6wj96a/8UbIX0BaReuJ9tYBcarQlJDawYIuFbvkA?=
 =?us-ascii?Q?m5JB/8Xn4bYkV5BsaJoACsNiXHwmBjG9PSN96VFqZABTbVM+16Ct2OOH7Ci5?=
 =?us-ascii?Q?J4FGOD5J985ZAs51s1MB5D5zq0lQICKqnODil/iQF2+SrAiQ9TC8wLwWmG7U?=
 =?us-ascii?Q?eZqRX1jZOwJZq/QicM+rjqMY5X7VBP/XGVWe//LabOGPr42hZU3u0s7UltoY?=
 =?us-ascii?Q?i4jITurl8E/kutTcTIN/gujUSCTyOifTZ2oSIv4T57DmQyluhwYEQCIOSg7N?=
 =?us-ascii?Q?TtRuUkx+6g3w6kdwtM3HyW/c54RMk/pxrCq2/yH8uyXSlatmOQUzJC11BT/9?=
 =?us-ascii?Q?Z8+8ilbXPEDA9n+sezobaCgEdNg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affbe3ab-9e21-4258-be83-08d9e09e7de1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 07:35:57.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/E4WKGVIpQoGbkwgUlTZ6vA8aQo2ftKfMHojdCdKeLCx7ZA7NMVrIFJ6NS6t2tsR2PAfkw7iTgyQ94/PffaJf1ogbjpDlVBkSNEVdhkHTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3545
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260039
X-Proofpoint-GUID: m6gKD5c46FQKuV7Axje-xWcmmHlKLy98
X-Proofpoint-ORIG-GUID: m6gKD5c46FQKuV7Axje-xWcmmHlKLy98
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block  paulmck/linux-rcu/dev
head:   1063f4620dd3242633b35487e08e159b803f717b
commit: 6d5d02daa5c0173da1c5430352dca9ab3f4fd8b5 [80/83] srcu: Make rcutorture dump the SRCU size state
config: x86_64-randconfig-m001-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261439.SqXHa4LN-lkp@intel.com/config )
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/rcu/srcutree.c:1426 srcu_torture_stats_print() error: buffer overflow 'srcu_size_state_name' 10 <= 10

vim +/srcu_size_state_name +1426 kernel/rcu/srcutree.c

aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1415  void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
115a1a5285664f Paul E. McKenney 2017-05-22  1416  {
115a1a5285664f Paul E. McKenney 2017-05-22  1417  	int cpu;
115a1a5285664f Paul E. McKenney 2017-05-22  1418  	int idx;
ac3748c6042660 Paul E. McKenney 2017-05-22  1419  	unsigned long s0 = 0, s1 = 0;
6d5d02daa5c017 Paul E. McKenney 2022-01-24  1420  	int ss_state = READ_ONCE(ssp->srcu_size_state);
6d5d02daa5c017 Paul E. McKenney 2022-01-24  1421  	int ss_state_idx = ss_state;
115a1a5285664f Paul E. McKenney 2017-05-22  1422  
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1423  	idx = ssp->srcu_idx & 0x1;
6d5d02daa5c017 Paul E. McKenney 2022-01-24  1424  	if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
6d5d02daa5c017 Paul E. McKenney 2022-01-24  1425  		ss_state_idx = ARRAY_SIZE(srcu_size_state_name);

This was supposed to be ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;

6d5d02daa5c017 Paul E. McKenney 2022-01-24 @1426  	pr_alert("%s%s Tree SRCU g%ld state %d (%s) per-CPU(idx=%d):",
6d5d02daa5c017 Paul E. McKenney 2022-01-24  1427  		 tt, tf, rcu_seq_current(&ssp->srcu_gp_seq), ss_state,
6d5d02daa5c017 Paul E. McKenney 2022-01-24  1428  		 srcu_size_state_name[ss_state_idx], idx);
115a1a5285664f Paul E. McKenney 2017-05-22  1429  	for_each_possible_cpu(cpu) {
115a1a5285664f Paul E. McKenney 2017-05-22  1430  		unsigned long l0, l1;
115a1a5285664f Paul E. McKenney 2017-05-22  1431  		unsigned long u0, u1;
115a1a5285664f Paul E. McKenney 2017-05-22  1432  		long c0, c1;
5ab07a8df4d6c9 Paul E. McKenney 2018-05-22  1433  		struct srcu_data *sdp;
115a1a5285664f Paul E. McKenney 2017-05-22  1434  
aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1435  		sdp = per_cpu_ptr(ssp->sda, cpu);
b68c6146512d92 Paul E. McKenney 2020-01-03  1436  		u0 = data_race(sdp->srcu_unlock_count[!idx]);
b68c6146512d92 Paul E. McKenney 2020-01-03  1437  		u1 = data_race(sdp->srcu_unlock_count[idx]);
115a1a5285664f Paul E. McKenney 2017-05-22  1438  
115a1a5285664f Paul E. McKenney 2017-05-22  1439  		/*
115a1a5285664f Paul E. McKenney 2017-05-22  1440  		 * Make sure that a lock is always counted if the corresponding
115a1a5285664f Paul E. McKenney 2017-05-22  1441  		 * unlock is counted.
115a1a5285664f Paul E. McKenney 2017-05-22  1442  		 */
115a1a5285664f Paul E. McKenney 2017-05-22  1443  		smp_rmb();
115a1a5285664f Paul E. McKenney 2017-05-22  1444  
b68c6146512d92 Paul E. McKenney 2020-01-03  1445  		l0 = data_race(sdp->srcu_lock_count[!idx]);
b68c6146512d92 Paul E. McKenney 2020-01-03  1446  		l1 = data_race(sdp->srcu_lock_count[idx]);
115a1a5285664f Paul E. McKenney 2017-05-22  1447  
115a1a5285664f Paul E. McKenney 2017-05-22  1448  		c0 = l0 - u0;
115a1a5285664f Paul E. McKenney 2017-05-22  1449  		c1 = l1 - u1;
7e210a653ec944 Paul E. McKenney 2019-06-28  1450  		pr_cont(" %d(%ld,%ld %c)",
7e210a653ec944 Paul E. McKenney 2019-06-28  1451  			cpu, c0, c1,
7e210a653ec944 Paul E. McKenney 2019-06-28  1452  			"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
ac3748c6042660 Paul E. McKenney 2017-05-22  1453  		s0 += c0;
ac3748c6042660 Paul E. McKenney 2017-05-22  1454  		s1 += c1;
115a1a5285664f Paul E. McKenney 2017-05-22  1455  	}
ac3748c6042660 Paul E. McKenney 2017-05-22  1456  	pr_cont(" T(%ld,%ld)\n", s0, s1);
e3ec4a4e8733d5 Paul E. McKenney 2022-01-24  1457  	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_ALLOC); // @@@
115a1a5285664f Paul E. McKenney 2017-05-22  1458  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

