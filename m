Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D9A49DF11
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiA0KUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:20:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19270 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239050AbiA0KUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:20:17 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R6TVnF012687;
        Thu, 27 Jan 2022 10:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=C9GQLN6rzysLHslU+D4M9Bl213r9WnLtObB7BSF3Q30=;
 b=b9JRz0MAEXPHlHKrexGMKfWZOP3kFohuA7uWVCj+TDgUv302ZwWOnyskReQQhHP080AD
 eXYQaU/PBzJQW2p23ImwZcfcuUV/d+t0GQVNn5J6x9GG/TuwxQgf6WUyShOlJtgFrp/K
 klcIjTDYNE9ZaY6nPrWnrv8ZkBkkw/z2J0/LFV8f0pb4oK+4YU1Y8gkV+v75LG6UKO6m
 /ZDO0IMDRDFq0Umfq9RFlKWEJV1fTWNyCIktp6xZeAzrWKbB3faj6FoZHhSPxzRg5ZYk
 RN6YchFNIKkBFEItCTis0Cq2QhfYJ3h1+lYDTSwOwg3xQDkjCtb33ns+33kzwaAveWdr UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjhbtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 10:20:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RAAWol032306;
        Thu, 27 Jan 2022 10:20:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3drbct1x53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 10:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeqjfsM56zJm1qRd92e3nqYUn4zPSPrSbqgRDRu6y6075S3FLPL1GOZOHP0NdS5QJcCLwaj6elCveEYogDJ5SxziuSYu6hmsAeWNFNWy2yH665jT2v/MEpDc6HvRzJ5rEDcDJt/RMkyZGIH1TosigAGI5dj/dJ9VcNlUDVOXgXeGjwBi6I6LSI1qgtOKCdylXA+2bXrgqo1W6fGWJaRofdVZe8FNQ3rgFWWklMTw0ikEmxU+DWf7v5pUuPzDnFrXpwMNCYkx/4YmxUbbtVuezwYCp5Cfe6qVUCrUod7kC8gGAg6Fhxblh/3GO3Ewi4xtsJ5PKG3NqsxUU7EaqiIuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9GQLN6rzysLHslU+D4M9Bl213r9WnLtObB7BSF3Q30=;
 b=aFKVcAIt1fQLoZWYQUammxL1Z6DjN9eyFPqZsv9/fxgwWEMUeMrDPrLDWJ83WPP/uukNxcpHL8g+x75SMtnrWjYgpCfZKpjAaHB7KrqNCr1OeCioEI0/qqkbtljGp7JW8Y27Q+laXCvOeUJC6UxI3jBh5x1MSHoVpjZfKAWLmB/q2puJASow87TRJbdXf93TKIdwjPYj7JRuEe1uEeA0tJproD6a1Kj86IkupUIdD9fWw1SJmWvyfZrREFyKkhBMEJnn7q29LnDl+65nip90EKfnRzL79lkQg+0OKveOf5aauBVYb+uWqgMdOmic7wuvyE4AGG3phU15C5UnTIpDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9GQLN6rzysLHslU+D4M9Bl213r9WnLtObB7BSF3Q30=;
 b=myOSTvOnBzXWRreEQbQ0cdlWnKksLUYyMQWZS1EYwFW7RdTll9J1fUx+w6BHVDZ5xP4vjEMmi7nzrS0XmDPvFtz5/xNoQ+T7a7hT0ECsUt6lWe1aBgci5x4Mv/V3B54bRm5kQiMbJN9yqMmmgCz/Fd98Vvw0zPxYgkF9ix7ewWA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1291.namprd10.prod.outlook.com
 (2603:10b6:3:a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Thu, 27 Jan
 2022 10:19:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Thu, 27 Jan 2022
 10:19:59 +0000
Date:   Thu, 27 Jan 2022 13:19:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: cadence: Sierra: Add support for skipping
 configuration
Message-ID: <20220127101938.GD1978@kadam>
References: <20220127085700.10333-1-a-govindraju@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085700.10333-1-a-govindraju@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55416574-7e49-4eb4-d0fe-08d9e17e9267
X-MS-TrafficTypeDiagnostic: DM5PR10MB1291:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB129110663799C6429A7300318E219@DM5PR10MB1291.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DibS82dSTKuhhQtcR/cCteWit56KNANcUyK/Tik9bmPJE0S1ngNi612Vo3CrWiCtr2dRcwI8aWfO8iPYzSWzHnJ7rSoRRwH18Icg0mkwCfvtrcqNUZkisXTZg4nikCHRSMRbJOY/cU/Zl0sqc8CPRiUmw3O6ZF5YGhISTi4zxAQ8XEzwh43Vf+afbpqcDjCQjUrbLm+ZBwRmi5M57Su8Q5MFKkChQaA7Uw/96mbKunKqiNUM2RYqIcAicCzSe/H45vh03oF4yUs1ONo1mBpcxQDID3oDjpgUK0XaV8nkQok2/r4hXwmB73CyTeOqM1lehSSB1bcxHXYbU7Jp2Ls1QT5qSsmbJMfxQJBQAukxQM64yZjyauAH6WqdSjDN16maK50Swycur/vIyhMid7MmW/0NDB0Ald2sBNsinCANKojFE3szEfqKBtSvfn2mli6USG+2OVXYZi2JoAVsKqh9Vl09oQM8Pp9M2X9VlYFqKfpMlUOmjiVDI8DCTJxQi6Louh/3EDSZSI9EwTxNauMxQM+4tQ/aOb27Bh72iaLccO1EmqpPi0mkuGb43D4Yx7IiqWDdeSMC+8t8V6BICqQhHH6d1qT4LUGpR9VEGsfHnsTxQtENGZ1yczkTxu2NeWINI9Mj8/DLpcycE7pHn6x9BYb4+cH3+mfZUw6aEGg9ElLEQ+4uAGu4EZuiPy/Iy7ogKiwNniRGmzc/jykhsZGrhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(508600001)(33716001)(54906003)(9686003)(4326008)(6512007)(2906002)(33656002)(6486002)(44832011)(5660300002)(26005)(52116002)(316002)(1076003)(38100700002)(66556008)(66476007)(6506007)(66946007)(186003)(38350700002)(6666004)(86362001)(6916009)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdGnc0PCsNfGYcgp4cbSUK/f0IneZPIjNhiimmAQUHE4hwiGN05th4jb8aou?=
 =?us-ascii?Q?TnF1Fw7oRhF9/0X3mwqknPxg8dWPwHLMZw57MsuZkwF87EYUtS+wuxNyV6yO?=
 =?us-ascii?Q?X5jf7KY1Ogo3beFQoSHu2Sv5HkxgXi/2lZ1HK1ziYT1wzhSZuDBoWRvwY8j0?=
 =?us-ascii?Q?RavUgnGcexF7dbMAJi604yvU08MZwsXFfRv5dSAlYZK3XH73KpBPqCmWkg31?=
 =?us-ascii?Q?OAV1rXzYNvkitDGMdMZR0CjTPeLHRYRlRKB0iuxOBqaaKgP94wQUkpskfFut?=
 =?us-ascii?Q?DjvoIYmUtWWRNW0cxtGLqZ+HijSW04tCMpWIOT+ZrxDd8n8SEuQPh8EbKAsB?=
 =?us-ascii?Q?bFQikFWQI10sJo6R+a+EKscXuNJzFGQ0ObRhegkoTfRzLBtCNCcf2ualiZIn?=
 =?us-ascii?Q?EQG3Mh1uNwhB0ykgSipMzf4xPxoFvaZnCRBlNaLfe8tS8VUsj3wCblPbjpWV?=
 =?us-ascii?Q?x0N1yUzmPAppM2GW0GGbWndyGytLcM8vFpTnxPtJ/p5zjsmHn0lrXFZXvZwD?=
 =?us-ascii?Q?+EZphDJR3zelpxb3ypTppFAdLS7RlYKqDjaP2iupqZoi6FLHp6LbUhHh6INA?=
 =?us-ascii?Q?iMjirNB6mEcltjxaDd+ySyqGuzRArxQg/3wSjLqP8S3YaOIAJRCOfFkIHjJx?=
 =?us-ascii?Q?bsVNjlIme2brxqnBTSEoG0rIUMx8GFR+AmWvTJZFrpalh8zV6y6U8KbC1BKm?=
 =?us-ascii?Q?TUl2EXgz9Qjq4jEUdiA97lsk/kxCNH1kMJqcY2QI0kwTZdY0GpaEr9n5Imen?=
 =?us-ascii?Q?B6ZjBC48US5e8zVqUv2nhnANOQRg7hQLAzzqZA0L1iMQthnNzo9KW00TFNYW?=
 =?us-ascii?Q?0K6XSJIvzYB+yQgqi9fAnKexM99shSm7DXiiUXq42U5Ts5c7xHSSH97iJhVn?=
 =?us-ascii?Q?Bkbd+tJyBo8u7cL2IOk3L+hSi4MqXyuOBYF6gUa6JZNSKsnaYlQGN9UkDNdr?=
 =?us-ascii?Q?rsKH2VlrZ09T4WsfZDzGBfDg3Fztupk0hEO7fgQgCMYJOx91XUgD6l56nsL5?=
 =?us-ascii?Q?r/FY5aZD78V/uRlJheE9yujpTPNjq6Lpkxck9+C+PQ8ga6XfBDUpOxjrebMF?=
 =?us-ascii?Q?oK7aIGu4goKzP9IntihF6VIlhJ+hlkfp0bi7QfLcmwS8o/GSDTstZiZO1NFb?=
 =?us-ascii?Q?n4T+6y35AsJddhaLoIPkWXhobKu9lWGbpVEpWIgidwNqZiZw0qCbrcOAdNZr?=
 =?us-ascii?Q?to6FJsSiSmMR0g12stN3Lv7AOexVj+nSg0FXe0Dbb/Y7h/cmyySx/mqcoJsO?=
 =?us-ascii?Q?m0l6wM2D15THvbnL5Z0jK6Lklb63DJvzfT69n9kqKE8VzXDBrneEV4PSL2eX?=
 =?us-ascii?Q?WWifjBLvZ85o5Warc/DEPJc3T3zAFvKuF+xeowp1TVIesxa/uIVj7WEHj4G7?=
 =?us-ascii?Q?e2e+hsJwBfZ3krvRmh+qCQc7TmtJvuK7xqKDCpZjTf4nG3vHWejEP16mOvUe?=
 =?us-ascii?Q?ez+2C6d5s7AA9ISBrMxMcs2pSzbBmELY0WFOwYE0U5Bk2Nw2URfBvLXnxFHQ?=
 =?us-ascii?Q?OjsHyTyGhi4XD0XmjcWMHasvXZhd+BGLsVtrdUekfBGWV3WLYg4OFcC6S1rb?=
 =?us-ascii?Q?AgK8qSMeM0VMmH5vBumgOndLTugl/a1sWZtoi2fr3OVbpxoSuu4zTS+ZM4vE?=
 =?us-ascii?Q?zWCI8KiOmULT7tHvnuxgwiLR9qXc9PoBrcCXmzU28w8+dl0QLRE1Hle6kPPI?=
 =?us-ascii?Q?RdnAr1Zv04AI0UIlsi6wQ0lNOzA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55416574-7e49-4eb4-d0fe-08d9e17e9267
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 10:19:59.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: By+EMcrUnv5if4kb1cy8k+7lg59b98Y7OIhE+YedtIpRQIgcLh8oAO+FU3vAaPIruR8smNt5JNx1BJMMZ3ueCcNY++Kg71iqKWe2J75I0bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1291
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270062
X-Proofpoint-GUID: LShIPuwEFkraGavvLVKb42JW9SEeDaNg
X-Proofpoint-ORIG-GUID: LShIPuwEFkraGavvLVKb42JW9SEeDaNg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:26:58PM +0530, Aswath Govindraju wrote:
> Skip the phy configuration if the required configurations were done in an
> earlier boot stage.
> 

Why are you doing this?  Could you please put in the commit message if
the user will see an improvement from this change.

> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---

[ snip ]

> @@ -1382,16 +1401,24 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = cdns_sierra_phy_get_resets(sp, dev);
> -	if (ret)
> -		goto unregister_clk;
> -
>  	ret = cdns_sierra_phy_enable_clocks(sp);
>  	if (ret)
>  		goto unregister_clk;
>  
> -	/* Enable APB */
> -	reset_control_deassert(sp->apb_rst);
> +	regmap_field_read(sp->pma_cmn_ready, &sp->already_configured);
> +
> +	if (!(sp->already_configured)) {

Delete extra parens.

> +		ret = cdns_sierra_phy_clk(sp);
> +		if (ret)
> +			goto unregister_clk;

The goto should release the most recent successful allocation which is
cdns_sierra_phy_enable_clocks().  So this should be goto clk_disable.
Except that will also call reset_control_assert() which is wrong...  The
rules are generally that error handling should be in the reverse order
from how we allocated it.  If allocation is optional the cleanup should
be optional.  The allocation and unwind code should mirror each other.

> +
> +		ret = cdns_sierra_phy_get_resets(sp, dev);
> +		if (ret)
> +			goto unregister_clk;

goto clk_disable;

> +
> +		/* Enable APB */
> +		reset_control_deassert(sp->apb_rst);

Since this is now optional it should be optional in the cleanup.

> +	}
>  

Since the order of allocations has changed, the other gotos need to be
updated to free the most recent allocation as well.  Then the error
handling looks like this:

	return 0;

put_control:
	while (--node >= 0)
		reset_control_put(sp->phys[node].lnk_rst);
ctrl_assert:
	if (!sp->already_configured)
		reset_control_assert(sp->apb_rst);
clk_disable:
	cdns_sierra_phy_disable_clocks(sp);
unregister_clk:
	cdns_sierra_clk_unregister(sp);
	return ret;


>  	/* Check that PHY is present */
>  	regmap_field_read(sp->macro_id_type, &id_value);
> @@ -1433,8 +1460,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  
>  		sp->num_lanes += sp->phys[node].num_lanes;
>  
> -		gphy = devm_phy_create(dev, child, &ops);
> -
> +		if (!(sp->already_configured))

Delete parens.

> +			gphy = devm_phy_create(dev, child, &ops);
> +		else
> +			gphy = devm_phy_create(dev, child, &noop_ops);
>  		if (IS_ERR(gphy)) {
>  			ret = PTR_ERR(gphy);
>  			of_node_put(child);
> @@ -1455,7 +1484,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  	}
>  
>  	/* If more than one subnode, configure the PHY as multilink */
> -	if (!sp->autoconf && sp->nsubnodes > 1) {
> +	if (!(sp->already_configured && sp->autoconf) && sp->nsubnodes > 1) {

It's normally easier to understand conditions when you push the ! as
far in as possible:

	if ((!sp->already_configured || !sp->autoconf) &&
	    sp->nsubnodes > 1) {

Is this condition right?  Shouldn't it be:

	if (!sp->already_configured && !sp->autoconf && sp->nsubnodes > 1) {

The ->already_configured is set/stored in firmware so I don't know when
that happens.  Please, add that information to the commit message when
you resend.

regards,
dan carpenter

