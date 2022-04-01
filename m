Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07C4EED90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbiDAM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbiDAM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:58:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1307627680D;
        Fri,  1 Apr 2022 05:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WauzdSEYunVkg7WKvuYfi/gZ1qE42kuS8/wAdSvfu+G6OeXBCQWc1ocJFy6euztl/dUjZYfEFHwiqv2d5NWeEZ6bA6WnB3BVL5KV4kp7WDXt7veyi00Fqpg+LsOOfoqOVy23PDLHq5FzkKA8QJuLA2pHvQf0mgO9F3fnDVInWTps7xBAn7oqQAkOQuS6JryqMNuG/fbbEHOGPw1rOM6EF8KU4PJtNirAVkgRtZ8JnXk+PdwPWI0pVn0SDuBMxQvQfi2UIHBI8BbQJcRZBupDRzmZhw9fVB+PqCaw7fkfJoKcy/LOxOukOxGd5Wwx1nFjKftsiLULj7r2lO5f2XPWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIl/l+pCDm37kyPGkK+osXC9OCTBfKcMxCRu2wtkNuQ=;
 b=Oln4ScyMlXKO6ihfW4TeVXTFjFDqShyJeLBm3Xkv6uMYZtTZVtoydSSo/pjnm4M+trYWwQVsIqSh5vvV6K7c8koqPpAZbGhD4jHIFUeUZOHC8nnhew4n547VTFpQnNTV7nujv8kNnYYPLmPprwN/Kb5NTv2pYQ1zFgv+x9eXIirsPG65sPpzAseDIRvKtTdBaFAkSvxXONhDAoX161xspRJ+AcLCX/rurtyKXWc0zrTKw3NU7Rh6H0d8yuL3A+k8/9Akf9p2cQ/pfWhZ36j6e8o6U121GxXkiIOpbtsZ44ijtxHy9CFO2zJHOTK32tz+OKhYfaS8OtYEIWT5WXEyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIl/l+pCDm37kyPGkK+osXC9OCTBfKcMxCRu2wtkNuQ=;
 b=jnNqISWhSHR5q81VvkNTtFS4xojoG+6/G/ZmurJPt7gwgRtjbpdiHIfLHrAAJL7m6bhSkM/soaRX4A8xiQ7cp2z4KFPCE428uPKNLdFXUmvJCZVAJZUgI3yD7W0l0vFMbON33uWHHVEpi5MO13Al+4BeznbnUg2AgC3GJEW5y7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MW4PR19MB5630.namprd19.prod.outlook.com (2603:10b6:303:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 12:57:04 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::7c8f:fda5:16fa:a104]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::7c8f:fda5:16fa:a104%4]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 12:57:04 +0000
Message-ID: <484841f1-85fa-06b8-5697-ade829e3fff3@ddn.com>
Date:   Fri, 1 Apr 2022 14:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fix certs compilation / export is_key_on_revocation_list
Content-Language: en-US
From:   Bernd Schubert <bschubert@ddn.com>
To:     David Howells <dhowells@redhat.com>,
        "\"David Woodhouse" <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <ce5bc8c0-2c6d-2a22-1ad3-357254686366@ddn.com>
 <e92ef2ea-bb1c-8a8d-2e25-c784a784b995@ddn.com>
 <ca485dfa-58e7-6a09-97b0-dbf7cde7a7e2@ddn.com>
