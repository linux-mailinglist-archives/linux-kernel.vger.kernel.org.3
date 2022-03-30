Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95304EB9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiC3FST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbiC3FR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:17:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AEC9D0E0;
        Tue, 29 Mar 2022 22:16:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3V5n6001212;
        Wed, 30 Mar 2022 05:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=sjZmjthMA/NHYfVWUZfcMjLplOgNmoaSd1vnrc7IWkQ=;
 b=PcPEnVW+Z2VVXxsx1d3Je+r1XHv9xWzrNpLucsgTyMeFQqdvM2iFh9uj2UaaWkqxebX0
 fnVR6YOYQo+JyohNV7UTVOaExxVY8PFXRfoOjhcDl5N650Y6auFsJLyUZjPLXL3wkGbP
 SfIKnP0CrbAboMQ7hIfy269urIpE3ecET/7Kr39mtfdZRPSZLi9hIC2Ek2w4p8QTRPdV
 nQOyH3zObuA0CkQYHwMkVd06hN1FlsS+CBSUKX3BqCyMxXGwnTvWsDDkRIc0PHShEkb3
 vjTa2alwW5qUyxDJNm5dMcJte15XHtkqoaE+Ajt/WP3cSDtWV/QzjBPIU5kbuaXUHU5k Og== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cr8j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 05:15:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U586Er050026;
        Wed, 30 Mar 2022 05:15:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3f1rv8ee36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 05:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaJxCKUNNxGwbDaSH33GnC5AIekRoSQ4ATSe74U2Q2p+1Goli0346xOQ94X/a1TGeUOoGIm2hQCazc2fTwmccyVLlvABbG9UFQNmUDECmege+gX1M9EvAzTii7SewEj1uUN8YOuh8CRSQTT6mcHk26QIsWwQmEMEo1gl+aYjUrv/uKEzD2trT8s3U5zVhyOdzqLimwxxq987MFSTHd5XOzBNm5Ba2MRr0Q4opOrmFTlBtOgByGKwF7CuXKbBMq/Mi0rqnd1EFEGshVjck00qWps/ciH/d9QcXOcUihVNfGaPJJPQxtUdr3ZfKnEv72IGi2Pq2Vux9nwOBbjop5exdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoKLmqEebzc8lD4/ZHNdfIWHgAI0MzRb6nAmtETmta0=;
 b=MwJF6lhGXYQq+l6wNwboDOjAFMIT4wWm3xNjM8u68hdcGaxLTW3RzsWVfJQmK0RTzxnhhg/i0UySrxf0TqL2da6HJOE/2bjEUSsqzFdKYyJ9kh9CqQXfEgyFsHdypEJoTrkVvfqodJ3ziG+eFXigZWTNG/sy6ekULnrg7MEDmO9xF7MappYQWi3fgEjdNBzlh1ipSLqzvuJI2jalLcucICSm1bGXYFG/FqEFlPVsYScGEADEXPkDbrG7oVcas2gvw/Qp5jMdfMmWcRkeoqVSlyB1oF4/NYC9lf5yDUPIRtnm2QIC87oP8INEeW2Gs4O87DkAAqtZAj7GyoeACtxYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoKLmqEebzc8lD4/ZHNdfIWHgAI0MzRb6nAmtETmta0=;
 b=Q27o46kkNIrQ216t7VwYEU53TrQNDq+M0vSJdVWWH0wNwF9ePdvZutljKTz3f3P4yYxpiwSy999nSW/toWixi7ofC6lJxWIlwoLhIXqrY6iOFoz6zlb0Ii0eV8LMRe/FEM9YP8vVkbNBdxysdwaxP2Wh742DVpx+bNbUxbqSkJg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5371.namprd10.prod.outlook.com
 (2603:10b6:610:c8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 05:15:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Wed, 30 Mar 2022
 05:15:54 +0000
Date:   Wed, 30 Mar 2022 08:15:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 19/24] media: rkvdec-h264: Add field decoding support
Message-ID: <20220330051541.GE3293@kadam>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-20-nicolas.dufresne@collabora.com>
 <20220329081321.GV3293@kadam>
 <f7e5b577bc48ba16befbed47ac96c363ce861f48.camel@collabora.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7e5b577bc48ba16befbed47ac96c363ce861f48.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0090.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::30) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14fc6e7a-3a21-4801-3d6f-08da120c5d00
