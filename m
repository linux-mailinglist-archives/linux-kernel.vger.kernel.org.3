Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4E449C78F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiAZKbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:31:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239969AbiAZKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:31:11 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q9ZIFw006740;
        Wed, 26 Jan 2022 10:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=gado/OzLF6kKb1+KznYr78BvfIr9BMBJLZDJFMzfeRY=;
 b=HVhtAWBnNx+q+YvVOFvTnPctxU//65/nujfuiV5d6gxfXnAw3Il8iQ2DMvmoJhXp4VLB
 Jxw9jVCrWRaRB9N5O6rwzkBp6ZTKgtWFQraOpla+/nyZPumVWq1UST2xHlfrMmlUCqP9
 qVpj0sX/CjuEvflZtiA9ZJi6PfNsXqzPPzgrn2Y+j7D5P/2I4i+TXz+O0F3j+Efxnqrw
 +phoghiNtebZvkMZpCQ7PsqLNDqmiaGRP425KfLKzR2xl1EG70kUBSExcAWRXbkdWKUB
 vpeQkjnvnLlgcnBmm3q5piZBaZJ0mciUBgDM+P+IHYdYPtYZk3sonll/XGNg5KusPLCl Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjeb5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:30:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QAUTe5066725;
        Wed, 26 Jan 2022 10:30:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3020.oracle.com with ESMTP id 3drbcqs9j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 10:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZSP79uo5M7CnK5Qk1uBq8+3Sry/o5WwyIVhZ7B3e7yeFAOvgsovneSX+dFuOTmoI4gQM+PHOFUyLLvhmGsplOFSCpAhOzZALt0LM7gnnYZRUsA//FORVNChXDCYz8fW4MLeRtZ3LYrHYGiYKr5uEhcMlnkQvtdDbL98w72DPzLEN15fBiN5MwplMjaMzCN4K10gDMmsb8WMmnLtpiWKzTy1xmX9f02xWhQF1AsPqyxzc4cPVzoKLPVXryPz9YTVsTlMeR5qblZ2KsXPsOUON0FdH5ZJL3KEI2NNvS9X+yE05kAsau6HL1Scje3mNIEnzBw7toIasHtgUhdqDo1F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gado/OzLF6kKb1+KznYr78BvfIr9BMBJLZDJFMzfeRY=;
 b=fpjyJZwZsWJeWhb17+Joq/zyu4Hh+waIcBogiC8x483eOn4oFF3yv9HxZoPOSbOq27hbAip7xUXkNntXNa3wPSq6wBUnlN5xGBm0Gklyf3wMDZyYF5pSMvpcmlQLQYmbqwIDtb/ZbcthuYJoabWObeJUoua/WMUAi9+Zc0VT40H3rFCDJf9sXySn28ZGQmdM3pjhSr4jm7fqkYGJmaOXAFo3Po/NyxTpHVhdGLZMTn4MQ6kowgBmg5wH2m34Vw2bEC+5sKMBGaBb9NQkAmI+QERjPuFTZrgTfiMyO5OVBU9Qu8aJNF61+XsuHk2v5i1JL5A1YiNfE2CA/LO/3XIMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gado/OzLF6kKb1+KznYr78BvfIr9BMBJLZDJFMzfeRY=;
 b=DVSJ42PvKQ06oIRBi+eDrJe3C6OMneCzh7FYXb9Xtaea3afVhV/NPtzBlQd1SKeHZXrEDLf3piW7CklYUAZe4KA2yFnGBsTSO0D8YmpF3AR2FkmAtIjhxnuRhbBTYdwDm3ywnE2JKU/iTpLHoSxvlrGWOebxxJRsQYKfMp8KL60=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2552.namprd10.prod.outlook.com
 (2603:10b6:a02:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 10:30:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 10:30:56 +0000
Date:   Wed, 26 Jan 2022 13:30:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: r8188eu: ODM_RF_CALIBRATION is always set
Message-ID: <20220126103035.GX1978@kadam>
References: <20220122170547.68378-1-martin@kaiser.cx>
 <20220122170547.68378-4-martin@kaiser.cx>
 <20220126074917.GW1951@kadam>
 <20220126083010.g7cw77wcliydh3im@viti.kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126083010.g7cw77wcliydh3im@viti.kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8b8c6fd-37a7-43c7-ecc0-08d9e0b6efdf
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2552B6752BB05315D50023C68E209@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHiCyt4pf0L+k/L6u9jBRMTxYX4wrtnEMn2tHTEWGk8HYQ4IqCz5R3JTPLTgbZ78tu9Xi9sBhbUEfAW9B+e0aQZrk7yiaZ/g+HYSW4KP9CJt/giKwmy87D7Z5Buz5NDTFFFahNSt0ZcXxDa+Lj8Aranz/mJyIdiwk8NcesA39BQ3fsNWyaEdqLco58YKB7kLiRYZNl4gFEsaoMW38KtokawudYTcaHGY4rCsdbUJWSbzLdZAjenM4Q6FQ2CRI1RIooW17TbCfi4+/MOqnn5tOHCaZNRSKGehowcjxm9+qRsiUv6GDEJTs6Fk5cewZ/mp5W90c8u6vP3yL2u/sBOyTnvIh8HfSU9gpbwuv3qKakZWGcQGmuoK4dOQpbvZm9FttDOyP8P6SNbPHwTVu2VbZX6VZbNkf00yzXEm0bVm34di45cGqVqjZB4+XZ7pa4SBDa3bW33lfeumji4oLoKfui0gz+33SZsQtBjaWrT0yxXV3rsFqKR6qVkdaQqnC84LduFvh03oImWfpQeUBQaGTm86NJFoIwWHWnD79Kp2tP+A2/lkeSLT+3pV+PWNnI8V1oR90G84NeHwZTU9UBveNbj7aNue7xj5135oeSpU0ssYX+DZIzzFsDTJ4hWbtZBVkSNLwMUaKykw72w7q5OV8jXNtCY3bqMet092w8tKxdnZuAoU4Sz/3ssRsWNw0/f9yDpEm9Y9bCKui8GUny9HpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4326008)(1076003)(508600001)(6512007)(9686003)(6506007)(4744005)(19627235002)(33656002)(6486002)(26005)(186003)(8676002)(6916009)(52116002)(38350700002)(316002)(86362001)(38100700002)(33716001)(66476007)(44832011)(5660300002)(2906002)(6666004)(66556008)(66946007)(8936002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wmWv2GVs+0e7gxwgeHT/XGx24lsnZyw0OOchOX8JTh0X/5vbPsZH9iRJl+11?=
 =?us-ascii?Q?QxEyTX375poA0ywu7v1rcsCW5iXgwtq+yj6ZKip8/WyCB5Za3WNqxUBULUrH?=
 =?us-ascii?Q?q37yHxr7WKkEM/szDbzBe9WrINhWLp0cG92DLPXyHX5mbvD9wN4/0CWv03Az?=
 =?us-ascii?Q?Key5DYmiOYsTiNHYnHmpl88O7Npld+zYi1N1gSepJjvKNuw6ZTGQhJsLy4xJ?=
 =?us-ascii?Q?83ipSMUFGk26FSQ++ALSO3CKQnHSjjoXkI3DXfZ+V9DNS1LNYlzFAUZ+fGpz?=
 =?us-ascii?Q?1hpPKy8gg9Op9f0xWx1KdDHiUGgYeuXuQR907kjpl5I+MRTHSfZMK12Ma7vg?=
 =?us-ascii?Q?vnRzRq+nB774cV8oix37Rp/POaodyXRb4r197M0vLfDMwybv6giB9VpvLGXw?=
 =?us-ascii?Q?SFKuLWiQceDDc2+d0xjAfDBSKP2v/qufucyc8+SxBAoj+8X+zfXQxUjh4fJS?=
 =?us-ascii?Q?Fg6DchyztFafTd+HpTJcpqwXTILOjnmESCgWhgwhJ+a/BrMJie2dPi20IM/D?=
 =?us-ascii?Q?fx/erYpW83Yb/bBDPosyyXwmXauUrDUuGrEf+rOQj7r3QpWhN4cb3HXRMRUl?=
 =?us-ascii?Q?+2aVZ+kLmHfY1Rrhp7bLDASvtvxeYOvAzHpjIPRKj4aw2mfXpv8gWAj/zbXO?=
 =?us-ascii?Q?yip3/oO5Q6gEQLuqC4BRrHXzyttMNCM1Sq8ObEwuQjZkNF2n+UnFWchNKn9V?=
 =?us-ascii?Q?gEEBOp3vy54+RME9SgdNeIjpx+gVkgKA60jP7b+Kmy93kWucCrmE3f4kA9Nt?=
 =?us-ascii?Q?nTxHtjyLtwyRftOrc07rQlCmfUkBikbXd1tHX+PVsYcX6VWiLcFDab9IrqS+?=
 =?us-ascii?Q?7xt4BfEFbN73ewJUYWdS6ul/1gEZSD1YTwFpT2YkX0zbT5WdzUkZS7eV659C?=
 =?us-ascii?Q?emu8IRgtuhDH8YJhxZQkEp3LELq7VM77h+9TgjE1YXAhSy2sWl753vpxTSkt?=
 =?us-ascii?Q?iZKzuXqDEll66GJRz/HJM7zRxLVP2XSILHSmAH15nPzphQ1K1BDuzFK4EHpc?=
 =?us-ascii?Q?SOhZmudhwZbu/3Abku+p7gvZCSUy1o+X/uXbZHQ1PrSbevmaNB/HMMgWt1gn?=
 =?us-ascii?Q?ZWBFrB3svExgHL9YIwUjTDq6yHseSz9iQapvtlSzjfj5AruSSs/A64P+LHkw?=
 =?us-ascii?Q?GdCznR7q/F+fTmTEp32BIz5FNmH2XGKJyov4LICRITHoDm1NSrd2vSEFcqKx?=
 =?us-ascii?Q?gPrpZKEBtNr76wNJlvcbBntL7ibgaY1H7PS/9+L+rmw7r+rk62dxhg+FUapA?=
 =?us-ascii?Q?EZHQZkYd9VTjtu+w1RhgQoz/QltzbBidjh+gg7adac4wYlvot8hMLCct3K6o?=
 =?us-ascii?Q?Rgl4Di4+JMhT7oiDkRoBzG6HPY/jxcTSoheE/EuZO1i5Hs616EiwmLbUfEk2?=
 =?us-ascii?Q?AXalt9wOZXs5y0nOzcNG40TNLbWS63kT5KVyx2gdT+RbBS8RIE+C4/MfkLCV?=
 =?us-ascii?Q?gBZ5CyllsE+EqYq63G6Mx1l9b7bt9jc3SsJ7hc/Vm89jAkSrUY9nnuy+8mQY?=
 =?us-ascii?Q?VL8x2rz4hOirt7bv0r3Qz2oWaS+IAfnfPSAX+xyZOjtp3NpQuUl1dLTddSqC?=
 =?us-ascii?Q?6EQAg0psZP75LWDkQOWjYuytqN+7ZXgFELI+nJRvNJEJQNksF8TrWn5rzLWT?=
 =?us-ascii?Q?bHaWDgVjdTsM+Q70E8jq99RQBlC3Zz7D66hD1B0wWg1Uh/AcgT4NPBgjJWO5?=
 =?us-ascii?Q?ZffQ96eekinXXDRhhqLv8GB75h0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b8c6fd-37a7-43c7-ecc0-08d9e0b6efdf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:30:56.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+rPrk7zv4XrSH7BZjdDl4Wuml+5MNesTFi//CIIJcVtlQZKCHuZ8WXdWSVMWe7h8u2kYdMXmWYWtGaTHsl3afg45D1UQ+9IzlFljJsByG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260061
X-Proofpoint-GUID: dRLzf1AeeOjxd8caq9z_FxTyASe9U2NL
X-Proofpoint-ORIG-GUID: dRLzf1AeeOjxd8caq9z_FxTyASe9U2NL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:30:10AM +0100, Martin Kaiser wrote:
> Hi Dan,
> 
> Thus wrote Dan Carpenter (dan.carpenter@oracle.com):
> 
> > On Sat, Jan 22, 2022 at 06:05:46PM +0100, Martin Kaiser wrote:
> > > @@ -36,10 +35,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
> > >  	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
> 
> > >  	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
> > > -
> > > -	pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION;
> > > -
> > > -	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
> 
> > Wait, why did you remove the ODM_CmnInfoUpdate()?
> 
> I removed the last item that Init_ODM_ComInfo_88E added to
> pdmpriv->InitODMFlag. Init_ODM_ComInfo_88E does no longer modify
> pdmpriv->InitODMFlag, there's no need for updating the odm internal
> status.

Ah.  Okay.  Thanks!

regards,
dan carpenter

