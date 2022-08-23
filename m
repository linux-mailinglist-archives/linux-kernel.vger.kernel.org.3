Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC159CF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiHWDU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiHWDUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:20:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B54505B;
        Mon, 22 Aug 2022 20:20:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNx5iW002888;
        Tue, 23 Aug 2022 03:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=vEYAtG9H/v4OqNXwp8RjYlS2UsI1b/N2mTX6cFm+qMQ=;
 b=ZLITgfeuqfd8/x7vZWoAFhPC4VrWSbDYAzEByQVyUQIoTecl7xa7upOuJHf/stuODXCf
 OAHSceHgYNmDkGRjeU6TylBrf724DTHeQcf8lfLD8rbgUZ1+kSOG3rJz9FjaY50Xeajd
 TXw99+jtNRkb1GjAkg4701yjs072XJwAI3Tzn5hElK6Bz2ci5ig5P+q9UmA0nYUbYOoO
 P5dpbNZntRthoOsKx7BgEkr7HlgDO2G6CC/YZWoF7T/wtkl6oV6JmREVFqPSIA1k1llG
 aIsYajMsEyNUscWpeg9OmJ2S8VSxuzQ5zcjAH2Iz6TMz4pAi1AyyE+1fiOueMHgHg74v iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ea70y0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:19:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MN3ksK031821;
        Tue, 23 Aug 2022 03:19:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjdnbsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKfT1QizSkxnyp4O5pvOoSlqfaeDD3HHOZDWF23ctvOlB/vbzzOHOqPpywnryBcfwwDop7kVVmrvxfFXZahKqHPxLWNGzuTSds552jLAxWpCQSfBuwOoRrXzhF+dbOxwjG7fGiPsruToqsMJQJtGKhLOOqxJ4gZVZGxHmg5yXP6bOUDPs+WiZWe6hLELB/2YaKjl0PP3Jad6bXAROr+oJgAksDJggftuSowCKmAPixwhrDrekfNBRq25gXrEHqIN0/xwi0NFlZTLHyE7n0lA/gVOJPxV3/CfuKOZZFEySb3JDP2v4wyP5FgwMxOCRDyPf6WxD/qxxVSLFY8Nuz95NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEYAtG9H/v4OqNXwp8RjYlS2UsI1b/N2mTX6cFm+qMQ=;
 b=DSNkye17Hwxs/0ynF+64wmM9+s7kJKAL4OSJKKWsVQm6gQLGZ19KdDeWA0tUBw0AEB5k8WzQU9/mFc12Q7fFaat52FROJ9XXf5QDO4MPHfLUH3vJ7uPNXMLTuSLmVCYPc5KvUoodfHi8sbLLfLi2VnZFEpKos/4GvPFbb9RLoa0M4owsO5nLPNh3D9rgp79mq0S90T9pH0H/2iwS+Ac0iluhMSfDx/UYRBzZ9VMCsB/DwpYWEbRWw8/zPHE+SDSDC6Tq0Y1FHeBdkbaCR4IBHC+UXE6CgxcZxGi2H7ZmeJweI5YxrgFSMVPgovyUwBVdiCmatq8uXyNKyIcYFkz1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEYAtG9H/v4OqNXwp8RjYlS2UsI1b/N2mTX6cFm+qMQ=;
 b=IxFqk7A+M3rIkdUG5Fve0W+9gUUmn8l7gXxLld/uUh5Nx/NMyySnT1ITNNlTEAPBRKpmlqLjhhXSoo3Y/sW9P6xf7pKjCQgwatqyeP6i97hRU2JCeMlirHYk0T+loH3uKWarJpHhhesBRdUt/OlCfir0ZpIyKACLYUrT21yAXRQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4075.namprd10.prod.outlook.com (2603:10b6:5:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 03:19:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 03:19:29 +0000
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/6] scsi: ufs: wb: Add sysfs attribute and cleanup
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zgfvabpn.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
Date:   Mon, 22 Aug 2022 23:19:26 -0400
In-Reply-To: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        (Jinyoung CHOI's message of "Thu, 04 Aug 2022 16:42:24 +0900")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0094.namprd06.prod.outlook.com
 (2603:10b6:5:336::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e27f1d8-50c2-44fe-151b-08da84b64a79
X-MS-TrafficTypeDiagnostic: DM6PR10MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbfOIgUcD9lC1qjM+NKMRAwcFwPTfF0iiJ96texQZZO4Icd7lkShXxsbLvSY5o7o3ZjHiVXoUBWBGIHu8UCZbC6FU16vEcgqBlhAhZBHMWyXBjcDF6dIZ2NmARrVDRsDxC38OObuZAWhHae4g5tzL6U5kd54TTSZo6fBKduWzIg7n4BJHqESl9980f5ETLRl3c4a1JkoZ+6uvDDRGKUFoXi4nm+O0e7aOr2r1nff5Cd3zI22Vlj4l9b64n+Olu784P5hflpXSxh2pTL4dnws6WZ6NSleDOUhKtk47473860DG+zFjOnAOhd6sIqxxOVFVnoTsFjaSxqx/Sslyeke5x7EXhE6DCXVXs8BAX3lYEzTdPQ9G6zDWKRutvQYA4akVloLGqch6dEfHwC85sFIpxLoNSLkt68baw6pZcmvqHZQ6okaDQfOt2/tn8itB9unbbVaTk0BGeNPA2btVDwf5hp7qYKSA+ufx9DxMdAOg8hzU69fMTDZ9Jmn4ZdX0EkutRhyn0sGik2BgjEBzjTwLqrJRy9GRgN7rNM+1NHADukDCRN1+3US/uvMla8QgXolz5TTJB6FDPmiYwCloPGFmPmAAwY6MTPKEwemIoHSPGvI/NrSF8g2hWtIKnFrDK2k43Tms7g1Ed9wPFBJosGJf0JR2EYsu0FgMRaUK0iFXeSgVdw0G3hVV+U8QPSwHRckWA7Ipg49+2kVIxvI1W0sXcD3EO1y7lZeI1tKURk2JmN+P1IEj3OJtzn9jHNtMENtAHL/JBAevG0mi2KaS+2DmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(8676002)(4326008)(66946007)(66556008)(54906003)(6916009)(66476007)(38350700002)(558084003)(38100700002)(86362001)(52116002)(186003)(6512007)(26005)(8936002)(36916002)(6666004)(6506007)(41300700001)(478600001)(6486002)(316002)(7416002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1Y4+HabueSfBAjj4vdAjazdksVuQO5yF7KIV4CWQt7QaeXyPJWs2Rs5ffna?=
 =?us-ascii?Q?S23PTYjoAjNQLXqETB0anAHjm6GnTLeCTRTdTS55ah81cNtfXTZiuxnP4eeO?=
 =?us-ascii?Q?7njel5viBlVcr85FkNgj6jhxlkDDvZfTNfUZVZOIUU2sfHHAyhMQLOfSK28t?=
 =?us-ascii?Q?HpIXVypo82DKIgp9v95tiNfEs8JnjrLuaXIFT4DRfQeJ7M9G4gnvwgdNJp61?=
 =?us-ascii?Q?F+SAWasNiNyHPw/D95TK2pL9CKKxNpCJPTQdv2TPIjvDZ/vlSK0LTGM0f34X?=
 =?us-ascii?Q?dOZm25wzRQEEa2G0PP1WMeckfA0d+KVrh7uFW3KwC8vq3u1Pa1+aTR1Xw7Tc?=
 =?us-ascii?Q?/784ZBGnd77u5x1owyAs/+kZ0XLgLc0C5TvHyLayS/TAyQJAf9dHT8jkyoMz?=
 =?us-ascii?Q?bSxmOpB8m9clxcaKsGyF2xge0M20IzOrSuks05aNQWkkrPjfZ/2sb3118kkU?=
 =?us-ascii?Q?r/0Ki/rkqA3PM3OOxQYsDsCJ1niPdUVvJJTqPQ7HwZpRhyC3EzYjPXEvSRew?=
 =?us-ascii?Q?mcg+WAxy3d9LuyuhkJ4RBV4YrlwgsrKV1PponDe8U1LTAeaBcy42XIu0AiMb?=
 =?us-ascii?Q?HoSZC4zE7WG3nKl70WwfhrKxpbICdg+EGWvpXSb+4RYMK2skukVshhzouD0P?=
 =?us-ascii?Q?0tXuNcHO+21GJmfT7ds3CzJM+KDE13JxXl5egxwcVdFpKa2R+gvsF58EWjGB?=
 =?us-ascii?Q?kCz5e+urYayQfs/FC6DjoOgzuPdrt56oiOmBVp+Bg3qIFYUImBSOdJNf/inV?=
 =?us-ascii?Q?08mvl3FKWlBBj8cwrtXVLpgNlx1LZGtZK1QRWSUHskq16R3BTgGBEtrCXkxs?=
 =?us-ascii?Q?v9PULaHxqIo5+Y26ObheW+Kz2Aj3jnOZD36idfd4g5xJ9bguGCc+1M2vCqW9?=
 =?us-ascii?Q?DLKjHCVtEKNP1C6i7KIxrYeomDXGkZIDoqkpgl+wJYwYgUfXTrxHfpFfLj4l?=
 =?us-ascii?Q?nPyGJl3brKaluLyVmi4RjJuaIOWMdXEvA5EFXh8ThWdc3KgWteo6asUy++y9?=
 =?us-ascii?Q?8BclMYJWqMQTY2kiiJd549SvEV96FqzadGVD9IzB7mTy/7Mt/0/h8Zw6wi7f?=
 =?us-ascii?Q?N9jJ7HJj6D2mlzVovEWllZgXunh0jgMvQNW5fTa3Z/BV/VSnuZPsb1Z3KA5M?=
 =?us-ascii?Q?S8CRjssP0dcFxcgQhfoMHHNPMCFD6xtvOQsaju1Z8XZ1S/lIoPgc1qsnzjoS?=
 =?us-ascii?Q?835Rilm3/htbC8/46377tl3J1+dpBqk8yPR27vgw/zCP3keO5lfg9O9T26bA?=
 =?us-ascii?Q?TYzbIO6hphKKC2a8QMXdG1hpii2z0Ngl94LNU1GDcLwGBa5dLo39Us03rscm?=
 =?us-ascii?Q?rU+zrNxIGXY7RfGmj+MJN+7mq1ouhAY25Cv8ShCnRFsIFDGXPcB3oBvSDYq1?=
 =?us-ascii?Q?bz4/VR7fTjDs0VXXrcJ9q97hgrl2uy8kUTtNDyFKf7CqvMPQ7R7I8E5O9FQ2?=
 =?us-ascii?Q?Vo90/vbqqvNiI5odiEIc2BZO4i/B3WB+XnRjCbj8LGviE9D3UabasMQPfv+v?=
 =?us-ascii?Q?Kbtg5oIHl9wmVjozdILbArS+KRgLphqHB4VrEvy3eU10fzM8vnDqvT/8/hOM?=
 =?us-ascii?Q?p7/dzZNTWchXTzakluvd/57SAPTMeQaEQT8y/o+CGxm34jvK7y4KfppR32OV?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e27f1d8-50c2-44fe-151b-08da84b64a79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 03:19:29.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q19FgkI6YG19tdrBtiFlw/f68auX00IXxnxdWTUDVj291kY5nO5+azMyZtWrB/kjnVbJulx7ZqGUObD4DmmBQ+aoKOMepmsIEtMUk+6KG4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=710 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230011
X-Proofpoint-GUID: 7x1FFdo6w-HF3l1SNomOrif7enKZgwCB
X-Proofpoint-ORIG-GUID: 7x1FFdo6w-HF3l1SNomOrif7enKZgwCB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyoung,

> This patch series is to clean up UFS's Write Booster code and
> adds sysfs attribute which can control the specific feature of it.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
