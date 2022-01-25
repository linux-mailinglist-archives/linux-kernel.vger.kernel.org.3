Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48949B98E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiAYRD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:03:26 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:40007
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1587217AbiAYRBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:01:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF8TRd5Z1Y05/GFrIngZ17JAuNektEnmVsze2j0BEgSz1FdEdlksH3BbEu+xs4K6ikJj5AGUtVoxRaWhMUJmK5t5P+zrG7VJJPeab4hsE+geUpjAa4rEll8UAIvVOtF/x/0NEqx1OxPvhcYHwJ4Ey3zOh1wTCHG+We0JOlb1u2DrXr6VJXOVFF4dkY1HtLkAAdhhzaZfDWOEDybjpLD7JncRvO8J9N/LGtKIrZoRlrFbcmFWy+hMv3rjEyULQkMeeaPJ+yv2KvpOSWN2qxlwy56X03Yp7uh2yHNnvP6Fg+rMZfmjws5h1HcMXVIrmxbrxYeTs1Fnhh2Uy0bpZQNqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBRpjbskf+5Aqst0Q25MUNBt/q5cFLHdz5xcM2NEFYs=;
 b=DSEB3AEsAxFrvcEXHrhhsIZt6Dhk+tGpENEQ3my53uJYssTatonlV4xqv+0onCgA5o+dBcnchkRlZCZqdD5yc1U8sfNa22LHbEv4geoXt5/NagmfbEuhtrYQZp7KhyleEGKxx98l/ycIl96hTBYRMn4xcS0DaO+hc1XuosLOoHEwiz6JPHbDXWFZkWbfUspWx+1qSsPop5tUMBkOIqbTIoOZJ+WbnZPzETVgKWv6QtG5j24aejfMVtC1Wcth5Xf+HVeH9yJsZnZyl9hvtROL9RXZEbbvdFH9Ts8qdfrfyAB4TWZ7N+TsH/XtisTzysbTKFX48oLN4RBwom3l2a5CYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBRpjbskf+5Aqst0Q25MUNBt/q5cFLHdz5xcM2NEFYs=;
 b=og3r6hrIZ80IlVlsQ5ca8JwlhQzFlSfvCBKTioAoSgA5/mbmcERMSJCTf9DjsP89szmdO6St2vd59J6G0IfDymJ/w8RBSA50i3wA5rU6KIa9lnKPRmah0LZq5Pg5COBQ4Fv06nVsvslLYxZJo1GdGA7tnCsWLbxvmVgSlrQwplvpkaZTOVkyNlmHHOtiSmvDXc9BTrHQJIh0N9oTzPNbCCZv1rzTVsYdB4JAYc1n9AGXGbV9RbXR2B6P4gQaJx+Z3pMnWxab63ZhprEo707lNYFhwVb96IyPPh4uhAfX3e6eKTF66S4Ny3l1Eg69DtNXWwQHS54qYNY/oOf1GXWFCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4316.eurprd03.prod.outlook.com (2603:10a6:10:13::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 17:01:15 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 17:01:15 +0000
Subject: Re: [PATCH v2 2/2] usb: ulpi: Call of_node_put correctly
From:   Sean Anderson <sean.anderson@seco.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220124173344.874885-1-sean.anderson@seco.com>
 <20220124173344.874885-2-sean.anderson@seco.com>
 <Ye/AUUlnuHBoGxab@kuha.fi.intel.com>
 <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com>
Message-ID: <284ed076-ac57-c90c-751d-0ced6d0c7c61@seco.com>
Date:   Tue, 25 Jan 2022 12:01:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:23a::24) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd545595-9d58-423f-4344-08d9e0244c0e
X-MS-TrafficTypeDiagnostic: DB7PR03MB4316:EE_
X-Microsoft-Antispam-PRVS: <DB7PR03MB431648174D034CF2B78B5585965F9@DB7PR03MB4316.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEy9SYfo/L2NwkMT/BlKWwQQUyTd8LrshDtKhr3ws8BP+BGIGG3vo5UnfxJ/FDws6Dmx36JSGLQFfJ2Dv+JGM2ol6bHz3fj4XBhy7E78qoAyZtbQQx32BIE/qDU2otVm+1blWn7TTqIDXeeQyuVP5Aj7Mi4CL1eF2XZy0SSRQWtS0/2wmFBzZmYL9koeH+yb55ADRilmmHx/UsEJokt22bNkvmeFU88rAVnKldoDXXWU7mBOLFhyPdbOyucreULww0VoNYNzQ7w1oMKpU99Cai2Wc1yoEQGVfvwQIsWsZq+hg4D7Y3IwoVadVINIwo9bBgNDlgZXU3J7mpRoRC6XjAlHz760MqSeTrvxjV+myNNs3Uz05CdBxpk+T9MN+z4n6JNbabckzIKKsRJ5YyPUVT1mMmTztHQScSpySQbIunkHjbsIp32FDKWfFJ7GesDRtQJDmHByLILsEyPU7fXa9RN71ejAg/Qc6L2RUlJZU+0Se+6T9m3eIgbMkVFzLLPhEOHLTc06aagb0zxRupnbPslXbesXfFs/EbKji+GxqUGgTTJEPDA6712PA3VkXyYZDuwaWIgsQACHhPWsOSb/2uJZOf3EAes25KS7OkCyib/quafQVTCe7upHtKK3Gj6lMw5d46rh90mfNKn5+toTUFUQSf48wny6GyJ+UhlgMNcm9uGLGPhgPZysXBeFXvz5qCh9qQYFCmWZtyv6APnE2+xB7hP3CdYKB3RASTrGU8mxqZ7eMGOiAMysicXy6ornUYP/KdDKq7xVyZwVCIaHYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(26005)(6666004)(44832011)(31696002)(36756003)(38350700002)(2906002)(66556008)(186003)(66476007)(83380400001)(508600001)(6916009)(316002)(2616005)(6512007)(38100700002)(5660300002)(66946007)(52116002)(4326008)(8936002)(31686004)(8676002)(6506007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhhRkcyY1RvcVgvYzU1MDdRaDNOY3pIcE1jT1hGUzFsVjVheFNnMGVrck5x?=
 =?utf-8?B?N3YrQnQxU2Nnd0UyTzhJbEtBRVFIbXh3ZEFYcXpIVTZCNmxubHAvWUM5ekxt?=
 =?utf-8?B?WFVKOFpnbHZxQTRyWjRiU1hEbGtaK1ArbEU5dnFQRkFiVk02TE54M1Rnd0RX?=
 =?utf-8?B?eVFFYjJ5TnplNVZ6RElYSHRHNGY4WFJEVTBwOWJTV2lYbzZzbFhxQ3huMEpE?=
 =?utf-8?B?WkZ0ak5NaGFYZEthWTZFbEZOaXFRU1pzbkVtQS9QUzh3Tmt2SFd6MjdIMVhW?=
 =?utf-8?B?dHpNYm5MM3lhMG1UUzY0MVE5c0paY2dhbVBPMmdmQ3ZLU2l1MlJQK3ROeHRM?=
 =?utf-8?B?MlpPNHlIRDlRcmxoSWhtNCtmNmtPakx4eUxtcHNDd2c2NjhvVUkvWDY2TVF5?=
 =?utf-8?B?L2lqYUpENWh1cGYzV3JqZTVYM01jZ05qeHNsN2l1QThlRXNVaXNNUWFJMjdI?=
 =?utf-8?B?L0J2MWpMZU5vRkRTOHVnNE1lYm5yTnR4SFpUQUs0Y0VwT0ZvWmNpWm1Fb2or?=
 =?utf-8?B?aDhOdjM5Z3Zsa3hXMDg3VTVkRGZ6ZnlKWlN6bm9NTWsxYStDeFJDT0gzSnE2?=
 =?utf-8?B?MzA2aEdQVXJQTVdjUUcyT3RxU3ZFaTFueXh3KzhVNVprRjJDeVMrUzZkK1RB?=
 =?utf-8?B?LzVaNlc0ZldyTURtMFZnMjBJd2diRjd4NGhkUnZlajFqWGNGWlVYcTdLeEpD?=
 =?utf-8?B?SHZHUkgyYWpZZC91bXd0SEJrenpLcHFNeWJGZ1QyUUdabGUxL20yaS9Zc2pM?=
 =?utf-8?B?L2JBNzhTWStvT3hOUEdJdk5OelpVVjRYNkFnOUJTRTY5YWwrTXZZOE9LTXFC?=
 =?utf-8?B?VXkyM2pIamVsc0hHYnk1VXhadnllQ0tHcUdsbTZheDFNZEJnSEkxY1JCczJL?=
 =?utf-8?B?ajYwTUdQd21tZExRRHBJQ29GM3c5bjB6ZC8vVnU5VGNhdG5hVERWRFFLc2dX?=
 =?utf-8?B?NSs1dDV5NTVXNkdZUGlNRitjYk5oZksvUVhNYytqMS85RXJXTWdERmdyRGdQ?=
 =?utf-8?B?YXhJWitJckhqbmtEcjdaTko2dzJjSUUxbWxBNTZ0Y2kzWUVzV2xYTnBzbDY0?=
 =?utf-8?B?bS9wS2VrcHFYNHFEeU1FbGY3NERKalYxT0g2bGpXbWtPckxGb2ZITm5DY0dI?=
 =?utf-8?B?czVnUUl2ZGxmZEJ4eGFVVE9ENWtjWWpyR1RpcUZKR2ZGaVVNRFBPZUhJMElr?=
 =?utf-8?B?U3IyM1MxNHhrVElLbHFOeHg1c3dmR3ZJZ3Z4ZUJnWnRHbTliZXN4YnR2a09N?=
 =?utf-8?B?dStVVCtyU3dNZGhiRjZ5cVloVU9RMVc3YnB5Y2VBQ1NvU2ZuRERwYjBJcHRR?=
 =?utf-8?B?WDFnNlhxektNM2tQcjc1VXdEV2N5ZFhmRkVRakVTMWlWdlgzTlVRazdiN2dV?=
 =?utf-8?B?V3dFZlNvTXBPSkdmcmZUanQrSkZlNHVIRWtRLytEWXp2R09yZnRoN0ZpQitJ?=
 =?utf-8?B?REdaWWJkbzFBODVIZHM0Nlh1L0w0K3F3UkR0UXdZeFFsUlNBWnRYNHg3U3ll?=
 =?utf-8?B?TXhNa1VERzJLUlFSWlczdmRIMm5MQ1RJbnpnblY3V2RqT2t4V2JWdm9qNUtS?=
 =?utf-8?B?TnFpaEtVdTJnRTJtbGlURW1qYXFVRFVCUU1RNDNvcFFUVk5RRmhOL1E2RTUy?=
 =?utf-8?B?QUI2T25Md1lMdkxmTzZsaFhNa1k2YUNTWG1Xa2tBcHpNeC83dnFXRVNsSEt2?=
 =?utf-8?B?NTlibW1jQk5TUGl5QlcyaUtMRWJQU2VYM1pzalRZZWlzdXZRV1Q2VjVXWG9x?=
 =?utf-8?B?UjhxSUNpQjg4NXVGTlZpM091MHRFdTM2RnBkK0FhbklWU2xjeDVtVE02RjNZ?=
 =?utf-8?B?RVprdGM4dDZCbXJ4SUc5VXUxMmJFcWxwS1dnUzZjb2hDYjRpSnZWY1pVMHlU?=
 =?utf-8?B?OE9OT3NCckg0VTBvd2pkTW9wd2d4T3I4M2wrajR4SmhBaTdadnpsay9aYm9u?=
 =?utf-8?B?dkxaRkc2a3RtcUVHVXlOaE4vS0x1YURwYmNqTDR4WlFBMVFpM1RtUVJoMGdE?=
 =?utf-8?B?cXJKYUxiQ1ZjU2JYSE5nNzZtNzc1OS92QkxpNmRkVXo5ODZvWkdueVBWbTdG?=
 =?utf-8?B?Y3puYzYzRitqMlpWaHFTZUxCYy9NMENyTUd2RUtmQ1JIckVGQUJvQW16eWR3?=
 =?utf-8?B?SWhiSGpMUS9uQUJkRTB5SUREbWVpKzQzaWZoRmZXVERLTVZmMnlocjEwemk2?=
 =?utf-8?Q?0lpP/RDpo5OFDkepMtyphZo=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd545595-9d58-423f-4344-08d9e0244c0e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 17:01:15.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSui/5rcd+cgi8BVYpzjcmbWHtP+vcqz4pCCl9gGVCkJOkwvVtTS+Av8rxmFCqaWiiWO5u5ZCfdpD1soQW1QOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/22 11:53 AM, Sean Anderson wrote:
> Hi Heikki,
> 
> On 1/25/22 4:18 AM, Heikki Krogerus wrote:
>> On Mon, Jan 24, 2022 at 12:33:44PM -0500, Sean Anderson wrote:
>>> of_node_put should always be called on device nodes gotten from
>>> of_get_*. Additionally, it should only be called after there are no
>>> remaining users. To address the first issue, call of_node_put if later
>>> steps in ulpi_register fail. To address the latter, call of_node_put
>>> only after calling device_unregister.
>> 
>> This looks like a fix, but you don't have the fix tag.
> 
> You're right this should have
> 
> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
> 
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>> 
>>> Changes in v2:
>>> - New
>>> 
>>>  drivers/usb/common/ulpi.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
>>> index 87deb514eb78..c6ba72544f2b 100644
>>> --- a/drivers/usb/common/ulpi.c
>>> +++ b/drivers/usb/common/ulpi.c
>>> @@ -301,11 +301,11 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>>  
>>>  	ret = ulpi_read_id(ulpi);
>>>  	if (ret)
>>> -		return ret;
>>> +		goto err;
>>>  
>>>  	ret = device_register(&ulpi->dev);
>>>  	if (ret)
>>> -		return ret;
>>> +		goto err;
>> 
>> I think there is another bug in the code here. Missing put_device().
> 
> So what is the correct way to create a device? Shouldn't device_register
> be paired with device_unregister? And from what I can tell,
> device_unregister does not put the of_node.
> 
>> If you first fix that, you should then be able to call
>> fwnode_handle_put() (instead of of_node_put())
> 
> Well, we currently only have a ulpi_of_register, so I don't think we
> will have a fwnode here. But I can use that if you wish.

Hm, looks like I missed the ACPI_COMPANION_SET

So this should probably be fwnode_handle_put.

But ACPI_COMPANION_SET doesn't seem to get the fwnode?

> --Sean
> 
>> from
>> ulpi_dev_release(), and that should cover all cases.
>> 
>>>  	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
>>>  	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
>>> @@ -314,6 +314,10 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>>  		ulpi->id.vendor, ulpi->id.product);
>>>  
>>>  	return 0;
>>> +
>>> +err:
>>> +	of_node_put(ulpi->dev.of_node);
>>> +	return ret;
>> 
>> So no need for that.
>> 
>>>  }
>>>  
>>>  /**
>>> @@ -357,8 +361,8 @@ void ulpi_unregister_interface(struct ulpi *ulpi)
>>>  {
>>>  	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
>>>  						ULPI_ROOT));
>>> -	of_node_put(ulpi->dev.of_node);
>>>  	device_unregister(&ulpi->dev);
>>> +	of_node_put(ulpi->dev.of_node);
>>>  }
>> 
>> And here you can just remove that of_node_put() call.
>> 
>> thanks,
>> 
> 
