Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA04DBA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350125AbiCPVtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiCPVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:48:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB51DAC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:47:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GLECbl018264;
        Wed, 16 Mar 2022 21:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SQrzOtnMG/wcNwNmnSt9cDGGmhrYkh0Z85FxZnyOaRA=;
 b=lXtGiSLMQIAvpMScQmGku8zIoaJuax13keI7aQu/B0C9m70yL1FJUQm3x5qxz/ojgjTu
 dNlvAIPj8J8fdzsVFThEkCWeQ7aSxT6znLrdLDN/GhFIgNttuNltCR/GOmEqkIuLwg8C
 6WhcZdktmdHngB0tf1HYJ1R4qX4qgvORuxavt/k36AQhBWK2lC8weobERaOvUBevkkfR
 Ld3zYE5xEqe9FXtCogBOi3dVfxXdErWs8OO2ecYUTKweogRmN5aBJTeRXEQI8SNLBtpH
 Y9TmcvVlKixF4TMxVUHlrAkJ9KbBqkxXkPNWbaBaGCctfVpE6RTS03DJ/W6GgVOnOfxZ lg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rqn52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 21:47:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GLlXmU176458;
        Wed, 16 Mar 2022 21:47:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by aserp3030.oracle.com with ESMTP id 3et64u0stp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 21:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9zhUtagWbnlXshAFU4nCdukOJTXnKzK9qu44xrj1jH9Q1OvuyB7a5p4U460w8R9wuCsuTxNpdOnydkQt1pJbREb7fIBOMXVcAU9Ac1n7Q4mBXsgcoZ7ljXTypkP+nVeT1O+Nq/ysQCfinfvyI8ULp/Rio29yiKNHn5lCiUT4/T7NSVXPMOmPzof4L2kuoWhtm1Vl3IR2LWToYIzW44AoAYYPOsfoQWnum1NgcCZa7Rh1CFOTjTDn9Q8OzZUO0WXOV2kMpjFySGMe2YvVNiveEWoCnQaLYmQcNMeQMsbQFNmDkEUAWoLo8ATNitSMXeKrvQYKOS52Ic5jnbCKf2Lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQrzOtnMG/wcNwNmnSt9cDGGmhrYkh0Z85FxZnyOaRA=;
 b=gs3FwZngx1mudAtVV0O5ph7oRe2Kn7x35DyTc5PCo+mExQe3uSzFt+SakfJuaewxrrCl7ScWaUpWpLJ3EDqMVgef05Nc62LAjqysVGXA/ryI6m4kPpzdNq5nv7wI66ke/exlvwq3kK8R4j1Yw7bFrdGMz1Si43kC7AHT3ESlkqv2RVPFjUSsbb6VYTsgp8iWJL/M6St8M+lz9uVYKy4Oc+IkdaQHlZZ7tTkEvf9xqbCA31PN3wqOPnUaIN/MhzuGPMgpFfqQlWqlVRZqFjrdFQ0cmpAqbeiBKYhDEQ0luPoEdBjzjQPTZVXUGjFWFXJxjlTKwGTqGehVmLXk7YGVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQrzOtnMG/wcNwNmnSt9cDGGmhrYkh0Z85FxZnyOaRA=;
 b=DReRNtuW2N1W1fwSAiMOMEJbsdlW0XD77Lto5EjrzTQ25UeFrZtUAMmAroZMIfepzrmUevuMKSbIMo5xKUiAdTwKOT1V3KBpLpXNQz7jXH5t1ZGeo2KPDPGauBjL+ek40KekFulVZbw9m6G4hqY5P2XRETMmINSWoClVRaZ29ws=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL0PR10MB3010.namprd10.prod.outlook.com (2603:10b6:208:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 21:47:31 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%9]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 21:47:31 +0000
Message-ID: <2bb2c005-ae5b-22ad-2431-2bd3ed0f89f8@oracle.com>
Date:   Wed, 16 Mar 2022 17:47:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] xen/grant-table: remove gnttab_*transfer*() functions
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220311103429.12845-1-jgross@suse.com>
 <20220311103429.12845-2-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220311103429.12845-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e72ff0b-4265-4b8f-f12c-08da07969271
