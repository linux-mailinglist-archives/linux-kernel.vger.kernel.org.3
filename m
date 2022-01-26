Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E696349C720
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbiAZKJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:09:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50420 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239645AbiAZKJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:09:15 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9kQY7007703;
        Wed, 26 Jan 2022 10:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3HNRcKrUgwTKPVln13GaiJ+yUsAmzr9HxU5QL3lUyH4=;
 b=ne5Huf8MQGNCRm8HC6Ec56HtA/f5zt1cEueC+wbbDpzcuAA6oHQylhStlHy+WYWQlhUt
 kRsyRVAX5wMuPOWQgferlE1DoQ2xZIQcviUQAKsvm+Zcz9a15UxpCxtlsr2nknIrLfPh
 Gw2yczuZxsJF/24Q7QLTJc3yDBOQHtNYF6ocb8HzWBBxueEccpUGC47rLv26N2Gw+Tq9
 srDGwtjkrN50UF0mOy0TVxM0sNsWzTwsQFu0veGejmmEbrCWs52OeK5YVj9iJm7P+TWo
 ifmCW2AcTIGp5NeQehHoGaTFqPLfd2ICTWoN9pWOy7a6ZVMXj1flN+qfpKwJj/mojWfD nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s5q0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:09:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QA6S1n009825;
        Wed, 26 Jan 2022 10:09:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3drbcqr9vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZs5hORG/FSXy8Msy0me7ElftBe66xy7BJgn7d89OIX/K5jlFKuu/hp22Q8Uk4QaQS1bHoFq6yvil+HGa6PUNVLsRjDGbVPL2eQ2Js6kVj8gaM54ScGk+oVqhgq6ehvQsCjPK8jyjuhhQTIIcnZP/fNwln301hmniPi8Wp992RN819000gArrZKW3tzkV539npjrXHKsF416E6QVGVTmBune3SSGjv/uU9oOyebRA1JHZcZ1oZ6vDFJnM82lW1w0GZWFMNIg1noHusin1SIsb4gryjLLd4idGIvrANYKQByfFo2OAXd3j1p/k83MTXYdKOb8mSCmWkJiZLwlRAi9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HNRcKrUgwTKPVln13GaiJ+yUsAmzr9HxU5QL3lUyH4=;
 b=F22GyiEf07SPk6Ci9/WsC8QTnvkqkbrJz2KB+KRGo7LV1BY99QWAHXwTBDUR0m0cHySIvowqXgWzlWlM7WdQ6V7E1WEcFWYHdLaZJkeQQDSNem3qKvSFx3Nl5A+Whi7svKtNl4tU4eCo4KX9wqc6dZxfhJ5pFsZHWXIjiXUhsa/YNiWEiRU8TVdN1IDAoeZh+X1iV9xY6QKvfRh+UyGR6QyWaXkmDQPxT3N2L8qGvKopd4SbZZX54Jr9XdRWwemcreuOtg6B0eALjsLTUMPkWAmsDkYxpCWvDAOQOyuLZrbCTwiF+KrmG3xfOr91BK4Ix963DqxvTcMDuYJS7M/0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HNRcKrUgwTKPVln13GaiJ+yUsAmzr9HxU5QL3lUyH4=;
 b=H/MgB9qFAMA0vGYC0Hagxmfqo1gammtQLonEdlCKxw5iCY0HgALLb1QS6ejziHd3ElALR7DZ3rQWRnakFGsgB0PXHWFDW6d9sr4FxHfmcTvl1C6QjxwWM2h80pSeJtdPOXiCIxh4Psw6quNsdKm1SYurWiGG8i/40IsoAAS06Oc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2488.namprd10.prod.outlook.com
 (2603:10b6:a02:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 10:09:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 10:09:09 +0000
Date:   Wed, 26 Jan 2022 13:08:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 30/54] drivers/cxl/core/port.c:527
 decoder_populate_targets() warn: inconsistent returns
 '&cxld->target_lock.lock'.
