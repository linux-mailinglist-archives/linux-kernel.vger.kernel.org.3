Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE99492EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348949AbiARTxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:53:49 -0500
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:37646
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239127AbiARTxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:53:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZGnRlHoNa4DwgpGKBZ+aBe3ZNSHXVeZTO0icKkTb/RPcAArh+fbZ1N4GzfdP1iDHR6+ba9oIdx/mHDMYlzxfytwg1CHtw9fw5ZP9Q4xfIsS/AiU8OpSxYfbyMAJ0SAVjWPVpdNRIfWzbsw0l2s8K0wDgkzOC0n07zIeQF2LMCiZKvohb3HyTvGcvlWBQ3t2fs48NN3RZkTk5MnQOSVblMj8nOYxBZr1wImaQ2TeN6YFOfGpN9pAt1KyHE9BP3jYG/UjH4EUfiffcpBcxROFGXMzcBpBVVDvUhwwHAReifYgVOfv/N+keUfX9pvPPfog3/4uAGXn4bj+XNPOrFaGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ0nHWRQLhZTIS/ORoo4PHV4xhpe2/fRJvsqGHGLyWA=;
 b=eNlHyADPngevQQFcbNy2HN7lYMp0gs5VMa7wHmZpU55L1kS/ogq9gQUJP7MKkw1Gu+bRYWmd+3EU1WYhvCs47bsd2iVYM/RbgsEmW7e3ShSi6+/A3kU/QpVZDerncB5XVLhFxqOPfyB9Z8G6Ldim3vKPDVKNbDfZ1wRozsPIn3303cMbP3sVvWldktTmAu715TgHu+G9LmacLkJd8f7VLSrsCTZGXNHfKEinTS3Jx/aQ+AfTSrHeEt2ie3GRFpKAxRdOnLL8hGj81fI5NjuJXfGsyKF1diLnu/z2MEF4XSQKfz+zAMeXU2IcidYtup8NnkBrklBO/09suH1RKnbwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ0nHWRQLhZTIS/ORoo4PHV4xhpe2/fRJvsqGHGLyWA=;
 b=VFHk+qfRhjfH/nSJECVbq2NO+9iAEw/4yrGcLBpu0xh+xmKGkEcVcCeNxrXcqyWVnZ7BXcUItQaVMLHeI3XZq//3vHV33quQL2obd5quePxCpgwCBheRmKBrzpvxWGUlLBLG22UTyrI6QpIHfNmlS3aepl2Dxfcfq/waBXsc7Wdgc0V05FbeZ/aBjNE6H4Rye6AVprL6jlYJ3CFitfUncrp2BY/r+7a7bGRg98v5+grM8BH15Fie70/orK0jAm6rEw8zOIBQpOBZRkebmJJxjRoLuHMj1h7K3Oj9NSl0kw0SWiMTmCQRlicBmmL6xZVdvskDAvKxB5sY8PUQorJYUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR0301MB2414.eurprd03.prod.outlook.com (2603:10a6:800:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 19:53:39 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 19:53:39 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Baruch Siach <baruch@tkos.co.il>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <87iluifxy1.fsf@tarshish> <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
