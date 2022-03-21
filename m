Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FC4E28B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbiCUOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348468AbiCUN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:57:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C294174BAB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:55:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LCwOZf001109;
        Mon, 21 Mar 2022 13:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=LojAHNHQAO2wcQ8UjhROsifyzn9vDUjoeJySsg8W6tA=;
 b=Tt22W1rifVaLx1x3OAsAABHITtxbe6bpdWkKNftHfqWpnuiTETDsmM+4p3hz1yHllt74
 RjLB9ooha9YjE4vYpJNmgeAghYDiz6Ryd48ieTbvQ+nfD4dGPH+m//WKlPzkOmtIBsKW
 qUFSdWPAXVaAc1+vWV+zimBi/AomWxzmyegLl5Mt3Sld/1pFGrWMFamIlTzH1Ya5+tKE
 K5Y6Pcvqr7Qa1qT36G5vqSz0COayDfCy18NDXIYfItEXHm/DSlBrmSuOaRJzHUjKB4rl
 3NFzPNUqQGk5CXMDHLwQdttdpOQBF9fhJiQFZ8Zl+s018PFU10wOE69fwKPjCQbKglVe jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0kc67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 13:54:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LDpcAt021337;
        Mon, 21 Mar 2022 13:54:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 3exawgs34e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 13:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KezjEzy75aszvbHCwLqzV/gz6bbRyZ6mGckfcrZOByb8bq8vpe2KiVApM7b3zkaiZQyySbFrwE5anlsNVxWxSAyoAJQlCuDrs63bpDLxLIn495oF4Uttexl96YC2+5NC2+eEtuS8rHpEUiiXTvGrcuYF6v50c4GpuVCzhQRoKY63wA6yNhvsc1AD0tXDprEUAFdHbJmXwD2evyNjWnMll6FwS0sH8GSzwU8DE/+vwDDfo32CfKKfgF4mEsYDbvDGtvZfOYv81h4/4tHP32mo6yWPBg/GlhQc4+3WBtHKMRcoE3g/zABXD6P+wqzhnpyDWczOa9zrS1neDDbT/rpb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LojAHNHQAO2wcQ8UjhROsifyzn9vDUjoeJySsg8W6tA=;
 b=ZBSkungWaVUzCUjYxPc0ZfkTzdYXcl0ek1f1+xqMUfd2KHFXs2HXsK/L1C17st3dUpY6P+0XUQ1ADEMyf+fAIH/UBVnMuOPXXoDTC6LYLaVOtziZHIzEn0sjcD8yDnPHCV2cYwG4iYN73KHpdZ9Hi8gi4uU3+REkine+2YW7qROTNE66kV2i2T4TzyDisfxfzqiBnLnMNr1ZFngQmxeYO2Hl9wAseaLWXUSSdpyJQUx34KZkXfg4jbsMgY6V/l4YTkA4IA/MqSGFd5+tXLAc3Iyz4dracbZJdRDkRSfDJRqcc/XDYjqYbK6sZO0pw4wDzB7UIa5SY2yqK+++i/PUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LojAHNHQAO2wcQ8UjhROsifyzn9vDUjoeJySsg8W6tA=;
 b=g+JnQCnJ1cbAN42IBGpHvOxZ6duyG2fUnYEVy/gNj+lvx/aT+adPjO+m0SaOqzy62h6iVzGEnexHV3+sRuvTAmuIsikIY+bLGB+GTZb7UZ9x74UEpiQLL4vVxZIPHwILgpgaF4kZkxOaf0eWJhZ/Lv+OaQRNOzawgpHr1f3rcro=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5462.namprd10.prod.outlook.com
 (2603:10b6:8:26::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 13:54:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 13:54:47 +0000
Date:   Mon, 21 Mar 2022 16:54:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] ocfs2: fix check if list iterator did find an element
Message-ID: <20220321135435.GL336@kadam>
References: <20220319203106.2541700-1-jakobkoschel@gmail.com>
 <abcbf5d2-c348-7dc0-cfd3-9bcc6431bc64@linux.alibaba.com>
 <A7AA04AA-6B4C-4211-99A6-0D3C04ED7B26@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7AA04AA-6B4C-4211-99A6-0D3C04ED7B26@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1fb6d59-aebb-4dd0-59a8-08da0b425c15
