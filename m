Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8C4A4D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355095AbiAaR43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:56:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29766 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240641AbiAaR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:56:27 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VFx58m010602;
        Mon, 31 Jan 2022 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=iKg4aVr3KGg6kbIgIC/ogT2CeRRwdHRvqxA2vWA1JJQ=;
 b=d6WX/sbjmKGOEfodi5RgursaH4fLzQeuTft/DHgnN7flqW2vM0WFT4yqdnOTH/Eqwgdz
 vhJw2aNMeXlTpJ/HUcfQQwc//khC8bJ4NY+ZugSUXtMX70c2eKYlIB4LXhBp0HuUJ2sM
 mJLzb3Hv8wPPauKRdpQnNQ/lRmNxcfk6lzx9e3dVgZMNobYcF1JYybmzPjSHdpbSM4q/
 eyZEyLtEZG8jRonUgamDNQVX18tMVTkUBoeXFYwwE2GbnGiEL8Xs8fTZqXAUjHadmIzM
 IR7n8niTpDK9m3TrPWRqPQc/FWGjalEXBU3yT7r5n/JQr5VuvEVqoui8xNJYuJAeE1L8 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatrjrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:56:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VHoE3Z009289;
        Mon, 31 Jan 2022 17:56:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 3dvy1n74pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFJjH7mbt0PyjMm4bdXSUx/Wm351bch84lGDjGsQZGs0/FzHN9okK07GBn/DRlP8HJTjkWndSpQJ60IkScOdsWvrvKfvwlw6TeFQmtzDbm29jTyPXIqLv0a55+WeHrDm2f/ic4qhUcbB09BNxm06cswoWLa5TWMFX2Fr/XVZleRc04rQNZG5cpYpDFCsKdIdATHmTb4/FktIdga0JBbQWRvzqqJEmtjLNzikuj48zKOn90brX+zJ9nD5ob1YURi0ZNs6K/2w79ygm8bMD9ZWpIqh1Q1zqSiQqiwItAaBYU27gofY8EBpSM//Cb1OyxeaC482i+vLArg+7L9ZlYQ/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKg4aVr3KGg6kbIgIC/ogT2CeRRwdHRvqxA2vWA1JJQ=;
 b=E4eTubyC0tkqM/cGWFwo5ynVXbxy/Ui6yiFoAnmC7IVwfoOkqfOYYUkqVbGEqdtWNcCe6tOnFZEm7aNq2JbPNX6LWD0d5RR0ov7KKmbsY5wF/qq06fqFsaoGco+fc7TKRwr9NKnvRUFxLPtgiagFHod6TaSyok9Tbr/C2MDGJFGvDi0d210/l+B/gQhSg53MhRmsEJDugbAu4ZtSp+vKoDSbNV+fz/1z/pq9Kqf0JSql71n/KgdDu7rz9XXTdpR4t6sDiKrUtYnk3lwi8ULdGLvWAaSlTvfTV+dFlJ0Hs8Z1bTS7TnPbgOqYekI7YzhMaPvVbPUAVAN8ncAPeTzyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKg4aVr3KGg6kbIgIC/ogT2CeRRwdHRvqxA2vWA1JJQ=;
 b=LFqVAm37ca9MigfvpeRANq8jMQ+IrOPcsVF92jn8Ml+JCc79WHaz+HVvklRX1jzyfFGVFqVmbeKkoDQpNxBxBUPc79vJoL8wx6N86Or2yzgE+XwY2ny7ZJwyNmHWw+KleKmmv/WIPIC0I9F5H9vONvIMFmLo5VZmW1knalcoFhQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5323.namprd10.prod.outlook.com
 (2603:10b6:610:c6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 17:56:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 17:56:09 +0000
Date:   Mon, 31 Jan 2022 20:55:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: visconti: Remove dead code
Message-ID: <20220131175546.GO1951@kadam>
References: <20220128163527.1587325-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128163527.1587325-1-usama.anjum@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15738a2c-38ef-4145-8b9c-08d9e4e2f605
X-MS-TrafficTypeDiagnostic: CH0PR10MB5323:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5323795941DB237B8E9F4C2A8E259@CH0PR10MB5323.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1hTSUugPYeCw6IxrEBvgt3X3Zwn9htae26DpJ2MVZj8aCY4X15Z47hOqn31o7m25pCAtMRM1Ak7Xvya1Qp4Lv2S2it6Wv0C/6MzEpzuYeBlboo9Q62L10Xj6Y1KTseJ+1VhQnyM7Va9ZkaF1WoF8bAgbR8U74vLICWUcmhW5DhJAb5AwBhODovi4/5pdqjfuyBqI6uO2/Hgt/tr6UaCHfaiiEWVzC39CGvfS6OdXtbm8K/4V8h8B163Hegai0kbTD4PDh68qrv9oXqxWLVUDozPq+YBsJlFdTgWlUF68E+EYNkttGKtanKX9buTN9FxXQq6k2yC+YiNjzHy71oNbNLQwd2wfkArTtf50CLCFsnrMOV5W/0TYxyby6uSfc9GPM+d5hf7jNPOaYXooes8PTCMt7p9ciCYEDDvV3nm6ali+plPtrUPpttYOYIFNiE9HDZd8Z9X0r+137vgdgBFG9jhTto9a+ycMvOmf84TMnbbkDbRO9LqUV3VN6CQtMNkwqzK1uPio58m/B+MFz4WfeNp9K/iL6N3Aq3S8zey5mcjRmGES1v28P2RgyR0HZSzKDOf+fTX9MLvZkZejnV63dDgd7r3e1pKvO6Rz0SGsss8/eB0P13bt2Gp1/s6fdnK5jijwEo3Ou99yu40d98m0X8x5MbGzKrM+wauvoLxj0VCUN2O3M5HwDatxA33ySCaS6DaNR2b7xuPBa9kEt/0XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(6916009)(66946007)(2906002)(66556008)(54906003)(4326008)(8676002)(8936002)(33656002)(5660300002)(508600001)(38100700002)(6666004)(26005)(1076003)(186003)(38350700002)(6486002)(33716001)(316002)(83380400001)(44832011)(9686003)(86362001)(52116002)(6506007)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwsdFT0mLMSlXMS1vw88BpqVfiwSzeXjYm1BvjxiZZ5Sjf9LFzn1vuz/tsSZ?=
 =?us-ascii?Q?S7DfM4da6dwqPfghhtIwkFPLMWNqJ7h3aYBQaZCJnAJWBzkFleUsOHPCBHYP?=
 =?us-ascii?Q?8Jz6I8/cbjW+ZaLgyvYAUXmz4+fxn9fYmqnj4HIXGFUOcKpIP/IzDDI59JYK?=
 =?us-ascii?Q?W4HGfq7cRNNuuCx72xnX3s8aZduNBz0TyqKqSfjoB5TxEbfvCLCLPfkGBtxI?=
 =?us-ascii?Q?v/sjkV6G48VGgrr8z0wYj/E+U3XHjUGezxffUlKcrc6CofmUtyBxhllSk6HD?=
 =?us-ascii?Q?XgShXMuRw+taarm3BYA+tTFhodYYk9//fZPh8s717OxfNXI0O3EXvPDVVUoT?=
 =?us-ascii?Q?IfCXdJgDckFpRuVAr7J/yH2ignPCDAZ3lpCCfDIbehW7XwpZGekTZ39UW5Y+?=
 =?us-ascii?Q?jdZq7iu8jp0pd+qEKULza7Y+Zw7G/NhLCYJzwTLcVeg+EX/SuMOV2Swxsnt8?=
 =?us-ascii?Q?hcA7qZSsFj2hoW35BDuMZqWr5CkmB0l+YQgRe3kgXi5dRyPYaRBzCbVkKYlt?=
 =?us-ascii?Q?c/ymi6b3gWSM2hF4nUNSrqgaHEHmGg0TeUQrzZVJXWktxHbNL1cRcTTZxUe3?=
 =?us-ascii?Q?vIql6EuNCUjlYCpUzakeSzGKckTWFzl0n/S6u17YW745Q1YvgwTk6/6lE0r0?=
 =?us-ascii?Q?sTxhCuWo49stKTKF2zasQlT4naSlBdzRD8H2IqDQ82dGAHTNQjFLuEOyhY/I?=
 =?us-ascii?Q?ytp9DOTmrlgCBF+P0gOD+OlHXuc3B5MfC1IaPFEg8Pk0NPWb6kGrz6pfdxPQ?=
 =?us-ascii?Q?77mxG0PAQSdgd1QEarB7O0MmxuaM7BpTPV2DmQV1nCxvEEtxVhNe2GngYnzd?=
 =?us-ascii?Q?FT/SrlKccNqIO4BzJeRMm1agvA+QZ3LwLcfUB7Aokj6kJqZ+O335ndxSiZwg?=
 =?us-ascii?Q?tKKSv6L1lzSqUEYaa/MDt5GZI2ZYKSaRTSzW3T1kobkRzV/8XMRkaAg0I9W4?=
 =?us-ascii?Q?rSfRj0yjQOOg8f1szJPgrv74BHy5lVbbj3QG8IgKy8dzgC3LpjfVbdfgDqYe?=
 =?us-ascii?Q?8oAMzZjZkt4GdGBjHdwAba4oqp9eByic6SatPdLdTmKvlO77vfQ5MssuXKOo?=
 =?us-ascii?Q?Lo/edaMNqDZuylGoH4h+CJ4xA7ov0eCpixIrQ4ihgsilcQCeqPI0wFXtOjjC?=
 =?us-ascii?Q?300XEfTWkiWQ02SpRoT945iVlumLFrjNM4IrFd4CIqaJgGCi9tQm6BAlFYz8?=
 =?us-ascii?Q?AAwfJU8FyoI7O1X6yjPqlgd2Y50yWoF1mVuURe6tIZnJ+YA6g9gTo3JLWJVa?=
 =?us-ascii?Q?Iu86Cu2NSth8Wql4L3N5lfVQz3Jr61Mfz5jpvfM165AIEwlyS8r87jBd8cj8?=
 =?us-ascii?Q?bFSIOMPju+/ZgLwGlteqnUyS6xt6ssErQtDCaVH48WQKYVmWF2PeMp1G9LBL?=
 =?us-ascii?Q?rjYKjD+K5O5DRQXKT+t5nPrVXPqPVJpvzvTYY2HxSK9Vk2nDPMxMCQnBSZEI?=
 =?us-ascii?Q?2ZteJ7dTamNMtm0DH5UFtcTYRpMVuAPNfToTZ+gYt3IgSkIEPpTzspTKzbgm?=
 =?us-ascii?Q?mrQ/MQND09XCdbKo+QkDlH/X/k4uA1u/G2Yktlku+rlWkVUPp+H/PwbnKcqP?=
 =?us-ascii?Q?ZLc4y7gMewqY8bF7QRJAniitZhnGKdYFy3gY2KsZnjXBKGiQ0DDNWhvP6gAy?=
 =?us-ascii?Q?w+DA1BbkCYFZDDEjTkwoM2UQZ1LQjJqMgDT451gFIn8G6bEPyJ0kALsXvSug?=
 =?us-ascii?Q?6d0h6MI9ur+hFSMAdS8RZIM4PXM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15738a2c-38ef-4145-8b9c-08d9e4e2f605
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:56:09.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Rv1mVX/q02nXKHuIIgHTYGx/GgFM/uaSPQvCVq6EuU5yQZF9Nr6rGgFAKsSUddGC4eGb5kbGq+GXldK3iWWDB9xWvqHVfOfhh+19Ee2BQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5323
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310116
X-Proofpoint-GUID: Q4ANAYJBJg4tWM6jwcGr0iWm8FVKRdPs
X-Proofpoint-ORIG-GUID: Q4ANAYJBJg4tWM6jwcGr0iWm8FVKRdPs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 09:35:27PM +0500, Muhammad Usama Anjum wrote:
> rs_id is of unsigned type, u8. The condition rs_id >= 0 will always be
> true. Remove the if-else condition and the dead code.
> 

No, this isn't the right fix.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/clk/visconti/clkc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/visconti/clkc.c b/drivers/clk/visconti/clkc.c
> index 56a8a4ffebca8..5ccf771d05985 100644
> --- a/drivers/clk/visconti/clkc.c
> +++ b/drivers/clk/visconti/clkc.c
> @@ -147,13 +147,9 @@ int visconti_clk_register_gates(struct visconti_clk_provider *ctx,
>  		if (!dev_name)
>  			return -ENOMEM;
>  
> -		if (clks[i].rs_id >= 0) {
> -			rson_offset = reset[clks[i].rs_id].rson_offset;
> -			rsoff_offset = reset[clks[i].rs_id].rsoff_offset;
> -			rs_idx = reset[clks[i].rs_id].rs_idx;
> -		} else {
> -			rson_offset = rsoff_offset = rs_idx = -1;
> -		}
> +		rson_offset = reset[clks[i].rs_id].rson_offset;
> +		rsoff_offset = reset[clks[i].rs_id].rsoff_offset;
> +		rs_idx = reset[clks[i].rs_id].rs_idx;

With Smatch you can type:

$ smdb.py where visconti_clk_gate_table rs_id
drivers/clk/visconti/clkc-tmpv770x.c | (null)                         | (struct visconti_clk_gate_table)->rs_id | 0-31,255

That tells you it is assigned 255 as a global in drivers/clk/visconti/clkc-tmpv770x.c
It takes some digging to find that assignment...

drivers/clk/visconti/clkc-tmpv770x.c
   175                /* PISYSTEM */
   176                { TMPV770X_CLK_WRCK, "wrck",
   177                        clks_parent_data, ARRAY_SIZE(clks_parent_data),
   178                        0, 0x68, 0x168, 9, 32,
   179                        -1, }, /* No reset */
                              ^^
Really, that -1 there should generate a static checker warning but it
doesn't on Smatch...  :/

But the probably the correct fix is to make rs_id and related variables
and int instead of a u8.  I saw this bug but just reported it instead of
fixing it.

regards,
dan carpenter

