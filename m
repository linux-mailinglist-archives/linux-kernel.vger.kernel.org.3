Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B194BA092
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbiBQNE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:04:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiBQNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952D2A8D04
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:04:07 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HCgvdn010825;
        Thu, 17 Feb 2022 13:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=x/qIs7Oa+UYhOTmeZvuxc0Zf5nyhD61M7G7k1vAN1Ww=;
 b=EkrvxuLxO8Mqwpm2iZan46D0k9WSx1trDC3ajW5QEryxctSqXQ8QtqYcYvid9EOHEe3C
 Z/Hrfwg9ORFTPxx6aC7CbnVNbntVJRyZSIQ0Olz0j/DiM7C6tN/rDkKX+TretbEu5S3t
 g0gsQ2839Snd2PgvmMTsNtxXRsK5lXmf6GkCIABCaDD54JAIlz7T29+xT/ycTrVrZoOW
 NslVzSqsZKGcxqTJljy8/qlEUjxgKmllVexV3X1KAIItz/MM4+RHQAkQFifc3nS7Ll9Y
 D456WLBEBsdW/lpSsHmym7IUH1q5qkde4+OLFZO5Z0RaTrr6m/yUa7lF92kiag0WQLu4 Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nkdnsvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:04:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HD1KKR160158;
        Thu, 17 Feb 2022 13:04:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3030.oracle.com with ESMTP id 3e8nm00m2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgsYoHnEfmhozavzWDi3j4Igz19+Vvgls+G0qxphrTsMY6JdJXfC/Wo/zyC3Vc9SbgJNy4hNkUvg0r4Y50wdt09eoy+5/Lu3P3xFZWTpNSl9KTk6EpKHeTSW4Sir4UcHa2lhn1FQVM7++Yq69bHx3PCFp5jkY97V5uMhhQy7hz6AOLPATpnJYDddc+4tkoVlDAva40Je9GP+jY0vYfVIMLq26Q71SJbAtFbUSBK6fckizc575xwx0wCD+8eKY6i07dGNFg4U3U3w8mvNvurKYrZVp6fPQeDbBZsFZ9LZ9pgaAckSwz1ka4qtRzV/k/QANqGs+ikxSgReqzwWh4oUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/qIs7Oa+UYhOTmeZvuxc0Zf5nyhD61M7G7k1vAN1Ww=;
 b=ASP2/z9/XSGzMat+6imovpUBHqJZ4RCXKJG3W1TnyDZqfjlJg7h+dpQPr0r/FhJeJWQS4MmByqWD4P2KbQuO+9upJ3xDpmGYOcpkR6QGjWVY5m751saueP+nF13lezATZN4w5x1Y/BtIkUYLQUjwrWYtynmcv/Ax/7FX7F4wSHFobNvGsAhY4YEpyrxoA0CJ9hGfmtRhRLnTUiUhBlC078Rgd7WmMH2SX7nflQeKyH1mM9E1Gr+bTrlVT9qfM5NPqHgLIYJblN/C8FNo0vEm964lzxKjjufvIrFBscDUgKscQJeT1kqQOPYmEXT9ByY82UstC5N2QHcGkQUqFWLHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/qIs7Oa+UYhOTmeZvuxc0Zf5nyhD61M7G7k1vAN1Ww=;
 b=PckWntlrl8+Dz+orWijK7dQf6MmjyG5Vg48L4Qm0t4PNd/rwDpfH0aWCDdWA1yXe7AD7SSo7oBGnnFinCXfmD0qZUnYi5ub3ziqcvJ9/gG8eSAoK+xcutNLQFnEuGei7uN79ospi/LzmT74l+r/mvrUxr/zB5nMJfxuedrUBCLQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1450.namprd10.prod.outlook.com
 (2603:10b6:3:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 13:04:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 13:03:59 +0000
Date:   Thu, 17 Feb 2022 16:03:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_fw.c:1209 mpi3mr_issue_reset() error:
 uninitialized symbol 'host_diagnostic'.
Message-ID: <202202150735.ENek3KKS-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71be72c-790c-4d4c-b024-08d9f215f6b1
X-MS-TrafficTypeDiagnostic: DM5PR10MB1450:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1450CB024C90E4485AFD24B18E369@DM5PR10MB1450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoKO3TBxp75Zt4mlALpTUJ5OpjyJ0Cmo5pNlycnZwMT+xE8KIdtwdQWlk5TUdQqnxH9pcUXd03gHR8LhtUt9B0FYXObCt2x/cWJxSk1h0g51zVQcT3kqP8tAYm5Z9ZKHges5uCWpsNoGm4ntFkgc5TbX8UWgVchN7ZfwFwz+jIGh1kVJDMtWyFAWUqW07kA09aoiJ2sqi2ExujRINGAVT3kV8yseDsfa942Ak32/2pxQn3BFjzVmhfFVEbuBgdRI8nPlZaLUIAJc0cjOEGAYyFtfS4V9V/PMmzpiu6FX0105gYyEz5u3gYS7dtBt9corfvsqQvq2oqrrvpWrFuoomE8Si4Wh5/lR9I9dchGRVN1trG+IWZR+aLMqPFxfvddXqRlIdUub/OkePW6PeMg06ETvaspmIPxL9IyBpd2FCiaAPIYezAOTZvrJKSX+T6EP6OIVadHidqJtX/eyeULOp07PKfmNRVdeAZy4qghF9g1qO+lWBV2R+WO3nmf9U+z/hVh4GDhv0+QajlkBxaNCBqy1lKWDu9dLE8pnF6gNc4DCjcZ78Q9wIOEBfiJqVBno0jWWZhBDWryVPrulHsK3Fe15vaxsLkuoHlq+fCSQmVixcXhRNgbY2OJxFF6IRx02cS29C7SBtmuDcXCr1O3HU0ADSdcJPBqTb2tsg1mjNFt012ub7ajU1TFSoMgeoWuqw8WRJIl0UR8xH724ETClD2RbmIwla8o/gbFxoW6k3uQ6tfCuT/F1qtP2aK4KDWCdCQEanqQJShUmJUUQrxO6VQy8MHrP3Z/pJJ3v0Cm7mkIWbGajke7uOrHn9d1VuNz6+ZrktO7j/xCaaFLZtlv4Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(8676002)(6512007)(86362001)(4326008)(508600001)(66946007)(66556008)(52116002)(36756003)(6486002)(83380400001)(66476007)(966005)(6666004)(107886003)(9686003)(5660300002)(6506007)(44832011)(1076003)(38100700002)(6916009)(26005)(38350700002)(186003)(316002)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y281e7UQCPkkfj1XvTlGLEPLwt9sVWfvc+iOl0nKgmQCnmdA4Ml6ypfVxoei?=
 =?us-ascii?Q?JJDJQDp8TBkg8tVSePS8vFy8k6M5FQaKqZAsAsAZkCSl2Aqcf5PV3RH4TCKF?=
 =?us-ascii?Q?bHVdMiHWOinOZ2IuEexNNfONSL+zo0VRix9ANaKIhF8gN4oA/etZGJNMoBH0?=
 =?us-ascii?Q?d5DPXVhRqdQCjytUzyGds2iM2GutAEebpHllCN5jPhjzqo2lK3X8SdyWhmHn?=
 =?us-ascii?Q?HVoJozVk4r5CrLI6qNgutnOS39Jzh31NWL5ExZrxrlUG5mKcdusqdJxyAXog?=
 =?us-ascii?Q?fotnb5Zz7TzTJ96dYgp1Izeh5Q1zzTDtjpm2me/9QSxGNBem+eIccl+rgF/l?=
 =?us-ascii?Q?aI8HCbuV5l6v18xBvavREFNs5qd1ZtSYcvyJlFo25DSZoTc2eG5hn5fxsADS?=
 =?us-ascii?Q?fJB93btK1ufwJxaX36l0BOrnEUVxRrXpCKGjd//HrcB6DkbfbhFkGYPzoQuB?=
 =?us-ascii?Q?FD5dmRUap4CyPJh2pfTPfaLx43WOoVvIiHVw7wInOyLLnIR13IWiiwIgZsaQ?=
 =?us-ascii?Q?/8MGwcUVNEgsEEukILUexGk51xfpkvpUjGxubTgetY155fMB0QGJAtQi9/n+?=
 =?us-ascii?Q?BrkZCI1r0QOA0ORKBqi+n5KJkr26MAzHoi+8jbzzxNtQr+JmKXQeR9jnpQ+G?=
 =?us-ascii?Q?/clUbHvhgkdES2Odh97Miw4v6ew9bKPUYE1UKZ3sVwjFyVg6TymoJGlYEyYX?=
 =?us-ascii?Q?ATrjYhSeXMYbbq9k3/6q/d3BW0ffSoT0XE/3CNXHdKNsnhFeepYjGgELL9gs?=
 =?us-ascii?Q?3FRk6iwu0zey3aGnZUo71ABUO4+OsVu4OfmzpxmGstXpK+95XfKlGwB67XKy?=
 =?us-ascii?Q?83F+YEkjayCf/c8FrCRtCRomnzFVj5PacFiK/jTkgvWD4zuWRpycai/oGKQh?=
 =?us-ascii?Q?R2AW7DZFRyQesBw67RNsL9bliR7j+Dw528rwvUCczgDGHsKtvut3kkjZALTd?=
 =?us-ascii?Q?5BYLbMHNEYi8r1PSZTBHpCUozOn1arXHueRvVI48Eu1xUv3drGZofhKmsbkq?=
 =?us-ascii?Q?qhzC5tWTmctBGFEoKVyBMl3i+4DF/dqw+YwFoGgzN9GZs369VhYk+sDOJ8QC?=
 =?us-ascii?Q?rgiHbZmFBbE4Lnt6nukuzawtIU83eZksp1nSbs9w8UC1FWV5VpFecY5Dg6q0?=
 =?us-ascii?Q?1ZbVxSAGcGG2P4OGzZ1+y9+Zl4g46DUBRdLKJl/NoqxyALXJxyYnGWoKa/G0?=
 =?us-ascii?Q?CrbIj/1kw0E4I27Qawsnj5H5fIBqtIE3E7/MInG9tqK0g63rtEDTOtVW+B73?=
 =?us-ascii?Q?uQmCbNGAmYOv7p3bft3cD11LYqaKiGXPhBWr71lGdmARuSzHnT73xVfoV+35?=
 =?us-ascii?Q?S9zJs5AxYTXmeLi4iKgeEosLsnUu+9Or2FaX8KrSsoSY+iYLjw8IZeUqnepr?=
 =?us-ascii?Q?H2gM/ILaZhbpGZbDI82DEwbcay//7qpOI8Ct6HARvtzxKCHnJ0JJ1Vdff8yB?=
 =?us-ascii?Q?P4vDLt1ixMt/2e4px7H7u2KxZoG8q7K0sMB8O3Czrl21o88UFMW41NTQ+ZKO?=
 =?us-ascii?Q?OnJ5D5TOa15xkglwJS8ui1cTnc8vP0LLQt9jf99ro900v0aRm+dN/hPLWJiV?=
 =?us-ascii?Q?HTdJmi/eSq90k6ajQJXFjgip16l9n08Ym+kz94APHdXpeIQUq2/ofyVJ/K+W?=
 =?us-ascii?Q?XdLjQwct9RktzwdLFDlVraUgD3ZLRjdBvjQEFePglif8uUrOo71jYnaqBnon?=
 =?us-ascii?Q?tsGh8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71be72c-790c-4d4c-b024-08d9f215f6b1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:03:59.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBMD3lvZEatJD4N8PZ6lMTuih7aMGygMnJHUa4Rdlm8Nn0YI4cK4ZZtBOVYV5D3LS7lc9J/jIb5NWDw7c/5m69CF6QjG4N605g9GUDZDMuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1450
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170059
X-Proofpoint-ORIG-GUID: luA93GJR7OipmE0lACbKjPZqdK6Gp4Tl
X-Proofpoint-GUID: luA93GJR7OipmE0lACbKjPZqdK6Gp4Tl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d567f5db412ed52de0b3b3efca4a451263de6108
commit: b64845a7d4039ab9667bafff9d7bb59365f17c0f scsi: mpi3mr: Detect async reset that occurred in firmware
config: s390-randconfig-m031-20220214 (https://download.01.org/0day-ci/archive/20220215/202202150735.ENek3KKS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/scsi/mpi3mr/mpi3mr_fw.c:1209 mpi3mr_issue_reset() error: uninitialized symbol 'host_diagnostic'.

vim +/host_diagnostic +1209 drivers/scsi/mpi3mr/mpi3mr_fw.c

824a156633dfdb Kashyap Desai   2021-05-20  1181  static int mpi3mr_issue_reset(struct mpi3mr_ioc *mrioc, u16 reset_type,
824a156633dfdb Kashyap Desai   2021-05-20  1182  	u32 reset_reason)
824a156633dfdb Kashyap Desai   2021-05-20  1183  {
f061178e076210 Kashyap Desai   2021-05-20  1184  	int retval = -1;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1185  	u8 unlock_retry_count = 0;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1186  	u32 host_diagnostic, ioc_status, ioc_config;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1187  	u32 timeout = MPI3MR_RESET_ACK_TIMEOUT * 10;
f061178e076210 Kashyap Desai   2021-05-20  1188  
f061178e076210 Kashyap Desai   2021-05-20  1189  	if ((reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET) &&
f061178e076210 Kashyap Desai   2021-05-20  1190  	    (reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT))
b64845a7d4039a Sreekanth Reddy 2021-12-20  1191  		return retval;
f061178e076210 Kashyap Desai   2021-05-20  1192  	if (mrioc->unrecoverable)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1193  		return retval;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1194  	if (reset_reason == MPI3MR_RESET_FROM_FIRMWARE) {
b64845a7d4039a Sreekanth Reddy 2021-12-20  1195  		retval = 0;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1196  		return retval;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1197  	}
b64845a7d4039a Sreekanth Reddy 2021-12-20  1198  
b64845a7d4039a Sreekanth Reddy 2021-12-20  1199  	ioc_info(mrioc, "%s reset due to %s(0x%x)\n",
b64845a7d4039a Sreekanth Reddy 2021-12-20  1200  	    mpi3mr_reset_type_name(reset_type),
b64845a7d4039a Sreekanth Reddy 2021-12-20  1201  	    mpi3mr_reset_rc_name(reset_reason), reset_reason);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1202  
f061178e076210 Kashyap Desai   2021-05-20  1203  	mpi3mr_clear_reset_history(mrioc);
f061178e076210 Kashyap Desai   2021-05-20  1204  	do {
f061178e076210 Kashyap Desai   2021-05-20  1205  		ioc_info(mrioc,
f061178e076210 Kashyap Desai   2021-05-20  1206  		    "Write magic sequence to unlock host diag register (retry=%d)\n",
f061178e076210 Kashyap Desai   2021-05-20  1207  		    ++unlock_retry_count);
f061178e076210 Kashyap Desai   2021-05-20  1208  		if (unlock_retry_count >= MPI3MR_HOSTDIAG_UNLOCK_RETRY_COUNT) {
b64845a7d4039a Sreekanth Reddy 2021-12-20 @1209  			ioc_err(mrioc,
b64845a7d4039a Sreekanth Reddy 2021-12-20  1210  			    "%s reset failed due to unlock failure, host_diagnostic(0x%08x)\n",
b64845a7d4039a Sreekanth Reddy 2021-12-20  1211  			    mpi3mr_reset_type_name(reset_type),
b64845a7d4039a Sreekanth Reddy 2021-12-20  1212  			    host_diagnostic);

Not intialized yet.

f061178e076210 Kashyap Desai   2021-05-20  1213  			mrioc->unrecoverable = 1;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1214  			return retval;
f061178e076210 Kashyap Desai   2021-05-20  1215  		}
f061178e076210 Kashyap Desai   2021-05-20  1216  
f061178e076210 Kashyap Desai   2021-05-20  1217  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_FLUSH,
f061178e076210 Kashyap Desai   2021-05-20  1218  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1219  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_1ST,
f061178e076210 Kashyap Desai   2021-05-20  1220  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1221  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
f061178e076210 Kashyap Desai   2021-05-20  1222  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1223  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_3RD,
f061178e076210 Kashyap Desai   2021-05-20  1224  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1225  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_4TH,
f061178e076210 Kashyap Desai   2021-05-20  1226  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1227  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_5TH,
f061178e076210 Kashyap Desai   2021-05-20  1228  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1229  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_6TH,
f061178e076210 Kashyap Desai   2021-05-20  1230  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1231  		usleep_range(1000, 1100);
f061178e076210 Kashyap Desai   2021-05-20  1232  		host_diagnostic = readl(&mrioc->sysif_regs->host_diagnostic);
f061178e076210 Kashyap Desai   2021-05-20  1233  		ioc_info(mrioc,
f061178e076210 Kashyap Desai   2021-05-20  1234  		    "wrote magic sequence: retry_count(%d), host_diagnostic(0x%08x)\n",
f061178e076210 Kashyap Desai   2021-05-20  1235  		    unlock_retry_count, host_diagnostic);
f061178e076210 Kashyap Desai   2021-05-20  1236  	} while (!(host_diagnostic & MPI3_SYSIF_HOST_DIAG_DIAG_WRITE_ENABLE));
f061178e076210 Kashyap Desai   2021-05-20  1237  
f061178e076210 Kashyap Desai   2021-05-20  1238  	writel(reset_reason, &mrioc->sysif_regs->scratchpad[0]);
f061178e076210 Kashyap Desai   2021-05-20  1239  	writel(host_diagnostic | reset_type,
f061178e076210 Kashyap Desai   2021-05-20  1240  	    &mrioc->sysif_regs->host_diagnostic);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1241  	switch (reset_type) {
b64845a7d4039a Sreekanth Reddy 2021-12-20  1242  	case MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET:
f061178e076210 Kashyap Desai   2021-05-20  1243  		do {
f061178e076210 Kashyap Desai   2021-05-20  1244  			ioc_status = readl(&mrioc->sysif_regs->ioc_status);
f061178e076210 Kashyap Desai   2021-05-20  1245  			ioc_config =
f061178e076210 Kashyap Desai   2021-05-20  1246  			    readl(&mrioc->sysif_regs->ioc_configuration);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1247  			if ((ioc_status & MPI3_SYSIF_IOC_STATUS_RESET_HISTORY)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1248  			    && mpi3mr_soft_reset_success(ioc_status, ioc_config)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1249  			    ) {
b64845a7d4039a Sreekanth Reddy 2021-12-20  1250  				mpi3mr_clear_reset_history(mrioc);
f061178e076210 Kashyap Desai   2021-05-20  1251  				retval = 0;
f061178e076210 Kashyap Desai   2021-05-20  1252  				break;
f061178e076210 Kashyap Desai   2021-05-20  1253  			}
f061178e076210 Kashyap Desai   2021-05-20  1254  			msleep(100);
f061178e076210 Kashyap Desai   2021-05-20  1255  		} while (--timeout);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1256  		mpi3mr_print_fault_info(mrioc);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1257  		break;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1258  	case MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT:
f061178e076210 Kashyap Desai   2021-05-20  1259  		do {
f061178e076210 Kashyap Desai   2021-05-20  1260  			ioc_status = readl(&mrioc->sysif_regs->ioc_status);
f061178e076210 Kashyap Desai   2021-05-20  1261  			if (mpi3mr_diagfault_success(mrioc, ioc_status)) {
f061178e076210 Kashyap Desai   2021-05-20  1262  				retval = 0;
f061178e076210 Kashyap Desai   2021-05-20  1263  				break;
f061178e076210 Kashyap Desai   2021-05-20  1264  			}
f061178e076210 Kashyap Desai   2021-05-20  1265  			msleep(100);
f061178e076210 Kashyap Desai   2021-05-20  1266  		} while (--timeout);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1267  		break;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1268  	default:
b64845a7d4039a Sreekanth Reddy 2021-12-20  1269  		break;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1270  	}
b64845a7d4039a Sreekanth Reddy 2021-12-20  1271  
f061178e076210 Kashyap Desai   2021-05-20  1272  	writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
f061178e076210 Kashyap Desai   2021-05-20  1273  	    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1274  
f061178e076210 Kashyap Desai   2021-05-20  1275  	ioc_config = readl(&mrioc->sysif_regs->ioc_configuration);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1276  	ioc_status = readl(&mrioc->sysif_regs->ioc_status);
f061178e076210 Kashyap Desai   2021-05-20  1277  	ioc_info(mrioc,
b64845a7d4039a Sreekanth Reddy 2021-12-20  1278  	    "ioc_status/ioc_onfig after %s reset is (0x%x)/(0x%x)\n",
f061178e076210 Kashyap Desai   2021-05-20  1279  	    (!retval)?"successful":"failed", ioc_status,
f061178e076210 Kashyap Desai   2021-05-20  1280  	    ioc_config);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1281  	if (retval)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1282  		mrioc->unrecoverable = 1;
f061178e076210 Kashyap Desai   2021-05-20  1283  	return retval;
824a156633dfdb Kashyap Desai   2021-05-20  1284  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

