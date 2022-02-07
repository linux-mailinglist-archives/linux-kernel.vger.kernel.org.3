Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9234AB85B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352713AbiBGKJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiBGKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:06:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B22C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:06:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2178Mf32007422;
        Mon, 7 Feb 2022 10:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5l5rVJzacY9HaY4BzARSC6weDJpBigMqMa84bbVmqGE=;
 b=sZQzIfnnzafNIh/ZGvTpVlYjyVc0XWnY+fu661dbeovOOtXD/hJ3dnbwfmqCdxsi/v1g
 olga9xrFnBWVlPhAEGcAULLczD4gj1h2VRQi4XzE3yMJ61gLtmVjnzUCkvKfncoFshF0
 7Nf2q9YqW9dzClo+NtKegZqf0fPjDZdoVJjwf9NqmT3fNeumXXIzywyXZqKI5/SCFu1L
 u34CBF3im23QM7Haph/Fu+7tZGMT9XifjO4aESH1hNtvak7OoFqGzboN+6inRe2Uya6h
 dAsOX2X6+Y/DEUEeyATEmfzqdW8iO/qhF9gg09Ta+nTZ5G5+6nGJo9Er4x/Gg+EGIj42 zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1guswkeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 10:06:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217A5Nig009054;
        Mon, 7 Feb 2022 10:06:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 3e1jpn7y1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 10:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCvhOfzyHELS0OzYb8nrTqzaazCmTWhsax3KzZC6rHSdXzwKFSMr3BMFXkninT4uUhlX6U9GmEgfpIOS2vssblXt5FkpACoqkVhvOlogcuvw6UKgTa5sK7P420YG/WHSPi6aMNEZk2lq3jmTK7NrjoxQzjFwvnwb0ug+K5GWL7Xt88bDfo6z8yILBf1or3tA4nWvI6Fb7IXlF8IrYtS4bfotYVKr7DqZemlqeO1o3Gjcd0cLMctNSOV/bssbCtpRArseiZUeYiZBCoT1oQDT9mxGJhRI9R55TU71Hp7mJY6D72dPsOZcXPC4UuAmnVFaEJrvX2c99+qJB8VlXE4DIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l5rVJzacY9HaY4BzARSC6weDJpBigMqMa84bbVmqGE=;
 b=JeRt6YzRL4vGj8mOkwacsogaoGRFlFHUFirMeifJIOcUNR8YZ30TNujz1XydThQszFAZIBmIeMvCW4fORTdzFQMABHnrPvuCpOf5sR7fXig2tqB5Q3+nzI7EKPvfq/1AleAffz+NTYLa6Qeyzz4Vc2D/xegeLNRfrZbDh9gMK367vSmE1M1mrrdov1P0h11Jgl4eCEVck5X+UnDDkYIsJ1IghNNAAKcN/2KuGRp9IJjocEalh7xNrFXUNQvsz3JrWMeSXhwu0FqEMFEUd8MDQur/fUcbB17Z4+RZdHpMYbCuzniZZT7L+iX9nQCQO+ni+wphtT+ARopYR79Xude83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l5rVJzacY9HaY4BzARSC6weDJpBigMqMa84bbVmqGE=;
 b=P0HVNDLzOezNEhujn8NDqPQ53BhyQTWMy5h8BjeK1cGl+/ESvn+We4i008c3DqBYkhwEJCQ2NsAfpavCe5O9twzc7V3yNPkWxN7uOz8+jq9Ufk86fqJ2wkTkGxsABRkmf5bNhReh6JAQcwd+2ALkNaUAazKQ2PWFSteL/4UeHsc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4317.namprd10.prod.outlook.com
 (2603:10b6:208:199::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Mon, 7 Feb
 2022 10:06:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 10:06:18 +0000
Date:   Mon, 7 Feb 2022 13:06:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: remove need to recompile code to debug
 fifo content
Message-ID: <20220207100601.GF1951@kadam>
References: <YgCj2P59AbFFmnbA@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgCj2P59AbFFmnbA@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 015d375c-0d09-4ab1-4aec-08d9ea217bd1
X-MS-TrafficTypeDiagnostic: MN2PR10MB4317:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4317FF051FCD877DD56D73FD8E2C9@MN2PR10MB4317.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FC3fiExb0HeDPeLVrnTq/IGbYDofi9IKNL26vvRtdJOgNmTDAibGBNM9gq/7BXPYEWDattAB6H6ASWba3hdSrpcOTSv8Gd/OOhe1+4mXI/wPNHsUn9q7k6yi3GvN1YTix9Ix2phmVanMkfSEI/UGUxCxJPjxMTT22gLql0XMtB6qEnLp65Zz65648qA06tqpbNA4SZ8LS6qsXq/nUJCqzU56GDJQm414h25QtOjF5JR0i/0sirOS+rllDgqke0Tkz1tKUqU6Wi7PrdBdN7oGqvODhL9iAxRFC2Y+1KisQQXB/sI6NogvUBG/C5dBzEKH+HwTQznevHMLFyqnTpMBtMRaW7uWf+0P47UVu1OnIwbJDacrmxLOjuWA/VOQhu0c021339eQTjTqkjMc81uBWVjz+pIKADgrJSDy3toOS1Uuju2kZFwe4+0k61DI74wbIU7CcWHxqhXYG8l/pMBRF8ByPN3kkJXC7E5n0ybif1psXXlHBt0khnRAZN5Se9ChuxQM9p8Tr+vyo8N5NoFD7Px0boWeIIVcqrBxKtQhaXxhbh3G4moOhSSzWoGbzgFeHQ8HeQz8RNrBtasDglcRwvD5hJYz82FXlakjWlKgppviUFyIJNKje/l8XcCJK/lys0gxwlsZFa9BXQYmAf/rRnbCzi6L2g9KlZl4sUuvKbpbR2+XWVv344+Bzq7EQLxpeTgHp8ZjbUx+rLBN3gGQVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(26005)(186003)(83380400001)(9686003)(6506007)(6666004)(6512007)(5660300002)(52116002)(33656002)(316002)(6916009)(4326008)(44832011)(8676002)(66476007)(66556008)(2906002)(8936002)(66946007)(86362001)(508600001)(38350700002)(1076003)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/aGNq9xZNqoXY1uQDxAMg0mEGHoI133Jh2CZkHuXbUWpvrb2pxFu8vE+ddGD?=
 =?us-ascii?Q?zMn8H4N+IJJkLN2FRov4I9UtqkRUxuvMPxzMJ/YWsLAMVMnggtJXEA9pDTuK?=
 =?us-ascii?Q?6EaGDxv3a6wOSJg4TWYez8SbWYhxikxB6ZWwW07IpLYj5rviqxVtKDuVVWhO?=
 =?us-ascii?Q?6aB5oicpUEeeGCFBQqVpUYm8PblxJKrkm8cGmng0yNGtth5/t3ABbSStW8zX?=
 =?us-ascii?Q?fldh80LQOpBm9k1T8BJbKlB/U2yB8fvxbhfNT+VJ53ycHQDkIU4kcvpQO6+x?=
 =?us-ascii?Q?wUPq3v5ScOW23o8lIbqMU6OykrKqHvczEbLOyGuFMGNvVdnIbL2ejH33Bwek?=
 =?us-ascii?Q?5HXRDgtrhGL5LxSBnrJCC/KImkTMGLfhOlb3KosKsNZPYqgOsu4lgfIaTcKN?=
 =?us-ascii?Q?zpYSllH1P/AGR8ah/A6jokYhZcCAyi2Hm/cV/Xp0cIrRQie/LK3Xt7b8Jbxb?=
 =?us-ascii?Q?28ZRZf1YxKB4lv9563fHHc1obT1qSxZNlCde+hsrvoBJPc1rp24uozlS+8tW?=
 =?us-ascii?Q?5qRxipeBGLxZwFEYpUeGGgzxlBoolbhpu18Zwk9iOQtPku199UnR00PL3G8I?=
 =?us-ascii?Q?BBwSZvJVw54zbXCPsRjvioqeBSv76KIr5inKXeZXPqd2Ptck5muG7+VjeAR7?=
 =?us-ascii?Q?U32kpy+F9hzGln36Cdr4DTTpriLsEk7apRImygFVmlAV0QAKVjVacWSl/X9m?=
 =?us-ascii?Q?cFw+Ejeff+keXv2K/1eZGDeOq6jmgvtYrd9WsAMTfT8oaAvqVGE0cYbsOtYU?=
 =?us-ascii?Q?WjQmVwbpTl2hs5dnMiHzq6Ex0rdEuy4QwaLb3aYVKJ175cJaef0tJcLKT4jt?=
 =?us-ascii?Q?IjwQvQb0YFntlTjzhWnZJZSeWF7DEGhNbWcqa5y+JVSjgzXjmjq3Lb9+82tU?=
 =?us-ascii?Q?pjh9wKAdflcs01WPT/58IK/qJeCXUqU9MFI392XlogYJ86ftDNZjNO7srAvH?=
 =?us-ascii?Q?53m/X24ISLSSpQkJ9xupRY4vt6OEIK3hgYYS+IjTd7+Exv0ugc8wc6W2Lu1v?=
 =?us-ascii?Q?6NObcVKXKsqNe64K9+eI8PBogRkvkQ0wjGVfpcFFWhdvlrxiX87cXq8ujvRe?=
 =?us-ascii?Q?VUJQEpMDQcTi5c/qQ4VK6y8BdZHOpcuLzqyLFe5jnqcpN2CdVWHpna1ANr7r?=
 =?us-ascii?Q?OY1qGdZ/RzaIhnpOhIe3kIXB8ggZGR4j5FGNMtI2Flgcg5FSH/5EnkqIeyhI?=
 =?us-ascii?Q?TICOEuNdHbuPtaomQRKs//IGso3vcCwFrxSAe00dqYTuc4uuFwZ7Y27DB3RI?=
 =?us-ascii?Q?1I8HxYnmqBAisJtqeUlegdW6P+JRJIQspWlHhg3N4ifzWD3klEVlQWB8jsp6?=
 =?us-ascii?Q?9MWfpB5Z5zts6jgjhhwHhT3sCMoQ8DaaAsfXKa4Dv0rR3qxDa8xu0VAX8rRM?=
 =?us-ascii?Q?gY5mFU0ltG8rDs37u2QreQ7XDfnqJLk+viW0OuIpsGwdEdXY4YNan7RKL1x3?=
 =?us-ascii?Q?flYoe7EcwnKpODpdvyi0LgZcJL5FMxfVG5Hc6nzq3OyrPUab1dfP/IlVzc2s?=
 =?us-ascii?Q?8Z8cGBy3Uv5SuW2CdiRPJKGSDEiwPPzFh4YMnhDzSI6rsFuyJjRBrqMSII7g?=
 =?us-ascii?Q?oUxpdtAcVrWFrEWirOLRKSkMa0I+T/ZJfut7G83MlneUKAqZ4LpTKWhL7nME?=
 =?us-ascii?Q?PkNf5CW/ovq6kxh4bCsA+iz437rcngaKUw1Qbv0AeoDMZFAyxA458PnzmxW5?=
 =?us-ascii?Q?DTG8+g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015d375c-0d09-4ab1-4aec-08d9ea217bd1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:06:18.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLrwlgMTpZg1kdDoKoS9JW6gVIYnj7uRpEG7uHLgeqm1UwmMtfFzdeNE1P6uOR7CO0BaVNtO8DPF+EgVAqSWobR/2AHMrLVNpf/a67BRJUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070066
X-Proofpoint-ORIG-GUID: bmYSVUWkhq3zUGRFrBzfheYxfaz1V8oT
X-Proofpoint-GUID: bmYSVUWkhq3zUGRFrBzfheYxfaz1V8oT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 05:45:12PM +1300, Paulo Miguel Almeida wrote:
> Debugging content present in the FIFO register is tricky as when we read
> the FIFO register that changes the content of fifo struct which reduces
> number of possible ways of debugging it. Rf69 uC has the possibility of
> triggering certain IRQs depending on how many items are in the FIFO
> queue, so being able to know what's in there is an important way to
> troubleshoot certain problems.
> 
> This patch removes the requirement of having to compile pi433 driver
> with DEBUG_FIFO_ACCESS set and let that be driven by printk verbositity
> level and/or dynamic debug config instead.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Meta-comments:
> 
> #1
> In my mind, I didn't like the idea of having to change the code and then 
> echo "module pi433 +p" > <debugfs>/dynamic_debug/control to only then
> be able to read stuff being sent/retrieved from fifo. It felt somewhat
> redundant at a certain level. On the other hand, I understand that
> removing the conditional compilation will force a for-loop to iterate
> for no real reason most of the time (max 66 iterations)... so I made a 
> trade-off and in case anyone disagrees with that, just let me know and I
> will be happy to change to a different approach.
> 

This is fine.  It's useful information to you.  It's makes the code
nicer by removing ifdefs.  It's not going to show up in benchmarking.

> #2
> In the past, it's been pointed out to me during code review that I tend
> to add code comments which could be omitted. In this case, the for-loop
> seemed a bit odd without explaining why it's in there. Let me know if
> you think I should keep/remove it.

Remove.  Everyone knows what dev_dbg() does and the "read from fifo"
vs "written from[sic] fifo" is built into the function name.

>  int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  {
> -#ifdef DEBUG_FIFO_ACCESS
>  	int i;
> -#endif
>  	struct spi_transfer transfer;
>  	u8 local_buffer[FIFO_SIZE + 1];

You did not introduce this but we are potentially printing out
uninitialized data if spi_sync_transfer() fails.  Please initialize this
with:

	u8 local_buffer[FIFO_SIZE + 1] = {};

Do that in a separate patch, though.

>  	int retval;
> @@ -851,10 +844,9 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
>  
>  	retval = spi_sync_transfer(spi, &transfer, 1);
>  
> -#ifdef DEBUG_FIFO_ACCESS
> +	/* print content read from fifo for debugging purposes */
>  	for (i = 0; i < size; i++)
>  		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);
> -#endif
>  
>  	memcpy(buffer, &local_buffer[1], size);
>  

regards,
dan carpenter