X-MS-TrafficTypeDiagnostic: BL0PR10MB3010:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB3010FD7F007E6A35234DC9128A119@BL0PR10MB3010.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m256VaKIqs22MZ9qF21JmI6ExdHuJUMS/uvCtDf7HLrPUXG6iCZxH1HfKndJvMJQQfepNRPfs5+LLcMRZ/loJME0vHsRSvqwus5V++EjxAWsnKfh6VFAdXJC682HQlDBctFRrGhzGE79DYX+lcp0m19xJSsysyoNOLmSS7Kyeejp6akLnSbo6qFkHtkaDGI9dkfiyUY09cpGjxUxNemSXn/JTa/wwwAgN1i3PWSnBwK8KEed176LA5j/JbePeci6P/KkjKxjbqW8AyBbIyJWpLkZsq1pvvkMMgq4acELNLUacaEn5UE9ZSyR1XXkJMAC/hztnw5bb0RgPznK4LZqFI73E5olLvDdnjD7cBCrl+I8bQT2bgOVE2icFmwFlglpYTLhTPy6KLxNwLVNY8Mc1A72dQLpuAmrEzl7ZVLpIb3BscunSXV08/p0BAn3PRTu8/Gx1dMjlKpT/T4vMtahT85ch4FVMUb0s8Wdp1zHck8lt6hACB92DqWfeKFzYO0x4eFCQOy1cVddHUAQHqf59gFPzkZdMJ9kLBZicjAJqU4r2MR9uPPeEKsa41dLzw8DyRr4jW+E8tmS2sUmLC7oG7fd0W33bNgMIBR9hRoezrkTCBVldC4uLQ5sigtfCqncLAvq6G7vYdYwp2lWBuDSnxsrdotwgOh8QVBmNeZzCQ/lv1EVKhZABf2hJgxe8V4T02D0YrV3APA4IYl/4iqoSZb94crF0A+Es32ICWV0zRJLDtevoWavNa/0EwnCQjnN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(508600001)(186003)(44832011)(4744005)(6666004)(8676002)(4326008)(6486002)(8936002)(66556008)(66476007)(66946007)(5660300002)(6512007)(316002)(2906002)(31696002)(38100700002)(6506007)(2616005)(36756003)(31686004)(86362001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNwcjNnZEljVmRkNmJPVEhOVnU5di8vaU9tZWRpL1hUSXhoNGM4MUIzQzZS?=
 =?utf-8?B?b3h2VzMyOC9ta1NyZGowdFlkZ1ZFWFlKaWpnNmJ3dmd4SWsvclREdElsNlJP?=
 =?utf-8?B?ZFdKLzZ5MjRCcVZPc0U4RWRWL1V3c0twUTNqZDJEUlBBeUd3RVJNcFFuUDRt?=
 =?utf-8?B?WHZmaUxsTWlGWTlIZ3FMNE12RDhSR0Jwd0lIMTA0Vm1mMUtFb3pBQkxZbWxI?=
 =?utf-8?B?aUV5M0JrNWxJNzRWTzh6bEZYWThlbE9QZlhqOVE5ZlNvNS9adXovVWdNNEo4?=
 =?utf-8?B?aHNBdWVlTWdVazlKUUgzTHdqRTFqazYyaXlyM0hYSDUvZzJmbFFsejRjT2t6?=
 =?utf-8?B?VTFIN3dVc1Y5aWt0ODBkeVZDYmM1MTRhMDZneE43TSt5aDFqMWRkM3NpbWxM?=
 =?utf-8?B?TVVsZ1NBMEh1bW41TnA1aE80SjZoMU9PMXp6RlBBRGx1SThWd0ZybVl1aTRJ?=
 =?utf-8?B?WVk0YkhDakFnT01HOUhBSTg5TnhCbVhuUi9Hd2ZSc2N2U2JyQWtIS3hhYkts?=
 =?utf-8?B?UDZrOWpLdytHUmVzR0wyQ2F6NmI1U2cvZm5WeGw1MkNyNVNxbmZHc3ZiM2lB?=
 =?utf-8?B?YVNmL1RMSTFYakh5QmNuUnhqV3VFK01UWStub3p4b3F5ZUowV3drS2FoZnll?=
 =?utf-8?B?emVtcjBZN3VrMWdQeEliTkVGbUxFbzNoZE94YnlKenhQS0NlVFhHTTM5QUUz?=
 =?utf-8?B?MUNTdGIrRDY3WERhTDBpaDU5T2txS2dOdFMwSEZyWDJuM3poNU83UnREaCtv?=
 =?utf-8?B?MXQxa05DRHBrdldKd2loK3dvL0hNTzc3dTRxTThaR3EwZWFiNlREeXljcjU3?=
 =?utf-8?B?OUtYNDNQR2srUGdtU2VwM1dxdWRPNVBueVdaazlOMm5pOTNuMGJMZGZweExm?=
 =?utf-8?B?MW92UE9UcFBzc0RlVktpMkRFa1NLMDlsRFFiUDErejdTWVZCQ2JWWHRaUUpx?=
 =?utf-8?B?YVpnVVF1QVRqRzZzcDJUa2Fhdm8wczRhSUJMZzlNbi9PS0VJK0VJdjdlMEhW?=
 =?utf-8?B?SlJWV2F6Z3k0L3lmU2h3NE04RzVsZnRIMWM4UG5mQWwrSnp0eGtJWDVhMk8r?=
 =?utf-8?B?U1k0TkcvWXV4MUIwanJSamtDZUM5UDA3WEtCYk9nVEFJVHlBRjVOVkd4YlAx?=
 =?utf-8?B?aEhIdzZ3TnY5V2NQK1k5ZXZXZzRyVDg0c0MzMVc5WE5EUVFHVDJNK1lQOHV2?=
 =?utf-8?B?cktTSFNsRnloV3ZtVEQ1Z3VTWGNMNll2aTZMcDZvRWZvS0MyUXpzc0lQWTdN?=
 =?utf-8?B?VnI3bnlTeG0wK05BTnlWMVpuVGc4VmxjTHNOcHNxem5PNjVoVERnNUZVMUJX?=
 =?utf-8?B?MDZDN2IyeHdYN1p3aW9QSXdYcTh5OGZnSUZweWVKcnB5WjRPb1hKdEE3dVRF?=
 =?utf-8?B?cURRMGxDL2FiREQ1Q3hOeHNUZVZSRDlLbWZCRkNhQklZd0tNcGxpb2k5RW1z?=
 =?utf-8?B?MnBXT2QwZXFXekIxdStjVzc3L2h5L0JPTVdKZDhlYk9TNnZobWdkam9JTTFz?=
 =?utf-8?B?TjBCQy9FMDlJTS9TZU96Zk1kWVlZZldleTl5dnJ1Z0p0eXpnSVpMZEdRb0JZ?=
 =?utf-8?B?eGVXZDJKd09HUm9qcHFsM05aR2NiUE4vOG4vSnI3VjNQVkFSMFo4REFHeUNt?=
 =?utf-8?B?Z2xhZGFDT2ZrUEQrdVZSNXoxb3JETkEvMHZFM1NBeEdrU0FEbERVcHRQODBW?=
 =?utf-8?B?RGlEWFppb3h1VUE5ZTFVYzk2VllMa2dEaTN6M0JTdGNWU0hWVUhIcStXcmoz?=
 =?utf-8?B?R1hJQkkrREZvc1Bxd2lLcWJSbGJDNEk0Q1ZnRmFUK3lQNlR2eWdsbUhqNTBT?=
 =?utf-8?B?WXNHTG50RUY5N1BjeFFETlJNT0VpTXBOdUFSU0NFa0JuTE4zMzVINWhjblhz?=
 =?utf-8?B?RnN1N1pOcWF3MHh3RHpIUmFCSWtSM0Q2a0JvU3BXRjBzb094SFhFREdqMkNI?=
 =?utf-8?B?cXJ5bW4wK01YTVJVNlc4aFJWbFl4dG9HNmh4clJ6MHM0cGRjR1BpN2NBK1My?=
 =?utf-8?B?bTZjM0g4Qkd3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e72ff0b-4265-4b8f-f12c-08da07969271
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 21:47:31.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTD9L/df1lFOH/NU5HLQhc8tptAiZzgUMz6c97UjpyU8HJY+mTgAxevQF3hXhq9o2I+Y4Tk5fZ5ZmoDvgB0tTSbcV1yIBD/X8t7Ha6tg/Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3010
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203160130
X-Proofpoint-ORIG-GUID: 3q97bpQdqQmetV7m1i-HmLRXH01CVMtm
X-Proofpoint-GUID: 3q97bpQdqQmetV7m1i-HmLRXH01CVMtm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/22 5:34 AM, Juergen Gross wrote:
> All grant table operations related to the "transfer" functionality
> are unused currently. There have been users in the old days of the
> "Xen-o-Linux" kernel, but those didn't make it upstream.
>
> So remove the "transfer" related functions.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Applied to for-linus-5.18 (both patches)

