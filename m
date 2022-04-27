Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78830511AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiD0N2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiD0N2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:28:23 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67ED38BF6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:25:09 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RClu4M000961;
        Wed, 27 Apr 2022 06:25:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=NagHgZEFNDlTEDcbmyBVa9v3Z0j1k3S6t1RiXaUaRok=;
 b=G4tQXt3YnrY5gVR/2F0y+PeurwWeX/wZDWnBWdCuV38oUwZSL0Cv74akpilvGIXdnJx8
 JjHRQ8G+GBBSXcIrKviDLMI0uKXm2dG2Ra1mMbDjTneXmcE0H/cLRMuqvq9aN7y5+ke2
 En5adAxx3jExQMr9K/VV8ZyTvxKGcT78XIFg7VttqWd9K9L3YTXlFAMlmgwgs8+tPcF0
 XqpHrAIf+Gz1Dxp8ArHKaheprLj8EgO/j0AGj/jYr0t4/ZJzg2VuWD+tYM2QVUL3cM89
 duljsR8c/Zc9h/fSlFrATbBkGjm8GtHiMVgsjUsC8+VQJ2V9mWg2MnJ5XzS4q+IKqLv7 SQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fps57rg6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 06:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVKKLay681R3gG2T56KTqHgibJzcu1xGVcmB/7sKN+N8P8AXMdJgWcS5uZcT7Zqe8ZQQnC9JNTX6tc3o44ko3yapnb6pSINx1byoqoqqIBRWU5o3yityWel+z9g8CBsGvpyVwGZ4N9Zes3Xsl8CTjafpE2AXrv8We5IUPgIlGwuIt4PjaeLsec9SMhugGUbI9EB/5QCiv8g3Chr9F3gqSx71ZXvAuUrGPhx04gNtcMDeauoNkU/j6fmXDTZyqDQ7GR30v5RtWmX99mEO2RbMrvkM/7ICD6kHXWic/q57HgUPtGyprjGwtH7tGAr5doidwyQYSW87W2QvK25LD5ryjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NagHgZEFNDlTEDcbmyBVa9v3Z0j1k3S6t1RiXaUaRok=;
 b=QJ1P3K+nGPOSeQRoXScdXg+n9ZhocpIf1lHRRBGlczQaIGhHhFrAqYi2nzunGtTZIm9HYB6z2jOfToAksQh2Dpk8uN6R3kuJCflgAHAszmqm4s7slVn7m8v+o6TCtNaEJGZD/uwfsgXif/GwKN+AyfqCAcM2bqxVzr4jT7TM6PYvJFoej+JCIZW5r20ZQ85yDpIDdtLfATEAHRqYF9DGnx3mFNRKAUIWD+3ekiEfsDeipF03CNVqY8uiw1SSIajLYTrCRYlOAy7YZftKaDUh0r9FFS6o6kOlPwyWGYoBvdSG8odpqZDyWvUuzhjtgpoJW47zvToe1po0LSVBhHlSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BN8PR11MB3650.namprd11.prod.outlook.com (2603:10b6:408:8f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 13:24:59 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 13:24:59 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Phillip Potter <phil@philpotter.co.uk>
Subject: [PATCH 3/3] block: remove last remaining traces of IDE documentation
Date:   Wed, 27 Apr 2022 09:24:35 -0400
Message-Id: <20220427132436.12795-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220427132436.12795-1-paul.gortmaker@windriver.com>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca1735bb-fe76-49f6-24d8-08da285153c2
X-MS-TrafficTypeDiagnostic: BN8PR11MB3650:EE_
X-Microsoft-Antispam-PRVS: <BN8PR11MB3650E0C35AED51AA8039FE0C83FA9@BN8PR11MB3650.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXlTelByVDNCc0pzQ0ZWOWVNaGI4OGRLVHlnYURKYk8vUTdxb2NwNEQxa1J6?=
 =?utf-8?B?Vlk2TGxZcHRiTkhlZXMrOUZoR3F2ZGU4bDBNN1dBTURoMkRKNGVmcnNUQmQx?=
 =?utf-8?B?czdQTTRMM01iWVdld3A4aG52WjJKeDkvSGxrRXVzYU55NkZXeWJGS3dyZ3g0?=
 =?utf-8?B?OC8yY3R2b1NpcHl5dmJhYSs5eVFZNm01cldpcklsMDJIajVvTmU3T1VuaUh1?=
 =?utf-8?B?V2JsV0tST2QyZ3o4ejdnZnRQL1FRc1RaN0gvaFhLc1F1c2pIT00ycDUzNXQz?=
 =?utf-8?B?emR1bVcxOUhzWUlqdmtTVHJlVEpEdUlHcnhXVGFBRkZSeXVQdU5FVFU5OXhp?=
 =?utf-8?B?Q296VksyTDlkOURBckhRN3psV2pGOWZ1QVZ1bk5VbjF5NXNrVU9FaUF4bFNU?=
 =?utf-8?B?RFFXUzF1VFVjcS9VamNORUR1cGE3NWl2S09ubjR6OWlXWEE3Z1UwQ0NMbjNO?=
 =?utf-8?B?UDV1SS9heG0wWjFrUk16ZnlIOWlQQ0o3eTJuK0RsMXNMV1lyaTNkYklMYlp2?=
 =?utf-8?B?Qkx2a1RJbDM0bitBN1orTmR5RHNrV1RBNnJrRlRZMGprWGFZV1JZUXNOSS9Q?=
 =?utf-8?B?SzRPbFhQbUJnR05BY3VIZStZRmNYSEc5SzVlMFl2bzhscjI2c254d3VwZG5Z?=
 =?utf-8?B?cGhiTERicm5RNVFjZUNad1FrK2x0aG4wdStSVS95RHoxbW1xbWNydkd0cG9x?=
 =?utf-8?B?RVcydUgwN0dnZVc5YkpJUm9raEwvbEQ2dDdNcWM2REJxVUMrV2JBU0hwYXdi?=
 =?utf-8?B?SHNyckQxbndCQ0Y1ZWsyMGhFZ1pKdlNIRzVnaFpLKzMvL1JqS09Hb1Y5YTBh?=
 =?utf-8?B?OHBoN0F4bjUwK1NiVzlDYUxzc1hyL2lUdWpGVkRmK0VuZExUdTdabHZoczBl?=
 =?utf-8?B?RFRveERVaTRvUks5UHFJb1ZHMTNEMURlU0lFSTdHWWNKbDZRUGhYU2VYazMz?=
 =?utf-8?B?QjVCQzU1bXhLc0tQdklLUWpkcFVlWEZWUVROTE5td0VseVE2Yk43dWlPb2lM?=
 =?utf-8?B?N0dnUmNZZTJOSU5hNXZlWHQrS1ZvRHVZV2pJeUJqLzUwQzU0b3hXeXg4UFBS?=
 =?utf-8?B?b1JBdXI1OG9XY2FsbVVibzcxM0NiRUtTTlRIOCtNb0pMNnBvUHZycU93WW1K?=
 =?utf-8?B?UUpNM2tLS21CMHJCY3ZORDVnVHlhcmF0L1BTekZHWFZZY3VSM093TnVXRWQ1?=
 =?utf-8?B?KzJodGo2bjlGN256b0dROVZvbzdrU3M4OUR2OFIwTnRWUTd0a2tUQmxIY3Uv?=
 =?utf-8?B?Tk1JYWsvZ2tWWVlOSU9ZM1Q5eWlLNmJhUmNKVytZdmw1QURnT3h5TlBCOVhT?=
 =?utf-8?B?L3ZuZnE4MGhZVWVOakg5cHNLUHAzMjVJMmJ4eFAyQjYyK2NFSmtVSUtSMDJZ?=
 =?utf-8?B?bDJ3RDh1eE1zR3g1bG9wYzYwTXJjRFA5NDhQSmRkbmFNL3o3dHpHZXRnRjB0?=
 =?utf-8?B?WkVwcTFCNG1lNHZhTU9DbjRyQnJRdjVmK1VWRkJrcEl5bXlCTHhBSmdicXVJ?=
 =?utf-8?Q?1j9xMcmSSEc7TfP4AkYw41Q2ItY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(66574015)(1076003)(186003)(83380400001)(5660300002)(8936002)(4326008)(8676002)(36756003)(44832011)(30864003)(2906002)(54906003)(6512007)(6486002)(52116002)(6666004)(6506007)(66476007)(66946007)(26005)(2616005)(66556008)(19627235002)(508600001)(6916009)(45080400002)(86362001)(316002)(15452945002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUtuR2YxeW8rTkUzc05qT3VOc1VUSC9pRTE5ZEdobTBoTkpvS0E0RnMyYU5u?=
 =?utf-8?B?NTBuYmx1Wi9IUGhrSDhHYkpoM1VXNEpzei9WaitGQm12M2lkeHZQeW4yU2dm?=
 =?utf-8?B?MTZER0ZvT0RKcytGTWxwUHY2NlZpL0oyMlk4clh6ekFSMll0OUU4OG9tdkVX?=
 =?utf-8?B?K2RuNzFXVE5BVzhnYmplYU80azJlZUduZEY5NU5lVm1yT3Rna082R0c5eWEz?=
 =?utf-8?B?OUZzUGRONTJVZHR3TnlhaTBYS3ZaSzltZVd6NHI2cS85V3NFVVhhMjFtOCs5?=
 =?utf-8?B?TW5vRWYzektDSUYvUkRaNC9nbVo1RjY3WFBOY25wMEMrWWJJTVJQWnkvd0Q3?=
 =?utf-8?B?VUtBWXVJdXQyUHF4dnhwbjc3b0Rudml0cWNpOE8vMEtWcHNmdGZnUG5iQ0Vo?=
 =?utf-8?B?MUhhU0pWbHNEZG4xaUZDWld5M3luWnVpbDJmbWdVQ3l4S01SZlpLZUQ0ZUV2?=
 =?utf-8?B?cGQwcWhzQzZ2cy9zK1RvMkZET3J4dGJzbTZ3S0lxM3owODJCVER6WW9FdXNk?=
 =?utf-8?B?TkpMQUd3SG0zYlRFdzBNUVhMMTBScm1SRzBTV2ZocldlQTZJNTYrZjh6c1BC?=
 =?utf-8?B?YzQvUU9mRnlUL2hsdGdzKytESURTL0FWVUQ0RUNaT0xaemFZNnE3ajMrN3ox?=
 =?utf-8?B?aEl4dlJJcDFwZ2dOY3JRWDJGSU54a1JpRTdiOW1sNnlEcU95U3RjYXJpeWo5?=
 =?utf-8?B?MEo3VlhoL2VWZ0FpSzdMRzlwV3lxNGloTnBlT2s2QzU5RWk5L0s5cmpMUTFN?=
 =?utf-8?B?WlhobWt3S2VqOVk2dzZwWXBIQTkrUGZSSnJ5SHVKdGdsbENBTDBRQ0tUT0dS?=
 =?utf-8?B?VThFNEhMYjZUUUd6bUJwdjROOUZQWXRYZDBmaWRsR0tWQnY1ZzR3TmZTZ2dZ?=
 =?utf-8?B?WDd0b1VmV0VSUmFqWGU2RW9xS2Z1d1JXakJmN1ZFOVRwSS9WN1FzM3RUaU9i?=
 =?utf-8?B?bTFFVDNrczh6S1pnRWtjSnJKUXdjZlNNR25FUXUvdWVOeER0S0ZiRU5Jaksr?=
 =?utf-8?B?VkFWNWxKR21YcndwbFR3N0pEYmdmbi9CVThwNm1NNDFXMjgvbEl4dmxiQmM0?=
 =?utf-8?B?aDFTODdkamFiMFB2RmNCSm9tQmFFNmRSNUpUL0lnSjJPNGFPR0JRSXAwSDY4?=
 =?utf-8?B?Rnl0WlpRZ1JKeHlOOHd1TGZvbmFnb3ZITStGeEVvMTJDbmxzV2RST3FoQTJt?=
 =?utf-8?B?SzBXa0FLMGhqYjViRTVRcDViaGs1SHNJVzczNGNpeDVRVjRXc25ZY0lUU2t0?=
 =?utf-8?B?cFlrZVh2UTdHWUx4QTYwMjFDeFhlSmU5aTNtUGtXMXJxeG1peVBDOHJBckow?=
 =?utf-8?B?RytjRGpvZm04M0ZyUWljVlVTL2kwSklZN2ZjNFdRSHJJd2JvVmYwL3E2aGN1?=
 =?utf-8?B?WGxZTWNHemhzWldKRjdaVWo0aDhGQ1FtcXlDNmMyb1RaRFRrcDVjSENMcTFH?=
 =?utf-8?B?eUppdkxWLzNHN0p0TWc4Zld5ejFMZ2EyQUNxc25qWHFpTFRLenJMVm5UYVdK?=
 =?utf-8?B?YTBocE9yNEozM0hMNTFwblhVa2tvTUNWb0w1QnowS1F3c0h0VzR2eGdla3o4?=
 =?utf-8?B?dUZXenljWFFMSWxxRWRkVXV6dGsydEZmTlBTY2hZY3YrMUlCVlNDelNXcmt0?=
 =?utf-8?B?ZXh4WkZudFFXK09pWXVYTTFVZk5KbEhSeVg1WmhReEtsSHkxRnErQmJkNWd6?=
 =?utf-8?B?M0M0eHRreE1VdEFqNFYyV0V6UWZLYjJpdWw1L2dyYW0vMy8zK2xXaGlJZzFV?=
 =?utf-8?B?QzZaVyt6RXZEMmQwY1JabE5GR2pBbVRkV25DQS9VbG8vQ2thTWZCYnZvT056?=
 =?utf-8?B?YzZpQ1cxSko1WGd3RXUybVE1UEVEaTRFZFFTZWhBaWV4dkJ3M2VNNDZRYTFO?=
 =?utf-8?B?K3Y4MG1tVEh4MWpJTHFFVW5EUktNb2RpZDY1ZDZ0czMrNlBzelFFL1h1VC85?=
 =?utf-8?B?bXV2TDF0VTNuV0dHR3lqaW1qeWhtTERPdURDb3dMSFhRa3lERXVFdXQzL0kw?=
 =?utf-8?B?ekV2enJsVjFURk9tV3J3SFBETlNOU280cGZCcVl0cmk4YkxwMEZxUWowN2o2?=
 =?utf-8?B?aXJ4bGcycmtWRVpNQVZvOEVsUjdqTUJFdlJrMlI4VjJVSDQyZ1pGbWJzUEQ1?=
 =?utf-8?B?V1B4K0FCa1hyUzBmL1ZSaGlsd1JMV2gvdlppR2JWQkJwVVdmSUozTDJHVnQ4?=
 =?utf-8?B?Mk8xWEJldmtkZG03MHIybE14Vm10bDVMMzdLcEtScEtvZ3hTeFIvSzJnVjhF?=
 =?utf-8?B?eGJTb1IyVmRFSlN1VDNaZGZHckZOS2QxQURzV05CeGJvWC83dnd5cjBjR3R3?=
 =?utf-8?B?YWZEMHFzUXhNSnJoRDVtcVRKK21NalhpYWxmNHVXRGxFaVlqWXFpUjZlRkJ3?=
 =?utf-8?Q?uZ5vZMVjKbqAtxqE=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1735bb-fe76-49f6-24d8-08da285153c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:24:59.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oD9ZwRcWFmMpvzb8obGwXMkl8CneghgO3OFHKgPmRZE1YYE5BHBLaJYaG1POa/StWX5H8tXIaREO3KKselt6pI8cUPZknZ0U9YI7wodLaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3650
X-Proofpoint-GUID: 1kS5n1xFmRdsaTOhZvFzWUGvTMFi7gkj
X-Proofpoint-ORIG-GUID: 1kS5n1xFmRdsaTOhZvFzWUGvTMFi7gkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last traces of the IDE driver went away in commit b7fb14d3ac63
("ide: remove the legacy ide driver") but it left behind some traces
of old documentation.  This removes/updates anything with a reference
to ide-cd or ide-tape appropriately.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../admin-guide/kernel-parameters.txt         |  21 -
 Documentation/cdrom/ide-cd.rst                | 538 ------------------
 Documentation/cdrom/index.rst                 |   1 -
 Documentation/filesystems/proc.rst            |  92 +--
 Documentation/ide/ChangeLog.ide-cd.1994-2004  | 268 ---------
 .../ide/ChangeLog.ide-floppy.1996-2002        |  63 --
 .../ide/ChangeLog.ide-tape.1995-2002          | 257 ---------
 Documentation/ide/changelogs.rst              |  17 -
 Documentation/ide/ide-tape.rst                |  68 ---
 Documentation/ide/ide.rst                     | 265 ---------
 Documentation/ide/index.rst                   |  21 -
 Documentation/ide/warm-plug-howto.rst         |  18 -
 drivers/block/pktcdvd.c                       |   2 +-
 13 files changed, 8 insertions(+), 1623 deletions(-)
 delete mode 100644 Documentation/cdrom/ide-cd.rst
 delete mode 100644 Documentation/ide/ChangeLog.ide-cd.1994-2004
 delete mode 100644 Documentation/ide/ChangeLog.ide-floppy.1996-2002
 delete mode 100644 Documentation/ide/ChangeLog.ide-tape.1995-2002
 delete mode 100644 Documentation/ide/changelogs.rst
 delete mode 100644 Documentation/ide/ide-tape.rst
 delete mode 100644 Documentation/ide/ide.rst
 delete mode 100644 Documentation/ide/index.rst
 delete mode 100644 Documentation/ide/warm-plug-howto.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..e7d6c6f5a6c6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1758,27 +1758,6 @@
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
-	ide-core.nodma=	[HW] (E)IDE subsystem
-			Format: =0.0 to prevent dma on hda, =0.1 hdb =1.0 hdc
-			.vlb_clock .pci_clock .noflush .nohpa .noprobe .nowerr
-			.cdrom .chs .ignore_cable are additional options
-			See Documentation/ide/ide.rst.
-
-	ide-generic.probe-mask= [HW] (E)IDE subsystem
-			Format: <int>
-			Probe mask for legacy ISA IDE ports.  Depending on
-			platform up to 6 ports are supported, enabled by
-			setting corresponding bits in the mask to 1.  The
-			default value is 0x0, which has a special meaning.
-			On systems that have PCI, it triggers scanning the
-			PCI bus for the first and the second port, which
-			are then probed.  On systems without PCI the value
-			of 0x0 enables probing the two first ports as if it
-			was 0x3.
-
-	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
-			Claim all unknown PCI IDE storage controllers.
-
 	idle=		[X86]
 			Format: idle=poll, idle=halt, idle=nomwait
 			Poll forces a polling idle loop that can slightly
diff --git a/Documentation/cdrom/ide-cd.rst b/Documentation/cdrom/ide-cd.rst
deleted file mode 100644
index bdccb74fc92d..000000000000
--- a/Documentation/cdrom/ide-cd.rst
+++ /dev/null
@@ -1,538 +0,0 @@
-IDE-CD driver documentation
-===========================
-
-:Originally by: scott snyder  <snyder@fnald0.fnal.gov> (19 May 1996)
-:Carrying on the torch is: Erik Andersen <andersee@debian.org>
-:New maintainers (19 Oct 1998): Jens Axboe <axboe@image.dk>
-
-1. Introduction
----------------
-
-The ide-cd driver should work with all ATAPI ver 1.2 to ATAPI 2.6 compliant
-CDROM drives which attach to an IDE interface.  Note that some CDROM vendors
-(including Mitsumi, Sony, Creative, Aztech, and Goldstar) have made
-both ATAPI-compliant drives and drives which use a proprietary
-interface.  If your drive uses one of those proprietary interfaces,
-this driver will not work with it (but one of the other CDROM drivers
-probably will).  This driver will not work with `ATAPI` drives which
-attach to the parallel port.  In addition, there is at least one drive
-(CyCDROM CR520ie) which attaches to the IDE port but is not ATAPI;
-this driver will not work with drives like that either (but see the
-aztcd driver).
-
-This driver provides the following features:
-
- - Reading from data tracks, and mounting ISO 9660 filesystems.
-
- - Playing audio tracks.  Most of the CDROM player programs floating
-   around should work; I usually use Workman.
-
- - Multisession support.
-
- - On drives which support it, reading digital audio data directly
-   from audio tracks.  The program cdda2wav can be used for this.
-   Note, however, that only some drives actually support this.
-
- - There is now support for CDROM changers which comply with the
-   ATAPI 2.6 draft standard (such as the NEC CDR-251).  This additional
-   functionality includes a function call to query which slot is the
-   currently selected slot, a function call to query which slots contain
-   CDs, etc. A sample program which demonstrates this functionality is
-   appended to the end of this file.  The Sanyo 3-disc changer
-   (which does not conform to the standard) is also now supported.
-   Please note the driver refers to the first CD as slot # 0.
-
-
-2. Installation
----------------
-
-0. The ide-cd relies on the ide disk driver.  See
-   Documentation/ide/ide.rst for up-to-date information on the ide
-   driver.
-
-1. Make sure that the ide and ide-cd drivers are compiled into the
-   kernel you're using.  When configuring the kernel, in the section
-   entitled "Floppy, IDE, and other block devices", say either `Y`
-   (which will compile the support directly into the kernel) or `M`
-   (to compile support as a module which can be loaded and unloaded)
-   to the options::
-
-      ATA/ATAPI/MFM/RLL support
-      Include IDE/ATAPI CDROM support
-
-   Depending on what type of IDE interface you have, you may need to
-   specify additional configuration options.  See
-   Documentation/ide/ide.rst.
-
-2. You should also ensure that the iso9660 filesystem is either
-   compiled into the kernel or available as a loadable module.  You
-   can see if a filesystem is known to the kernel by catting
-   /proc/filesystems.
-
-3. The CDROM drive should be connected to the host on an IDE
-   interface.  Each interface on a system is defined by an I/O port
-   address and an IRQ number, the standard assignments being
-   0x1f0 and 14 for the primary interface and 0x170 and 15 for the
-   secondary interface.  Each interface can control up to two devices,
-   where each device can be a hard drive, a CDROM drive, a floppy drive,
-   or a tape drive.  The two devices on an interface are called `master`
-   and `slave`; this is usually selectable via a jumper on the drive.
-
-   Linux names these devices as follows.  The master and slave devices
-   on the primary IDE interface are called `hda` and `hdb`,
-   respectively.  The drives on the secondary interface are called
-   `hdc` and `hdd`.  (Interfaces at other locations get other letters
-   in the third position; see Documentation/ide/ide.rst.)
-
-   If you want your CDROM drive to be found automatically by the
-   driver, you should make sure your IDE interface uses either the
-   primary or secondary addresses mentioned above.  In addition, if
-   the CDROM drive is the only device on the IDE interface, it should
-   be jumpered as `master`.  (If for some reason you cannot configure
-   your system in this manner, you can probably still use the driver.
-   You may have to pass extra configuration information to the kernel
-   when you boot, however.  See Documentation/ide/ide.rst for more
-   information.)
-
-4. Boot the system.  If the drive is recognized, you should see a
-   message which looks like::
-
-     hdb: NEC CD-ROM DRIVE:260, ATAPI CDROM drive
-
-   If you do not see this, see section 5 below.
-
-5. You may want to create a symbolic link /dev/cdrom pointing to the
-   actual device.  You can do this with the command::
-
-     ln -s  /dev/hdX  /dev/cdrom
-
-   where X should be replaced by the letter indicating where your
-   drive is installed.
-
-6. You should be able to see any error messages from the driver with
-   the `dmesg` command.
-
-
-3. Basic usage
---------------
-
-An ISO 9660 CDROM can be mounted by putting the disc in the drive and
-typing (as root)::
-
-  mount -t iso9660 /dev/cdrom /mnt/cdrom
-
-where it is assumed that /dev/cdrom is a link pointing to the actual
-device (as described in step 5 of the last section) and /mnt/cdrom is
-an empty directory.  You should now be able to see the contents of the
-CDROM under the /mnt/cdrom directory.  If you want to eject the CDROM,
-you must first dismount it with a command like::
-
-  umount /mnt/cdrom
-
-Note that audio CDs cannot be mounted.
-
-Some distributions set up /etc/fstab to always try to mount a CDROM
-filesystem on bootup.  It is not required to mount the CDROM in this
-manner, though, and it may be a nuisance if you change CDROMs often.
-You should feel free to remove the cdrom line from /etc/fstab and
-mount CDROMs manually if that suits you better.
-
-Multisession and photocd discs should work with no special handling.
-The hpcdtoppm package (ftp.gwdg.de:/pub/linux/hpcdtoppm/) may be
-useful for reading photocds.
-
-To play an audio CD, you should first unmount and remove any data
-CDROM.  Any of the CDROM player programs should then work (workman,
-workbone, cdplayer, etc.).
-
-On a few drives, you can read digital audio directly using a program
-such as cdda2wav.  The only types of drive which I've heard support
-this are Sony and Toshiba drives.  You will get errors if you try to
-use this function on a drive which does not support it.
-
-For supported changers, you can use the `cdchange` program (appended to
-the end of this file) to switch between changer slots.  Note that the
-drive should be unmounted before attempting this.  The program takes
-two arguments:  the CDROM device, and the slot number to which you wish
-to change.  If the slot number is -1, the drive is unloaded.
-
-
-4. Common problems
-------------------
-
-This section discusses some common problems encountered when trying to
-use the driver, and some possible solutions.  Note that if you are
-experiencing problems, you should probably also review
-Documentation/ide/ide.rst for current information about the underlying
-IDE support code.  Some of these items apply only to earlier versions
-of the driver, but are mentioned here for completeness.
-
-In most cases, you should probably check with `dmesg` for any errors
-from the driver.
-
-a. Drive is not detected during booting.
-
-   - Review the configuration instructions above and in
-     Documentation/ide/ide.rst, and check how your hardware is
-     configured.
-
-   - If your drive is the only device on an IDE interface, it should
-     be jumpered as master, if at all possible.
-
-   - If your IDE interface is not at the standard addresses of 0x170
-     or 0x1f0, you'll need to explicitly inform the driver using a
-     lilo option.  See Documentation/ide/ide.rst.  (This feature was
-     added around kernel version 1.3.30.)
-
-   - If the autoprobing is not finding your drive, you can tell the
-     driver to assume that one exists by using a lilo option of the
-     form `hdX=cdrom`, where X is the drive letter corresponding to
-     where your drive is installed.  Note that if you do this and you
-     see a boot message like::
-
-       hdX: ATAPI cdrom (?)
-
-     this does _not_ mean that the driver has successfully detected
-     the drive; rather, it means that the driver has not detected a
-     drive, but is assuming there's one there anyway because you told
-     it so.  If you actually try to do I/O to a drive defined at a
-     nonexistent or nonresponding I/O address, you'll probably get
-     errors with a status value of 0xff.
-
-   - Some IDE adapters require a nonstandard initialization sequence
-     before they'll function properly.  (If this is the case, there
-     will often be a separate MS-DOS driver just for the controller.)
-     IDE interfaces on sound cards often fall into this category.
-
-     Support for some interfaces needing extra initialization is
-     provided in later 1.3.x kernels.  You may need to turn on
-     additional kernel configuration options to get them to work;
-     see Documentation/ide/ide.rst.
-
-     Even if support is not available for your interface, you may be
-     able to get it to work with the following procedure.  First boot
-     MS-DOS and load the appropriate drivers.  Then warm-boot linux
-     (i.e., without powering off).  If this works, it can be automated
-     by running loadlin from the MS-DOS autoexec.
-
-
-b. Timeout/IRQ errors.
-
-  - If you always get timeout errors, interrupts from the drive are
-    probably not making it to the host.
-
-  - IRQ problems may also be indicated by the message
-    `IRQ probe failed (<n>)` while booting.  If <n> is zero, that
-    means that the system did not see an interrupt from the drive when
-    it was expecting one (on any feasible IRQ).  If <n> is negative,
-    that means the system saw interrupts on multiple IRQ lines, when
-    it was expecting to receive just one from the CDROM drive.
-
-  - Double-check your hardware configuration to make sure that the IRQ
-    number of your IDE interface matches what the driver expects.
-    (The usual assignments are 14 for the primary (0x1f0) interface
-    and 15 for the secondary (0x170) interface.)  Also be sure that
-    you don't have some other hardware which might be conflicting with
-    the IRQ you're using.  Also check the BIOS setup for your system;
-    some have the ability to disable individual IRQ levels, and I've
-    had one report of a system which was shipped with IRQ 15 disabled
-    by default.
-
-  - Note that many MS-DOS CDROM drivers will still function even if
-    there are hardware problems with the interrupt setup; they
-    apparently don't use interrupts.
-
-  - If you own a Pioneer DR-A24X, you _will_ get nasty error messages
-    on boot such as "irq timeout: status=0x50 { DriveReady SeekComplete }"
-    The Pioneer DR-A24X CDROM drives are fairly popular these days.
-    Unfortunately, these drives seem to become very confused when we perform
-    the standard Linux ATA disk drive probe. If you own one of these drives,
-    you can bypass the ATA probing which confuses these CDROM drives, by
-    adding `append="hdX=noprobe hdX=cdrom"` to your lilo.conf file and running
-    lilo (again where X is the drive letter corresponding to where your drive
-    is installed.)
-
-c. System hangups.
-
-  - If the system locks up when you try to access the CDROM, the most
-    likely cause is that you have a buggy IDE adapter which doesn't
-    properly handle simultaneous transactions on multiple interfaces.
-    The most notorious of these is the CMD640B chip.  This problem can
-    be worked around by specifying the `serialize` option when
-    booting.  Recent kernels should be able to detect the need for
-    this automatically in most cases, but the detection is not
-    foolproof.  See Documentation/ide/ide.rst for more information
-    about the `serialize` option and the CMD640B.
-
-  - Note that many MS-DOS CDROM drivers will work with such buggy
-    hardware, apparently because they never attempt to overlap CDROM
-    operations with other disk activity.
-
-
-d. Can't mount a CDROM.
-
-  - If you get errors from mount, it may help to check `dmesg` to see
-    if there are any more specific errors from the driver or from the
-    filesystem.
-
-  - Make sure there's a CDROM loaded in the drive, and that's it's an
-    ISO 9660 disc.  You can't mount an audio CD.
-
-  - With the CDROM in the drive and unmounted, try something like::
-
-      cat /dev/cdrom | od | more
-
-    If you see a dump, then the drive and driver are probably working
-    OK, and the problem is at the filesystem level (i.e., the CDROM is
-    not ISO 9660 or has errors in the filesystem structure).
-
-  - If you see `not a block device` errors, check that the definitions
-    of the device special files are correct.  They should be as
-    follows::
-
-      brw-rw----   1 root     disk       3,   0 Nov 11 18:48 /dev/hda
-      brw-rw----   1 root     disk       3,  64 Nov 11 18:48 /dev/hdb
-      brw-rw----   1 root     disk      22,   0 Nov 11 18:48 /dev/hdc
-      brw-rw----   1 root     disk      22,  64 Nov 11 18:48 /dev/hdd
-
-    Some early Slackware releases had these defined incorrectly.  If
-    these are wrong, you can remake them by running the script
-    scripts/MAKEDEV.ide.  (You may have to make it executable
-    with chmod first.)
-
-    If you have a /dev/cdrom symbolic link, check that it is pointing
-    to the correct device file.
-
-    If you hear people talking of the devices `hd1a` and `hd1b`, these
-    were old names for what are now called hdc and hdd.  Those names
-    should be considered obsolete.
-
-  - If mount is complaining that the iso9660 filesystem is not
-    available, but you know it is (check /proc/filesystems), you
-    probably need a newer version of mount.  Early versions would not
-    always give meaningful error messages.
-
-
-e. Directory listings are unpredictably truncated, and `dmesg` shows
-   `buffer botch` error messages from the driver.
-
-  - There was a bug in the version of the driver in 1.2.x kernels
-    which could cause this.  It was fixed in 1.3.0.  If you can't
-    upgrade, you can probably work around the problem by specifying a
-    blocksize of 2048 when mounting.  (Note that you won't be able to
-    directly execute binaries off the CDROM in that case.)
-
-    If you see this in kernels later than 1.3.0, please report it as a
-    bug.
-
-
-f. Data corruption.
-
-  - Random data corruption was occasionally observed with the Hitachi
-    CDR-7730 CDROM. If you experience data corruption, using "hdx=slow"
-    as a command line parameter may work around the problem, at the
-    expense of low system performance.
-
-
-5. cdchange.c
--------------
-
-::
-
-  /*
-   * cdchange.c  [-v]  <device>  [<slot>]
-   *
-   * This loads a CDROM from a specified slot in a changer, and displays
-   * information about the changer status.  The drive should be unmounted before
-   * using this program.
-   *
-   * Changer information is displayed if either the -v flag is specified
-   * or no slot was specified.
-   *
-   * Based on code originally from Gerhard Zuber <zuber@berlin.snafu.de>.
-   * Changer status information, and rewrite for the new Uniform CDROM driver
-   * interface by Erik Andersen <andersee@debian.org>.
-   */
-
-  #include <stdio.h>
-  #include <stdlib.h>
-  #include <errno.h>
-  #include <string.h>
-  #include <unistd.h>
-  #include <fcntl.h>
-  #include <sys/ioctl.h>
-  #include <linux/cdrom.h>
-
-
-  int
-  main (int argc, char **argv)
-  {
-	char *program;
-	char *device;
-	int fd;           /* file descriptor for CD-ROM device */
-	int status;       /* return status for system calls */
-	int verbose = 0;
-	int slot=-1, x_slot;
-	int total_slots_available;
-
-	program = argv[0];
-
-	++argv;
-	--argc;
-
-	if (argc < 1 || argc > 3) {
-		fprintf (stderr, "usage: %s [-v] <device> [<slot>]\n",
-			 program);
-		fprintf (stderr, "       Slots are numbered 1 -- n.\n");
-		exit (1);
-	}
-
-       if (strcmp (argv[0], "-v") == 0) {
-                verbose = 1;
-                ++argv;
-                --argc;
-        }
-
-	device = argv[0];
-
-	if (argc == 2)
-		slot = atoi (argv[1]) - 1;
-
-	/* open device */
-	fd = open(device, O_RDONLY | O_NONBLOCK);
-	if (fd < 0) {
-		fprintf (stderr, "%s: open failed for `%s`: %s\n",
-			 program, device, strerror (errno));
-		exit (1);
-	}
-
-	/* Check CD player status */
-	total_slots_available = ioctl (fd, CDROM_CHANGER_NSLOTS);
-	if (total_slots_available <= 1 ) {
-		fprintf (stderr, "%s: Device `%s` is not an ATAPI "
-			"compliant CD changer.\n", program, device);
-		exit (1);
-	}
-
-	if (slot >= 0) {
-		if (slot >= total_slots_available) {
-			fprintf (stderr, "Bad slot number.  "
-				 "Should be 1 -- %d.\n",
-				 total_slots_available);
-			exit (1);
-		}
-
-		/* load */
-		slot=ioctl (fd, CDROM_SELECT_DISC, slot);
-		if (slot<0) {
-			fflush(stdout);
-				perror ("CDROM_SELECT_DISC ");
-			exit(1);
-		}
-	}
-
-	if (slot < 0 || verbose) {
-
-		status=ioctl (fd, CDROM_SELECT_DISC, CDSL_CURRENT);
-		if (status<0) {
-			fflush(stdout);
-			perror (" CDROM_SELECT_DISC");
-			exit(1);
-		}
-		slot=status;
-
-		printf ("Current slot: %d\n", slot+1);
-		printf ("Total slots available: %d\n",
-			total_slots_available);
-
-		printf ("Drive status: ");
-                status = ioctl (fd, CDROM_DRIVE_STATUS, CDSL_CURRENT);
-                if (status<0) {
-                  perror(" CDROM_DRIVE_STATUS");
-                } else switch(status) {
-		case CDS_DISC_OK:
-			printf ("Ready.\n");
-			break;
-		case CDS_TRAY_OPEN:
-			printf ("Tray Open.\n");
-			break;
-		case CDS_DRIVE_NOT_READY:
-			printf ("Drive Not Ready.\n");
-			break;
-		default:
-			printf ("This Should not happen!\n");
-			break;
-		}
-
-		for (x_slot=0; x_slot<total_slots_available; x_slot++) {
-			printf ("Slot %2d: ", x_slot+1);
-			status = ioctl (fd, CDROM_DRIVE_STATUS, x_slot);
-			if (status<0) {
-			     perror(" CDROM_DRIVE_STATUS");
-			} else switch(status) {
-			case CDS_DISC_OK:
-				printf ("Disc present.");
-				break;
-			case CDS_NO_DISC:
-				printf ("Empty slot.");
-				break;
-			case CDS_TRAY_OPEN:
-				printf ("CD-ROM tray open.\n");
-				break;
-			case CDS_DRIVE_NOT_READY:
-				printf ("CD-ROM drive not ready.\n");
-				break;
-			case CDS_NO_INFO:
-				printf ("No Information available.");
-				break;
-			default:
-				printf ("This Should not happen!\n");
-				break;
-			}
-		  if (slot == x_slot) {
-                  status = ioctl (fd, CDROM_DISC_STATUS);
-                  if (status<0) {
-			perror(" CDROM_DISC_STATUS");
-                  }
-		  switch (status) {
-			case CDS_AUDIO:
-				printf ("\tAudio disc.\t");
-				break;
-			case CDS_DATA_1:
-			case CDS_DATA_2:
-				printf ("\tData disc type %d.\t", status-CDS_DATA_1+1);
-				break;
-			case CDS_XA_2_1:
-			case CDS_XA_2_2:
-				printf ("\tXA data disc type %d.\t", status-CDS_XA_2_1+1);
-				break;
-			default:
-				printf ("\tUnknown disc type 0x%x!\t", status);
-				break;
-			}
-			}
-			status = ioctl (fd, CDROM_MEDIA_CHANGED, x_slot);
-			if (status<0) {
-				perror(" CDROM_MEDIA_CHANGED");
-			}
-			switch (status) {
-			case 1:
-				printf ("Changed.\n");
-				break;
-			default:
-				printf ("\n");
-				break;
-			}
-		}
-	}
-
-	/* close device */
-	status = close (fd);
-	if (status != 0) {
-		fprintf (stderr, "%s: close failed for `%s`: %s\n",
-			 program, device, strerror (errno));
-		exit (1);
-	}
-
-	exit (0);
-  }
diff --git a/Documentation/cdrom/index.rst b/Documentation/cdrom/index.rst
index 338ad5f94e7c..e87a8785bc1a 100644
--- a/Documentation/cdrom/index.rst
+++ b/Documentation/cdrom/index.rst
@@ -8,7 +8,6 @@ cdrom
     :maxdepth: 1
 
     cdrom-standard
-    ide-cd
     packet-writing
 
 .. only::  subproject and html
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..6a0dd99786f9 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1183,85 +1183,7 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
     HRTIMER:         0          0          0          0
 	RCU:      1678       1769       2178       2250
 
-
-1.3 IDE devices in /proc/ide
-----------------------------
-
-The subdirectory /proc/ide contains information about all IDE devices of which
-the kernel  is  aware.  There is one subdirectory for each IDE controller, the
-file drivers  and a link for each IDE device, pointing to the device directory
-in the controller specific subtree.
-
-The file 'drivers' contains general information about the drivers used for the
-IDE devices::
-
-  > cat /proc/ide/drivers
-  ide-cdrom version 4.53
-  ide-disk version 1.08
-
-More detailed  information  can  be  found  in  the  controller  specific
-subdirectories. These  are  named  ide0,  ide1  and  so  on.  Each  of  these
-directories contains the files shown in table 1-6.
-
-
-.. table:: Table 1-6: IDE controller info in  /proc/ide/ide?
-
- ======= =======================================
- File    Content
- ======= =======================================
- channel IDE channel (0 or 1)
- config  Configuration (only for PCI/IDE bridge)
- mate    Mate name
- model   Type/Chipset of IDE controller
- ======= =======================================
-
-Each device  connected  to  a  controller  has  a separate subdirectory in the
-controllers directory.  The  files  listed in table 1-7 are contained in these
-directories.
-
-
-.. table:: Table 1-7: IDE device information
-
- ================ ==========================================
- File             Content
- ================ ==========================================
- cache            The cache
- capacity         Capacity of the medium (in 512Byte blocks)
- driver           driver and version
- geometry         physical and logical geometry
- identify         device identify block
- media            media type
- model            device identifier
- settings         device setup
- smart_thresholds IDE disk management thresholds
- smart_values     IDE disk management values
- ================ ==========================================
-
-The most  interesting  file is ``settings``. This file contains a nice
-overview of the drive parameters::
-
-  # cat /proc/ide/ide0/hda/settings
-  name                    value           min             max             mode
-  ----                    -----           ---             ---             ----
-  bios_cyl                526             0               65535           rw
-  bios_head               255             0               255             rw
-  bios_sect               63              0               63              rw
-  breada_readahead        4               0               127             rw
-  bswap                   0               0               1               r
-  file_readahead          72              0               2097151         rw
-  io_32bit                0               0               3               rw
-  keepsettings            0               0               1               rw
-  max_kb_per_request      122             1               127             rw
-  multcount               0               0               8               rw
-  nice1                   1               0               1               rw
-  nowerr                  0               0               1               rw
-  pio_mode                write-only      0               255             w
-  slow                    0               0               1               rw
-  unmaskirq               0               0               1               rw
-  using_dma               0               0               1               rw
-
-
-1.4 Networking info in /proc/net
+1.3 Networking info in /proc/net
 --------------------------------
 
 The subdirectory  /proc/net  follows  the  usual  pattern. Table 1-8 shows the
@@ -1340,7 +1262,7 @@ It will contain information that is specific to that bond, such as the
 current slaves of the bond, the link status of the slaves, and how
 many times the slaves link has failed.
 
-1.5 SCSI info
+1.4 SCSI info
 -------------
 
 If you  have  a  SCSI  host adapter in your system, you'll find a subdirectory
@@ -1403,7 +1325,7 @@ AHA-2940 SCSI adapter::
     Total transfers 0 (0 reads and 0 writes)
 
 
-1.6 Parallel port info in /proc/parport
+1.5 Parallel port info in /proc/parport
 ---------------------------------------
 
 The directory  /proc/parport  contains information about the parallel ports of
@@ -1428,7 +1350,7 @@ These directories contain the four files shown in Table 1-10.
            number or none).
  ========= ====================================================================
 
