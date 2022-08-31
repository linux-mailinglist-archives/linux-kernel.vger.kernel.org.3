Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA35A7B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHaKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHaKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:13:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1CB7297
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:13:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V905hO012850;
        Wed, 31 Aug 2022 10:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=IoLcNtr4cnMzY+l1iMArbkaC2yuRdeMg2veYGn49Gkc=;
 b=tHs80UOMZYDAPS4yQlILmjfZv1uovAFUixPfjje3JEISzvjhJlTtGvKIw/qFHBJJDyE5
 rWGTikk1h6QJPSEw7dspH77pTAGPoE7BQsk8fR6RNaR9ylMgumvIGUyGrkDhsq3qKAjc
 /bBJRZUCVNrNDr9hbCW+nHNsPNQTZmpM09QjEq3de8fQQ2nX26+rxsLoWuVcS5QQJt2z
 l6Cji7yRlsPPET2Ri+I0MaRhY8pEOYz5oLKu4ALKmXy7NjabBLrO59judwdEurU/Z8Y0
 ISWOjurmpto13KK2XTXqTUADpCWd45MSrR2WTRf5nTTgROB309qTsklB12q2ELdVKhoB 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0rtw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 10:13:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27V9US8C007887;
        Wed, 31 Aug 2022 10:13:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79qb76pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 10:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0+n/OnQu8QM/NvpELlrDcvxMAewNxjsKUVxTrrS3qPzqWOkVYv8sb/4Fl8v5D2gxyyZfsCWhLBlA7K/RukQwqTXY6rum1Z3VCTkCDmp8+WAt1Nfk5MDeNClTN4KPl5aZW8JbyxhSRvamC+EjoANeNwcOcpBCnio6heL7kuzyaeFtukrdqDqRcgWKTzIO6iD3G9LoIX5vA5hl0AT08sFmWG3h/1JEeSO/gmds3orAexYqO1K3OpfvVwrwESlS/XdchhgBY4MYRgzjWbRAH6fmSnQVF+Cv4bVb+SZXHbovFHHWSy8vA/RctytWgGvnK93NRlexqh5sad0ivzZjdDoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoLcNtr4cnMzY+l1iMArbkaC2yuRdeMg2veYGn49Gkc=;
 b=GTDov1K7UiSOzAAUwdtji2IzJPDX9xUMsEHFxg+ShPgdyqcPwOr/Xq2e1G4mUq3pO65S9LGbqZq5NtomqoTk3hihQ/xMaQMmemaHCVUh4FKfOQjjkJoQhrcxidza7DOZN5lZe1XDnLh8222A7EdOPUREwP19a58jgoe7miL7mc/CJvgoIsoh0pu0h2bwH4kErysOb2tTXfS0lTZwXdyd6fcMJmiVSgSCTnqy9Tg2WyxwFSm8kcZtWeSL6P0zJtGY4vAF8/a8tzyLNbl7dw6RgNw0x5r/TYidNigAnqL5z2i27s36fqwDVXicc6sJHpzuS9zAr+pc3qInjYN2LmYc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoLcNtr4cnMzY+l1iMArbkaC2yuRdeMg2veYGn49Gkc=;
 b=T4+DJ1hAkARciaipjRhRMDcvQjl4sRdEWlIgyUeyCmkdsZSQ8fZc+ijNo0Wah1SptxGlfPdSgsRL+g2kigBfx2uI4jAJRu6hgpCRhYOhYOCdX3zSlbMd+GxYRL6T/VXxcHhdLJBplTQKRGM6jXOI1XYt/8U3q886Wh/S4sHaFEA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5846.namprd10.prod.outlook.com
 (2603:10b6:510:14c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 10:13:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 10:13:14 +0000
Date:   Wed, 31 Aug 2022 13:12:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        Anton Altaparmakov <anton@tuxera.com>,
        akpm@linux-foundation.org, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, 18801353760@163.com
Subject: Re: [PATCH 3/3] ntfs: check overflow when iterates ATTR_RECORDs
Message-ID: <20220831101253.GY2030@kadam>
References: <cover.1661875711.git.yin31149@gmail.com>
 <7b8b8633d921665a717734d011a92f713944d0fb.1661875711.git.yin31149@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8b8633d921665a717734d011a92f713944d0fb.1661875711.git.yin31149@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27fe69f7-ad38-4de1-7e1d-08da8b396a0b
X-MS-TrafficTypeDiagnostic: PH0PR10MB5846:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/l/k+sBfJawR3MYgiGK7FIo+MmAq7e/OxVslg8eUyFOXDHIN1aCxskv+hr5BvpHxTl1C0LqAk7OYcxWQrU49QifsvLQVPf5rzJtn527xfNoT5ILaiUOYGZnPCLu7l8dQPaS25h2SjFWUK9V8Kb7/WGb9YjqqqqpkHP3Dpg02wLldWIdo5EKQg/xOPSwbTncS+J0kEalB8gbkDzTOO9n7I2D/I4sxYXcJxiOB4nkiItXrUAUKUKnUMqNPCcG3fWTmmETnjVJUfzeBIwaRK4Un2XYwNsYjNm0mVrkBDfLKKv+1wYXju7BnhTgKnmwjkjDg/VkpoHOP2VuAOA+QLekzhmLKQheW/dJE9v3dcy0IWJx7RXuObvtAClu5OBx5Jf+G10GauGdxgGbBrMqIPt3bhOG8T8/UXRIc7nACxj0dFb8t1JjUSjxWwgg5pTpFFhbBiZaW/JB67B7cMSkF+djkCYJFZ3gIc+yynbMYJAK2mxpPjyyvATecIDTo+RL0bnI/oZp7vn5hlSlaDbObbyRJxJa2lTmjd9EhN8sPHCTZoSUGQMfFfTFz0TbXbB6D52+4ahgq1Ec1IfNLUnNC94DSRpTLCOwMja5gLSV0fXPKy4q6V3PKxPG4m/nSZMBKXzVssNcvim/NILTCMTINpK9EcpkgtmHBG3oi92+zCdc6LAUtMwQaO5IZAr4TUbPTn2ZOUuMioGb1xkAk1O2Xyxr+lPfPelb6Kf/foFgXHRt6PXzcQlWK+NJcIWGtBhdJ+TaQPdgZt2xKzr5wDOqkbDTUBYOYDTFZfzQv2xuG2fTtZprkfU1swD7IaNCbNCv9mo7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(376002)(136003)(366004)(39860400002)(66556008)(33716001)(38350700002)(86362001)(6486002)(4326008)(8676002)(66946007)(8936002)(5660300002)(41300700001)(966005)(478600001)(38100700002)(6916009)(1076003)(316002)(186003)(6666004)(83380400001)(6506007)(33656002)(52116002)(6512007)(66476007)(26005)(9686003)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t5uzyPPgZ/Z9b+YZXzS+ElfdljcNwcuqxnxBIUHbK23aAqIcw6W8sO8seZlW?=
 =?us-ascii?Q?owlHgv7NZNRSCJfXqXjvwW+e9SdgtDRHoA7FQe5CiHW+x8deSdVpe4+tSZTG?=
 =?us-ascii?Q?jlBAiXhXwf/MZqvIuVQXQ61Dfs0dynO0GFgNgHIevWpDUfs+x1/tztIyz4jf?=
 =?us-ascii?Q?M5vHG1Bvv2UVCjlfhnpFd3rhD5QILoIXIccXtEOuLdpoe50uMRBsrnkBH80q?=
 =?us-ascii?Q?oUf0FMqdHs7kCt8hyvDeesjbOJPwJhqRoGrXIe7HZ0UPT8fCyn2v92Gp2NFR?=
 =?us-ascii?Q?R5w5NZfBG1IRlMKx+ES0LxpgEq8ZivgVUgKtyWKIj7IPMwDJnoKlAKW9mmnI?=
 =?us-ascii?Q?2hWBavQ3qxJoB9mY1dEiuJbdheaqvinnlCHrBoKH6iQsv3+wTgaRXa+1se6T?=
 =?us-ascii?Q?zGnrFQYk/uvTuRkpr4XHhTtYWnGh98rfBijL8KgqaPl95x5rHkibY/zXEjJb?=
 =?us-ascii?Q?8C7Z8EJ8o066UehuIqR5hukyMknjseVAKul4pmvVYU1OtTNvBBS78GTa5ZrI?=
 =?us-ascii?Q?+wy19QSZRSuprmOr6JnlT9+PVy6sLgACn+GbRKAu9eVjQoTdQk3p71SRBUCr?=
 =?us-ascii?Q?gD43lqQPLl4pYsr2HtrDW1La9FHe8nWR/thOKc2mRVTPeC7rGVQasRzfYOm1?=
 =?us-ascii?Q?crh2gQN0ChTXy4bwymkfPoCls81uMC7DsxOHcSRCxLUsmMZsOAfrRuNsLkuB?=
 =?us-ascii?Q?lFv7tBHig2W8d4z1Tk1lfbMM0owuadqI/OmYeeIKAMiKRylALIEGJpHJbqOc?=
 =?us-ascii?Q?bN6z4dI38bZSGRvZqkDalA6f3Y3k4hQcEgxAe99g0n/iSFsIVDLPm0hBYyo1?=
 =?us-ascii?Q?volzbqcknHilMXi3tQIp08YtfC5fiwkIyR8SyeIIh+klB0mHVetbzMCDWk3C?=
 =?us-ascii?Q?9Ag53SILC7NSFDYQphzXynmdXP565LdiXyaYPrHCTNQcqrA9uhZ0M7dBSZii?=
 =?us-ascii?Q?T8kzhU9Nb2Wm4pOFlB5hmNKW/Nzsk44gLMpy4N/x7TmKcywyc6ER1v0/2ZLS?=
 =?us-ascii?Q?1KFCZah6f0ChmEU0FlkWbO8iq+pHVPPERkw2I+tEpLPkWK0qNJneNRv+YF67?=
 =?us-ascii?Q?Zn68oYiArPACdsq8bXq21DTIfttMK3uZlp0ZYtQsbTwWuTNh/vjQ/tpnmS2f?=
 =?us-ascii?Q?r9nOjjEoT6E8zfuaN7zO99NkORc5y1cxDSDFbyEbsef4p35X85IGM6OrUBYA?=
 =?us-ascii?Q?ouXUa1zE1WZnh6K3p6pI55KD8Sy1ZcXfGtgqy56+sVCRpd2wEVywakDlGYPn?=
 =?us-ascii?Q?m4Pv/453Bl6xaObNCGdhgJSAjssUWYtDvnj+JeZoy7azSPd55Zli3TKbDyXJ?=
 =?us-ascii?Q?cyjy53O5+2HywN7+5ftw/1FlYfc3hf0De3ZHzJu7Iuu+U2Cou9OVqPiOExPY?=
 =?us-ascii?Q?OZJteBWzBdf2RAGSYL0t3W8TGhvBPOBg/TOCJOBZZcDNRqGJsxBkh35p/heE?=
 =?us-ascii?Q?TjqrDruTGOtELWmEq+yK31vYqJYxdAeBFJhV7nVAuICNs1GRHME4TG+yUyzp?=
 =?us-ascii?Q?XlYynfXjfUcQLvLhF0+CcWERtoBnV3ox+JlPvOw6Uev0CoDJu/PrcEZpGCO8?=
 =?us-ascii?Q?qjkAuL+rL8VLqcNl5h0Jeck7ZQnPkW44l3OsmPFvSAplpe4aHvSgTz09Ec1H?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fe69f7-ad38-4de1-7e1d-08da8b396a0b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 10:13:14.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nY1d01FjI2CgffxpFZQwVPBbM3o+5jdJtoZ/k+MSkBWA5uoj7OjYr/1kklC89YT7SVhmC1FL8dS7tKinn6lBZFVeelNzeHY+ZcCbLEh/xho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_05,2022-08-31_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310051
X-Proofpoint-GUID: qYb1halYQLplbG2TzxT1G_A2EbjI9xtl
X-Proofpoint-ORIG-GUID: qYb1halYQLplbG2TzxT1G_A2EbjI9xtl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:48:54AM +0800, Hawkins Jiawei wrote:
> Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
> Because the ATTR_RECORDs are next to each other, kernel can get the next
> ATTR_RECORD from end address of current ATTR_RECORD, through current
> ATTR_RECORD length field.
> 
> The problem is that during iteration, when kernel calculates the end address
> of current ATTR_RECORD, kernel may trigger an overflow bug in
> executing `a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))`. This
> may wrap, leading to a forever iteration on 32bit systems.
> 
> This patch solves it by adding an overflow checking on calculating end address
> of current ATTR_RECORD during iteration.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lore.kernel.org/all/20220827105842.GM2030@kadam/
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  fs/ntfs/attrib.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 904734e34507..55e618c9e63e 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -617,6 +617,9 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
>  			return -ENOENT;
>  		if (unlikely(!a->length))
>  			break;
> +		/* check for wrap around */
> +		if ((u8 *)a + le32_to_cpu(a->length) < (u8 *)a)
> +			break;

Wouldn't it also be good to check that a + a->length <= mrec_end?
It gets checked on the next iteration sure, but it just seems like a
reasonable thing to check here.

regards,
dan carpenter

>  		if (a->type != type)
>  			continue;
>  		/*
> -- 
> 2.25.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/7b8b8633d921665a717734d011a92f713944d0fb.1661875711.git.yin31149%40gmail.com.
