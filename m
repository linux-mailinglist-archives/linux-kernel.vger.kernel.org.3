Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E8464D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349112AbhLALuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:50:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51036 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349100AbhLALuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:50:24 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1BA4vs016574;
        Wed, 1 Dec 2021 11:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=T5cJ9IZgzOjEd7S3nwwdRB1++ClAXpwrtsHiK408fwY=;
 b=JzwO0DXw6lBe4nbtwMRjp/N52Ceg97wf7HaDU3bq97iSDrNF6yHxladzJRkX+/LdgOrj
 a1YKa23a7loLjF8IQSGlfHnEhMXAj2E9W8f5eKf5XT4y5U1csKqEvG85Ifu6XVeCGUQi
 G58RlQm4J/5yJBJoBA4VQwcdnO10C/SsPlu+27ZStZe6cCE2j1j0Dr8+1WBwc+9TlosD
 TjlcWZlK55VKfCA2dho0NnXT2EUm2UU3P9qvLd/6ZUtnhuYzaienV1fZ8XGG+ZKMO5jr
 57/5DMHJj6k6DlNZdSLmPIRPB1RbSvOUSBjlTn0VsyAZIaKi3bOYBjT+Z1myY1pKLK/y Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wqgvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 11:46:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1BkJZW059048;
        Wed, 1 Dec 2021 11:46:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by userp3020.oracle.com with ESMTP id 3cke4rmvjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 11:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPK7XHXA4oKpmpD5g6lEATwbXvrMyeMhOPfPqm6ZZ0iso8h4LKqMJ+95dPieQufAPdSLnmZ6AxXYWaUrzdO3PNFZEg8h6I7Brje+oiuNJnqNYS0qcnCiVv2xek67f3zcfccfiE3Bx70SOTvIKJZOrjyFYrF2KbvhUiRXKs9vucfVrsUAbrZGuRXNYnP01ohPxVVuXPCS6pyOsm3Pz9kGvpDC4gvwon9SoCZe4dhMKfKgO0j5oUGyfBNRtnmaK65+DpNxtIiM9JaStV76rdTBGQOfIqLiBE7XdwBOzl5qN+fsDqefddLaQXeBn0JFOwWDpyQzf5QBuFzGKB5Q4xp2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5cJ9IZgzOjEd7S3nwwdRB1++ClAXpwrtsHiK408fwY=;
 b=UR4ep2P0zE+tsTg7Q3L2YdbudH/ubtyuLoFScFkhqRGQ6VyYJleQ/AyjmTxw95IbEuoxS8jhPq9QO/PKthzJxdbkVuNZxrE1ksWUvuKhUbmd2rWYqIg+E443p2S9A9nx0ymdUbHnSg9fz9NB21wOx/Ciax1JSSMyEJv/m9SSOkj2qJgBkhmPGzy2de22C930Pr+rTroZ1yub+QmRFmoCNFTU9+xqSJSmZ0ejtYVYczpFbiiCEsC46IzGy/GY92uMkY0eNeuOvmeFEDdT3Wh/b+ZodlOMTF+KsBKatbT/3vggnB+AgZ5PhoJerLzmHnqSgxyw73HFXZDRpEVgpp2V4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5cJ9IZgzOjEd7S3nwwdRB1++ClAXpwrtsHiK408fwY=;
 b=pvBBhdzMTLvap0LnI/oAYkiKf/Zs2AgLZh+pr+YpudUbdWCLJpxIASexJcb14Aa0VLgjuSzg0LPO20Ux9DHY+qA3nYTTxkiEp3vbzs10a3Odx04NpKtMCLXijMHSClIe1Wz2XnAi/1ffqWZMbh3EgThIp5cGv2aLmTeenUXIvlw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1248.namprd10.prod.outlook.com
 (2603:10b6:301:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 11:46:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 11:46:47 +0000
Date:   Wed, 1 Dec 2021 14:46:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Rob Herring <robh@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments()
 warn: missing error code 'ret'
Message-ID: <202111280304.FL2314qf-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 11:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34398d89-f9fe-496d-6927-08d9b4c04187
X-MS-TrafficTypeDiagnostic: MWHPR10MB1248:
X-Microsoft-Antispam-PRVS: <MWHPR10MB124857C21D349EDBDA7C6D8A8E689@MWHPR10MB1248.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqJJ8rsld3muS5mmM1KTk4L3M2IEkVwPAyXBsLF2ZE4+MNUWGQjHjnNgWlpvy0PnD6fMWRNmqN/RsORgiz6iUG+HvksdUMW+ET9jVke2336CVOUspbSyOqDWwvZ0dKrvSxtGkbYlTrZ5pWiqb4YcVVUvelbVrr8Qt7gkIEwJRvbstgioXROwWdHjGnAmuSag+Ep3DtQ3PfyOtaYG2CZ2zN4ZwwKF5Yp4pvOsuSTbqNX1jEoEWvjNZ3OLe/gXh2XGFZV27ut49itGONISC5D37j590McA8uh6XoPB9w630+KnHOgtHSXtB+s9eph6iy7Td/Q+okqodfyp0NpxX+CDK/XKnbOwz0oxWe13oZEa61c2uSy8PQsZiz7WkfaAQZo/GdbPRCB7tVJvMfRtiqOG5Xlrd4AaHc2IlJIgEOYwr9PuOgjb3kt39Ko0wzZInkcaaTTWQKEv0IZPycEXBQJEc5N9vsOYSivn/S8t7EpIivvym/UZOvimCKqPsZAx65q49e5ko5VEX962/lLENqtqwVr+6DR0b7vPx1kmWuwMTEOSI07BRly7czwpB28kRjuLO28TVWICYUd8wAx8HDIeOO+lQRu696zcppiadmqELFwxXIWrkJOJ9IDrccEo8dXnYwZc6bKbGTB1VlI+Q4doVLY4bbVhfWMnexjY4H2iNZ2xlYEqGY+GvgzdjPkkIJgqlDVnJgqrq4k48No1M/zYJvoGK+fnxd47XnQR0/9V14NMAg9yF/3RrPHkI8TyHdk+SZpxX1ZR1EChXd93Ve8sFfH6AZg9TzaUvW5gh99qcexM/DOpuCOdZDRSyCmDqv6yZ8Bqct/CJzGxNiTn69nEtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(4326008)(38100700002)(38350700002)(54906003)(966005)(9686003)(5660300002)(508600001)(86362001)(66556008)(83380400001)(8936002)(186003)(6916009)(6666004)(26005)(6486002)(316002)(2906002)(44832011)(8676002)(1076003)(6496006)(4001150100001)(66476007)(956004)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEQ1MU1qaWI2WXQyeXEyYWxQQ1F2Zld2ZzFYcHREd2VHRlI1emtNa1loMmZW?=
 =?utf-8?B?QmNRcVIrdmkrQ3FWSXBJK3c1Q2RCL3M0NlJJQUdPd1ZTZ3hkVmpwa3MzVllK?=
 =?utf-8?B?K0lpZUJzb0ViU2dwUENFb1lJWDJ0Um5uTE9SMmRRMWdxK2RpZER1anhBcWdG?=
 =?utf-8?B?d3o4Skx1bmFyNVhDRFVTdGYyZUJxRHIrMlJUMnVIMzRTcnZPK1FYVGNLZE5p?=
 =?utf-8?B?bEh2cWo0Y1M2MEFteWt6anlKYTAwaDRBWjY1TnpqR2lBcjluTllOUXBUckRN?=
 =?utf-8?B?aHNRM2krMG1DQVRWOWE1OVIzcmRKcUZWZ04xUTNkazh5UVZYN2V2VnVkSFpk?=
 =?utf-8?B?SFJzTEo0aktWWE54RUNjd2pqLzZqQWlURmsxdmJSRFYxRGFDajJnalJxUVh6?=
 =?utf-8?B?dkV1SE5VNkptRThwWUxvMjB1VHJuS1ZvUUU2YXNLNllZYUNRVzdaWmZZWis5?=
 =?utf-8?B?aHdFZ3NwdHVuSlE0ZVdldEVQcTk2SytiNjBIUXdlOTNFeXpuZ0VtQzZWMktT?=
 =?utf-8?B?STlOcisydmdoV2cwNzQ3WW9RbUlycFFMU3FDSjhvc1AyUmR6V1pucFFRMUxz?=
 =?utf-8?B?bm5JZlYxemFHMFozRFZFbXhqNVdzc0tIMUpqeVVzcUxuWVVNRTgwVUIwWUJN?=
 =?utf-8?B?UGNOMDdIQytzdmV5TTNjRFNDMCt5VG9CVUtOZFZ4WjZhcGZwc3czM2FESGdY?=
 =?utf-8?B?c0VPZjhHdzgxYTBlekp5Ymt4YjJHZCs3K2lXdm40VE0xZ1V3ZDFYTXBadDNw?=
 =?utf-8?B?bDZJZ0FybFIzZ3U2dnQ1ZDZ0aE91cEUwNS90eGN1enJaOFM0ZzlpVTNCMVo0?=
 =?utf-8?B?d0hjbmxmbnZUUzYyYmpFYVo0enRsVFFTOEYzYU9tOUR0STB3eVh4VWxicVlE?=
 =?utf-8?B?ckVnaytVbmUyUUJhMys2dEpoazh3Qjd3eWxtUkU0QnBrejY4aVlRb0kxdGtG?=
 =?utf-8?B?WnJJK2thWUJ5cVIyanVBaXlXVk5XSXdETEp1SGxPQSt2S3hzSzFaSWY3TVdx?=
 =?utf-8?B?Z1lJQ2ZjVGlxOEt4K21IelZMWlcrVGxnblZNK3RVMmNLbUVoaWs4UGovZHFE?=
 =?utf-8?B?WTlJZENKSFExUWcrUW5USHBqUlIzVE9idnRLSFNMbnoyTDQzSXNKb1JqK2pP?=
 =?utf-8?B?RGZpaEpjMFBFRUVCS3FQeHJZNldoRXFhcmo1blk3Q2pTZUREU2M3aU90M0NW?=
 =?utf-8?B?TFRoOGk2Wk1vSm1pcjViaWp0ZEI2aHhsUytjRUh4MzZHU3pnUWw5cEV0Z3lk?=
 =?utf-8?B?bkZyenlSNjR4UW9lUUNUdGVHRzYrVktvMEpUOUxnMlB0anRldkFMVnRJQThj?=
 =?utf-8?B?b0FVb2pFV21oeW9XbVczN0JtRGRhVEFoVFYzRURoYllPUDI0ZkRZdDBCbEpI?=
 =?utf-8?B?eS81MHBvejFtaW9JTzRBUW5KclM4aEoyWHFPcHo4WGtXQUJoVUxGNDVEZ1ZE?=
 =?utf-8?B?VlhwRGVxOUl6NldIbGhGSmlCV1FrTGk3RlVheExBTnV6KytzMURibjVOcGwx?=
 =?utf-8?B?MWR5Nk1lK1ZwVlhZSkpTSVE2RmFSOS95YUFKaDhXNUpCWHAwaGUyNEVBNHZO?=
 =?utf-8?B?MG9wMGQyeU01ZFhqbmF6dTdqb0lWMnZ3M0FKTGFJb2tXYnJWL0wvQzFsdWRY?=
 =?utf-8?B?OXJVdUFScDI4VXM2c2Z5aEdaelZYZkg0QlplOUY5dnVENmg2WUJ2RWtyWlg3?=
 =?utf-8?B?VW54eEdOYTQzUWQ2UTY4SnVzZlBnb3JlUmIrZlJCZjNnYWtGQlZpQmxqZWRi?=
 =?utf-8?B?Z3dxYzRLWHpwL083YmgrOHhFZXdKNWczMG1PYklVK0RhcVc0NVZqZUdseUtT?=
 =?utf-8?B?clhENUo1a1ZQeG1VdDh6dG9ldUgxKzZ1QjFJTFl3alg2MFN6SGlrVytqTDQz?=
 =?utf-8?B?YktvY3RzT01WbGNSbnMxbEtldUF3dncrL2x0K3ZRMmcybjIrdkpzOUcwUU5E?=
 =?utf-8?B?MVYzUTJWdEdGS1U3blNJTzBYSUVqZnN0cWVCemF3a3prYU01NCtydDRuWWJz?=
 =?utf-8?B?Q2ltMDNlaDIwb056VzJaZjBiaGwrcm5mSXIwOEVSRmRaRWh1R004OHk4eko0?=
 =?utf-8?B?bzFXbmRXbVkvajRNbUhXVlhCVHZvUG84Y1FyYklpaUJJejNQWFk4ZWhkQUZC?=
 =?utf-8?B?RSt0dFFJMVBWS1E2M0JiV3dXcVAvZWlPRkxWRnZ1U3g1c045WkFiRGxpSXRI?=
 =?utf-8?B?aWdEMk81VkErZUQyU1VlVWlHK3l3ckhCMUp0cm1nRTNlOE1JdjBlVEVtQ0xn?=
 =?utf-8?Q?5KF9l1NdP28L1y9BFXHO2k23OUg4fzoogU8g3ZJgXY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34398d89-f9fe-496d-6927-08d9b4c04187
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 11:46:47.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83ma9rQPyPdI+aKrYfpbwKZA1MM9uT9hd3q7cKVJiHTD2aSxyMI7Y/ubXw6VC0ohU5YvgUug9Z7pWEHd6nPdRVGk6ZHbUGzqFTU+KS5YyXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1248
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010068
X-Proofpoint-GUID: vm39hDXUdcZHL2_MLMmcnapEAKsf2nHp
X-Proofpoint-ORIG-GUID: vm39hDXUdcZHL2_MLMmcnapEAKsf2nHp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: ac10be5cdbfa852139658d52c2f1c608782ce992 arm64: Use common of_kexec_alloc_and_setup_fdt()
config: arm64-randconfig-m031-20211127 (https://download.01.org/0day-ci/archive/20211128/202111280304.FL2314qf-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments() warn: missing error code 'ret'

vim +/ret +152 arch/arm64/kernel/machine_kexec_file.c

52b2a8af743604 AKASHI Takahiro         2018-11-15   81  int load_other_segments(struct kimage *image,
52b2a8af743604 AKASHI Takahiro         2018-11-15   82  			unsigned long kernel_load_addr,
52b2a8af743604 AKASHI Takahiro         2018-11-15   83  			unsigned long kernel_size,
52b2a8af743604 AKASHI Takahiro         2018-11-15   84  			char *initrd, unsigned long initrd_len,
52b2a8af743604 AKASHI Takahiro         2018-11-15   85  			char *cmdline)
52b2a8af743604 AKASHI Takahiro         2018-11-15   86  {
52b2a8af743604 AKASHI Takahiro         2018-11-15   87  	struct kexec_buf kbuf;
3751e728cef290 AKASHI Takahiro         2019-12-16   88  	void *headers, *dtb = NULL;
108aa503657ee2 Benjamin Gwin           2020-11-03   89  	unsigned long headers_sz, initrd_load_addr = 0, dtb_len,
108aa503657ee2 Benjamin Gwin           2020-11-03   90  		      orig_segments = image->nr_segments;
52b2a8af743604 AKASHI Takahiro         2018-11-15   91  	int ret = 0;
52b2a8af743604 AKASHI Takahiro         2018-11-15   92  
52b2a8af743604 AKASHI Takahiro         2018-11-15   93  	kbuf.image = image;
52b2a8af743604 AKASHI Takahiro         2018-11-15   94  	/* not allocate anything below the kernel */
52b2a8af743604 AKASHI Takahiro         2018-11-15   95  	kbuf.buf_min = kernel_load_addr + kernel_size;
52b2a8af743604 AKASHI Takahiro         2018-11-15   96  
3751e728cef290 AKASHI Takahiro         2019-12-16   97  	/* load elf core header */
3751e728cef290 AKASHI Takahiro         2019-12-16   98  	if (image->type == KEXEC_TYPE_CRASH) {
3751e728cef290 AKASHI Takahiro         2019-12-16   99  		ret = prepare_elf_headers(&headers, &headers_sz);
3751e728cef290 AKASHI Takahiro         2019-12-16  100  		if (ret) {
3751e728cef290 AKASHI Takahiro         2019-12-16  101  			pr_err("Preparing elf core header failed\n");
3751e728cef290 AKASHI Takahiro         2019-12-16  102  			goto out_err;
3751e728cef290 AKASHI Takahiro         2019-12-16  103  		}
3751e728cef290 AKASHI Takahiro         2019-12-16  104  
3751e728cef290 AKASHI Takahiro         2019-12-16  105  		kbuf.buffer = headers;
3751e728cef290 AKASHI Takahiro         2019-12-16  106  		kbuf.bufsz = headers_sz;
3751e728cef290 AKASHI Takahiro         2019-12-16  107  		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
3751e728cef290 AKASHI Takahiro         2019-12-16  108  		kbuf.memsz = headers_sz;
3751e728cef290 AKASHI Takahiro         2019-12-16  109  		kbuf.buf_align = SZ_64K; /* largest supported page size */
3751e728cef290 AKASHI Takahiro         2019-12-16  110  		kbuf.buf_max = ULONG_MAX;
3751e728cef290 AKASHI Takahiro         2019-12-16  111  		kbuf.top_down = true;
3751e728cef290 AKASHI Takahiro         2019-12-16  112  
3751e728cef290 AKASHI Takahiro         2019-12-16  113  		ret = kexec_add_buffer(&kbuf);
3751e728cef290 AKASHI Takahiro         2019-12-16  114  		if (ret) {
3751e728cef290 AKASHI Takahiro         2019-12-16  115  			vfree(headers);
3751e728cef290 AKASHI Takahiro         2019-12-16  116  			goto out_err;
3751e728cef290 AKASHI Takahiro         2019-12-16  117  		}
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  118  		image->elf_headers = headers;
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  119  		image->elf_load_addr = kbuf.mem;
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  120  		image->elf_headers_sz = headers_sz;
3751e728cef290 AKASHI Takahiro         2019-12-16  121  
3751e728cef290 AKASHI Takahiro         2019-12-16  122  		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
7b558cc3564e6c Lakshmi Ramasubramanian 2021-02-21  123  			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
3751e728cef290 AKASHI Takahiro         2019-12-16  124  	}
3751e728cef290 AKASHI Takahiro         2019-12-16  125  
52b2a8af743604 AKASHI Takahiro         2018-11-15  126  	/* load initrd */
52b2a8af743604 AKASHI Takahiro         2018-11-15  127  	if (initrd) {
52b2a8af743604 AKASHI Takahiro         2018-11-15  128  		kbuf.buffer = initrd;
52b2a8af743604 AKASHI Takahiro         2018-11-15  129  		kbuf.bufsz = initrd_len;
c19d050f808812 Bhupesh Sharma          2019-07-11  130  		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
52b2a8af743604 AKASHI Takahiro         2018-11-15  131  		kbuf.memsz = initrd_len;
52b2a8af743604 AKASHI Takahiro         2018-11-15  132  		kbuf.buf_align = 0;
52b2a8af743604 AKASHI Takahiro         2018-11-15  133  		/* within 1GB-aligned window of up to 32GB in size */
52b2a8af743604 AKASHI Takahiro         2018-11-15  134  		kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
52b2a8af743604 AKASHI Takahiro         2018-11-15  135  						+ (unsigned long)SZ_1G * 32;
52b2a8af743604 AKASHI Takahiro         2018-11-15  136  		kbuf.top_down = false;
52b2a8af743604 AKASHI Takahiro         2018-11-15  137  
52b2a8af743604 AKASHI Takahiro         2018-11-15  138  		ret = kexec_add_buffer(&kbuf);
52b2a8af743604 AKASHI Takahiro         2018-11-15  139  		if (ret)
52b2a8af743604 AKASHI Takahiro         2018-11-15  140  			goto out_err;
52b2a8af743604 AKASHI Takahiro         2018-11-15  141  		initrd_load_addr = kbuf.mem;
52b2a8af743604 AKASHI Takahiro         2018-11-15  142  
52b2a8af743604 AKASHI Takahiro         2018-11-15  143  		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
51075e0cb759a7 Łukasz Stelmach         2020-04-30  144  				initrd_load_addr, kbuf.bufsz, kbuf.memsz);
52b2a8af743604 AKASHI Takahiro         2018-11-15  145  	}
52b2a8af743604 AKASHI Takahiro         2018-11-15  146  
52b2a8af743604 AKASHI Takahiro         2018-11-15  147  	/* load dtb */
ac10be5cdbfa85 Rob Herring             2021-02-21  148  	dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
ac10be5cdbfa85 Rob Herring             2021-02-21  149  					   initrd_len, cmdline, 0);
ac10be5cdbfa85 Rob Herring             2021-02-21  150  	if (!dtb) {
52b2a8af743604 AKASHI Takahiro         2018-11-15  151  		pr_err("Preparing for new dtb failed\n");
52b2a8af743604 AKASHI Takahiro         2018-11-15 @152  		goto out_err;
                                                                        ^^^^^^^^^^^^^
This needs an error code.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

