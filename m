Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D264BB89A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiBRLqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:46:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiBRLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:45:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD9140A3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:45:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IAHhft009210;
        Fri, 18 Feb 2022 11:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=G2Wkq9ECtBBFKxcJidrjhdLiG9ceRfmG9tSNUfnjQn8=;
 b=N4ylGuuML8oHsbUvFe/G7DKl3KGjd93ZZ/yqBKikif/qYFOYzAAfYxqFSL+oROGGJ/7i
 +WlFXEa6QvSUZvUQigg9XOWpBSJilWdFfgwGFm38LvEKp3RbpQ/v0S5PB0pEcIta/MMd
 dQkuJmN4pZhZpBB+7bjYsoFXfVvq+VafYF8F0VHn1XHr1NWyy55EOyTMdfeyZNuOtFIi
 eHeCs0TQdGxr4vQk3d5AW2TJx8/qpvQPNbaqbzYzVpFHxXhaLZEAqRY11G17cU6WHKe+
 LxZ/0dcrNPRVH3iJstVorjCql1/C8dPJMBviuf8Zgapy8fJbWhACVaWzXG02UGw5a163 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e17tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 11:45:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IBedHa058840;
        Fri, 18 Feb 2022 11:45:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by aserp3030.oracle.com with ESMTP id 3e9brdp2un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 11:45:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMbN9qhv71uUtAJe1LdOtdLJCxw0y9iwCCBFlkm6maFwf4CbuvmqIJNpjbE8ra4rmuP3Ts+9cB4YOcq2arjJaS2KD5nwekAbOCdf0uI/SY1wWVWcgJWQ/4AlnSSvtJffq6aJaCcMKFjDO5o3L1/IqugpYASFEAiWlr1xW8MNsJ2ZTCpM9tSxpzfL33TO0mnA1E274OOey3eRFyWgjcxRWKgMHLTUmlJjYvUNflzNoNGNPDYnLYpv2paWJvoNwerZnvUd7MKlIYMLZYvWB77NWqt28Vw0a2gs5JVl8+S4cpBcSJZc7Tu48P2UHHM0W/LxUYsuGSvXyUYYOKLYmV+ciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2Wkq9ECtBBFKxcJidrjhdLiG9ceRfmG9tSNUfnjQn8=;
 b=lln47+ttCWZkB5hsfa15q/DJ7U/Co7qhlQXhcQySo3VbNABXRYxm3s5C1307iMBmzbWV7Yp3cKXjMOuGEu0C/wH/uzfGprBofc4Ns1GAUG6nMtRuNPq0mxcUY6GFkzbkiZ7WeYLlTJjSybN3Dl+8GzSeZs6ozz0r+qQKCshwPzCUwu65TeFoeH7Gd2NBb8G/r7l5MPX3Lmj3Zq9pSH+O+4WsFtlR5SX6291t9ynIBDRgvIznNPziwO/9XvbAmQs+gxPan8dNKgwpIeSs/RhEYUKmR8YevplaE4LmM17lMmskodkR+8AhAJpnwSBrBZcDhzmzC3CvPkTN2lLUZR+zyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2Wkq9ECtBBFKxcJidrjhdLiG9ceRfmG9tSNUfnjQn8=;
 b=AqM/scw3QXGG2oZueEzdw2KbpQwY6zKLSRQdqdVcN3buSXyEfDyLVuLVaj19PWkiLEDXgkl2DWsiFbwGoZY5ALaJHzsJspoVKGeCnXyFZ0OoWbH0/zJkZ2klL+D1CZkzNSZ+aXspiYt/2bdwjW1ChT3Q9Nqk1VX0U1a59Ku1dWQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5849.namprd10.prod.outlook.com
 (2603:10b6:303:19b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Fri, 18 Feb
 2022 11:45:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 11:45:14 +0000
Date:   Fri, 18 Feb 2022 14:44:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcelo Aloisio da Silva <marcelo.as@aol.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary braces in if
 statements
Message-ID: <20220218114455.GG2407@kadam>
References: <20220218043705.GA23783.ref@snoopy>
 <20220218043705.GA23783@snoopy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218043705.GA23783@snoopy>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0051.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784b953e-a183-433c-68c8-08d9f2d4201d
X-MS-TrafficTypeDiagnostic: MW5PR10MB5849:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB58499C7793395EBC8B503EB78E379@MW5PR10MB5849.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjCXhcvdAp08bAStdPVd/yWyv3finOoqUAItRn1TVlZHPlOVB4bMeXXrVpOVMVdIC6r6QE9XGPoqWT0y18M6ukvSDNrZvmuSVGwBm9cCP30qpOTA21fSY5AwXqLXEZz3Q2Sk+gUVzc4myT78Xk+TTNzUnr9Xu4/1NW4yAk5J23p9alvmMFJGa7s7SEuNpbou5BX1T8LtdKjWa6MFH1PlcbUEvMIrsrikgwtUpXr01HeoUF8+YdV17/u4X04UtxQNQ0mmr3Rk94tqWvX7cv0wYVV6wvTdhAZFCv5zhaEy6g3xYf6HNNa47oywdPCAHdAZnavNxkSQZrIIuSz5a+9JGj+uSqQ+yWYNAdMEE31W+GJAx/JKrFUPZK80CaYs9pmwHbLX3Ep54350cIGjs3sUQpfc0AScWvbg+xupLEHLdnOjL11h6B+dH6fzAHnp6xYSsmvYnjAN/IRhvKeBEgALtg6GyTpRI8doUrW1JNX+B5rbXgagEP3ztV/VRaYbT+Z4TL0jM2B+hraxDAimWRlX56Sb0We4p99d9NIVKGeWGpJn2B15rJQl6ZzG9Hxna8Erxo4d9KDon11UcSByb2G7tjLbgmJJYGa5yXMTwOacJPnCvZWOTJYd5rA+gbi+u9kTm+KWgvlCm1CF0jZUggcZKcREnl+AaEDZxaW0cX2PGXaITWUVXnnuE7W1gAeDbJnonrH0UGK2zydWFw7U4UfIKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(316002)(33656002)(1076003)(6666004)(54906003)(6916009)(66556008)(66946007)(66476007)(38350700002)(52116002)(44832011)(26005)(6506007)(33716001)(6512007)(186003)(5660300002)(508600001)(9686003)(8936002)(8676002)(86362001)(38100700002)(83380400001)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeqrlG8nipE3P15PRMJfGDhLvC5N+da41HXUZZX4xGWRfiRohHVt8Ae4tzTE?=
 =?us-ascii?Q?WDQBHFf0Clv3rbz767EysdwO0IoJ3L3/3aO75pt5TBPU0m+WT9z6TCWGYuCs?=
 =?us-ascii?Q?9ePwZlgF+SkiPLGhgq0Wfz0FX7Gkfr1GXlJQPpjnGOtdkYidEZWCjhEStj1O?=
 =?us-ascii?Q?dDGyuKHdMOQAr3ZKh5yKRgWBxa2FAw9/owBRnceerRqD8WogCHlfAj11B+mi?=
 =?us-ascii?Q?DxvNH3kvR5mdsfnXafBF5t2lQQsaXdHUtpu8VKUCjuWH5mr27/j0Q8PTCWlj?=
 =?us-ascii?Q?/HMJV6PFBdxdaXYB/mqopOWVN9L0d5KoMosKVjDhU9zM4CF1pnVYI2CZzCEu?=
 =?us-ascii?Q?YsBfgGNIo9tV+QflcNq/E5BWf40Ovwuus7uRxwj8uqtWO+n0aP6/+TGgmSSF?=
 =?us-ascii?Q?LoklN39dVlkzlZmV5MZwMcONCpBQgX0rEnHX2mBo70G+WpXLhWu6KvksiAh9?=
 =?us-ascii?Q?lfyE8bpCAdy0CuV1T8/Lyl0W6zahmf/2I1kpqLuMxS7MYAEjHggXh/x4gUCQ?=
 =?us-ascii?Q?eRmJoFrcCh2nfspuBPCAS7WSOPP4laNzGM3gNGyBpiiEholyvvmTfh1IBmbN?=
 =?us-ascii?Q?OXmYKjE3wuYt5SwWZitMETEZEJ+bZCrjRaeuVhc1mY+gno1BOY0TykvQFpqL?=
 =?us-ascii?Q?Bs5MwX6HqOdF59cIyAqUTrMRaDg1tuEo+Po23phaBytmgH24OH9xskcH8Mm3?=
 =?us-ascii?Q?IWe9YMYe1ISfvSziAgN/m3L1MR8SDkOSATNu+oIaBEmuNmkbW4LisuKxePdL?=
 =?us-ascii?Q?L4P8QpMG7166npfKb0bszlggps1WoFQHoadeXyDKUnwVgbL2T8mfNTQf0fg/?=
 =?us-ascii?Q?d9lhdVCp/Pzw3Z0PE30J4jv4eUh+0QCEsQe3NQiMqvoKYzDVouokXjQlGxnh?=
 =?us-ascii?Q?O7u1pPZG47O0diXucra1S8rqVeC37ErKC3oC58dnkBgKnIbPSCdi4+s93oVg?=
 =?us-ascii?Q?c6tvcHBo2disx58GyoJWfF/IwKFtY3SsJ1JlUTnx8uekQZRJ4xa2BXnnUxuy?=
 =?us-ascii?Q?gSta0C4x1NbtIjighGz8n6dV1ZieiE0x8bMRV3b+dOLmb4rPMYnUcl2kGiWf?=
 =?us-ascii?Q?Xyxr9rNb2MiVUQvzs/8Er/w80T6bGlR8cZMSZzstcmR0XIwgfB/J4+VPV7f9?=
 =?us-ascii?Q?8vgnh5pARJ3A3hplpz4cjeCcs1Ezg25xHoeC918MOuuprfow2jwRYTwatGmu?=
 =?us-ascii?Q?ZXsNNpCRzfMcz0Qkd6MeJIWw0OU1QuiRV7bUecp+XOu8nSTqXWjUXqTK3RSf?=
 =?us-ascii?Q?cNPQO5kF04Eswaq01uN4vFEIzQbhJcwBVQuqVhkLpGV79kk3YTL4t0RhBbby?=
 =?us-ascii?Q?/MpNPD9m7/V7qbVsW9u7jqR/o8Fa/auHzNc+JZ2Ziw7fYAm0Ije7fGjoCmG6?=
 =?us-ascii?Q?dfzzF/fpZAHnegNdW/pERADAlZd8iLxpBD7ljFScYY9zPxL68XQM7YDx8ae6?=
 =?us-ascii?Q?siK6taAzE2HgUXkCW+wfwh2VHvSX9jp4P1fWsQG5yW2/MRbuCSOE/n4Mg/zf?=
 =?us-ascii?Q?IoqW199XRoPkv5rSjvLWDih3MNOKAZGgAd6UmGBTpwpksMMPdJHZdqHey9tu?=
 =?us-ascii?Q?+Mx4G/SZKy8xZION970UIiYDP96+464yJDoujpfa8p4XW5t/5X9kCIJ85kVm?=
 =?us-ascii?Q?R7UpyOQZ6a6CYWLeaTC33NOsr0Hnd9Y8f+YfOz0ehyd80WptfT6qLfluHE3/?=
 =?us-ascii?Q?as66bg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784b953e-a183-433c-68c8-08d9f2d4201d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 11:45:14.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYEzTewsLL+u9jC5anGrrCNFRSRnfRWvXrPf3SjLPUNrxqkA2YOW9jXgEODxpnWyu8s4RsL3jaiss18taTvPGrvRwMR2qs1D+Hzl7DOlyis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5849
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180075
X-Proofpoint-ORIG-GUID: QmIdNzhmZIxg1Ntw83H6Nvig960Rz9qu
X-Proofpoint-GUID: QmIdNzhmZIxg1Ntw83H6Nvig960Rz9qu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:37:05AM -0300, Marcelo Aloisio da Silva wrote:
> Braces are not necessary for single statement blocks.
> 
> Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 45eff3018d73..ad1d73a27548 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1379,10 +1379,8 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
>  	if (pregistrypriv->wifi_spec == 1) {
>  		struct wifidirect_info *pwdinfo = &adapter->wdinfo;
>  		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
> -		{
>  			/* auto site survey */
>  			rtw_auto_scan_handler(adapter);
> -		}

Generally we prefer if statements around multi-line indents.  It helps
for readability.  But you could move them to the right place in a
different patch.

 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 			/* auto site survey */
 			rtw_auto_scan_handler(adapter);
		}

The rest of the patch is fine.

regards,
dan carpenter

