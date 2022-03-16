Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAF4DAD79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbiCPJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244838AbiCPJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:29:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8513C738
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:28:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G82Kw9018452;
        Wed, 16 Mar 2022 09:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=PG9rXtGtOPe9Ne9DMxy+OXTi70yNoxrPzxcgnoQN940=;
 b=ix50/v+dNbxULneEVfwkctOFzgMkKrPxHxFILTxkbzXnDZBN0+AzGzutKYj3E5ISI/Ee
 aMSaO1Fwkb0ORxTFc0V9UgZV3Vbbf0exrFyFFC5ACQiCcUiwMtFKwk5zZd0tbsLOJfHq
 YRGbz0th8klWteUiJF7BuhMCMh9puPDQi6p/Iv8fOIg1uONlKgSjf4uqFt5cX65tbnDK
 7XKRa3q/cKZIvuEwcMwt6xnNDf9upZ71uDmX9BxMUKyjPelIlDct+eDEv9DSk2FKZB+J
 S9b+1C2TW4OZjztwRY75gvYqLk2S6hFZRazc8+zpr7W11lwRUfa2+0VjwbCgkTl93QWy fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwncnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 09:28:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G9A2L3018698;
        Wed, 16 Mar 2022 09:28:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3et64kj695-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 09:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJpeMYoBS0/MYyQpO5ADNA+9/LS6hXK8ENXQOdU72O6/38v756A1qNYsF22JMTXkolK0Xwq2Rd2R0YxxVkvQ4oaIJMi8wzWUJxaaq2p3QhIJ/BQiC0kXnBuN1gQiZUna6S2MKhKU7YIY1dHEeKu1YzSge+HQRNw0c2q6oXuFjyEIWMqYropHi53s63+sJaR4S5XhGSB7Ju7vlejm+uGsJu2bD9WR/uU9yV3CZB6+ydNo0DM+isxb2up5WT4Dft9qQyWte5KYUSICOXXLbc7PgJyZ03fN+BXvagpG0o1GMg1J1+ndbrytaosb/M/2JOsHff/oIx1NSVBb3fhVzEuRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG9rXtGtOPe9Ne9DMxy+OXTi70yNoxrPzxcgnoQN940=;
 b=GLcVzrEVZaLjC90Z+g/slg/dx8vkwJPBOyNeGZe6YOwSKTbN94bVvswoGydx9MRbDRyFmDj4KzuSmzXCwc6WwAshwFQr2VlkfWhgqp3IdGhnHeN2GTePpW6dm7WZpWv90y8tzhhNx+jTBn4OrvqB5HZgZcRM0s35ZrtW3TiWCktxDp4N/EfC+LfL8l3UyEoiFOyQbpa/FydiJB9kqn8F18poKbY3+CW/S+UhKVXJQOaX+1yNMxki1lyiPmtQ2zd14xdgC8HLHC2Uwv57bbJGPpCqRLRSXGk5WR8p1p7IyGrIG3txNtqp4w/lU77EHiOsESjQzU2r0Kh1izG1TgUzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG9rXtGtOPe9Ne9DMxy+OXTi70yNoxrPzxcgnoQN940=;
 b=wKhRcMQnhgfqIYcjsQnnIEM4BRjXIdC5ifblc2O+adOwBcoscrGinQDJG3SseRm8OH9xmEIz7IvvLs0MkNHf07OwShC4BPkTVRC2qlfHcKJifd/021ZHp+YlhDSE3e2OCk/zJdzgBez9N4TX59rLMc3PFhmAZkWThI2dNMhdcE4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4742.namprd10.prod.outlook.com
 (2603:10b6:510:3f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 09:28:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 09:28:05 +0000
Date:   Wed, 16 Mar 2022 12:27:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: r8188eu: remove local BIT macro
Message-ID: <20220316092743.GD1841@kadam>
References: <20220315205041.2714168-1-martin@kaiser.cx>
 <20220315205041.2714168-7-martin@kaiser.cx>
 <20220316090128.GT3293@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316090128.GT3293@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e25b475-0c49-4b19-78e5-08da072f461b
X-MS-TrafficTypeDiagnostic: PH0PR10MB4742:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB474229E07A6FBC20CA5219EA8E119@PH0PR10MB4742.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkuHnArDW+g7cgdCSO0v2vIfo1pjZMH47zwLl6U/zeuC5BicjAOyKjW+ZB/oiB/VWuDqPpi6++H+uHtSOrTVYL0c174m6uxQT/6cEf6SuKbRi0Xr68YDdEg4xqdgDRrYb4IpsaFPOZapvk3QNF+dJ319VG2COUThBdbgTgI/iEzAUj/6dQhU0gtKotlo7iaWYhfIobR9YWg1ozIOi1X8wDQ7gSmXqa0U5LB8HhU95O58xUv+xZ6gki553Dg6Vxdq/rA1uV2qVWVF6QXYUHVELp7daqx39WY6cLInuFyKK7B6p9lkMnnmQAzcjMdYdCAYiepHoFjNoJCHYrjlyvXh8vyWQegbqB3oUfcYwDXqsBi4mpikntX8H8e889c4/EDbXbukZFVfgZ3g7XA1BC3FrkTRT3bHipZ1uIR6jCAxvft+xqR9jUeBtvsAsXFHAxRN2h8ByW/3ClrZTxciIeuzw27RVcgpxbW0LxVpORtWzXAAh6gOf3AfuqLU5XRgIDLpfvXWEFOvENya+PrwsCtJ7MqM4zqsFIi4cgRKxC5xFV/X0Nk8gVvarrmAWFqAI0EUL/BYrKN9pk/XsQXvrKnLmgyMoLaHRyuCfVqYBH6EhFZfM1D6ZfuVLEWlHku7V5rr0jiQPnl5FkxnuY0k1UYMJrUdwUW7rYJsDT/TvAFPzzZvoeN2JzBSX/FhQhlS+zpcEIQvu0y4z9wWVgIG0LQE1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(26005)(1076003)(6666004)(5660300002)(6506007)(8936002)(83380400001)(54906003)(6916009)(86362001)(6486002)(66476007)(9686003)(316002)(2906002)(33656002)(508600001)(38100700002)(44832011)(52116002)(38350700002)(4744005)(66556008)(66946007)(6512007)(8676002)(4326008)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3A7mniqLOV894/yH1EX8qwIqaq9RClh3qCGusMUpck8p5tN630heyZUxWyEA?=
 =?us-ascii?Q?xIEpul3r2iL8/nvVe6VLOL9gWcXPyEE9AlEspx8zdOdUJv9cXo5cQP42X+UY?=
 =?us-ascii?Q?K0Ms6HgKXHaYNF5FY+5HV/eqEEXO1uD9TPiQ9QLN2CVAvdUSWSYoaVBPCSKS?=
 =?us-ascii?Q?xri+8VnhSac3wA5yLoDlDlNiZvkXLgkt1aXT1yPPKkUbalHcQdAHQMyR5jbU?=
 =?us-ascii?Q?aOONr8MboOekKlXfFk62IuTSUSX9OiaQAP1WKsdPn2OzW4urHA4ey/VlUWob?=
 =?us-ascii?Q?5yo00GvAsMS1eQ7xjn2qoPw/g2quWV3KwlmsSSH+6X9QoYxWtr9Bl84jFF8n?=
 =?us-ascii?Q?PmTY8zAu5jMryFyvM/iHDUrfj05MVKVseFp7yOxGu7QT9XhZ3HFYxLLVQZcZ?=
 =?us-ascii?Q?ppff88YgHRLEXqIp7gJBvG7xqMURnMY+weDEoU8I5IwsfxqaEzZDBzW+uVNq?=
 =?us-ascii?Q?Tkc7UcaaGK2ba6wvI14Mp4pd/dl0OMaBXfpXYcBR7wvj9WbyFasLaUYQUfq0?=
 =?us-ascii?Q?L7fLT2IcI4Pd8igrhbUlkFEFo8QcEdKpEHRVjRTaNA57ZAZMW0cwdDj4S3yF?=
 =?us-ascii?Q?073yExOw23MH0fRt26hYUYVvd7Lmu+AIzGFPxuBiSY4oo/YOX7tcZ2n8a7IF?=
 =?us-ascii?Q?K7FnHF0ndEfRIiCkGmaZ35HF/KfmyEkfEgnY822RbzAhQPwiPBW6/p/q4Cm4?=
 =?us-ascii?Q?TOU7tvlYs2qrq0zuoDAdcC56e0JC+RLJymo02Vs/3ZbL3o+gyFVoTlVtyer7?=
 =?us-ascii?Q?pSlPorZ5UQW6Ot4QkZU/r+yQrjtFgAVfEngfJFILFCwYG5GYj2e0A7DB5kwg?=
 =?us-ascii?Q?MDHDaNc2ufZvfllruZKXKvWCYtBeGSh01NQ4JEJnDex91HAlEVdwpHEHQ5tI?=
 =?us-ascii?Q?cfh60ZPKB1rPTkleJKDsR3tK8wwb0WaXhzrTuTHQywftvMbyDzbZQD9a0kYm?=
 =?us-ascii?Q?uWhabFPB56KUxEACqmlrcRQvK/JbNrLdb8eVaVlIxbpSWSO+Pm0Yz1nT2mlX?=
 =?us-ascii?Q?Sih0cTfENIOiI5vD4daJUsFXtMLwQwn5P4vuYW7yUZrs+JCOkGLhrVI72fcj?=
 =?us-ascii?Q?8e7fnrfkWkK/rpDD3asTrKqd00IqvMt9TUVfk9NI6Vp6JvkhDNoP9/BIhcQQ?=
 =?us-ascii?Q?+Chm7LLq6p3wOJ93ul1ot7PMF4kEEBUL/Z3z8jKl/QJgIuRl6v0y0R3HV/RN?=
 =?us-ascii?Q?VDG3DVwSSbsGSobpEQ36zGj/nDgug3VnqnW6chIEjdkVUDxe1/7P6aqejA8F?=
 =?us-ascii?Q?b8Ca1MIN+bjsoI23OohgXGlbJKndijoCp+xf0blX6fq2auORdvCACqkOfsMh?=
 =?us-ascii?Q?h5L/Bif0HQ0RpIhv6nJ2jDR2eU8MLJRuEpsxgah7/v66UTh0Zekpb4w6aCD4?=
 =?us-ascii?Q?aqCF39iUK+tn3OaHncFmqRhK10ge22wUxxV4Ww6XZQqZns0qaGo+u7VQOqrQ?=
 =?us-ascii?Q?Bz1YLiBH+piqAPleGhQfeYktU1TvzifVt1gbWwu7uU6kwFmtnieVIA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e25b475-0c49-4b19-78e5-08da072f461b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:28:04.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQmY0NDcujdnb3nj9BNhsS/WjFdGowkbCo47XQdAmrut7owCYGGe61OS1aXBPWDvoUGtOx45J6Zfz2hNlSr/drlcHItBm6IC7V4iX+yStfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=799 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160057
X-Proofpoint-GUID: Wwohv9QGhfRyqP1_mSAwGBS4PhuLK9Mh
X-Proofpoint-ORIG-GUID: Wwohv9QGhfRyqP1_mSAwGBS4PhuLK9Mh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:01:28PM +0300, Dan Carpenter wrote:
> On Tue, Mar 15, 2022 at 09:50:41PM +0100, Martin Kaiser wrote:
> > The r8188eu driver defines a local BIT(x) macro. Remove this local macro
> > and use the one from include/linux/bits.h.
> > 
> > The global BIT macro returns an unsigned long value. Therefore, we have to
> > cast DYNAMIC_BB_DYNAMIC_TXPWR to u32 explicitly. This define is used with
> > the bitwise not operator.
> 
> It doesn't change run time at all if you leave it as unsigned long.
> I don't know if there are static checkers which care, but if there are
> then those checkers are wrong.  It's nicer to not have the unnecesary
> cast.

Oop.  It's a GCC warning...

People accept such absolute garbage from GCC.  It's like in Africa when
you get bitten by a snake they rub cow dung into the wound.  If it hurts
it must be good.

regards,
dan carpenter
