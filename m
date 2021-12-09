Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAC46E9F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbhLIOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:32:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55752 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbhLIOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:32:55 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9Du01C022879;
        Thu, 9 Dec 2021 14:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wxzJqbsytxddOwWJFeFsnwgxKE5oS3PamUJJkw8Lwjg=;
 b=A9sI8RHJBeSGf6K6LPSanMicSLQ9T9/jeYhpfEcDJJYh4dXjv9pYZBBCm3WiJ9cbvd6i
 FqRp34M/zim7BrkTeJQOnAa6xUI6C9PXwEdshInWgdSmHqOxvONjnkW+4OrJ+aV78Upj
 u1CHQmbb2XujJL7kWD7uCVPlUJcfrN6rhGmBltMl28MBY0gfVhSbcJGJP29Iv0RDxZK4
 zLfjnr4R1fR1UDESBiRi5wdqkoMGwcNTbg+xJYO/5L7O3l081N2tIRHysjW6A+csKCHE
 ZxcKlkXj3R86XloW5oZrzPioz4FBugoAfjqYM4OnlrLf1tAPV1IHcsZ5Ou4PPWQXhxSk 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctu96u7y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 14:28:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9EADnA001477;
        Thu, 9 Dec 2021 14:28:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3020.oracle.com with ESMTP id 3cr057vwfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 14:28:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEkpMGc4cxhU6FgsYeSsRQW4//S5tbev4idlDHckjCuBO3Sz92LizmUYD1QacazNtFYX09wevR4tpNQOwS35e4DItMz9ZEgQs/UbqpNu6IoIGAK6kvNCsWR7r1Vfvnc6wSTa4Sj81fzN2KUaKJ9fu204Ql2XjA7EIx5wtVQl0lyttn4oR/PLbORjukQzXLke4d4M4qj/BMx+CExI1dng4lRmC1IGtddf/xBxNn0S1tYy74Rs9MHxpoSZjnzwZRkmyJNVyfxuh2K2WaiuvpRBCY1ywOgL0NqNZ/60tSImT9LW4VPjKuORavj8Z9YuvkKiYQY6Vy9FCs5gO9uQHBIPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxzJqbsytxddOwWJFeFsnwgxKE5oS3PamUJJkw8Lwjg=;
 b=Z1rprnuHH0DulGyqubwAM6AHmviAcBPaexgQfLb5cWQ1b/gJnBRuhZHToEoB4/KB/3xQi7OtR+3PnwBYKl/5d7Wg6iweWLy0pg+wimOG4tSTPZ0sQAauiuyd4wwtD2aanaKFNTXMrY4Phodc70MfLrPd8JvFrKIqQ5Fm6G4kEL8/KBd5Sp8yk0f2EJgT2Dunf+34SsOjg9IenJ603pkBcrFMUwH220q6U/W2ShuC/NxSbWW+VuhfJTmlNfakPCzR8wdmTxZqVNVBEwHrQBGMPVoSqeympG2npIBducwEqbwOkShlv8Jmf8aoao7atnGBFr8bPIw8N3XxJ7LAjckqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxzJqbsytxddOwWJFeFsnwgxKE5oS3PamUJJkw8Lwjg=;
 b=GifKAYbgoGMBffdJ1shazUHArAFc06HkOEdGzMJX9jKfwdYZqapgnNBz7ql7nPwBWS40Z4Scy5bQudyx37zLKo33iHhcMgqLBGaU0Y43ehavWaanmPmbHn6dGKX9pBjPc1tfsH+qVv3tFJI3u7crI+Ud96hwEhnDTde3ZCBScSw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1357.namprd10.prod.outlook.com
 (2603:10b6:300:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 14:28:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 14:28:56 +0000
Date:   Thu, 9 Dec 2021 17:28:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_pwrtrk()
Message-ID: <20211209142829.GK1956@kadam>
References: <20211209132516.8387-1-niejianglei2021@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209132516.8387-1-niejianglei2021@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Thu, 9 Dec 2021 14:28:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 842c9877-915d-4346-3112-08d9bb203b2b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1357A3706184E60FB741B7D58E709@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ty+iw6FjBgUcBp1oqxFWc3oNGhPMh5tIf/Ksk46F1OdngTgtbt4sVzp+xUlkCrcQCFBhUCK+VvrgnSiF1R/AXh3nrWk81x+I2uPZWOV/0x+lvIbwjmttt1rtiCAA1XVv6ZYORu+oUt+/mkrcl2XxcYTo8YyA9lV4eH9LxibUne4+f267X6CsrNRi6+sfgm5zzClj3mSO/hTzn9uzBXmpy5JS9cUNYsyFA1INPU2B0nbiOTfg6WrcOOnWgnmvdq59B6b593fuSBtnaiK6UqfS3QlgCZPlVL1y/KxlIE8drRBn4UDq9Uo8rBiDU+rP0JZuc1cupvl3Y4EInFgl1OPuxeT5eujLPIBIEms+rGWSRLGcJpaDdFXOXZFazFFGB0OQuBSiCpM9OFTcVB4lZesJgYbI4ekgWuV4jbx24dB2ualx25hCIL+1TSo60cORPX3lmF9TVSY24eK1bIOARGIFTxZUVM6KlE+zRnREI8Hf+h5biXWyvZ2Y0aOd5bsC28V1AQLpZoRY61bthq4XEBQekWNVbt0rt0BqImrA8OVKEq/NMOD6Yau93dHndIXv6HzJl4k2s39elXyEqZ/jGdHeNsywAWMoflLJO6uJSAX2xgdi1vpMHLtwSSCnDCztxBLxXd0ipOjQJgXkD937cwMh38BjgMmvERO6aBN5uq7MKX5w/VL5YRRMwkKVvg36lq34nUhJeyYTTfxF8eYdG0zYiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(9686003)(2906002)(508600001)(66556008)(4326008)(316002)(38100700002)(9576002)(66476007)(33716001)(1076003)(38350700002)(33656002)(66946007)(8936002)(5660300002)(52116002)(6916009)(6496006)(44832011)(6666004)(86362001)(26005)(55016003)(4744005)(83380400001)(186003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0vs3GeZWNO40h+h4Fv+SFIrbJDid/BqH2c06scPMunSU9rNQoGNUlPrNki/?=
 =?us-ascii?Q?gmhKUuB5r+AII3/uMd58ZDtbJNHVi+1i1UmdZm3GnM3ZxknbWYwuV9n5ayH5?=
 =?us-ascii?Q?bvytjtMtMg+OHrbj7nVzmE2K9Po+zi/32f9TeZYzN6wL7vSnbhEoTVMbXqL0?=
 =?us-ascii?Q?efupu9ErqbHxBHYWqUz1QjLY8bvs5CIdsCVLVP0JPihwN2PzYAQnGmfqOo/9?=
 =?us-ascii?Q?vEWiCtsNtMy5iI+kyRxNjGmYaHJfajho2Eaf4uotxa6YSiUo2zoQ3c8msGDb?=
 =?us-ascii?Q?2X/khCRL8gOPdSJuJD5IULqbnCzs6/U1xbzVQqQ+zouAaBnttYeIMFeyTfPW?=
 =?us-ascii?Q?gaGp75hxN0sK5cE48+pUwB+lGE/Edw0QRY+pizp5aTJ66236Epfek3dv4326?=
 =?us-ascii?Q?PVb+EKW2JfGjwI71y/OLfSYq5gUAukydJ81uSbsBOCM2dUZbHQnWeXmW6X5z?=
 =?us-ascii?Q?KfQnwumQMWkRdJBU0g6wZFOQaaVty2Gzx5c7vlTS8Wa6SYZwTUL7by9CJvUP?=
 =?us-ascii?Q?G6rkVfVU0+A4WWgaGtMiwGtzY4hnfNEze8QpT7mdhzyhnaP80zKJ6DiYPDp2?=
 =?us-ascii?Q?XhJgSeKW3L9O84bpCGE9EJ+SNe5JQJS7zq+ALLSH4ky42cf5a+RQPaK2kWiZ?=
 =?us-ascii?Q?N56461YJzAxS90vBM7I6Nctr5RT65oBsnR6tgsoGYlcWigQTdQWA0FKFHX56?=
 =?us-ascii?Q?GrczgmiNoi6hMpvUKZRBqdiO03OLCtJkaVCOQ7LDdi3fhbZkO6T0P3bX3+Ck?=
 =?us-ascii?Q?0YQ5UZRBeyxOno7NRDULDQ7Ve3JQLTfjXQrxzGQRsyD/678xfJA30spR2FDk?=
 =?us-ascii?Q?nYAQSKejXfVNyrR6x/Ns6Do9QrPXaEgtho6ngKT6iShuqPm+p3APPv5HhvaR?=
 =?us-ascii?Q?/dSKcxHS8m9glfXkPtHlp3BIsz6Xg6vU6dS2j3CY4uSWPwdgEbn5oBuCBrtJ?=
 =?us-ascii?Q?mBEOlHQIuJxJYhUqY9RAtIYKbRTNPIV6+J/8Ci7a7GxzRilU8xAGQ+T/S2aJ?=
 =?us-ascii?Q?N4ztyPvSK9nTsef54s0BvmH4bIL9txrLpQPdNyjdzE2CI8GWkC029avHBrGR?=
 =?us-ascii?Q?snvQzvDKpV3+veSDapXcqQq0vtBz7OR1+fB4m/Aeq2WrDXOP18mMdyYq82Ah?=
 =?us-ascii?Q?TJanv/yOOgb2wdvuCLZHWcfp0rgaJuJz8wjo57HODx/fW2d4rjZ0O7iTKIhk?=
 =?us-ascii?Q?6iRpQVbKZOkPYiVld5e00XRbjMga4n5SHvy014cOQstbbC0iu3/8fo9+JvbQ?=
 =?us-ascii?Q?7t/8YE/F7TzJPXg8LTY3N9oFJ0Pv974YARZlLiNDSYSWuC8d+j+8tn/OvXGq?=
 =?us-ascii?Q?JFIcUyGcSoOHAArD7rmcQZ5raCIR7HYDMNYCoeCUMy6b9A/8gV1T2b5N8sby?=
 =?us-ascii?Q?XAJso0U3P+DqG/uDuEsoRVq5Oq194eqGYO1ovlK6Lp3Pcl01W4dVvhombLZ5?=
 =?us-ascii?Q?2dr91ux7mvV+HMQT38HGTejj1A6IEprn/kz8dZnRa4nfprHTgs7pD+bVljHg?=
 =?us-ascii?Q?CfGBJ/1J1VsfQmlJrj0yYtHo2ZjiiGYTtpszeFrGFZHo+lpZrk6V8q7Pr0GQ?=
 =?us-ascii?Q?t80nvSUB6MVNqQyFYwEULpL70YrIDYkCadEZSTFg0/r6kwYh5MCahLqdCxKc?=
 =?us-ascii?Q?2V4vsxu1ZLVHh5ct2mIaIPRw2gG98NuyhyT/FrBQekgTpt0Do/Hxjm+b/tvZ?=
 =?us-ascii?Q?GZgudg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842c9877-915d-4346-3112-08d9bb203b2b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 14:28:56.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ibrh9oAYu8cMsHDi7Xo1mXJNTKBVCQ8WKyK6prz2++Pkd4FjyyylnuMSlIawJiSwf1O7AvBA0+TIX/g5Whbg+XLfD8TQBjhNLyA/JR+26VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=988 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090078
X-Proofpoint-GUID: Oe1PJ5ZjX78fZkN2AD7AeiW4we2MzscA
X-Proofpoint-ORIG-GUID: Oe1PJ5ZjX78fZkN2AD7AeiW4we2MzscA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:25:15PM +0800, Jianglei Nie wrote:
> Line 5968 (#1) allocates a memory chunk for input by kmalloc().
> Line 5973 (#2), line 5989 (#4) and line 5994 (#5) free the input
> before the function returns while line 5986 (#3) forget to free it,
> which will lead to a memory leak. This bug influences all stable
> versions from 5.15.1 to 5.15.7.
> 

This code was all deleted in September.  Please work against
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git#staging-next
or linux-next.

regards,
dan carpenter

