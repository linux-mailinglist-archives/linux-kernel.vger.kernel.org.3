Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4934E26D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbiCUMrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347546AbiCUMrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:47:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E36698590
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:45:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L9YbLm012459;
        Mon, 21 Mar 2022 12:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0ZDuWmFqj5jz5ZvCc/4mDW3ncIRIsYBmgHIQXh74u30=;
 b=shJEKXyu7dPZIOQ1/ZhHN20La10uc8EZcoZh0i8m1y2HvmrNtcnbQT6nwEXdr3m1ijBL
 l1srkGf/yFMaC5a1ZIk3luxuBjr+zNGOBBrjvxvP41DUlYBAb2x+qXJNWrLiWhXvafPb
 B8LJl0Tu3ug+eEGn0satCEuJ4MGBSI6+d7FBUy54bojMSMqF8Ezrfj+INXvh4Z/Qi/IJ
 xv5KP0bjbWSepG1WQSb9PYnjFRU66GiTBkRcyw2FH7hBlBDpwnvNx6XbmrKYvFKXc+0m
 mx4T0ijEejLU011vRqoJMouXWSlPh/hs5aoa199FMeRlLOmEIN7hhRfCEIFB2gaYDi2U Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ss34at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 12:45:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LCfa5j137586;
        Mon, 21 Mar 2022 12:45:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3030.oracle.com with ESMTP id 3ew49r3bpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 12:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2ifWA6b5SGI1ucQRS/5hHO2rn33abE2Fc04S4vFvb0f/XEC5aat9X7BbRcTYd8IdoLmcZbkw9qey5dzW0BCcGFMCfJOiUMiwk6x+8iOrMlTYHQ1BLDGfG9JgdSSk0uSYIavSi/enfJRaLRL9G+HMrhZw4yV7nRjBa7aDTPIdlU9peYcUnAyBT5WQehOffPtdRz6EnFZtT3ZH5yvaPA/AZtMqnSAfGCsy45+WnxYQ7kV6HZSPRNzUQkyhlEw309E3bvKQnpHZ0PTkqkaxmR+m4tiomnnIDtFZ1KO8pC2GDfxNIhXT/hk72C+B+Twi1JrY+kWrriETcdjmDKBq0onFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZDuWmFqj5jz5ZvCc/4mDW3ncIRIsYBmgHIQXh74u30=;
 b=Wv6ErBmDPlhpud+uIEIA1XbO9+emaWZGviW3T/OFL66Sn2Fu4+/1BoTWqmlMdb75XC7KgK+w/stRbiA4oQgKI+cgesx+kRqdJ9PKIedwCYom52TOmwP9HK05qvoJrNnjBSmkUB0tbeMwoab1vqnkis11tUTnBq2ZJ6w/nqErSzK+KzsPtVANgR/2NL/LOnRcI2Nkw2EbJqHL3sI1lD9QQa/jqomb55w3Wf9Uwo97mQzWaQpxL3Kg9hNUGqEaTviSS2aUO+dImX6hdOw6g+opn+nNfpYDDbdOO6EAbsjDglK8j0zBDyXBLhk0oUUlNEtKp/djWQbi/HJRFbBSmCFZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZDuWmFqj5jz5ZvCc/4mDW3ncIRIsYBmgHIQXh74u30=;
 b=pYNynJIUJKWfIyvP+wvo+sRL2wBcrZjaDERWotbMJUm18QtNDvRjocMg6zMgf1U072cwnd685xSIcyaC+nodwP2DBSyje0UkiLmo529YtoYzJI51r2fbfSf5mR1lvMtfIvtbNliFvPUj7OzdUQmAOGhPWz/dmMYV7wrni3thZxM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2255.namprd10.prod.outlook.com
 (2603:10b6:301:2f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 21 Mar
 2022 12:45:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 12:45:35 +0000
Date:   Mon, 21 Mar 2022 15:45:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] staging: greybus: codecs: use dedicated list iterator
 variable
