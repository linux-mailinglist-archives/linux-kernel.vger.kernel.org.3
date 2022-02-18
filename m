Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22DC4BB965
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiBRMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:51:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBRMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:51:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907A964D9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:51:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IAPkRc021769;
        Fri, 18 Feb 2022 12:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=AO9I93mm3GnKzfpQ4jfEeEvtRhBbY+nlrzg/UI497/E=;
 b=XhLj7DBn3Of76yJnEEDeVHxXIXukc/zzsduTZWUfw8rgQqOzyL6cyjjydvzvYImQ1uST
 3ArxU+5n5F6BsAPq8Gr5iejUewMpd0BAZUVn0BV1JeXBNXEuQT1I6VaVEKnM94NA3kCx
 djrsHsV+06EmGiopd3/s7bxlh8fo11tGpz8xAEZgd5345zuWPaBlYe/mlTkP8zgNGoZY
 88zfcGT+iBRLabjF4/MMzNumySb0D/vgHjEbUOs7ZIVbatyNl+/GEeTlPeod3OE6v7yg
 fqrehwuqyL0tH+wOFZJJgjvLCThCBN52Emme3wWGtMl+m9DJH+Wp3aZJ6GlCnpeO+jUq UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fgp9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 12:51:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ICoCCA196167;
        Fri, 18 Feb 2022 12:51:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by aserp3020.oracle.com with ESMTP id 3e8nvv8dtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 12:51:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMGUe53a6jp6f3HC3f1gxpP1AWEsa3/bNDsxzu06Okn1ylcfPuPVqep2OqQzRVfsVXYOFuo0yYJHJCSjWzcvxeAKs+zcsz9Q0gYPR26vjkNZvnIM/Mg8rlEy/iWGevBwGePAfEeKDwo+ag+5prCwHtNYg5LxIX4wvaTDuGC1xgpElJmxfdjWf52uodTObiGUH6Q3C/qyiMnffnYaHEwUmhmLvmnn4plbNhaqPJoPpwlrkeaUSDaQ2wH4Qm7TKEz8Bx31y4hhuZZqOOloKy+WcVMh48lYhgCqYye21XX7EM0EO2hA3iWOIT+5mVcoJl6pBhOMVWf6p21/p9wUllIgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO9I93mm3GnKzfpQ4jfEeEvtRhBbY+nlrzg/UI497/E=;
 b=mv91Y7Ww7rvJp1iYQpmUzBWHMPIkEdr3Rqn1EhEc7MuzoTr31wu4o7R4KQkFsod2aDB0CAtRCcVsBpLyrHS7bbj44uHSTkOdXE/Pd0ETIfU2RxT/umDvJrCP4Bz0IrOt4PXjCqf2eBnci/nIhwk2zDuNNKFqPPf1dnTV6GUERU59YZ8n5byHGxNa0sCc79+jqT5cAhJi6gt1FcmT5ynyluAYcHjgl993KS/mOm7fcTN635EeIvrI2laIoEJ0B7a8euOAkV2YMN2Fkk16IzeaFhuzctaJsYaY429Rlx95eNjFyXWiejFVUAwTGBWn4NKMtN+agAbDEwrobCzAvK1mzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO9I93mm3GnKzfpQ4jfEeEvtRhBbY+nlrzg/UI497/E=;
 b=v81Bagxopi5PBEVdUJAmzS1Zng4Id9QDnBloGMqL8qEouSTgKXrvP5TFCG7tgu+//YPk9B95vOL6ReKfO4t5xPj2IyXk+snvOLv5e/qVagzJALvdy5GeDqg1NVDEcDx2ev8EK5y8BFlA9B6Hfb3AEIZXwr3uy4HIbyJWwHkpk+U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1671.namprd10.prod.outlook.com
 (2603:10b6:910:8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 12:51:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 12:51:16 +0000
Date:   Fri, 18 Feb 2022 15:50:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcelo Aloisio da Silva <marcelo.as@aol.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary braces in if
 statements
Message-ID: <20220218125058.GE2467@kadam>
References: <20220218043705.GA23783.ref@snoopy>
 <20220218043705.GA23783@snoopy>
 <20220218114455.GG2407@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218114455.GG2407@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0052.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e6a7cd-2a05-4ca0-b7b0-08d9f2dd59e6
X-MS-TrafficTypeDiagnostic: CY4PR10MB1671:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1671A84366CA006D9BE28FBA8E379@CY4PR10MB1671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3g6ABZbrO+GNgGCSph7TR/Mf3/QhQ+wF4OY9haUcrhB7g7l6YuwiXDft1ZMUxeWecE1iEZnWo4mVqAnfHoqTrJJo4SeYC2N1tnGeq2lMVzLRJh1XFJIYqKZYwLwzQvUCKBfxOZNYRzpDcnA7ddiAA69SZftqGxlZmBdXjdGXfvw0uInLqF8zengD2jXfsuT6yJC5Md0Rt+7MdFepm6xOCLVtFlWBH+VIcNDiMpcAK6vuQIZkyjjooDmBL+Zr3oZ+R2ePNbaqi/J+6/72Ei1xFvvTwdfiR0K/2I4Wa5nKHXF3OGI7TfUx0vlTNJmJit5pVa7dQjYJZp/G2LMk7EbfOcE/Wp6QEIGXd9tN4fmrC+ePj67PWQgB8XI/M8QsjoLSRY8LJjykDDc6eN8Zy756jkG8FN78b8LZjcCDJebtc+TOc6BqejaNHDAvOF+HhRLtwN3HSowOcHzkOtHbiM3WQev6xbOQYwiM4O5+yrqUOJs2w997Jpmve/wF1pyU6SCjUGX0YNCvHLaGeKpodn63HVE1BpCyqJmmBgKkbayMZftgCBmw6vgPqFAeJ60z/cA2MrXGFJ4LREdfkjADsT4G44Hia1Q4IjOayks4/qfYXLX0v2Cor7ulPGNjvaJnbv4z67f+n+IekIywZaXAy63Clru50HFhrOZab4EJT7YzWlooXZDh66FDzcrih4AOp0KbTbniW2fK3FlzIJCuv1eiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(6486002)(508600001)(38350700002)(8936002)(316002)(26005)(9686003)(186003)(83380400001)(54906003)(6666004)(6512007)(33716001)(5660300002)(52116002)(6916009)(2906002)(1076003)(8676002)(86362001)(66946007)(44832011)(66556008)(66476007)(6506007)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hupzRKIIk9H1aFUJXj7GDpo7EikCF9NsVqVEIOp+3ktecQ2UOx9IVW5GTLh3?=
 =?us-ascii?Q?XEtdjNeDHSSGAZ2P3juhYUBYO/k4E+XB6UZ2fm7B649QdDQgTFa6lEs7yuvO?=
 =?us-ascii?Q?NEZbQDwPzmpYkXlsDdmLyMe4RQA5gaRBDOp/TL2ETj9V3a8KeuCN32F8CfPY?=
 =?us-ascii?Q?SpocO0tUG5XneRI/JLNeqpNN2RE0qqiZ6xJ/MZ1wvOj1fbBAuClfnj4gaKZF?=
 =?us-ascii?Q?ar2xWpub6hcRMUAwM+dsFySCr9k8dNy5gd4wQ0O3WulqVO36cdmMii5NL25H?=
 =?us-ascii?Q?NdKCm3LDz7Us832npuh0fzyfcnG9dDraRDQZUozrqXGEJBwAPc+jfSqB58bM?=
 =?us-ascii?Q?ZR2wV6LMX5iu6Bgh8U+mQ9lviPO1yQqqIgU+ADZCYIK+2Zm2Pn2SHQ5shN+s?=
 =?us-ascii?Q?Q9sWvSvFkIIHDqy0vsqhvCNIn58RkWkC8LTbdqeujDMyjVrdXJvqILXICr+o?=
 =?us-ascii?Q?ZEGTlfshfEQGH2CUnrtryohhQOk3FxsZM+gmnzzyMDeLlNWJrkV1xtqCx4CD?=
 =?us-ascii?Q?SVwuD1bHIXCproEM8RTG0OLx8OnrahSxHQ+9o3AtTn0vadsJ5eYPkQOXd9rj?=
 =?us-ascii?Q?nbiNBntefwjFEl5YVCR4UWzCanqI3QzcN1xm0bdlyWjIV8rq1g90IoTejdfu?=
 =?us-ascii?Q?KE22kGsGxZkUnbj3RTGdPxeJu+IvGKa/SozTtBiqHUGv6I1PuCPWQfqJLBr+?=
 =?us-ascii?Q?0SUbQ/M+A/MZBbhj5uSnDcaH4H3dIyNSQy/LBHBh6/y69JCUd6MADWCFezg2?=
 =?us-ascii?Q?H/i5K6VnJNzvMAf8doRVqeXKjCsSiKweejkZeZrB8vptw2FyKCevDP36rUZr?=
 =?us-ascii?Q?xDWaTra7Mt/ZP9LvRBCpIX8u8oO/pMJCsHCTLfTRdYAB9Od8sgWUthEiUvb3?=
 =?us-ascii?Q?lBWyoV+7Hwx4/HCPgjKhwiiV974mB1ppHU4sDbexyzx4UZ7ngTemPw34E/E4?=
 =?us-ascii?Q?l0nB8rIOr3J95vbP6TsDTSnyK6cQQsiFywbPBF3GlJpST7Ox5GRXA1/0XmsM?=
 =?us-ascii?Q?kNOigc571OHgy+8GK6PveVJX6LJd5/nHWhzZUs6jtv/ADFbva0EydMNnXGq7?=
 =?us-ascii?Q?M4gHiNHzBp+oUpZTJdAX0fjefmkhs+fLmVGuP0R8j4MHhVEtMzyhBD6mzaj5?=
 =?us-ascii?Q?s5z47rlpKwE1P4ImanHA8DImFzHA5UFIHsDSwheqEIyzyVz0gPLWxS0nqBXC?=
 =?us-ascii?Q?kSz4mh4vq/9h61E0rWim5ihth9lla2HQw9d4iixZ2SIuvq2AMHXrkEan9vOd?=
 =?us-ascii?Q?sGiO60HtKcc3OoMTqzuOIuBcJvL/Rao+aGsbEtOxjQ/7eAThAcaJudvJW/Ir?=
 =?us-ascii?Q?c1+T8aqQH+6WwQ6rlCX92ED43aw+fPIRSWTsuvsFwUA9bDmCwZdkW3mKwxGa?=
 =?us-ascii?Q?ha8ju+5vH3NREUofSjWiO+w6bBLre/IzC2ZyA+iBlRA6aCg44uW608fMuzS4?=
 =?us-ascii?Q?5NalDU7yfZiPDi1cvyxl4mICfe7EpHTw7JHqUXyVmx9+PA8i3GqGDVSgCXLD?=
 =?us-ascii?Q?ICVvPH6hh0gy9b2N+ekSvl4zfFhSAkUoVK+Wfjp0XLG3dUPAKLzkJzmrOYkI?=
 =?us-ascii?Q?QQFpsedyCbNBG31qLr079wiikMX/CoT6OlDGoAOnA5S/wV4Tt7cVDF61Csgm?=
 =?us-ascii?Q?xWb/8xgV0ri5RZLGk/rngX+DMqm6SCgo3mYJYn/KuJiM736JHteASEnWyxCv?=
 =?us-ascii?Q?himS2w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e6a7cd-2a05-4ca0-b7b0-08d9f2dd59e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 12:51:16.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrKJiW1Z9xNYUNkkTfl2rE6a11pYLcPMSE0IG+X6akTUbRcqG4sziRsdJGSfSGqz2Z56cdczqHcdjBMhQ1kFQwFBJSdVAGLUup/6r5WrBuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1671
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180083
X-Proofpoint-GUID: 8l7V16HJysBoh74aGVkafZMBEr_mVTYu
X-Proofpoint-ORIG-GUID: 8l7V16HJysBoh74aGVkafZMBEr_mVTYu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 02:44:55PM +0300, Dan Carpenter wrote:
> On Fri, Feb 18, 2022 at 01:37:05AM -0300, Marcelo Aloisio da Silva wrote:
> > Braces are not necessary for single statement blocks.
> > 
> > Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_mlme.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> > index 45eff3018d73..ad1d73a27548 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> > @@ -1379,10 +1379,8 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
> >  	if (pregistrypriv->wifi_spec == 1) {
> >  		struct wifidirect_info *pwdinfo = &adapter->wdinfo;
> >  		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
> > -		{
> >  			/* auto site survey */
> >  			rtw_auto_scan_handler(adapter);
> > -		}
> 
> Generally we prefer if statements around multi-line indents.  It helps

I meant "prefer curly braces around multi-line indents".

regards,
dan carpenter

