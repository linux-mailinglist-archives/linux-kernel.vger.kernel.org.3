Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12D049F839
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiA1LX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:23:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20870 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230042AbiA1LXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:23:54 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SBGS9h004447;
        Fri, 28 Jan 2022 11:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=V6poofyaA61GklCto/R0hWYS2QJ5R0RJPVbEkhfxXCk=;
 b=Q5uWqfXa1nfRE5jF8r4RWjHS/S2nq9eVW/dMLYyreASP+LRUUXltHjdOEZuqgtMhEzLa
 98Qp4rR9PfNHfcsVYDa8JQrLyjRTMq+YpiWqZ/NQyaem7X+i/fG1KqHqAOEQhs57Nlwz
 7Yffe256YEkaueU19VMXEnjs81qB+7X2iMWkN1pHe2G/J0N3Df9dtqSByWYREi5HJRxV
 vatiKJJh4Ax7TI16yO3fcRjwb7DcLn2OYdBNgS3KaDQg/g4mQSivHQX5lW5LUF40wXpG
 RqrgiGem45EJ/sxQyERmUD3l8bfvuUs8LcLnXdhFBh14wVO4NG4JIg2QplM+R5kcD71o /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp2jtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 11:23:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SBHA60013119;
        Fri, 28 Jan 2022 11:23:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3030.oracle.com with ESMTP id 3dr725dg16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 11:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWbQKX78QCgvs/cRyMLzQmdcQA9VswJmGFPgAb9TCtt/OVKUGOn+oh0SbTuRt99GjHtg5MMBTEI4htuj4LYoSwr02RAr6s15UyPQSc/DMRWzMbXHoC6DNLl6/GMDpvpniOC2w8ExX9TBP/Uv4hAV2YSZshwUXksPU/g/rGjKeH88WwFnepq+G9p6Tx5enCBgP6LZ0DTa6fWJCgKdkZ/1qFpKcq1OwlSpUnYbUwOY+Il7pGjiTdfKm2f5Rl6xuXt7gWHvFgjKo+JXwtNKjpA7FWo2xIE5vwf4y8zOjfCXaJUJBlFdM5cpYdIfeydQAN2xQQvkm1caS1Wgc3Wz6grVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6poofyaA61GklCto/R0hWYS2QJ5R0RJPVbEkhfxXCk=;
 b=aldGizd6kifABMoFe6EnUtBQAlL6tll7VfzbdyNGMwuuD7gae6FUxzRipnN25qV5bezQA/56RYlA+4wt1P5p+aDlH7UKj0tH2r5tBHk4TmgFt6BUokwk3WBSvZC6lrCb0u6A1uI+9xuiwdItCS/ywjRXI2ULlJ9uiGai9LpbaM6YLPhWXfpSLwNf1JR5fqTRdwVAb5B8nawMhcV/ed9wAgU2zbJWdfTtqGJuVhr8HTot4Tvdwy3RahmOJxyIvCTH2VV2ikNn6OgCg1QPRi37kDae+ijeQZhMP9pvgoG2PZg7LeSfQvA5q07SiVa//1yv8c0xaDSRBgD5l2ippIeQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6poofyaA61GklCto/R0hWYS2QJ5R0RJPVbEkhfxXCk=;
 b=jYtrEob7p1A79C1Y9gEviyOa5nkbsP+0RQbQbhZwV6uOo5aKapfQWwRxIhagWzE1AHLJMfnEsP3gbwqpmWMeZtCjTHfSXhjpnK1pXMsmT5Ep0g5njYtcSCvevCgf3zlRiBOJ+fU7i5f0dSuLyE7gVz7hm3aMZtr9+E5iIu6X5js=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DS7PR10MB4958.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 11:23:35 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 11:23:34 +0000
