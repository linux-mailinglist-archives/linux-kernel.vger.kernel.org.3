Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24E1492965
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiARPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:08:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46868 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233331AbiARPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:08:11 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IF4Vvu013820;
        Tue, 18 Jan 2022 15:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JSB555OiLJRGAjW5Yrv93i6pQNIc4nYYd+gy2V5KxAk=;
 b=kOkSH8d02Opae1qk9W/3GETO4o2Pn6+ElPQyFsdiBqD/Sl6J9wfw8z/h7iJg2cxoiv21
 KpDFkPqO7RO4yZDti21nWDj+8TRuDGOKLb0BNOPq3dTBdgKzGZzwbfC+TnPAMU4y1DXn
 q4q2XRvumfcbQ2krbU2b+8GI2zMtw9FT9F+dNQq/ED/Oe7jlM/AidWTqQuD+XScs+HRq
 2NYY9r3j3BjK1f4aZoFjb4gvcZ701OQf6bWGUaYaT99FOZvuHehm+ehzPk+An0dYKmZn
 T4zjbRGxhrCfEnGUMZ91ejKbqQO9gu9mat78KTcUc4Ax1rxGnAOwkeNZQtRcDw3UPTKs IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52t4b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 15:07:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IF6rEN048124;
        Tue, 18 Jan 2022 15:07:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3dkmac3bqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 15:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1TBNFGiorwTIqfN/WNrMX8XAxuSQsCvs9pkFz8YYIHBmwAI1/8axlzyv8nc5Rz97BCjea6S44yUBId4lOJVPSU1egt5n+5O1ZR12LCKSIZPfuD4hquMOI9wEZeZybvmJ2Br5fykHlLfqOPJGD3MEbrYx+qRcEGy1bWlrZgjAVkkz5WHRfovWcWRwZRHieQroZLomW2cAfca5WHcDosrHfbrSmG/t42bgG7ADFfwvcSxk4sEDUUbJG2oqKLGomj/oIDTEt2TiHhqgphHDXHdtdQA4cJW/o6/igXDLaIGwqOsWtIcI40xfrximv2f2vQbeTk9B0ZsV9RHSbqlJ4upDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSB555OiLJRGAjW5Yrv93i6pQNIc4nYYd+gy2V5KxAk=;
 b=di04r0YrjSD1owYFrRp/t91QJUnT0NslyxoFY2qJnn+Na3MER3Mk34ArdOCWOSQ2HCMfMFod9bz3nIJUSFQKXeqZlRnViEy0Ehy+IPtp7Dla62v2vocVFBaNR4uWM6R0w37ILkl73Wjy2lq7nUACY+0ex6NwS8z50tKCvsa5KCqy5OqqaL4s9CsPWjnk83zBDI3NOeacpnAqgX9ANECJOHAYBCwcm9cM8h+B64w2iascj09Sx7mjdXJgHvdkq8Ckmynp5OIdrUDvA11RZ4mE+0/jdDKkcoIWrhcxVg/B0MX66Rd4jQc9tlDeNBDKB1GINqyQ6kwoFpw1TQLkbPhwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSB555OiLJRGAjW5Yrv93i6pQNIc4nYYd+gy2V5KxAk=;
 b=wrafCgnvqyI6EsMuDNlFv401zE5OZNfVjs5grofQPpuvVIcg90lHveH6WMCrVYkLNFwJPRmGNVbVq+kNdDCHIrrYBERmwFloLrpG1Bvf6r+sW44SKt2v421lbeBHt2ttgN8km5De3FHeIX1uhRfGOtE4FQVCiS3528C1eiWu4nE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5321.namprd10.prod.outlook.com
 (2603:10b6:610:c9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 15:07:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 15:07:50 +0000
Date:   Tue, 18 Jan 2022 18:07:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, martin@kaiser.cx,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: handle rtw_init_netdev_name() failure
 appropriately
Message-ID: <20220118150728.GJ1951@kadam>
References: <20220116192611.19224-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116192611.19224-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb80c1c-fe08-4f38-829a-08d9da944b5f
X-MS-TrafficTypeDiagnostic: CH0PR10MB5321:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB53219B0A7EBC276C6895AE798E589@CH0PR10MB5321.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fjds9Hm2FRAu4PHs3Oa3Ef2qsGLViJ+rQmCKU5gnMtXcSHTvroBNiX8OODoEe+/sQReMMY+tOYKK41h5pvFjTK6xP1f/jbiFhoadoj8D6A10uS/VsBdVXeUjYHZTbtwvMCGqSOCnkt2vw5E3eRMvZZRDQaPQcqlNu7zMw+8QQ6SMEmDr58PVVcAPd65HIQLqqjDYMZgOQh/AFNBaD9f0AsVcem8E1qZ1aVzxpFIXSOz31m5rq41hKVfj8BYoDv0RjC31iZkj0BpBcp9LAVrtYhQ2QIlDD6yY5o98tGmDlmQ/hnl+efb5YKdqJroReceegqRQxVshFGL9Cw/tBtyr5pvUQU1ftSnpH53n0UczRfyccHIDlW6bDEj0M3v9BADxjkYND255Dc4IO5mBMDe3Xd+zKcuTD9rl77W8Wi72Ki69bxXoa9DIcrrpufQlHCoU8Ytvu3eWjL0sv+w1zSaoxcPMMo6dVJHfSddjCXaeLLSv4HeTdqVI+Rq1liTu7jdSxYph4/nZ0dvoVN444IQZzD8WKhmcoTzvMuan9gZdOu9fKkKDBLoQBP7RuYtvAakSQBuY48r6/yfHx4c1EN6hLOoEXolx6DSs35nyhu5PTI/Ek16Ir3a3p3SdLVMsToiOWPhSFJ64MXDlWrnLSQQC+iagNQ5861FlE8mTUtY+rbxMeEEiUr4HfUejEyzOpKEZQ/jnJk0hxjZnbgSphQNyo9HYn6Xctt0gMZel5IR9fSUppHa6WMakvmRCnewy4xaWHDn4AHGlwbeab//jvQqeARVIgQgUQP0J2ktUT7zlKJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(26005)(316002)(2906002)(44832011)(8936002)(6666004)(966005)(9686003)(6486002)(4326008)(38350700002)(38100700002)(4744005)(8676002)(66556008)(66476007)(5660300002)(6512007)(1076003)(86362001)(52116002)(6506007)(6916009)(508600001)(33656002)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rfK0BxDCDxxRYK3VHtyIqKYyOWGN4YtdgRV+hIv0KoAjD0WEuaUVN0kfk9rT?=
 =?us-ascii?Q?bQpXAF6kxnpV4ZGXY06+CYOKBU2HV+sLjkGVKnp387s5aIzupamM3m06ggu8?=
 =?us-ascii?Q?flO98M0e4/jOc3OqDig9L51I9MNyMrLOnkdH77kdrsSxgxOqGMXofoP1hfkV?=
 =?us-ascii?Q?B5iJogiWaLf1+Z15jngNduwbYTA3YR3qz/bnJpvLpoFcfeoGrB6HJEBzBQ9V?=
 =?us-ascii?Q?fHUT+CXfw+dvZ1Tyirct6yE8El6FOVtghUWX4XtP09JGkzY/6zW9N8gGBc4Y?=
 =?us-ascii?Q?/r4nsJ6S5dT3UQ4KhiIOpa+8TOu8jpQPGpvN3/3W7Ja8BBoqsu+7jUYKg61U?=
 =?us-ascii?Q?+EBX68i6xqi07CNMpyGCB2R6pfLAnTVDJOv71D0QQEIVJFDu5f/ZFhznvrF8?=
 =?us-ascii?Q?S9ptO4b8NnRD99K92eFwX775mq5sbvMc4aj43fHsOpNd7qaer77RL3oTILCI?=
 =?us-ascii?Q?oQBoAdHEHlI7Z3vUOG8G0YI6AdwHWu53rlM816T/8LNme8t/AZCYxmJgkdiC?=
 =?us-ascii?Q?tePsvDHMP1jYxxqRhy+W69us+VdMSKDSy1v7j7F8+k34J+qOl5uXqofP/JR9?=
 =?us-ascii?Q?iOtIUfuPcXlFEnYiA99X7m6Yp2pd/unmO6+m8CHtoaOS98YFMU6BJ5o8p1By?=
 =?us-ascii?Q?5CEMMVjVI442gxa4BTHtl21XCR63Gpt55qU1I/88dd1qfGTrdHThKXnfbkYc?=
 =?us-ascii?Q?liaRBydeyQiKCk5w0oIB3nj2lAwt6CfSN4zBytjBDDVDhk8/odQrWZ+7Zj7s?=
 =?us-ascii?Q?OJTSa2WE61OwchsYeDepD4WIfFYaJCCtpePwXGIjey/tAnIfu2m3fCZ31WqX?=
 =?us-ascii?Q?qjRKVQ1Ss06BAE1/MCy4WZ141ZntnZgs2lE4PlQSlAQk+ZT3QXC3sRKL/wEy?=
 =?us-ascii?Q?Ixo/wqMfbO3OqeKSUtaUe+ELyTVU6hvHTQX6lQScR0HMVXOiAKQYyKqqXHx/?=
 =?us-ascii?Q?jvxvIw1B+4tNlbj1C03oTQtptLbptSqGMGMuu5K7JVoa1KpjZ5L8TEqQIUWm?=
 =?us-ascii?Q?EFc4YulEdFF3xxC+19ZLa1J15y6b8CcGfOViEwv7BqpXQTCzJA6KEDKCUwNv?=
 =?us-ascii?Q?tJ/XGHTWmpvVUBwmzWF8DWUHeQMKxjIOPNNvjA3alKAgoz1qkhnoCYdwanlG?=
 =?us-ascii?Q?6qNo+aYwiuwkqalWLQrKqz9RW8uY8+UYDVLM7+kzos9hwu3LEWQL11TYEqPJ?=
 =?us-ascii?Q?5leM0tPuzTn13TmtKTJr7pZRs7GiZpbimhdFQ/5BHN05azAU3q9vebnPjGQU?=
 =?us-ascii?Q?98Cw8kTVeymLzRFuKUbleHcL8232jRoHUSdPa8ja+vq3PKjdy0H+qYAvwImu?=
 =?us-ascii?Q?07ltqfrrsV4IOpLsrFBg+tWpj80YNaPbQHWFQ0drcc/mszxzlafLz0F6wzgr?=
 =?us-ascii?Q?X4pQrRNFdSuLWtzVC/co8LBFWxJoT0Hid8pMab2wrrOmVj0luA6pCM8FbrV7?=
 =?us-ascii?Q?zHJjR5+gcGYOSChrEq2qHPESbFk8VzjzDoxEr9y9pMiirtcyme1KTlTSE8Ja?=
 =?us-ascii?Q?7RPVc0iobi4d+ntxF8YGiJTf95Y9NeDBLCZ6rwPG9K/CV1YvIkK/Sk9ordL9?=
 =?us-ascii?Q?C8Mw0gfxgVnK6lZfD+WGC6KLnUexfDBDcXInas9JRLVDv2MjiqaNK74LtFB/?=
 =?us-ascii?Q?kIzVB89TehbuEBpI+c7v4raggMZp4SZKl1Tzw1zQ7JGgULnLztJSFd4DRs5U?=
 =?us-ascii?Q?3jDUcHKEWM06oaVKJOGD0Ee+fBA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb80c1c-fe08-4f38-829a-08d9da944b5f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 15:07:50.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDOQhd8qhWVjOjJ8gmhmhbXGzlX0NlhSsH00+7eh/FY5rGy7w8g937Y9zJ7G+TsaiHtwyKAwbnJTAUZ/w/Bt6fPCbGaJoR5ON3vnwjVI37w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=963 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180093
X-Proofpoint-GUID: 5-Jx9WAcE4RQNpLtR3YlpF376fvVsszg
X-Proofpoint-ORIG-GUID: 5-Jx9WAcE4RQNpLtR3YlpF376fvVsszg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:56:11AM +0530, Vihas Mak wrote:
> rtw_init_netdev_name() calls dev_alloc_name() which allocates the name
> for the device as per the given name format.
> It returns a negative err code if the format is invalid. Currently the
> name format is specified by the module parameter "ifname".
> Warn the user if "ifname" is invalid.
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---

This doesn't really fix the bug.  Better to re-write the error handling.
See my error handling guide here:

https://lore.kernel.org/all/20210831084735.GL12231@kadam/

regards,
dan carpenter

