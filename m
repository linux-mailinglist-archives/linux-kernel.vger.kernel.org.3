Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E148A700
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiAKFHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:07:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23374 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbiAKFHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:07:21 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TH7X027029;
        Tue, 11 Jan 2022 05:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Pp3+MlmOg/taluPkVqTIDFn/2Sh9pMB+BhiyquH2m5Q=;
 b=pC+H6F5eMeFUnHC0mywm/ODkfztvs43mUHD63Cbb/Bdoakkbus3mpEkciUfj+QJLRsOd
 5F/JNcYuz6B+MucF1F2CyBjZ8nmQriSHiAbR37UuRM+8i9oaJwA9YxhZF/AFIBFDUGTT
 0MpXVz5wjCkzEIyIiQM5Cz1vfpL7QXU1sv0gJCGRMs7nVZ2ecIBoyxvDsSCcLBNGojCp
 UunyYKJBOsYGCBFZqJrwe+A2/cdgbwO/TP6LN6WdgHJkUsyqj9j/+/fNbgp/Ect3cs+6
 xZoWJTUYy4GpuxJeLR4nDt2KlUnLkCJ7dqFhG0pQsdIsdLSZ4RJXsWuLRcylhHmm4igY Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn749yx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 05:07:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B56QQg070532;
        Tue, 11 Jan 2022 05:07:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3030.oracle.com with ESMTP id 3df0ndj4c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 05:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTM23tX/kPvxasoTMC8J4EnJLJ7x4AsdqAG9nbXj+THRBCCgbC+sO9Ar0Sd4KwAkY0QqAbHICaKEpGKrOHIiR6NPOFyNNyEVfiirdzmxVbCzxH9VrtHXq3dncN/Hw9YTBXLZV62gG91UQE4ksDQMYBuefi1EjKMhzVNBxCQ/IQ8adrBh/vLd4EhK3eN/GyBazGqp3mb/y7JeJrGL7T85LBzVTfh/V2Kg0Ejwwk3N6EN89xTbK38dEBIX+SnbMpt8+flRMPgoyb0+7sovDaKw4AJ4+8ve7ChSd+zQDocS9VMJT4jeg1sJbER/hd9rOtHikjT6L+0/jRVNG900NhDAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp3+MlmOg/taluPkVqTIDFn/2Sh9pMB+BhiyquH2m5Q=;
 b=DS/O1ql5hyhk5Xm5+jPQXyMvfGw4YT36mc95WIXrZxzsRnJi5PJHu3sJJweSRhzx2oD6ycQOKKJnWIAGWh8pt8C8v7vNarcltMeU4DRnbShNHqDkHN2sqEwRr+Tah/W1Wl1EgbsX/4rCrTWLKUnzr9o+YxtvMU6VSpmOm1EGjCD0nE6iFHQSPpFm8/mdCzG5FB3w8QEGTRO2i65L8b3vRZpg879i1WHNLH71/g61tzL8iuq8ILeTj9UR7OJI67FKqehFWGPWOI2HW+JkJTgD8rcAkMizzb13bMRZY8h/VCslajGV7VPSaINotDhTFVw2foqUHBGFGVEx0iiDeN3IgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp3+MlmOg/taluPkVqTIDFn/2Sh9pMB+BhiyquH2m5Q=;
 b=rB0w2JiY42Tf0n3cNq13dL7teZ25fYouDjCwsoeHdt6hw3hw910Oo9WakGFOg8qTSiUWGfw0E4MWaO8iVtiHBIiThTDjPtGhwh7kq9kF3YjmG8ne3O2Vw6P1ELIN8oooF4DwLaVfPrPDZsMx4MzsGchzV4SDB22vMbpEDARC5Vk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 05:07:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 05:07:07 +0000
Date:   Tue, 11 Jan 2022 08:06:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] staging: r8188eu: convert DBG_88E calls in
 core/rtw_iol.c
