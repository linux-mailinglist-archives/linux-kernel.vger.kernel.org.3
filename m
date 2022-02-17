Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C424BA20F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbiBQNy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:54:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiBQNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:54:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7725F35B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:54:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HBO159021441;
        Thu, 17 Feb 2022 13:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=wAh/U2cGCXDVTb3jJ/9k2T5LTW5krSam9H7O6jRnT6k=;
 b=bonw50w92XdJ9gu9QbesiqcxOH3zQUvUWBDqYfYg1LBNVJiwKPuy+AU/L100v85lds3g
 Ygjx3RVSUGmE6VKYfiqAdrOjoo1RSHA+k8EdT2GsVeoDYU5i2m11rI69CVkLfG+Qtn91
 MwSv8uyqHlkEWuVnk2a6KnOoj5qfMHPIgMh9BSWu/8zqAtp7Wlo0lq9MdS4me66hSIo8
 61jUPpWZOPmcEWpq6vZBMFmIexvomt4EjMhf0ZBvak4tOsiXnxxImLaitGSRRh5lSead
 bK1/bkH5qoE1AVsD8Wrq7Y3NgCRUNggYCKI5FaeLVowMzTcQXfpvULwhxjbhB+twISuO hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fdfdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:54:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HDpVPJ062141;
        Thu, 17 Feb 2022 13:54:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by userp3030.oracle.com with ESMTP id 3e8nm02a7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDrBexFPxDNCeLLHUQK4hiA0hFAIu9p3NconwNWCNUvmwUwTX80WCzmMO4XgRykQuZTlWcDMONTqfoU56B43oFUQ6mNnzYNhbuJ0awAlFRSdtEyo57KnNGZxy4a+fTYHdRFOg0bcgoS1hZEjZ6i3sSrEA+WvsSUmlgidIkN3o5gZrMqDdxxXpeVAoOZXyHz7nOMuiL8qiivXw4ytZCFJAr8B4pjIoZn7XERB0KcbxISneUj8CHhvzvpAAxzCruqilf9PjQv57UlcpIg99oFc8bjfM76lWUgbgSepAnjkKSZMna/TZ6OG1C2d6AdlHb5A32g6CrQPPtDWkpK5K4dxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAh/U2cGCXDVTb3jJ/9k2T5LTW5krSam9H7O6jRnT6k=;
 b=V+R9CWJo6NYZokIyaXe7VraoNJ5QIYq0nmZLNMlZb5wjVUihBieMtzjA5XyRn4h8dCSvHu3u+SqrWnxG89ian0SitPO3V7undLbTNejiZoyR2/fKXD/1VYHd1wtIGNvw7/vunz7bBwDkfWgbgIo3DSM7+m+1DV/yByvxdYNi1nd3VPKGiGFJLW6NQ2JpS1w1V5wJbGPtAln+C7z5ndLMGysWDxeZVYoBwtgBwCy2LNanxWdwf8r9Do7JWtmL9drSTD92/RIcXGCcQrCia7boHmy8HIweDryhsSWFohXfPX0rqAltU5WzLBnIFhUgdFraA58XpCv3b7A0uqVhmAJF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAh/U2cGCXDVTb3jJ/9k2T5LTW5krSam9H7O6jRnT6k=;
 b=Ud5pODzWZsJNmmh+1++4tVDcE7/MQE9mJgzq1lOsGX1yD0YQs1vKwl4EOCi31ducTPN0iKIWg4vNpguRjTToelV537ieIn0DheesrQwG1843jh0vrsplrPu1vYZEnHwf+VcTd/rZywkpR0Vat0n7QqqvXb5Byg18aY+U/IY9uYk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3146.namprd10.prod.outlook.com
 (2603:10b6:5:1a6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 13:54:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 13:54:36 +0000
Date:   Thu, 17 Feb 2022 16:54:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-rebased 120/133] drivers/acpi/svkl.c:164
 acpi_svkl_init() warn: '&acpi_svkl_dev' not released on lines: 157.
