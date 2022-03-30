Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6015B4EBACC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiC3GbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243329AbiC3Gaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:30:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3241456433
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:29:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3V549001212;
        Wed, 30 Mar 2022 06:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+tqqQ1zYT5h6rZk7dFpqnP5V+KiyyHy5OqllWqJssrc=;
 b=vAWTd6i04soPrriRTf7ZeRlrkPIOYgmS7waqJECaZrRWxr1btkxoYbwPb5PASjHIwbMD
 /oRU2yIZAAfUVenLitVmPM2Y3r3xA0BLvWNMVKHcAQ3NT6xMtygYr/jxyIUhjynRSRtT
 Xg+2wkrlqJnP7jziThEnpT89siaihPuCgVWbHMR7SuFIoTTLQsIPc/LKYcmfYC0Q1pBV
 bc1QljgF2jgRAZc1VtSiGOxVx2LaBtJj+jfN9dYIKjR1L0DY3yRhr5npGJrK3qIH+f3A
 Mav6XeWv1fY4E6wy27fxY+cUKGHN6K5Xbmzz/wq8gcCwjwd3zvhY10Srm+6y4u2HAI+X +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8crcdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 06:28:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U6JVR2016561;
        Wed, 30 Mar 2022 06:28:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3020.oracle.com with ESMTP id 3f1v9fk5e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 06:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnHJyiCw3+iaXQZuukZ/MqgXfRjdCZSFz0OeKTiKp6gRsz9lefPdapEYqB50srur/kmZOyZ7IcaOFCmPRtLan7u3LNS0qyfjF0LvIiWhY4MXgMUpZPKNBACgfNcs3b/nDeLhZbO+WwR4ion55I59HZ/WFn6Nrri96jPATpu8bzyoB3tLBiWQL7c3oKTaOtj38pFT/lb636FwoI8w338NpxBTijym4r6aJkcVgIOp04yNmhfBPYUmbZ+nhJPpW2p2PFMEUtddzJkzN2K6GvZV62WAJIEIoMv1FVbYtko2sKj4bkhbtfGQ5oTyA4LoW3CHmCn6wZsAUSfr8Y6l9SCBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tqqQ1zYT5h6rZk7dFpqnP5V+KiyyHy5OqllWqJssrc=;
 b=AxkJILcQRozygBKnBlDZjGTN07Py+CTZACXW/i5/+jBCm1cLTUrUxluCXJ+IwfIss4+zYFADmVMO7mKQ6JZjN/Pvb2GCWD43pxaF1NYhLbgjhxvTHlL0pzj2PxQEIJ4AT3ZSRb3NbH6Hw6arxSOXiMg1IeXtceWBYGYH4sshFx1Mfte3bsqBWqifWauwsiG//8oD8Wew4WoNeZ18gvO/1izNZC3tlwEcJDIEsVAJ5uSbNazeBKEOFKXoGeYgxGflwkKh4wgBWnakln/tMDOp49JD5pVdI83zyNis1j9VFikroF0PBxB7n6qBE601jOszDix0Q8B3hlugCB02lGK/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tqqQ1zYT5h6rZk7dFpqnP5V+KiyyHy5OqllWqJssrc=;
 b=isHNO92CAWtvRheneF9fD+e4zuuWNqfdqhahxCyyZ8dhbNyPXmSe4aa66rvaAF6VQ33fG++yEz137fKw/+YlSh0Z+qjNYa0rrFRQFC8h9poe8k4I9PlUUIVjYgJkbNodF4hwVEe5j0fddVQVx4sCEmIb/P1GiSwvglSrZn0lafw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3610.namprd10.prod.outlook.com
 (2603:10b6:5:150::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 06:28:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Wed, 30 Mar 2022
 06:28:50 +0000
Date:   Wed, 30 Mar 2022 09:28:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Rebecca Mckeever <remckee0@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: fix suspect code indent for
 conditional statements
Message-ID: <20220330062829.GF3293@kadam>
References: <YkK7ABTVt0TCbd18@bertie>
 <20220329161632.GA1169956@alison-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329161632.GA1169956@alison-desk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca250ed1-e4ac-4403-3b1a-08da12168d5d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3610:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3610D8214E01EC5EACEA12B98E1F9@DM6PR10MB3610.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJ/ctNjpZgG4/jaHk5yGvHRR8qzzznYAXja1Yhbs1x5FU2ZY1lRwKlrWd3RwYOqW/t6TDPXfdUCWeGTLMNKSH0iNRBKMHRwWWdFjkVg13QZdYZL2XI0IkmtaWrCticcugBmTUduy3itSZFaWm8Ictd7h3yFGagrtpvWjoiSIcVCqqUR9LC+6n4EDj9SQJt0bfWJbpllkH65cAItA3znu1X+QesXfCWikM2ISkWJvP6MTxGBIEGPwfBBJtwq1kCU5zts2pDewXeoPBB7moMF7Z2A71s2RZEcL+p0vJPsnWanebADWRHQTDVIH/Lk/ul4PUTrsGymOXF3T+Ag1XtB3RtsGpxbNjghuuDEjgZzQgHdMZneBjauA56EDMYyT6u6yN28W0NEmxSG4Luy/A4sVZnlY8cFSFeASBwqOMUmJ6Vbh0rzgK7dY3wPbjW681ywbKUlcx7BKWZaQfikGZ6vV0vO+b9h2nIDfMHUwLc/ssIlEqbTWpII47B4F6uLgpMH7VkAt+AV8famBxFBMh1qosM1E+gRZvBXBkcMnrfAw0xlZqGX42chcXDro9Szvacze25ObBjdE/gEaiFSph74l2khIPIqQwns9jATscXAGio4WfHbSLVz5Y8c9wiBVKfWs1633jvsegZnE/UoZQmWSRDbyYXioiJXzn1Tu1Age3dgiTHvxOX+wNRvM0I4akqhs1pEw6BLz54pP+Ek/wxzaKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(6506007)(5660300002)(2906002)(9686003)(66946007)(83380400001)(6666004)(6512007)(52116002)(6486002)(1076003)(66476007)(54906003)(66556008)(508600001)(8676002)(86362001)(4326008)(316002)(6916009)(44832011)(33656002)(186003)(26005)(38350700002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jhfrp0/HOK8oH6GQw3Rcmn3Q+/PN9UWdbbagS69TgqpXzJG5oKPuHBqtmUc5?=
 =?us-ascii?Q?iiwOlhp7TJ+9DkrMXtpVwG2d1jr4JghJyWhy6JTILo1DeTh79VVmq2Vhq2Yl?=
 =?us-ascii?Q?L+nRYx3Cl2NtJGBNU+OOTTd9CNK5h1wIULMsfDPZA4o0v6t0D12zI2wo9//I?=
 =?us-ascii?Q?GizzFJPJL2P5rkmzxoLx33jf9m85UsrwhnjmG5VZJavW+IZigFcef/+TueZ9?=
 =?us-ascii?Q?R4KzQjItGRfwYmThnOlgigEUZ/VzNM268u+9e9ccJ3Pp4I5zjlVM9g7mw5mK?=
 =?us-ascii?Q?lClw5CxK6e6Lk+d+wRjTaECek2PuhbhN0AavVVrKEkJbdXP1doKVSXEfz11d?=
 =?us-ascii?Q?OtZw6xcPbgodDKiQpVfsVxOWNHuTiRmN+SJ5Fa9fdfNRQ6f+5Vb7VY6Vta9j?=
 =?us-ascii?Q?m+4U43eOQx61fxZQYQukVkuoGfysUy6Y1LThfSHRdUHojZs6VqjT+m8tNH5X?=
 =?us-ascii?Q?c4nrAF4nfSckpNcbQuSlyypcwKQjWBPLHqBNqOvKfmvoMnwDYXDoLYfWlt7K?=
 =?us-ascii?Q?3NRrzc9K0NdmZFHrYSoFgSBB3rjHur/JExbYgaSYiCF+QI/6mZRf9yzUATpj?=
 =?us-ascii?Q?lHF0iV8VW2++zLLo7P1Z8d8Ts620thq4ksSR9qs0lgNWS1tL0VUblE14vmD2?=
 =?us-ascii?Q?m+IVNdEaBB3SN7LqzHpaTkm4CtZ8W1EC2rhcRZym8qUEBYDjOnWHkmuBXi5k?=
 =?us-ascii?Q?bwgmuXx8VtRgutAyLDpRt16dBWnXZ7C0iziQGlHUQ7pi+cnKwUGB3pPDIPgC?=
 =?us-ascii?Q?8XXHftBYc76IlPLryLI1zpy1dok53IX5dRTC0XMAOuCICKHYLc0zpsvFrz85?=
 =?us-ascii?Q?+UhVTgQ4JDtevXtDsCAPw9EeEC8NpxncqHmrKQ8pCJyoxI8ksg9hXh0V0iYA?=
 =?us-ascii?Q?MO/F/bEvlEtxfrVhP5hDWaHKbGUVUDjFJeh7Aolhj61AGf22gSLPYInluGHe?=
 =?us-ascii?Q?zHA0yhRN0M9OvpRjeeYcyy6a9/q4i2IPYB5HHDPPq8tuE0zhlvy78oifVfQw?=
 =?us-ascii?Q?PRZR7t99thb0lPpo2p0tlY5qMJGBs/5kEWVQjU9GWYcY5zrpvgb/Z0CgWp9I?=
 =?us-ascii?Q?ybcY51PnJIYLeafsZOBqlsvwjTooMgBlSSXbIcqNbkN1DMbdXcYZoXwAhrHu?=
 =?us-ascii?Q?IckKE2vO5zSVHhy+ajekDEMRnT6F4UR6bzPQbf7V4aUPd7/0C/NHOK/rNch/?=
 =?us-ascii?Q?BYP7semrcXBcIRdefEV0L/g5WucQOVflbAIrebN4HDVMTIm0UhonvtS88yV7?=
 =?us-ascii?Q?wQn5jokeX7fwBEKi3zM3ma+TVPRYATb5zceGA/9ij+sdKwyO03mIezGceSQk?=
 =?us-ascii?Q?VRnPEoWgtTgwHVhOPMCG0lABoo9kKjHguLGfDWOKzXnsRDzXXAxxlE4lQ0AB?=
 =?us-ascii?Q?4oP8eDG73xCgb7dUhsdqdbIyzJkoBaDobhkFYElYHvaXstS2R97oTRdWRlAZ?=
 =?us-ascii?Q?MJ4h94YJ2ypCFzOj38WOq7l11gs6DpLD5DMG0YGzlNBvU2FnaqZ6kIVReVle?=
 =?us-ascii?Q?5iCOvFL4/yNAFg/1HarhphH2Da9mMeotdhSUuiq87Z4JjSzMZ6hu/CM5ElP2?=
 =?us-ascii?Q?+88y5aqUxylc8Slgip2MwN3Ua7DTbrZw4nfZRKrmCTcLLC1RxZ4NezNFXHy/?=
 =?us-ascii?Q?9I2bLWWOgBeuC7J4jblG8FOIXtb32eWiLdtX9eKCgTll5MPZA/zn6eu1XzKe?=
 =?us-ascii?Q?qoK3mv2pPcleAzp9SvMCkRcso+QR3s41lZFByrO8+9YVuOICzOR4H2ANFjxV?=
 =?us-ascii?Q?9d+yHrE2X1A+EPBg+9NRwkJI0ZgVB3w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca250ed1-e4ac-4403-3b1a-08da12168d5d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:28:50.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG5PTqL5NmJJJ7PKDaqIYZJ5LO/qwVey+aGvpURnUQxUSZ5BjiRHi7G7vvn0TuziGuAwZqbEO43kq+nKCA9XKzknZpaPfdyrAI7YQHquhCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3610
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300030
X-Proofpoint-GUID: AAWaIIzi0VzXj6n0twkL5646YYsNZttW
X-Proofpoint-ORIG-GUID: AAWaIIzi0VzXj6n0twkL5646YYsNZttW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't really like the focus on commit message minutia...  :/
Basically everyone can understand the commit message.  There are one or
two maintainers who will fly into a rage when they see the word "fix"
in a commit message but I have a simple solution where I just never
email them again.  My time is too valuable for that nonsense.

We would have applied this patch as is.  Or I would normally have
written it like this:

[PATCH] staging: r8188eu: Delete a stray tab in rtw_survey_cmd_callback()

This code works fine, but the line is indented too far so it's confusing.
Delete a tab.

Signed-off-by: ...

I had reviewed this patch earlier and almost pointed out that both sides
of the if statement are the same except for the comment.  The "need to
make timeout handlerOS independent" comment is wrong.  I have not looked
at the details of the other comment.

I did not send my review comments because the patch was fine.  But what
we want is for the code to look more like this.

regards,
dan carpenter

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 6eca30124ee8..dcf7b24f95a8 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1404,11 +1404,8 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	if (pcmd->res == H2C_DROPPED) {
+	if (pcmd->res != H2C_SUCCESS) {
 		/* TODO: cancel timer and do timeout handler directly... */
-		/* need to make timeout handlerOS independent */
-		_set_timer(&pmlmepriv->scan_to_timer, 1);
-		} else if (pcmd->res != H2C_SUCCESS) {
 		_set_timer(&pmlmepriv->scan_to_timer, 1);
 	}
 