Message-ID: <20220111050644.GD1951@kadam>
References: <20220109215427.887-1-phil@philpotter.co.uk>
 <20220109215427.887-4-phil@philpotter.co.uk>
 <20220110100843.GC1951@kadam>
 <YdydYlpVzHoLy2Wh@equinox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdydYlpVzHoLy2Wh@equinox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bb34142-19de-4851-3ecc-08d9d4c036b7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4691F76A2F9D309CAAAD08788E519@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9gSgVR0XGbVMMG3LGj+DzrHC0MNPrXRZZEVnnMWv+SAFEjzLhXShEJqwi5SBQiAMIWKAeDUnZ+wifqbZfq+P+ukT+RIG81aNGVcoTXcc51uiIzZgZ5B61xFRokZJdPJzo7/ij7o0NhGt3umxOp1xbMJsGQt8sxFD2zyxVFEznBzMeE+LYxdhaKs4UM7QuV6AQqKvNwosCM62vu6vAyBLutMPCQMEbDiK54O2dV/XUyfraDgXrSXn/kRGp8lXPm6HIHaADSt42nJ/L1O5tcwrWasFJUCGwWjUafh5536FcZy59ZPdAqNM2LMumrOoU2waotKl+YeAk9vLf3aaS4SbJkvFxJDVL1Pcm6WojcOAGmh1StgtzB2he5TE6m5emjFcHVChCIc21csT3/ahlUAms+Hy8O7mPhzv5PSW0QU6UpLrWoEJeo6bYIQslq28VAcY+8Gz+tPjeiIk/FuGTAM90kzZ8F3xdAr+qortmgsESGIyia8rlavL8FBWq6I89No77EZL3T4094u3fyIDJl5kaXTYJU6ZtrWXKLgZ/DOdmmWZVOfz5qW8sCdZwX4ZaBR3obNEDzbH/t6wgZ+sGswQ6lNEzJU+SSoDzUBYaU+6AtIOtPh3Un2rkwcGQoKXDtV/pJx0E7/THausUz35/SksATl1/z1jnzu+B6MtVKJKlI1CHucYWcYI+MX28q5sweaajVp37JNUp4vQJhwoKzKYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(66476007)(52116002)(33716001)(5660300002)(6916009)(1076003)(66946007)(44832011)(186003)(86362001)(33656002)(6486002)(38350700002)(508600001)(83380400001)(2906002)(316002)(9686003)(6512007)(4326008)(8936002)(8676002)(6666004)(6506007)(66556008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MpqWCzUPiI09U4lujb18f7lU9W7ZZAXZf+gzpcnZOjdu3Fn7CyrhNm8j2KI?=
 =?us-ascii?Q?GBbuoSNGlMTVMHJQ8DhJJAe1KPpV6ciEopLbXytc675+XJPnIDWgDK2hYiP9?=
 =?us-ascii?Q?eb4IiTYBOt2ma9TvUyo9vjeIfJJ8mLXQ9t/F96yS878exL5jFFOyRYha+nX/?=
 =?us-ascii?Q?2PCyLbUTRQZZIk4YsQcZvR4DUUVicw2sBqqKmiLKb5SEo7wtzrB7xTjmdjLr?=
 =?us-ascii?Q?vUF4f0ILn148Iz27wuUCvp9W4KZ6rSgxPL2iwJmV9dB6E0CUP5GeJ0EIUXfB?=
 =?us-ascii?Q?Jeldye6NWfSEgobbWTF/YRi94V8IzkNq8M2rjI0d+v+Vz6BqyJzcNyaB+/zQ?=
 =?us-ascii?Q?JqiJPhwZiyxe4uQg2+eJVyBEcw9opJYczydSKkicnlDOOuEfqHxs5xD9J/Kr?=
 =?us-ascii?Q?2brKvY1RFDvNqdHiItoopaQYXiBQnOkdeyiWwRbAOKZ/LsVUTQb3E9KSmOb/?=
 =?us-ascii?Q?SfIQZkJbPBZi21IousRzoK1xLOIrs3ZyTP55398M0RJk+8rBtkQRKQ3ZhEeo?=
 =?us-ascii?Q?JVjH2Vdlij2zY/dbty+ICKukc4L916EGSrMaXE0yroV+Q0iVSMjlNXjjdy4Z?=
 =?us-ascii?Q?x4qEpRFLztjfB07YxPsn+6WdVazSVpRGdLkq7b9OLW1MCSeeV5vYTHWVOHWA?=
 =?us-ascii?Q?BWtoCLiYkzz8/PZ804dYCg6e+CRKLG6jt85ALXsos5A8F5xG4nuqpRFxFd2B?=
 =?us-ascii?Q?Wbyf4aFrV4NXSUbx4+eVRj4jNgkvcvS9U4uXCI2fUTNt4FPWRuD/F2VUOaDd?=
 =?us-ascii?Q?bvlScvfwpDbHze3Zgw6NPcbMcuqXWplMnHSRlxg85xnNMxoBKCAwzhyI5ijn?=
 =?us-ascii?Q?v63fiAARkTyEsWFbNT1UPAL2owsDVCJfm2VqhSLotFXhlHnQ1YkvsBifESzr?=
 =?us-ascii?Q?htIqe0sFXVdv1xmHOpIrXyBA37OLQ1fqAKfHlZWe6Bv4/maj85BX0IdfrDuj?=
 =?us-ascii?Q?V3r26xOcmcXdaQkkk6nYGgUSK5X97MWYkM4hFk8XmXS2nJkLi+MjXNKfmk2r?=
 =?us-ascii?Q?Kb0tDAhnHGmCtAVvHASZTpWjiPCo+098K9C7gorsPFGxzDRh2zwRwDlliflT?=
 =?us-ascii?Q?PdclcJ05K3o+fmPV8iw0YdO1oEYwGdq38NLBgtZy8wd3FaPC3QCqjD5K2UzC?=
 =?us-ascii?Q?vea050d1ZaBzBPTFhnf2qqzOh9c0z4m9ahyYYXZNj6osxXR6XGh+Hj5RyfbH?=
 =?us-ascii?Q?DVKGhTUJghj9SeB7isaeoI+9hAxQQXtuUpKZvL3Pr/qHT6ftaWXcP6OjjPEs?=
 =?us-ascii?Q?oFeXaffyAuWf0ivOirmRCujL6s/8YNRYUKVRCnNBRi9EbMvvs5HNl/gdM6HH?=
 =?us-ascii?Q?qHgDgc9BNBaUyWKr7oUbBB0S/+Xv1GhDSpvVLm8hWHRhnUS36iR4ogkz++du?=
 =?us-ascii?Q?PffH3dSf2oOcQl2kDFqVafq3UdTk0psXARqeMyxp1fkqKH8RD622DPxZ9arY?=
 =?us-ascii?Q?lpkA2T7SW+Gi73lILGuet8bRe8i4QzFwtiiup18DrYD88v4LhDrNyOHEyc+2?=
 =?us-ascii?Q?qB7wzXD/fdsfLnPauZ+vF6qxZjIuB1KCUj7M/t8Zz2p23jrdcQ9WDfzpUeJV?=
 =?us-ascii?Q?VYYzh/ItBr0pmSWdD8ZGbhG+wzrFc7aEkG8FYZDPnGeLPWnlxU0CN+5MYzxq?=
 =?us-ascii?Q?UNy064P4WCliXsbYYgDYCkp+pbdjRD+XtASqJza1F7gdW4STkWMZYcnThS+F?=
 =?us-ascii?Q?TyMdnq+W95Xyy/ll8cO3mteZwm8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb34142-19de-4851-3ecc-08d9d4c036b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 05:07:06.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ0Yhr6xLO/KEg93fHad20PC3EK5UKxUCUaMUqaiR1HW7TpTygPvcHSsPKvLMM3Ns4U3FpWpnuzIkW/qfLHvQ+qyt34OY1Wss2SkWAnh7tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110023
X-Proofpoint-ORIG-GUID: X8DT1FNDQtWgKMyrjn_mrUuevzta0n-T
X-Proofpoint-GUID: X8DT1FNDQtWgKMyrjn_mrUuevzta0n-T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 08:56:02PM +0000, Phillip Potter wrote:
> On Mon, Jan 10, 2022 at 01:08:43PM +0300, Dan Carpenter wrote:
> > On Sun, Jan 09, 2022 at 09:54:23PM +0000, Phillip Potter wrote:
> > > Convert the DBG_88E macro calls in core/rtw_iol.c to use pr_debug
> > > or netdev_dbg appropriately, as their information may be useful to
> > > observers, and this gets the driver closer to the point of being
> > > able to remove DBG_88E itself.
> > > 
> > > Some calls are at points in the call chain where use of dev_dbg or
> > > netdev_dbg isn't possible due to lack of device pointer, so plain
> > > pr_debug is appropriate here.
> > > 
> > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > ---
> > >  drivers/staging/r8188eu/core/rtw_iol.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
> > > index 7e78b47c1284..923da2a9f6ae 100644
> > > --- a/drivers/staging/r8188eu/core/rtw_iol.c
> > > +++ b/drivers/staging/r8188eu/core/rtw_iol.c
> > > @@ -12,13 +12,15 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
> > >  
> > >  	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
> > >  	if (!xmit_frame) {
> > > -		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
> > > +		netdev_dbg(adapter->pnetdev,
> > > +			   "rtw_alloc_xmitframe return null\n");
> > 
> > You're going to have to send this anyway because of the compile issue.
> > 
> > I feel like you are not being aggressive enough in the debug messages
> > that you delete.  For example, this one should definitely be deleted.
> > Don't print an error message for alloc failures.
> > 
> > It would be easier to Ack a mass delete of these messages.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Dear Dan,
> 
> Thank you for your feedback. I already sent a V2 series to fix the empty case
> label I left in core/rtw_mlme_ext.c, sounds like a V3 is needed though 
> based on this feedback - admittedly I have tried to be conservative and
> basically only removed commented DBG_88E calls or calls which just print the
> function name/line number so far.

Yeah.  I saw v3.  It's fine.  I'm not really trying to nak your patches.

> 
> I get what you're saying about deleting them all just being easier,
> but I've already converted several in previous series that have
> made it in. It would make sense to delete these converted calls as well
> if going for the total deletion approach. Also, I do worry some of the
> info could be useful. I'd appreciate your thoughts on this.
> 
> I am happy to delete it all by all means, just want to make sure majority
> would be happy with that approach, as opposed to a refinement of this
> approach and being more judicious with deletion of more DBG_88E calls.

In the original code DBG_88E was kind of an error level severity message
not a debug level severity.  Of course, you had to use a module option
to turn on any output at all so it's hard to judge how that works in
real life.  By making them debug level severity, you've basically
deleted them already...  Don't be a hoarder.

Once you change it to dev_dbg() then it becomes more difficult
emotionally to do a mass delete.

There is a real value to just deleting stuff.

regards,
dan carpenter