X-MS-TrafficTypeDiagnostic: DM8PR10MB5462:EE_
X-Microsoft-Antispam-PRVS: <DM8PR10MB5462274010DD9C30B90B3B5D8E169@DM8PR10MB5462.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZhRQhgLo7qmneEuIp1ILXvkWpHUhB7iK0Wa9vuIS/3q5fAKZ7LDahjOQpNoo8UBXgUc+KVVYdd08OqzcCxE2C2xNRfOEQ+BczsZxudnii2O6YE+JMZIgJccvE97bkJhOedvz50anZRPfyGvomn5hFnx0HQSqmWQXrBqHP12WfWZ54feq0Uy3fNobO6T0JH8Sk8J/YcAO/OnJFfQgBDdJjbDpBCXlIZ5WPEyCjjJupvh1qZuWpbQ2MmyV61uEqgHaep4v9ftb7LJYexBO4qjnd/45bBTeb6FIw9KYrYbsspJVVkZdIuUumX2Kq/fg/TabGtvvkWPjUJ+md0k1AkDnSlWl+08JTmoBiqJn3FSojUuaaI22KLxSmIR8VYaK6c1B4+xY6oKTeTs0yW7fPoT7UMBjRAxLKmO3VBiTFZjnOHChsrJxEPz35vpCtKZidzcH76DVVHX1EY5DQt1qpMjFtH6NSYZhscOoKqciSzV7ZNPeb+frlbQBrpvyCn81+AlymRZUPzL8yvV0UF88guD4gYihZBhDMekaPwdaaVsqhveqJSwv/jndMLwstAZ8p/okEybcxSopfJzBZG62sX6iM1+2SpkJdTl0p+xq3EeBCErpJ6W7qqyWoVykjWfMMpTfRFWWMxV4AnTko6klqEuusEhX2XUjvaj3/FGMdiFTSH0uLNM5eYhtoY6QlSTntz3VidgqICrqU1+1V/tZV9rMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(508600001)(38350700002)(316002)(6916009)(38100700002)(54906003)(83380400001)(66556008)(9686003)(6512007)(6506007)(33716001)(6666004)(26005)(186003)(1076003)(52116002)(33656002)(8676002)(66476007)(66946007)(4326008)(86362001)(44832011)(7416002)(8936002)(4744005)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nv/11lVbF0/3RGPflPIzMAZC050S83HXckdna7h6QpdAjBc3ofW1XHEm9YCQ?=
 =?us-ascii?Q?9wEbMj3e+H8bT8EftTBNesyfyzMCx4mK80tQMMkJU9VH/hkaFK9qJ314H51o?=
 =?us-ascii?Q?CrK/43xbdTe30bubGxOTvlAzNDdNmhYRuOQuY+EuY8e84M6vWTQa0jnxOOUM?=
 =?us-ascii?Q?SDMd3ZmNdMFCvlt/5DDnmXWe3XrfRpuf1GdQNAIs/9GqfkUZVzV2a5qq+AfV?=
 =?us-ascii?Q?8vtEl66HIgvEi9ztV7ItyTZ+qNRUKhvwxSZQb9U5WbN8klXsNAU9ScYr2D7u?=
 =?us-ascii?Q?vyfNZFcBryLahwqliKfO1+2XtX+zEE6pZ3qlxrJNtxjckQl4oXgnj8t/6pv9?=
 =?us-ascii?Q?y2dzLmdSp4jFpDq7KEo03CY/mn2DJUARGQweA1WajqfEaPuF9i9cdVxvNqTF?=
 =?us-ascii?Q?qDc7l5YrihezLnamb205lSzuHKzp7hpjhV+8U5pfc5cZJsasxJWZVqbjjaWH?=
 =?us-ascii?Q?0N4ZIZ5PhBOAIaVBbB/5IMAuZnPWwExtP3cAzRoMunlEjaJwNplt0llpdYih?=
 =?us-ascii?Q?EmbZPXO1rZoy7sQEc+svQKzrXqrlW+TmPOHuRO57Hvw9+TH+IK50fsUpdWzl?=
 =?us-ascii?Q?KDguYc8fY4a1wOloM9HeWv3xpXNmG0K53Tx/+kaHwHxoAOXIho7eqfbD/VSb?=
 =?us-ascii?Q?uX4BFmdPf6ge/eRtGrClIxilPUDzu5+77UvtA/4XpqMJSUnzfnwULfiE1Wg0?=
 =?us-ascii?Q?oPPK7U0Q7U9KGTLx9mB/rGxRqWD0ShydBv+2Qs428d4O31aV/NO/0RiGtKln?=
 =?us-ascii?Q?3AX/a+M8oWj3LPsJ209sEhQOsA9zFvrwdiqLFrOBf9Xb/J3mP9LLub7tn7AG?=
 =?us-ascii?Q?MyLsCL/vy7YK2M/T3iZYp8TX49kdV7jtkj9zz7HgcQ4JbDgnWMOl2SugM1gM?=
 =?us-ascii?Q?CfSzUQ3Ev7cI+yJopWxVrjFoLDPxuqzOTPGyl4170WdGIx6HSMgAZpv8sBgh?=
 =?us-ascii?Q?RBIm3wK1sPvA6sufc/8WQpqHexv84FS2ELqCEjsbeb/OTPyAvzIwsxnYV0A5?=
 =?us-ascii?Q?WR2TqyNHQeORFTn5ZLCtjHxDbEIdj9pRLZ6O7ZfrAbViHrlLC21aKPg174fi?=
 =?us-ascii?Q?tGjDeGX1MHZ8ThWU6W/mWq/rxy7DRH8f6e0EiQzRN3YyognwIMBkuIJhDaQ4?=
 =?us-ascii?Q?cV00oQf8oiDMoOnNIPAX8qBRfr8cEqPPqoTl3RUK9k3HzAw4pdtk8BFblQby?=
 =?us-ascii?Q?EaZ7BzEkuRO5Hn4FJcftAYG8HTNRsDtghiVdyQxx8PLrdoDtIiLgZkzEZEOy?=
 =?us-ascii?Q?vCgxU5rXq2uxPeLejdfMX7tbQ6ZR5s7UhLeLiMHXpuSZWubaoFfXXeeqJzNW?=
 =?us-ascii?Q?FOhSyffar6lvg8xI3tAnP4HSJI+T3r7DALkqCbyVaum5ByodPRuDzMXP69xB?=
 =?us-ascii?Q?INH0B7NOBRxUygRCfz0+x7bVmUmasyEPsSmGaqUMkyGOSDuStgOK/MlWG6ai?=
 =?us-ascii?Q?s6yd6sJgex1j/0ZDitui15WKdcJKPBti/IZhXkkm6jthIRtukNYUBw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb6d59-aebb-4dd0-59a8-08da0b425c15
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 13:54:46.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjg2nBujdSPc2GEU2wpI2lZ5dmc3VWxVTLTi+03MJkEsMDluitCL0caZF1tQIUOj0va+dH45xp2zfBvDF8OW7zLEmOh8Tm9kqINy1sl7x1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5462
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210089
X-Proofpoint-GUID: yjI8ed8unVZUfISI_wGoDTtO7T4Hdg7R
X-Proofpoint-ORIG-GUID: yjI8ed8unVZUfISI_wGoDTtO7T4Hdg7R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:34:34PM +0100, Jakob Koschel wrote:
> >> @@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
> >> 		}
> >> 	}
> >> 
> >> -	list_for_each_entry(res, track_list, tracking) {
> >> -		if (&res->tracking == &dlm->tracking_list)
> >> -			res = NULL;
> >> -		else
> >> -			dlm_lockres_get(res);
> >> +	list_for_each_entry(iter, track_list, tracking) {
> >> +		if (&iter->tracking != &dlm->tracking_list) {

This is an open coded version of:

	if (!list_entry_is_head(iter, &dlm->tracking_list, tracking)) {

Ideally someone would come through with enough confidence to just delete
it but the second best option is to just make it readable...

regards,
dan carpenter

> >> +			dlm_lockres_get(iter);
> >> +			res = iter;
> >> +		}
> >> 		break;
> >> 	}

