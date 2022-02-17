Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46C4B9537
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiBQBBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:01:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBQBBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:01:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633A279935
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:00:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GNtaMW021455;
        Thu, 17 Feb 2022 01:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JFJ4kL7SXijJN3oG1sWTZLHxSTd5A6JiZHl1Lxxa+Cw=;
 b=kMKp9WyyWZ5lclpdq8ckdCr264nlrxv1i3jxd7Y59ORMZ9DLPqs+Zl56MadI2B8kw0uL
 wtaEwacc1XSaWuis1o2RlGx3b5F1h3nZcchB/c7CC23vhouJYoSitRN4oEkGLRW7pWdh
 pdsTrESl6JPxbpxPqZ6rPPdziIOUjB23R1+nL6THwoT5c+SM1DVdcVCY+TLVysmGmGuN
 g6wmjbvU+B07qBKpNhcmsusPYH7SwvicE13Z++WBGh00ctcVIsHZhbQ7cb6Xap71mNAb
 mNy4OuOjDRxelOZZDD9WF5E/ckwFtMb7PdDisBjJ5jjG1amIZUkAFtH0pLuMItMFFslN 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fbr6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 01:00:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21H0qc9h172044;
        Thu, 17 Feb 2022 01:00:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by aserp3030.oracle.com with ESMTP id 3e9brbrqnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 01:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDwV3FHosGiHuP1ZLe6cfLOX4/o+at6v/JytS519MGgGHoqMpQjapkwjIAtTzv+ksxWYg5iulLzT8emyw9OC5Nt6fsGma1O11/WxVY5/mBUyK2DNcFDC9ayGNJm+CrcVhLT9d/e5+Su7UbwIsW26fCyjcBvMrhYNhYvBD4P5lUMirLBau0LoN121tTwPejGu6ACQAl3U0cVOOuLsXtpq3vYybrTEQQBhCgGcp0n1u7Lf73LDPa2H+G7hDbV63BHZXpovertesmWTawa6lUyOlT74hIItSPFtpiMUp2b+mc3mJxiYySXYJ/C//CzAKqhbUuppE0Cap5lh8UJaxfkk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFJ4kL7SXijJN3oG1sWTZLHxSTd5A6JiZHl1Lxxa+Cw=;
 b=ZcTA6rSfDRpWLmplAoAhA/k7la0YXOOpsS3EBP9nHxS7bMjj12mk4MbuEX9rBwl/m3pR0d9pvvkIZKmEG+bqUjZFy7lGqdw6A5xwNoVmDmlBpPums+JBgi9fews0+ZQ+u0aGcWjw0BR/p0bNS+MfT57J0HlV7yB9gN789OoNy/WMvVqTLVYOQ2X4aSBiKBtnA9FAK6XJvHnMzbyz4jG+Ud2NJrjM1eo2IxW5RkB/Isau23vxqG4fE/XN2zRW3Vtfw/igVWlHlATTYubpOMLjxenTXliBHmtqbbneQufhkCceHuPdoonHfWmhPYQ8UlGewiqNvFDgjGOOztKebWGaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFJ4kL7SXijJN3oG1sWTZLHxSTd5A6JiZHl1Lxxa+Cw=;
 b=bWJ9y24PV4Y3CBMAaHfUsj1tAsUxGI0ghVwsOtTpLjiD1ninowjlzbqm8K/R/DM7Cs6nT1W09/lak26keh7+tKDPmEFDUYo/oImodC6m+pakSfEI6MGU+PuqQ7b4kAImmE+4aO1MMUFNV8Qisk0a+beOVjg/Y6WX8GPCu3aCnzw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1934.namprd10.prod.outlook.com (2603:10b6:300:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 01:00:48 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.014; Thu, 17 Feb 2022
 01:00:48 +0000
Message-ID: <1f486393-3829-4618-39a1-931afc580835@oracle.com>
Date:   Wed, 16 Feb 2022 17:00:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH linux-next] Fix shmem huge page failed to set F_SEAL_WRITE
 attribute problem
Content-Language: en-US
To:     cgel.zte@gmail.com, hughd@google.com, kirill@shutemov.name,
        songliubraving@fb.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>
