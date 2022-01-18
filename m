Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81634927DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbiARN7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:59:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13818 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244894AbiARN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:59:34 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ICmPWm002682;
        Tue, 18 Jan 2022 13:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WERJ8B4OiUHAnE7MPlKdkSHlDL0W4uHYqUMMCoeFdhs=;
 b=omQGjS9efqNfRX7onDBIKc6velbLqunbFxWYPMXLqEHcy6QZUxDWDI3h1kD180JLx2HX
 sWrrb5/PHh6Os2HPxMPVv/Bzd8RU+QmZPIpDjs+TeC/FFBlksdQhPTZEV6tYK8rL6IC1
 vZeWafFosOLIIvlof/vKYDFWRjrOdNKLvyBwsVegyGNT4537+vCxfKSsBJZNkCfTieES
 RQOZvgyzfSRWC9uWEW1JorTXG7Qpk71YEfqlENBRiHSiK2FEfaqIcs+RnIV1VOysgklD
 sKGyLAFTeH43zCLhod6KS+9unWAOXnPXSPCH3R2AncO8WofyUDWfGZts71lxIhayd7VJ /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vhy74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 13:59:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IDorRn141953;
        Tue, 18 Jan 2022 13:59:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3030.oracle.com with ESMTP id 3dkmac0hhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 13:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yup1xi/Mz3p2ZtwXDgtRMJG9EHAx/UjKbDS7ZKFByDdN6V3+HEfZUCo8Tj0XLg7yzpsyVe/90ahH8MVtUiYAAvr19pzwZhldF95VXh9lWlm7ZiZw/1aYeN+Y/bYaCIIrtAEDsCqMzKaWgYqkoCGnsrPYLf19UI5/hf7KumQhnfz/BuK//W8cn6bzMZTfyXolfpYbC+JzV6PhV2fnH+iNOR5/HlGxqgoRYpCuybYhpjV2cmky9t6qHJj+jeFR6EO2Bn7MJoRIZylBHb0Eza4gK7v/NfMGxstZ7SxY1sXi05tU/G+xfd877ZZX0NK9nB8jK9Ar+q6k9Cw9ikU1Hpu+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WERJ8B4OiUHAnE7MPlKdkSHlDL0W4uHYqUMMCoeFdhs=;
 b=KrpMHuOHVJxfvZTY/JBDvbprcFx/ZKzJJVV0qaM9epe5e+cBVLN5wmPPVikRlU2NpVMih80GLCpjRJ/BlOTWwAZdLSLlGGg5uNJGyuO67dDfyV21a48tZ05XQcl1EaSmjWhQjGdaEYjcv2a0CeydoGJkR30dyWWI+VQzAcp0WFKbl9oDW4JGm97G2sYV8C1jgAKdL1kvJ18qBArRnCMPIFZf1hhh4xZYOwl+hC6SyoQr3fbzhU6xBNUZhjXjXefmYjxmUeBwbVGeIashZf2r2dixTuI7Cw7RI0AkoweMYHQNNYtVlw+8+2oHA8gU2KQxppgIrAjCnBI8zTwKOlwj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WERJ8B4OiUHAnE7MPlKdkSHlDL0W4uHYqUMMCoeFdhs=;
 b=Bvhgs2fQ+Dc4UspyDKl0QxfytOVktyqRv6MWAHu5Mt02OjojHNKbLlZXUYxyccSG7698+O+nUubhotCPlz0Mop8qgJIOmeML0zk8hKgVD5VRL9hxUlpwmuSuZ9/qIg7mA+qmas8zTy+bUrd+8ZSAokuf8Htc7PHpY8QS0mB+aCw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3031.namprd10.prod.outlook.com
 (2603:10b6:a03:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 13:59:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 13:59:22 +0000
Date:   Tue, 18 Jan 2022 16:59:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: pi433: validate max bit_rate based on
 modulation used
Message-ID: <20220118135902.GH1951@kadam>
References: <20220117055849.GA10644@mail.google.com>
 <20220117060220.GA11202@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117060220.GA11202@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaf713be-4d6f-4c64-42d8-08d9da8aba52
X-MS-TrafficTypeDiagnostic: BYAPR10MB3031:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3031636420C6174D48F1612B8E589@BYAPR10MB3031.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYieaB0RqfEpmxZVktIduuPMo/b0/Jt1h378l8cBeSaWCgFQR2xB/CqD3/XfMolpFha9+pSxhM9yjJ3wE+3Lz/IKucsAlNzezpYmbNmed8iD9b/hR60lG7XGv+9HsVZldtWrJeVq5ZH7J+AkYlB1cOyJQkbqTm1lrDtb8PSUfpMS789OD4jNkAFalZ0F6bGkxhKFR7ynq++fbuSIeYMYbw76pSp/GQfLp4sdNYhIQXYRgyo5Yv1loD150AIfcKG9cuOHefcxtDUPyydNGne6TLXWdw5wOtdBYdWAr7G/yO45bkPnsMUGoMU6N/jliLviIy8n40pxGlfXRnWkcejwoPFVjsxAWSYVT5QuLm/+1PvRI51Iv0AysUUs3RdkzLYD7pApuQwDY+XanltcSXWWDtqpCTRqdkLTYLjBdl/fg1pz/ydeLps89ZM9ZQo8iN8v1wIRA5uzsDfj6BV2/26jV29CifRQpCgnRQbDa3oZ8IqUs8GRgWJuU+QRFee5oRUedQ23yMa5TisfxaaOhN8QZbiTAPxMrdu8fULugFsR/6yioQD7SZZJ8PPSAXQwUs6BidkXFhncjTfnYYjLaJ5Y1oFrZALddCJc4i/P/1jKLODntfz8lACdq2MKbUB40yh/kzF99Iv+piSybAMwq65HHwC2GllLAaT66cG7ue3NR1Lvu1/LM7eJCKABhFcIFueL5bkdZI8UFS7FK7KLeR+3sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(66946007)(186003)(6506007)(86362001)(33656002)(66476007)(66556008)(6916009)(8936002)(52116002)(26005)(8676002)(44832011)(6666004)(9686003)(15650500001)(316002)(6486002)(6512007)(508600001)(38100700002)(38350700002)(4326008)(2906002)(33716001)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmcG7GUe9VkemxoTpC82Ly1n6ez2Qq6smDw+kXwNWbWdsIYoXscHyPBLCrta?=
 =?us-ascii?Q?KIE0cU/eXyL8P9zaNbmJOqlAWGTb+JmZ2M1FNDuTyM4UNRcba3DPV8VX6isD?=
 =?us-ascii?Q?/JehUxQdEAxRnGew8m0fy94TfpOyFnaJLplTiYTKvRxXyFlWLN6q7bzXpGPU?=
 =?us-ascii?Q?8wU/MgrV7koFRQ3K8tHX5OAMaPVflD6vFXyfEdl6soCPrmfJaQGuIpQUz80R?=
 =?us-ascii?Q?slKROtaqgnN/ATTRPaEDgMxYxSMFDSptySrSCzK5+HtM6CrPkJAuZ/TF49eU?=
 =?us-ascii?Q?CBxSYcf0S+4xS0wJsBE5r2ZqLIH6n/DKZdNAhTPkrOSG6/BG5h8B299FuIsr?=
 =?us-ascii?Q?z7lVg1x3PvhfO6A9XLh4TpzM9c0FacXJ+2Ufj+s5YZ3vQx5IBmfeW4ihycYd?=
 =?us-ascii?Q?NGfGfimnwTsrzSv/JKQJ2GFesjk4qQfcL0ey9ZbMWpToDl5cHrPrUHDQ7ucf?=
 =?us-ascii?Q?bgqSvYr1tuZStlN69opdq/RCeGMxpTOpcck2OCm9vxaON5fHX/7ARm2DnwKy?=
 =?us-ascii?Q?F/UaHxol0SCN6jO+3fMxacge7iSlhLnFJV0QHXovZHdyo34pGfwjJRoXz/Wi?=
 =?us-ascii?Q?seCuF3Vi+Tw0+E0Zv621HaF7BElkSmHkU9PzQJahl7RlYU47V/NzHbAtlU7H?=
 =?us-ascii?Q?4zvlxvJZAnrV/In370reT7/ZTylWWKOjImLOM9NqfuBmLRWCbciNHgAa/UWD?=
 =?us-ascii?Q?OgADQY1z3MpJqYWWmTlccWPlhUu/WBEynUw/5fv/Z2NS/ItpQgQOVrMwZueD?=
 =?us-ascii?Q?1NQN3cY9Xg/pLhrWmAsbKu9aOMoBcBBnQGxM0Uu0mh81/dSn19W6QA1YtdNr?=
 =?us-ascii?Q?Jnz71e6I5URDLisUDQ1Vzmqn2DL9Khv/tmxwfxVlet2abYwpmr2oJBf8Ojvq?=
 =?us-ascii?Q?pjcKAmt4JsbhYy/F7YnQ/lCBRU43dQcrzUbAd2FNzYRfR1Q3+wzt8K5+dC34?=
 =?us-ascii?Q?EPm30DrsUZf5WHLl2DGMpRnhROrgLgHtI9h75PXpQ14CYwFXPOq2c75t9X4n?=
 =?us-ascii?Q?tMmaEAnNl9qq7+yrIJTAZn1UAZA3dcrW9StrkFDhyLGo1XwNtl9mXvka3OlY?=
 =?us-ascii?Q?dQiK5LthkkTKtmJNtKnqqsC+2qZODwjeMvQW0T4OeKgGd1BueNPm24rXg6DA?=
 =?us-ascii?Q?mpiQKyE4GZmkCT9BI/XNBHZSBTimMzr1ijS9NMLfA7qVGWnGCZ9vLI5BIcLm?=
 =?us-ascii?Q?2NKp31fR317A0griOU7qFlghQpUvFnyVO+p4zASTV3vU5e034FyjpNkyPo3U?=
 =?us-ascii?Q?xyslNb+sqUm6DqIVrHw7jwodoyEkLwiGtC0HuDGBoI2ML4xQlr/7vn3wVRuw?=
 =?us-ascii?Q?SQjTUyLs2CnW4e3oOtp8nju9r4eHOfBvWimvIsIqXkUQSNEX9AzdYTt2NE17?=
 =?us-ascii?Q?Oo/xgyY5xYv/QIF12EdWC4JnZm4MuGn3d3aTa7zLCJGVlltotNUqUqCWZUak?=
 =?us-ascii?Q?u4QwxMvJnMxklTO79D1IZsBO8v6N7bFlSywpEvWOeD2Yqwfn2vDBkZbX57G6?=
 =?us-ascii?Q?T6+TWgqz+SISiATs4Vzt6GJ9VkbmoKSy0tddCG6FxAMaxoGrtUQBqqPHdTNO?=
 =?us-ascii?Q?bwDHieV4hYeKcvR9r9PTB30gdTevvIwnJACMYZvB4kcXGFaxDR8BJH5gkuS4?=
 =?us-ascii?Q?rnnToJF9RFepTJwuI73WVOe86bDAX03mPmhrM0+fp/VovN1ZMTYIlQg4dn1Y?=
 =?us-ascii?Q?upZQ9A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf713be-4d6f-4c64-42d8-08d9da8aba52
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 13:59:22.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7qsFiw4ewicGwY3r66YLtlOqW7Zvrfz7KALk5Y/a4Pe2EsASSZ5g3BmFAexFiGtkjjWLBqgpy54zv1jshh/SDYexW9sVyH1TBVFLA+lAeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3031
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180085
X-Proofpoint-GUID: ibSffdhzt41EL2GTrwEGSB0AqicPs0e8
X-Proofpoint-ORIG-GUID: ibSffdhzt41EL2GTrwEGSB0AqicPs0e8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:02:20PM +1300, Paulo Miguel Almeida wrote:
> Max bit rate is dependent on which modulation is used. Previous
> validation routine only took into consideration min bit rate which can
> lead a misconfiguration of the rf69 chip causing the packets not to be
> sent/read.
> 
> This patch enhances that input check in set_bit_rate to account for
> modulation values and their respective max bit rate
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Meta-comments:
> 
> In the patchset v1 I kept bit_rate argument's original type as I thought that
> changing it to accomodate values as high as 300kbps couldn't be part of this
> patchset and therefore it should be a separate patchset. 
> 
> Given that kernel test bot compilation/test process 'complained' about the 
> argument's type, I decided to send the v2 patch that addresses the data type
> problem while I work on the patch that will change bit_rate type across
> tx_cfg and rx_cfg as this will require a bit more work.
> 
> Please let me know if anyone dislikes the approach and wants me to deal with it
> in a different way.

I always think that correct static checker warnings should be preserved
instead of papered over and silenced.  Someone went to a lot of work to
create that warning and then we're disabling it for being correct?  It
doesn't make sense.

At the same time, this is a GCC warning so it will break the build.

Instead of applying this patch, I wish you would just make a note of it
in the drivers/staging/pi433/TODO file.  

    "Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can
     support bit rates up to 300kbps per the spec."

But you're right that it's complicated to fix this because it's part of
the UAPI.  I think that the UAPI for pi433 is kind of garbage.  No one
like custom ioctls.  It would be better to use sysfs.  Each pi433_tx_cfg
struct member would become it's own file obviously.  We could pick sane
default values where ever possible instead of leaving it all up to the
user.

So my idea is that instead of modifying the custom ioctl then we can
just add a new sysfs file to set the bit_rate and all the other stuff.
Eventually we will delete the ioctl after all the users have updated to
the new userspace.

(I say this with the complete confidence of someone who has never used
pi433 and is not really sure what it is).

regards,
dan carpenter