Message-ID: <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
Date:   Tue, 18 Jan 2022 14:53:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb5d056-cd93-4c59-382a-08d9dabc38f6
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2414:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0301MB2414F7F2841F3B29335F1A0F96589@VI1PR0301MB2414.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: naYUZoOH4rPqfbcHbvTPvZCIdPtChg9uwteH+doc0Xlov/Ei+gkRkZYDVdHJO0qGO7j/wFpA2eyBS6k99MTdXla4AT1n6tI17H+qwA/oF2JUecKFWLt1BX8I8vAxosiBRXO+h1RApsZ7YnMZ5pbwUTs6L1NdBEx+S7QW4CJF/6XyaWywSGkeAaiMbzFhiZMpIdiHITlNYNafZV2EzPMtQa2oPOHuXp9Gk7QYh9dlU05Jd6MDbc9vrqLNp/ibr4dfLWBrv4qrZjXQX8OE/sHvuD5R6v/3ynhmnDMYPYhuyvwVcbo/caShmewW+MFu63zCFguTCfmzzRil7t7lJ4Ciy4TdpqCmOytxk7u8BNUp2laO4ssrMpKrHlMnDRUMsFm71E8R7ZRh6DlQQcRA8GMLBhdVNCYbbvMRwKWd5PNZuxKWdOwWReTos3LITMNy5mMFeliuGu4ZdT6egSgZwyv2Gzxl3l5kRipbtTwvBExHR4TDx32aw7DjZ4yaESUbYwrvJnLmiDkNTS0TU5OwZ1SjWE8dHmBiYDhLHjvx3nMLNt1hSNMCXdYhyuL3QoINqGm6Z1q5nS6v4aGlYR1KygRJ5D6E+kDuePXTvObFL3I+xBfPt6eRIJ8l3XJSMzgpINrqk9s5rJq4S47hxjqykdaJ1+2qcJXjCVjfnQShmlcezK1D65/kZMWUeMrhd3fBBO0R6nQtNaenCaeP6ZMNixGodBsoi4/EC2AuTav4bESDt1lzlwhGJcvUZ3gEplUpadMAKMBDAm4vo9SgJjX0D1XCQO/3m4sPuOodMcSSDKtXWEliqAmUE+uqO9KjbA4Q9aFkph+tcr12yLqxiPKnhD8/lGdzycuz4nmnvGV4SVuwVqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(83380400001)(66946007)(66476007)(6666004)(4326008)(110136005)(52116002)(38350700002)(86362001)(66556008)(36756003)(2616005)(316002)(966005)(5660300002)(508600001)(44832011)(6512007)(54906003)(186003)(31696002)(53546011)(38100700002)(6506007)(7416002)(31686004)(6486002)(8676002)(26005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENtNzJOb1NQcUlxWUsxdm9OQ2ZveU9sK3dTV1IyVTNGMWlBVzUrcE14WUdD?=
 =?utf-8?B?V2JlTEhObnNLOGU4RGwwVGVxZ2hqK2MzRE8xWjF2bFBSclU0ZjFsdGdKU08x?=
 =?utf-8?B?Z2Vsak1QSFZQRHJqeHJvb2wvRXM3N3RLclV3UTZIaWJDM2E0ZzJ0eVNmVXJF?=
 =?utf-8?B?c2lPRFdBZTd1RzBLWXBrZjI2YzRZNVNZK08vWks4V1ZzM2p2UG82Mnh1RC9Y?=
 =?utf-8?B?ME9yR3pQbE84eEtFeFVqZkhVNWYxUEtRWjhRUDhBTmVQazhoUUlEZmRwUS9k?=
 =?utf-8?B?RjNkeDA3d0lURk5WR0k1ZUhocWxrTFU0eU5CcC9XMTFnYkhuRW42ek1Tb0d3?=
 =?utf-8?B?dFEzRkl5bVdqZ0gxWFQ5NjNNaHZzTlFlWmE5THVWcVFpMWFkem5DdVVIdlhi?=
 =?utf-8?B?SlExK0ZadzIvcmtnd1M3cWNUenpzK2oxOG9wQWE0bWxiYVV1SHNzVEVQMzU5?=
 =?utf-8?B?eXJjUlVTRUZ6Z0tJWmJWU0llRDd5dXlXTURQcEM2VjRtWURoUEhEbVUzV0Y0?=
 =?utf-8?B?ajF1eWI4TDVMcFg5eUs5VmJURzUrZWJpckUrSzNuQ0pZMUhpcDNMeVZiTTFy?=
 =?utf-8?B?Z2VwRGltOWRTOVY1RzVuQlpKU0d4NFNEVEQ3ZmV2UVQ4WmkyV1B6bFdYeGFF?=
 =?utf-8?B?eXZPSGt4bVNsMTJHakNQcGlQU2tRK3BpZHJ1NG5ob2NSVGZwMUVhanBQbkxs?=
 =?utf-8?B?aTkxSGU3cDN4RHBORk5RbmxjVXlWZEtCdTQ4UUZ4NGhyZ2RlUHB2QW5FNlV1?=
 =?utf-8?B?akNnOTcrSERLTDNVd083VFlxV2RjZjFNWmFTV2RWZVkyQVRuUlREaXlsWVVH?=
 =?utf-8?B?cDh5eDBseGh5Z21xZ1Z2RDU2SHZHSHFVUUF5cmI2QVRJTU5EN0t2cGJTSzlv?=
 =?utf-8?B?ZXl5aXFqU2xjb012S3JmYjBJTWRjbjVlK3V4OWNjdnNVWnoxNEJtTDNXQklL?=
 =?utf-8?B?S0Q5Z3VtNE96eUxrbTJ6eHRrYS9LNWhOVDZTaURxUlFGMW9xYUtHNEN3OGZS?=
 =?utf-8?B?MnhKV3BHWm5kMmFnbmx0YnhIanJZWkdKS3Qyb0hsemp1Y200V01ZeFdtY0pZ?=
 =?utf-8?B?d3NCVGNpZnoreW9KZnlIODlBSW93K3BwVjIrWUJmbDNyTHRLUmZuTjJZRUwr?=
 =?utf-8?B?eFpDUDhRS1MyWXUwQzY0ak8xOUpvQm96cXBiT1p3djFCZmNVTDNnSDhFNUYz?=
 =?utf-8?B?Zmhma2Z5RHpqVFJYMjR6RzZ5QjBWUklnQXdpZ3lWOUlONm5lNkNNU01SdVJ6?=
 =?utf-8?B?OEdybkh3Q2haT09FdTFJcEJIMEwwaGJ1d2ZMY0F4dGxKTWZBSjllWHBwUXNT?=
 =?utf-8?B?RXlzSHNKOS8vL2tYSXNxcG00MGZEd29xZThFT01zZjNMZXVzY24xb3NQeG5s?=
 =?utf-8?B?ZUhjV1VzUitpeHFVRUUrSzhwWG9WTjZqcU1yUjRYMFU1OFNXRjdBaXM5TzZG?=
 =?utf-8?B?TXVPS2ZjTFJoeElJTEdzSDlmelpEZGxmMnNRV3pwOXNNb2Z4and5dXh4VlFh?=
 =?utf-8?B?bW1MZDJKYXhTd3dSNmV6VjY0R2pqc3hrc09lcktOOFFmcHNzVWFnVGg0Zmph?=
 =?utf-8?B?QkFlTElMbWFPZ1BwbmVMQ09yRnVpK0sySmQzN3lFSWhyVUNBVTlnMkkxTGFr?=
 =?utf-8?B?a1JFQTk1RmhWaGNpWmozUU9keVJwVWp1aWRHSithaXc5UE9iWjJxZG9FcFJq?=
 =?utf-8?B?aTBqRmpldFVaS2xhdFBrTFhVeGVJM3BPNEtmS2p5bkxhdzNtbDRDNVlIditS?=
 =?utf-8?B?aUlRckFXVjdaSWpuYXBReFZFLzhmNDdiODNKRThoc2U1aFlDU1NkNnlrNWpq?=
 =?utf-8?B?SmlNalNjOEg0NjZUVFNzRlFaYlozM3NGYXhIaTY0WVBZbk5Mcm1Va2VCdUpp?=
 =?utf-8?B?RXJ3SDNBQ2hFdGp5TFRjQVJLMVRZZWdtUlRNc1AvT0R4VlQxSkgydU8yMDl5?=
 =?utf-8?B?Ym1aUURxTXhwNGlESDZCaW5EcmorWnlVR0R2NFVtN2ZuM0haSnJFN3ZkODRP?=
 =?utf-8?B?L2tOYng2a3JuY2x5cGxwd01teTVjZk43ZlhhaTRJdjNzcW9LNjBxcVZCRDlJ?=
 =?utf-8?B?eHVYRDBoWEtmUVB0NnZzOGZRL0FYamsweDF3V3kwbUhMVnVlQ3A2N0xRRmZV?=
 =?utf-8?B?cWs1NnlSenNSRjF0ajJUNDg3UTlTSnVWN1BJQW1FbGdDd1JOdHhxK2JIV2Vu?=
 =?utf-8?Q?emEM0iqWWCEzqf79ibTcYZQ=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb5d056-cd93-4c59-382a-08d9dabc38f6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 19:53:39.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oYUrVPWo8gq7U6clJcCP3b72t4LGXSlnAIRxtLhj82ov+exB39ndYqg2PysYUaiM6Qf/FtYDRm9NCm/EUrSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2414
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 1/18/22 2:46 PM, Thinh Nguyen wrote:
> Hi Sean,
>
> Baruch Siach wrote:
>> Hi Sean, Thinh,
>>
>> On Fri, Jan 14 2022, Sean Anderson wrote:
>>> This is a rework of patches 3-5 of [1]. It attempts to correctly program
>>> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
>>> we no longer need a special property duplicating this configuration,
>>> snps,ref-clock-period-ns is deprecated.
>>>
>>> Please test this! Patches 3/4 in this series have the effect of
>>> programming REFCLKPER and REFCLK_FLADJ on boards which already configure
>>> the "ref" clock. I have build tested, but not much else.
>>>
>>> [1] https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.hancock@calian.com/__;!!A4F2R9G_pg!M3zKxDZC9a_etqzXo7GSEMTHRWfc1wR_84wwM4-fShiA35CsGcxcTEffHPbprbdC4d2R$
>>
>> Thinh, you suggested the dedicated DT property for the reference clock:
>>
>>   https://urldefense.com/v3/__https://lore.kernel.org/all/d5acb192-80b9-36f7-43f5-81f21c4e6ba0@synopsys.com/__;!!A4F2R9G_pg!M3zKxDZC9a_etqzXo7GSEMTHRWfc1wR_84wwM4-fShiA35CsGcxcTEffHPbprbpOFmvX$
>>
>> Can you comment on this series?
>>
>
> Unless there's a good way to pass this information for PCI devices, my
> opinion hasn't changed. (Btw, I don't think creating a dummy clock
> provider and its dummy ops is a good solution as seems to complicate and
> bloat the PCI glue drivers).

Can you explain your situation a bit more? I'm not sure how you can
access a device tree property but not add a fixed-rate clock.

--Sean
