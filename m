Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925C24D6348
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbiCKOTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiCKOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:19:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F549119F00
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:18:41 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BDTCW1029467;
        Fri, 11 Mar 2022 14:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Qy8F67MnbhoV2EvV6dtq0vsTBfGRqjKRt2v3zgtZw10=;
 b=fEwzRaZcnjIwP4ua0hqvr4q5vzYLBeGN5UhnCd7IiZc1MWsZPzngKIZ6YHRi7KfTDZXj
 NrWpr0eG4o2GijqJfIfhfqeKO64FadGKqPLjkocphKUlWgv87sxsTYxt/+XITafmQiE5
 ziLwSNJXRX56FizTctox566qr/EvnT4KnZAKcqOO7D23ta+fRa4p8GK/onGF6VVEmSF5
 /XLyKeX/UX74A1DmgzpOeNXdEp3q9iRBgk6Xpv7UzeKjluEaecBkC88R/Zic1diK3xYY
 K+Fz9szKRNMdjWzKlJg84oRDp5daMwKtwuXUq+JTIOJs8Kplrj6Zs93AulWEDGmsnazi MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2saqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 14:18:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BECVdq024357;
        Fri, 11 Mar 2022 14:18:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3ekvyxmsdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 14:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edDwlj6k728NErkfpXFcthMjS/5qD6GypPSgHvFHL5MQEXOqqGxOaAclziUAuT3e7eZtIre+QMj0VYpsmTthJTYE0NDvXAF2+0PPwLE5LY2m67KtPFpOGaGPHZtgPR4XYx8h83b34mkbYEdhxcwn7KlJ6w+jddXxmqoV3g/+nm/7J68+NhP/TNa4rzAeIC/bOiNepS0QhcO9s0BXeieHA0TSEzU2Gb8KuQxnmAF+IZuXe4CiNdRp2yNrefti2xqWyi3pnpBwE+VkT6qzZe2iwFTqE79WgRcrICZvVHiJt2w0o/iZ4xfVYHEtV4XCP9eQ7maT3l+co2x+goEQcbaNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qy8F67MnbhoV2EvV6dtq0vsTBfGRqjKRt2v3zgtZw10=;
 b=Pyw+GW1mG9r0jzFnwwabBjUj33s4iW231wQNuwG6i9wljV9PCTvP1P+OShcBDuIsvMsw04xJADmib6wR6hTZXEUN+Oe4G9e21DIRli1V8CiagqWN3GAKVLQb8+F7ucqVSty+pJtVhRjsY0hweT1sFRKT0w2sigyB1oIwqlwdoBVz6J2pDHlr3tZWNVUc5PX4QbviT3Kt9POPBqyc/9MCUC5o0PZ8nnzB+kGWjdY2suXEvkjF7g99zKEyBqEYwBKwSTEFhmwE/rOKjYI0f+nGnERGyWleKHAeWL11L/9NK8mxJQgKZX2XEXe5cJeXRwAX+XCSE8xrK3U9hPUENd7HSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy8F67MnbhoV2EvV6dtq0vsTBfGRqjKRt2v3zgtZw10=;
 b=w4kLrvuJzY/qrU1WuleiYJNzO9m3exd33XxUgltlJGI6Ukzpv9yDH6UhPeEYOI2621MYLhSPZwMdyTKgsyBro9U9mENuZZ8qKlhEwLrKPYCd5ORvsY2qH7TxvHY+tIt5Btvus22oBiRAZMneg3Vto1mAxhTrTjvOnAIrCJ5V7A8=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4272.namprd10.prod.outlook.com (2603:10b6:208:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 14:18:26 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%7]) with mapi id 15.20.5061.023; Fri, 11 Mar 2022
 14:18:25 +0000
