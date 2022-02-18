Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE844BBC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiBRPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:38:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiBRPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:38:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192723B3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:38:06 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IF62Xf017318;
        Fri, 18 Feb 2022 15:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JfCiWhO+XcDjbEfJHY2uBAlaaKqhg9h4vdzCplg2f+I=;
 b=BaBzleA4hDRVwmAUpw76WSRwvxWEPovYWH3pfrTpjO52VTthU3VgjQROf89RzOj7NGil
 YqWoSOGC4485LISJtKFfBWmIrOkoAFdoy9mU9I4I4H9HermaM7YKAmvzj9HrLht24DMd
 xq6B81/+Mew726z/e/POcLqD+UBs3M+mfSUiH3e9cYg2onS967xtqmbCSODlFqvUpA0G
 6AsBlrYH0RZ2Gzxh2FSvS2NpisSUJQ0P5NxSnrMNu6jlQNCaYReV5/nIwtGv+8wMvf5e
 NDfhcWZ/lbivIDZjOMvkJpbYURzyjlA99xZ87+mV84YdLy71/CmMQ40sYSBhyoQqLbmf iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncb1w9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:37:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFUexn081892;
        Fri, 18 Feb 2022 15:37:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 3e9bre12t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:37:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWg/Pwz2OU7kXlN7fhV+S1CC3Rp5ro3GpqnPUx+Ky394M5eGUNH4ZPKbjkC5K8bjLsYcf/cNTaAh78bcaFBviXv3qxLcf6aHbjuy7LCdgYUmECLkci2ckhFC2mD2Xxd0UZimFvQZAw/OhYvQuaRUbAbUp8GjLMcI9oVxEKGfQ+NInGdmLd726cnfjSLQfYf/yyh8CgFI5aMJvGiyiKpms70nzzIMyNjuCFzXmN1hs6kyeaHHOXWi49S6aS1M8ExQW6pEkBeT6KEp0GQB4ZVyV372oCkgi/loZ8ZHpzaVr9A/I1urrqn8Sup3xLRgNP9gxobXBSF4A8r020epJTtk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfCiWhO+XcDjbEfJHY2uBAlaaKqhg9h4vdzCplg2f+I=;
 b=VSRgVMCSYtZed8ZQcWdu1UH0AFnP84Kz1Ph4ezSIP860GHhHYt/pkSvwfhjvSC6iZpQhSdxUHJMUYyR6kLDN9pUuTEMk5ycMhceDGvvug0CyeIn20Mey2BD8Z7akqnjOpZHFXrJALLU376CUpx6xL0IvQk+pt/pHB+LS/yl68zE+Ba3ttdN5eshdpz/dy9IQM8wv6UMa9GueilNt103gRD9FJoVlO+S29ADQppD44LT+0YrmAw+lDuNjXIx3FHiAhUwH1MyBM9j7gAtDjC+Rz4XCYr9/eGyVLZyNR9J9SQS15cUjc4RrVBWYxdGUszYXST+kr2qA46gSEy2rbfOvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfCiWhO+XcDjbEfJHY2uBAlaaKqhg9h4vdzCplg2f+I=;
 b=ZU2Qg3cWylOquT7XEcizR/W5GY+a32VFqMfvHcghLsRmq7i85fSLdUJ1SLvQ2VHWP/YbFANHpdhA/Ks0KaGgDyLY8MCLJkmZ7btJg6Ta54Wb2zm0Ns8pnZ+PAaovmdo54RDQ28KVhtqfDoD/EYopW2E9ShGBxNZWWVbV7tm85Zs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1359.namprd10.prod.outlook.com
 (2603:10b6:300:1f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 15:37:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 15:37:55 +0000
Date:   Fri, 18 Feb 2022 18:37:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: rtl8192e: use BIT macro instead of left shifting
Message-ID: <20220218153737.GJ2407@kadam>
References: <20220218162908.48f83564@cpi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218162908.48f83564@cpi>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c61056-89c3-4a0d-f9c0-08d9f2f4a18b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1359:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1359092E1819F1D95096DDED8E379@MWHPR10MB1359.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFSgrlEN0pIlEfT/XiGWqxG9zKFqviKHrs8f5JlC/SrTqu/Mn00YLufyDh/gcR1tEhSEEXbcxj5+vt7AS4/gdoUf8EMkwoT1vTPQNa2pFfRKUxeoq18cB1Ol68Jt0K1IjBj7yWVqcqCKhpnivo0KmInNruSJkt6ygIWBc1tt8RaRzWFs9lA7n4cxViNnOHglJ7MBgoAsHCF8ArbQ4W8IV7OQwz6nIPfHDsV8qf8GyA91OxAROmM1kLI8CKlF3U46bu5sqrfPxAetzZ/aimiCzBslq5KoP4H0u9Ku/m/aGk8bo8H8LuWECrC1chUlfe8Gg+ARdMvC2Z376OHWpxxEhpTLDLQMdKFpja9XoxrKIoQz8Poa+Ui6/NLDSs89fXH9XBK/XGHhaAh2OVelgSvWZpRXRCdmlSRPUqFgYScN1GWgD/5WI+9dJviWZC0RPshWw88b7ihf5tRnajM4iLvNKk8hYXscXilo1gY4kjrUhvN5MFQebs8/0CD2XR1I0mdbisW6XfT74NyOVjSgkWj0Jx8tlqIaMw/y6CD1MgtE3sdTf3rk7EVMNY3Hzh0Sx1FSad/yGy1TkbKzvOMhC/yjhbVSFuOXDSNFn/Lx8Zluw+n/me0GcbjgNU7t62hmn2PR+F3W9m5Ez0zbGG/5X9zbiksJv+yc6s6CSIO/De02XiQ1Ya18S513UbHUGG+4zC6Dq+3ozyl0CsbSaGQ9E9sZcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(6916009)(53546011)(52116002)(9686003)(6666004)(6506007)(6512007)(38350700002)(38100700002)(508600001)(6486002)(2906002)(4744005)(86362001)(8676002)(66476007)(4326008)(66556008)(66946007)(5660300002)(33716001)(44832011)(33656002)(1076003)(26005)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bYTFycLt2tcqTZ/b/GPQdx/DFbkfa1YCwAX6cUZbzJsYsVXQ8QUd0aWLxJ7M?=
 =?us-ascii?Q?kuJny06pcZjKWlLcNt0gfqP0wwsuLu18gRzVUtInEEPKObZs5jZ9E8Rzq2S+?=
 =?us-ascii?Q?kFNT1+553kGGHW49AM4EJDKX2vIoiY6j8x/OUeM2ARrsD69Acwx1R2PsUmci?=
 =?us-ascii?Q?tfS44voDr9KygWl55xTrqiwgkXXz+e53sw9KZ7B1mfD/HtRRuP8qBPfQq9eY?=
 =?us-ascii?Q?vjKT0PBUZT7UXojRMjC4vulYvjb3h685+FJPOdkq/Y9bsgkYZodsmn4nXyIG?=
 =?us-ascii?Q?K9n/kdSVhvgdxMJfzae8Z+SlCRVWhKA4xxqUc22e0CkAt2THLy9yWdOIiUK+?=
 =?us-ascii?Q?V83im1j9Z51qG3cWk7i+cQLfkD03pWUwDkn2o+Cc9uwVYnPz2EG5t0xtRYaH?=
 =?us-ascii?Q?OBLs7riqlhK9EDjdAngHzn4pHg0sGerUrcmDfqdDnzRvwv6/RsaWd90J/suK?=
 =?us-ascii?Q?8blzIUmgp8+f8+F7U2vVCxOgKcCe1tKCd7a+aFVCbvCr/INcnxGYmBsoBw5P?=
 =?us-ascii?Q?qzASdmtPeKJ6y9nIyN6lAB4ER7XQfdXYSrVsch+Rh4Rp9ZOz6Eolc3BrI9J7?=
 =?us-ascii?Q?Tw8+Lrj+NAznxwpQFSLtaBAZV/slCNfCN9gExNLC71vc5ORrF4rDXX85ojtp?=
 =?us-ascii?Q?RWItIftv5eFwv9e15F65IAsZN5Mx67FkDOgQQzv9a2AID1GKd/5kv4kwHkKg?=
 =?us-ascii?Q?Stfnscbs/PsSZuAeuU57ujUtAvMi5JlBUhoe1kQYNogAxWHKzNVX0X8d/9Fh?=
 =?us-ascii?Q?QWHWByz+OA87JoKGuL0YfYgATO2OGdS82ki4hu0R6Ojj/xNC4imxIhazTD5c?=
 =?us-ascii?Q?xkh7rDZaS9kX8SLYFg9Uvdw+Xv8poj7jEN/ddPIVLIUaODpnAdH70xhufJmk?=
 =?us-ascii?Q?awxy38fgYlrHXhQjpiRoNEMDfC/Z4PSGYj1u0CbqyvXfTZI8UhX64Uyf9u+1?=
 =?us-ascii?Q?wrl3enYx9W0D7/BnLxHHi1JHHjQCo1DXHmOzbcIuatOKGN/PGbpa+F9OuHnr?=
 =?us-ascii?Q?knb9Js9/7yek8iAPhqJXxT1fUnaIAHXmPktMWYTqRJHNFlHaf1z337TWvVNM?=
 =?us-ascii?Q?CvN8MoogrNQjLiiCEXTLRG/yZ5A5C7t3ivZyqPRTGl63WnxRSfeELcUHu+HV?=
 =?us-ascii?Q?NgpAoW0IMuuoNBMvdAJX9fUiVWdIT76jbGsBT7X8ndHDZW15ca0CGlviHywi?=
 =?us-ascii?Q?CC/qamOBFsDUFAkY4q8Tutw5/gNB8CGumSfNz++0WSEJkFdImlnIZIEpGlbQ?=
 =?us-ascii?Q?jknVwmPQMBceCN8HRF1E9NUKg1b2cOhDCruPOXEf2cwsSI09rwS5tHDKoukI?=
 =?us-ascii?Q?etSg0ppJQMwO/aRAHdkBjaiF8oMyRK+S75mtXd6luPAMhLSNqmfNSshlYX6U?=
 =?us-ascii?Q?c6UnRzqPvCi/wPZCm0wkfmq9va41jUh8ehWmJoIIsF8DHjL7jPKn+1Gy3kZD?=
 =?us-ascii?Q?IXNjonJ3hXp38x7RaEtfmlonkvHcBqgjkohMItL4gkD+uXyxpRK+nEHJsMCr?=
 =?us-ascii?Q?uUcgqisGJD0VR1XwyL6k1ZWUTI/lp2GSwULQxbx+gw7Vp5EflRDis15ASQRV?=
 =?us-ascii?Q?T4xpB9Tn3W+iG8YAIPBgAZGJB+Y1pqgP6CfYMo1Fd2MF7Bnrv4Eh5F3X+FK8?=
 =?us-ascii?Q?Se6P41rP85uSHSf9BCyclROhj7bdheqx1trAr8ErxytIoxT1TQmuft4UWhDI?=
 =?us-ascii?Q?bkh39w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c61056-89c3-4a0d-f9c0-08d9f2f4a18b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:37:55.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsStKIy3mBHEvwz2mmc4ePxnwKpubSwheQdNzPGg8JJChJLp9SWXvOoSwURi8QJrbg3MIixMk4l3OF5VMFLQbXtJLg2WlLEEFuH/xmw7tjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1359
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180100
X-Proofpoint-ORIG-GUID: 8i8ETt7QvX9BKVCW0al7n_M1n1VBonhL
X-Proofpoint-GUID: 8i8ETt7QvX9BKVCW0al7n_M1n1VBonhL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject needs to say "[PATCH] staging: rtl8192e:"

On Fri, Feb 18, 2022 at 04:29:08PM +0100, Moses Christopher Bollavarapu wrote:
> From eaca0dd8fcbe3ff6daf14ea7a532e53acf840790 Mon Sep 17 00:00:00 2001
> From: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> Date: Fri, 18 Feb 2022 16:08:16 +0100
> Subject: [PATCH] drivers: staging: rtl8192e: use BIT macro instead of left shifting
                   ^^^^^^^^
Leave out the drivers:

> 

The patch looks okay but these headers do not belong.

regards,
dan carpenter