-1.7 TTY info in /proc/tty
+1.6 TTY info in /proc/tty
 -------------------------
 
 Information about  the  available  and actually used tty's can be found in the
@@ -1463,7 +1385,7 @@ To see  which  tty's  are  currently in use, you can simply look into the file
   unknown              /dev/tty        4    1-63 console
 
 
-1.8 Miscellaneous kernel statistics in /proc/stat
+1.7 Miscellaneous kernel statistics in /proc/stat
 -------------------------------------------------
 
 Various pieces   of  information about  kernel activity  are  available in the
@@ -1536,7 +1458,7 @@ softirqs serviced; each subsequent column is the total for that particular
 softirq.
 
 
-1.9 Ext4 file system parameters
+1.8 Ext4 file system parameters
 -------------------------------
 
 Information about mounted ext4 file systems can be found in
@@ -1552,7 +1474,7 @@ in Table 1-12, below.
  mb_groups       details of multiblock allocator buddy cache of free blocks
  ==============  ==========================================================
 
-1.10 /proc/consoles
+1.9 /proc/consoles
 -------------------
 Shows registered system console lines.
 
diff --git a/Documentation/ide/ChangeLog.ide-cd.1994-2004 b/Documentation/ide/ChangeLog.ide-cd.1994-2004
deleted file mode 100644
index 4cc3ad99f39b..000000000000
--- a/Documentation/ide/ChangeLog.ide-cd.1994-2004
+++ /dev/null
@@ -1,268 +0,0 @@
-/*
- * 1.00  Oct 31, 1994 -- Initial version.
- * 1.01  Nov  2, 1994 -- Fixed problem with starting request in
- *                       cdrom_check_status.
- * 1.03  Nov 25, 1994 -- leaving unmask_intr[] as a user-setting (as for disks)
- * (from mlord)       -- minor changes to cdrom_setup()
- *                    -- renamed ide_dev_s to ide_drive_t, enable irq on command
- * 2.00  Nov 27, 1994 -- Generalize packet command interface;
- *                       add audio ioctls.
- * 2.01  Dec  3, 1994 -- Rework packet command interface to handle devices
- *                       which send an interrupt when ready for a command.
- * 2.02  Dec 11, 1994 -- Cache the TOC in the driver.
- *                       Don't use SCMD_PLAYAUDIO_TI; it's not included
- *                       in the current version of ATAPI.
- *                       Try to use LBA instead of track or MSF addressing
- *                       when possible.
- *                       Don't wait for READY_STAT.
- * 2.03  Jan 10, 1995 -- Rewrite block read routines to handle block sizes
- *                       other than 2k and to move multiple sectors in a
- *                       single transaction.
- * 2.04  Apr 21, 1995 -- Add work-around for Creative Labs CD220E drives.
- *                       Thanks to Nick Saw <cwsaw@pts7.pts.mot.com> for
- *                       help in figuring this out.  Ditto for Acer and
- *                       Aztech drives, which seem to have the same problem.
- * 2.04b May 30, 1995 -- Fix to match changes in ide.c version 3.16 -ml
- * 2.05  Jun  8, 1995 -- Don't attempt to retry after an illegal request
- *                        or data protect error.
- *                       Use HWIF and DEV_HWIF macros as in ide.c.
- *                       Always try to do a request_sense after
- *                        a failed command.
- *                       Include an option to give textual descriptions
- *                        of ATAPI errors.
- *                       Fix a bug in handling the sector cache which
- *                        showed up if the drive returned data in 512 byte
- *                        blocks (like Pioneer drives).  Thanks to
- *                        Richard Hirst <srh@gpt.co.uk> for diagnosing this.
- *                       Properly supply the page number field in the
- *                        MODE_SELECT command.
- *                       PLAYAUDIO12 is broken on the Aztech; work around it.
- * 2.05x Aug 11, 1995 -- lots of data structure renaming/restructuring in ide.c
- *                       (my apologies to Scott, but now ide-cd.c is independent)
- * 3.00  Aug 22, 1995 -- Implement CDROMMULTISESSION ioctl.
- *                       Implement CDROMREADAUDIO ioctl (UNTESTED).
- *                       Use input_ide_data() and output_ide_data().
- *                       Add door locking.
- *                       Fix usage count leak in cdrom_open, which happened
- *                        when a read-write mount was attempted.
- *                       Try to load the disk on open.
- *                       Implement CDROMEJECT_SW ioctl (off by default).
- *                       Read total cdrom capacity during open.
- *                       Rearrange logic in cdrom_decode_status.  Issue
- *                        request sense commands for failed packet commands
- *                        from here instead of from cdrom_queue_packet_command.
- *                        Fix a race condition in retrieving error information.
- *                       Suppress printing normal unit attention errors and
- *                        some drive not ready errors.
- *                       Implement CDROMVOLREAD ioctl.
- *                       Implement CDROMREADMODE1/2 ioctls.
- *                       Fix race condition in setting up interrupt handlers
- *                        when the `serialize' option is used.
- * 3.01  Sep  2, 1995 -- Fix ordering of reenabling interrupts in
- *                        cdrom_queue_request.
- *                       Another try at using ide_[input,output]_data.
- * 3.02  Sep 16, 1995 -- Stick total disk capacity in partition table as well.
- *                       Make VERBOSE_IDE_CD_ERRORS dump failed command again.
- *                       Dump out more information for ILLEGAL REQUEST errs.
- *                       Fix handling of errors occurring before the
- *                        packet command is transferred.
- *                       Fix transfers with odd bytelengths.
- * 3.03  Oct 27, 1995 -- Some Creative drives have an id of just `CD'.
- *                       `DCI-2S10' drives are broken too.
- * 3.04  Nov 20, 1995 -- So are Vertos drives.
- * 3.05  Dec  1, 1995 -- Changes to go with overhaul of ide.c and ide-tape.c
- * 3.06  Dec 16, 1995 -- Add support needed for partitions.
- *                       More workarounds for Vertos bugs (based on patches
- *                        from Holger Dietze <dietze@aix520.informatik.uni-leipzig.de>).
- *                       Try to eliminate byteorder assumptions.
- *                       Use atapi_cdrom_subchnl struct definition.
- *                       Add STANDARD_ATAPI compilation option.
- * 3.07  Jan 29, 1996 -- More twiddling for broken drives: Sony 55D,
- *                        Vertos 300.
- *                       Add NO_DOOR_LOCKING configuration option.
- *                       Handle drive_cmd requests w/NULL args (for hdparm -t).
- *                       Work around sporadic Sony55e audio play problem.
- * 3.07a Feb 11, 1996 -- check drive->id for NULL before dereferencing, to fix
- *                        problem with "hde=cdrom" with no drive present.  -ml
- * 3.08  Mar  6, 1996 -- More Vertos workarounds.
- * 3.09  Apr  5, 1996 -- Add CDROMCLOSETRAY ioctl.
- *                       Switch to using MSF addressing for audio commands.
- *                       Reformat to match kernel tabbing style.
- *                       Add CDROM_GET_UPC ioctl.
- * 3.10  Apr 10, 1996 -- Fix compilation error with STANDARD_ATAPI.
- * 3.11  Apr 29, 1996 -- Patch from Heiko Eißfeldt <heiko@colossus.escape.de>
- *                       to remove redundant verify_area calls.
- * 3.12  May  7, 1996 -- Rudimentary changer support.  Based on patches
- *                        from Gerhard Zuber <zuber@berlin.snafu.de>.
- *                       Let open succeed even if there's no loaded disc.
- * 3.13  May 19, 1996 -- Fixes for changer code.
- * 3.14  May 29, 1996 -- Add work-around for Vertos 600.
- *                        (From Hennus Bergman <hennus@sky.ow.nl>.)
- * 3.15  July 2, 1996 -- Added support for Sanyo 3 CD changers
- *                        from Ben Galliart <bgallia@luc.edu> with
- *                        special help from Jeff Lightfoot
- *                        <jeffml@pobox.com>
- * 3.15a July 9, 1996 -- Improved Sanyo 3 CD changer identification
- * 3.16  Jul 28, 1996 -- Fix from Gadi to reduce kernel stack usage for ioctl.
- * 3.17  Sep 17, 1996 -- Tweak audio reads for some drives.
- *                       Start changing CDROMLOADFROMSLOT to CDROM_SELECT_DISC.
- * 3.18  Oct 31, 1996 -- Added module and DMA support.
- *
- * 4.00  Nov 5, 1996   -- New ide-cd maintainer,
- *                                 Erik B. Andersen <andersee@debian.org>
- *                     -- Newer Creative drives don't always set the error
- *                          register correctly.  Make sure we see media changes
- *                          regardless.
- *                     -- Integrate with generic cdrom driver.
- *                     -- CDROMGETSPINDOWN and CDROMSETSPINDOWN ioctls, based on
- *                          a patch from Ciro Cattuto <>.
- *                     -- Call set_device_ro.
- *                     -- Implement CDROMMECHANISMSTATUS and CDROMSLOTTABLE
- *                          ioctls, based on patch by Erik Andersen
- *                     -- Add some probes of drive capability during setup.
- *
- * 4.01  Nov 11, 1996  -- Split into ide-cd.c and ide-cd.h
- *                     -- Removed CDROMMECHANISMSTATUS and CDROMSLOTTABLE
- *                          ioctls in favor of a generalized approach
- *                          using the generic cdrom driver.
- *                     -- Fully integrated with the 2.1.X kernel.
- *                     -- Other stuff that I forgot (lots of changes)
- *
- * 4.02  Dec 01, 1996  -- Applied patch from Gadi Oxman <gadio@netvision.net.il>
- *                          to fix the drive door locking problems.
- *
- * 4.03  Dec 04, 1996  -- Added DSC overlap support.
- * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch
- *                          by Ales Makarov (xmakarov@sun.felk.cvut.cz)
- *
- * 4.05  Nov 20, 1997  -- Modified to print more drive info on init
- *                        Minor other changes
- *                        Fix errors on CDROMSTOP (If you have a "Dolphin",
- *                          you must define IHAVEADOLPHIN)
- *                        Added identifier so new Sanyo CD-changer works
- *                        Better detection if door locking isn't supported
- *
- * 4.06  Dec 17, 1997  -- fixed endless "tray open" messages  -ml
- * 4.07  Dec 17, 1997  -- fallback to set pc->stat on "tray open"
- * 4.08  Dec 18, 1997  -- spew less noise when tray is empty
- *                     -- fix speed display for ACER 24X, 18X
- * 4.09  Jan 04, 1998  -- fix handling of the last block so we return
- *                         an end of file instead of an I/O error (Gadi)
- * 4.10  Jan 24, 1998  -- fixed a bug so now changers can change to a new
- *                         slot when there is no disc in the current slot.
- *                     -- Fixed a memory leak where info->changer_info was
- *                         malloc'ed but never free'd when closing the device.
- *                     -- Cleaned up the global namespace a bit by making more
- *                         functions static that should already have been.
- * 4.11  Mar 12, 1998  -- Added support for the CDROM_SELECT_SPEED ioctl
- *                         based on a patch for 2.0.33 by Jelle Foks
- *                         <jelle@scintilla.utwente.nl>, a patch for 2.0.33
- *                         by Toni Giorgino <toni@pcape2.pi.infn.it>, the SCSI
- *                         version, and my own efforts.  -erik
- *                     -- Fixed a stupid bug which egcs was kind enough to
- *                         inform me of where "Illegal mode for this track"
- *                         was never returned due to a comparison on data
- *                         types of limited range.
- * 4.12  Mar 29, 1998  -- Fixed bug in CDROM_SELECT_SPEED so write speed is
- *                         now set ionly for CD-R and CD-RW drives.  I had
- *                         removed this support because it produced errors.
- *                         It produced errors _only_ for non-writers. duh.
- * 4.13  May 05, 1998  -- Suppress useless "in progress of becoming ready"
- *                         messages, since this is not an error.
- *                     -- Change error messages to be const
- *                     -- Remove a "\t" which looks ugly in the syslogs
- * 4.14  July 17, 1998 -- Change to pointing to .ps version of ATAPI spec
- *                         since the .pdf version doesn't seem to work...
- *                     -- Updated the TODO list to something more current.
- *
- * 4.15  Aug 25, 1998  -- Updated ide-cd.h to respect machine endianness,
- *                         patch thanks to "Eddie C. Dost" <ecd@skynet.be>
- *
- * 4.50  Oct 19, 1998  -- New maintainers!
- *                         Jens Axboe <axboe@image.dk>
- *                         Chris Zwilling <chris@cloudnet.com>
- *
- * 4.51  Dec 23, 1998  -- Jens Axboe <axboe@image.dk>
- *                      - ide_cdrom_reset enabled since the ide subsystem
- *                         handles resets fine now. <axboe@image.dk>
- *                      - Transfer size fix for Samsung CD-ROMs, thanks to
- *                        "Ville Hallik" <ville.hallik@mail.ee>.
- *                      - other minor stuff.
- *
- * 4.52  Jan 19, 1999  -- Jens Axboe <axboe@image.dk>
- *                      - Detect DVD-ROM/RAM drives
- *
- * 4.53  Feb 22, 1999   - Include other model Samsung and one Goldstar
- *                         drive in transfer size limit.
- *                      - Fix the I/O error when doing eject without a medium
- *                         loaded on some drives.
- *                      - CDROMREADMODE2 is now implemented through
- *                         CDROMREADRAW, since many drives don't support
- *                         MODE2 (even though ATAPI 2.6 says they must).
- *                      - Added ignore parameter to ide-cd (as a module), eg
- *                         	insmod ide-cd ignore='hda hdb'
- *                         Useful when using ide-cd in conjunction with
- *                         ide-scsi. TODO: non-modular way of doing the
- *                         same.
- *
- * 4.54  Aug 5, 1999	- Support for MMC2 class commands through the generic
- *			  packet interface to cdrom.c.
- *			- Unified audio ioctl support, most of it.
- *			- cleaned up various deprecated verify_area().
- *			- Added ide_cdrom_packet() as the interface for
- *			  the Uniform generic_packet().
- *			- bunch of other stuff, will fill in logs later.
- *			- report 1 slot for non-changers, like the other
- *			  cd-rom drivers. don't report select disc for
- *			  non-changers as well.
- *			- mask out audio playing, if the device can't do it.
- *
- * 4.55  Sep 1, 1999	- Eliminated the rest of the audio ioctls, except
- *			  for CDROMREADTOC[ENTRY|HEADER]. Some of the drivers
- *			  use this independently of the actual audio handling.
- *			  They will disappear later when I get the time to
- *			  do it cleanly.
- *			- Minimize the TOC reading - only do it when we
- *			  know a media change has occurred.
- *			- Moved all the CDROMREADx ioctls to the Uniform layer.
- *			- Heiko Eißfeldt <heiko@colossus.escape.de> supplied
- *			  some fixes for CDI.
- *			- CD-ROM leaving door locked fix from Andries
- *			  Brouwer <Andries.Brouwer@cwi.nl>
- *			- Erik Andersen <andersen@xmission.com> unified
- *			  commands across the various drivers and how
- *			  sense errors are handled.
- *
- * 4.56  Sep 12, 1999	- Removed changer support - it is now in the
- *			  Uniform layer.
- *			- Added partition based multisession handling.
- *			- Mode sense and mode select moved to the
- *			  Uniform layer.
- *			- Fixed a problem with WPI CDS-32X drive - it
- *			  failed the capabilities
- *
- * 4.57  Apr 7, 2000	- Fixed sense reporting.
- *			- Fixed possible oops in ide_cdrom_get_last_session()
- *			- Fix locking mania and make ide_cdrom_reset relock
- *			- Stop spewing errors to log when magicdev polls with
- *			  TEST_UNIT_READY on some drives.
- *			- Various fixes from Tobias Ringstrom:
- *			  tray if it was locked prior to the reset.
- *			  - cdrom_read_capacity returns one frame too little.
- *			  - Fix real capacity reporting.
- *
- * 4.58  May 1, 2000	- Clean up ACER50 stuff.
- *			- Fix small problem with ide_cdrom_capacity
- *
- * 4.59  Aug 11, 2000	- Fix changer problem in cdrom_read_toc, we weren't
- *			  correctly sensing a disc change.
- *			- Rearranged some code
- *			- Use extended sense on drives that support it for
- *			  correctly reporting tray status -- from
- *			  Michael D Johnson <johnsom@orst.edu>
- * 4.60  Dec 17, 2003	- Add mt rainier support
- *			- Bump timeout for packet commands, matches sr
- *			- Odd stuff
- * 4.61  Jan 22, 2004	- support hardware sector sizes other than 2kB,
- *			  Pascal Schmidt <der.eremit@email.de>
- */
diff --git a/Documentation/ide/ChangeLog.ide-floppy.1996-2002 b/Documentation/ide/ChangeLog.ide-floppy.1996-2002
deleted file mode 100644
index 46c19ef32a9e..000000000000
--- a/Documentation/ide/ChangeLog.ide-floppy.1996-2002
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Many thanks to Lode Leroy <Lode.Leroy@www.ibase.be>, who tested so many
- * ALPHA patches to this driver on an EASYSTOR LS-120 ATAPI floppy drive.
- *
- * Ver 0.1   Oct 17 96   Initial test version, mostly based on ide-tape.c.
- * Ver 0.2   Oct 31 96   Minor changes.
- * Ver 0.3   Dec  2 96   Fixed error recovery bug.
- * Ver 0.4   Jan 26 97   Add support for the HDIO_GETGEO ioctl.
- * Ver 0.5   Feb 21 97   Add partitions support.
- *                       Use the minimum of the LBA and CHS capacities.
- *                       Avoid hwgroup->rq == NULL on the last irq.
- *                       Fix potential null dereferencing with DEBUG_LOG.
- * Ver 0.8   Dec  7 97   Increase irq timeout from 10 to 50 seconds.
- *                       Add media write-protect detection.
- *                       Issue START command only if TEST UNIT READY fails.
- *                       Add work-around for IOMEGA ZIP revision 21.D.
- *                       Remove idefloppy_get_capabilities().
- * Ver 0.9   Jul  4 99   Fix a bug which might have caused the number of
- *                        bytes requested on each interrupt to be zero.
- *                        Thanks to <shanos@es.co.nz> for pointing this out.
- * Ver 0.9.sv Jan 6 01   Sam Varshavchik <mrsam@courier-mta.com>
- *                       Implement low level formatting.  Reimplemented
- *                       IDEFLOPPY_CAPABILITIES_PAGE, since we need the srfp
- *                       bit.  My LS-120 drive barfs on
- *                       IDEFLOPPY_CAPABILITIES_PAGE, but maybe it's just me.
- *                       Compromise by not reporting a failure to get this
- *                       mode page.  Implemented four IOCTLs in order to
- *                       implement formatting.  IOCTls begin with 0x4600,
- *                       0x46 is 'F' as in Format.
- *            Jan 9 01   Userland option to select format verify.
- *                       Added PC_SUPPRESS_ERROR flag - some idefloppy drives
- *                       do not implement IDEFLOPPY_CAPABILITIES_PAGE, and
- *                       return a sense error.  Suppress error reporting in
- *                       this particular case in order to avoid spurious
- *                       errors in syslog.  The culprit is
- *                       idefloppy_get_capability_page(), so move it to
- *                       idefloppy_begin_format() so that it's not used
- *                       unless absolutely necessary.
- *                       If drive does not support format progress indication
- *                       monitor the dsc bit in the status register.
- *                       Also, O_NDELAY on open will allow the device to be
- *                       opened without a disk available.  This can be used to
- *                       open an unformatted disk, or get the device capacity.
- * Ver 0.91  Dec 11 99   Added IOMEGA Clik! drive support by
- *     		   <paul@paulbristow.net>
- * Ver 0.92  Oct 22 00   Paul Bristow became official maintainer for this
- *           		   driver.  Included Powerbook internal zip kludge.
- * Ver 0.93  Oct 24 00   Fixed bugs for Clik! drive
- *                        no disk on insert and disk change now works
- * Ver 0.94  Oct 27 00   Tidied up to remove strstr(Clik) everywhere
- * Ver 0.95  Nov  7 00   Brought across to kernel 2.4
- * Ver 0.96  Jan  7 01   Actually in line with release version of 2.4.0
- *                       including set_bit patch from Rusty Russell
- * Ver 0.97  Jul 22 01   Merge 0.91-0.96 onto 0.9.sv for ac series
- * Ver 0.97.sv Aug 3 01  Backported from 2.4.7-ac3
- * Ver 0.98  Oct 26 01   Split idefloppy_transfer_pc into two pieces to
- *                        fix a lost interrupt problem. It appears the busy
- *                        bit was being deasserted by my IOMEGA ATAPI ZIP 100
- *                        drive before the drive was actually ready.
- * Ver 0.98a Oct 29 01   Expose delay value so we can play.
- * Ver 0.99  Feb 24 02   Remove duplicate code, modify clik! detection code
- *                        to support new PocketZip drives
- */
diff --git a/Documentation/ide/ChangeLog.ide-tape.1995-2002 b/Documentation/ide/ChangeLog.ide-tape.1995-2002
deleted file mode 100644
index 877fac8770b3..000000000000
--- a/Documentation/ide/ChangeLog.ide-tape.1995-2002
+++ /dev/null
@@ -1,257 +0,0 @@
-/*
- * Ver 0.1   Nov  1 95   Pre-working code :-)
- * Ver 0.2   Nov 23 95   A short backup (few megabytes) and restore procedure
- *                        was successful ! (Using tar cvf ... on the block
- *                        device interface).
- *                       A longer backup resulted in major swapping, bad
- *                        overall Linux performance and eventually failed as
- *                        we received non serial read-ahead requests from the
- *                        buffer cache.
- * Ver 0.3   Nov 28 95   Long backups are now possible, thanks to the
- *                        character device interface. Linux's responsiveness
- *                        and performance doesn't seem to be much affected
- *                        from the background backup procedure.
- *                       Some general mtio.h magnetic tape operations are
- *                        now supported by our character device. As a result,
- *                        popular tape utilities are starting to work with
- *                        ide tapes :-)
- *                       The following configurations were tested:
- *                       1. An IDE ATAPI TAPE shares the same interface
- *                        and irq with an IDE ATAPI CDROM.
- *                       2. An IDE ATAPI TAPE shares the same interface
- *                        and irq with a normal IDE disk.
- *                        Both configurations seemed to work just fine !
- *                        However, to be on the safe side, it is meanwhile
- *                        recommended to give the IDE TAPE its own interface
- *                        and irq.
- *                       The one thing which needs to be done here is to
- *                        add a "request postpone" feature to ide.c,
- *                        so that we won't have to wait for the tape to finish
- *                        performing a long media access (DSC) request (such
- *                        as a rewind) before we can access the other device
- *                        on the same interface. This effect doesn't disturb
- *                        normal operation most of the time because read/write
- *                        requests are relatively fast, and once we are
- *                        performing one tape r/w request, a lot of requests
- *                        from the other device can be queued and ide.c will
- *			  service all of them after this single tape request.
- * Ver 1.0   Dec 11 95   Integrated into Linux 1.3.46 development tree.
- *                       On each read / write request, we now ask the drive
- *                        if we can transfer a constant number of bytes
- *                        (a parameter of the drive) only to its buffers,
- *                        without causing actual media access. If we can't,
- *                        we just wait until we can by polling the DSC bit.
- *                        This ensures that while we are not transferring
- *                        more bytes than the constant referred to above, the
- *                        interrupt latency will not become too high and
- *                        we won't cause an interrupt timeout, as happened
- *                        occasionally in the previous version.
- *                       While polling for DSC, the current request is
- *                        postponed and ide.c is free to handle requests from
- *                        the other device. This is handled transparently to
- *                        ide.c. The hwgroup locking method which was used
- *                        in the previous version was removed.
- *                       Use of new general features which are provided by
- *                        ide.c for use with atapi devices.
- *                        (Programming done by Mark Lord)
- *                       Few potential bug fixes (Again, suggested by Mark)
- *                       Single character device data transfers are now
- *                        not limited in size, as they were before.
- *                       We are asking the tape about its recommended
- *                        transfer unit and send a larger data transfer
- *                        as several transfers of the above size.
- *                        For best results, use an integral number of this
- *                        basic unit (which is shown during driver
- *                        initialization). I will soon add an ioctl to get
- *                        this important parameter.
- *                       Our data transfer buffer is allocated on startup,
- *                        rather than before each data transfer. This should
- *                        ensure that we will indeed have a data buffer.
- * Ver 1.1   Dec 14 95   Fixed random problems which occurred when the tape
- *                        shared an interface with another device.
- *                        (poll_for_dsc was a complete mess).
- *                       Removed some old (non-active) code which had
- *                        to do with supporting buffer cache originated
- *                        requests.
- *                       The block device interface can now be opened, so
- *                        that general ide driver features like the unmask
- *                        interrupts flag can be selected with an ioctl.
- *                        This is the only use of the block device interface.
- *                       New fast pipelined operation mode (currently only on
- *                        writes). When using the pipelined mode, the
- *                        throughput can potentially reach the maximum
- *                        tape supported throughput, regardless of the
- *                        user backup program. On my tape drive, it sometimes
- *                        boosted performance by a factor of 2. Pipelined
- *                        mode is enabled by default, but since it has a few
- *                        downfalls as well, you may want to disable it.
- *                        A short explanation of the pipelined operation mode
- *                        is available below.
- * Ver 1.2   Jan  1 96   Eliminated pipelined mode race condition.
- *                       Added pipeline read mode. As a result, restores
- *                        are now as fast as backups.
- *                       Optimized shared interface behavior. The new behavior
- *                        typically results in better IDE bus efficiency and
- *                        higher tape throughput.
- *                       Pre-calculation of the expected read/write request
- *                        service time, based on the tape's parameters. In
- *                        the pipelined operation mode, this allows us to
- *                        adjust our polling frequency to a much lower value,
- *                        and thus to dramatically reduce our load on Linux,
- *                        without any decrease in performance.
- *                       Implemented additional mtio.h operations.
- *                       The recommended user block size is returned by
- *                        the MTIOCGET ioctl.
- *                       Additional minor changes.
- * Ver 1.3   Feb  9 96   Fixed pipelined read mode bug which prevented the
- *                        use of some block sizes during a restore procedure.
- *                       The character device interface will now present a
- *                        continuous view of the media - any mix of block sizes
- *                        during a backup/restore procedure is supported. The
- *                        driver will buffer the requests internally and
- *                        convert them to the tape's recommended transfer
- *                        unit, making performance almost independent of the
- *                        chosen user block size.
- *                       Some improvements in error recovery.
- *                       By cooperating with ide-dma.c, bus mastering DMA can
- *                        now sometimes be used with IDE tape drives as well.
- *                        Bus mastering DMA has the potential to dramatically
- *                        reduce the CPU's overhead when accessing the device,
- *                        and can be enabled by using hdparm -d1 on the tape's
- *                        block device interface. For more info, read the
- *                        comments in ide-dma.c.
- * Ver 1.4   Mar 13 96   Fixed serialize support.
- * Ver 1.5   Apr 12 96   Fixed shared interface operation, broken in 1.3.85.
- *                       Fixed pipelined read mode inefficiency.
- *                       Fixed nasty null dereferencing bug.
- * Ver 1.6   Aug 16 96   Fixed FPU usage in the driver.
- *                       Fixed end of media bug.
- * Ver 1.7   Sep 10 96   Minor changes for the CONNER CTT8000-A model.
- * Ver 1.8   Sep 26 96   Attempt to find a better balance between good
- *                        interactive response and high system throughput.
- * Ver 1.9   Nov  5 96   Automatically cross encountered filemarks rather
- *                        than requiring an explicit FSF command.
- *                       Abort pending requests at end of media.
- *                       MTTELL was sometimes returning incorrect results.
- *                       Return the real block size in the MTIOCGET ioctl.
- *                       Some error recovery bug fixes.
- * Ver 1.10  Nov  5 96   Major reorganization.
- *                       Reduced CPU overhead a bit by eliminating internal
- *                        bounce buffers.
- *                       Added module support.
- *                       Added multiple tape drives support.
- *                       Added partition support.
- *                       Rewrote DSC handling.
- *                       Some portability fixes.
- *                       Removed ide-tape.h.
- *                       Additional minor changes.
- * Ver 1.11  Dec  2 96   Bug fix in previous DSC timeout handling.
- *                       Use ide_stall_queue() for DSC overlap.
- *                       Use the maximum speed rather than the current speed
- *                        to compute the request service time.
- * Ver 1.12  Dec  7 97   Fix random memory overwriting and/or last block data
- *                        corruption, which could occur if the total number
- *                        of bytes written to the tape was not an integral
- *                        number of tape blocks.
- *                       Add support for INTERRUPT DRQ devices.
- * Ver 1.13  Jan  2 98   Add "speed == 0" work-around for HP COLORADO 5GB
- * Ver 1.14  Dec 30 98   Partial fixes for the Sony/AIWA tape drives.
- *                       Replace cli()/sti() with hwgroup spinlocks.
- * Ver 1.15  Mar 25 99   Fix SMP race condition by replacing hwgroup
- *                        spinlock with private per-tape spinlock.
- * Ver 1.16  Sep  1 99   Add OnStream tape support.
- *                       Abort read pipeline on EOD.
- *                       Wait for the tape to become ready in case it returns
- *                        "in the process of becoming ready" on open().
- *                       Fix zero padding of the last written block in
- *                        case the tape block size is larger than PAGE_SIZE.
- *                       Decrease the default disconnection time to tn.
- * Ver 1.16e Oct  3 99   Minor fixes.
- * Ver 1.16e1 Oct 13 99  Patches by Arnold Niessen,
- *                          niessen@iae.nl / arnold.niessen@philips.com
- *                   GO-1)  Undefined code in idetape_read_position
- *				according to Gadi's email
- *                   AJN-1) Minor fix asc == 11 should be asc == 0x11
- *                               in idetape_issue_packet_command (did effect
- *                               debugging output only)
- *                   AJN-2) Added more debugging output, and
- *                              added ide-tape: where missing. I would also
- *				like to add tape->name where possible
- *                   AJN-3) Added different debug_level's
- *                              via /proc/ide/hdc/settings
- *				"debug_level" determines amount of debugging output;
- *				can be changed using /proc/ide/hdx/settings
- *				0 : almost no debugging output
- *				1 : 0+output errors only
- *				2 : 1+output all sensekey/asc
- *				3 : 2+follow all chrdev related procedures
- *				4 : 3+follow all procedures
- *				5 : 4+include pc_stack rq_stack info
- *				6 : 5+USE_COUNT updates
- *                   AJN-4) Fixed timeout for retension in idetape_queue_pc_tail
- *				from 5 to 10 minutes
- *                   AJN-5) Changed maximum number of blocks to skip when
- *                              reading tapes with multiple consecutive write
- *                              errors from 100 to 1000 in idetape_get_logical_blk
- *                   Proposed changes to code:
- *                   1) output "logical_blk_num" via /proc
- *                   2) output "current_operation" via /proc
- *                   3) Either solve or document the fact that `mt rewind' is
- *                      required after reading from /dev/nhtx to be
- *			able to rmmod the idetape module;
- *			Also, sometimes an application finishes but the
- *			device remains `busy' for some time. Same cause ?
- *                   Proposed changes to release-notes:
- *		     4) write a simple `quickstart' section in the
- *                      release notes; I volunteer if you don't want to
- *		     5) include a pointer to video4linux in the doc
- *                      to stimulate video applications
- *                   6) release notes lines 331 and 362: explain what happens
- *			if the application data rate is higher than 1100 KB/s;
- *			similar approach to lower-than-500 kB/s ?
- *		     7) 6.6 Comparison; wouldn't it be better to allow different
- *			strategies for read and write ?
- *			Wouldn't it be better to control the tape buffer
- *			contents instead of the bandwidth ?
- *		     8) line 536: replace will by would (if I understand
- *			this section correctly, a hypothetical and unwanted situation
- *			 is being described)
- * Ver 1.16f Dec 15 99   Change place of the secondary OnStream header frames.
- * Ver 1.17  Nov 2000 / Jan 2001  Marcel Mol, marcel@mesa.nl
- *			- Add idetape_onstream_mode_sense_tape_parameter_page
- *			  function to get tape capacity in frames: tape->capacity.
- *			- Add support for DI-50 drives( or any DI- drive).
- *			- 'workaround' for read error/blank block around block 3000.
- *			- Implement Early warning for end of media for Onstream.
- *			- Cosmetic code changes for readability.
- *			- Idetape_position_tape should not use SKIP bit during
- *			  Onstream read recovery.
- *			- Add capacity, logical_blk_num and first/last_frame_position
- *			  to /proc/ide/hd?/settings.
- *			- Module use count was gone in the Linux 2.4 driver.
- * Ver 1.17a Apr 2001 Willem Riede osst@riede.org
- *			- Get drive's actual block size from mode sense block descriptor
- *			- Limit size of pipeline
- * Ver 1.17b Oct 2002   Alan Stern <stern@rowland.harvard.edu>
- *			Changed IDETAPE_MIN_PIPELINE_STAGES to 1 and actually used
- *			 it in the code!
- *			Actually removed aborted stages in idetape_abort_pipeline
- *			 instead of just changing the command code.
- *			Made the transfer byte count for Request Sense equal to the
- *			 actual length of the data transfer.
- *			Changed handling of partial data transfers: they do not
- *			 cause DMA errors.
- *			Moved initiation of DMA transfers to the correct place.
- *			Removed reference to unallocated memory.
- *			Made __idetape_discard_read_pipeline return the number of
- *			 sectors skipped, not the number of stages.
- *			Replaced errant kfree() calls with __idetape_kfree_stage().
- *			Fixed off-by-one error in testing the pipeline length.
- *			Fixed handling of filemarks in the read pipeline.
- *			Small code optimization for MTBSF and MTBSFM ioctls.
- *			Don't try to unlock the door during device close if is
- *			 already unlocked!
- *			Cosmetic fixes to miscellaneous debugging output messages.
- *			Set the minimum /proc/ide/hd?/settings values for "pipeline",
- *			 "pipeline_min", and "pipeline_max" to 1.
- */
diff --git a/Documentation/ide/changelogs.rst b/Documentation/ide/changelogs.rst
deleted file mode 100644
index fdf9d0fb8027..000000000000
--- a/Documentation/ide/changelogs.rst
+++ /dev/null
@@ -1,17 +0,0 @@
-Changelog for ide cd
---------------------
-
- .. include:: ChangeLog.ide-cd.1994-2004
-    :literal:
-
-Changelog for ide floppy
-------------------------
-
- .. include:: ChangeLog.ide-floppy.1996-2002
-    :literal:
-
-Changelog for ide tape
-----------------------
-
- .. include:: ChangeLog.ide-tape.1995-2002
-    :literal:
diff --git a/Documentation/ide/ide-tape.rst b/Documentation/ide/ide-tape.rst
deleted file mode 100644
index 3e061d9c0e38..000000000000
--- a/Documentation/ide/ide-tape.rst
+++ /dev/null
@@ -1,68 +0,0 @@
-===============================
-IDE ATAPI streaming tape driver
-===============================
-
-This driver is a part of the Linux ide driver.
-
-The driver, in co-operation with ide.c, basically traverses the
-request-list for the block device interface. The character device
-interface, on the other hand, creates new requests, adds them
-to the request-list of the block device, and waits for their completion.
-
-The block device major and minor numbers are determined from the
-tape's relative position in the ide interfaces, as explained in ide.c.
-
-The character device interface consists of the following devices::
-
-  ht0		major 37, minor 0	first  IDE tape, rewind on close.
-  ht1		major 37, minor 1	second IDE tape, rewind on close.
-  ...
-  nht0		major 37, minor 128	first  IDE tape, no rewind on close.
-  nht1		major 37, minor 129	second IDE tape, no rewind on close.
-  ...
-
-The general magnetic tape commands compatible interface, as defined by
-include/linux/mtio.h, is accessible through the character device.
-
-General ide driver configuration options, such as the interrupt-unmask
-flag, can be configured by issuing an ioctl to the block device interface,
-as any other ide device.
-
-Our own ide-tape ioctl's can be issued to either the block device or
-the character device interface.
-
-Maximal throughput with minimal bus load will usually be achieved in the
-following scenario:
-
-     1.	ide-tape is operating in the pipelined operation mode.
-     2.	No buffering is performed by the user backup program.
-
-Testing was done with a 2 GB CONNER CTMA 4000 IDE ATAPI Streaming Tape Drive.
-
-Here are some words from the first releases of hd.c, which are quoted
-in ide.c and apply here as well:
-
-* Special care is recommended.  Have Fun!
-
-Possible improvements
-=====================
-
-1. Support for the ATAPI overlap protocol.
-
-In order to maximize bus throughput, we currently use the DSC
-overlap method which enables ide.c to service requests from the
-other device while the tape is busy executing a command. The
-DSC overlap method involves polling the tape's status register
-for the DSC bit, and servicing the other device while the tape
-isn't ready.
-
-In the current QIC development standard (December 1995),
-it is recommended that new tape drives will *in addition*
-implement the ATAPI overlap protocol, which is used for the
-same purpose - efficient use of the IDE bus, but is interrupt
-driven and thus has much less CPU overhead.
-
-ATAPI overlap is likely to be supported in most new ATAPI
-devices, including new ATAPI cdroms, and thus provides us
-a method by which we can achieve higher throughput when
-sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
diff --git a/Documentation/ide/ide.rst b/Documentation/ide/ide.rst
deleted file mode 100644
index 88bdcba92f7d..000000000000
--- a/Documentation/ide/ide.rst
+++ /dev/null
@@ -1,265 +0,0 @@
-============================================
-Information regarding the Enhanced IDE drive
-============================================
-
-   The hdparm utility can be used to control various IDE features on a
-   running system. It is packaged separately.  Please Look for it on popular
-   linux FTP sites.
-
--------------------------------------------------------------------------------
-
-.. important::
-
-   BUGGY IDE CHIPSETS CAN CORRUPT DATA!!
-
-    PCI versions of the CMD640 and RZ1000 interfaces are now detected
-    automatically at startup when PCI BIOS support is configured.
-
-    Linux disables the "prefetch" ("readahead") mode of the RZ1000
-    to prevent data corruption possible due to hardware design flaws.
-
-    For the CMD640, linux disables "IRQ unmasking" (hdparm -u1) on any
-    drive for which the "prefetch" mode of the CMD640 is turned on.
-    If "prefetch" is disabled (hdparm -p8), then "IRQ unmasking" can be
-    used again.
-
-    For the CMD640, linux disables "32bit I/O" (hdparm -c1) on any drive
-    for which the "prefetch" mode of the CMD640 is turned off.
-    If "prefetch" is enabled (hdparm -p9), then "32bit I/O" can be
-    used again.
-
-    The CMD640 is also used on some Vesa Local Bus (VLB) cards, and is *NOT*
-    automatically detected by Linux.  For safe, reliable operation with such
-    interfaces, one *MUST* use the "cmd640.probe_vlb" kernel option.
-
-    Use of the "serialize" option is no longer necessary.
-
--------------------------------------------------------------------------------
-
-Common pitfalls
-===============
-
-- 40-conductor IDE cables are capable of transferring data in DMA modes up to
-  udma2, but no faster.
-
-- If possible devices should be attached to separate channels if they are
-  available. Typically the disk on the first and CD-ROM on the second.
-
-- If you mix devices on the same cable, please consider using similar devices
-  in respect of the data transfer mode they support.
-
-- Even better try to stick to the same vendor and device type on the same
-  cable.
-
-This is the multiple IDE interface driver, as evolved from hd.c
-===============================================================
-
-It supports up to 9 IDE interfaces per default, on one or more IRQs (usually
-14 & 15).  There can be up to two drives per interface, as per the ATA-6 spec.::
-
-  Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
-  Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
-  Tertiary:   ide2, port 0x1e8; major=33; hde is minor=0; hdf is minor=64
-  Quaternary: ide3, port 0x168; major=34; hdg is minor=0; hdh is minor=64
-  fifth..     ide4, usually PCI, probed
-  sixth..     ide5, usually PCI, probed
-
-To access devices on interfaces > ide0, device entries please make sure that
-device files for them are present in /dev.  If not, please create such
-entries, by using /dev/MAKEDEV.
-
-This driver automatically probes for most IDE interfaces (including all PCI
-ones), for the drives/geometries attached to those interfaces, and for the IRQ
-lines being used by the interfaces (normally 14, 15 for ide0/ide1).
-
-Any number of interfaces may share a single IRQ if necessary, at a slight
-performance penalty, whether on separate cards or a single VLB card.
-The IDE driver automatically detects and handles this.  However, this may
-or may not be harmful to your hardware.. two or more cards driving the same IRQ
-can potentially burn each other's bus driver, though in practice this
-seldom occurs.  Be careful, and if in doubt, don't do it!
-
-Drives are normally found by auto-probing and/or examining the CMOS/BIOS data.
-For really weird situations, the apparent (fdisk) geometry can also be specified
-on the kernel "command line" using LILO.  The format of such lines is::
-
-	ide_core.chs=[interface_number.device_number]:cyls,heads,sects
-
-or::
-
-	ide_core.cdrom=[interface_number.device_number]
-
-For example::
-
-	ide_core.chs=1.0:1050,32,64  ide_core.cdrom=1.1
-
-The results of successful auto-probing may override the physical geometry/irq
-specified, though the "original" geometry may be retained as the "logical"
-geometry for partitioning purposes (fdisk).
-
-If the auto-probing during boot time confuses a drive (ie. the drive works
-with hd.c but not with ide.c), then an command line option may be specified
-for each drive for which you'd like the drive to skip the hardware
-probe/identification sequence.  For example::
-
-	ide_core.noprobe=0.1
-
-or::
-
-	ide_core.chs=1.0:768,16,32
-	ide_core.noprobe=1.0
-
-Note that when only one IDE device is attached to an interface, it should be
-jumpered as "single" or "master", *not* "slave".  Many folks have had
-"trouble" with cdroms because of this requirement, so the driver now probes
-for both units, though success is more likely when the drive is jumpered
-correctly.
-
-Courtesy of Scott Snyder and others, the driver supports ATAPI cdrom drives
-such as the NEC-260 and the new MITSUMI triple/quad speed drives.
-Such drives will be identified at boot time, just like a hard disk.
-
-If for some reason your cdrom drive is *not* found at boot time, you can force
-the probe to look harder by supplying a kernel command line parameter
-via LILO, such as:::
-
-	ide_core.cdrom=1.0	/* "master" on second interface (hdc) */
-
-or::
-
-	ide_core.cdrom=1.1	/* "slave" on second interface (hdd) */
-
-For example, a GW2000 system might have a hard drive on the primary
-interface (/dev/hda) and an IDE cdrom drive on the secondary interface
-(/dev/hdc).  To mount a CD in the cdrom drive, one would use something like::
-
-	ln -sf /dev/hdc /dev/cdrom
-	mkdir /mnt/cdrom
-	mount /dev/cdrom /mnt/cdrom -t iso9660 -o ro
-
-If, after doing all of the above, mount doesn't work and you see
-errors from the driver (with dmesg) complaining about `status=0xff`,
-this means that the hardware is not responding to the driver's attempts
-to read it.  One of the following is probably the problem:
-
-  - Your hardware is broken.
-
-  - You are using the wrong address for the device, or you have the
-    drive jumpered wrong.  Review the configuration instructions above.
-
-  - Your IDE controller requires some nonstandard initialization sequence
-    before it will work properly.  If this is the case, there will often
-    be a separate MS-DOS driver just for the controller.  IDE interfaces
-    on sound cards usually fall into this category.  Such configurations
-    can often be made to work by first booting MS-DOS, loading the
-    appropriate drivers, and then warm-booting linux (without powering
-    off).  This can be automated using loadlin in the MS-DOS autoexec.
-
-If you always get timeout errors, interrupts from the drive are probably
-not making it to the host.  Check how you have the hardware jumpered
-and make sure it matches what the driver expects (see the configuration
-instructions above).  If you have a PCI system, also check the BIOS
-setup; I've had one report of a system which was shipped with IRQ 15
-disabled by the BIOS.
-
-The kernel is able to execute binaries directly off of the cdrom,
-provided it is mounted with the default block size of 1024 (as above).
-
-Please pass on any feedback on any of this stuff to the maintainer,
-whose address can be found in linux/MAINTAINERS.
-
-The IDE driver is modularized.  The high level disk/CD-ROM/tape/floppy
-drivers can always be compiled as loadable modules, the chipset drivers
-can only be compiled into the kernel, and the core code (ide.c) can be
-compiled as a loadable module provided no chipset support is needed.
-
-When using ide.c as a module in combination with kmod, add::
-
-	alias block-major-3 ide-probe
-
-to a configuration file in /etc/modprobe.d/.
-
-When ide.c is used as a module, you can pass command line parameters to the
-driver using the "options=" keyword to insmod, while replacing any ',' with
-';'.
-
-
-Summary of ide driver parameters for kernel command line
-========================================================
-
-For legacy IDE VLB host drivers (ali14xx/dtc2278/ht6560b/qd65xx/umc8672)
-you need to explicitly enable probing by using "probe" kernel parameter,
-i.e. to enable probing for ALI M14xx chipsets (ali14xx host driver) use:
-
-* "ali14xx.probe" boot option when ali14xx driver is built-in the kernel
-
-* "probe" module parameter when ali14xx driver is compiled as module
-  ("modprobe ali14xx probe")
-
-Also for legacy CMD640 host driver (cmd640) you need to use "probe_vlb"
-kernel paremeter to enable probing for VLB version of the chipset (PCI ones
-are detected automatically).
-
-You also need to use "probe" kernel parameter for ide-4drives driver
-(support for IDE generic chipset with four drives on one port).
-
-To enable support for IDE doublers on Amiga use "doubler" kernel parameter
-for gayle host driver (i.e. "gayle.doubler" if the driver is built-in).
-
-To force ignoring cable detection (this should be needed only if you're using
-short 40-wires cable which cannot be automatically detected - if this is not
-a case please report it as a bug instead) use "ignore_cable" kernel parameter:
-
-* "ide_core.ignore_cable=[interface_number]" boot option if IDE is built-in
-  (i.e. "ide_core.ignore_cable=1" to force ignoring cable for "ide1")
-
-* "ignore_cable=[interface_number]" module parameter (for ide_core module)
-  if IDE is compiled as module
-
-Other kernel parameters for ide_core are:
-
-* "nodma=[interface_number.device_number]" to disallow DMA for a device
-
-* "noflush=[interface_number.device_number]" to disable flush requests
-
-* "nohpa=[interface_number.device_number]" to disable Host Protected Area
-
-* "noprobe=[interface_number.device_number]" to skip probing
-
-* "nowerr=[interface_number.device_number]" to ignore the WRERR_STAT bit
-
-* "cdrom=[interface_number.device_number]" to force device as a CD-ROM
-
-* "chs=[interface_number.device_number]" to force device as a disk (using CHS)
-
-
-Some Terminology
-================
-
-IDE
-  Integrated Drive Electronics, meaning that each drive has a built-in
-  controller, which is why an "IDE interface card" is not a "controller card".
-
-ATA
-  AT (the old IBM 286 computer) Attachment Interface, a draft American
-  National Standard for connecting hard drives to PCs.  This is the official
-  name for "IDE".
-
-  The latest standards define some enhancements, known as the ATA-6 spec,
-  which grew out of vendor-specific "Enhanced IDE" (EIDE) implementations.
-
-ATAPI
-  ATA Packet Interface, a new protocol for controlling the drives,
-  similar to SCSI protocols, created at the same time as the ATA2 standard.
-  ATAPI is currently used for controlling CDROM, TAPE and FLOPPY (ZIP or
-  LS120/240) devices, removable R/W cartridges, and for high capacity hard disk
-  drives.
-
-mlord@pobox.com
-
-
-Wed Apr 17 22:52:44 CEST 2002 edited by Marcin Dalecki, the current
-maintainer.
-
-Wed Aug 20 22:31:29 CEST 2003 updated ide boot options to current ide.c
-comments at 2.6.0-test4 time. Maciej Soltysiak <solt@dns.toxicfilms.tv>
diff --git a/Documentation/ide/index.rst b/Documentation/ide/index.rst
deleted file mode 100644
index 813dfe611a31..000000000000
--- a/Documentation/ide/index.rst
+++ /dev/null
@@ -1,21 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-==================================
-Integrated Drive Electronics (IDE)
-==================================
-
-.. toctree::
-    :maxdepth: 1
-
-    ide
-    ide-tape
-    warm-plug-howto
-
-    changelogs
-
-.. only::  subproject and html
-
-   Indices
-   =======
-
-   * :ref:`genindex`
diff --git a/Documentation/ide/warm-plug-howto.rst b/Documentation/ide/warm-plug-howto.rst
deleted file mode 100644
index c245242ef2f1..000000000000
--- a/Documentation/ide/warm-plug-howto.rst
+++ /dev/null
@@ -1,18 +0,0 @@
-===================
-IDE warm-plug HOWTO
-===================
-
-To warm-plug devices on a port 'idex'::
-
-	# echo -n "1" > /sys/class/ide_port/idex/delete_devices
-
-unplug old device(s) and plug new device(s)::
-
-	# echo -n "1" > /sys/class/ide_port/idex/scan
-
-done
-
-NOTE: please make sure that partitions are unmounted and that there are
-no other active references to devices before doing "delete_devices" step,
-also do not attempt "scan" step on devices currently in use -- otherwise
-results may be unpredictable and lead to data loss if you're unlucky
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 86c8794ede41..a3a43ab8582d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -12,7 +12,7 @@
  * Theory of operation:
  *
  * At the lowest level, there is the standard driver for the CD/DVD device,
- * typically ide-cd.c or sr.c. This driver can handle read and write requests,
+ * such as drivers/scsi/sr.c. This driver can handle read and write requests,
  * but it doesn't know anything about the special restrictions that apply to
  * packet writing. One restriction is that write requests must be aligned to
  * packet boundaries on the physical media, and the size of a write request
-- 
2.33.0