Message-ID: <da0efe1c-1d02-3c45-482a-b92ac314e211@oracle.com>
Date:   Fri, 11 Mar 2022 09:18:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH] xen: use time_is_before_eq_jiffies() instead of open
 coding it
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1646018104-61415-1-git-send-email-wangqing@vivo.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1646018104-61415-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e595bd-750d-4e3b-8bd5-08da036a0125
X-MS-TrafficTypeDiagnostic: MN2PR10MB4272:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB42723CDF35B9FE052EB602AF8A0C9@MN2PR10MB4272.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVfNnIaP3vNEO0bnxsaTuPjb4L9ponjaJ9Volmv6xUBEjcO/mU+v89kCdPgjyH7sJri6ghT8SuugGxFdWVE+V/WHWEYB99QdOGc0D4c8155Ck1WYS+N1Nf0IwWvolmEvL3SUT0HFSW7f8JtPWdmgLQj6PEl9NSSEai/o2on+JCFaYfgn71yW9csOSfqY7eoqOrE765UyFbWKUlrXGwoIliaf2e5DrgzoicovJd2uEF+kaKfgjuYzUK3k7NAY5t0tZmtk74VSJIbPuuCyWzn45JBQi5H4ZnBPxNFqkQJAQ96A0j6d+ZctXyiVcGpXI1poyG0nNbo/t6pBM0Sj/f3EfU3aYeZTA5NFGaZjF/IEwkjjvrzry55H0LZjULkqBsIT88Fev2qVlpUX4smbUYL4rJl2ivsHF7y3embNszl8blnIq/TI9ku5HO1NjjEQz6YL4ABaAWZf3vlvyc8AGCpIJ8cLWpchiXgzxsG7JmKRcFcMBOrrTUWyUXNUWqxgJytBlptpdsPOyNYL4Z7wllNJAKUirNijtcLFcaHhdDe7GxKU+W8NL1msVOZ52lUK7jsa3ULcBns7gzcamewQA+smuHbMUcPIbzhZzR/VkEJIPth0hvls6MwItDoLV5eY/1Z3qAlWg2be3t4eZfGrGK080ZnOnnOglN7Xmrcvbedg3rN7cEDuN4mfIILbMny/UJaoNZD5ISRndeKYN7bV+Ime67sYUl5Zn+eRZKFD6GSj7KU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(508600001)(6486002)(6666004)(66556008)(66476007)(86362001)(8676002)(316002)(31696002)(110136005)(26005)(186003)(6512007)(6506007)(38100700002)(53546011)(2616005)(31686004)(2906002)(558084003)(36756003)(8936002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjY1ZThRWFFYaXBBMGRJc3NrVlpLbFJrL1NVMGtLb3hxUUsrclN3cEE4UUIy?=
 =?utf-8?B?azJ6NzM2eTVkR1hUUkxFNTNpaHNiL1JLaUtQbG5GdVFVOHFzN2dKM1cvekYz?=
 =?utf-8?B?TER4aEJySVAxc1BVYit5NUF1WTN4cGtWMlNNTkZKQ3Mwb3o4N01IOVFSeHc0?=
 =?utf-8?B?MVhPd2Q4KzdkMFhzejdjVXpTbkF6MmVmNGZNMDEzU2RQeWNYNDhKYzVzMHJI?=
 =?utf-8?B?TVpieFVHSnJhMms4UTM0WlNnYW9EYzA5aFNLckZnbVJyUXlhMW9wbGphMTZO?=
 =?utf-8?B?RkQvNEFWcXMvZ3d1aE1mNkp3endPTXF1RWhjektCbFZZZGpTUmxzU1YxZGlW?=
 =?utf-8?B?aTV1bzduY3ZGbmdPeFNQbHhvdUZFUEhvSjNVZGVLUkhCajNHN2hJOVhjVFVy?=
 =?utf-8?B?akNTNVN5Ujh6QzlOQWJkVEVJU0dKNzJhM2R1UDVieDZsU09QenNaTllKOWZU?=
 =?utf-8?B?VDhlOEM2MGdzVm1UOEJTc29iU3diMTl1MEh2U2g1dTdEc2RtREZ1U2FjR2Zp?=
 =?utf-8?B?WDhWbUhqTVhsQWV2cWtyNUlyWk5udHhCd2RsRzJmTUk0RHJxc3JTcFlIK1lp?=
 =?utf-8?B?bFlXM3ByNjAxVEpDUjdoNDNsa3NUcFFkTUJvMk1Jei92ZGJyZ0w1WGNaQmth?=
 =?utf-8?B?VmxaMzM2VjBiU0ROVHIzMjZDOVJwWW9lNUF2dWs3WEQ4bERtK3VBWXN1NVRS?=
 =?utf-8?B?a0hMUVE3RGtEdEp0dkxUd1Z1Uy8xdlhCY0FFS0NZWU1BT1RiQUw5Q2h6V3dF?=
 =?utf-8?B?SnFEeG9WNzQxaFhndFlwVE5KWmlsVEFLbW5GRlhpMDdqSmRzcjRMdmphSXJp?=
 =?utf-8?B?SE80TXdaNVdodGdwczExdHowV3FTNyswMm1SR3RJclV1V1FSNnFYNVllUEFo?=
 =?utf-8?B?bEs0dUtFRkZaRG5OM2NTUHIxZGhGb2IvN3krY1RHTnM5eDVLb1ZYUDJRWmJM?=
 =?utf-8?B?Rm95RXlUTjRvK293Uk1KNG1CMUpuTFJRdGQyZHRUQjVNR0hteHFETkd0MnU5?=
 =?utf-8?B?MVY1Y2JGWEJhZzF2WVR3NkxXWHE3aFM2eHhneUxScGErWXQ3dHFYUG8xbGdn?=
 =?utf-8?B?VkplNFI2dUlnUlFZZGMwZks5SWE4TnB2UFVmOVdUbThJV3pUbnE4Q3lxVk9Z?=
 =?utf-8?B?eTdPUTR6cTBZeDE0M0Jsb3dWdytZZ213UE8yOFhpdzhBM3BiVnFWeHNNTlFZ?=
 =?utf-8?B?MUZaaFRqc0wzK1RhRmN6alZHMlZZMmJpRkp5b2dwc2huV1E4S1V5ekRjckpE?=
 =?utf-8?B?SDArV0pBbVBRQ0lYd1RDY0p6dWcvcHJzTDdtRVA2VmFoZmVLbFhMeUV4Y2pQ?=
 =?utf-8?B?MklEaTFkS0l6bm1sb1h6eFZ2KzlGZ0JyWGJPWTlzNWZkWURTTkJGZUlpbVBn?=
 =?utf-8?B?SkJjZTVtTlZiL0czdUJabTFEUk8zd3hTM0gyUkFpMDl5N3V1NWprbXFGVE5R?=
 =?utf-8?B?ZHNSUjFZdGNzM0lydXV4WENGWVlWa0xGMmtYQkdwNzJrUHB0bzVyQTlPK1Nn?=
 =?utf-8?B?dGZjcEl2akZWdWtmTkdaMVM4MUJvbU5uSHhaQjhHY1BDYnFZMHp0cE1xSUhW?=
 =?utf-8?B?SUNLQ1ptNk82U0RySGpRWWFlMXFYR0hFajljM3hlNzl2dVhRUE9CSmhmNWpa?=
 =?utf-8?B?SmZYSkxYZUl3RitRaU4rWlFrcWF1ZVVlM0lxV1VhdFNMRW1OVm5Nd05OTWFF?=
 =?utf-8?B?aE0yVWozWUdnc1FCVm1nbXVWK0ZoZFB2WTBsRUlGZjcxbjFqeEVkTm8xMnVF?=
 =?utf-8?B?OThoaEVpVitZcGE1bmVMaDYrVFh5QS9ybC95YnZwZXF5OG5QSWRjOG9PZGgx?=
 =?utf-8?B?UUhaWE1VVWZ1Y0hEMGpLUEdRUUZZTjV3Y1ZsOEtzSWJweXNodXZRRzJLaFpx?=
 =?utf-8?B?Q2VCL2hXd3dCZENyWCtncU42RXVVaDFieHNMaUlITEUvLy96ZVhvNlpKbWtz?=
 =?utf-8?B?SUJHelJmZVVQUEZJMTBxcTlsWGF6VGRSdzB6TEowUmpLMzV6cGZRQWFQL1l0?=
 =?utf-8?B?SDZGZ1dibGd3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e595bd-750d-4e3b-8bd5-08da036a0125
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 14:18:25.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTIpCaTnipPcHh+8MEGKnDt2hP7qWo8qr8CxADQQKp+2ZD6UucqVQoqrU17X06LLtXtSaOZE61Ian7gi7GnVtR1K/u4GhBQVF73W0BLy0q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4272
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110070
X-Proofpoint-ORIG-GUID: DKb-WaV8DylUQLM_UEA3d-5ONZG8-IeW
X-Proofpoint-GUID: DKb-WaV8DylUQLM_UEA3d-5ONZG8-IeW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/27/22 10:15 PM, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
>
> Use the helper function time_is_{before,after}_jiffies() to improve
> code readability.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


Applied to for-linus-5.18

