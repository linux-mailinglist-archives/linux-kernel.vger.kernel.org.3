Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06604D4207
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiCJHvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiCJHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:51:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5312D204
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:50:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A79x7m002635;
        Thu, 10 Mar 2022 07:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=V8o7KCpI2j86f9UkFC/kpVtDlssxBFOs3qSS/KO720A=;
 b=mVpUkDhwBZqACX1RV1Pf0OMSPU76XvoBgs7ZJWxd+1DKv7fRsdSAYmqzMlLipSfM0Q0T
 FRh6bTAxLfxrpBKJlL1xTZHHtIbp2CvtvmiWmdk437qENOwjLJk51kNpqEXnVZqE0ZCr
 SUTXmMGvlzgH3Y7T7EPXRZDWYIeVv1r0X8ZC/zt4CAsknbOquVv+dB6i5jlvk48svULX
 hDVN9AhllTExCMe0W+bhyYWsyXCXzXZCmVA/9QFLW1llKgAATTW3JzCMxo3CxIjaogq4
 NbjTJlccHF6j8gLfJJWkN6bWV9P1yyA0ZUEnuHyoqD3K+nb6ANgnuyvifQh13OZBqYWk cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cm6jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 07:49:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A7l0uS011444;
        Thu, 10 Mar 2022 07:49:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3ekvywhaus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 07:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7PCCz53cIjaW82fcCHjmSkQjJnm9GJeG5A3g8F2mWrBcHKpBQol06yXY6KMGrU9ZLQJ4iI9IozciNT1o3vj2SZTurGZs4TxwoIgvFEWeRJie52EbvUfN+SDEQrPee5JqVhEGEQxkr581OfYRHUXF6FaCg9NZ0YU5ZsX5QXdKWHcvXeGQEDz2k/DM4yFDPZvditwBAwuHFs0H93I9WNhHIqSYpVdI5qARO7xVpX6QG/OHbzc6Z5dZsLUq7iCXYD+AKxy8W7i/MXZDXd+q7cI0Uwrpv8IOcV3eOlFhP9+Xyne8saDCHBnVa4L3ak8Ojn5KhQNgeUB2qFSPeqrH373FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlNWAUr10tjy6onva3VFDCPOSI/xa+hLHKpQv5qp1dI=;
 b=GR0fv9uKRiLplCRbiArZ6b9Rg0aRuORb9VmRsw2ZC/bDghpHrg+8odQlq8MmNlDtq5ntTUyAeQ2be+IZWrgLtoxHBsoNiSWDvKrhaP31Nr3+y+G2KDuRh6+Y5Kb/Lc61x1F5iGIurWKApEbosfEyUYvy5Kv4e3hkrSi0P1dUKDL2CoHi2kbpzvUvkJSH8lOcF0TOEYoL7ZcCf8Bn1mEc3JaMWpG9Y/FRb5Oo4yULmOS2VDbaQQ6ia0GLv8OjjbWi0WsTfDRLAsSaj76TdihoyU9PBhzxAkGc0nmmgL+84E5vEDpJNbrtnOhFhSujdu1lEedgz1TPmIMoaSllTUiq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlNWAUr10tjy6onva3VFDCPOSI/xa+hLHKpQv5qp1dI=;
 b=EpRMCD++/wYpwtKVkqLDDNg+3BKroOguThEzEmbaslmDsZenkqFSp9d2iSrDnh/opMuGzMIs+h5zDn4KSB2kGoJhsCw/OuA4JqiGowdCnudP/yvWgTzqjSCEhFum2nUPKB5oAvcs8gecWmSoBghnsPMWFbi64ig0XBD0d4pxaKo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2143.namprd10.prod.outlook.com
 (2603:10b6:301:36::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.23; Thu, 10 Mar
 2022 07:49:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 07:49:28 +0000
Date:   Thu, 10 Mar 2022 10:49:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        =?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/chelsio/cxgb4/sge.c:2566
 cxgb4_ethofld_send_flowc() warn: missing error code 'ret'
Message-ID: <202203092354.8QMmp2o7-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59eb875f-4388-40f3-6b47-08da026a80f4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2143:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2143011565597843DCA66A318E0B9@MWHPR1001MB2143.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1RCxQJRj18VCPDOHnR7BAVZz8trPUghHjnYcW0Ue5zt+xwmYdDQdMLeyQj/R6tnjGAnaLHEID0/eW+WAJ1Nmcp15cw2pSy5cOi0YTHg6WQ7v1/KhugrVqoTh3Vv4YUUy7doYKN3X7FkfLKUYJY57zdbd9s+Uh+fwVKpz37Bh0xYphutSgXvTyEkucin6VPxN04BuWpgbjSrffKdstl5yN8pVU/+4EZPXQUPsNljUSIjdALoPg8oYayR9X/DVA/VOis/oWqNMZtieIxMJKMDkXYXb5p1ZaapoYtd8Q9Pr9KZ5tn35vzf24TV5CXyVbVFag3SoNvT9TI5GsZZSv5pKNSB03EORJUuXNQotbjpfZUawuWIrpmqm9GDOwczDHQRslJalYSO4Psr8arQ2g0mGt8pK3+7GZqKrj1zwfh3KaJPe0C8Jpci0uU16U7ZJwGIwV7KwPq1WGIm25S/84fFzczAY9qnkqWNXPFZGNoT39jqRi5xHBQ7NMue8OfIZSqKVzDb14Nk9TGU9AtwyAqAsmVMsVEvh7v+GbDDBacLw9JdcezpBY5oRvNeVNpAScrvLY/+qo3SdONh01g7rHShZ+yaW5JcoyQQudVat43dJgk5Qy8wkfasvvJYltVGiMvAvf1FOTuXSc4Uo6l1APlZEqr3yT2V8l5PHOs2EhnfBQfs7iBybiOc6qXFIKHW/LvC+e/gjAdVm7RNhUcN0bcFokRnxo2y48sP6dCYZYFxZHQ+INB427kJv99/LwiUGgqd8v6lQVRcGzH0ikOgEz3mJVSMWqmSHHUMESuMe0q+381KtqBXTaYvu63i/NAL8Qs5DiWlAcq0yMAOSk3e+sq9LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(66946007)(66476007)(316002)(8676002)(38100700002)(6916009)(38350700002)(508600001)(52116002)(966005)(6512007)(9686003)(1076003)(4326008)(2906002)(6486002)(83380400001)(8936002)(5660300002)(86362001)(44832011)(186003)(36756003)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2s1yfPSEIvRnYMFCLeyGLgCUgB+6VJ37Bq2SEufDRyCn65RHYsvOz9mZIW?=
 =?iso-8859-1?Q?K/PiuB8rF2RWWpfKYG76phpB8xlEOF/03eMb7tsHQKkdGydAjUujgszxPD?=
 =?iso-8859-1?Q?WxgCbiZD/QpWSZS+cxLfdPVxzzvnitwHpyIzh9bEjYWrArzmZK7ZMr3fr6?=
 =?iso-8859-1?Q?cZd07r4At4jp89KTiZYr6bilPm5deP9oYPSs3XxtoFcNX+GDTLwhogeRxm?=
 =?iso-8859-1?Q?321gL1032jF7zoPWa3vr8TzoMJarmzIoi5zBHUifHL0a1zZdUOkMw12rTg?=
 =?iso-8859-1?Q?LHwMCAo0U3rrxVrRTXSoWSsc1EFNrJMcaX81m+NT4DBmOoqEJR0GreeWbp?=
 =?iso-8859-1?Q?xRS4KKU8PiT7MbFgfy4hIjcYZ1OnYiGi/14syHzW2a58Y2DAiRA6BI9hQ3?=
 =?iso-8859-1?Q?vflcN00kyy+95WOKGwnNuL92sQTu3gI1KUwCeDN2CsJt9MEJsqNFGMq/eq?=
 =?iso-8859-1?Q?ETEbIaqT4UaTfR837MrOxP4PaZQTgCgf3cI7O+ecgpGoinFjiGqMJtLIWB?=
 =?iso-8859-1?Q?TBEslVAuUWZAnsqcIyjs/ttAYFhN9LWJDOYUc5Fq72dwIIGzAwpw8reuoB?=
 =?iso-8859-1?Q?ysxJbNvd2T7FgWrxpwM9ON5HfyeTR9A8Lj34/rGxqSOLGdzAhOAh3Rhg8+?=
 =?iso-8859-1?Q?wUL/9viQjvCGW3fJCwqPiVxJFP7PtJx0fNOjb29Y1MuwybuzsU1Vb0O6fc?=
 =?iso-8859-1?Q?wVaCGDRRsd9lHlCaDlPgHllcwDSYs/TsJEqrPAynkaRB34XxtuLZh9K98y?=
 =?iso-8859-1?Q?4FhOXkFi2WfTC3HttksZDegkmzLl0x4O7kl03tpp/EKv1KIx5To0TsIGqf?=
 =?iso-8859-1?Q?+A1ieuvWqEY8s6Wrhi34WIXRpt8egyw6UXqHJ7uFOfUIBKNp1zhxu49S+Z?=
 =?iso-8859-1?Q?RIm7vvd7umFoXubivw0r2P3McauSNNiFJjR+M750Zn1ZVRn/92v3lyQSfy?=
 =?iso-8859-1?Q?SKPuqHO1TZuBGg7uitaT3JpqjkufJfPQX9J6mXHn4sa0apWrYuPD7Yms04?=
 =?iso-8859-1?Q?Pnj5WffrUGrjfMD98fM0fpaW5dtZm0dJLC46/9tsFchUfaHKg/MbDkpWKU?=
 =?iso-8859-1?Q?7vWgJGRYxz7LAA3hw5rzWENjhIQpZuc38ZfeehE0ZRqh/vl0D7xZs90J00?=
 =?iso-8859-1?Q?qLv9XE6OodtmffbHui1QuTbCGowbfMepvyYqvrU31LBfauHQP3BjLQ3cqQ?=
 =?iso-8859-1?Q?E7bqnlWxNrpFrnJkrCZGw2+1zBRdjavwl4cvBGUJtwfrkAn5g/LwvO7B8p?=
 =?iso-8859-1?Q?bP9VyNB2+dKcnsNEzri1S40TRx1Goaw6c3wtOtuBJ1xAK4O+EgfrDO5mwU?=
 =?iso-8859-1?Q?ZRg9ChHRGrt5Qt7QiGtNfFo4MLUeF8sz2zs+inu/TXnn1wGk+D9bxkx+nu?=
 =?iso-8859-1?Q?+qk+0wskttB4FZCtsDHokMKmTv2RnoM+dwwJ8vUAw8rnp8su44pd5wFwG7?=
 =?iso-8859-1?Q?8ctQoPwPBE1Q/LdouS/JIOjcds+5Q3hqJRnaFocE0ubyYEMzQ+ekx6sMqG?=
 =?iso-8859-1?Q?7UZceuzRVmA31fIB+eOVpQliubfKtKvQgwrytgmAJ8a6Ls9HbHHzqD1Nmt?=
 =?iso-8859-1?Q?pDWKQ7BuPY9ksJKKjlbRz/5WFUiwG6RFaFihse6Wn9rz9X1qrb/nz00VXT?=
 =?iso-8859-1?Q?wj0g4PDvALgiU6IU3GQzomH/xqPRYh1GeKoymHz4AfzYuWwK3nVEhwplvs?=
 =?iso-8859-1?Q?2E91KS8xp5O9DMweztTj/zwuUWP1kuKX3TPau8XZTfdwK8Y9dg5GrxyWH5?=
 =?iso-8859-1?Q?oXtg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eb875f-4388-40f3-6b47-08da026a80f4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 07:49:28.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIcsVD9IwYoBccdMDMjZ+ExParrZJLnsCPMhwjs9u2sMkDq8L+lq1b+o8KO67wbuRKvOONeqLOIkzOCReM6yJyjLdYPJuOoZDpJ3+SKsF2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2143
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100039
X-Proofpoint-ORIG-GUID: qQoi5RP04B3UjbuimP6-ESy2y78eWAWQ
X-Proofpoint-GUID: qQoi5RP04B3UjbuimP6-ESy2y78eWAWQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 52bfcdd87e83d9e69d22da5f26b1512ffc81deed net:CXGB4: fix leak if sk_buff is not used
config: microblaze-randconfig-m031-20220308 (https://download.01.org/0day-ci/archive/20220309/202203092354.8QMmp2o7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/chelsio/cxgb4/sge.c:2566 cxgb4_ethofld_send_flowc() warn: missing error code 'ret'

vim +/ret +2566 drivers/net/ethernet/chelsio/cxgb4/sge.c

0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2535  int cxgb4_ethofld_send_flowc(struct net_device *dev, u32 eotid, u32 tc)
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2536  {
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2537  	struct port_info *pi = netdev2pinfo(dev);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2538  	struct adapter *adap = netdev2adap(dev);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2539  	enum sge_eosw_state next_state;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2540  	struct sge_eosw_txq *eosw_txq;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2541  	u32 len, len16, nparams = 6;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2542  	struct fw_flowc_wr *flowc;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2543  	struct eotid_entry *entry;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2544  	struct sge_ofld_rxq *rxq;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2545  	struct sk_buff *skb;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2546  	int ret = 0;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2547  
a422d5ff6defb1c Gustavo A. R. Silva 2020-06-19  2548  	len = struct_size(flowc, mnemval, nparams);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2549  	len16 = DIV_ROUND_UP(len, 16);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2550  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2551  	entry = cxgb4_lookup_eotid(&adap->tids, eotid);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2552  	if (!entry)
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2553  		return -ENOMEM;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2554  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2555  	eosw_txq = (struct sge_eosw_txq *)entry->data;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2556  	if (!eosw_txq)
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2557  		return -ENOMEM;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2558  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2559  	skb = alloc_skb(len, GFP_KERNEL);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2560  	if (!skb)
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2561  		return -ENOMEM;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2562  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2563  	spin_lock_bh(&eosw_txq->lock);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2564  	if (tc != FW_SCHED_CLS_NONE) {
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2565  		if (eosw_txq->state != CXGB4_EO_STATE_CLOSED)
52bfcdd87e83d9e Íñigo Huguet        2021-05-05 @2566  			goto out_free_skb;
                                                                        ^^^^^^^^^^^^^^^^^^

0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2567  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2568  		next_state = CXGB4_EO_STATE_FLOWC_OPEN_SEND;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2569  	} else {
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2570  		if (eosw_txq->state != CXGB4_EO_STATE_ACTIVE)
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2571  			goto out_free_skb;
                                                                        ^^^^^^^^^^^^^^^^^
No error code.  Are these errors?  It's hard to tell from the context.

0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2572  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2573  		next_state = CXGB4_EO_STATE_FLOWC_CLOSE_SEND;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2574  	}
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2575  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2576  	flowc = __skb_put(skb, len);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2577  	memset(flowc, 0, len);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2578  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2579  	rxq = &adap->sge.eohw_rxq[eosw_txq->hwqid];
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2580  	flowc->flowid_len16 = cpu_to_be32(FW_WR_LEN16_V(len16) |
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2581  					  FW_WR_FLOWID_V(eosw_txq->hwtid));
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2582  	flowc->op_to_nparams = cpu_to_be32(FW_WR_OP_V(FW_FLOWC_WR) |
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2583  					   FW_FLOWC_WR_NPARAMS_V(nparams) |
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2584  					   FW_WR_COMPL_V(1));
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2585  	flowc->mnemval[0].mnemonic = FW_FLOWC_MNEM_PFNVFN;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2586  	flowc->mnemval[0].val = cpu_to_be32(FW_PFVF_CMD_PFN_V(adap->pf));
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2587  	flowc->mnemval[1].mnemonic = FW_FLOWC_MNEM_CH;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2588  	flowc->mnemval[1].val = cpu_to_be32(pi->tx_chan);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2589  	flowc->mnemval[2].mnemonic = FW_FLOWC_MNEM_PORT;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2590  	flowc->mnemval[2].val = cpu_to_be32(pi->tx_chan);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2591  	flowc->mnemval[3].mnemonic = FW_FLOWC_MNEM_IQID;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2592  	flowc->mnemval[3].val = cpu_to_be32(rxq->rspq.abs_id);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2593  	flowc->mnemval[4].mnemonic = FW_FLOWC_MNEM_SCHEDCLASS;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2594  	flowc->mnemval[4].val = cpu_to_be32(tc);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2595  	flowc->mnemval[5].mnemonic = FW_FLOWC_MNEM_EOSTATE;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2596  	flowc->mnemval[5].val = cpu_to_be32(tc == FW_SCHED_CLS_NONE ?
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2597  					    FW_FLOWC_MNEM_EOSTATE_CLOSING :
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2598  					    FW_FLOWC_MNEM_EOSTATE_ESTABLISHED);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2599  
69422a7e5d578aa Rahul Lakkireddy    2020-04-30  2600  	/* Free up any pending skbs to ensure there's room for
69422a7e5d578aa Rahul Lakkireddy    2020-04-30  2601  	 * termination FLOWC.
69422a7e5d578aa Rahul Lakkireddy    2020-04-30  2602  	 */
69422a7e5d578aa Rahul Lakkireddy    2020-04-30  2603  	if (tc == FW_SCHED_CLS_NONE)
69422a7e5d578aa Rahul Lakkireddy    2020-04-30  2604  		eosw_txq_flush_pending_skbs(eosw_txq);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2605  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2606  	ret = eosw_txq_enqueue(eosw_txq, skb);
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2607  	if (ret)
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2608  		goto out_free_skb;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2609  
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2610  	eosw_txq->state = next_state;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2611  	eosw_txq->flowc_idx = eosw_txq->pidx;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2612  	eosw_txq_advance(eosw_txq, 1);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2613  	ethofld_xmit(dev, eosw_txq);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2614  
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2615  	spin_unlock_bh(&eosw_txq->lock);
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2616  	return 0;
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2617  
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2618  out_free_skb:
52bfcdd87e83d9e Íñigo Huguet        2021-05-05  2619  	dev_consume_skb_any(skb);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2620  	spin_unlock_bh(&eosw_txq->lock);
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2621  	return ret;
0e395b3cb1fb82f Rahul Lakkireddy    2019-11-07  2622  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