X-MS-TrafficTypeDiagnostic: CH0PR10MB5371:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB537115D2FE21ABA53DF84E8F8E1F9@CH0PR10MB5371.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnHt4iUxwRBm+A8ZPUsPd2LK9qAPoCQWzDtFaENdOE19i6OTIDwcVas29XuR5Xbxs3sYpVljJT0XXfqqICY2nVxfkO50JfH2WwZ7OcURHxVCWODxC0WmLcz91CP8AL831rck5YVzGhbBoBRAqOd5nSsG8HPQfMeqdrgFAAMmFd7a++14+27dFwglrTyu8oNnSzTL5DCx+s9sOXrlTimQkxrgfhPIvdcchVRVmD2i7gYxdqYlSn1wOd+yXPyvlKix5cglMpDdTlDj7cZQ2VEwt1O8A656Ifpwi8qWeWbMYzqen6OSGMEWS6c3O52L9x9if0Rvw6YPRtU1Lksj/xp3RSIiHuIhPGAwxkVm62oP5/PwiMJjmxstKAECG/+SJ5rudgTwAY2ucNufwP6dPyXXFFbiEHlJtvq7x2CcHA3vC6+bEwGxXvbOKgiwfGkMiWARRxEU7wdrnuUBJ2WjAYrN2ukTqoXTqdbSM1RePnXmt3sTNem8kc2l5hzZyj8C0ljmWIHo77FyBhLzlg7M0KV64MrxTH+wnZZa9SGnDqKCHA0jcMBCcif2GJdKFCRrOoSDJNLxVkwR0wMif0IX25Gmq43O/ZzBIw4/fVgwtFeBZq1bn1+u3Pc2yR1NzLKNCZDyUl+wNwLafIundaP8z42EV33tm3lF9yk9Zf+1C0CabvV+oNfshrL8epEPTclA8uGQObDzMFfW72gfAtELKdvLXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(316002)(66574015)(44832011)(5660300002)(86362001)(66556008)(1076003)(66946007)(66476007)(4326008)(33656002)(2906002)(8936002)(8676002)(54906003)(38100700002)(186003)(6506007)(38350700002)(508600001)(26005)(6666004)(52116002)(9686003)(6512007)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TjGe4fMk/zve6C1e4WctENFILGr6RIoM9KHYZI8UtHVfg5HAla9ZjHyX7f?=
 =?iso-8859-1?Q?uRE6nwUjikyRkwYbBMasa5wvkqxrtJriW+6b9PMlZwNID/8F6+dFUnfZLu?=
 =?iso-8859-1?Q?8lqWm5wzaVfuz+BIg4Op+j+CiaAWkQ5y7SygUFIbqWlml55xk/ho3pxD3v?=
 =?iso-8859-1?Q?9cR4oa33FZJkitS0R3W9xotZgLstwheiWh3A0nDFMQ22l5FmLZqwqR7Fur?=
 =?iso-8859-1?Q?tJn+GUurB/K54dafcg8UDn+6MhXAdyvSSj/sxs5VijxRl5e0nQE5Y6k8pl?=
 =?iso-8859-1?Q?CgHbDCN7NlWFN87iZgxThJllQ+m4jdh0AnuCA5ao6wbJAILnm1+V+nkMaD?=
 =?iso-8859-1?Q?tSde7MTwSgKHoX7IqAqCGaBNm7SWssB8CtsxDVvhVvmwajmj5Bh7qWLsGZ?=
 =?iso-8859-1?Q?pB1+EY5tAdiW09rrTn0pEM88Wna04c4exGktshGtq2zF0vtUGhVMH62u2Y?=
 =?iso-8859-1?Q?CkCgM6BcQ2Pv16b3mDydpXFDSg0m2Qkq4tg35UwhuKUEGwjBAPBaGXk+3Q?=
 =?iso-8859-1?Q?Qh1eRSMV2pV34NUhRy+F7ac0oz0X/lB5ySluZnC9XVZxjb+Iwdx5rQltt9?=
 =?iso-8859-1?Q?a6lYtCli1rD6Su4i4lCqogAqthQexMReLKw9g6Vg4nUeTb9JTDyPczxeXo?=
 =?iso-8859-1?Q?oZ9RcdEAzVA47kugvf4yYjMC8+56D2OJmsEYkoCs6a0vMfRk2FgyXHJ02G?=
 =?iso-8859-1?Q?Yycn4BcrJ2WJVrtINCD5rzeUbZ94eZQT9hpGWgPYI9JuEQWjceeweSA6jV?=
 =?iso-8859-1?Q?9NWCebrcK5MK+Uh5cpuq7ztqfFTtCizLhbxkcsdV+rvgwm8/Wfz/khbALB?=
 =?iso-8859-1?Q?N3YGVw+eP1JXfNHTUpmbd1lbZdoe6m2wROBlvtj0yKQ/n/lQNcXMHar7vk?=
 =?iso-8859-1?Q?Leq+YEGmvgGXqq/oQ2USbNagDGmWFIhF7IlVF6lfCSXV+2PYSAYLNu1fml?=
 =?iso-8859-1?Q?W+2ngVN9P0yQg8ReQLGEZEShm+ZWM2jH7nJkR6fz2KvSq4lRm+uvxCCzzM?=
 =?iso-8859-1?Q?D0de0Fdl1/xw7iGbMdAVZKyf3FivhLU2Y/LMNDQDnk4k3UoyfFeb/v95Xo?=
 =?iso-8859-1?Q?wMU8Rc9xWTVqzT1NVU62j1KBJnsy+Y+ma8esZgSHi9CTPgDzkJdOuqWK7/?=
 =?iso-8859-1?Q?0761JY96/QqxIwm8gGQ+Pp7YiWK+GiFCwmzoL/gM0tdBpUM17axfj3T5T/?=
 =?iso-8859-1?Q?tY4T5Dcz6eDt8tdeoyM7QVAzxIDSooAdCBvE7Ip0THi9ZcLrHNfSaFqSnN?=
 =?iso-8859-1?Q?Z1wSpZIA9Ir4UBjlkgWUdCQ/Mg6Sr2kKxr54H/w3U6TIDNYMTM4MZwMFj4?=
 =?iso-8859-1?Q?+e4+oqEyv9e5sJGnA+YmWuGV/CC9YfX8Imd+sc2sdwGMzgWOVp1YBt56sJ?=
 =?iso-8859-1?Q?0WOqhE+lAarVjanu+ErwSSiUJ4kELufCHhoPzzYmqMlXOxIWNpKH/xoJf9?=
 =?iso-8859-1?Q?bg6HXDjeRSgZs3LT/hMv02FNv1BXuHumYpMGctjLaFQbjSu/4C6Z/r7Y/n?=
 =?iso-8859-1?Q?mqC9lK+z2ribxSk5ANcC0lsAm8pAsMfVj3kBJuP+OzIhWguomCWcxeniRl?=
 =?iso-8859-1?Q?GZAB8d7Ug2OEhE6gGP5AeP7TekeTXiuo67Rv/GMEzeu4TXBeK4YDJi54U5?=
 =?iso-8859-1?Q?IhD9AUEvZ3D4ZgwLI2jzT0bV8aIkKAzS6fRxxBRb/J++d+hsKv84K/7Uy3?=
 =?iso-8859-1?Q?KVH707IbWjWs+P9YDaZdNCZKPRLx7nq6MBqAoKaHh7PJOrOAeu+zVl+60/?=
 =?iso-8859-1?Q?jDKPgz9XrE1eunXyrt2DxKsOp7EvTQ6VQLII9tHrVqRiy0k4Nw+DO7MdQt?=
 =?iso-8859-1?Q?kFbUwZ7cwO0TtmItOQ4MDPI67Gt49Ts=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fc6e7a-3a21-4801-3d6f-08da120c5d00
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 05:15:54.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6njO69VmgHGH1ClM2vVqMaHbkSOOnlT9CO46xOqwuF7+VxhTCpXXZ5A83RGs6RSMGBPwUPurtPA4+Ld29blHYJcVTO3c4dFh4aAVqzdkHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5371
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300025
X-Proofpoint-GUID: gE3UrIer5vmbwH62G5nyInAlAybyT16z
X-Proofpoint-ORIG-GUID: gE3UrIer5vmbwH62G5nyInAlAybyT16z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 04:54:55PM -0400, Nicolas Dufresne wrote:
> Le mardi 29 mars 2022 à 11:13 +0300, Dan Carpenter a écrit :
> > On Mon, Mar 28, 2022 at 03:59:31PM -0400, Nicolas Dufresne wrote:
> > > @@ -738,23 +735,26 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
> > >  		struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> > >  		int buf_idx = -1;
> > >  
> > > -		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> > > +		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
> > >  			buf_idx = vb2_find_timestamp(cap_q,
> > >  						     dpb[i].reference_ts, 0);
> > > +			if (buf_idx < 0)
> > > +				pr_debug("No buffer for reference_ts %llu",
> > > +					 dpb[i].reference_ts);
> > 
> > pr_debug() is too quiet.  Make it pr_err().  Set buf_idx to zero instead
> > leaving it as an error code.
> 
> Thanks for the suggestion, I'm just a bit uncomfortable using pr_err() for
> something that is not a driver error, but userland error. Perhaps you can
> educate me on the policy in this regard, but malicous userland being able to
> flood the logs very easily is my main concern here.
> 
> About the negative idx, it is being used set dpb_valid later on. H.264 error
> resilience requires that these frames should be marked as "unexisting" but still
> occupy space in the DPB, this is more or less what I'm trying to implement here.
> Setting it to 0 would basically mean to refer to DPB index 0, which is
> relatively random pick. I believe your suggestion is not taking into
> consideration what the code is doing, but it would fall in some poor-man
> concealment which I would rather leave to the userland.
> 

To be honest, I just saw that it was a negative idx and freaked out.  I
didn't look at any context...

You're right that we don't to allow the user to spam the dmesg.  Ideally
we would return an error.  A second best solution is to do a pr_err_once().

> > >  	for (j = 0; j < RKVDEC_NUM_REFLIST; j++) {
> > > -		for (i = 0; i < h264_ctx->reflists.num_valid; i++) {
> > > -			u8 dpb_valid = run->ref_buf_idx[i] >= 0;
> > > -			u8 idx = 0;
> > > +		for (i = 0; i < builder->num_valid; i++) {
> > > +			struct v4l2_h264_reference *ref;
> > > +			u8 dpb_valid;
> > > +			u8 bottom;
> > 
> > These would be better as type bool.
> 
> I never used a bool for bit operations before, but I guess that can work, thanks
> for the suggestion. As this deviates from the original code, I suppose I should
> make this a separate patch ?

I just saw the name and wondered why it was a u8.  bool does make more
sense and works fine for the bitwise stuff.  But I don't really care at
all.

regards,
dan carpenter

