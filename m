Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4D49CCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiAZOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:51:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36406 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235611AbiAZOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:51:04 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QEmS7o007700;
        Wed, 26 Jan 2022 14:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=frOjIbXg4yvtOBgkWUSSqCAbsFez5rWLr/jRbi5w2N4=;
 b=XeAuRDpVRqe4Ah0GBjPNO7UubB/9GcT2jSkr0eaLmKtj4wVj10hMFW9QNPr/2axEp9kk
 xlZ2UxMoDgDY89mujvY1JWgkuoku7cOZ+Ez2CPHKSagbDhGR+tTkQCAhfgT1ZRDuBNoD
 sdPx3cngQDIRmn2hyfPIkcZPbMfQZTIWsLvj3Xlrwp4+gdHu7KimjyvfffAxetpm4sKs
 MDFqeZCHzbn/VPw/Dvz6PIrgof0DzmQwPAy95Yu1+JIxPURtoM+egBFISKuQVDD2lOSe
 6Vs1tV64+G6taQfLf3yYS81mYXQpGARc1uoQnYUH8B6niK+YnOgjH9eSSVZbaHVubZ5M Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s66nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 14:50:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QElMsk103355;
        Wed, 26 Jan 2022 14:50:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3dr7yhvc43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 14:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFxf/EkWO4SKXePZz2UbE0JhZt7+TSHrcrlWtif65TMJgyPp9iVRhwiD5YwcdS3ZjZSpNjA1wraZd1bUE2YHNKfLnx9IdwLVdY5RrIeNla1qEImLsutbp1wwJ6Lcy2zoa1r3x41Se87LY5YBNk3LQt1mZKT2vh0h5K03L+b3Y0AcZNqhHWz8tzNJ1sj276pBgxEE30YNoa2jC6yMX3ejBD+D4WGFm8GqrQ5r6E7FvCLBqTn+L8zbmptSZKiBvesejUkuy8eHlgkcr85Tw/JPr2I9nRO7d88INmj71Z0d0HdOIdkm3KJ4tpl9Hi7HFyqQSOnbLL4t63ZO9ZSgiQ8KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frOjIbXg4yvtOBgkWUSSqCAbsFez5rWLr/jRbi5w2N4=;
 b=nQofE1+bQ3N2J8009VSk7mm47jfmYbw3CYpj7lXBHBtNZ7NKaN6P9rCQGNW/fzjX1KBcRN1UIkhieD8+R6ZQJOgc43l0/M5+n1+wmYIOlpnioZGz2YSAMFVSLQoz0pqYgz0kY1gPvcHcU5nuhrJPKN9iim4RjsXqJwJ1EBAI4parPiCb5WRcbdNGYZUTh7rmNOlQluyO2T/J1LdVUk4IpyF/u5t8HWhTGZLFW5ZxJSeAQQM3F6HZNn67FbXS6L/w6rHQ7q7Pn4puXilUPayAVWBflifZpXJFV8QPa42HzzRkwUaMroWai64wIFKSfy3+D95zgNe0xXrjTUNCuzHl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frOjIbXg4yvtOBgkWUSSqCAbsFez5rWLr/jRbi5w2N4=;
 b=WIUJM4VfsDIGo19wCcqrL6OOz12edVaTZB85+XDbE4Ie7BS18PmKfolqPr0AgawytPJ39naM0rQLZs4d+S5C8YDfPA6k7OG8oAwpA9JR0+5yr01uQegVeE5U66+4RgabnW4ar7xgcavZLn3uU79o+9ybcg9xBC+1xlCYYsX64NM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5718.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Wed, 26 Jan
 2022 14:50:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 14:50:40 +0000
Date:   Wed, 26 Jan 2022 17:50:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild@lists.01.org, Tom Zanussi <zanussi@kernel.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/trace_events_hist.c:6174 event_hist_trigger_parse()
 error: we previously assumed 'glob' could be null (see line 6166)
