Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A74D2B11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiCII5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiCII5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:57:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C1162008
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:56:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2298KOvn028053;
        Wed, 9 Mar 2022 08:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IpVV+g01xGKSlOk5b+x/4/541M0SG89ZJ957wzhGFVs=;
 b=nsmaEKcHuF4QC3RI3g+vAhiZDscKeb7SHaNqHPMt72ul5eDvU2IbdpWNyHmtsqvsOO8X
 tzdr47MdZkexu57rV81QZHAu5OhDeAutdSAb7QOClJ0oIdkpn0AfquXM+bnvysPxjR8I
 yuS8dyfAex6JNk/CM97bHO8/A1m6WGNOLgfJosRsGqGXM76ej3tDg8BY8jqmtgRGYUvy
 8UrspNPatHv3icd1PJ2+qgzk4IlprEI8927+CQiYirakE4Oziu7oGdTd7Q+667nwmvqk
 DfX2idC6PqOXWacLrijUytXFqazm+eith0zlA/bwtIi1GPewMblKyZLcjllOI6Se0wJc hA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2hgtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 08:56:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2298ucwD168158;
        Wed, 9 Mar 2022 08:56:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 3ekvyvnm3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 08:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvxJLiPjLqrV1uI7YgEOME/wEz2d2p/zUKYNog5+dXlRMDwCHvo3oZN8bW+SUQpo/Lr5UE7xeVQWr8lcJP32NWZlFiPVmsllFYimt96v2rYFj5UaAkxDtgji0aN45A91QJh9n8amCXiZj37FxO3bvc70DFABk5dFiUKucAKAtApopB5dNEgPsOtCVQdXfGBfh+ytbkmmW3TUkGB3G0aGGT2CwrjAgtPyBbFrM6iHhldda0rx07GSCbfZw0Hpoc6vEQB9yeCs4DuzF6FOQxFa1hIxb/N27v2FtXa7QiLVpg6UfOzOVsLMpDaofnhHOMpcTnstPzqG7H/kV9XA+8Vokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpVV+g01xGKSlOk5b+x/4/541M0SG89ZJ957wzhGFVs=;
 b=diN0RaAi75PM9a4lpo3uu5+0hOLgmMjTxy6WG4dAO0sOGBUYC3Ll1TvuM+c8JK25fbF0TJjqCWBerVjT1N4OylLqMnXSeg6523HSdK3LTbiBQmrLLSa/EPhtVWReX1wViIB0A/vlcULScduiUpxXfgtZisAFlhWzu8hP2kr5Y/aD0BwzRy7sS8KsYz0K/IPtVqcwCPOxlzvrsk2eEDynCiDk/DEpsXHd8Qz8mYzZNktKEc9sBUd7Wg73slRffanu9ngYi+xkWrhYr5T9U7HAz7eEWRh90p7pnMdLnWWEAoTKyuwpZAoKoR11SK5DZl4mIpfsOINBJcOBmR/i2dU7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpVV+g01xGKSlOk5b+x/4/541M0SG89ZJ957wzhGFVs=;
 b=FCQFvzBiuXYhs4ddie8cZLNkR6boCqZgilXmtFx/QNZmpusD49s7i75GIqP5fHfDdo+vPYUAS/kmLnsIZuF1ZBkBjgMQ5Dg7lDPckLRRdMBp7iXt6oc4s98ReboNl62hr52fzjlXddrKVgHrhhfCMBQaOUcvHcoVwLaZXWgYLV0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4338.namprd10.prod.outlook.com
 (2603:10b6:a03:207::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 08:56:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 08:56:35 +0000
Date:   Wed, 9 Mar 2022 11:56:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] clocksource: acpi_pm: fix return value of __setup handler
Message-ID: <20220309085618.GR3315@kadam>
References: <20220309040301.25087-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309040301.25087-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CTXP275CA0034.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:1::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bfa8ca7-a3f4-41f6-0329-08da01aab704
X-MS-TrafficTypeDiagnostic: BY5PR10MB4338:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4338805204D4FCDBCAD639778E0A9@BY5PR10MB4338.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyb0cixZpc3xfOw9pqWX5ZaoZiHc7B49fAgGAYPLWDXI9XDTVKF2/vi0EGFY5fcDZARk6phjWiEP73OnQ+fNtvWnfTJch2C3bmvQKr3mxM5DHjIX6unsQXAMUiEns+5XsR9w0fICz488llv3fliESrWlSsmjHIKQ0t+U0OC5D8ce2Wrb2LZt2HQ5KycQGpj2iZ/5wW7bneDh94RgyhwKTwq8coXohmupdz+wQ+dkEtbSDEwCF05eoEG/1OrUsPjIaZ3JRGp+n9X2+DKYQNbcGvD9LPVDT7K7ySa/3AFFnNYCO1KojBwL7/rBuWMNSS9QCwj3ZH41qdjkstO7Vzw5KilFdIpzerpuAmUY97oe39XiK6x8K+yaZnIaJrkanJkCTBxOlF5uSCZWzHsXggzxWUF8r/sXTrKp22RVZV+aFNoEDi53JC9MkGU22HwjPLgZV+viXoRBnv9P4FGrAXKn2YwBxVtdita5vXsU0C+LQn2tvYd4GKIt8z8hcVRB+xVoOJ8t/h4iCfc27VGsl2AcekG7BKvz75DT7FSFfpLakjrm1oQW8dSiTt9TdgwdD/RaYm1iZXdZFbzsjPRKxFEqqYhrMvNX/qKXo6fuyC4uyc40I+Cp/Z0jk+PXqPiti36Y2zmJtnE540NVuE18REyCKk1rJF8OBOspv4v1rVKA+pg+HPu+shNdkWKTAn2rzkyKtQZyUe94iWX9hGC/CmFTBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(8676002)(66556008)(4326008)(508600001)(54906003)(26005)(186003)(6916009)(316002)(83380400001)(1076003)(9686003)(6512007)(2906002)(6666004)(86362001)(6506007)(33716001)(38100700002)(8936002)(44832011)(52116002)(38350700002)(6486002)(33656002)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NmsRh8A4L/lBJgLRAOu8Cz/I37p5ah+KuL+7Stl+11UZwjzYN0Y0Ilso86je?=
 =?us-ascii?Q?V0CAixpoUujkXKIFqM/xcGUFzhBINGtBVQgld38iaKbyQ4pFA3FCJ7L5Vpcg?=
 =?us-ascii?Q?tjwms+8zmyetLIj8nX9erziP56BkfnAPadwlTdlXxG92miS7lBZeUQW1f6+S?=
 =?us-ascii?Q?hsbl0vu7+E5+3S67gBvM31R5yjGa2amNFRIGOc7JhkhQipcAQvG+y/PWtN8e?=
 =?us-ascii?Q?PlYA6aI3wF+4a+kj+tWpKqujXjcoYXBjhDv6udIslymK05A9S7QmxLfoFg7X?=
 =?us-ascii?Q?W9oVMX724dd1JUyFSY9sC1XMfw0V8sLJr2XxuFcGwcbfH5oKr/gzemw3mAo+?=
 =?us-ascii?Q?E6SD4Vi5ohgJ7+Aqamrdbq/K1tfshuWGw6dcSc8gX1t1SrYgilBBrgaIlTAe?=
 =?us-ascii?Q?79umu/GWIRo0wixQA2MyzpGQSwmFUbTD30hizE5snE4lw70Ox4psOmKx8L7m?=
 =?us-ascii?Q?VZW7WHm12VOCJlwqfBjnppwHUtvl2pIagWMsLBh4bLbjWLbx1ZzrztO3KZVR?=
 =?us-ascii?Q?c9X8IZ3AtdpePisNnjNBN6j02RktLzBWITR2p+/6z888Yv9BwdiogPW4KkCx?=
 =?us-ascii?Q?/Ag5BkEhTxY9XK/ckW8iCZ6VEp59ehruJMDWSA+iCdeC2lJkwjw9KVhVTSLn?=
 =?us-ascii?Q?goGGGFGBHOqyL3gfXoBVjCkLSdCRvJeJ4g3+h2G8+Vel4+fCr2qaQ7ZbmoEF?=
 =?us-ascii?Q?sFxP/b8tHB5xHocyWMknEVoNOJez1+vCu1XIMLhEP55EbSfADm8gBqKMuFSC?=
 =?us-ascii?Q?2fG+q/PSBna4+1qA5sj6taHTLbjW49thwSoRI366JvrYG4HMrRz9Bz7ecZVw?=
 =?us-ascii?Q?vdWnSAFVAdAU1M1VX7+0ofWoJycgMdjJ7a4jNVIm5y7ZjvNEvrjdEvA6V3TT?=
 =?us-ascii?Q?kIkr5VLcYs83GoCsGlavwwLUzR5zr24wOFSbUlGNH3TkskvZmn9zFgQeV37R?=
 =?us-ascii?Q?qTurbn6qWAjgFQw0CTY4HR2cGRfT1TNq1JVJRKug8zLwCJyAJZGsWKQfgy2O?=
 =?us-ascii?Q?/6F8eDvm4B9oUaIoEudIBqyO0gcU1sJvxKTBZDtq1505+s1WPYHZT+xaCW02?=
 =?us-ascii?Q?05rB2gK9mZeDToE3ZBHlKxQ2eUDjiPWrrSnji8qmBJbwoyNVi0KxGwt8B6Lz?=
 =?us-ascii?Q?0WK792bveWGvprv1I9NE40oq8Hc4y2J4rMmz6glBnNET8pKVryJuk7+Mcqj8?=
 =?us-ascii?Q?aHURzw8wtn1mo+j3ZHW3AlW5Mcm4jFmU9xg+pXOX5w+fDoAK61cdK2QbxSz4?=
 =?us-ascii?Q?9O+soep6BeeWe1X5dik5OCNUEPk1jCGqVNHT/6AaCSL6oFUZeJg7pkabSG2P?=
 =?us-ascii?Q?CW3q72mD0IEKmxKeuuhzXMVu69EvR2oC57Q4PNdxn2VTh05sHi612tWpz+ID?=
 =?us-ascii?Q?L5JDZuTJP6XK2Vb4xs3Sdw8k3jDVrDJqBO/yDz86fY7s7/l7jF6L3pCCTzfj?=
 =?us-ascii?Q?l4Niuj1oS+3TuoTYTl+CMTEiGZ68iKnzxzaO6i/rL9wGspot6ldNdhj9D1RQ?=
 =?us-ascii?Q?jMtHZ0VsdN4k+ekkkCPDM+xpsfMfC/tbwG55IJLlZdyYZ58qEdsgarja6xZF?=
 =?us-ascii?Q?Ld+ALlEXDqlX6/M/t43w2QCUjHc5ToECTD32VlgbgiBM6PflddY7N4h2ndRi?=
 =?us-ascii?Q?MCVsjYYkilo8RKt+xsdVMeqXq4zsE64E6PY98VEHK8DTdA9/gLpu0yjzyUrh?=
 =?us-ascii?Q?uLAKaA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfa8ca7-a3f4-41f6-0329-08da01aab704
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:56:35.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZXBOThVj/rfp+AMM22sNPTk+aCaih/HpDy7Oa+heTpXSdDZ4qmVZRbKcNYvdavDQvmXuBn65VT/CfPuVMvElGPKmi1a/0NveqySK8QREtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4338
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=992 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090048
X-Proofpoint-ORIG-GUID: rPHAC6s8xrBGm9PqkxhKnLofEbQaW7vr
X-Proofpoint-GUID: rPHAC6s8xrBGm9PqkxhKnLofEbQaW7vr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:03:01PM -0800, Randy Dunlap wrote:
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) environment strings.
> 
> The __setup() handler interface isn't meant to handle negative return
> values -- they are non-zero, so they mean "handled" (like a return
> value of 1 does), but that's just a quirk. So return 1 from
> parse_pmtmr(). Also print a warning message if kstrtouint() returns
> an error.

Everyone probably predicted that this API was/is going to cause bugs?

Smatch treats every (struct obs_kernel_param)->setup_func function as
the same so it's impossible to write a static checker for this because
in do_early_param() it expects zero on success and obsolete_checksetup()
has expects 1 on success and also on failure.

init/main.c
   732        static int __init do_early_param(char *param, char *val,
   733                                         const char *unused __always_unused,
   734                                         void *arg __always_unused)
   735        {
   736                const struct obs_kernel_param *p;
   737
   738                for (p = __setup_start; p < __setup_end; p++) {
   739                        if ((p->early && parameq(param, p->str)) ||
   740                            (strcmp(param, "console") == 0 &&
   741                             strcmp(p->str, "earlycon") == 0)
   742                        ) {
   743                                if (p->setup_func(val) != 0)
   744                                        pr_warn("Malformed early option '%s'\n", param);
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   745                        }
   746                }
   747                /* We accept everything at this stage. */
   748                return 0;
   749        }

regards,
dan carpenter

