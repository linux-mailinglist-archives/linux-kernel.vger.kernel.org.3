Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA74A488B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379099AbiAaNq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:46:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15226 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376324AbiAaNq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:46:27 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VDZ3iL007225;
        Mon, 31 Jan 2022 13:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xfbTfc9gT2D2lC+5sLBI9hmRk5f468WaU1HB3mIOsII=;
 b=MHKDBgIGIq2BEFEreN+OaA2UJjxGy9ywGwOgaXtHhLePM6oxldYOOHqvXNimOIRvAHFU
 Xj5UZy8e+AdAHMyufCqfZFQIgydgYRJOkHyoiNe8lFAKiyLY1okkdteUDhhX8xnrZ3WG
 2lYh8VGcNOqF1rQkaFq/7+wAwstCO8AEPUQyBtUPW/6xUCDkl8cDJkuERRe4SASOvlDe
 B+xaNRA0XoGtm4fnE06xxcbV0r8zpAccJYQAX2T8NZFTJa1S3n6xqXVrpBe//jckbNeO
 rFDTYExOKdZaYO6MKJUl6OPRHKw+gzMOoxR01BIoyS5lFMCQHcfY9HZrmtyYNi/zJ3G0 xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvx4uv34a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 13:46:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VDjb6N000817;
        Mon, 31 Jan 2022 13:46:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3dvumdhwd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 13:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulitw/QbjIuq4sGoCYC9F7dLETNJO0hYVh70uvYujhB8u3DiNJfT1+of6S5kwAGNUu8h3PW5WUVmQceE1ksai+7oiTS1g22Ruoagr32JXItQ1FIUQcL+vQl54T5EYb3xG7eQQJfCX75Dk84USDixtyH9AmnoVew87AvYfL6ic3fTijHKnPCv/ghkzJ/+kWnylQRmKtu8ZB9vg3V+F2Qwe1KX16YLxfSu7RWgx7XZYnT0zRIFo7S+KMqUoy71hRrzd4/eOIfZ63Hm8P3cZJjYpz0jalJwkBXwCV6Yma/ul+rsy/AMFIK4fGROh/mk2ljvhNyMM0p77ec7QhwlxRiJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfbTfc9gT2D2lC+5sLBI9hmRk5f468WaU1HB3mIOsII=;
 b=LcTIZ/7TAqqyKAbEMToFd26A+NYGLhy1F8Bnm+cIRN8t6qPrbq+4AEG3JZH9NrJbyGBuag8VJjgATc2VsyqC/QNFNSQi9QF4O5DQSov7r81Boumk7aw/Mjvb0cyWSEiI5ajyCRP8DXO95dagDICzEJiuJ56szDHzj1e2urngPuPyI6rpAH1O0pVOJXFmzenzTCHGR9TmTHz3FVKQ9U3eMcUjdtuiEBGdLkL5iAXRYNxoyr8InmCtbeZ6f+DeT93tzD/7sPOwYIwl0lisxxaCcQiJwwYKZHoUWSWktZEmI0Z8hQc25AVhxJDMOts7Vsbb+G/JEkwmHmwkQ+ac0uCiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfbTfc9gT2D2lC+5sLBI9hmRk5f468WaU1HB3mIOsII=;
 b=vh91PqqQMbsQe8/iGcU2pAaN/u3PMrEg2JIE8F0X7WF7jwAS5cYtbkPGhlYKRnG2l6pUREpR62igze69uX3vuU7GcE7u93MQzSYpKQ6ptJvpJ4IlK9cj6Vmav5qn/Qf8/mcXKNSygAUe0xCuurFs6uMZnTJIouEpjIXB9ADufMU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL0PR10MB3441.namprd10.prod.outlook.com
 (2603:10b6:208:7f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 13:46:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 13:46:18 +0000
Date:   Mon, 31 Jan 2022 16:45:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: pi433: add debugfs interface
Message-ID: <20220131134558.GL1951@kadam>
References: <20220126132116.GA1951@kadam>
 <YfX+llwDWZZMz+NY@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfX+llwDWZZMz+NY@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317a8576-fb57-42f0-7ec2-08d9e4c00ebb
X-MS-TrafficTypeDiagnostic: BL0PR10MB3441:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3441BCC46F2BEC69CCDFE61B8E259@BL0PR10MB3441.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcRYZyTHVJeFoGck0Ik+I6fW7f6iThH2GK9qFWV6oQFafI50wUaoeVpKBiI+D0xNIPT0gdj08MqFE0k9mjgPx/VFoy6HuFm8jN4DPm/4GcZ9CwLrNrUj9Cuaba2Rjro9GFSAycgIyfycmP+DpKyBC9s0K6NBHB0shlf6Ay9z7FKg2fRKeu56IMIcFVWwGsQJsfx0oc1XtJH9fO17u3ICoBT5YArYfx+Ye2GoiFhOlzrLVys7N8M3szS21FRTwuzlcdpTdFQPG8ZH0rIwnGmWn+NgRPqjoWgObN8o2ZGaOT8N7Sy12pCi1RGYIUGMZrsTR2SRdPRRhDOdFSJOyHEUPKfjw4ilgU/yxK0Tv74DKem1MhBe5ncqR59eY0b+eqtD5v4yKMqO5hK5Mfc7ibDLje+UxB9aNvweNjIZidCkJClzUY5monNNpQdn/JPMgKYUhDTXnob1Ijvd1bOToSuRFOUWwskASKAlftcd6QxIUBsa2IRZ4/ZYmaor/L29PmLhvBhuQxyEPRqrxVNZs3wRwxVwDlCTqJRzWlu/dr2HCusPavgr+gdEqAKH9Me6N9pcRWI6qi9BfEVbxsEdrEeGeEMDKL7QE+NNTlyoPBEMm5WCe4PNtXSy+mbUYT+AEXjjq+zv6CZCDvYGqIOA8/vf5QW0ZECKXDktvcqmtKO4b/bXa81lVpecAbiMKBBiA//S6WyRbnQhUOC13/NI15/5XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(8676002)(8936002)(508600001)(1076003)(66476007)(66556008)(2906002)(66946007)(6506007)(6666004)(33656002)(52116002)(6512007)(9686003)(83380400001)(26005)(186003)(86362001)(33716001)(38350700002)(38100700002)(44832011)(316002)(6916009)(5660300002)(4326008)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3RYUs3Amr824Cy8V78/YPiwjB+WFfgSS2xGxsfGw48ukERb53N6s2Qv0neMB?=
 =?us-ascii?Q?slZqnM3Npnl28ggJOq4l+eT0YM9i587VKy/QU7BLs4jbCpDP9SLntJTAjl1v?=
 =?us-ascii?Q?phMWxEXc6rDLb5WUrBbVWU2X/DayohWzOY8aa/fi5EHCE+S1odJHJepHHXT0?=
 =?us-ascii?Q?y20ktj77AqBmwXcfGGw+YsYU/KgFoBXaPD01yibdBRCzM6DdgvC4XWaIpSUa?=
 =?us-ascii?Q?DCcwDhFlq/1HB0bphUZN0hVp78e3mzZEovfjqoSPtiqd6+UT83i+Qnpm4Jqh?=
 =?us-ascii?Q?LUGDSoopsQNzFsTUGE8nQTPNn2rdYjT2uXHwXl+0O7QAls2MoaMkbLmRyg7Q?=
 =?us-ascii?Q?mKZiI73fYErrgBdvSM47AhDKZRMjG+xNzm0zlUk0wPs8qFlVzmkdEn4bYULg?=
 =?us-ascii?Q?SuJ/xdwCtdKdH1OzwJ6PDcm17r7PNeUT2kxx0e2le7pDHS/mAZ/JJlM3+QMx?=
 =?us-ascii?Q?nYyoaLNPmR86NRDYb5NBvFmRbrkWEaQ4N27L5nij/85JgeHyX4FyMYgSMkBG?=
 =?us-ascii?Q?xkxSU9I+YKnmFEoDhogkegAGV5CLFYZMLaQmgg0+CHLFVA+9CxIAA692tjSb?=
 =?us-ascii?Q?kkS5/CaxHypr1oUHwtNmJJXxXFqsdWlWCI0IWSivx2uuTkRzMhFxTjA70kDT?=
 =?us-ascii?Q?GUdKe2wwDeHbilNwSSsJ0cScwh3fDgRkC1+bJ3SXYi1zHPe4d/A/5xzYWkbe?=
 =?us-ascii?Q?cB7YuihDxN87hx5NO7oQ5F+6Gyn70Xv+rKv44TOWzKqRzwnT5l+yRKwbTvon?=
 =?us-ascii?Q?ged28Gr7tVBOM9H/LsC08n9GlZDYo0WB0q6xMCz2I5OHYE793tzVbCswue9o?=
 =?us-ascii?Q?JQOlmyMjq2RU0jXbla/7e/ndRTcBbtFGNA1Qiw1QtNPjIx1VgOKKvv3P2J8F?=
 =?us-ascii?Q?sa3WtPGakSTM8X8/Qsk50gFNaNGzWWvx1Iz/NIx1Aol5D/7LyIW9MhKNIqi1?=
 =?us-ascii?Q?g5OAw7M1+1kfi5edLYTg0Dj280dg8N5lWYhF1Zes7n8fqGtizvHl+J89uFEK?=
 =?us-ascii?Q?AeLae9JNvK0ASl5xmAiA8y/2LS1b/R60vgGfMzTXp9DvOYh9T05VM7TMSrxj?=
 =?us-ascii?Q?1SWg3L1KOxknwZEi/oJIoYOhI7LrZYDSb0QgPpcNnOgWST97ueWIhI1aMmtO?=
 =?us-ascii?Q?Z1lZNw0UovhOCTwpMhmDzjNAVqbgsyCYAai1ftCVSN88fZzI6q3yIlVu9wnU?=
 =?us-ascii?Q?izwGnuQvLioqaenR7wfZrOWzEDZ910241ZvADOk7KT+cLrVyW3yfwpeEozGf?=
 =?us-ascii?Q?H4mY9INNIRbIu+G5e7tXDm9Yi2FqdQTPQt4sZEWfSpdCR2x/jwf1PC+VNN5w?=
 =?us-ascii?Q?yMVKFasQlB6nmi+hM5EULc78WHVyIr5agUaZkTgtbbjTUw029NFOvTEfmyVy?=
 =?us-ascii?Q?omINAsVPN6kI6cNSqXWO3K3Zx0EInVI08aVEiC4UXG+1m44k0L+IeElhWGIZ?=
 =?us-ascii?Q?OXUZ/Yrs0JPRwYNq6MC+QrNQTAhgdStC/m7w7oaBLkCqbj0TOiPW77pC6uyT?=
 =?us-ascii?Q?fA4Z7M3pR2WwOpX1DbmS8yE/dxXdUbqtA3fRxNyoLVwBwMx52bRHG3BGhf3V?=
 =?us-ascii?Q?QRrgm3YBXy0yZMUq2ZzdPohHblbV1AkEnEHLvWQpbFm6pONnRI/ThyklYPVO?=
 =?us-ascii?Q?j+2E/eXR7PHvY2qLRgk18MHSYdBj80oxj6jtP6pBxQacQNQY4UX9ZRVkgA2P?=
 =?us-ascii?Q?pqGsqaIx9K4FnZ3VPltueUUbdEM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317a8576-fb57-42f0-7ec2-08d9e4c00ebb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 13:46:18.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOzZQoLxHnLJzCkciEErOE8PGl8pT+P9EuOL5C6kzmNVmpQAOsx6v0eChRN0eY4yyHdKTeRO8ieBz1UoU1okAxFRjt+DyljC+74T3BNOCq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3441
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310092
X-Proofpoint-ORIG-GUID: T_TLVqZNoky3m3s9r5mHOx8L21DNLI-6
X-Proofpoint-GUID: T_TLVqZNoky3m3s9r5mHOx8L21DNLI-6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 03:57:26PM +1300, Paulo Miguel Almeida wrote:
> @@ -1102,12 +1104,75 @@ static const struct file_operations pi433_fops = {
>  	.llseek =	no_llseek,
>  };
>  
> +static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
> +{
> +	struct pi433_device *dev;
> +	u8 reg_data[114];
> +	int i;
> +	char *fmt = "0x%02x, 0x%02x\n";
> +	int ret = 0;

No need to initialize.  Bogus initializers just disable ten thousand
person hours spent developing static analysis.

> +
> +	dev = m->private;
> +
> +	mutex_lock(&dev->tx_fifo_lock);
> +	mutex_lock(&dev->rx_lock);
> +
> +	// wait for on-going operations to finish
> +	ret = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
> +	if (ret)
> +		return ret;

Drop the two mutexes before returning.

> +
> +	ret = wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
> +	if (ret)
> +		return ret;

Drop the mutexes.

> +
> +	// skip FIFO register (0x0) otherwise this can affect some of uC ops
> +	for (i = 1; i < 0x50; i++)
> +		reg_data[i] = rf69_read_reg(dev->spi, i);
> +
> +	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
> +	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
> +	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
> +	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
> +	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
> +
> +	seq_puts(m, "# reg, val\n");
> +
> +	for (i = 1; i < 0x50; i++)
> +		seq_printf(m, fmt, i, reg_data[i]);
> +
> +	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
> +	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
> +	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
> +	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
> +	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
> +
> +	mutex_unlock(&dev->rx_lock);
> +	mutex_unlock(&dev->tx_fifo_lock);
> +
> +	return ret;
> +}

regards,
dan carpenter