Message-ID: <20220126145020.GB1978@kadam>
References: <202201250054.975KVd1O-lkp@intel.com>
 <20220126093918.268d0e42@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126093918.268d0e42@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b5bfe0a-ff96-48be-6325-08d9e0db388d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5718:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5718B5E32590137DF1E91D5E8E209@SJ0PR10MB5718.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkyssFx95WwxYH/M6mfD69r68Kic87Yi7iZFTaOIQN5LmGVTvLWpvIKZkPk928uVc1pRidl3N07SmpP5DzkPKUdQPlFvzfYd2dz2FHnmysqSAJacKwu17GNd4ST3AYth1wboV9jzR15pnHwFRhnkh+nP/IkgNvMyRT1HUTcGebxkXmB0rB+uDlOgm0ngowBPNjNhuPqTYClC8ui+LyQAcAeT8j3Lqe7Uyy1teBr2jXf9sAZtNBrJhnkQyhYdZuINYxe/Y0wx6ZjqH3zlZLYyNmtO+/jQy8tGDCNEi90mTLEzCo4lG9kxg7s08i+2R3No3UPjPsoR9kQIOnlqwc/sNr4YoCKeT725oPEOsPb3YURFEfKWQPI9vI0/w8YofXRK/08wmG5xX8aOtCE+g1SS5Nbzw2yw1HQzpBYjDKGdhGvxCWVY6i1B2K1O9NnWwJCGJvjpLQOaLwIEFDrlFl043nL+NZML0oKkGzKyzo15W23lRIRt2HC17jRKQjlvsmCdgK0HWt6ycJeg4Q3u5XNAlwqlpBZH5w8pYS/4Xc8IYACiYG/1LpWmUvw0iRJ6FlF1SdzrBQC8q+fg919YK6ihZ/KSdZaEFU2RO1Qx4cY4J1WHby5z2yQyjmsJKVxP/90EaOK+4QobT4hVadE1ffcHcWNitxZfSf9xQj6VWg0JuXAwQmDhjhJCXVtvfzK21APZY+2bLYTmD24IbnkoKHGLmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(38350700002)(8936002)(6512007)(1076003)(44832011)(6666004)(8676002)(4001150100001)(508600001)(6506007)(6916009)(38100700002)(186003)(52116002)(9686003)(2906002)(83380400001)(316002)(66556008)(66946007)(66476007)(5660300002)(4326008)(33716001)(26005)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CWjMDYvRYlz84eJfKYdnrDR1Wlm5QdhtThRdcIENZaYRKjFc7boPl8mtFGec?=
 =?us-ascii?Q?OV0fX9+smzG1zOA6T3Qnf66nc/sqR/QSoTA6ofObotm9ng2+HmQ9TLkgIgw5?=
 =?us-ascii?Q?jtcxMGO+dtZMIma+JCQoSyyIDy1N44U809rJTHknPtVV+PfcK4PqVAhgPUUU?=
 =?us-ascii?Q?xNba9S/rYJTgxaMwGdkXmmkgkiMRASUD5Na0rNJB6ltpt7XLurPTB8wCSYIb?=
 =?us-ascii?Q?3E6mc5aTgUdZpvqsOMXzN8ZZbmEEeldAq2OMJNTMaPLgX68IkuoNmW9SMxJD?=
 =?us-ascii?Q?N4QbJmrbXkVHUpJnNQg/kVVxOkAdypVYKm8qkGv9hAAvmTUXJvgaRWCPeJTG?=
 =?us-ascii?Q?HDLzMlVF9zcrYyvXWGd3hHE4tkG/vxDjNnZ8d6baXVeMNFqL6Mf4N2rZbfKw?=
 =?us-ascii?Q?pezO7M1g+ah1lycQZ1x9aCbkWh43/diLwVJSmHUXNLTPvCkwNThdx65p00/j?=
 =?us-ascii?Q?Nqn/EByNDe1f/AFo/onGa65vZpRyHcRbp8UhbeamWwz3Cio8U1VyckWSvjDs?=
 =?us-ascii?Q?E5oDcADvKBplLZu2T8xFVgrkRTuuKO68sbUf77Ib0RVHCkgdvoO5RaxkAgBu?=
 =?us-ascii?Q?yL0Rrncfgvs5fN2OKQadrgn/QWeieADq2sCZANNG8sSvwFodCCh4fZ+3nEC5?=
 =?us-ascii?Q?3+vp0St2bBSh9fCls6o7A/zeZ8JXqFuBYRYyctuK0uhnMt6QqxibVBU+4gEP?=
 =?us-ascii?Q?RL+nNKGMa4bNVSbVRYWsQLNStfBAC5oJ64ESVztP6qmd1G/wAD8SdHBlBCUh?=
 =?us-ascii?Q?3CIChD87+VIGFBZ2FQYjlN1i0cozUfYcBoPprHB1UJNPF1XlEY9niKAJzLZU?=
 =?us-ascii?Q?AYFiS7486v1RJHDqCPPc2XFCY/VD/Rekjb0gjaj85nUbeCVzsYjnRczGz92I?=
 =?us-ascii?Q?2aDBwqY8mxlXIdbJWB/aDgkXVF0AmVlZivvDdqlrjNm9bTYqAJu0g6yO47ce?=
 =?us-ascii?Q?TQu34lYbIjrhnXVOlPKKWjpG1gM3raMlXndECOMoah8BauqK7iYpNyLXpOWD?=
 =?us-ascii?Q?VuWAjr3yHcmnBv0qD0ohq9UMTmgMJDxK4TjwybMq+n/eavByv8RoEM1NjjO9?=
 =?us-ascii?Q?VZMkTepc0c8Li5hmhhOLupG5iZz/kiEnyY5R6we4wZHj4zLIkEUbFLbSIrGa?=
 =?us-ascii?Q?1/6lpQgQ+I+c9cGNP2c/DFcQSfCwha8MQczZlVvRngGlq+MuHXRoJ4lj5YKV?=
 =?us-ascii?Q?gzhyGco23Z8iiuhKtbU9GXGvJ7UeEK0Z97oa2WCCUxpvWi7xjRC7+TOyZteo?=
 =?us-ascii?Q?s8yaO6MOMICuHNM1W5ONA+NESIeKYbKdSsmFe8C9EwfJCOmbkv17zDpovoeZ?=
 =?us-ascii?Q?VMDOoMCYKLrtiIlR+KibpqG3k8gglsR0izXRnxmBAS2bW7dElXn4R5kBuxrW?=
 =?us-ascii?Q?7GpoEr2AYv7v2Ff1FTbVwIr2ksZITmhxc0QBkkWiAvK3dhy73lNRbUrIclGR?=
 =?us-ascii?Q?8FrY88EkUhCVQLSxVrZJHxX37C5ojQrvW3ufKR965SjZqR1NxF2qBmzFux7D?=
 =?us-ascii?Q?WQgmh5BDEt8evF1vpnOrjcJMeI4gxOvneJeUnJlthFWJKTIr/+igpOMSes0j?=
 =?us-ascii?Q?8KjzYaGVGOoE/YvT3TTN7PxGkvoSWcAyRd6tndAffQZ+yu/0BihzVoMHms7p?=
 =?us-ascii?Q?5QffFG9LkEjJcd5gug3AYPLumQwxlo+6YnonFVQ3v43R3XQsyrzZDf2FLnpy?=
 =?us-ascii?Q?MvLJn20yWD+BdI74X+N5KTsOlUw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5bfe0a-ff96-48be-6325-08d9e0db388d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 14:50:40.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNgq2hVDtBougdx4OzBwmqIQlgTH7C1StIuOKczLWQ25zrjTz26aOvS7iHRRhg0pRW9wmU1Q6okSuzh7I9Rkwd2r0qp++jYm4uZC8KWwdJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260091
