Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658EF4E65A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349735AbiCXOse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243341AbiCXOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:48:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD91A8EE5;
        Thu, 24 Mar 2022 07:47:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OCMl9F015038;
        Thu, 24 Mar 2022 14:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cjY7iA6mDgWcU4obzhMlJj6CW6dBm2aAOqsd4cY0Ybw=;
 b=bQ2NJkZn3Z9cDe2B3AsytBOXAtLRHfMiv6gh20a4o8Qtfifu/RGc9rJIgPGwUxUVz2Lr
 MRB9NO+ewtLM2xF6UG9xwPor8c2aS12415ZRquQ5WQreHKk7HyD1051D1cpkl7a1xmrK
 m6MgYq3lustOXRchvNWUkwxc/0tF2jd6uITJOko/DE7bdEzLZBQxb12EYGMI1odxrC9K
 Jy+ULKX87xkyZ+1XEot9hE8WdvytXAu4DwJcwILU+9kTYklQGmKOF/wfaLXemOaBaw3l
 X0X+rYlxC7+Qr4uVemceA9FNY7TTxqZzuyPs/YdEotKx5tNS7O33BYgBUXnmPQ/1M9Yv ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y24sqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 14:46:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OEeuZJ079735;
        Thu, 24 Mar 2022 14:46:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3exawjdcf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 14:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbP6ANAkngCktLrZ2zjUYHOwfmGx0bWQgUjZv0KhHaCAKkqUAy9gBZ2Oz3BeP/jUlBCli2pVe72ljGuUNWjoC9/YtND3KifN00yNnIzEY//pd8RHMK+alEVIdEiHCDvrWLd9+9HWR5CONgLnJcY4VQUARKooFM9qD/1WN8KOlAJgfQacsT1yJaVS6tnDvENYGYRT4HLccvERzivrWurRXvFBn8ttAHjbfLPuXO7HwllIX5718HMzB3+9YuVf1PD0JnGvaDe+YW8lYeHaZJ9w+piFBGreFvgJS/EC/40lpoVRAA8gWyAJ06WHCTvndrDO8uwMNvJIW4P9RkQExXtq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjY7iA6mDgWcU4obzhMlJj6CW6dBm2aAOqsd4cY0Ybw=;
 b=lLhTrj9jCeNsqZOjxsADexcUZvdQUNsgMpB2ZGvucH1EQ8oV8o69kTdXnHtr2lT3ielhoelR4nbi3OrS9nmOYshkxK2QHIDfQ+h42L17kC3u7Wqv3LncdCJ/XBJp5Ory1a0ENfShLvkk+jssz1PRVSPz5UyUuZ/r6nmJxpsSxitjYEL3Bohu5vzOfov34VxGDrVDj5W7ceadND+NaWxwZIvA8ORDABf0+4ngRQ0S0RK/BIOWOIogF9VrxTdJzzaoNSzdm5QgsfbnXtGsQWsvjPKXqTtZDpBaVJROrIPhCs3lO4c7knxXFXS2X3AY3GBkxMIamnKWH88BbZ8tuW1U4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjY7iA6mDgWcU4obzhMlJj6CW6dBm2aAOqsd4cY0Ybw=;
 b=b+Fs1YmOAAQQIpyX3Jp9MtTCExA/JLuE1ivoxqrgKONKZZOel5DAv5zDpPdXxwLLYBRP96cN8hdU3l+dCzv1M7BxgNWIEelJHCSYwbbpIEzPjvS1xh5YmF0w9uP0qmZmDB6gkNn86EGJFTptPXQ5nz30z+Qk46Wfc2AdV4Yl/m0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3557.namprd10.prod.outlook.com
 (2603:10b6:a03:125::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 14:46:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 24 Mar 2022
 14:46:38 +0000
Date:   Thu, 24 Mar 2022 17:46:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v2] ksmbd: Remove a redundant zeroing of memory
Message-ID: <20220324144618.GQ3293@kadam>
References: <577b4601aa5d62d222fa9387c5036f2504f40318.1648017112.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577b4601aa5d62d222fa9387c5036f2504f40318.1648017112.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2e4790c-9100-4e70-eae8-08da0da519f2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3557:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3557390FE94F3A7D939165BE8E199@BYAPR10MB3557.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKZRfgd9NZ47Ka5S7CkVxxFK1UQQo4nC0FBEmYabfg1/8+EG4stEE6WEpBZJLgIix0IMglASifvQro30mP01MWspGbngcEKcB1Ja40Dvpkpoctf2HlndDdr4dTWricEE5kZrnV4lm5zqV3BY/6pYJOdtZ79wL7P9fOZyIjbujtNz5SIVKBTO49hwikdU57miJMybc6aA2eTPPSVKD8WY08Wpk2fsgC04E4SAu9fzs9Xs7w070z+cbNrBHFPpmiXsG4SFWWXIlSD1OEt3nuR2Qt0KSnfFTRcz6LLYgcEamBBw1w2DDiTfXpXtPeH+zntBS29AV//rWUJ5rnMo3YJiBaOiprlQ9B9qODPfpdI7/VRQTIu8dWS/JKf/myIh1fCo6rBJA5Km3ksu3v8zS+29WHkcSnO/inCpO1eKE56TmcY46iuzM60WdFNhvUYQ7DSFc/n2f9eo5ddukRrLUYXo6OKZ0m0SSko+W3SdEZWa0KBtgoQeLPMrCfW+1MrCj+BSabLm7f5XmiyyXQNONaSMuhOPeSokv5USZXJIdeVgIoyzPy7uCYsEExZhBNvX38geekfFnV5lNvk1E0UZP4QS3GQizTChFj7S9c2yBzCXnGUn8Lc3wJd8sJLH2YkiCagPhr6HX8TPXXzKeplV17hsw+Wc2LScE6hSerkk8XnXHnRuwcb77V/hNZMxdN1xisKSmCw5z/XWDj758lZyh2PzfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(44832011)(38350700002)(38100700002)(508600001)(4744005)(6486002)(8936002)(5660300002)(186003)(4326008)(316002)(33716001)(66556008)(66476007)(66946007)(54906003)(6916009)(26005)(9686003)(6512007)(52116002)(33656002)(6506007)(6666004)(1076003)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtAmEosDKPAFhhSEdV7JX4WNMX/go8b82TFYxZ9HakLBuSB90x5pMwQ29c0A?=
 =?us-ascii?Q?pi/mqqoCiCzKpAcKgEiGs/RSzL6Qd/HsOhsoiuMzbqCA+rHoCY4/buok01cB?=
 =?us-ascii?Q?RsDfXhTH/r5yEtJMJ56fPI7r4Z1UD8VPXJblCKTqweG/05kfsF1D/keLk8NV?=
 =?us-ascii?Q?8x8MoeEAEuG5wR2mUcl4Mm6I/snMt+apTWO1KKxGJiKk8SUfxWA/015bkazn?=
 =?us-ascii?Q?M7w0fUr02CyXaZnF6qq3soCSAmkF+fZLDf2d+5XzRQT1S/GOCPXkvtXTH5Ux?=
 =?us-ascii?Q?u9SNqyglqCBu8+6tF8zzJ1sc00ksh/P8wmhYUezQDC6POtwcS0uqRCtRy8e8?=
 =?us-ascii?Q?kT/R1CrouTyU2qmJ4Sh2EsrIeI46TH/0Sj9R91Hi7+J29S0AiYaysx6AkvB1?=
 =?us-ascii?Q?z5ivamwgGITJ/jnVLhCnuuqjxRegsmYOI4rIGJS3Vo82zUcN+rTuu6RRLWoF?=
 =?us-ascii?Q?uvOLpQM+ujm2LcnURFUtWYInXWE1ZfVrMoPQyIfBfuPCnOc8kSBsDUWzZR0A?=
 =?us-ascii?Q?Y6Q8l01SsP0WBx2XWoHhN3bfMgukIR063UZ8+d7JFZ0UGAfQY+ZPUQvETyNm?=
 =?us-ascii?Q?xcm9qnPEFgzRaexzRvKKOM8jkW+kmUkosmT2hwjzRD+UU+eeFJvUyjgM7XhF?=
 =?us-ascii?Q?IoXHDFnF4OsiAnMksxu7j5LK7RqwSaO8K4R9NBqZkTi6gmyLfyaIM0z5FN4U?=
 =?us-ascii?Q?pgKxPnGsceI0BBeIqgIGRpxOZGindAnQSaEFpyccg7BWNxyKv5A3XCOw+99V?=
 =?us-ascii?Q?NU9aKu+7++sr+e4TUWv1cvA9VL1a2s6sGnEs+2GxbPxGJIy8ePS75ITE2yVW?=
 =?us-ascii?Q?zFAMDcfDqEP6DFsjHrFD3d36AYF1lDBvPJsmBfimjuzb5YREzk9DMu4/fgMC?=
 =?us-ascii?Q?Wo+oAS80j+g6wyZwRymE5x2yDwOl/Wg5NTqj3KgT7aDfSU7d6FKVlbHCaMKw?=
 =?us-ascii?Q?FOQ2JLiSzih/qKDFcusEQJsmsRsF3yWhjgFbc2Sr1EujLmhJbIhF4FD9Z5IT?=
 =?us-ascii?Q?aYgY0LCun6B+VlVheAlD59++wh1DbGQSCxivp+T77lofiaD7vzCmED+Rnqix?=
 =?us-ascii?Q?0TUBb7kTA3pngCE3W6wz9haFtbmFPhxOGhMGjaOilJYrhobR5Q5o24pmsJsT?=
 =?us-ascii?Q?FshS8zMAUDFKc2aN0WbkmybqHlmmlmJIAEO717eNlNRkPi7dXRqkKEnYN/Zu?=
 =?us-ascii?Q?iEVZau2XP8ZxNaJl6H7VU8naiw2v47vJjBVn/8TV0sdEGHR+P1enAYgUmDsm?=
 =?us-ascii?Q?Y2WS3S5x8MYqCADzmaa7HDeXhNy/UvamgnNwvLqLYIznLMK7tZ3f4OrvHN0b?=
 =?us-ascii?Q?pM10T2/62yCJtHVsv+HmrVS5/+NDyA97vmenZF3BOhxjyCqo0NOIOMtpwr5e?=
 =?us-ascii?Q?8uIwR9Nk5dmIIOcGUiH19JPLvXxe9TDxdvXIPC91S/v1UWzGcoLYygqsYVud?=
 =?us-ascii?Q?/ImdiFysJxfdL8E8oM3adhhsb8uNKoen7fymfVPxJ4+XbD7bib2MKQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e4790c-9100-4e70-eae8-08da0da519f2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:46:38.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKy3/X1ZZUJv12lXlLQpWw57O8cM3iAZnf2V0Z9nGqYCXHpDnXQ6lWbjpFziY0PrFUI3fqq4TjlF9clCKguLv7UeAYW0PagNcZlqBQaHx40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3557
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=748 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240084
X-Proofpoint-GUID: Wod73xKs0CalmrldyXG0VJYi2Y60RDQh
X-Proofpoint-ORIG-GUID: Wod73xKs0CalmrldyXG0VJYi2Y60RDQh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 07:32:05AM +0100, Christophe JAILLET wrote:
> fill_transform_hdr() has only one caller that already clears tr_buf (it is
> kzalloc'ed).
> 
> So there is no need to clear it another time here.
> 
> Remove the superfluous memset() and add a comment to remind that the caller
> must clear the buffer.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: keep kzalloc in the caller and remove the memset here

I kind of prefered v1.  I misread the code and was looking at the wrong
fill_transform_hdr() function from the other driver.

regards,
dan carpenter

