Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312F50B424
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446069AbiDVJd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446061AbiDVJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:32:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499D2E9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:29:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23M8bnxh019753;
        Fri, 22 Apr 2022 09:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=hxFdDCbuSjik6OXRzMcjNb+mVeu/KHIDeHxLwwAq7GQ=;
 b=Vhvf9jJlGNDt42ldTpDbxlV9UFy53WMe7KXIUIlHKw0WONImAUmsR6xVNz+Nz+hxgYvW
 9FaOZJpTj7KKK6vUxVB2rzDPaU3k1Njn2j4ydLdARhQ1KUzOtzX13FhqZHNI1yl7deYn
 jdf817unqMg6RUrFT2uAqnCgyfX1Az3F9YglumUuArYBJ+EH+5Db9yNHQeIaxdjCiPnC
 qM/sPNMmz0Na0Q8+ZrDXtG3ayYcdOlo2LJHG3rgpbpncspJ9Q8smHS7/JQVcG7LGmSH4
 guuMNx1MPkEhB9Q/GbuIKEneNcM8izd0QLUFHC4OWkq4fEeBxC3ZSjLmT49aM+zkIhgz ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1eb46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 09:29:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23M9H4Jq003613;
        Fri, 22 Apr 2022 09:29:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8ap126-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 09:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6IentSLqMnTNjSbdSw0auHXhAsSM99BwLl36zdB6e1lcnSY1Svms3jQ7E1ue9EagTvzDOvDiFpBAO1LzD9nZSS6w8KJh6gx3ussb5F2VYgYYhMLeBQuma4lb3BwZL7ByyIejKz6AmjoC8reKYvIElP2L5wTnLpvpwssFGmADwgIp0GLcWRO83y172ZbsiiewHhnrZWdPP+Skylpot35YdPeWau0cAqXT5/WkFHi3/a94SI5phcTqBTZMuaHn3V8Wbxy/XNgYUUkUvfrJ0v+m6eY4DnjiO9utN87rYb310zLA2EzTEqdXGJRJSrB+bhB61M4SFjq6Rj87i6qYBIgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKbN9XqXd/wH8kE99KFGGTH68yjJLxpX9yygrCDE3iI=;
 b=Xx3ydxggkDUqERpEtPS3vvmEIMwMzpL9bWcgMcRVOtYtgqaTuvPAcnDApeSfS9guLvkPXLtA3GHibmCrMv4f4vbMxPSoq/J+HZcuNV22gOtJIF/cPlMHsabcidorbItoI7JrlscF6HX9lY5aKSC8QndZOIEmpIydMsmFSOFG7pgziR0fK3CJ4pazRl1EmqbTZi/q5TOX1sIsw65GFmN+BLifzmOX6RP+9+GO+0V5pr4iqyz/xrfZpChAPoYoDKantcZ+TJ2Vi9R0YyOHfAA5/VINQKEO4P8NebMsQsxVVsMjQS4JI+UnJjbuw/RmcXKNNH0TCKo3tnAQB2zmnBOAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKbN9XqXd/wH8kE99KFGGTH68yjJLxpX9yygrCDE3iI=;
 b=NIKM4nv7D9xLQLS3hR4/GOYJ2bY8V8XvAgLVq2qTS1nj7zlGEoUadZ6Esa4yz7yOX7YRSjHpCzePjNuhvUVDab2WCvx15x8HnNJZcv0aqFOlsV49+NLRPP+Sbvh5cBRMrGHfne7fSNQ5jBZLHPM0scG3iBO8t0JAI45K9E9jWfc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN0PR10MB5982.namprd10.prod.outlook.com
 (2603:10b6:208:3ca::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 09:29:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 09:29:37 +0000
Date:   Fri, 22 Apr 2022 12:29:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho <mchehab@kernel.org>,
        Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Hans De Goede <hdegoede@redhat.com>, ira.weiny@intel.com
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Message-ID: <20220422092915.GF2484@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com>
 <CAH1kMwT0gyQNB1-j62-2ntJD9Lobsmr8-5h6n6-SJ44wykMyHQ@mail.gmail.com>
 <YmJGzwA0kD+lFtfN@kroah.com>
 <2181149.iZASKD2KPV@leap>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2181149.iZASKD2KPV@leap>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0052.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0adf2bef-1ec9-4560-0449-08da24429e95
X-MS-TrafficTypeDiagnostic: MN0PR10MB5982:EE_
X-Microsoft-Antispam-PRVS: <MN0PR10MB5982A529500B35024D76A8188EF79@MN0PR10MB5982.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQsDSXXpn6BCdZWbujAI47KOsT5zM7rnmoou1ESmSndN+X8oH7HS46n7rPrf+2RKsGeYhaLGEbNAtzuHXkPkAIVrkKIGuQ3ZLzMkCMqcrCr0+akOy9ch1P9OBo3uDrkzyDhzQVw164Hc3WHvVQ8IkqO06eq97qR+L68VNrMw58j6jRs+nfR+or9sz/Up4wBKdy0gjCRzd2TFpaHU2IYH9kGwECXHsYj2XBzSrjnFHev6iZJagE0aXBNybNOSeFUnvOpLMtVid1DOvtH5ShjMgFgbhAJjg0FEts+oS/7FSDyg91Yg25/5beOWgkxjF7oolvKP2Ot/O+v+qYTKSlL7m84rkh6pA6ooKdz350U6/Uybw8dwmnjmzYjTra1Ug88tfkM+sN5Ik4zfGtiX9odX3HnyP5pFbZcw7E6U+qYlWMyvos8s9uVWGWoQCUvsCw8A4A8ZTRsbx05aZfzeSdbnCFWPceIahl7xOpHWcnrX96KFPFNsI9dDcAUHc5vKWEzwbBNB1IXRn6ROrcJUdtmuSuZ3PoDFDGuxsHf5jR1gnEYTn7aHOOa56MIeNfls78vMHS0LfZf/EivbDGci3vV9ak6vHHP66qh7pzP0O7CAqtoSdzXleC0S+EBcdyb4EkhtvX0/KowuUhRhj62GoL+koqy7keOLiLCJPvbwy4c2ams3og2hImRd/ABQCX9H9MxAFkeM9j3IA001JVnVemhLwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(6666004)(4744005)(66476007)(8676002)(5660300002)(2906002)(86362001)(33656002)(33716001)(9686003)(26005)(66946007)(66556008)(54906003)(7416002)(6512007)(1076003)(6486002)(316002)(44832011)(4326008)(508600001)(38350700002)(38100700002)(8936002)(52116002)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SDGxJScxjsKMAleaInlwX52zmF59q99/OBCaaFviUHqQVY8kIdA93e0ZJJ?=
 =?iso-8859-1?Q?cOO847R6EuUr4IDPVQJvF4yl5QHbgB8FnIQz7v2ISVNdOT3lhgs19GpBtp?=
 =?iso-8859-1?Q?Or0EtKwzBWEPLMnj6xr35jNnBm8VKHCxoHcLS7WbA+Fjr9aTgKF/mYoqLO?=
 =?iso-8859-1?Q?pbSAHCIqmfYAviLM7N3RZD9HzeWu44LzokVklrC8jmjUvMH+llKNbXl5Qz?=
 =?iso-8859-1?Q?xYMGzoM7RaDeMg3TL1OGEKqj+LSKS9xFww1tdUGlZNU1xjIwU3J3/71KeI?=
 =?iso-8859-1?Q?o1URWqIh4aD/yGJYlIhky+DIR6LeV1qaNDVpYYm2ep2sUhVT5aNeLFh/P5?=
 =?iso-8859-1?Q?AmZp9LobY7kgeBNH8JGrTyT4iVYtt2a9uKP/iUmVUQsIZu9QsJXosdByFR?=
 =?iso-8859-1?Q?hvd6QNkoJ+8cl5JKEu/iz80yCHW5WOxbKS853LhbU/EUeDo6U+53UEntVi?=
 =?iso-8859-1?Q?I06zoHY9Hf1fLFJMf3uLZFLfsOljtHneYguF4mdWyAM+rxhLHGdvhwgqGB?=
 =?iso-8859-1?Q?bZbVNv5IwgZScJLZkMXKAs8DKeI0WTfulHz+kds0xg2jGKWD9egUcbzGah?=
 =?iso-8859-1?Q?dpclvJPIBomSRQYVUBRgTfsH+lBQK22P1ZjV5RoEkvKiWMAqtdr7PHs2CI?=
 =?iso-8859-1?Q?QwdN/Tj2PsztP38KHEdb6LJOPrMpN2tE40XKGMM7QP6HqMd9cPz027lgAl?=
 =?iso-8859-1?Q?WY0tABGgKTI6wqtUPutMYKAN+Yx4uXMwHpoLy6O0+RhrSDwsuKBPGRlOoW?=
 =?iso-8859-1?Q?YBjNWZVvD9RTpARSw03Cq4pPjzlXF66koPbMVoDfqrhsG/p/wF1EgxxZAI?=
 =?iso-8859-1?Q?HBD1c0rGlA2747pitXC3/qMXYY4gyzLiFxURT1LbCi2MEnsEuVlDmrK4vr?=
 =?iso-8859-1?Q?nL3YT9u6KtTtkqB2xxdc75Ki03XhZlq2gSJodmTG0vq+D7LFQGp7kp3+t2?=
 =?iso-8859-1?Q?nelo5HpUiS+/S3JRT06R/gQPKZDTE7BSHFjcP8eUcMFZhFtQ9Xg+i/IJ7+?=
 =?iso-8859-1?Q?SXF1ws5t1AfNmYNAK5OtCGF301IakY5eEEWSKj5fJmrU1sCi0OFjm6iv7O?=
 =?iso-8859-1?Q?/qbkC8gPHnYcELKgXXyKF4exJHObiZhtLe1h2BfEPqhW20IMwHMJTlpkOo?=
 =?iso-8859-1?Q?dZlNqdarVCzRB16a93LF6gAc4bPCKi68TUyI+lWNPFi0GQH4i8mgOkc8rJ?=
 =?iso-8859-1?Q?+B6zZNYdgM3teUMln2wHlQxfn8l7wK5S/YaHw+PBWiF1gGdE0eSZFg40k7?=
 =?iso-8859-1?Q?kt7ykd6gTSu4sy5iGkwPWsiIGEqz8KmoQ+ri5Xlks79zyHauUm4gBKF0tq?=
 =?iso-8859-1?Q?x+KiL8oKzXD32J9SaEHnTyneHHCH1PmALayjisa3vGi0rXmDYHGnB8kT/2?=
 =?iso-8859-1?Q?Dp7soObw/qn9ZYEiDotB3lCFjnaUHGzFtwFcdgio3lJgbvB9Qa5FgjIJEA?=
 =?iso-8859-1?Q?RlDKGoFfH5wXFpJH4eewu6mWxdaImPjSe+dvQEBdrJ7AKlRXqOWlhSmZAW?=
 =?iso-8859-1?Q?EHZcB1mkDANQGgb8afffQHhXfekYO5oo1o1wf/yGqbshkQocblMo5tarKz?=
 =?iso-8859-1?Q?kh9DGNt36WLon01NMdRSV4rQGo08fMk8JvQNQF4IXQwx7nb0+Ev6+Mq5vp?=
 =?iso-8859-1?Q?0l3VV28+YXdsjWBUoQ0SpWvWmPei6eaD9SDhsYVfZbtaj0FS4lXiuvm6/7?=
 =?iso-8859-1?Q?MCqxO93NDzCEkHcLcPMeiPfhkNo0n4wpMYq00d9fSS5DPlloCVfJzULMew?=
 =?iso-8859-1?Q?0d+l2VOG1nvkYmea/cyx+dq8hy+4v+8OOOAiA9yn/lG2UGVH2t8gLP4FSJ?=
 =?iso-8859-1?Q?49RUo0wfpSnuChA+UkqFNngvGF5zn5M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adf2bef-1ec9-4560-0449-08da24429e95
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 09:29:37.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvYLon476ur7LcWqcw2SD2OTlhhA5uwVgrPocCCPP/H+4cUlJfBsufN8Q6gTNBJs+IuTu7gMY/CzXRCZkRyuV0aojMycx1gyRVGBN+r/8QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_02:2022-04-21,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=949 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220042
X-Proofpoint-ORIG-GUID: 5NhwVHsXiOLfvyQsMi-IbAHRrLjps1NN
X-Proofpoint-GUID: 5NhwVHsXiOLfvyQsMi-IbAHRrLjps1NN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:21:21AM +0200, Fabio M. De Francesco wrote:
> On venerdì 22 aprile 2022 08:10:23 CEST Greg Kroah-Hartman wrote:
> > On Fri, Apr 22, 2022 at 12:26:21AM +0530, Vihas Makwana wrote:
> > > Did this patch series get lost?
> > 
> > What series?  (hint, do not top post).
> > 
> > My queue of staging patches was empty as of a few days ago (it's filled
> > up since then), so if they were not applied, please resend.
> 
> Are you also talking about re-sending patches for media/atomisp?

Heh.  No.  No one was discussing your patches or anything to do with
media.  These are for staging: r8188eu.

Vihas, please put the subsystem prefix in the PATCH 0/7 email next time.

regards,
dan carpenter