X-Proofpoint-GUID: H13DZQuWSCdDeNOzQaBzdedckK8Pi2D6
X-Proofpoint-ORIG-GUID: H13DZQuWSCdDeNOzQaBzdedckK8Pi2D6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:39:18AM -0500, Steven Rostedt wrote:
> > 9ec5a7d16899ed Tom Zanussi             2022-01-10  6149  static int event_hist_trigger_parse(struct event_command *cmd_ops,
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6150  				    struct trace_event_file *file,
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6151  				    char *glob, char *cmd, char *param)
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6152  {
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6153  	unsigned int hist_trigger_bits = TRACING_MAP_BITS_DEFAULT;
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6154  	struct event_trigger_data *trigger_data;
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6155  	struct hist_trigger_attrs *attrs;
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6156  	struct event_trigger_ops *trigger_ops;
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6157  	struct hist_trigger_data *hist_data;
> > 4b147936fa5096 Tom Zanussi             2018-01-15  6158  	struct synth_event *se;
> > 4b147936fa5096 Tom Zanussi             2018-01-15  6159  	const char *se_name;
> > 30350d65ac5676 Tom Zanussi             2018-01-15  6160  	bool remove = false;
> > c5eac6ee8bc5d3 Kalesh Singh            2021-10-25  6161  	char *trigger, *p, *start;
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6162  	int ret = 0;
> > 7ef224d1d0e3a1 Tom Zanussi             2016-03-03  6163  
> > 0e2b81f7b52a1c Masami Hiramatsu        2018-11-05  6164  	lockdep_assert_held(&event_mutex);
> > 0e2b81f7b52a1c Masami Hiramatsu        2018-11-05  6165  
> > f404da6e1d46ce Tom Zanussi             2018-01-15 @6166  	if (glob && strlen(glob)) {
> 
> I just reviewed the code, and it looks like the logic should keep glob from
> ever being NULL.

Smatch can also figure that out, and does not warn, if you have the
cross function DB.  Unfortunately, that's not feasible for the zero day
bot because it takes too long to build the DB.

I was puzzled why this warning showed up now when the code is from 2018.

regards,
dan carpenter

