Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A84E22EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbiCUJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCUJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:09:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE449F6D5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:07:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L6Vf9R014720;
        Mon, 21 Mar 2022 09:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=EIey3c636YhynFPpGdsMYt0H2f3SlNhIq+SUe1MTlbs=;
 b=TZE+WnmJT+JN+uknwmsWbibpMXQZwsl5IPnX4/eLyETsaExISW9pYe9y2yfTa5arogSD
 EYxT09hCMmcY6EQw98GRI0/vwDTGldQKdWkXn9ZZ+p/C2SFOhRW3ISf9vUkRjiPS1mTw
 Uq7m7df8fHwO03qFjUKOfMFPG28pdqpviV2bfNQeuRFdmSRLE0/i0GvWnY8v6gY9k5kr
 uF000xWddI/xLmuvEBjl4SidAT9bGV8Q12oMYC2232w6MrBmPci7AKyhqKyJyooqd/zK
 dUHvoWn2CYK7Msv/D6Z/dnGtOROJD5Vio8qLSIBbZSGg/V0YdkOFp0T38KaQguHdg3k8 Mg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ss2mg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 09:07:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L916Qx137382;
        Mon, 21 Mar 2022 09:07:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 3ew578rwtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 09:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKiBYo4Mt5nnnyO+l4+RDO6t4R5xrpNuNAolCvTR2oBdw0jI7giXhRvFmtyKa1xs700DAi2phELnoy3ECem04pKh2n0TN4gpxLi/nHZW46iz5e12KHAWoleJWR28TSAhCvd0llBKVRZRMoGSzKDXr8OMZ8kIszTCHRRmAU3skLvqtNpvF2cqoDpwA3iiJFWqvVYr1gAAjs5DyZWUrjXgkhmd8M0dWoibPmZshixnQOGC+HmKuh2Tw25IIrRn6ufJDfjUBRneH1gXihHmvmnZ1QYz02cjUnB9ETs2Y0BGMhSWBe/HuHFnEa/0/0GTr62IJ3S29p7MQbApluY4TLurGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIey3c636YhynFPpGdsMYt0H2f3SlNhIq+SUe1MTlbs=;
 b=DQ4fS1VJVlgKYLI/nJHRkpMlJrdQCOhYXZHOXClfV0JNFjO54+3X7Npdm8P6nbkhVZTav3Jg6WubmMcqUtRZo/IDSa+xEGpLyMYo5hxAFUSKi2+gojR7Wa++9FD6Y7t64KPi4eJRpFfhCtQxSoDBfeB9SsGaceGYX7bh8xbf5w5rEeILoUdzLlEy4FLFgB3vefZFyqcHTatO4JrAceBs2oC11UH/gm9nrNgtW1z5VR5pIIz9gpLtYL/ZMP4AmU7HNLWpuq30410daAUyDdN88g0czP78qiqRrLjAaEuaD64YnI8E/ERNYHZeKUgsyC/7hzR20rUy36oj1Kf28X4Uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIey3c636YhynFPpGdsMYt0H2f3SlNhIq+SUe1MTlbs=;
 b=kJQKLR9AZyKMY7ks/9jcMABYF04sDlbU48QyW9lBJBWkZE23kz0D3cXKxl55ahS7nvhTGCWVh1L/FpcC+YOjidgE7N2168wbOW9AYBB3Rlg+tahx7V8FMm0Mbyfes5H/4QU+cduUaw5OoDXaqKQproMY7iw19discVBxU8lhow4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4881.namprd10.prod.outlook.com
 (2603:10b6:208:327::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 09:07:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 09:07:08 +0000
Date:   Mon, 21 Mar 2022 12:06:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Martin Kaiser' <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: remove local BIT macro
Message-ID: <20220321090648.GH3293@kadam>
References: <20220319180342.3143734-1-martin@kaiser.cx>
 <ac3343ea279b4d048d77b3cf2724bcbe@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3343ea279b4d048d77b3cf2724bcbe@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99f53eb9-e0da-4b0a-065e-08da0b1a2d0c
X-MS-TrafficTypeDiagnostic: BLAPR10MB4881:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48810F9F1F91755DA688AACB8E169@BLAPR10MB4881.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZXnBhMdOMZzqFv6ZxJm339py2FrS8VZ1Aky2cTZ17f1HzLJx8eN8dilrlSPrKjTC4LnuOBMmvQZlhdBOQyMSME3qDTW7/k5mDNRLzz4MtbUDllnRckD5BmZZ0Qmat5WAJuJ1N8E+PMtf6qblc8fumuS1icq18sw94sLedFbvhhvrWR7eWbY5QPvzfbJJItZ2QCbAHBUMXZALYvYKeMkkEdlk4PkLUg672x/+MeYFHnKrt7hZpEkF7Hc+21dRsDPwMm25U1PqBCN82TY+cQO/bZPwDmuLjsXdfu2pE+Lmg1uOeAlZYos7ie7fb6o52bn0e+12q8W9GMI4u/V/dHB6oC0rovOkMdijwxRH0Q92o67IzIpQXFgaw7aQ8orIGomnWLb8MsygNyf+Pum1mGkJ4f09H5Drz6yz5rSsK9WAilGArgRYrBuK5wwM0l9ySD+HIgNzmV5hXbztCJIZ7oEiXtnqE4oxoWSqfeRtbp7ARRYmSRomjRNn5aVdQ41qwJAtF2DYIEy6nTsclgiGA0bBETfrwT3d0i3tY2vZavO/1+fKytd6vbRVHLh1ltAEUJaXADGcdWwW+idjRjzHH1AYKexb4otMJWmHZDabFEOIk9bhZO9pbgTdYVwYEBwf4A513scBgRJcKIG4POCAASmIweattPTasm3IkTigtni0CDrLfHVIQtwuoV2LfEzuXzs+ds+fzB4kwtigmBs+vQCTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(52116002)(54906003)(6506007)(9686003)(6512007)(6666004)(33656002)(2906002)(508600001)(6486002)(316002)(26005)(186003)(4326008)(66946007)(66556008)(66476007)(8676002)(1076003)(6916009)(38100700002)(38350700002)(86362001)(5660300002)(8936002)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkgR9RrxRMQTN3B9l9qeLxVSET5pJwCHqDV0ksQce6GOOrxQmp0QKtBSdn+d?=
 =?us-ascii?Q?PnCRh+UHd/VGpmvyiTuWqkAEep+mmIfUQX82Zpsfhpwcc7tRRIsd39gkxxUW?=
 =?us-ascii?Q?AXz1X79sa6PmQTACQlAO7QO33dXIOPnVIXUxCkNtVCqnVHBOJam4GiyBmRCN?=
 =?us-ascii?Q?Qk/qODL3dMC1MKorjL7Y3ojBV8eHgOc3lakborYSESc927xUHSu3TTAERWA8?=
 =?us-ascii?Q?DImBydF86JP1nCvRlGSK5kiV/lC1yjqphHq0IYt6xvWzdfoO95MRVAj1OW1A?=
 =?us-ascii?Q?JU1gH9ORmcAd61BbBI4Sjf7PpeDQe+FPTxI3Z5SlxMtHm4RbHaomnGIhUS8h?=
 =?us-ascii?Q?k45PPiZ/TgP3WoO9/oLWOR9NXf84Ur2BYqRiNtdp2lXyeDsyZ8w7nKz5QV3q?=
 =?us-ascii?Q?7spbyyls7AA+ljJ8FQsXEnWx0apgGPt70ovTQPdB7rWEJbfqilBEK0owqAzF?=
 =?us-ascii?Q?T7Vq5DKdBDBbIj77IBF4NLucvKwd6EardPoCbdW8BrgVMJmS0/e4c+t20OVL?=
 =?us-ascii?Q?OrA7KJndaBq1f18aZ6VAbx6TiNO/VZXkWkjtvjSRP9IKt+gZ/NrhYqS1eA0T?=
 =?us-ascii?Q?/dFABT84USP4vpW9UVZYOeMqkFwNyFHc2Tz0njkWtsdmWIaXwR6bS7DS5uv6?=
 =?us-ascii?Q?7hvmF0sqzrHo1VhJEc24oMcUR6uLhVV738fwbx0gIMzcwNyAs4QDgfonhqQz?=
 =?us-ascii?Q?vBdNi2714Sxo0kHcfRT1jiGqQ8bzbD9MBI96j2Tt0ahvbz/Wo/+XdnA2LEgi?=
 =?us-ascii?Q?VwrXlrg/BTmiiI+JgwWRdk1hEdXX1MdjubxbHtoC+DLIaCWGRLJB9UiKR+LN?=
 =?us-ascii?Q?tDSihiRTcbw7nplAloI0UiwfqAy/FzdWfZ0cvV3Tn0nC212t5LwLVBUbbeE2?=
 =?us-ascii?Q?qW8WaaF/EFUn3nz0VD6f0g1UwfGMv/Y0N4vQL/xCKRQNeCRpsGzwvuOQSwez?=
 =?us-ascii?Q?j5bPRcg85UQngT7/OP+HFur5m8EXWA9jDLe2Vsl3ln92eGFlCJWtJviGlLs9?=
 =?us-ascii?Q?LFVm95dmMdcZsQVkwLfvhMf5l92E/WKoOGzxkDqh1vIk5LCwvYU59dp8tsl/?=
 =?us-ascii?Q?W0cbHOywimsT95mqQ22MwPyXEjFTliFpONmvcKERedf+UT/RHdKq1SC6kUPm?=
 =?us-ascii?Q?RgqxdYTacQvzBFsgiFLCyLywIZud5Gy32NZcSLYbVFSJaq0JDs/hGG/f+Mzi?=
 =?us-ascii?Q?Ajf6vXwSr0XIQL2sYmPdnX1wjLjJ8G7HxpN8Xim0ReAg6JbM5tZhgg98GVZ9?=
 =?us-ascii?Q?qVwxS+BZjQ8UhbdlNyBgcu+S2zBeWmbsJ9LJ2e1EyKlCDfBCcHHGZVxCDjY6?=
 =?us-ascii?Q?TR3SPgRspvTHk6BlVe+nDktsAFmLS0jIBI7m/LkuAszztxbAUw7tCgFOPP71?=
 =?us-ascii?Q?LfYSlHPBBy10/tb5BXQheBZ5TPct+nwbMN66wTHQS4M7EDcwobiQfE3X9J2N?=
 =?us-ascii?Q?P9hogCr3sh+nhvG26D4FGA3TPG4w7LzXd9iu/mfOXCq5uf8M+yOP4w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f53eb9-e0da-4b0a-065e-08da0b1a2d0c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 09:07:08.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXzLd9H4kpCC0aZ6Ac1X/JFkjiiu0MMOhy+iUPMcD3QMEH8xMexrTZUgOpLqgITXvwuaOl5XQurM/52195yfjdcoNyK/Eny7Vyw5YE3VFGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210059
X-Proofpoint-ORIG-GUID: pNnP3CWlxaxxUR1o-OAVEJum5qPeBVkf
X-Proofpoint-GUID: pNnP3CWlxaxxUR1o-OAVEJum5qPeBVkf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 10:35:58PM +0000, David Laight wrote:
> OTOH this code is a big pile of poo.
> Abstraction functions gone mad.

Yeah.

I wrote an email similar to yours and I even wrote some sample code.
But then I deleted it because I don't pay Martin anything so I'm just
grateful for what he sends and can't reasonably ask for more.

This code constantly amazes me with how many abstractions there are.
Martin keeps deleting them, and I think he's going to run out but so
far that hasn't happened.

Anyway here is the diff just for laughs since you brought it up.  Not
something that's necessarry and definitely not a priority.

I don't really like enable/disable functions that do opposite things
depending on if true/false is passed as a parameter.  They're normally
more readable split apart.

Ideally there would be adapter_to_pdbm() and adapter_to_podm() helper
functions.

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 665b077190bc..d973cf341031 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -276,12 +276,23 @@ void Restore_DM_Func_Flag(struct adapter *padapter)
 	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
 }
 
+void enable_dm_func(struct adapter *padapter, u32 mode)
+ {
+	struct dm_pri *pdmpriv = adapter_to_pdbm(padapter);
+	struct odm_dm_struct *podmpriv = adapter_to_pod(padapter);
+
+	if (mode == DYNAMIC_ALL_FUNC_ENABLE) {
+		podmpriv->SupportAbility = pdmpriv->InitODMFlag;
+	} else {
+		podmpriv->SupportAbility |= mode;
+	}
+}
+
+void disable_dm_func(struct adapter *padapter, u32 mode)
+{
+	struct odm_dm_struct *podmpriv = adapter_to_pod(padapter);
+
+	podmpriv->SupportAbility &= mode;
+ }

regards,
dan carpenter

