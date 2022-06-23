Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE15574AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiFWH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiFWH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:59:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D584146B25
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfN9sCZyJuOAUmuqlbqO1rM9z293dYujO+u32W6Jzy16Db/OBmtytX0iz2eLu76nZ4kagMMSAJC0Hv3u+yJ3HOd0pKY7qtfKMmcGOtZlBPEgx9L/lyZtu1VqvuyocQHImioZ0E1YOmdeur42fk+BM1ZNo6HAK1E51Zd/5IQHi00zeqjiTj5KJYJb8R9LbOmxW8namBX5zpHvPxFPXFV8UT5WHvkmc7Ai4/FcLuCLx0mjvvYotqMlpJnbWxWVVs/vjPudxWwCuJbpEWG4aYSEjojJSLP/QgUXfNbLHjaVi9L4vULzJ66mZx0ER6jjfjLSoFKvXM77YOmFD4LaLfJaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfg6PW0PChEHGQ4R9t6bnvbaBdnRt0kRd44w7tfK57I=;
 b=BkVrCZ27hG5ztPrIxLe+rL3DxWbUgnogZXfHaQUZ40x2cjsXMIhxo/phHenBslOIxg+5EZgUsn0smKPCiL40vC1iiQHoJ8w8CQxifBtbS9mGg1xR/raeouuAkW3mHbD6a0cIbsGovIO3+844TuTLJq1fEdP06TjM97HhaxP3kTapQQfpR7FetWSa2cIFNux+qmxXyLf7mt8ghtIWOA6hUxg4jBgXSCYAM/gSxsrjOCxNiAb0LoFw+2EQj2Qgkg4FL6kpYYfnY38T6c0vUQrRP/z7lOouMCR0L9zS+B4t78hi3fGgIwWT+AUzo+YvpmnlulOnqqoBkZTkaUcBptdDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfg6PW0PChEHGQ4R9t6bnvbaBdnRt0kRd44w7tfK57I=;
 b=dpWOroPqZlGJ9XHLJBsnb8FigCG2nqiIuA0q62AQiPKZyaZcq1tgJcEh0nLbhc1WlUrg91a+l8MGielMP+S36YaQ9XeuyBgtC6t3Xl2Wwsy55AQOMKgzlOT3fwSJFc9HVVzpTGtSp5qk8mAwvcfu4UevY33BRrhckCb0GRRRNhENgo3zRb3Fx9ohBakFK1yVd0C1rm+o8RUVNo50wQNmgRI8obigV/BH9q9uXrqf30nM8wZuit4+hvLLlj3ZC88ANKqnQe/wrZ1H+tYWOAAYDK44oZoALUP+NRP5FOZD/FtDYYNxYN3S6CFm0u6Sssy/xjFSW/+gdgOVUSx2rzC39w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by VI1PR04MB3245.eurprd04.prod.outlook.com (2603:10a6:802:6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 07:59:38 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 07:59:38 +0000
Message-ID: <b85e6530-da44-3287-f3b9-51cd4f3116b7@suse.com>
Date:   Thu, 23 Jun 2022 09:59:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] x86/xen: use clear_bss() for Xen PV guests
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622161048.4483-1-jgross@suse.com>
 <20220622161048.4483-2-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220622161048.4483-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR0301CA0021.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::11) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c4de446-4088-47f6-93d3-08da54ee51de
