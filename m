Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0152A4C2A92
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBXLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiBXLOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:14:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB19294569
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:14:00 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OAx5DQ001622;
        Thu, 24 Feb 2022 11:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=GrWsjOvEfQMIS61im1PEWLAfcUlZiFUp8U1qko5n8J0=;
 b=E5mtmY4oGVF7SHhCT1q+OjT0TVAD2JggHsFgkZBvr1AbfJnQDxXKMfY1NN7f425Q4Vvb
 RBfnJWaR0pwdlmIrnTOO/EtDkU+RlZR++W/2ft8PSIJ2Jb2qFfZhDNhNO/+TcXHyoiVL
 yhvBOWY2td5UL9BeVt36VZKsqwk/AekgWUSNY7jR5zdEHPbOjb41TzCsjDnP8XcXRQZj
 5wHyzRM2B9cFPV9Y041EYOitYTHpliGGeM0hGapW/bE8KkgPhcdfLOYzNp1LGcXyUSU2
 z83Mm/xU0PQdYA3P73bpqgwr1OrW9YiSa0iR/4H8A7miHqCNAs2/GPM0/IN+3c1e+YTl Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect3cpvwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 11:13:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OB5fpp136062;
        Thu, 24 Feb 2022 11:13:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3eannx8m7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 11:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdcU4Gdu6/UhpfU8HQxy7iRzQBXZa9Pd9yy4JZIK0whok7eEw3cYet6IQap5T6xvn+hXpfhvYC6BviD3KNsh47NDuUixLrTblV8J1kI6+hQ43wqcG9xL6DMNObVxJfyCGPkD8zNsL3QFNfcjcxe/vKooM0DJwnAiKa8xz3db/oH6EFjkP+8iQlERnArm4aXQLQ9XBdXT/3e/Zi3z0irI/sRwaUOLofXoM1SjhKuIOg7oB8Xlb1hW9FWSdoEsDKNcgH/GTnq3pVrInp57eEv5VyDtn75SDX8jm1DXlmTMK01GHCs2h5zmPYrcDxea0vIi1cWtGOCO3ZUyuwg07GnCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrWsjOvEfQMIS61im1PEWLAfcUlZiFUp8U1qko5n8J0=;
 b=KAzCvnlF5hB4Uwqvh1oor5/rC+totJ4TBhfWRVhJLRjVSyoH61dzQfhjHgGEgaEneXWttkH4PZmThv+6E98Snto2WB57nxUwnjorRAkrH99zL8GwQwuZ4Tp7f/fjopt0fFGTAS2FwZK6W2MVoPUFfoepqA1JkDajPnIdDA1aSXETMcgOQ/uNlEGcnDycSCKHsg7D6YDSYvDxo0dM8k0PSDeNexXPEtft3aOkTlD0Wo+Fd7ANmp1hiSuFbdGnGJ4OTl2pfDROO1zKpZl2V8ZaCouMRmySLLdet+OK+UvDyfmNzl+HjMCCfrsa6o8lAVlBxKVyd1Xxmd/aZ2JQcGPjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrWsjOvEfQMIS61im1PEWLAfcUlZiFUp8U1qko5n8J0=;
 b=Ud7Q3XmUlameuKZJf8AaQyeLq3rtwD0y741FhS3Pn8g8GnNrqToFMHCPPplVedHqSMu+TbS4JgPYX3EtBkGlecPGzk1u31DRH2CORkCcV2u2DCB1RxJdCK2WpFcg3B9ITRodfLc61u/sg+1jGI4515NHF7Xy8b6bZjqjzP27RDM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5364.namprd10.prod.outlook.com
 (2603:10b6:208:322::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 11:13:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 11:13:51 +0000
Date:   Thu, 24 Feb 2022 14:13:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Stefan Assmann <sassmann@kpanic.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/iavf/iavf_main.c:2309 iavf_reset_task()
 warn: inconsistent returns '&adapter->crit_lock'.
Message-ID: <202202230942.xMTeg0Na-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba847572-af5c-4586-de9f-08d9f786bc90
X-MS-TrafficTypeDiagnostic: BLAPR10MB5364:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5364933022371BC720B40AA88E3D9@BLAPR10MB5364.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDjxiTov+4nTFe5FLF8ct1UMMw8i9xduJqsXIbt2gHP62msTtOZF0QDXE3zT9B9fWkT4FQADry4sJon4DbSroqES0mR+267TelYKilPm/9ILfsvJitpugE5Xd/9rTqQCyfJtH8Wxn1bqVCP4EuFrvDxdk2JuFieCxOU1HZAGf8B6L+vRnf7XixoAxrm9yt86564jKlSi3j/+Wk4llXusezSdjuCaSDJTK95X0Isdc3gzpzLHask0m9aoCL14smd2yDTlNsv/prt2suaKBmRFHMNTiPCnyMrDH068J6sG1beYOywvRyzk5brde9yZFCluzYss10B8xUDkSc8PVLWKa91rxcVS3btpEZMnsiDlO/Mn8uV0KNLC+ZD/bH5m87kUTQU3Ft1duwSgIIZ5r4nviQxr+4jSo4MYMq7Bg8yyQjdJtyaU2C5SbdMfw8Er5qfzN63dj/tbbmGyhj0U7RVRf+abEoEwjXvGmUF/J+hZ12IBrvZvT5CC9PQgcpWCVPT8pbAY4nbKV61wK3HQaNlx9zt57jCXrkrCyKjBCjgz3nu7fUz8Ypq+AjqxJnDTBh7LgaZldn9Gq/vsxyzBoYFc6Xa9/3Ua/LjbEc4E9HW/f6OI/KMqdpIrcKAnbnqjo7WKjl0mysW8LMD33L2KHUfQlnqRBjqrDnVghyFUYsjg0mY47fAXHGaI8BuD6aLvzBQhXGlM/hQYP3g+Lcb+eQ0Cg0O3V6j0TCvW+sBmAk6Cihz0nAv5vNMPzVAfYvtxSotVdT8RFd+m2k6OzSvyrIGfVOokRZm4sCoYYuwhvmgjmwhFoN+/WAXZiY7q5XHpUwBjITo/EJdLLt9yzVP8Sn7VWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(9686003)(86362001)(508600001)(36756003)(38350700002)(6506007)(6666004)(6512007)(38100700002)(8676002)(6916009)(186003)(2906002)(5660300002)(66476007)(316002)(44832011)(8936002)(26005)(4001150100001)(1076003)(4326008)(6486002)(966005)(83380400001)(66946007)(66556008)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?waA/N8941DPuKRnqi2IObZ3XDwAF3xtsmpKguwJOLuwq0JVhhGMpWl4Mxijt?=
 =?us-ascii?Q?NjXcP/vW6Kz5Jc5K3WUOwjPEo5nYtJvAo9gBUAyBRH8xk2+Z0SzAeEltw41y?=
 =?us-ascii?Q?ApymAL1cbd0nhoZqoVIHHx6Xsw2WshGvLbCGgxYG2mYsAUvto3pffHCslXHX?=
 =?us-ascii?Q?bLgYmWFJPevSPJn7rNkiVYN/oXFDyYgzYzOpzb6feiri3HL+kZBsg2QWSmoq?=
 =?us-ascii?Q?lAeG/JCHp6A+MDfTHNLHIRArKJ8vCDg1wpnH9ioi6ea1bhafDUeCyUQ3TCnY?=
 =?us-ascii?Q?vT4HDg8UuypYIuYdVLskhMR+LMuRTRAghN1OdPANBoPnnRxlwCB0HWl6WXjb?=
 =?us-ascii?Q?z35O5FgMwA9iOZj0K6vELkw3D8YzRQBeCtTMvNGn5MW1soY9S6R1dmQmwmq1?=
 =?us-ascii?Q?rg3ZChuSoop8nd5VMvR98Zd4L1RSv72NQeywwUYEjtPtOyh26mV5Qj9xumKd?=
 =?us-ascii?Q?xTrfYku6UWBIA6OhLIRETmCtg64b1d9FXTU/yir9kUoltPmSxwTDfBXSVGo9?=
 =?us-ascii?Q?1UWX0wDcA5j2iN7dcUOodorJu5hVdM/ntdvRVJ7EhWPcMB25qbI7EhRCjZPA?=
 =?us-ascii?Q?PDuBg3LThx9WfDa4DzN+ZSmzVn20vcnY1eWiTKjcSGvxrKjL5vTjI8wh+VsA?=
 =?us-ascii?Q?jXa4I5kpXxDj4Ty4QANVKTKQm8VFD7AfjtxR2zby4iCrHwXxYW//puUf7gPB?=
 =?us-ascii?Q?VyJ+KM2cLduSNV4RlM2LDZL4266vGV0Cqa9HbVDWfry5m6dM4UErcVvFVziW?=
 =?us-ascii?Q?jpKzyd7SfDGc24LUv33e0Lm+WnOZbgVKBAY44x4NgQVdgB7rdSgKhEuzUvGR?=
 =?us-ascii?Q?1NmxBdg8ZSBJBt7GZW5onV+5NpXEgN5MHJYZ0EJPFS8+sG2bgHMUdGfxDz+A?=
 =?us-ascii?Q?y4FQ+oM10LMUggOY4QMHHwqrpMPJMYFlCCZKZS+pZRAtddI6Am09sp6mhDkg?=
 =?us-ascii?Q?FF2qtVFW9ESGHCqI7PswCDwjg8IimpuszBbuDuFGQEtlhTJk+kuVvCgNTPVx?=
 =?us-ascii?Q?ukd1HGElX8/TJ2pZp5WRrNhBqfe+PGmkqDukMYfwxPEMpw/WAI/AfPgcMNx5?=
 =?us-ascii?Q?IZ/gM9J6/2zDmvnwaratS5R2uazUB3epXBwqx1k9JSJL28mGy/NO19YoBMrg?=
 =?us-ascii?Q?y4lNr6im6gLGdTLoKaGDUJsTYiVy0rkaGEiY/gc4fcq2RpmFlUw7/qOf2/zu?=
 =?us-ascii?Q?Hds74u69vT43y0qT/lSlZNpgmNFna2ZatPLiCL+YJxARcPYdQVdETJb/gnih?=
 =?us-ascii?Q?vjvARakEZKWuL7edZY0/gXsoEO5Z1PIMLF3uBk0PqP6d+gkIHEufDoxJacG6?=
 =?us-ascii?Q?LPHybJUZf5qmIIHKdDJynX8pzGi6f3bBxqcJ+5dmh/yEmTRRNfkyweTKmyw5?=
 =?us-ascii?Q?GllwkpF81Megggr8a5q1Z4RaZ0EVSIdtCq3qXAGo0LPTyFVe0oRmMLlg2pMu?=
 =?us-ascii?Q?cnnNmAcW2XH+0moZIaMME21E/e69/muECVrNvpm/MxVMi/+Ax6hEwKcnEwwi?=
 =?us-ascii?Q?WzI6wIW7vmSTsR/PDLwAShnMU9sxd4BNDcRJIXM+byqvbX3jKDGi1GoH6Tl4?=
 =?us-ascii?Q?pMZeKB4yefHvB6SCmRCTgYqkxR/kywhV+GT9frN5/WLpXby/lo2vQgT/7DMo?=
 =?us-ascii?Q?DUsfQR7bYj3yKLVDFetI5pmMyBqj3safDecOjoUj6G5Sz8iIH1YwKpLEo27+?=
 =?us-ascii?Q?Kisycg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba847572-af5c-4586-de9f-08d9f786bc90
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 11:13:51.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbwj+DKlRSZSba5Tnvpq1JyPF2dQ7LUcxdCAM4dzTVAtFmcMyFEExfSmbz3pnSetG1rljCbH0NQUREwyj+QGKIXYM8hojYREyak5sNfN73c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5364
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240066
X-Proofpoint-ORIG-GUID: qD4zPByNu1j1GuCpR2l-E46ywFE55-xr
X-Proofpoint-GUID: qD4zPByNu1j1GuCpR2l-E46ywFE55-xr
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   917bbdb107f8767cb78f24e7d6725a2f93b9effe
commit: 5ac49f3c2702f269d31cc37eb9308bc557953c4d iavf: use mutexes for locking of critical sections
config: ia64-randconfig-m031-20220220 (https://download.01.org/0day-ci/archive/20220223/202202230942.xMTeg0Na-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/intel/iavf/iavf_main.c:2309 iavf_reset_task() warn: inconsistent returns '&adapter->crit_lock'.

vim +2309 drivers/net/ethernet/intel/iavf/iavf_main.c

129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2097  static void iavf_reset_task(struct work_struct *work)
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2098  {
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2099  	struct iavf_adapter *adapter = container_of(work,
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2100  						      struct iavf_adapter,
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2101  						      reset_task);
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2102  	struct virtchnl_vf_resource *vfres = adapter->vf_res;
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2103  	struct net_device *netdev = adapter->netdev;
f349daa58809ae3 drivers/net/ethernet/intel/iavf/iavf_main.c     Jesse Brandeburg      2018-09-14  2104  	struct iavf_hw *hw = &adapter->hw;
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2105  	struct iavf_mac_filter *f, *ftmp;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2106  	struct iavf_vlan_filter *vlf;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2107  	struct iavf_cloud_filter *cf;
ee5c1e92dd01d37 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-08-28  2108  	u32 reg_val;
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2109  	int i = 0, err;
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2110  	bool running;
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2111  
06aa040f039404a drivers/net/ethernet/intel/i40evf/i40evf_main.c Avinash Dayanand      2017-12-18  2112  	/* When device is being removed it doesn't make sense to run the reset
06aa040f039404a drivers/net/ethernet/intel/i40evf/i40evf_main.c Avinash Dayanand      2017-12-18  2113  	 * task, just return in such a case.
06aa040f039404a drivers/net/ethernet/intel/i40evf/i40evf_main.c Avinash Dayanand      2017-12-18  2114  	 */
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2115  	if (mutex_is_locked(&adapter->remove_lock))
06aa040f039404a drivers/net/ethernet/intel/i40evf/i40evf_main.c Avinash Dayanand      2017-12-18  2116  		return;
06aa040f039404a drivers/net/ethernet/intel/i40evf/i40evf_main.c Avinash Dayanand      2017-12-18  2117  
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2118  	if (iavf_lock_timeout(&adapter->crit_lock, 200)) {
226d528512cfac8 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-03-16  2119  		schedule_work(&adapter->reset_task);
226d528512cfac8 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-03-16  2120  		return;
226d528512cfac8 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-03-16  2121  	}
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2122  	while (!mutex_trylock(&adapter->client_lock))
f98a20068dfcc16 drivers/net/ethernet/intel/i40evf/i40evf_main.c Neerav Parikh         2014-09-13  2123  		usleep_range(500, 1000);
ed0e894de7c1339 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2017-01-24  2124  	if (CLIENT_ENABLED(adapter)) {
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2125  		adapter->flags &= ~(IAVF_FLAG_CLIENT_NEEDS_OPEN |
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2126  				    IAVF_FLAG_CLIENT_NEEDS_CLOSE |
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2127  				    IAVF_FLAG_CLIENT_NEEDS_L2_PARAMS |
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2128  				    IAVF_FLAG_SERVICE_CLIENT_REQUESTED);
ed0e894de7c1339 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2017-01-24  2129  		cancel_delayed_work_sync(&adapter->client_task);
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2130  		iavf_notify_client_close(&adapter->vsi, true);
ed0e894de7c1339 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2017-01-24  2131  	}
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2132  	iavf_misc_irq_disable(adapter);
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2133  	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2134  		adapter->flags &= ~IAVF_FLAG_RESET_NEEDED;
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2135  		/* Restart the AQ here. If we have been reset but didn't
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2136  		 * detect it, or if the PF had to reinit, our AQ will be hosed.
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2137  		 */
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2138  		iavf_shutdown_adminq(hw);
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2139  		iavf_init_adminq(hw);
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2140  		iavf_request_reset(adapter);
3526d8005f23da2 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-03-06  2141  	}
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2142  	adapter->flags |= IAVF_FLAG_RESET_PENDING;
3526d8005f23da2 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-03-06  2143  
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2144  	/* poll until we see the reset actually happen */
8e3e4b9da7e6268 drivers/net/ethernet/intel/iavf/iavf_main.c     Paul Greenwalt        2020-06-05  2145  	for (i = 0; i < IAVF_RESET_WAIT_DETECTED_COUNT; i++) {
f1cad2ce06f28c4 drivers/net/ethernet/intel/iavf/iavf_main.c     Jesse Brandeburg      2018-09-14  2146  		reg_val = rd32(hw, IAVF_VF_ARQLEN1) &
f1cad2ce06f28c4 drivers/net/ethernet/intel/iavf/iavf_main.c     Jesse Brandeburg      2018-09-14  2147  			  IAVF_VF_ARQLEN1_ARQENABLE_MASK;
ee5c1e92dd01d37 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-08-28  2148  		if (!reg_val)
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2149  			break;
ee5c1e92dd01d37 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-08-28  2150  		usleep_range(5000, 10000);
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2151  	}
8e3e4b9da7e6268 drivers/net/ethernet/intel/iavf/iavf_main.c     Paul Greenwalt        2020-06-05  2152  	if (i == IAVF_RESET_WAIT_DETECTED_COUNT) {
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2153  		dev_info(&adapter->pdev->dev, "Never saw reset\n");
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2154  		goto continue_reset; /* act like the reset happened */
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2155  	}
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2156  
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2157  	/* wait until the reset is complete and the PF is responding to us */
8e3e4b9da7e6268 drivers/net/ethernet/intel/iavf/iavf_main.c     Paul Greenwalt        2020-06-05  2158  	for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
7d3f04af69bed2d drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2016-10-05  2159  		/* sleep first to make sure a minimum wait time is met */
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2160  		msleep(IAVF_RESET_WAIT_MS);
7d3f04af69bed2d drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2016-10-05  2161  
f1cad2ce06f28c4 drivers/net/ethernet/intel/iavf/iavf_main.c     Jesse Brandeburg      2018-09-14  2162  		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
f1cad2ce06f28c4 drivers/net/ethernet/intel/iavf/iavf_main.c     Jesse Brandeburg      2018-09-14  2163  			  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
310a2ad92e3fd91 drivers/net/ethernet/intel/i40evf/i40evf_main.c Jesse Brandeburg      2017-05-11  2164  		if (reg_val == VIRTCHNL_VFR_VFACTIVE)
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2165  			break;
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2166  	}
7d3f04af69bed2d drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2016-10-05  2167  
509a447ae80c2e4 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-12-23  2168  	pci_set_master(adapter->pdev);
7d3f04af69bed2d drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2016-10-05  2169  
8e3e4b9da7e6268 drivers/net/ethernet/intel/iavf/iavf_main.c     Paul Greenwalt        2020-06-05  2170  	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
80e7289356cdba9 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-05-10  2171  		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
ee5c1e92dd01d37 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-08-28  2172  			reg_val);
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2173  		iavf_disable_vf(adapter);
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2174  		mutex_unlock(&adapter->client_lock);
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2175  		return; /* Do not attempt to reinit. It's dead, Jim. */
                                                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Drop adapter->crit_lock?  It's dead but the checker will be happier and
