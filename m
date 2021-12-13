Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545A4472D17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhLMNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:21:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13634 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhLMNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:21:37 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BD9ktCg011714;
        Mon, 13 Dec 2021 13:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qSjg8Sj6HRBcb7X2UlWC66OaC1iK9uMKdsjk8ZqUWFw=;
 b=NNOu3y+UVoJfdRl0t8AhmgXxQpLw2A3DZbDQoU3v1pxMI2r/aJe7gu0HSewo3ybzVsOx
 xy1ZBD0K9eCJT/EX1NQxH9IYj23be8Y0lwzY5n3sYzE0V35pEMwrDBONt6cae5CPML31
 8Se8U/b8q2m5MfkQQNt0MUpgOi84y+sdvkmotUKe56IY9Sl1s/WkjFxbh8x1yrY6tWiW
 +Hzqk4r9V5AhRR5Nlnif97Xvhvdjs/78FEf1Gw+18PzJr2hKXvLx/BCK9vtdCj+a7dto
 ZPgFFx6Eo+FXlaAnTPMY2noClcx3n6PAqj9LtDGpvzxvoHIxysZLfS6L9otjNO2BRKIW dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3uk8esp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 13:21:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDDFmdj160433;
        Mon, 13 Dec 2021 13:21:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3cvj1c931s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 13:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FouL84EiekqNqC+bcjoKQ5ub4JHgoOQbtaorKpVnMDEPru6Pan0Y3eGnoilT/x/28M0XE11tbneXgwVy1dPB40ZgnjSBxaSUebqaCesC3C5WBa9uVTOKRi8vv2CGX69TLyk7ftiskSF+9PSPvGPVWQO1p07mAiWW2LMJYusOZll78CKny4RO0BXa6+lZJOKmXkw+n0VRkXHqHuroMujkUofb5ljfNHwOyGn14NVKdv6+6gwXmmTbw7iGpdUC21d0WueUiSqnB06nisTR+YRwr3RmHV7o+tY/lhYUVsTgFFukfuqwiS7UpRpC67dqnTsEye0aqpn49US6viUJ4fnSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSjg8Sj6HRBcb7X2UlWC66OaC1iK9uMKdsjk8ZqUWFw=;
 b=Uhtf5DI5UcF1e2R3P1VgHj/J3K5koOEyNYJbfDPb+JKO0RcS5Y0hX3VMec2ItxtcvDk8kNEeyNzaNuVSbAoV7SDizxxCkBEgt1vDUX9xmzlx3hBoChm27/Ocok8Fq4oJGEOfzQr23Kqu8Z/ekM2k7+NtveCRuZ8MNlO2BRpOle7AlDb1Lf+duYYKSWW8FCYR26IZOZ2xMlKZWi8TKcSt/WjuY8KdZ6rQUNmfrEcPZnoTSqcUSCAKybp7MQ6g9FSY3I+Z/im4hlItHDgRYpTz1lRcY8vIkKMN+cSDO2KHfGKXH6E7VhOYYxBqSuUFqVe1wpd7w8wn9IoHNhM3XHje9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSjg8Sj6HRBcb7X2UlWC66OaC1iK9uMKdsjk8ZqUWFw=;
 b=VjhNFvrfQ1YXcZptq0XoOTQmBwXlOBKBUNolV2rnBn5oszz1PYVNbk/I0KoKbs9Dfipr8f8c/K6dPCKTtvssp+sPTAIjPulXPv2YH2oOMA2Wghl7B9ySLm9ol+p5ivgbDjhpNxJ5uhNdpFxiPhGKosfa9QXOYp4FEk2gASUB7TM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5789.namprd10.prod.outlook.com
 (2603:10b6:303:140::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 13:21:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.026; Mon, 13 Dec 2021
 13:21:15 +0000
Date:   Mon, 13 Dec 2021 16:20:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, 282827961@qq.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
Message-ID: <20211213132053.GW1978@kadam>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213061244.13732-1-changlianzhi@uniontech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 13:21:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117b1e92-666a-40a7-7471-08d9be3b706b
X-MS-TrafficTypeDiagnostic: CO6PR10MB5789:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5789286D15B3BFBF291F7B0A8E749@CO6PR10MB5789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIRxxhgFo8RttJPicupHOlGQwnADfPGKmYkRq4esauhYgw4EIUMn1+YKiI4DMXQaqWnRR6I9kQxpoObEspYawpzzylnl5SI9UPn5GmOmRo6LwBexgMvY0NY5TdEBTwPeTUIdfgPpIXxQ0K6QqHoXFhJyAvylQv48u7TeWPiYalLef84uH/wCBo51AW58HM+jGi8v/yewPmBgQWPRnbhIJuS5JVgerBBXN/Sw3nrKzbPaCsAaNimy42Kcvhrl8w49ddfW2XJttERRGQiNRcBgCx5VHwqxEHjXNS2wS9Zn/Cy6s1muVb/+gkVj1HKhAdSqt4rpjE1xJLu+HIKiB8NTDhv1x51DcA01p0NBmkF24jfhwwN8bibIQownAVLO5fNTQ78OjBvFBLvrnG1BPQiBWBbvXEY8BVuKMZHR5H/0FfzMu3XF2L2htAcvEHG5tt2CJc4rgnmZdD/40M7/cmbrBBGWTa/17dbpzyuG+wWy9m/K0EEQrclrb7PEAyt7gNp8iKAEzpMg2CNrj/1EM4GXkJ5y5WZzMnejLk42v4McP0zbWCZUCHjJMLhmPJ4D/UvqqCiMX6BOCFVp3+96UWKuGNkn6WOMo8XrlK+aRGo3e+/2R9uqRs8j8B32/wvhUx5u4GDSpf/zDxW7R4fCSkQ0XTgFXSeav5C03AZ62uqyr+XfOj5jxdl6SkoQPAV/e407frFDiw+BNR4lXklVlDY90g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(44832011)(5660300002)(8676002)(1076003)(38350700002)(38100700002)(9576002)(186003)(86362001)(26005)(66476007)(66556008)(316002)(55016003)(83380400001)(66946007)(4326008)(6916009)(52116002)(6666004)(6496006)(2906002)(9686003)(33656002)(508600001)(956004)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TS7hf2BnymdNTGtkakrCip/mDT/gAlY0xDpRrOWLLQ07IsdThmVRG9+vMx7q?=
 =?us-ascii?Q?G8RqE33A5sjVqokpUf54374872uANPsClxAqtJAx8zAPN+kCWrmdj6wm3ZDy?=
 =?us-ascii?Q?wwNynkGfdCMKUKR5bolFgOQ5I2Ysm1lxF6V+2u3qa46HYSNfRTGUNR7IpiBe?=
 =?us-ascii?Q?n0UHWDbwDXrFb+UpVAe8i3L+Kw+KfB+GkJVAJ73UnPQ209aSZKkmV6DUjn6y?=
 =?us-ascii?Q?zA0if95rel+3wAm2wl4kkeaecbZ7zt2cy5UBv63gGsY5fT4+wVUJO/0WTJsb?=
 =?us-ascii?Q?52Zly/ZhqdqiRdaNy5uE31qmamXk815W2XZXTp0byP9sqY585dFjDRe/cqIt?=
 =?us-ascii?Q?+CUbR0Rf5ye+sAXWdWiHSIAphI0tv713iaEofvp/06qBpStdm97eUrVn+DNn?=
 =?us-ascii?Q?QaajfJBfZINmt0U2vK1wldZ7UGQSasXyP9gwpHoAmfveO249kMKZ5TV49jb4?=
 =?us-ascii?Q?Dj2t9xtNo/2fIqcqfDpO7aZDiLP7F6iInbNOG/WMlj7bW2l5GcSMTHh1Omy9?=
 =?us-ascii?Q?+KXCeCD/hYnB8si1jOUWWGj1xKqoLI0nJYfeu82+vefmkDxWojkpRFtT2sNE?=
 =?us-ascii?Q?FvJV2iNOafhyEqHKUuXAobO6oqTl5Kbh2x34QRWWHj4l8TL/S+xkz6tuy9cd?=
 =?us-ascii?Q?g6tQRBXNGXDo+7RpkAkYetSYoLHaUDVTKiBEPzdoHIc2NZbZyj2nUh1qI6NS?=
 =?us-ascii?Q?JvvvjgvQt6v1Tvw971PJG8KGFYZvllldeYuq06lVXrZy0t4YB2KV2XXHNgOL?=
 =?us-ascii?Q?RzamnHhpVGFzI2ofWYOFdqvon5c/UcYZCkmNQAEPniepxvBvxa9L3nPH617C?=
 =?us-ascii?Q?nqGlNTh5vCB2SGJ2dEjq7Ts08Iqult3q2PW9AtuxTCjE26+1nkLC4k9EM4VI?=
 =?us-ascii?Q?f83FYred4WDIjeKH2oB5hA3zQv5voj35XRDW9pNT6k5+MJ4Rb1EALo0AD875?=
 =?us-ascii?Q?bHJBi9dnUZWgYcj7HycaNv6YfeAg6x9d26fw1/hWf8V01LdpajOKR8H9ToEx?=
 =?us-ascii?Q?lx+vMwPzhJz4woyJ0InSfcgHN1x3x3mpRoc5ZU/qI8ztAfnD54NeKaobFTGQ?=
 =?us-ascii?Q?oHKT0ZvlT/D+6NAB7nk+tlZBgqo7ohVJA2UduPJUR2tjckViLwzfVhZKFwe1?=
 =?us-ascii?Q?87Rrv31kicoU+SqhTyy5ETlwrts5HPDSvqXdlgT4lMcaBvjiC5Y0UbTlzxKr?=
 =?us-ascii?Q?LQIau/Z2ZEdIa+r7r/I8hJeGa9Xx3G65KqF+mlo2nJ5F6rIaJSY7hZdRAoSJ?=
 =?us-ascii?Q?03YYK5jJ6dKH7G1i0DZnnlrHgMcSFsd/DLRmX6g3lAOADuSpV1VwS+l/uuDW?=
 =?us-ascii?Q?KQXtKXhz9ea4dYOuzmXLEmoYa23rvbi/uNe6qSB345hEZNOuwMHRtGm78piK?=
 =?us-ascii?Q?pHDGbvDJtdnsBhvnGEAkLlBodp3RsFL+QgBASUhsji6AXBNycgqY4QHLZmrq?=
 =?us-ascii?Q?HWNTIq7zzJ9V7JQaXkt88vyLRzN9/2pn9VS83Qn/Kk8YHib32Pg6NY0lG41K?=
 =?us-ascii?Q?Oudr7IIF8X5W3TxCH1QuR39qzR3pn/pqvQvsLz7wVKcURvf33qrpLmVVpVr4?=
 =?us-ascii?Q?Hjt++PBYQycMHfe8JwclNoGhnvd5V215C0u+i6uXVnnjlq4vWMlQQy6d6zg0?=
 =?us-ascii?Q?bxNqkya3bRFeLEVunONhWJUerLK3d9Edpnw/ad1idN0OSY92vxPVf4+WYCCg?=
 =?us-ascii?Q?JR5Isw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117b1e92-666a-40a7-7471-08d9be3b706b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 13:21:15.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtEDX6gm2vrXYQjCIiu7Ti3toRPufoApf9n3bIsfWGmVywoiWvZ43GKbHUJC72EW/SzHtUvSEzkkFNU82/dgUmZr55RIKzJzhaI4Wba+1kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130085
X-Proofpoint-GUID: oMyStP4iBhivnM0qAUaA_4fEJdXqieWD
X-Proofpoint-ORIG-GUID: oMyStP4iBhivnM0qAUaA_4fEJdXqieWD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"the keyboard led light display problem" is pretty vague.  Perhaps say
"Fix incorrect "Num Lock" LED indicator"

On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:
> Use the "ctrl+alt+Fn" key combination to switch the system from tty to
> desktop or switch the system from desktop to tty. After the switch is
> completed, it is found that the state of the keyboard lock is

Is this one of those fancy gaming keyboards with LEDs under the keys or
are we talking about Num Lock?


> +int vt_do_kdgkbledctl(unsigned int console)
> +{
> +	struct kbd_struct *kb = &kbd_table[console];
> +	/* This is a spot read so needs no locking */
> +	switch (kb->kbdledctl) {
> +	case VC_LEDCTL_ON:
> +		return K_LEDCTL_ON;
> +	case VC_LEDCTL_OFF:
> +		return K_LEDCTL_OFF;
> +		}

Extra tab.

> +}
> +

> +#define VC_LEDCTL_ON  0	/* VT can set the keyboard light */
> +#define VC_LEDCTL_OFF 1	/* Prohibit VT to set the keyboard light */

> +#define K_LEDCTL_ON 0x00
> +#define K_LEDCTL_OFF 0x01

It's weird that ON is zero and OFF one.  Really, it's unfortunate that
we need a new ioctl to fix this bug...

regards,
dan carpenter