X-MS-TrafficTypeDiagnostic: VI1PR04MB3245:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR04MB32453339114C58652510281DB3B59@VI1PR04MB3245.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WY9C0kOXBWkXvSIt25kjMggAC8TEDDukV9llPg3jizHfRgaElI3cx8QyIxef7bQ3SyQEzwCf8Ha/i04XvZxsOr+7Ad3YxSHdZnwgxM+Nq8uhXj/78eM2avmUhx6efbJDUpV+Kf31AAY3f0BEzMJ6lYaOSTTGtbgippNHnJmFz16SMbs3Gaq+YR53gKKsv0Ucds9N2QcN0iAso6SORHKmZARjvMYqkR66qfs2AMPU1j2AqHo+H3h8f30vvZVWSNOy7IkH1ZdzExuAUJWofvkoEPv+A9hfR+dNaB4Z2n2w8J80VZAczvtIL6lxl2pGKULSQcPa//h2qwdhF5V7wtJT+r9eINEbvd+SXQYnRj82Z3nw7Un+xkxBrdKjGo5tr4gOaIVK69bfgy2uYIp2kJFNdG0c/4clUNwBKQg+eUb4VEZNpmWM7kEZDEZbqWgcR/FvVnGX/2H5ZYypk88Tp6oO7m5T6PNI2+eosBFp/XaNSsUgfFSKAs/1UrFKD2MLLMnk7iL6zZHzYGXL3lqJg3SrwkwePnrae0Y+NHUGTAKmnilLP7daV6UueQfGG5LEckpFwjSI1jCuP0UTBK7IGnAarC+uv8utom/zwcy44V14CWZ7iz/lQLxRphotj+t7vjvv1rTtiiwP27wedq/fjRorO/r8DzhMx+Oz9YknKYOvVveQK/U0M+yJPwJSG/MF4usvE2LfFWmEDpcy/bdD5eNFSgm1egI5QzmF13gajyBrgDbZkmBoiGauMnUbibEmNnUKgJjSwVVgkH1UW+4MWX7XB0JHs6TX7SQBX7+KyKpwqJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(376002)(136003)(366004)(186003)(6862004)(6666004)(36756003)(6486002)(66476007)(8936002)(4326008)(66946007)(66556008)(54906003)(41300700001)(8676002)(6636002)(478600001)(53546011)(37006003)(26005)(2906002)(316002)(31696002)(2616005)(6512007)(31686004)(38100700002)(4744005)(86362001)(5660300002)(83380400001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhLN1lNYzA1SXJwZEJkdDJVZG40TVpCUjJQaHVmR1RsN2NVdzg4RDNlMkh4?=
 =?utf-8?B?dnNyanB1bkRGeDIrUzRKbUVib3R1bkpCQ09YMlRaM2ttNUtNakpZcDU4S0Iz?=
 =?utf-8?B?Y3A0WU9FWW5wUWlQSEFVbG1tMU9iWEZBM1JTbzFPTDEvNms3T2thbmNLTi9E?=
 =?utf-8?B?VE0xb2c1WnVrQVVxekpWSlhDb0VJSDg4RHpSQTZZdHpPL0wvYU4zR1JmMGNF?=
 =?utf-8?B?R3NoT1NiK2twUXI3MlA4OERLUEtBcVM0MnFBQ0prT3h5a3dHVTdKRjQvSVoz?=
 =?utf-8?B?WFhFbHJjRjdHMk5sRCs5eXFTOGY1RWNuWHVsRC8weWhjQ3ZCb05SSUxtbHo0?=
 =?utf-8?B?cnd3dk5TbU5VWTV5a1dzWXpRd3RtTnVHVFlTOW1wSFgxWjJFcHBoYlViR2dW?=
 =?utf-8?B?Vm84eUxCODNXcXdNRW9PNHg4b05WOTNmL1pFd1pxaDdJQWFiSDdRRmhIRFRB?=
 =?utf-8?B?Qzg1Z2ltS2JyZld4UFd1dGk0enhjUWhvMlpGajJsOEZVcFMzZkVVTS9VQ3dz?=
 =?utf-8?B?ajFHaTQyRkZiS2VQSG1nc3pJa2pGMFlzVGZ3amhES1JQR284VHp2S21lRnI1?=
 =?utf-8?B?V0d4azZRZWVWcG1LWXRLMWZERkYxWkZJODRVcnVlcnIwcytFUGErZTMwMUpr?=
 =?utf-8?B?QWtTZExqMmtYQm1zckxwa0ZvNFMrTXVVOS9BVWQ4SEVrRng2OFZBYUNWRCtQ?=
 =?utf-8?B?RGI1WVJWZkJQUStETmkyQTY5NndmSktKMXpReUtJR2RwNW1zTjR0ckhzWHUx?=
 =?utf-8?B?YWdaaWEwUVQ4WTlYMGZZREZ1TUR0dkErbDBKRklZMTJ2ajNzMnVxSEFVQ3lC?=
 =?utf-8?B?R29SaUJhcTlJSTNJaXJWczZialpGOWNzV3RUUzdFV254dmxRT0hIc3hIUlNG?=
 =?utf-8?B?eE0vdkg0NHhTTlkzY0s2cWx0THF1aHJnRldwcjNUN1VZNnZmSDIxaVAya3Rk?=
 =?utf-8?B?N1ZzdlpFRXZVQXh0TUNPWUpuSzlmQ09sUjFZYm91TjNNczVLbDhnMWo4bE9W?=
 =?utf-8?B?bTB6ZzRFNm1LMVRQV0lqMGlFckl0bjhrcW5CV0djM3pmUEFoMTh5OHdURDFZ?=
 =?utf-8?B?c0ZERkVzRFh5T3JKZytEQkNjWWZqLzZKbURiMlJwSW45RkQrUWZQN0ZkeDdh?=
 =?utf-8?B?T1B4WkxTS29HNWxnVWRpWWc4cTdRbVpjZjEvNzJXRFd1cE4xYko5amhJb2ov?=
 =?utf-8?B?NE5FWGhBZzdHcWFRMGxqRnA1em96VzhGa3ZnNDN6cm45ekJnQ2dyZVJiRGVj?=
 =?utf-8?B?aEJlV1dYdC9FSHRuU0QrN0c3RjAxSVp5cXdYajlOZWtRY2w1Qjd0cnNmREdX?=
 =?utf-8?B?ckg4NzlNSzFtd3NyaUplRnZiYTJPRGRDMGc0NUZ4aUl1YTROOTkwNEx6L3hR?=
 =?utf-8?B?bWRtUzB4Y3BNUVRSRjRudlExVElVSEJVcCtpdE9ueHE1SUNuSkRSRGwrUGNL?=
 =?utf-8?B?TDNZakVKNXdyNzRuSm5ScXppZTltVmdHYUU1ZUJ3OXBKc3ByT2xJaGNJYlBQ?=
 =?utf-8?B?bzNUMmhTMGxwNll0aTdwMFU2ZnNzWVRrem94TUQzS3h4M2FZUGVvMktsak9v?=
 =?utf-8?B?RnpHdDdyaFFpU3ZBcldCMGlpMWZCS1QxYlJ3bUQ2T3JRNlJxYXBGTnBEek1F?=
 =?utf-8?B?MWJPc3NQR1JEejg3bzNvSkZRd3poUHlpOG1QcjZJczBsSXI4dDJDemdOcjZj?=
 =?utf-8?B?dTlvWlNuTUJURXNTYVZrdHdJNkZqZHIwb0orWDAxckMvL3p4NWl4MXA5bUkw?=
 =?utf-8?B?NzZYWEdZK2QvZStQT3U0ZWhlejd3ZEErUzVJTDE0RHRjQXVHbE1nTW9iT0dQ?=
 =?utf-8?B?U3c1eDFIRmN3YnM0cWNwTDRJWkN4UDIxOHM5MGxmWmZycWdodGdvRS9wQXJV?=
 =?utf-8?B?VVZXUlVZVWw4bkd1RXRnWm5wSEdpWktNZ0w2Z3ljWG94VGRqK2lMcVJJc0Vk?=
 =?utf-8?B?RGNnUHJ4RytueUFxOU14bUZvVG5CQnNJUG1aY1VEbXNEZnROY3ptYWtVbEdO?=
 =?utf-8?B?N3ZUTEZvNjB3bnFEeWQ3ajlCbTF2V2xidG5FVWxQOWpFTDJCTWY2Tk16Tkx5?=
 =?utf-8?B?RW1FUHFvM0pRWDUvUVNvQWpNN2hvVlowTGpSdEhmaVdNTHp3NmY4c0R0OGZC?=
 =?utf-8?Q?MQVP2s+ozNcnaBpW6AqWQ412x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4de446-4088-47f6-93d3-08da54ee51de
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 07:59:38.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LseRsPvw/F+mATn81xRC6IW0EjRcI9bgu9hv11HCEOn+Mp1xxv1txEuMItq9nxVhwr40f4MZWZnNKQgWfdsDTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2022 18:10, Juergen Gross wrote:
> Instead of clearing the bss area in assembly code, use the clear_bss()
> function.
> 
> This requires to pass the start_info address as parameter to
> xen_start_kernel() in order to avoid the xen_start_info being zeroed
> again.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>