Message-ID: <202202160009.rI543Li4-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca4d676-60a6-4902-e923-08d9f21d08ad
X-MS-TrafficTypeDiagnostic: DM6PR10MB3146:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB31463767B84F3F7423AC13AD8E369@DM6PR10MB3146.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:170;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prGwYSpOE2Vd1gG2k6FyYe+N4RUGD1FPgk0zebPobCujHBJGLqBepgY29aF+O2IQARLuiiJ/xcBLIRVpV7enWJKGw8dkWGRAcSLeF+R9p2vawK0waNm/tRjbPWnzkFo7UneYokSJ8ltqUUYWzPkUBJXY81IrccrMAPk/PegIPw7lWSYaOij+K2MqPvhDnz5I3AUV2cZs8K8Qo5cGa+AK1ObeDhOAKD0q7ZwsgaPYFamddUFESfmYWdXZmNV4s/N0RB0G8pe6dtFDbfggy2+ynhev35jlxSZXXbJyGrniHbOo9Q9blr0uvHHJOFW6R8D4xEHojKhLmoRxGEFEF4b7XILL9aSaAbRM7BDa4x98AI/WmIUKhvF1P7iwxJWYaNLpUGXDAh/kU+1AS2xYVKr17MSArSfy8RieFH/tTI5hpEKuVfZjtAC3fyBoEc6CuD9dUupsS7ILYGd0OZPYKSzf2CBTIJ+clHhwFcfQox1akFMmxbGik9BSIeI2LA/qs6mOvzitOZ1EQBscqR5o5Mt1El4zQagOgA28Nw2p5jVHvZovlsPXv4o4gHrNXNtsipjKu4S2ZEz3o+f8HPmQDYNw2zs/74ue3/SiHCD5S4tprwB6SRE1SHU+66pYyKxFLrOd6WPvbDvNW2BfQ4VI2K5K+mRN0QchfGDuEYQrRZPuD5sJW8E1oHnPnFF3SZFwi+Jc+TX4q4ZZl8i6LXwtTn3SXuIogAopIvh8UtsOzxiYCxm1enuhpFwJEMpAIcRlR5U4N+iUuuT6QkeC/xErwSfCe3+fWjrqRmH6kPCQDc7A7evd1rXq6mjE8ZPZYQDSrDMlGySmLG1JA6JZH9XQfKkLAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(8936002)(6506007)(4326008)(6486002)(9686003)(6666004)(52116002)(26005)(186003)(44832011)(2906002)(1076003)(83380400001)(5660300002)(36756003)(966005)(508600001)(6916009)(8676002)(66556008)(86362001)(66476007)(38350700002)(38100700002)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j44bRjcpe9eByQiUNaO9rmzqXJuJpmRApimZglwfHJ2UlEuQByyuSU8SSURl?=
 =?us-ascii?Q?9kAotcHbCRRdk/9LKW8Y9V9m/DbDeuR97Rq1CrS3yKIs+YCjufRyPlkdP1Ov?=
 =?us-ascii?Q?avvfeGG+ahWRMk4+zLS25g3tpt24TQNwlNukKYtiYLuPnd3UT2UYgKOif0Jv?=
 =?us-ascii?Q?08zbKK2MO1C2xG2AUNF4BdSu+gh5+OUz0dlegJIPcbFXYLjrsv6xyGTJn3IY?=
 =?us-ascii?Q?m8xz+eSRNVXEK8ivq1mgYdKmcbg8qOSUqiEdyJfFQfUdgYhqtg44dZVI5r53?=
 =?us-ascii?Q?EtmIf/noHRZgHq72VeCD2uC8ttsqtwdP9KDn5Pydx+UKPfHrsYnSOmCXo1xw?=
 =?us-ascii?Q?iP7Ad2sSqEwL52ToaGV/CghPosrHKAg8k0SvSPMJr7GvWuk6N18eeY7CVx9I?=
 =?us-ascii?Q?EXLqMILd4jThJjMgswWa17Tb8jaNdDQHm02vwWI0IyLuzCmerRt5CdckRM61?=
 =?us-ascii?Q?g/Rx1oYEI6gks+Az9i5JRar2QnYcz8B8qqwe+f4YnbV5ZbcQnHqA5lX+LfNY?=
 =?us-ascii?Q?q2QKb6dr4NJxXqqr+4vTgJirLNM20F9vWH/muZvxCLQMzwtHwC2TxGI1KrYi?=
 =?us-ascii?Q?fYZSgldDHuJks0e4ShfEEhYqQh3gOwMrSwfMbcLNH+m2O3q8cKFlndb0QalC?=
 =?us-ascii?Q?xvHKopZEORDymnEjV9CURjIIqLmlozz0Qrt4cZZbK9xc9dAo3O5MqI9zL3t5?=
 =?us-ascii?Q?A9uJIpN6Ldkyd2orwGqNFCq420OSpVMjGH8eREjcbvCiTvxl5lHmZcU2mxGk?=
 =?us-ascii?Q?MaD9oFDKcXa1fuBpD9sc1UzmR+9QMfv+AnM3OpJ576TVygBnwN/QAVFyhMW3?=
 =?us-ascii?Q?RzHuwzfByXT+MXrUmYk5bk6enxGJE5cB1wOHxzg7zhERDJD+e0v0Wy51sdqy?=
 =?us-ascii?Q?FquFX5zgEDqKEDK+qXJyfa3sWso9gDKLMZT6RPb+spmc8ksdeE+mqS+kqa7Z?=
 =?us-ascii?Q?9maiuJ7BdjPNTAIuLxs4FeTFIZ0PF5oZ0iSdWKBoOLO4iAJy3A4aHkQjhKJg?=
 =?us-ascii?Q?khF4StvyOc59B80tgfd712qcQja3pYoRZBze+hRDtwn0mkeh/ZCI9ot9e4BX?=
 =?us-ascii?Q?9X4YYDozJiRLSsH8F9zzp0DbtNIp+Fo/rkjj+Sev2uN+H/R80mKPrfYFSC+A?=
 =?us-ascii?Q?fCzKlyYcrSUtkvlr5zn6/kCKsKTXYOGapCWwm+nn+rRyMlRhzQWr62ZD5SL+?=
 =?us-ascii?Q?AcLh9j44UMJQ01tf461wOwa7Uems4CXQiXT/veH7MRiRNrBXsh8atjKESuqu?=
 =?us-ascii?Q?NZO8P+B3gV9eqQCg0+r0A4atUXhueBTGiinCYHZnwiqRU13jbHMWuQaBA49B?=
 =?us-ascii?Q?snBdkzgxhwKT8KyP22X2uTSiKMizVya/1scPygsR6prC+S7x7d8OLTai60KW?=
 =?us-ascii?Q?iHlyqxM5+XyOD0CPVQmEIlQaius5BKwivgh1yanhe503f7IslZwjD93+4dH4?=
 =?us-ascii?Q?tH1HiKv2gYXd9gIcMoJDflG1Rc2M0TWqYOcscxNbVPACWZSXNUCyP194Vfij?=
 =?us-ascii?Q?Q1PtAwfLdnWSEgWagCGBTBOII7hnZwVOUuuw8aIqnI/ZIpFk5ec2fsemYuoi?=
 =?us-ascii?Q?a01yxGUJufsGJU0pDzlcpvrURe7jI43r8s/0eT+lAw5VaQxgXsq27nxe0cSN?=
 =?us-ascii?Q?RuaQDZBBdlqcJz4CDpUGtTFHkG4mW/Fyhb6kMws2kn0KjDKAoQ0GuHD7J85n?=
 =?us-ascii?Q?c6b2YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca4d676-60a6-4902-e923-08d9f21d08ad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:54:36.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNbyUvTf1XNXs1Dq8xlpGQvitrVPNnK4qXdAa0w38GM2CXXA5aXrlxkUcJJ6xNmf/IyQyQO1gfbBtbMZKDBfgwe3cj3j7vuQeiNtOPDa8Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3146
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170063
X-Proofpoint-GUID: Kdu-irG4gwHOimAKj6WLlwaGmMvDyHzR
X-Proofpoint-ORIG-GUID: Kdu-irG4gwHOimAKj6WLlwaGmMvDyHzR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   36c91f6d572820e8556972fd7644bd96798e85d6
commit: 370c68664d53ff13dbd36847e140df02364387a5 [120/133] ACPI: Add SVKL table support
config: x86_64-randconfig-m001-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160009.rI543Li4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/acpi/svkl.c:164 acpi_svkl_init() warn: '&acpi_svkl_dev' not released on lines: 157.

vim +164 drivers/acpi/svkl.c

370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  140  static int __init acpi_svkl_init(void)
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  141  {
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  142  	acpi_status status = AE_OK;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  143  	int ret;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  144  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  145  	ret = misc_register(&acpi_svkl_dev);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  146  	if (ret) {
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  147  		pr_err("SVKL: can't misc_register on minor=%d\n",
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  148  		       MISC_DYNAMIC_MINOR);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  149  		return ret;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  150  	}
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  151  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  152  	mutex_init(&svkl_lock);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  153  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  154  	status = acpi_get_table(ACPI_SIG_SVKL, 0, &svkl_tbl_hdr);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  155  	if (ACPI_FAILURE(status) || !svkl_tbl_hdr) {
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  156  		pr_err("get table failed\n");

No misc_unregister()

370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  157  		return -ENODEV;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  158  	}
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  159  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  160  	dump_svkl_header();
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  161  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  162  	pr_info("ACPI: SVKL module loaded\n");
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  163  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19 @164  	return 0;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  165  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