Date:   Fri, 28 Jan 2022 14:23:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rt8188eu: Remove dead code
Message-ID: <20220128112315.GF1951@kadam>
References: <20220128111954.1028121-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128111954.1028121-1-usama.anjum@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d718b2ea-bd35-457c-0c1b-08d9e2509f34
X-MS-TrafficTypeDiagnostic: DS7PR10MB4958:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4958736115868D7F0C65A4C48E229@DS7PR10MB4958.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaiW9QtR8NiMDLIOEF+P2eoZzZd6Rw7Yp/98Sf8edcKxOq0OwQmqxN6LubEU2VshJYcjxY9ndtTRnM1EM2jP/UIcOUKm5yh3UNCWSi6sl3frb9KMMT8ZzKw//iYa8IDhmmv6+DYejGp7aVYlgItkWG1BuNvdPrn0hiwbIT5pWTar4IMUx/te2RKozmkkM73p0mGaPvIt211EwGzJrAvyGUKnAZPEcKWphO4JTf06NJt9bW85NEeVqL6odbEZT9uW/zf+TnEa/JWqECFKFrcpYD0cZ8cHLNLUAW9UQQWq+d7sU3R205IYfw7rGGZqVTWBWtk+vb+ziXNnS00AXX7FaeDe6kD+7DyLofsCeLPDikLxipBMOHggfFleNxNA8sIVtwIuGxVVHT3nU6Gf06l/fE+7ITF8d+jc1ykVQZDSyFwGRLpHn/z/vvW2Qr+qOq0jF0Ta62kTlMoLxI65OTuMXtAOkccmhy74dlJ5GeVgiVB5VfCYmItQxUBKSsTdqq1jD8ERfTpYZtvNQpDT6ZUiHma3zeZfXjyw+LhMz0Iv30IS0PVcb0YMpM5Z0+9/tDP7szckZExJV6ia/zI8lj57bqXfb8BLTOf+qUn+GPnluHuqGirwOkegBSnQUcEp9yKjDLvMWe5X6OM+2+111ajllVqe9PHpSRiuKOOZPqqGhjH2lvt4KDU0OOVYCldkyxh69WNUs2+zr/wAcKujsFBMDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4744005)(1076003)(38100700002)(2906002)(186003)(26005)(66476007)(316002)(38350700002)(8936002)(8676002)(66556008)(4326008)(44832011)(66946007)(6512007)(5660300002)(9686003)(6916009)(6666004)(33656002)(6506007)(508600001)(54906003)(33716001)(52116002)(6486002)(86362001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVv3LpMtIgZmmFVEoVOQAFV9WBm93r/wPUo3A6iTEwYY7mzrPFO3PsmzUk7+?=
 =?us-ascii?Q?uETRb69ZQ/jkJQ0NBpeYuOaHzAcl9ZA8WKHh3eedNe95T7yW3PqnXdOZDGvH?=
 =?us-ascii?Q?qzwHw7kdwNVsVo3/M8C7x9YKwrnTKJktmyzfwMDda/zas1T9jlxppqMiL5Pm?=
 =?us-ascii?Q?HcyAIw0R/GQPSdLuxiT+s4mwgj0yLz3GAL8UoXwYVgsPJ29HIsBRaJzmGjT9?=
 =?us-ascii?Q?V8OjImuFFo5uF8Zw6zwj84J5BZUKLANCdF67EfZK5Z0TNBlZSERS4nXrI9ue?=
 =?us-ascii?Q?lQvm/Z2JA+9d4/6ds4E8x3Yf9q+N+RpPr0A3Kjz0WxpbJgNRo4PwZ684UOIN?=
 =?us-ascii?Q?s69kj7FEULmms0QI8UIA9Hv/euYtr2k9rMMjmW9V0dOZeh98MIIxtI7sAs2v?=
 =?us-ascii?Q?qA2pNFNMuNIkiponipOFQv42LZEbgp2JHovUy6/3WBikLI0RNrc71rO0Ueao?=
 =?us-ascii?Q?nbaemY33vx2Ge52JuBwv816p3yQD10imHRJ9AniCvozQBWE1KvFMK9OamYJo?=
 =?us-ascii?Q?RuR+akJ0cId24HeQVzZVzMg+N+g+W3HEdG9EyS0uOBz5LHN6O50CVpUZKYfg?=
 =?us-ascii?Q?O0d4gQWFyKUd8+8sRCM1FXoMZW2vjU1J0R1LDQxdtA3XmoIBWfXjzYv8RVB+?=
 =?us-ascii?Q?Ss/ZsGzsa3+uc1ikU8BBoLx4Yyi7uwbNktbPTwlJkSDBn6u3bExs7jPfNfnf?=
 =?us-ascii?Q?UppLwsM2ngNb3toD+SDPTUezHLtp5AA75XR6jcFMecMIsjqmeaIoWZiq98Ex?=
 =?us-ascii?Q?mvh4JBhEVINAEKlu3n5M7cMyv6eIcgOxWOpHTqmznD8teYYGLmdKGa9fd1ZH?=
 =?us-ascii?Q?/9GC6VVTTFsAH1lmRthKEMw+l5PJGYMPZqDol2PVFp1Tn3LRr4nJTnWjILvZ?=
 =?us-ascii?Q?mxS2T3gFka87bYxxfNdUpWBj0mq2vQe02CnSTonUBZmwCRprX7rxpNYJhrbo?=
 =?us-ascii?Q?N7Rs7JUPaW9ToY499OFvEbcx+Jymq0awj+rOdLXZ/j3D0FsS3mF53iHxc+un?=
 =?us-ascii?Q?9hi6sNrwbT0fSosirc4Nd3ZU768o0AuiQg2PN3/2s5u0whHgmWO/dKpfegIZ?=
 =?us-ascii?Q?Plizq/byupJn/nUPj3u3r/HQ8gpazV2s/LCRX4rXTFc8UxEF0KcYMpRZd6FC?=
 =?us-ascii?Q?NuOgUw6nx4sAMfqPMt04a0LaEeJRZAJ01JGeu+Q5A48itXr1Fm2aGFrM05ED?=
 =?us-ascii?Q?vPbA6Jtubt5FQ7llC4bcNfE5Os/OLWJKnWiBvBb4eCc4wkLI05wKLhmB4Cig?=
 =?us-ascii?Q?isEFSRoZbib5d0v15oSsf94A7tC+tdK09+/HtrMAzXSAMJTQipq68GFonYlp?=
 =?us-ascii?Q?8rF65+XviFJIczMBQhH+SSDVlnEq6jtoIVMhU6s7lZ0EmsLLI2wrfNEigukX?=
 =?us-ascii?Q?gxsKyWX9D5qbzC0Xo9obVULTkJON0RglnlNPKe0loaT+YXWKp32PbAWbZ7hF?=
 =?us-ascii?Q?WKfA4dJlS3PfIT8UtgMkRcxComENeD8e7b/qSohVNOUJ1npyWE4LbiWrib+w?=
 =?us-ascii?Q?bgalAcYl7rxm7U4MIx2IebVaosaFDrgQh7sQpq3vqQ533GXU9Bg/UrZaxuT6?=
 =?us-ascii?Q?/SxtkiNvCMR82VHrfhzR/3pZz6I2V2m4lX5/ENQPHw6PEDTTVPPEYyW5y9P+?=
 =?us-ascii?Q?qUlvTTv8a0+lHmzElO8Bhmpp3snoSKpPnLvi3HO7g3w9KXzlWJQn8lKRa71O?=
 =?us-ascii?Q?y8zG99Zh+4+9mUaaSmB7eF7Kvzo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d718b2ea-bd35-457c-0c1b-08d9e2509f34
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 11:23:34.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjKbYRQGUEbCdFP3D/UvrgDKH/YLW559/W6JgOUJoX2eejCCcONvRDVTf86Bz2EUO0m4UE7Vu1RKuKDXWOhPjoDhe7I7vqOku2T4BgnN9LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280071
X-Proofpoint-GUID: BUjAgavjVrrR9KgQr-e2JvIB8FcelC81
X-Proofpoint-ORIG-GUID: BUjAgavjVrrR9KgQr-e2JvIB8FcelC81
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:19:54PM +0500, Muhammad Usama Anjum wrote:
> rtStatus is _SUCCESS when the execution reaches this if condition.
> Remove the dead code.
> 
> Fixes: 67396d2dfef3 ("staging: r8188eu: merge ODM_ConfigBBWithHeaderFile with its callers")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

What checker warned about this?

regards,
dan carpenter