Message-ID: <20220321124511.GK3293@kadam>
References: <20220321123712.3068778-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321123712.3068778-1-jakobkoschel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa4e7f6-703c-4b9d-061e-08da0b38b178
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2255:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2255088E3F54C0CBF60C2ACA8E169@MWHPR1001MB2255.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXUYSZduHF3CNMkpr/evBBqJz8wp4j2U0L0Svle6GatSUVCzb2AdsgdkXy2k3EuV3SW9F7kyCNj6onA0RpMdNQsY1HLTK6dvL6JXPQREzvpDNCN643czhP3VZVc8b3e0Ye3gTMXJXNcXAAF3cYSAvcT8cJWjG/C9cb106Fj62X7xsUptT/ClldMG7ivRMo1R6ZhX0arWgXP06wZvxO9KU/MHnqifeBYq842cNrXkkSbbZVEh1byVovUH7ZfxR1qBc+v7Y3AZpx16LJgOlaGpimAep1tvm2GP6Ki8jVMU/StZp6cGxi7lpnaVBIQcBway/nJJW76Et131zI46j0DiE/mKd/1WIpEWh4XyFtL+y6ySlNm4le2xYJsyIPWuZCy6r9U1tJtdpzIyBMLfI3rqLfhWi5NcBujPFxakyc+2MCJ/G18b4nuVAlwdPQYcJHM/JOu8zgP+vhfkpOOxh/H6YIp1Y9DQCAHRso3QPrvVFOU813Hj0dO37a0NfLwjTn2w69H63MubpZ/gHT3g0R28YKe8BbFe6q3Z4WFy98dvTMqgpJxtIQkvOdm9Q3nOs2TQOa4a92j5O6o+LbUnlCnIHCLu7XzxLwAL1lTyQajWVWfQ3icUI/EYphCh80V7Ufa4YuTolk1Q1TeBWqO5euWvYYkHBXOBB+ZfPp5OLgLSeNSXTDEY/PaO+9ViXJukPuO+Zp82Tdn7LaHynBHXq0tkBDriYqu0sXVa67WrXB7KZKP4PKnBEVkVMe6BeqaBrFI0B0/kW6VAVMj9xfvO7IV/tLPiSn22/KAChf5ajTQTqGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(7416002)(33716001)(33656002)(66476007)(2906002)(86362001)(66556008)(6512007)(38100700002)(38350700002)(8936002)(5660300002)(316002)(6916009)(6506007)(6486002)(8676002)(54906003)(6666004)(4326008)(508600001)(26005)(9686003)(83380400001)(1076003)(966005)(4744005)(66946007)(52116002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ysjzvv6bIdUX5GraPVVSIhHHR4meM/k6R5oPdZ81artFEumy2qPlPXjfVHL?=
 =?us-ascii?Q?hNa2MOMFV04pQNhU+WHRN9BRXE6WJpZUphZENF1q7cAMCViwuv4/DCTcu22l?=
 =?us-ascii?Q?PfsFCUyyKhZ4HXuoxHPIr4yFOdi/ctYbPj0bVCUSWxYyZ0/KU4ijYh/MZ4K/?=
 =?us-ascii?Q?KETpmMuWaifVrVfRDHSoD9r1tHaOKYWneKkHgB9X7h/AC4RZCfGXBXoi2Ia/?=
 =?us-ascii?Q?na+e9wR6eNMRlSuqcMSNnpJU2O0+bvpf3p/KPGm5iTDEfVAK/nKF2Z0+mjiq?=
 =?us-ascii?Q?pOy+6TEF93s6+Sunx+UrdKmlIG61f2jMFJwnEN0L2b3st+6Lq8pwp99CXB4n?=
 =?us-ascii?Q?a0KpjsurTzjEeg5BsdXN5dvDJ2SfT9YQ9qU4JxqrGbB/mAzuvPrS32vqsRF/?=
 =?us-ascii?Q?QGdLBwock7WHbEVbSN9xnSyvgLCB3VLgE1Qs9g1fOVHw4/qneAWaooYjrQ+G?=
 =?us-ascii?Q?vt/2+jwGtKLcsCczCTi3uAhwI81mRLFZwpC6pzfhu8y8LxMVW0m8ObCipK7h?=
 =?us-ascii?Q?prewUT2gGiQABksmpSfbmzyneDABwTucjAHvw8SUHamAIM7H8XwFKbYEUJe4?=
 =?us-ascii?Q?Ope3TZ1cZSTNelcvaHwZivl9BOJNukXFS2sq09y/eLWnuMeBogghB5acjRRe?=
 =?us-ascii?Q?8EF9Qfu5xDUi6gE+F7Blm6j88zBoAlvwViRr+Bs88RHLS1uUFAT2BsC43UZS?=
 =?us-ascii?Q?wbQeXFemK4A72VhzNzzthmRTf1lhtOIizr6Z3WTQ6BboYz2ySwDuHs6IVs4F?=
 =?us-ascii?Q?BlCc7Pgi0GRa3cDjvfe/tgtFnGNI6Wok23JHHE3O7gC5M9g8simmMmKa7zlk?=
 =?us-ascii?Q?b3BgVv17DoxtcQDgf08YKySTZ4VXiA+OK5zInDwQwPs2VmiLQaQzxXu09YwC?=
 =?us-ascii?Q?EEPDkABtaVLSo2md+dKRZ49Edaf9apgSVT09bo7m4eKngvU0wQEyHq0l8Eef?=
 =?us-ascii?Q?K5zgcWQEDrlQa+Zy0M/+pSJ1MPkpjWRIPG7MAQTRUN8bN5uRvzL7TOtWDO+V?=
 =?us-ascii?Q?q7glWVaPt5QbxaTo5s+MDWp4gPfitrZ2oK0K6dqFlyXVs0xbNKCIjLKdUTdK?=
 =?us-ascii?Q?65y1m96qgKWSj+fzvQhEoUoROVX3HPEYLnYadpYXOMcSqi8gBa2KimMfv8Q6?=
 =?us-ascii?Q?A1XernzeRGsfiQ0zV4wa+Pw55OuPz13Bxj58eQa1zyZM/3wlqwHMrETqa0OY?=
 =?us-ascii?Q?npVk9m4I5a0X4dO6fBgHpX4C6YyPLKEOpC7KnHSKYB+snP0iYdb7sHHAkTTR?=
 =?us-ascii?Q?FrrhWRdDHxjPfOXTWaWmG2p+dYNpgV10X5E6UqWnJfIrirKWhyd5baJsyUFw?=
 =?us-ascii?Q?oME9Rc5CPIHUXxVDJ8ZkKiixHRIwnzMdrJ+W9+3d6tCc2kbhyzxv8l/peET6?=
 =?us-ascii?Q?QxoRzgZttw5vwzzno36FMwaISt1IdUsgXFIYws3yWVD6Pgb1IO1ewab/Rykc?=
 =?us-ascii?Q?k7MRWIfBGDDjg2An3NAxcq8Ypwd1a/fRSLh14L9l2bhyCXUewV7rUQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa4e7f6-703c-4b9d-061e-08da0b38b178
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:45:35.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kUI8qX0DwVhC90mXh04Qo40gq6J8atoPP+b26Ji3jPRI6NUoJtAMuA2HsZTaPgh4u4laX8FPHYyLDGBH9Y/fM+JRyzZUcou0hvXQmRZIjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2255
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210082
X-Proofpoint-ORIG-GUID: qkWXHhO2jtpu3kidRNeQrf5XOl2_dBbn
X-Proofpoint-GUID: qkWXHhO2jtpu3kidRNeQrf5XOl2_dBbn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:37:12PM +0100, Jakob Koschel wrote:
> In preparation to limit the scope of the list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
> 
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

