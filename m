Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BDE467A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352696AbhLCPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:18:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51778 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhLCPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:18:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3Ej8h1019878;
        Fri, 3 Dec 2021 15:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=gBm8CSuY1RBF4kHAYp0acvKeH2FzmNqHSA3Pp4gXpKg=;
 b=sQ1JGC3hlbIkApV5QLZV6ob8/3a1j1qhMLyjQ3fmcPplPH+0ZaM+AI8M/2oOVM6sFfA5
 7rFdBOv3YV9/xSCU72wtt3YCy3NBqZKB/w2RlTqW5frO2ebFMTfSUFn/GbMs/NABAef6
 p8A+F6BT7k6BG41DukdiByzDsEv2rRrl87BjcXqN3ZkTru9EbLHt1s1Ljq7OfpWYPk1j
 SpD5OMvSg4CqB7ySFJWWJSLAguw36WiWfuP+N8CmMGsjUwXWi+UBNjNRTXv5oU+XJzpX
 iczgcKxfOzHJxdXkNekPbS//oaX9+PCffeGazChlO5aVy5caYYviiHKS6jfDdbsCUgYA 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqn99g4y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:15:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3FBrol181414;
        Fri, 3 Dec 2021 15:15:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 3cnhvjk0rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLMDf0kAL3xsfJWQggFnLmCI1QPIc6Ooy/aWRBbkMppLcFebiiz7zmbcrrdrFz9Iug6tLKeWm2O9eU16zC51E0pOCvSDtlUrOOiOlF039rZ5nWxON0E4iw7vSMOilAlLz2neCQ8kuzS9GhyCGe2oO377s4COF77C0hoIpFMCk072z5ME9vXJOdPMSTYIoOVKkNttpq64O9TzcBLM/80mEP88zTt1i8hTlUhAyrE7UxOiYp+NU9XKZXtUQNCYm2eB5Mrf+P9k3fy9IYIsrxKzySG4CLAOpIyfSy/gZCXuIMQRlZazFjo3kL1R8eDEZf0CM/NisJl1cfw6+144ART2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBm8CSuY1RBF4kHAYp0acvKeH2FzmNqHSA3Pp4gXpKg=;
 b=ZaXgFmXEjWbkl4KqgzKRUbg6o3Mka4vMvuDnL/HF/vq/yTCxWw9Nx4400cr8tCxKLt+fDYEdkZJ07V0KWyndCkIpJVf6QoqY98BqzER+N1NPyJVUICGJAT0XAz44qY4EBpF0HX09W7hCY09W8cvxg4/B3JQ6cx/LqaL+rmHSDbc47DNa+W2EjSrhSyk1U5HC5jvJtYS8XIXxCxwN41VYHMRN+F56MpfJcxAziyONVVSPV8L1W19FtdyYe/YWW877o7aJGHhsa1hd9+1CEWHO4U9ZhpB+fbvfmQrY97atgZP04QZSfQMORG0RPTJC3onEZXtbkSiFFSQV6e/PJ3XWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBm8CSuY1RBF4kHAYp0acvKeH2FzmNqHSA3Pp4gXpKg=;
 b=aZNr/Sclofz8VurS0DPq/l1i/elDthUWIdwYlcRkLsTBM0Lxw9vsvZeYQnw+0mWJYjnIcyk5mi068w2R5YRIDA48yPk2BYcFcd2OeqpLldAl4RH7h97HepAVZiJBlW0sZt9OXxLi/VXPxV/5s6Zb3Jyda4Wma/UloV8MtXq+Vcg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1486.namprd10.prod.outlook.com
 (2603:10b6:300:24::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 15:15:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 15:15:04 +0000
Date:   Fri, 3 Dec 2021 18:14:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kbuild@lists.01.org,
        Stephane Grosjean <s.grosjean@peak-system.com>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/can/usb/peak_usb/pcan_usb.c:523
 pcan_usb_decode_error() error: we previously assumed 'cf' could be null (see
 line 503)
Message-ID: <20211203151444.GK18178@kadam>
References: <202112021833.wABxM5UN-lkp@intel.com>
 <20211203145851.nrgmnu7c56w4vecy@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203145851.nrgmnu7c56w4vecy@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 15:14:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a01302ed-2b29-4d7b-ff36-08d9b66faead
X-MS-TrafficTypeDiagnostic: MWHPR10MB1486:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1486ED436C6A8755539E42618E6A9@MWHPR10MB1486.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBDFWPGr+4IgB1gAtVme2DnM28fbNGeR7rP7++M91V3SUixCCRCmA4cQm6j2sSmJI/8+zZ0iSaNqCZANp9UaIqOF+lIIB1qLRrUTv0hxhB5ph2XfKEdA+Y7YvTkhYTx6dpViOUz0rpcqX6iKiZkL9gN8B5D3fV77RWfYcKqNMt64JA9GO/d+AS5RUSEwoaxVccsKyFBigEw4Edy1tkYGwFcKlCKlmngFzkUMJXJiiCkh+WqLXzLMdlicZxmb43yGKxqjAXszdSFWo+MJb6/OAksm7Rn4jLaQUDWm11jTFNQ0AQJ4YY0aFbLgbtTmJBK+z+k317G69RQtVOS6pfimvAqBQZ2N3Q7y1aHBxSkoitzq+6Iy6Xrgo6Aj6jHnssSGyym743CtxAuAwGDOVS80UaEfvYgd+bELGt48nl16zJjXkxb4CUiMkZOG1HFG0YFnj+93jobpeQcGZ4TVOoyICVA3vaSn8t5OwXXagq93m8aiixHFY2J04xpmLg87POj3qxiDMYq8C7ksbRq7e/H6uRMKchTvnudlQ0frjuoniPU1ADnSfLTsNH0mX9RhhAPPCZT1Hg0mUUGryZMtt3/dkrIcWsSotP0XiahagfykXvGApvJcavyl6CoXw25PbXgFwR4ZxAz1s6mGpqc/efA5+D1MRVNynKKlndp49SNsVTJZPUIWK+ZewhmKzJQWNzQHR8hUYmDWUXeYrW3OJyxQ2w231sJDqBo/ca8/lfFMFN87DosbzUGgC3iC6OjBUv9JyerWsHbbk2q9YNUx9QOzUlIZ8A2EkQ7m58ibyhL4rvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(508600001)(6666004)(44832011)(5660300002)(8936002)(316002)(66946007)(33656002)(66476007)(9576002)(66556008)(4326008)(38100700002)(38350700002)(86362001)(186003)(26005)(956004)(966005)(55016003)(33716001)(6916009)(2906002)(1076003)(52116002)(9686003)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLZIMBiuS8VtN1DH24q1TpzQ2JjjkQ8iaZuzmOl82z7d2eFPZRYv8wt7OKKH?=
 =?us-ascii?Q?rgOscxHwLc/1xTpu4NoSZB8xPYvpT3WgsFw2fsjiVfTpJZ5jVZDLSZCOh6xn?=
 =?us-ascii?Q?r1jx9H+wxoInS7WVDZGcIAFmaUXnVsSRxD1432Bw4dxLyqRZUZZJxML/qPFE?=
 =?us-ascii?Q?RV1s7Bzye0U+2sfUe+y18Le94RK6r3pOPBxWyr193lN0rAPLsjYXDoInPrVh?=
 =?us-ascii?Q?LBAysr15kxXm4oDjb5v4iK6yHB3spEfrLjmkmqHNOYI00VVSri9/uQRvP389?=
 =?us-ascii?Q?U+u13ETs4S+NSMCWByFjaecGckcfWzkG7IMCp2AzsZS8r8ZoARgsvNeFadFo?=
 =?us-ascii?Q?azOmpmACuUBlJO9JVx7sX/lGk00Mj37L340X7EmEBHJGMnzxb1wa8p0cjeA8?=
 =?us-ascii?Q?fvyjiW/iHqgLLEwcxzsypKRDPio3tpOQecALxD8rrRGf/0JSCEUaHh7U3B/P?=
 =?us-ascii?Q?uDLien2Tabkzjw0+UUQHQAroKrjV0jhXcPUCA/0Ks/gKtzevHmNpFXzk/ppe?=
 =?us-ascii?Q?Rgs5wvFswGgDF0elXU7v3ErcBw6fuzfKDlcBpbWmrmRkIe44m8S2BdzBm5YB?=
 =?us-ascii?Q?oqI85yCHkMbGWpwgnczFO7iMWAz/6u00R7WJMJeQRX3L31zlMFwyClmSrNER?=
 =?us-ascii?Q?u/CN097KR1R2YWZOc8p62CQF+ZEHtKy6v1pa+J8dQAvDl3mSemcHcB/ZUvmF?=
 =?us-ascii?Q?Lgjba9hYuUg6ZClGoQcMsjpYl93Mxfk9s4ya/O1RtLTXkNHJ4K29YbIzlGsa?=
 =?us-ascii?Q?4lHmQ5ASCUApxv7qZTt/vlYcBgMkULeVMQdXhgaZY87OzpQ34OQI47m7lh66?=
 =?us-ascii?Q?xVWvlnzzCrbmJzhguuUePMVUNE3ndMf+znmisLa0RsBBWG3JdXG0fcedAP1P?=
 =?us-ascii?Q?mJ0DHSTK/H0U3ivAnVB7KMA1QOpNVsEaaP3QzbJHnLHuVlhxP46HaWq0qXNV?=
 =?us-ascii?Q?fiNQv8V8QcsLZszRj66/EomGJLFAF8vwOBuypMH7NuLvSysTprj2TSqXHhni?=
 =?us-ascii?Q?QfLn9E821BWfHfrdS+CPxA74Htb8/7AsX8bQVbwHLLsJ3yeqQ3Y8D5Ja5U69?=
 =?us-ascii?Q?OTXkjXVpEswaoKa/0WilNJlfAdL3ufowxJEcgCFP/yeGH22+8cBO52cI/njE?=
 =?us-ascii?Q?BAPzJ4M6+iCV54uZjlMj1wNSuJ0CXhRXOVFhlLpzacqDYxOjPm5aFummxcF3?=
 =?us-ascii?Q?I9l8ODVuqHlwPMOV4k+fkkwXVvOuVLvsWCkGl+035i/Q5OyT/KwnNjjQc44G?=
 =?us-ascii?Q?XYQoS4fXCRpJp9RrMIIFPkExNVGFTn4lyiirdLI7vtbm5YDVTs1nUJEWkTbv?=
 =?us-ascii?Q?US/fPj0Jln5E9EA1CfPYOlFLUuCcmH4I4CoW3q9B14oarxS89cjppPe/1Rgr?=
 =?us-ascii?Q?ABudX7uK+AKhugzq958VnG6CC4rTjMljSSFudWB2I4I+GVMOO0/MUtjEhLur?=
 =?us-ascii?Q?HFZo63/of9AfrsL4LvQ4k+bxc3Y/LoppIndiSGtKerUvBhX/WQDzVjBusVLk?=
 =?us-ascii?Q?HFZnj7ukjX21ORCCAtRrljCSIMI28jfEQg9MjVpBeMr5YrDjS5iX6+IXpaXD?=
 =?us-ascii?Q?NXeY+O6Z+wOUwDFa3gGp1XAIw/mK4ICQi9wQ00RA/cjBjti3qd3ZfULSUZEO?=
 =?us-ascii?Q?OAMZnfmgM853Bl7U7+VDOYy4idCOvYa0CJE/KhEcCJ/aZ85TnkWomw+kB0K0?=
 =?us-ascii?Q?1+kFiGx7yOLs/D9nvboX79UAK5s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01302ed-2b29-4d7b-ff36-08d9b66faead
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 15:15:03.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDyTR2tI+Jrb45SF+H6eSMbAh9V/3tBGdwLMCQFfAHqUP/uULOoTgCqb6gkIwtsLuXCwF22pHYNEifb24dss5S7pwJx2UznxMO+ojMZ7QNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1486
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=967 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030096
X-Proofpoint-ORIG-GUID: ifRFpePmkUmM2b9FDpWoLWB7igoRz76o
X-Proofpoint-GUID: ifRFpePmkUmM2b9FDpWoLWB7igoRz76o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 03:58:51PM +0100, Marc Kleine-Budde wrote:
> > 
> > 46be265d338833 Stephane Grosjean 2012-03-02  450  static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
> > 46be265d338833 Stephane Grosjean 2012-03-02  451  				 u8 status_len)
> > 46be265d338833 Stephane Grosjean 2012-03-02  452  {
> > 46be265d338833 Stephane Grosjean 2012-03-02  453  	struct sk_buff *skb;
> > 46be265d338833 Stephane Grosjean 2012-03-02  454  	struct can_frame *cf;
> > c11dcee7583027 Stephane Grosjean 2021-07-15  455  	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
> > 46be265d338833 Stephane Grosjean 2012-03-02  456  
> > 46be265d338833 Stephane Grosjean 2012-03-02  457  	/* ignore this error until 1st ts received */
> > 46be265d338833 Stephane Grosjean 2012-03-02  458  	if (n == PCAN_USB_ERROR_QOVR)
> > 46be265d338833 Stephane Grosjean 2012-03-02  459  		if (!mc->pdev->time_ref.tick_count)
> > 46be265d338833 Stephane Grosjean 2012-03-02  460  			return 0;
> > 46be265d338833 Stephane Grosjean 2012-03-02  461  
> > c11dcee7583027 Stephane Grosjean 2021-07-15  462  	/* allocate an skb to store the error frame */
> > c11dcee7583027 Stephane Grosjean 2021-07-15  463  	skb = alloc_can_err_skb(mc->netdev, &cf);
> 
> alloc_can_err_skb() ->
> alloc_canfd_skb()
> 
> https://elixir.bootlin.com/linux/v5.15/source/drivers/net/can/dev/skb.c#L210
> 
> If skb is NULL, cf is set to NULL, too.

Yeah.  Sorry about that.  The kbuild-bot doesn't do much cross function
analysis (none for functions that are not inline).  I saw that this
patch was old and could easily have checked it on my system which has
the cross function DB but I was in a rush.  :/  My bad.  Will try be a
more diligent person next time.

regards,
dan carpenter