it drops adapter->client_lock already.

5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2176  	}
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2177  
ef8693eb90ae387 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-02-13  2178  continue_reset:
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2179  	/* We don't use netif_running() because it may be true prior to
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2180  	 * ndo_open() returning, so we can't assume it means all our open
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2181  	 * tasks have finished, since we're not holding the rtnl_lock here.
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2182  	 */
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2183  	running = ((adapter->state == __IAVF_RUNNING) ||
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2184  		   (adapter->state == __IAVF_RESETTING));
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2185  
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2186  	if (running) {
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2187  		netif_carrier_off(netdev);
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2188  		netif_tx_stop_all_queues(netdev);
3f341acc1c65b80 drivers/net/ethernet/intel/i40evf/i40evf_main.c Sridhar Samudrala     2016-09-01  2189  		adapter->link_up = false;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2190  		iavf_napi_disable_all(adapter);
3c8e0b989aa1afc drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-02-27  2191  	}
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2192  	iavf_irq_disable(adapter);
3c8e0b989aa1afc drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-02-27  2193  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2194  	adapter->state = __IAVF_RESETTING;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2195  	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2196  
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2197  	/* free the Tx/Rx rings and descriptors, might be better to just
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2198  	 * re-use them sometime in the future
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2199  	 */
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2200  	iavf_free_all_rx_resources(adapter);
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2201  	iavf_free_all_tx_resources(adapter);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2202  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2203  	adapter->flags |= IAVF_FLAG_QUEUES_DISABLED;
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2204  	/* kill and reinit the admin queue */
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2205  	iavf_shutdown_adminq(hw);
310a2ad92e3fd91 drivers/net/ethernet/intel/i40evf/i40evf_main.c Jesse Brandeburg      2017-05-11  2206  	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2207  	err = iavf_init_adminq(hw);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2208  	if (err)
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2209  		dev_info(&adapter->pdev->dev, "Failed to init adminq: %d\n",
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2210  			 err);
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2211  	adapter->aq_required = 0;
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2212  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2213  	if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2214  		err = iavf_reinit_interrupt_scheme(adapter);
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2215  		if (err)
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2216  			goto reset_err;
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2217  	}
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2218  
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2219  	if (RSS_AQ(adapter)) {
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2220  		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_RSS;
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2221  	} else {
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2222  		err = iavf_init_rss(adapter);
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2223  		if (err)
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2224  			goto reset_err;
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2225  	}
a7550f8b1c97128 drivers/net/ethernet/intel/iavf/iavf_main.c     Md Fahad Iqbal Polash 2021-06-04  2226  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2227  	adapter->aq_required |= IAVF_FLAG_AQ_GET_CONFIG;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2228  	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2229  
504398f0a78e724 drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2230  	spin_lock_bh(&adapter->mac_vlan_list_lock);
504398f0a78e724 drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2231  
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2232  	/* Delete filter for the current MAC address, it could have
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2233  	 * been changed by the PF via administratively set MAC.
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2234  	 * Will be re-added via VIRTCHNL_OP_GET_VF_RESOURCES.
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2235  	 */
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2236  	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2237  		if (ether_addr_equal(f->macaddr, adapter->hw.mac.addr)) {
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2238  			list_del(&f->list);
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2239  			kfree(f);
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2240  		}
9e05229190380f6 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2019-12-17  2241  	}
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2242  	/* re-add all MAC filters */
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2243  	list_for_each_entry(f, &adapter->mac_filter_list, list) {
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2244  		f->add = true;
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2245  	}
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2246  	/* re-add all VLAN filters */
40d01366e6dd5ef drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-10-01  2247  	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
40d01366e6dd5ef drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-10-01  2248  		vlf->add = true;
ac833bbf7958bbd drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-01-29  2249  	}
504398f0a78e724 drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2250  
504398f0a78e724 drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2251  	spin_unlock_bh(&adapter->mac_vlan_list_lock);
504398f0a78e724 drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2252  
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2253  	/* check if TCs are running and re-add all cloud filters */
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2254  	spin_lock_bh(&adapter->cloud_filter_list_lock);
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2255  	if ((vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2256  	    adapter->num_tc) {
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2257  		list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2258  			cf->add = true;
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2259  		}
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2260  	}
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2261  	spin_unlock_bh(&adapter->cloud_filter_list_lock);
0075fa0fadd0ac6 drivers/net/ethernet/intel/i40evf/i40evf_main.c Harshitha Ramamurthy  2018-01-23  2262  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2263  	adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2264  	adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2265  	adapter->aq_required |= IAVF_FLAG_AQ_ADD_CLOUD_FILTER;
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2266  	iavf_misc_irq_enable(adapter);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2267  
fdd4044ffdc8313 drivers/net/ethernet/intel/iavf/iavf_main.c     Jakub Pawlak          2019-05-14  2268  	mod_delayed_work(iavf_wq, &adapter->watchdog_task, 2);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2269  
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2270  	/* We were running when the reset started, so we need to restore some
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2271  	 * state here.
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2272  	 */
44b034b406211fc drivers/net/ethernet/intel/i40evf/i40evf_main.c Jacob Keller          2017-10-27  2273  	if (running) {
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2274  		/* allocate transmit descriptors */
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2275  		err = iavf_setup_all_tx_resources(adapter);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2276  		if (err)
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2277  			goto reset_err;
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2278  
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2279  		/* allocate receive descriptors */
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2280  		err = iavf_setup_all_rx_resources(adapter);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2281  		if (err)
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2282  			goto reset_err;
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2283  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2284  		if (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED) {
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2285  			err = iavf_request_traffic_irqs(adapter, netdev->name);
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2286  			if (err)
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2287  				goto reset_err;
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2288  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2289  			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2290  		}
5b36e8d04b4439c drivers/net/ethernet/intel/i40evf/i40evf_main.c Alan Brady            2017-08-22  2291  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2292  		iavf_configure(adapter);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2293  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2294  		iavf_up_complete(adapter);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2295  
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2296  		iavf_irq_enable(adapter, true);
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2297  	} else {
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14  2298  		adapter->state = __IAVF_DOWN;
fe2647ab0c9970c drivers/net/ethernet/intel/i40evf/i40evf_main.c Sudheer Mogilappagari 2017-06-23  2299  		wake_up(&adapter->down_waitqueue);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2300  	}
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2301  	mutex_unlock(&adapter->client_lock);
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2302  	mutex_unlock(&adapter->crit_lock);
67c818a1d58c789 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2015-06-19  2303  
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2304  	return;
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2305  reset_err:
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2306  	mutex_unlock(&adapter->client_lock);
5ac49f3c2702f26 drivers/net/ethernet/intel/iavf/iavf_main.c     Stefan Assmann        2021-08-04  2307  	mutex_unlock(&adapter->crit_lock);
80e7289356cdba9 drivers/net/ethernet/intel/i40evf/i40evf_main.c Mitch Williams        2014-05-10  2308  	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
129cf89e585676e drivers/net/ethernet/intel/iavf/i40evf_main.c   Jesse Brandeburg      2018-09-14 @2309  	iavf_close(netdev);
5eae00c57f5e42b drivers/net/ethernet/intel/i40evf/i40evf_main.c Greg Rose             2013-12-21  2310  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