Message-ID: <202201250055.R82EBqL1-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfecf206-01d2-4333-025b-08d9e0b3e491
X-MS-TrafficTypeDiagnostic: BYAPR10MB2488:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24886D34586BF0AAAE111CE18E209@BYAPR10MB2488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0EIrSZAe7+L/yurGD4q18Z3qj8jWBtR6UYC1W6uHgDr4Z+0Jt9o/ttHIpyORoxDMm2LWtatI6gpDZaB+E3NIo5hBmXVr23kWJX3Z/ymo34TGTessCr6/TBCG/Kcm1XqZwaev/vwSWAuKjoFOwrZVBw25S4LN9GnEcX8ImjlTjnA2eCI4qfF+oBiPIiRFuWWVSF78DyWWu4FJVn7ZSEQPzNbpLxTuBMupD4cJ8ADw/9NmPlNpd3sG3BAhZ8oF5ORJQJoR+66M1CSavRRIGyw5DLrRqbQmURppnHJZjsNThhnt7KNreGVR49J1W/WvGLNC11ZX4QOLrmbGVDHvPE6sdSVBojqMuD+QYIgWk0Ec2jmr08IlKwAnN0Sql/iZpwrH/jAgy0gVbr2QuhJeN982e0WuXqcEBcOH4/zLTw8owmo0FFPPlOuTGPYVzWXgLmmGpds7yXJTCAKxOZAiRWITY5keUuQgWC9RKTGGT+0+Ct05PqkclSaff5UlAhyRA5kMnRCyc1m43mCDQ0J1vNFJRZF3/DKmxmlA5Ui6IJR7mG5E3vVg45dD7zOFdWJC8YKPQ3gT+WQ/p+d6zzbAf0jYNZqNnRnmasQY9UWhyP+YDBj5LmxyZaq12frtYZT1tfNMve5UOd9k7QOczSuUAhTW1R6NLUp4JNynDqIiTbHx6gBNmhYb+OGGKw5OFdOukxvxXcVqTaKrSqOHul26CoRZ4HrsAt7K6mW77nfGNYY7aLpsTcV0eVnFuTDgC8ICXrCoflnV3CRCBPBz5SjUNmp8ar9P4Y0KVOvF6KhN84DCBiOnIYAvhT7+c7PRjXp3kZIhbrnTJctuaTHBAlBEE2mZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6486002)(66946007)(66476007)(6666004)(6916009)(66556008)(26005)(4326008)(86362001)(54906003)(36756003)(37006003)(6512007)(9686003)(38350700002)(5660300002)(38100700002)(83380400001)(186003)(1076003)(44832011)(508600001)(52116002)(8676002)(316002)(6506007)(8936002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aqm6DSsGXZvuYjh4PGorMW/CZH5sHaeBmHAf+9YiZELXvM5YJCP1WqVyAi+H?=
 =?us-ascii?Q?qQd5llaHO+iZG7gLpYnQFBuAILANvDQfhEsTcoFtRHZu7bawvi8qZnV825/8?=
 =?us-ascii?Q?GxpNlfFHa4e/CUecKArQI90iXbrkY3qCDHQJ/zKn5dbLbw5zoPSdAnOUxuJ6?=
 =?us-ascii?Q?EjlMsGtxCOdowHpVIPOlzxiOqf2WOuERTestz+sHGve3NGaWppQfsgapiRZb?=
 =?us-ascii?Q?szMBXyLDOas70z3nPSrkqpFYE28HH45uOqaHUqW3mx7GWLtTUaYRNkExPgq3?=
 =?us-ascii?Q?ovIkubLu875aW0YxEcacGI1ssR0HvkA9n+c1cF5mDtg/d2f4hrxSk57ZRidm?=
 =?us-ascii?Q?GVZNUJPE9M/uU5/OFQOhvNeFlEYb09HJTDdJgTgb04wrB9OE5uKfAwZKcZzv?=
 =?us-ascii?Q?yKIruk8GMjAc8THKrHx36mSF0T5rguBbs5TSw1fmJb9L3aSftnzKVYhgCbch?=
 =?us-ascii?Q?CprlxBVL9pdNvt9L5CvV2FHYiEBty+70jh69So5mzARSJGthBYc90Cjn7ijZ?=
 =?us-ascii?Q?zKsYqdjEgqRcjFH2nSR2ekTyPmAUmaT3e73Qh9lwvCnQDzBOsdRH5x8WNfwJ?=
 =?us-ascii?Q?LmzuSqMteM6I+qIeX+UStWctYPTNgfibRoHp/PhdfxIjIH3NCFveWGRDilJN?=
 =?us-ascii?Q?qjW5+5KtdyZbSTjkz+P5UirI1lNoD7dSAWWcfu8hGaAi4QiG4ob3hkLBvvMd?=
 =?us-ascii?Q?Ur7oJCUBWu2+2BE+ajLLSC/BknT9OqfxyTOLLwb/gefYLW4KgfrROzEszL3p?=
 =?us-ascii?Q?eniGU+uYG426CxV/x4DZegG7+zO4vy0MK8Dl91LNbQZUOjPgiVFVk1Hdsv4j?=
 =?us-ascii?Q?IC1s4Cwyz6UpHnRWdhTEublzMUr5zOreAOOMHEaIUKVwBl6Wk6oXgzleHwPJ?=
 =?us-ascii?Q?YxL0OrQs0ECY2B0vImmkvhHIXLUAZMj8i4N3nTPUHL8/oJxrJ9uAbTukN7pc?=
 =?us-ascii?Q?2VBHH/q2J4EvhXC/GpHpbnpkqaZsViJptLsFcu34IAV9TTnY8xgrHbv+L69z?=
 =?us-ascii?Q?UO2KRREpij67Q6WQSHlMstGyn8buoR+u7dhGY1N/gwEyZUJOZaznYEodGHCQ?=
 =?us-ascii?Q?TrrCRrM+0XFFZrSl6W950X1b59Dt/sAItVv68d9fppcYrTe+FR/MLmXZDdpp?=
 =?us-ascii?Q?0uhUWdwr1XCk+DqlavQKWFfLsDm5h+YyC4TCQNPdGTmqFfH/ybMJZXfHzPvP?=
 =?us-ascii?Q?Pi77jEf/qQie9GgA1lMIJIzbckQwrvBLt2my/6Y2++C3V+UI2FBf34ST/wMv?=
 =?us-ascii?Q?djs0OoFTAdp19CMdKfQNSxMZPuiZ7S6ErLyQWdt2h56nZybmHL8JJconLnTH?=
 =?us-ascii?Q?ih6IDZyQSNEFnPbw2S83VXg6I17Dyf28LsEuo0CXomtVlvAA7c3G7a2t3CrK?=
 =?us-ascii?Q?vVp91A9EeFOj48kSo+3vG00BWszhT1cdSb66/W9Zv5W+aVfiaB2X0tXNoguI?=
 =?us-ascii?Q?6Mi4sdinldIMHQb7mA8D537gBBfGVl8Whr3GSgAhbQybg7Nrh4RljT1EP9YW?=
 =?us-ascii?Q?pmNkt/I+HXWa+xUBnMJreUeJjp16+dj9KlkGdTCfLm2FRTMQdPW+woM9J+jP?=
 =?us-ascii?Q?cIZhJj0D2JPf2c5ANjQCC5mvNk3nYdE58WxQmaXeYoXn5E8vtPhYkMHJn31S?=
 =?us-ascii?Q?IRuZZGWkt6yLfC+bdasYJJ8Ya/rnNo8Y5R7TfbKBPMmvzIenaFzSn3Jul790?=
 =?us-ascii?Q?ba0Wl+GMrrftE+krdtMDnpJYtfE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfecf206-01d2-4333-025b-08d9e0b3e491
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:09:09.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyfCjAE8mocMwkMwGRIe1ns06XJFcgLOecpRss1u8T+8n5aKO7Ir+9bcS1iNT7qyN1+Zc2zoubYAwO0uu0Yrhr89oYusfJY1Zao9stCG8ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260059
X-Proofpoint-GUID: LipZsKiL99PVtrsueYTm0erRLHDJky9U
X-Proofpoint-ORIG-GUID: LipZsKiL99PVtrsueYTm0erRLHDJky9U
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   d0687472d5b56e2018b833723082c2717e96c074
commit: a5d24e660f35f16cfe30031dcbd7356f7a002398 [30/54] cxl/core/port: Use dedicated lock for decoder target list
config: s390-randconfig-m031-20220120 (https://download.01.org/0day-ci/archive/20220125/202201250055.R82EBqL1-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cxl/core/port.c:527 decoder_populate_targets() warn: inconsistent returns '&cxld->target_lock.lock'.

vim +527 drivers/cxl/core/port.c

48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  498  static int decoder_populate_targets(struct cxl_decoder *cxld,
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  499  				    struct cxl_port *port, int *target_map)
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  500  {
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  501  	int rc = 0, i;
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  502  
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  503  	if (!target_map)
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  504  		return 0;
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  505  
42c377a63d21df drivers/cxl/core/port.c Dan Williams 2022-01-05  506  	cxl_device_lock(&port->dev);
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  507  	if (list_empty(&port->dports)) {
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  508  		rc = -EINVAL;
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  509  		goto out_unlock;
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  510  	}
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  511  
a5d24e660f35f1 drivers/cxl/core/port.c Dan Williams 2022-01-21  512  	write_seqlock(&cxld->target_lock);

Lock

48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  513  	for (i = 0; i < cxld->nr_targets; i++) {
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  514  		struct cxl_dport *dport = find_dport(port, target_map[i]);
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  515  
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  516  		if (!dport) {
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  517  			rc = -ENXIO;
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  518  			goto out_unlock;

Missing write_sequnlock() on this path

a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  519  		}
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  520  		cxld->target[i] = dport;
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  521  	}
a5d24e660f35f1 drivers/cxl/core/port.c Dan Williams 2022-01-21  522  	write_sequnlock(&cxld->target_lock);
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  523  
48667f676189ec drivers/cxl/core/bus.c  Dan Williams 2021-09-21  524  out_unlock:
42c377a63d21df drivers/cxl/core/port.c Dan Williams 2022-01-05  525  	cxl_device_unlock(&port->dev);
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  526  
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08 @527  	return rc;
a5c25802168993 drivers/cxl/core/bus.c  Dan Williams 2021-09-08  528  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

