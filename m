Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB64BB0C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiBREb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:31:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBREb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:31:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B22637;
        Thu, 17 Feb 2022 20:31:40 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21I3aRZq029147;
        Fri, 18 Feb 2022 04:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=vPTkz/hSktKPdhegba17mYx6OeyYzeNWSaGUwzBhWzU=;
 b=Px1zMnHu8pyQ2MMQUcXYnbwNiM/phkdRhjRnzqWcul1TXu+oPiMoJhHmAM4BvjIbwOLa
 xx1UvdXB3nOBh3hVoTcgy5g1ivTGxujLUabO4nHVAqnPfI2zgZe4ICMeNY0X/wZbBP63
 MBjP7fTzwGmyiChvaPESmBkv0re6jk2JxXbHJ1Ez/43C5zjce0KWMIksxbtV36CZtYMD
 HkPZjj/MAOSwyoumB2Xj/Fir8EOOqgo53ZPi/IpCExAv6vI+3whADSTTpHEGWWLwpPr3
 aiubjxpnubiBGmQcEGO5E1gE4hQM/t6+GxC/xE9tJUotRriUjiHpRpky7GR2LvQDaNya tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncb03jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 04:28:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21I4FKtA114071;
        Fri, 18 Feb 2022 04:28:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3e8nm0mpt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 04:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMNh55lSvLYt/gHdOF4CVpbTtse45bfcNDKyhYRSLSWvvYGOxHKTECiVX+tDyGbO7e3/vgPV6ZUGeWckPAUANhwUxU3zhhRuh8ygvqNlu9VpspJtHnx18y/2t5SsAQpCuhhH+SCo3HdWMSEAxGvk7gVFi7npJOEpSJ1Tu8iZZ1yfX4CkDtQ++RJmkY+JUV8eD4VY6SEHykVYEOz8sMcaj/xOkU8HliUYyQvc/k0bDKkvbpEFGz+oemgwCbuvtvcQaLaeKYCBaQDY6J3wbgVqYKnNWoRfW7FBndHA/1X+KuMiwJgUGgdTWfba8SYqhyW3HVnqzkc7MbyV1XO2IoMSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPTkz/hSktKPdhegba17mYx6OeyYzeNWSaGUwzBhWzU=;
 b=KRqEW7cx+nWNKXzql6iRIjqVOQQPvihlMP+rDAnPr1ii5wFIzh8OZ2ubmn8IyCaW285T10PMc567ygTk6zLb98XqwysqYtjQU1/ieCFserYOP9nfVlDhDvS429SEsrLuMY4pSGGczjVurtvMhLjPmPbS7NSVaum8v+2R5tRQ8qbIDr7DeEbW2+Cg30KMZkUahDhVRpc0nA/AQedoultJiRu+Gl4lj6Ih5Zas7kYfbQxRf/m5I1hG7npKg58L8/uUky39IgxbOKblqrSWIRbTuajIn1r1OgC55A6v7mjehkawbjfAwRjyqZBu4JXObcJAQjvMAjRQKFAITd7JhbOlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPTkz/hSktKPdhegba17mYx6OeyYzeNWSaGUwzBhWzU=;
 b=CFCppLQP0ybjP8jL9hTlbblfgjrUCH/2d+zGG9/ILWnTddz3BvLpb9N1BuPi69B/cae5cB0jd3ViU7wxPmQ2aCS/Vo67IUxZThZcaOEuk+kY76hog6UIAL0D25ocuYehQknVNLPVG1ukdovvDy9/d7aEdTztkIZ0FpWRThlb8sk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB3879.namprd10.prod.outlook.com (2603:10b6:610:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 04:28:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 04:28:23 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com, hch@lst.de,
        Ajish.Koshy@microchip.com, yanaijie@huawei.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        liuqi115@huawei.com, Viswas.G@microchip.com
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ley8iysr.fsf@ca-mkp.ca.oracle.com>
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
        <5ecf520e-588c-d756-1cb8-2224535b550e@opensource.wdc.com>
Date:   Thu, 17 Feb 2022 23:28:21 -0500
In-Reply-To: <5ecf520e-588c-d756-1cb8-2224535b550e@opensource.wdc.com> (Damien
        Le Moal's message of "Fri, 18 Feb 2022 13:18:49 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0010.namprd05.prod.outlook.com
 (2603:10b6:803:40::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af01263d-ff83-4027-829d-08d9f2971962
X-MS-TrafficTypeDiagnostic: CH2PR10MB3879:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB387916A8B4CBDBDEE39EB6FA8E379@CH2PR10MB3879.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlUM8wBxoWtrTMbXhuk5VUG9vAKMj5gaYwaz4pllMBjPeyv4njl17X/GijIHK5hbc4cIvi0PRoV2hpi/exBHy3jQGsove/n7ruq1+xx5cPEDn+2KmJ3oa1TLUQ9dDy7RRe6N1x9YLu3BM/yp8cL47TH6V6z93jdVQW218dstD/Qm9kh6l8bHV8+zR/lKCpNGt918DkJHVGJeG9HuIPXHgai6KpxxjfN8kBJGg9SnwOUKRt6OwvG/3xpTzT5TfbT8Z/lNgkd7gnFQVWSoL0mSuLTwpVST9VDKBK6oUWG4dgpJu1VTqQN5W1eEEWNwkXxCi9D3r2AisSlk4lY4ZOVRK3X5rOdg9zGGcGJi53kjTEAhtW6MjW4sG/e5rvgUoKW6TXEMHHJspNCzFYen2H5GKqu2bViVsx9+k1w0RRYwxwv7KJVBXm4AAM2dCRqIWqs8cTtfAPG1FzpBGn6xz/tpt76B7QfO6y70Q2uYNk5Rf3GWk+JkpxoqEEMhy/qnuK0zX+H4m1KD6DIlYBH2M+Epn6aaWHZf/ltN64VpDgLGzxetQpqbyAIaLZdnLmU3byWhqa0ak7x3WWze1n2rTqnlcntJD0TSDIxTU4c54WnE66ncgv0uj4hdN/NtMi5Dn/K1ehSfmexAzOjT/IS1GeFoJtPUoi2TNxwsRRYYAEWvwQqvAIWvpyzNp7lJi41VttJHKkzAl4H4gL1S07Dl76jVBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(6486002)(6506007)(5660300002)(52116002)(7416002)(8936002)(4326008)(36916002)(66946007)(66476007)(66556008)(8676002)(86362001)(4744005)(2906002)(6512007)(26005)(186003)(38100700002)(38350700002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Ns84RtjebTXCMePWfyfELg7wdgwN4RJKQ3hxDxqWWGSnnbMZbUfK6XooefB?=
 =?us-ascii?Q?Fch5Gu+R9gchZwf317UY/xcgtNZfIsG/Ste00SSPYpyTo+iPXI8nPYXONdPc?=
 =?us-ascii?Q?/Qfn7NO3A0c/+Tt8uGJ489naRgBx8GfBXKk4a4zGREdiTAH/qZfzzftDrroI?=
 =?us-ascii?Q?Nlm7AO2mELTPo1O6ezLy9sKOsSv5lsVYc4O/c282vppe5rDO82f1CaaMa0lU?=
 =?us-ascii?Q?QEBor+DGjvqovtZaSOKfkPp+pXTTw5gBWdmQdPK8wq8AwOyuiqcFVRuwOHDB?=
 =?us-ascii?Q?24t4Y16TbSESmLAUhlSk2eUHx9gGqb+OUKULPH8Q4qZDU+dDqzXt6hebbcmO?=
 =?us-ascii?Q?z2gWiWDTGZK2gwQlTRnDghwL2/XQEOgLfq9KfQ+h6MPCEVO+idUNU2EUHzmF?=
 =?us-ascii?Q?hcp06etW91lxA/VXsF5bRipT30XLp2mWMTFh+tgav5V+XOIMD8gnwxx7jrSM?=
 =?us-ascii?Q?UVafdUvJTm9ZQt4QDauEDYblnIpe2YbDKeVFiU8hgx+qd7k+x+hh0GWt5xvC?=
 =?us-ascii?Q?cpst0fH7nPyHGK9g8AlWTrHo4yBjC9mZmmp6W2hr1DIiVRwXx22JNT2EtSUO?=
 =?us-ascii?Q?CYgicqk6C7pZ4wVPIk9DHVqF7VCZ3+smdALW3i8+IORmXcSmfOTxOiv2kVIM?=
 =?us-ascii?Q?htknFSbQ5grz6q1txjbTvX1si7hH54GNCZZIYcIOmCji7sCTMy10wA26DhtA?=
 =?us-ascii?Q?Kx31Twiid7P/dpulMZYvPkdomJesk6nbrpafyb4npTUnDKbTg9xOV5cN6cZE?=
 =?us-ascii?Q?MapgxMhvmWfnINXhhymgZhXmhe8S+OdNvdvtpFoqceGEh6RyhFxVjxtmO3ef?=
 =?us-ascii?Q?Lvh/Nd3BDYJqNkY0sFLHEJ9YaYGr4/2XVZaLMkmETu0/ZFi9Txl4WonnVcVA?=
 =?us-ascii?Q?Gyns2xedeL9NMysc13gO2/3m/lIc20WBYC08VvFitPW2RQT73OsG4P/7QO10?=
 =?us-ascii?Q?zd2lgQ22WGO7e3o+jX+QMqANgAUGYH6PQLSS/2XgPtKdm71l7Ae9fcFFJYkK?=
 =?us-ascii?Q?gtlmq5P6hu3+lMHR33CVrGucU+mQAl514ddwssCKoc+hyCp+8bUg3lICe5Uu?=
 =?us-ascii?Q?xEDGDBGRD+n9GoWL3Qe7z7zxPu6jRkypPP1DZwYOWorZfdMKbpH5ajFUdeeZ?=
 =?us-ascii?Q?uNrxKoEWCMhIFoQudS0Ipdif//P+1iShh9F/DUf7TYckGHIRLWjp1yWbQBAf?=
 =?us-ascii?Q?qQVRwRmonR12jkztyk2oB2gG2bmXICvt2f2+txIYbdskLwWKiwpkkCzhC00K?=
 =?us-ascii?Q?oFe2Rl4Vpg3/7ZJWjkEORTqDqJeZzFwiaEOhq1Kz8vmAlYF11ZeEo5GCgVXr?=
 =?us-ascii?Q?Z4ab3SSEBGdOVS0qwwOwfVfha6WjR1lHctCvL1cEuAqHmfLHEC6Sm6CRkM2Z?=
 =?us-ascii?Q?AB4yX3LZEilO5AfiBScs+wqHoUFLObCJ+DJfiDuRmyexHwRXE8jMJf17DE7s?=
 =?us-ascii?Q?pfySFGmvCm+uVWgWn3BwP0CPmPpP9qrtLgS/pq/24VsERAs58a0WV15zL29v?=
 =?us-ascii?Q?wB3eBnEVqM5VVOrV/vndLqQ6EIMxCld+Nm7vAP7bR+b2Yg6iErh+5WVBNeV1?=
 =?us-ascii?Q?If+OSxCJTBmPcGr0lb0N4sLd7FNJ1N1L7fFbBFCHJEkE1UALX4Y/R7wEB9HP?=
 =?us-ascii?Q?uvFQ40iiz6Q1dO0tMieh/VSG8uL5pK5dj4r/rE4q5lfq1gWCD8+cz0SM1Z5k?=
 =?us-ascii?Q?UIYqDQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af01263d-ff83-4027-829d-08d9f2971962
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 04:28:23.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6kVYV2KQyAvKkM3DrsU8hOKQy6Xn+WAsvYH/ZA04IqnVjDCANEVO900vdIpbwfjk4qeA47EOVmsOS/WvJjpG4sDP67bAnbjs19z5+33ooE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3879
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180023
X-Proofpoint-ORIG-GUID: _Q9leqTfQ6WONFBHGuShNSzjyN_V1IkE
X-Proofpoint-GUID: _Q9leqTfQ6WONFBHGuShNSzjyN_V1IkE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien,

> This series and my pm8001 series have a conflict. When applying the
> pm8001 patches on top of these libsas changes, patch 28 has a fairly
> easy to resolve conflict. Let me know if you want me to send a v6
> rebased on top of this.

I'll fix it up.

-- 
Martin K. Petersen	Oracle Linux Engineering
