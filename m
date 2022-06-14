Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62AA54A3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbiFNB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350600AbiFNB5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:57:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393833EB3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:57:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1MVek025660;
        Tue, 14 Jun 2022 01:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ScnGBoHMNJFEOoWN8cTawVClpzxLYzM7gOvPp9kblIw=;
 b=x/FDna6jr4xvbGCU0UiJ+Hy3CW+MkLJtsXwgr4EldTebKQmhYzOHPSi9Wh8TZAXgg/VS
 Lxx4o+9wk21EMD78gJhGbbHCeCDQJwWkhLE8NqvVowVFsQoTEdsV/TaJ7ui1xSoKiAaR
 GCmko827PGoUTjN/YYYmtawR9aV5F0YlRe+DnLSlb3jWw0VY9/SdoqtS56hV+1U+MDom
 a4ZHSiVnlcN6xI0rtTgruWjGuVNMMFCtcQNVK7DkU/fMbO6G6SZVLoyl+G6XtUFWs0aH
 8IfoaS0/qGSQFvc3NDZeuGhb6/DCGqn4GUYRungJBi4pRXvsV73GaWWxeKMo9DTSmFqk Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9cfun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 01:57:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E1oGhB005388;
        Tue, 14 Jun 2022 01:57:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpgyer47k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 01:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI6mGHrlLgUr9U3HdenbWAxT38sq0j0nX/jox2ccfgTiIg6BPT6vKefLNgrY0Ng7lFBt9z8S2yBdnQmbYZLwZmDPbz+/uinXhI39u62CgZz5qNjs/YXgV6zseCD7xgvBDBfoqH8T6FjBu+yEfOhVNqc+84OZ5LVptw2/POZ10fpklEOlf31mbsYIe1eBHbzYCzhOka2bqs4R+jZh0diIpVXB8TMdtdXzM4NmA1pGkodUY/Ta1gIeilx5X9CoCnzw5l0jMUvjmLPQZ2eUEGxY4Pads5w8hoZqios7XUTG4lxxz4jcf7R0eLKr9zb9sNqBHoj1dd/qcrC9h6ILnLtfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScnGBoHMNJFEOoWN8cTawVClpzxLYzM7gOvPp9kblIw=;
 b=aIbi1PkbmYPAbphe61599GuIJhxuNsA9Qiv2MevMkUctdZHyC/KH3aoU8pKaH6l0OKFEegAHn5U1KThxLC4dtb+txjM2r8i0EUNJyU2Qr2MBjKBm7MiOQ1lRLlzOfYAOtoRug1hDMplq9t6IzMMTNkEzxIPu1m3ah7mt222XrizD4bSquxjiCFDpf82iPdtCnOXFeqHD4oBtsPAW3MQ/3JonCSrLeGXOVjL/NqgjdkAmfPUQVvSf/4oIMLRDH2mb2NPllQTNCriK2xeWbZQCCWwM8NxHxMuifKx6xzpTRmZCnHUWxTx20i+m2EL9ShKWTZ0D3xjqYN/Ppel1wfuOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScnGBoHMNJFEOoWN8cTawVClpzxLYzM7gOvPp9kblIw=;
 b=MDfRTKCrN/gADE3k1KWdEBdIDYJ9DgOFfeV8o4xfPpt3Xrfh4P67iLGmMczIQmZCgnA3hoU5hd8QdbQb1OvBQ0ZsKj7zK6tqDv5rSBNs2S9qVNf2brlD0aBrKNBw51eQqBfEbp2cnC/xJuk0Km++9S1ez/zwd6FGjCKxXeCHKoI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB2949.namprd10.prod.outlook.com (2603:10b6:a03:8f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Tue, 14 Jun
 2022 01:56:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 01:56:57 +0000
To:     "Alim Akhtar" <alim.akhtar@samsung.com>
Cc:     "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'kernel test robot'" <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Bharat Uppal'" <bharat.uppal@samsung.com>
Subject: Re: [mkp-scsi:for-next 31/41]
 drivers/phy/samsung/phy-fsd-ufs.c:50:3: error: field designator 'cfgs'
 does not refer to any field in type 'const struct
 samsung_ufs_phy_drvdata'; did you mean 'cfg'?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkuwt3dx.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220611233355epcas5p1970bae9647eae17e20d330775b584695@epcas5p1.samsung.com>
        <202206120755.03gKC0ne-lkp@intel.com>
        <000001d87e12$c6962770$53c27650$@samsung.com>
        <yq1mtegt3ym.fsf@ca-mkp.ca.oracle.com>
        <02b601d87f91$8bce05b0$a36a1110$@samsung.com>
Date:   Mon, 13 Jun 2022 21:56:55 -0400
In-Reply-To: <02b601d87f91$8bce05b0$a36a1110$@samsung.com> (Alim Akhtar's
        message of "Tue, 14 Jun 2022 07:23:27 +0530")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:160::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be23e5a-2018-425a-75fe-08da4da929df
X-MS-TrafficTypeDiagnostic: BYAPR10MB2949:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB294954B28529CF2DB02CF90B8EAA9@BYAPR10MB2949.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNa+A0zr8iGECvB1lhKgfTOuZLyZtXpAkBvSELsFck71pISmjdYsGd9ift41CsT4/yknEE2AUt1OuZAcTMPg8GzW0O+1QN1Rv+07De7IQ5yetYA3c5s0o9gJfQykBPQKHbRMmYhy8NsCgbAch4l41ZPFq+ZI38KBnO1NbYeSX5lwQe/ME8Sp+Eg/3M3UJBxeaLY8I4EyoDJbS5UTOrkfEtfUiojm9ugEHeH1RM7lnCpYi1vHRydvCoVzr3dtYc6dn0BFezcOH3gK5s4w0Fl251fHG6pi88k9y5zygmac/XH78xWeabIGYEEfGjwTZF9DjbrP++xhNddTAbeRuMApoutjb1/iO5lMhIZwCZtUrREEz1LHDv5BYRHvb1kyuRf231WE5E22cGf5RN6O8SapW9PlXIB0iiJ+aV5OZuEdWWvDfjF5tMEYsCoDcN8HM+ss3Yyiqi/Pn82SdMBfqgrICk56aqO7Vn2mbN1L2OUjL5HePkr4vj1lbZFBHn9joQ0tX42A8OmxTUS3o2wKdWMptO4KjH5HBDnkqaUFzq+3hIFhpEgvdwBwKbhcwFYkZ7OMPeV5dsl5P/kT+wivcN809v+WvdTXdDyIyvy+hsKBiCt3YDM7jPUdWxdHGwZZS+RNq8hkjRgxFq9P866Gg19Rp4ygehuf9UZE1gTehROyD+9ITDKiTaziZQGckh6HR9ac+PX/BbPlQ/rMEFr/Vh6Awg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6506007)(52116002)(36916002)(26005)(6916009)(186003)(508600001)(54906003)(5660300002)(38100700002)(558084003)(38350700002)(6512007)(86362001)(8676002)(4326008)(316002)(2906002)(6486002)(8936002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+lf5N9pJC1ib9BikLGf6iNm+g7jldUPWIKolWS2BgXcU4dfx2pOCtSxU7HM5?=
 =?us-ascii?Q?wYQGXLCTN4J6hBCFC0x8un6mfub4Syk9vGDk5Jc+5NUiIzE2Ix+oUiFxfGW8?=
 =?us-ascii?Q?VX/KPmKNAAbOVYJUHo3peR2stgi77R7KaCeoaL/FrFjrkGyC456DJ1F6cJnI?=
 =?us-ascii?Q?kqcOVlnFpn4nMvY/SyJuN/bFYGFEH5+Wu+fr/psEJMqqil9OxueAN+toQ+mp?=
 =?us-ascii?Q?WoKT9/RvLt0BvqkuiUKfE0S8JHIJFxSQ8FI8/wtiaaY0DOvqBHLoMj0tDShF?=
 =?us-ascii?Q?pwAegMJ6ElFU/uVOdQg+4OrlJB1sjJLlJec0RwAlghFEyCCmTi8FH02FoqAx?=
 =?us-ascii?Q?UoaemRLdh6buMARrTxl7f2Pu7EIfig4tMgF9d6Z1HE/dU7rI9ZLxu6Z9lsq6?=
 =?us-ascii?Q?aJWoW/TTsw2IkXtaVNJ4U3IbTCjOXCsNC4t9pUrBui9AxMpUCN3/i/HBt/qh?=
 =?us-ascii?Q?nA1YeECCvK3I0E/+jNlFI2kBHgYoU2+9TdxS8BWkKvjra7+MLJuyYJfpk+jP?=
 =?us-ascii?Q?rt1GDifdKee4SjgZ4y7ho9kmr91bKBf9l2twYjkCbw00q6UREcXfUGRz2w7b?=
 =?us-ascii?Q?a1MltEpC9jxhvl9zpY24eWUIApCoZ1lrszGeGjGaWB1IBjTCacZKcQvgBkdX?=
 =?us-ascii?Q?XTWDcWOUsoGVU50qwgemHmCO/JEmXZaQ+/LXZ0M+isJKSlXMdEtivpYS+MBa?=
 =?us-ascii?Q?oq131FZRWmWg8GOMBcngqlqZ362/QY6fyN1pFcSGXsaeMmJEf3KLuSX3C3oe?=
 =?us-ascii?Q?RHYVyqM/qwQIovmRp1EyY+BKTTzjWKvwoAzNtwZ+2BCKlawPptWJsK7LZ7Ss?=
 =?us-ascii?Q?UalivHfPbivZEjCzOVnJWe+12ESGqF2v56q9ViKha4QBNsRhDgvSLHkhjAtQ?=
 =?us-ascii?Q?IzlBNAu08H6Vtu7/o+GlVA8xSIBlxlUZb2eRx4vEizF2kJ0iN3YWuoLaiZYL?=
 =?us-ascii?Q?/YS+T+yesxT2ix2B9+jlpKsIJDH+JmhED7Ypa5rAsiuvEZ99j69uaNDbIhOL?=
 =?us-ascii?Q?tBmPYuD4c/GOiVErCEQBr9/Ss42Zum2b1wIty5mrhev9I9jiWmMo2q+KwwvR?=
 =?us-ascii?Q?6caFp7uSvCzP7Hs8JJ+b391EnPYYxoTuk/m64SjfaQqHV7Ivbxsf5kLFX1qW?=
 =?us-ascii?Q?DX9/gWN50jPTqW1jpUubp+vex0KhzL47l7fIw8+3IN0yZWtxngO4RHHxVwV0?=
 =?us-ascii?Q?DxV4rU4MD0TDcpLgbkgMXh2f4zq/J1064uCn4mIolpX88VdqfQGQJnYJRmV9?=
 =?us-ascii?Q?FvQY2bdePCuNfubC11j0B/gkYHoostV0hkOdAtjVf0CzHICj7HKRgXHc0gBO?=
 =?us-ascii?Q?R67f7y0YMruh5cdATAcSkzdOyP4djnXklTFjM2/byrsBUMPyL03QRw/lOEpV?=
 =?us-ascii?Q?2k+XFT9/90W/w2YzYg/K+AOF5E9DwDlu3UKZXSWBUfAYMu5ckPnHT5X/VNjo?=
 =?us-ascii?Q?8PxJ1+S7WmcEBqNsVqhH4x5fxw3dICDKGvhHl+mQuFsgPBpozqLYwW9h7UAF?=
 =?us-ascii?Q?/eWtei+G0lp1Y/WFNhv2Vidc4I08PDOEZnywUhnw3fmQddIu9WqX1Z2dRWB6?=
 =?us-ascii?Q?i7wqDeGcXVStgCiGBwcbR5aB38WM0zjrzZdjd0n+Sxe8qukH4u2m1rAmUvjf?=
 =?us-ascii?Q?yG69oC2wDvT4hk/pd+xlRvoeRTRRDBDQLakm9Qp90bAkuKdibP/7bGAFDpAM?=
 =?us-ascii?Q?nYkaIw6cZFg7kN8TUevPAYnTo96QmLruqUiZprPvEUcE4XUUzKfTw6L6Hqta?=
 =?us-ascii?Q?dZg8/ISPFRCceuf3h+X/UJGqMFZvyuM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be23e5a-2018-425a-75fe-08da4da929df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 01:56:57.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/vQ68RxFDJ68o4e81klzCqtRRZGg64gYgrhJw9Efsi3lxDY0fUkX0cAiqUiYtz/LjlozekRW3q2PmaP3UgnC+/kdheoqd53nsznqcjHGc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2949
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=615 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140006
X-Proofpoint-ORIG-GUID: xfarozmu3XTVIhkS2iIe6pJDtf0mmDYW
X-Proofpoint-GUID: xfarozmu3XTVIhkS2iIe6pJDtf0mmDYW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alim,

> Just drop patch-{1/6, 2/6 and 3/6} (phy changes)
>
> And please keep patch-{4/6, 5/6 and 6/6} in your tree

OK, will do!

-- 
Martin K. Petersen	Oracle Linux Engineering
