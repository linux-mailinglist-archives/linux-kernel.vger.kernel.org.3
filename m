Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF3593108
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiHOOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiHOOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:53:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2101.outbound.protection.outlook.com [40.107.220.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B713E8B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJtOeAwhoTMx6KSoaJzqHZtjyq/Cy+4zv3gV9NbzG0Pd7ntXpDpnmQB+LiMGKKoDRk1p/xDBUaNNf5/qnHy1OAifh9vk+fCuy2kK+8F1stJF/sj8qwSLMfgwtcrQhTASweoTtPlNbKS0pvCQVQEw9sQEPaanSZZ32tiapF6iIzKhqaK05lvaR1hAArWM305woStnSpkXnn26BkFxMqJIb714HO+926orZe0yTSAQuBampAmr0zmd17+6mypI2KlpkwtuPCjuOpV4Jg+8HbZ2pH9LHest31xt80u5wZA2cyD5WY0iaG6m9zZw8aCqpv4mgHU3zIP22RoraE543azmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVDN79TxEMtbQ0ufJtuicVQ3XpV4mukqM1MpfBnx5I4=;
 b=KVrtyXZlLjs1qSSg2jChjj4ViVCYIUaZymwILrxUT9hIFl+l5xf+HNPNXXFSx5g0vyrcjymU0gG4Gl5Rf0BAoyUFdgqRVuDSCp7ZGRMTw8ohU8NEzLUAQVBwfjOTzPI8qx+p5HhCiN3qwTTDQq+cB7khtUERjz5lAF1U0IutuZI1djSJ/2bt7HNDzc24Zd7wkKAWXWLwo5ij+uKOuwTCMOt4ly1+F7WG1IdMMpJItpQX1KuuD9Xau3ijQPfteEdc3Z1cJRJ1gk+Qq+aqwwgOv4EgbJ9c7Jsit7txV8mRXq/EMK6yUWkfH+BDgmweM+BDs40abwY26hmH28ViAwQYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVDN79TxEMtbQ0ufJtuicVQ3XpV4mukqM1MpfBnx5I4=;
 b=CnBgW4igU6pe1aoXpwtZr63bZGuOI2IqrI8JpZfKtqg5fnrOEw96UuctMk4hOMeszXrGwxj0iVVam+A8WKWU/1iVVSSHNiSIz8hLn+dh6y32V+50A8WrzRZm2MB+njwhjrQeqfCXdGcxnqZQ9YhM8ERJdeZqCNlQC9efkeENt+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by DM6PR10MB4267.namprd10.prod.outlook.com
 (2603:10b6:5:214::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 15 Aug
 2022 14:53:18 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee%4]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 14:53:17 +0000
Date:   Mon, 15 Aug 2022 07:53:14 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: boot stuck at starting kernel, due to __genpd_dev_pm_attach?
Message-ID: <Yvpd2pwUJGp7R+YE@euler>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::33) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eb489c2-7688-403f-9962-08da7ecde36e
X-MS-TrafficTypeDiagnostic: DM6PR10MB4267:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUzlEyU2/t8YCKlQxS0m7LLY9XwwqhHXGQcjGZro0fLHO4imoKpwecHjPOkEiVb4TvX6kNxbUgVOwgyH4wzMdSIAYNvlnETrC4h++xkmlsoQ3Rb7gEqJ3DPjbpnhMAt0FFVgLY3Kix4Mrd0+U4XmLjxtqvxB0Uy8dhCOKyPfpSnmcwQ6Skyinkxa9zeEWvFo7c/ybbpdukapNjiHuZvMjYXsxWGslGotGTbtdq0Xtl4WC2gmyqss2omj2oGMgcr3Tc2m+4NJaEJsuEfYjLtrcz4y4CcuhBvTnq6GJRPl4WltLuCGnKcZPtuuALqUxqbzXD85KWvkX/gIKt8V05kauq5my5WmIzoo/sluOUhkO/YPkymSBJIZdIMR2R00V05Q7A09A/Va/BlaphOCMKyHnXHOFe5CU7yRizK1mnKCLuhkpWYb4pp2Ata+6CyiHv235YLdq96FQNeGOWTyo7kOCXLweAkW9rsr5Gtr3hSB6xeOuavK4w4jDbn3mqQF4TBW7JJJxAkRK781rocu/IPlbUwTozeq6FTdFaTHHJ9ZlTghrJMTdKipV6E2GzBKngdBy72Hjy5C0u1eCpm6wZtM8fRlG0P2Wyn1tyJ+cW0m42outhCTugCZv9sOBnSZAYiNIhwYiObrRwOA/uYgKE7NMIuMP9wLTQXlo5afQlIyTHaX7YTY4A9IbyzXM2Tc1/l0994sN6usxTO1AK0DDqDsBwEVlmxQ2TNb/1Skou6UdESsD9mj32tdm7SLBp8ybbGvqZupteNScedESzjRWRiYrsjaQdxRKFXmsvlejNDjAIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39840400004)(376002)(136003)(396003)(366004)(4744005)(44832011)(2906002)(6506007)(33716001)(38100700002)(6666004)(5660300002)(41300700001)(66946007)(478600001)(6486002)(66476007)(4326008)(8676002)(86362001)(66556008)(6916009)(54906003)(316002)(8936002)(186003)(83380400001)(9686003)(6512007)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pv6JA3NZ5z/sTcYp/y+kbN3UiSkhTlw8ZUdJQa2V6tqpqUnKaNrhVKoiDKDr?=
 =?us-ascii?Q?7CHdw+hGK7NtkWkfP0SLazSov9qbH01KicNcMYjO97zQaqJZSSA/8IoGs83A?=
 =?us-ascii?Q?hkyBAHAt5wq28fdArK3rXFxwHcFtK9DdciD7kkoURMZii+igX4broNwJdkYb?=
 =?us-ascii?Q?DYoK0LQL2UO6HIA8kL1ldTqzjvcyTzLCL3nfH39ELYef/bNUdQQ1T17tSypF?=
 =?us-ascii?Q?rY6CcYuIVFSzFD+9x05sgYZeZCxgh1F2OUsCjwHq344+XsHbCTiP8OtPSDjJ?=
 =?us-ascii?Q?uSbbXzD4ggoD/zQRAO5g2cuYWaWkx2P+LT3ls496EwRn0d2uBBJBx4gt+nzm?=
 =?us-ascii?Q?zsHTBD4ztQ/HJAAy0SPAMB9OWlZQ61ZElsuVVkdFIENFJiyLPurq69b5BcTp?=
 =?us-ascii?Q?rL1YyxQ2gRPubAMtT0wg96wnM+PCt2b8EG9rmUEbaJNtEiRcrQbXdDW+oc6E?=
 =?us-ascii?Q?gUhS+Wvcok+YzfEg0kTTuUf6u0PPSP68g1JRkCtv5h2NK6Al4hGoFGNYfIAU?=
 =?us-ascii?Q?xWbTU48oJawLaV5KxOYHXNMjg0vj9dhaQNP1gsIXMqX/vGYkT6iA/nWyXvxP?=
 =?us-ascii?Q?O/Uo5Y28WlNt4sANW/0aFpIrdkNuK9vSScCdAs5MY6EJ/DwBnZPkAJlsGok0?=
 =?us-ascii?Q?GVPbGpR140aOj7YTP7l1McFNXrrNSuxUDl2ZVTuH74mrUEIBjLjbVgYHaRSY?=
 =?us-ascii?Q?eBzQ0dYhZM0typYT7Gt1UvBoDOa6Pdj6VjPBoPB4pB9tHKoR/PYmWXjmYIdj?=
 =?us-ascii?Q?uaTZjuEIBqP4TZonhDvpl0sqY+2L3atovknYvI96a2pb76CyG0USGpEF+pOr?=
 =?us-ascii?Q?L8FQM7TRFvJbxoNhNKYpecx9eDZPYQsqppBgImXehME0wdOORMH7AeuXLX2j?=
 =?us-ascii?Q?CT/9/pdp4TweTDec93/B/EoY+ZABMCq93bcGg6maSgyIETNevAWlyYYZmlnN?=
 =?us-ascii?Q?sY1/RTpDUDod8QUABAxh1LyUQI5qvnOWXCdEBB4rIEcsi0Y3u3bKzdGBt5gY?=
 =?us-ascii?Q?JRA67jp05pHUKwZMf82cmeVvHFa7BOr7m9mLxUfD9nx+AHLn11ECCaDw/V6m?=
 =?us-ascii?Q?kUe41sLJx/Gt1OYqPS4tAN+dOz9f2RVUzK7cuh7yNZw2FdM0AQIDO+gjJs9l?=
 =?us-ascii?Q?TiBf/K2JQf26A3NCpv7zZwRK6JFGadaxyf7Pu7OCdV5GKcsg+CvxJNltqx4j?=
 =?us-ascii?Q?XrAhTZJHrLMudtooD9Wc3ZycsIB73vrMrgHnBQ0fIVlrmNO8UonQNkbtXeSs?=
 =?us-ascii?Q?Q1uDYxSe8krnWAQgjnP/PgMEiPK9lt/1LnQxqgRo8RLdtjKGheBmSl9iHbFz?=
 =?us-ascii?Q?DTNiUpU+L+6uMn5ol06WLYCGd06JjuQm5gIm5+fb+j2iFbpDjcV4djmSN1aR?=
 =?us-ascii?Q?pJBPYr5qlCOwuTRWyu3QRoF2gstigz6YJ2LPnNrS44FcRSOQGQR8amw9AGbr?=
 =?us-ascii?Q?g3Oo23mvsUPNY+brk2g5JO4SDprWI6DFiXLXlCiTLmo4gR+DMY+OiwOemcDJ?=
 =?us-ascii?Q?z88R8+urdGcnDSSNecyWTx+zglhnB3lsPg+pE524sWa5u/hS6Y7Q3GcYjADw?=
 =?us-ascii?Q?q7GlFdRmVS5LepiwwgPpqfOkjlBCNkAWL9xVE+2iRPVCQnEDaxD5lXUmOcjZ?=
 =?us-ascii?Q?G3YBpr4w/+Tn8ldKE8r1IkQ=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb489c2-7688-403f-9962-08da7ecde36e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 14:53:17.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpluDtM7IlX7biyH7CTDwltvtMIrCNOM2/JV6lUrKRwplyHe5/rMm77BHKT7a6k8tbYFToX2wcmkklEdFD41DYturK1eNTVwPYKdwmxkDNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

You might have already gotten this report, but I tried running v6.0-rc1
on my BeagleBone Black and it gets stuck right after "Starting kernel
..." from U-Boot.

A bisect pointed me to commit 5a46079a9645 ("PM: domains: Delete usage
of driver_deferred_probe_check_state()").

I don't have much more detail than that, other than I'm using the
in-tree am335x-boneblack.dts device tree and I believe I had tested with
the multi-v7-defconfig for this verification. I'm happy to test anything
that might offer more information.