In-Reply-To: <ca485dfa-58e7-6a09-97b0-dbf7cde7a7e2@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc1075a-47b8-432a-fb37-08da13df1ec2
X-MS-TrafficTypeDiagnostic: MW4PR19MB5630:EE_
X-Microsoft-Antispam-PRVS: <MW4PR19MB56300B889A6F4A996FA03F95B5E09@MW4PR19MB5630.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfzZflh5RPIuPgWoeWjJPMjvGaZOCT48jF/pEqCkv968vQa8lyKT13GTyXAfRxgbidboRx4jKNLruU2oGOj5Vid8eCHNgJX/6rvcMSpasrlNcvv9gnWtXvYeTt9CwztpXOhASJdfSC54JFWQkF+nDUB3Lz/YiGIGY2qk4FgEP0peM5mzqe8JHkrPD/m/lDjxTGZ8T3EF8WWETXgXhdX69u9MCAIdkhXrNybhF6fNAk3ZdsX0OcVorXk2uiD+plS7NG1vnPoGUXZtwsoTqpelK9MB9PhtShgZFhZmg5xX68uSFHGIC+qvWNbq+R2M4f643YazOcN+32McY1H7RlSSGMRoyWjXVmxrudn28jFAT9df9UXkLRXYSPzaLmcRAjiSVgCD96L62ZwQtZ6UOWL9kZaEmBWAUqzdchFPPxAWVauywupjuOLO4IfoDcftT1Cs8/gfXCpgyCYrVL41k3ljBsnZmMcoUEVkYI3LrLozBVvx1XGclwog3xzi/RTzkjnlkLjYpgxeFLEvjqpas+qDA/Mqzhv486i53Q86CeNWix//vAVFagHzgl91VSkmFkfXYtz8UKwjFy6DR8430YMxSwXkowD5vYBupsA23k2F+uf78ze++MIM8bpSezx01OZqZbxXz14008Ndw/n+Dn6jU/bpJjcIFgRQDknVw7/D8D4Yo79mLH7nUj/oTf63Un4XogIvrhI7lyckK9KIm89VKQOKSjR2n22P33nVKYHaDTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(86362001)(38100700002)(31696002)(6486002)(316002)(110136005)(6666004)(6506007)(8676002)(5660300002)(6512007)(66556008)(66476007)(66946007)(53546011)(2906002)(36756003)(2616005)(4744005)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lMWDJ5bUsvTGVxbi9FRDc3WkVSMW0rMTVKZktzSHJ1YUU5NlFrM3BNMVhz?=
 =?utf-8?B?UW1ZalVES09XcGp3T3BPU2hXcjF6ME4ycUk0SzlyaGticnp5KzhhSkVOeTVw?=
 =?utf-8?B?UkdFWUdXOVNFalFNQlJZN2JSRk9wVXpFSjFrT1dEQkdhNUlkRFI3eFNQZ3Qw?=
 =?utf-8?B?SzRjV1FpYjJkOUJQV2U3WndiVmI2ZzBIN3YzRVd1SFV5dTA1eW9KUDFGUFdt?=
 =?utf-8?B?OXZkZWtSZkloa0k4a1pLQTlSVkVVbG9ZbVVJc01BTm1nclhQZTRNU0ptSzRy?=
 =?utf-8?B?alJLd3g5ZExLazdFdVgrTjRoN0xKL01icU43R0JHa3BNMFNaVkhJVmM5Ky9E?=
 =?utf-8?B?MWFmN2dzZFhKb1h0VTZkZXNQSW5aYXQ4cmltREFyUktPQW1tOTd0ckpXNzBV?=
 =?utf-8?B?QzRwTXMyUnNrR1NNcmNTd3BGbjVEdG83OGoyR1lNVEdkYS93MVY0L3M5L2VM?=
 =?utf-8?B?bmJuWnBSeDI0QUViVHVYTU5HOGNrTUU0SXJtMFZEMFkrSW9kT2tseTRtWnhj?=
 =?utf-8?B?ckk2dFFqSFJzaG52WjcyOFJlaEJuOWZpd1p2dm9mdGxSV1hGMnlseURobGd0?=
 =?utf-8?B?ckFGM0RIdzM2dG1yY2QwR3BjV2x2OFhSWWxUVHkrWi9oWFFmTmt3NU5Xb1VO?=
 =?utf-8?B?Wjd6ejZMTUJMK0JadlVyZm9aN1QwcUdySm9MdUJ2eTJ3Z1hEZFJJT3Z0L0Yr?=
 =?utf-8?B?ZFJrTnY0bkR3c21LSUtQNVErWkVuamNCbU1tbWVaMURVYTJNMnZvcEVRUGFp?=
 =?utf-8?B?Z05XOFhQQjcvYnlia21hTnBtNEdxQklja0J3YmtvMUlwM0hJOVY2N090dHU1?=
 =?utf-8?B?UGwvbWkrK1FPZTlldFBNY2gvUE83S3NrWHJpWldyZkZSQ2tmbjFqZUhWYmJo?=
 =?utf-8?B?dDdIUTN4WCtEa2d0azc4bnhLRktzcy9mL3piSGRZQXZBUC96d1dyY2ZoTUg2?=
 =?utf-8?B?UEg2NmxKOWZobzI5UTNMY3o0RHEvbGJxOGgxbHVKWnI5Zzh0a28yWkxVU3VU?=
 =?utf-8?B?Z0tCTVJkL1p5SHphZXBsQURCdjQ3NGVnWmI2TWhQdmZ5MDlBVEhPY3RteHZi?=
 =?utf-8?B?V3N6ZHVhbkx5VHN2TDF3S1h1YWdJLzUxcXZlaW8vKy9tcG9hVXc4eDVZWXd5?=
 =?utf-8?B?aCtNdGNNTFdNVVBWTkN6d2M2RlBWZTNWT3NkS3FkSjhSVHgwM1BOeWFqajhB?=
 =?utf-8?B?dlEwb3dWQWQrQlB4TGJkc2FrSlorYjJMVFZpNUdIRG4xYWhwZDRHTC9iVThB?=
 =?utf-8?B?dURBTm8rQVN5cEE1dGRScmV3WXVnTGh4SzhvcnFycnJJMitEN01JT0JFeU5a?=
 =?utf-8?B?Y0JTMVNrd3dBMEYyOXVWWWlsZkdsZmpqQXliWTN1d0xpWmwxT2FsZVZTNnVX?=
 =?utf-8?B?N0M5NEt0OHY1azU1SDVwY0FNZHl1dlpWd3UvczNHSkxSYnBJcEYxRHVKZXFa?=
 =?utf-8?B?dGF3Wk01N2RWamhUd1ZGLzYvN3FER01sZGQ1aHlmQTZRdEdCYVhITVpyeFlL?=
 =?utf-8?B?a0dBQWRjZ0RTd2dia0hEbC82UEFqcTZxbHRqdVp1VlM5c09Rd3JZQ3QxVGc4?=
 =?utf-8?B?K3QyTW1zeHdiRW9LMVNpRDNLWDJGV24zeldxMVcyT2wwWG4zUENVQXhBOTh5?=
 =?utf-8?B?RFVpbzQ2SHcrcTlNYU53eUJycEFjTFRsNHlOU3dGTmpxTGxWUXoyY2VDRFNw?=
 =?utf-8?B?Vi9zQXBWYW1FU214MDltd29WOE5Ra3ZZcHpsVE5SM2hkMG83cmpGcWxDaDNN?=
 =?utf-8?B?RG9ZNFFZNWdNSVRseTdJSGphM3N0VllNb2JqNXNzOE9RVHB3eHhZSlNaYkor?=
 =?utf-8?B?b29BQklyOFIzN3JWcVB0NlhKNUwzc2tEWUh3b3E2WFRDdG5BMEQ0NFFXYmUy?=
 =?utf-8?B?UG9JbDl2RFBSeU1penQzK1N6T0xHU3l6Z3J0d2tZb2hTUThKVlFJdVBRN1p4?=
 =?utf-8?B?N2V5R1pjS1p1aFpqTmpKeFIxRmJqYUFiaE55OW15QlVoQlpmREhoZUo0NStz?=
 =?utf-8?B?dEhGbDZwbHhYYXdRTUMvSndlZU9QczNqWno4ckFISFlkZFFOMndqN0hqM0Vq?=
 =?utf-8?B?dEhzVHRuQnpxY1c0YnlEb1phZ3h5OHY4UXdSMm0xNlVRRy9HQ2Jnalo2MjFN?=
 =?utf-8?B?TzhiSjZSWlI5WHFVRGNkRW1oRE9KWGhaV0ZwdXpScHpzQVptQkYyQm5SR3Rn?=
 =?utf-8?B?ZG5kN1ZUM3BlVHJaUElsLzgvajhHeVR2WjhlRitKRzIyK2FWWSs3NDFyN0Q5?=
 =?utf-8?B?OW1JR21WYjVvcnlEeFVGTEoyejhlRTMrYUZBSXNBQjRHelppOGtBdnhRcE9C?=
 =?utf-8?B?RHJTUmpwY0dZWGc2dVhBOTcwMlBDaFRoMERlcitNRFVPTlNKNGg1SUhuQ0Y5?=
 =?utf-8?Q?648XzxtRcq4xJuoyRcR2a+fTS8mFuC58PESB7KjGTWRg6?=
X-MS-Exchange-AntiSpam-MessageData-1: vIL7cMyUJwDHZg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc1075a-47b8-432a-fb37-08da13df1ec2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 12:57:04.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXuOHxBjQp+tU4B91Ptb2P9FvC/DnRp0JxLHlAm4EejO91i8iF7W7vuFoynAu75cYFFSx3MJn+3sdBdVQyZ2lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5630
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/22 12:09, Bernd Schubert wrote:
> ping
> 
> On 3/2/22 21:19, Bernd Schubert wrote:
>> Sorry for the spam, besides that pasting the patch somehow did not 
>> work (I cannot apply it myself), I had also a typo in David W.'s mail. 
>> I hope that attaching the patch is fine.

Actually not needed anymore with released v5.17. Looks like there was 
another fix for it.


Thanks,
Bernd