References: <20220215073743.1769979-1-cgel.zte@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220215073743.1769979-1-cgel.zte@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0041.namprd22.prod.outlook.com
 (2603:10b6:301:16::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74aaa3c6-63a8-4cdf-2aea-08d9f1b0ef22
X-MS-TrafficTypeDiagnostic: MWHPR10MB1934:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1934D38AC4222CAB7712217BE2369@MWHPR10MB1934.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9JQltIeXzIYqxN6vflJtqy9JFFJig1AjTmZazmrlloziKQSop6YwiJw+e9nlUdEB+JUnYLQZ3kpcbl8l7UIzyGesQyopgA6tdrLT8sHCcuv6T2fcuOhEPFHr7IGNCMi9bwVEuK9/ydVb3qqXqa5TqFE9dUEbMc3fAgQSlr7twaJy3e57M1kYLzuHVmBdVWomXEfdp31FR/qkb0o/mroI/tP1DF+kv3IBcHMS9Y93Pb7It3vN2uqOVARBuryX1aOjKv3rDZJ6bCLLDs76IGD7WbnVoxpfj3DvXYymW1bmeFchKy9LckPG+j/nQLdHBJqTXaQk7CGHbN6pAuNVksMKG1dmGmUKqrt3WtTZEMgHpLQol/OzZ2+0R1nTuy8De3qgfX/4geM6Imb8iAe10h9Ewkp1LP59GOzI+KPTA0dH3CInWvtySIxz7c/h1+PLCiZpU4jjm5cA+6R7EVAWJ6c2JHKckrnn5qajDeHqE0i9driVD6UWSuwOFTCbFqY99dhV7HXUsZb/A4D7HIpJIW414hdXItyOA2fxU3PnCqQkAVUI/ejLLen5kQVq6w7fTk+L0hO2YNZkT2kBFVXTGzpHK6vbMCN7yM4kDRH1l6nO9y2Qcl/4LFtcQC0/zqaoBIwCo9KVtVWOoiWiz0s9EraoV34ul7Zbh69Axf8UN8NMiJDB53856GbRVtC3Km93UBqTF5alLOj7Y6uzgnsndppy2gNW81Q6OmNWFGDT4GPx6qkIkBTsM3UbCJ2gIXzcDVq003XOSHT2n6GHp9zwZlyajY3p0EFKNI6ry/FQvN2p74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(52116002)(83380400001)(6486002)(508600001)(316002)(8936002)(2616005)(6512007)(7416002)(44832011)(5660300002)(2906002)(31686004)(36756003)(38100700002)(86362001)(31696002)(186003)(38350700002)(26005)(66556008)(66476007)(66946007)(4326008)(8676002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkpaYnhGV2ZoY3pUS0tUTm9sK0RQUlpKR3ord3lvNi8vUVVPb0NEWWlpWDhU?=
 =?utf-8?B?MG9XdFJ3R1RPcnRvNklET0UvMnloTG5UMEVZek1pVnBPVFFBaDZOOXNseVoy?=
 =?utf-8?B?cmUrNXBhR0xZNngxSFFaY3Q2VE9UYW9idk54NDBTa2ZtMkFRRmFjUDFMMDlE?=
 =?utf-8?B?TmJkOFJLRmFqMll4N1VGWU9JYTQ5MC9Tb25FODRhL3hZakowQy93YzRtT0lW?=
 =?utf-8?B?TDRJMGN6VDBOcUhYbzVlRlFBTUQraVc3ZHlGME5YNjh4V3R6MHlHSk16aGhr?=
 =?utf-8?B?M3QrSHp6UlBCWlpMUEdSSjFkOHJMbUZFTkJRV1VENDQvcjFFaWNWeERKVi80?=
 =?utf-8?B?aG5TTWZaa09mTnlKNzhIbC9Qem1xOW9PWk5xN1NwWWJETUhrY2ZkVzYrUDJz?=
 =?utf-8?B?cTcyeUpaelB4VUZzTmVDRkJod1lXRndlb0l5T090NGZmWGordG14citKTkRi?=
 =?utf-8?B?NHdMNFFqYURQbTR0bXdkNGFjVE9meUdFQXdBOHNpMXZETnYxVVdOKzNtRkNB?=
 =?utf-8?B?UmZiYW5GSHNCcTVxcnUxWTk4K2hvbUhwL2RhUGIvdFZpRU9mclgvQWQ5ZlJx?=
 =?utf-8?B?eDNwVDdScG9FUnAxcGFLZlVFK0MxMHdpVEJjaGE2ZGpmenNGbFRTL1hhM2Mw?=
 =?utf-8?B?MmJXMkVBaElrSGltdWc3bkFXY3g1T09RUnVMLzdGZUVnbnBFRitDR01ObWdv?=
 =?utf-8?B?UE9CWG9abkhmU0xkL3hhbE9PemNHYXJVcHA3SzRXZllFZ1J3a3A4WHMyemxp?=
 =?utf-8?B?UzJsYnJHdzBwY2JZV2lGODA4VUg3Z0EwRjdRRjZOSGhXWXU3NzJBMzlXdkZw?=
 =?utf-8?B?ODV1ZlpUakJLTU0vam1jSlpxNHl0eUhzMnh2ZDZyTkZBVStvMG9sY0tOTFAx?=
 =?utf-8?B?L2hoalJSQlQ5QU9Za29pKzluazk1SHZIU1V2NUlVa0NYTTRMSnFuV1lWM0xp?=
 =?utf-8?B?STVIbCtNcjZNYU9oOUc3dXg0VXpMcmVTbjJZRndaR29nTSt0Z1EzY1hhU1RY?=
 =?utf-8?B?VTZzWTJ2cXg1QjUwMHoxS0loMVBpU2MyTy9WbTc5MURFT1ZYdGpZZGc5bStn?=
 =?utf-8?B?bGVVOHBjL1dLem8wd2hSeEhLT0xYNjZiamZtc3BBNFRiMm1WZ3lEa0dtRnli?=
 =?utf-8?B?U1cxZ3pXZjZzYUtjcFhvTlZnOTJ1d3owRzJmYUdTWW0ycHlxczVvNlFuWmpk?=
 =?utf-8?B?VndvQXQxZGt2SGxGdlY5T2xmeUdiNk50di9VbnpqcW5xSGpUM1BHYUZPMEhK?=
 =?utf-8?B?SUNWMGtCQ0JvNllvdzJvWU5URXlTNThKaElOR3ZOUjdLcklZbWsrY2RKWGY4?=
 =?utf-8?B?c2ZxdDZyazNOR1dVZkNJMjQxVWlIR0tBRlQ5eHd1OTBvdUpuY2ZvWHRET2gz?=
 =?utf-8?B?LytldC8xdGFkSlM2eEhrODJ0dGw5ekRWK2JURDMxTlFadTEvOVlCOWtDb3Jv?=
 =?utf-8?B?ak9rNFRpMlU0MGFiUWRwVUJ3OW5vcXRGNDRpVDNEQmM5eXF5VllNTk9MQzN3?=
 =?utf-8?B?RVJvK3ZuMUFiVStGTzhDMWhzSXhnN0dQTS9PWCttQ2FVaWhGSWJ6ZEhCOHl5?=
 =?utf-8?B?S25nODdiLy9uc0c2NXAxQ3pxUUsxa0NwNGFkbGxNMjl4TkpuWHF4emJSWERX?=
 =?utf-8?B?bjFvajNpd1pVZ29RcVJyL2hBNUt6Y0MyQU1KbmszUEFQUXJudDJEVWE2a3NE?=
 =?utf-8?B?d1orYXFIeUJvcnpYUkxyVFRJanlmNGwxMkhvKzZxR05NRmIwbDJwOVRBZjVZ?=
 =?utf-8?B?eVpjNlFSRFMxMWJGcmhXZVByOW1hTHkzYTMvSkZCbkF0ZXVKUjNiNHNVY2U1?=
 =?utf-8?B?MDBCd2FOMXpxa2h1RS93c2tTUk5QV1ZtNG5HdUNRNDFONEdnTHptNEpSM2pw?=
 =?utf-8?B?NTVYUThmTC9oNFprRUEySmplbVJqMDRQdEtSQ0w0ek9Tck1lcHhEVTlDMkZ0?=
 =?utf-8?B?S1ArSTROUE9jUVN4Wmo0Ynl5a2d2TWdnaC9MUUJsVjZUekZSZ2dyb2o3a2Zn?=
 =?utf-8?B?Q0NHMkJMYVZCaEY2YnUrSkdqNjA2a2J2OWpScmxOa0pyZFFHK3V2QlNZTjUr?=
 =?utf-8?B?SVRlTVJOOFJrRzU3VUxiTFhmNFR5V0ZHZU9aakdwOFJpOFdsNXV5TE84UjE4?=
 =?utf-8?B?Z1E1aHFvMmlxejZ0T3d6TXU4WEJNdy8zWGk1Y0dSY3NiNjdhRU5leVkvWUYr?=
 =?utf-8?Q?KthwPsGXoEr6lm7rPviMJMw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aaa3c6-63a8-4cdf-2aea-08d9f1b0ef22
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 01:00:48.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf+MnZvbiLWCi6SMscGUTxK8Ole09OZKTH7HpRRm2GTdSvKINthmvHyYeBWW9rxDpUYQ1bdYKsCn6FGkiGFvNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1934
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170002
X-Proofpoint-GUID: 2S4xlBg_z8n1Jk_N23LfYXxCDk5DwpC4
X-Proofpoint-ORIG-GUID: 2S4xlBg_z8n1Jk_N23LfYXxCDk5DwpC4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 23:37, cgel.zte@gmail.com wrote:
> From: wangyong <wang.yong12@zte.com.cn>
> 
> After enabling tmpfs filesystem to support transparent hugepage with the
> following command:
>  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
> The docker program adds F_SEAL_WRITE through the following command will
> prompt EBUSY.
>  fcntl(5, F_ADD_SEALS, F_SEAL_WRITE)=-1.
> 
> It is found that in memfd_wait_for_pins function, the page_count of
> hugepage is 512 and page_mapcount is 0, which does not meet the
> conditions:
>  page_count(page) - page_mapcount(page) != 1.
> But the page is not busy at this time, therefore, the page_order of
> hugepage should be taken into account in the calculation.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> ---
>  mm/memfd.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 9f80f162791a..26d1d390a22a 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -31,6 +31,7 @@
>  static void memfd_tag_pins(struct xa_state *xas)
>  {
>  	struct page *page;
> +	int count = 0;
>  	unsigned int tagged = 0;
>  
>  	lru_add_drain();
> @@ -39,8 +40,12 @@ static void memfd_tag_pins(struct xa_state *xas)
>  	xas_for_each(xas, page, ULONG_MAX) {
>  		if (xa_is_value(page))
>  			continue;
> +
>  		page = find_subpage(page, xas->xa_index);
> -		if (page_count(page) - page_mapcount(page) > 1)
> +		count = page_count(page);
> +		if (PageTransCompound(page))

PageTransCompound() is true for hugetlb pages as well as THP.  And, hugetlb
pages will not have a ref per subpage as THP does.  So, I believe this will
break hugetlb seal usage.

I was trying to do some testing via the memfd selftests, but those have some
other issues for hugetlb that need to be fixed. :(
-- 
Mike Kravetz

> +			count -= (1 << compound_order(compound_head(page))) - 1;
> +		if (count - page_mapcount(page) > 1)
>  			xas_set_mark(xas, MEMFD_TAG_PINNED);
>  
>  		if (++tagged % XA_CHECK_SCHED)
> @@ -67,11 +72,12 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>  {
>  	XA_STATE(xas, &mapping->i_pages, 0);
>  	struct page *page;
> -	int error, scan;
> +	int error, scan, count;
>  
>  	memfd_tag_pins(&xas);
>  
>  	error = 0;
> +	count = 0;
>  	for (scan = 0; scan <= LAST_SCAN; scan++) {
>  		unsigned int tagged = 0;
>  
> @@ -89,8 +95,12 @@ static int memfd_wait_for_pins(struct address_space *mapping)
>  			bool clear = true;
>  			if (xa_is_value(page))
>  				continue;
> +
>  			page = find_subpage(page, xas.xa_index);
> -			if (page_count(page) - page_mapcount(page) != 1) {
> +			count = page_count(page);
> +			if (PageTransCompound(page))
> +				count -= (1 << compound_order(compound_head(page))) - 1;
> +			if (count - page_mapcount(page) != 1) {
>  				/*
>  				 * On the last scan, we clean up all those tags
>  				 * we inserted; but make a note that we still


