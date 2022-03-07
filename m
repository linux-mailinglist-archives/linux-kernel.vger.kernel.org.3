Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3924CF2DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiCGHr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiCGHrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:47:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E745F8C0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:46:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2275ptkT010128;
        Mon, 7 Mar 2022 07:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=m86YmNWM0+XdMDMveDVKzLtCSWWx62tdkC0E0UMsZH0=;
 b=WMW8neX5z6qPDstFk+y7cFb6R4OzEKi+qrE7k+MbZ1A9YiI1ckLtDoVVvBkl9b9AU4Ih
 RS0qcgpZ/Ret0g40LEKzGewTyb508R1vO4jXeL3WCjf4HolqBAuQ8mXrgioGyj/5SbI2
 96d0yD0nHghOqg7AaVGcwSOmm5sBlu2nS0jzjvgsiegNMIsWCusa3Vfl9ttgzH24EfsU
 k5Xs0Xr0I+Q6Qpfr8nnKRPrnbrLJhd8XjSC5CoennEHrhqMo9A6IaS3fY3rRBE5gn1bQ
 oz3Bdo+NQV8gwSmXrN6x/Qbgdr+a7w9mvn2quSsecguRYYwNzFfOZELt+0VeV3USpJEH TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9caw10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 07:46:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2277bJma046980;
        Mon, 7 Mar 2022 07:46:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by aserp3020.oracle.com with ESMTP id 3ekyp0u824-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 07:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hlx3E/mRvFoQ/EupcL/tr0H5udwfQm6stomYyZSlt4b0qDeoNPfQirqjdxlx4pwoYH/IgcptZof6tk069nSrCegbeSk4lLo/Y/qiDTZTR8nloXIoweDLmw90jMLWgRg8rqKvZDtiBLlqNjdb0ASwaAVU2hOGgVtf3J0bn9eG/xrVmNHN3z0VVI9LJb2fVuNI7ulqy1RY9NJ+4YI0IAoDXYFUXzTJUYnxSTMmH/RR6TeWjZpdiW30/b1cwAQTuomCC/JdE/Ib1Ov/UAjpE92f5q82dQaLZ5RzyuKsfDawJQ5CtbQW4fpgd5sMa3PbWsRKC8jgPVLElR17wLTyKPeTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m86YmNWM0+XdMDMveDVKzLtCSWWx62tdkC0E0UMsZH0=;
 b=YxaocSGzznSs3rgJ6KGbo2tFtTQpEbgol+aQXx+evyKxGMKWpuWpifYkljlZuI6p3nF/9N9Yl0HYNeH5q9fOTDCoKsk8ZTH/QlLP+MkIihVN56KTHiA+iW7borK+N5Gr04tvjekEdPPHynsCGK52O03vSw+gCDxeuhU2DHv8q/s2jNllPYoEym/9mGcbPALNaU7CkAtT+F6Ytkd5tEA1EwoSgNS8FRuJgSGo9K9Hq+JM9Q0giWt8xFmN8Vk1/to6fkXLtsiZ0X2kadsfFs+CC6GK7hLXvKZC7kQGJ1uiyWsA5toxmPOxVfzj5KehZtceAZTjEW2qJrmSVSk1WX8Njw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m86YmNWM0+XdMDMveDVKzLtCSWWx62tdkC0E0UMsZH0=;
 b=lc0DwUR6jERp8BGFT8DbUsyrWLoyW+rdKSHlQyuqPM556GwAFWWzatskSjFDyhtCTNsdbdHC6QfxZp5aZu9frTs6co3/5iCC5eAGIecDD/00at685pmxSq45oOXOVbyuEiuKBMirivyPNBR77moyr5/bepUTfILwNNdKefYyZVo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4014.namprd10.prod.outlook.com
 (2603:10b6:208:182::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 07:46:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 07:46:00 +0000
Date:   Mon, 7 Mar 2022 10:45:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vchiq_arm: add prototype of function
 vchiq_platform_init()
Message-ID: <20220307074544.GA3293@kadam>
References: <cover.1646255044.git.gascoar@gmail.com>
 <b74ac90e869f71a98a04b834c4f3b5ab37bb38ea.1646255044.git.gascoar@gmail.com>
 <20220303122546.GH2794@kadam>
 <20220304193015.wgofp34efl2loplj@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220304193015.wgofp34efl2loplj@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5160470-e9b0-44e6-88b6-08da000e85f9
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40147223895B289DFA814DDC8E089@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdFv9jOuwl+ok6ltrubtt65glrhslzk5JVsW7EzW+Httnc5gu6dZ4meiVsCSMXZfDSn05CGQk2+IR5SOCr9Oi3qNpH7yS11avVJ7lw51Qayh23bdOCNY93qzeeDbY7wxXyEzRq7+ZdFuTPOCG2dVCmL0y+5TckN5CNyIhDxsKGgb7Qhl+EtWRp16LPeg5KbuSlCQWZE4kNs6+/i2p/Flrfa8VlWRJCJVep/Ujt7IqSdTmYayBJ8359SWU4A5KEgl2IH+EE23Rdl0JTFfnNzom/CLogbOoZ5X6r0tqg0SDlIsTb7tKQixF9V1t3TUafViUvS8Xq/rc9nvW5gfnmOUPqlnq45C/cu8fIx9xt+KFk3GxzbkTsg0Cmg0fY8qrAIdHSkgaxqP64XFN5B5dj4sCvI61zXIsTOpe3EHmxe33hTsLRT56oUnSIxIqYzMC8I8xcC5hoQkyEH9PhFCBunSxEJIrpykZBbU/OSceqZ8aVZwxvogyQUwYFPibBKXZS2qjPEzYNEeQq1QA+IXX6kJeP2uMwGwAiXFD+Ufxd3WvAhxvkKeRfVIAwnkvEXKUULYl1zcmqaJk7h5ciRwvqsyRDKSiBKNykGistGuv2ENzmI9H5NFf+GGWnOz3FK6LOTBBwSZfI6vJNpwKmstOAusiFcarFuMXCHkkGrVLcw4Lko37iIJy/UxiLGJORQSrNounS+miM8fY0jtABXROQILGI+/QrbYPmwm9xDCAImvw8nWUoVXYkS1717Rq3VkwVJ9qgJVKey6C0G8lWpZ/0R0TX8tKK/OiqXPSZnq6NgSL4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(4326008)(52116002)(6486002)(66556008)(66946007)(1076003)(26005)(186003)(33716001)(33656002)(316002)(66476007)(83380400001)(6916009)(5660300002)(9686003)(6666004)(6512007)(6506007)(44832011)(7416002)(8936002)(508600001)(38100700002)(38350700002)(86362001)(2906002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NIajgyalI2azBnZ2UvY1FjWk1sWnlaeHR2cjlzNzZFeHdIWEtkbGZHQlFI?=
 =?utf-8?B?YWErNEJNcnVRd1VYTzlyeENOMm1SSnVZSzVlVUJFaE5NUGtZWjRxS3VDeE9X?=
 =?utf-8?B?aUFSWkZJVjRQNEZmcmJoMzFBU3Nzb3c1eHNQMWhjbGV2K2hmck1mdWlteHZy?=
 =?utf-8?B?RUJ4YXJjL2JlVElIbW1xVnc3cUlxOWNuaEtJaE5UV1F6S2dId085NFJsSFZ0?=
 =?utf-8?B?M2t5WWhXZFdIdTFjcGZ1cUdzUHlBRXl5eUtaNmpZVll3UmRnUGpWbnRXcWhr?=
 =?utf-8?B?VkNyd20vbktaenpEZlJybHhVckVScnVEeWR3UkJSTzI3aVRnaklPTG9RdVlC?=
 =?utf-8?B?OGVFQURSMWtwcGhiSVZXUnhYdWFuRXkzWGprdytFR3M5SmxCa2NkbXk2SWhn?=
 =?utf-8?B?amZ2Q1dIaWlLNndLTGxBM1hSaHdKUWJQdGhlNFRaWktUdFRZWVJiQldjdkZY?=
 =?utf-8?B?c0xIYk5vb0svd2x4dmhUYldiQW15MW0rN2VJSThGcUFkS1FENlpEZ0tua1Za?=
 =?utf-8?B?SGVJTytJa0pwU2M1UzNpZEhoRjd0eVRRQWllMEpBN1IyS2dFWnFMZkx4MjlJ?=
 =?utf-8?B?RUZxd3d4Vk5BWmpGYjl4RlFHTGg3ZWorVGpZTnJlMWZvTE01M2xISkFsaitC?=
 =?utf-8?B?MXF3ZkhTZEVoREVEcFhieDVWM3Q5S0Y3SmtKbUdvb0ZqNEFJa3o5aFpFWEFV?=
 =?utf-8?B?dHRPWWxRVE53MFdGVFd4QlZsd3BUVEwxTGY5MklPZnF4Nk5WQjZDOFI0ZGw0?=
 =?utf-8?B?bUcrdkp3ejhxYWVqY1Y0U1dDN1VVZHlqTG5JYXJCaGRPTGN0eWlyQXhhc2hl?=
 =?utf-8?B?eXNSM2doK3VQRENRNm9YSGRHbVlmN2dNYUR1Y2ExZjhpdm1NcC9hN0d6SHp0?=
 =?utf-8?B?S05IdFBHSFdvSWdlTS9tTU9ibnRhTUdrQ3BTWTVGUk1FNVhndUswMnMxbWJi?=
 =?utf-8?B?SnVjUGhna0tpWEhqM3JFWnpqK1ZNTlZvVjliYkZIdjN2MGZSQ2Q1M00wTnM5?=
 =?utf-8?B?TEhaR01oV0xJUC9USGhoWE9MbXJsWDc0dGYrTXNwQVRjWWsvQkhIYjhyMVR3?=
 =?utf-8?B?c3N5dFp3QnQwMVVkVnlDVUg5RGdFWGJkS013OXhUM1k0SEh6QzdUUGFkL3FZ?=
 =?utf-8?B?NXlobTg4Y3M0NjhLUHVMMThSTiszL0VCQWg3djZtVFk1MlpTSTBSY3RmOFUr?=
 =?utf-8?B?d2E4TnRMdXRnWG5haWVDSlpTZFBYY3RSZExGSDh6WHRMaFBubXE3SlpMcnlk?=
 =?utf-8?B?R0VnZC9BdHg3RnNWOWcxWTM3Z3QzY0VyZi9LUjhsSXdFNlVpUDlFdGtJL2tF?=
 =?utf-8?B?Uzk5Y25hTFhVV3ZBcklHNS8xUFlKV296MVFlaWNkT1E0WFc2dXJWZkM4eWdB?=
 =?utf-8?B?R1FBWTM2dUVicmRXWHFMVnhWaWNsdGZNdzBPNzNLVUY2dWlGY3lBcStNZ2U0?=
 =?utf-8?B?RURBOStZY0VwNGNJdFpoOGM4RERqNjJMSlY0U05FVVd2RUp2QkNhcUJydFpt?=
 =?utf-8?B?VTNRQU5XM25kNVBpY1dZWWdFUG8vK1JiVVh3WC9zSWNIN3AwWTFETDlIZVJx?=
 =?utf-8?B?ZWRjNGQwVXJFZ0hBU2puSmpOcnk0T2JHVFFhcEtWWlBwbmVLMWRxMVFkaVBG?=
 =?utf-8?B?Q3F3dDhBZTFMSzFXMmdKNTA1UzVINFVhNytER2pKaHByaTljOERLeU5SZnRX?=
 =?utf-8?B?czUyRHhQWC8zcEplZm9XeUNHalNvYWtnOFd3WkJkMERMZXJUcDFGNTMzUWUv?=
 =?utf-8?B?N3NYb1kxVE80Smg5V3VDWTJ1ZmVNbXgyK2E2akZTMDkxY3c1NkM5R205SjVD?=
 =?utf-8?B?OXV3OEdyZmNRWVB5czFrYzFMN1lVc1FjLzdiQVNlRUY0Y3NCQUhKRFRUcW5h?=
 =?utf-8?B?aWd4NG5FVWJON2E4cGhnVkxheS9aYm5QTWtzSUVkRlM2OVlkMzNlcVRkT3BB?=
 =?utf-8?B?R3NGWjhQRzVlQUw2Q0FGOXI2dlA1ZnJCMDJRbit1RDFjZXZnRFVndmhnNVpC?=
 =?utf-8?B?YXZ4Wmw0T2RuSWhiWGMzRXZoY3Z3SEdsM3FIZUtDTm9QbXpRZm94ZjVPd0w3?=
 =?utf-8?B?NXYwcmU0MlpzZ0RESmQ4emlVd1NuOU8xSk5VdXBlaVhHdXk4eXJrZ0ExVkh0?=
 =?utf-8?B?bFBNekFEZWFjanZKdklPdGg0RjNWbTV5M00rZ0liYk1wdVVYS3lZZHNmelpu?=
 =?utf-8?B?TEVkM3pBcHFRZVpwWWVGNnZZaEJJeFZ3czRQdFd6Ykd0UHArZ0cyMm5FRktD?=
 =?utf-8?B?WEpHTDBNendySDNGRlVWaGxwNk9BPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5160470-e9b0-44e6-88b6-08da000e85f9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 07:46:00.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipLUEJxozG/ZDuY9JxGZaOb5AqtzJvg51dGCFX/SwaVHPlQC0RUYhpuN9hpoSRQnoyRlJnUPkzqSjUV/WJtHgi3y8ykXhn60nQigyVOQ2E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10278 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070044
X-Proofpoint-ORIG-GUID: kBtn6XeozpiQ9n11P4pkIgUlqu3IL4DG
X-Proofpoint-GUID: kBtn6XeozpiQ9n11P4pkIgUlqu3IL4DG
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:30:15PM -0300, Gaston Gonzalez wrote:
> On Thu, Mar 03, 2022 at 03:25:47PM +0300, Dan Carpenter wrote:
> > On Wed, Mar 02, 2022 at 06:36:38PM -0300, Gaston Gonzalez wrote:
> > > Fix "no previous prototype" W=1 warning by adding the prototype of the
> > > function vchiq_platform_init().
> > > 
> > > Note: vchiq_platform_init() is only called once in vchiq_probe(), so
> > > presumably should be static function. However, making the function
> > > static breaks the build.
> > > 
> > 
> > That's weird.  I don't have an ARM cross compile set up.  How does the
> > build break?
> > 
> > regards,
> > dan carpenter
> >
> 
> Hi Dan,
> 
> Test building the driver in x86 I get the error pasted below.
> 
> However, now that you mention it, I made an ARM (64 bit) cross
> compilation: making the function static builds OK without the warning.
> I'll to do the same for a 32 bit setup.
> 
> So I suppose that making the function static is the right approach ?
> 
> FWIW, branch and cross-compiler:
> 
> - Remote: https://github.com/raspberrypi/linux.git
> - Branch: rpi-5.17.y
> - gcc: aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
> 
> 
> -> x86 build error:
> 
> CC [M]  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.o
> In function ‘free_pagelist’,
>     inlined from ‘vchiq_complete_bulk’ at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:650:3:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:434:4: error: argument 2 null where non-null expected [-Werror=nonnull]
>   434 |    memcpy((char *)kmap(pages[0]) +
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   435 |     pagelist->offset,
>       |     ~~~~~~~~~~~~~~~~~
>   436 |     fragments,
>       |     ~~~~~~~~~~
>   437 |     head_bytes);
>       |     ~~~~~~~~~~~
> In file included from ./arch/x86/include/asm/string.h:5,
>                  from ./include/linux/string.h:20,
>                  from ./include/linux/bitmap.h:11,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:22,
>                  from ./arch/x86/include/asm/timex.h:5,
>                  from ./include/linux/timex.h:65,
>                  from ./include/linux/time32.h:13,
>                  from ./include/linux/time.h:60,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:13,
>                  from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function ‘vchiq_complete_bulk’:
> ./arch/x86/include/asm/string_64.h:14:14: note: in a call to function ‘memcpy’ declared here
>    14 | extern void *memcpy(void *to, const void *from, size_t len);
>       |              ^~~~~~
> cc1: all warnings being treated as errors
> make[1]: *** [scripts/Makefile.build:288: drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.o] Error 1
> make: *** [Makefile:1831: drivers/staging/vc04_services] Error 2

That's so weird.

1) The GCC warning is a false positive, but -Werror means we have to
   deal with it.
2) I can't explain the false positive.
3) My guess is that making the function static affects how it is inlined
   so it gives the compiler more visibility into how free_pagelist()?
   is called so that's why it gets triggered because of the patch?
4) This is an x86 config and it's an ARM driver, but nothing in the
   Kconfig file says that vchiq_arm needs ARM or raspberry pi.  Should
   there be?  And a COMPILE_TEST option?

Anyway, we don't paper over warnings like this so the patch is not the
correct thing.  Especially we don't paper over it without a giant
comment explaining how we filed a bug with GCC or whatever and a link
to bugzilla and all that other stuff.

regards,
dan carpenter
