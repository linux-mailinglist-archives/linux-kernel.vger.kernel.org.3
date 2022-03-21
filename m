Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB04E2394
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbiCUJsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiCUJs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:48:29 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2132.outbound.protection.outlook.com [40.107.96.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886FE13509D;
        Mon, 21 Mar 2022 02:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgcOFfJFWGxIU+FszOxJNEvA96yJM4a+n6FJ01cNcqDiKY54RbvABJ0mo4oizSD2XDwwv+S+LwHEv+9bSUT9KrQz3vvmVRjz0KbUWSEJiFAi3zQSp4FqsbhlCVzZSPyFfs2de4Yea7XlwOW8B3DXziAPW+hFzm2qAMZAmf8rnlqHd7asaVoubZGVYct5IIUm5XD//0ToW8CR83lu+TwO+TAo2TTEV/pzpzg9i2sO5fabGOf63ZWJ95F2zUbuLQqVt3i0LdxLnP3Vbnzw2ZhB9KI5Ma+2EGwMe1HGJcPgZAoEvlEl4rzRFBsilM39wAdIt9Z2MyhnBAj1lWe1UPQ14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93k+vMv2/R9D4efwwsZ2UxZY85KpkdTpLptJPuN/01E=;
 b=Z1kTmvle+MeJppVh86AOCHmPSce6L8Utqtewm/bReiefNJuJiDZE26xoHiR53Ff/gTXZL02jSPPz2JacytbWlXeqJFtSPSQ1IprKx7TI0ybkgr+PbHzTFHoPs33k29VdcdLuPsull7HV5lViOtFmKFLBApDHkoRx1w0IR3XRbtvj2gTZM4DGt1pQF2LlL2+r1J24xseSaTITkamiTPwc/bCaG3TnqMv+umi12F8LvVAZYbU3YiZjt5ucaQoF8vXUZUzZSeT7aDRzVxkBSd8qbxJf1b1Iabh0DHMXvBivDLTpP9AePlkAjwFOucJRyXEUxDMwG6CNYTYb5tI3Awsv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93k+vMv2/R9D4efwwsZ2UxZY85KpkdTpLptJPuN/01E=;
 b=q67YkiSb5hca+w6PxR0ajoivbdoQRvZzdtlJK3JNxipmAztM3zaNZm7M8AaYjcmqGchwmnJKdMLgqoLOHXqoBSmZi0JMK6K1RdD2QioYEQBm07jlINoIQvs+ldHqqaig9aW2SbsVJMV5zyZop1coWjH4F3xevJKyhOA5kAAWS1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 MWHPR0101MB3008.prod.exchangelabs.com (2603:10b6:301:30::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Mon, 21 Mar 2022 09:47:00 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6%8]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 09:47:00 +0000
Message-ID: <e9f92650-4f7c-260d-8aa2-92d1c84bf74a@os.amperecomputing.com>
Date:   Mon, 21 Mar 2022 16:46:50 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v7 5/9] misc: smpro-misc: Add Ampere's Altra SMpro misc
 driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
 <20220321081355.6802-6-quan@os.amperecomputing.com>
 <Yjg1nREijopyA+8A@kroah.com>
From:   Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <Yjg1nREijopyA+8A@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To SJ0PR01MB7282.prod.exchangelabs.com
 (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb234d37-d8a5-4afd-0d62-08da0b1fbee3
X-MS-TrafficTypeDiagnostic: MWHPR0101MB3008:EE_
X-Microsoft-Antispam-PRVS: <MWHPR0101MB30086C74A65439B334F41E7CF2169@MWHPR0101MB3008.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKlBIOFGt22KkPRmDGASmmFtZ4PukVRbkkhgAbOTgZgfOYeQ2KRGrmve404uB3L14asavzpVt39iv2XtN85m177Qo8FcXnmDE4ETqkZ53DdMk38z2V49IAuWj+2OXfeYc2JmseqzJlV9wqJRmwmfefgH4Xe/in1A7NYhWoEC9en+Vft3e7xCDhjtp2sXXi3ux7Thn8N9IiiElJ5OLZeq3Hd/diiRZUbGwz1I8ogrgdXJUCyBUjwLbOKHcVb7Ecss3o+IN3zxSNd+J98FOpNJ3JS+HVpIYkPeZICNqDcLbjer8D1ouMhUbYQwaFlDXErSicyJBMd6yC85Ab6H2YbvLCpbJn1uUxBlNijDD8UnMUi0V8WLDBZfXmxKEqKELWZLAIQOuyTfbiNYBfD+rH8SV9xBJBXDMJ9SvNI0+d6yWkY7fCL9TiGKQHokM8mJpmQ+PP0tomQIWjYMrR3zqtvNWfCi4I8nKhl9B1TFy/JSffmFqHQy/HPZDwBsMZzFRsfo2YI95Xc+JNtemaNfRsbHqm/OlCl9/O2Vv5b6BxF0sqvLqmF+u1mByOJanVrM8IwSqtSwOPlHqtXxpC8WgsF9Yg+ojSNNYLS0KXBQYrnXWj8zQkTd6ahTiji8Z4K3GJYnUWreG2wED0mvamAeEoIDCwHzmA8plLVsZE2I2oHIBcDE/XcdGdorZgMiDw8h/FN1x3Pwep/Ox0sNAjYfBMnJECtwkJ4JgkM3jaKgtRzcPRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(26005)(186003)(38100700002)(2906002)(8936002)(53546011)(52116002)(2616005)(38350700002)(31686004)(5660300002)(107886003)(6916009)(316002)(54906003)(66476007)(66556008)(8676002)(4326008)(66946007)(86362001)(83380400001)(6512007)(31696002)(6506007)(6666004)(6486002)(508600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRDUitxcEVIWHBPZlRYVk8xTFQ4VmcydHhJS3MzbC9ERTNwOEdsdHNNRU1Z?=
 =?utf-8?B?aWhiNStDM2RHVnRmS0RrWFBuazZuMzhEZVdRNEZVNWE4TFB3VDQzMFQxUFVS?=
 =?utf-8?B?bkt1c1UvRzg1aHdqU0NVSG5TRmo3MTJCN3NNODhxY2JHM1ZxWi94SGZ4c2VP?=
 =?utf-8?B?VkNKbk92RWNrNFpDN044V2Rnc3FmMjRYS29CV2hoanE3Um9RVS9FMkZ5N3VD?=
 =?utf-8?B?Ri9id3lxQTJPZTRxeC81bGlIZ013c3E1WkMxM3JSYjhuQWc4VjFTMkYwU01C?=
 =?utf-8?B?MlRNbzYyYzBxNUUxaHpoRXZmdHlLZlU4ZlZNN3FWK1RvZ2F2ZXcrRWhXOUw0?=
 =?utf-8?B?VTRJdFZuaVZwbENTTStOcy9SWUM0WCtydDJlSkxmalBBZmhCbitEc3kyZ1ZF?=
 =?utf-8?B?TmxwRkJmUFBqcjZsZW1hb3pjY1NkYVV1eHFETFdiNERHZkk5SnhNbjI5bm5M?=
 =?utf-8?B?N0pNVEVqU0RxbGxmK09RZjdSTndTL05RcFc0Mm1qZHMweGwzZjh2QUQxNnBX?=
 =?utf-8?B?b3VYYW9UaFM2MnNLUmRJdi8xUFJTTURPWFl4Z0dSVUI1S1BBTFJSbUNMV3Ir?=
 =?utf-8?B?N3doRnpCZ1k0SVVNWlV4a21kMk55Tjg5MmFqcFNWUE9KakdGMlEvb3RiSWE5?=
 =?utf-8?B?eFBCZGExRGFrY1BZNlJyRi9IZm1lNGZkc3U4YUZLcjZKaGlRV3I3aVlDS0o2?=
 =?utf-8?B?d1psdEd4WkQxUnplTWUrZm9LVVUwRmxqS0xJdGluYXdNYUJTNjFlWnkrTmlv?=
 =?utf-8?B?RXNITGZEUWdsR08xZC9KWXVza0tTeC8zOG5uWC9VclJKUkpJdjVlSE1LYUpM?=
 =?utf-8?B?dmdUNmhUUjYvVjR5N3R6ZXgvUllwVERwd21PZk1YTHNkaHhtNVA2SllvU0Zm?=
 =?utf-8?B?a3JBUkZDRDhMQk0yZGpLbzlibll6R1N6VmJjV0haQ1E5MG9EWURQQmxTcGJ3?=
 =?utf-8?B?TXMrRXZqRXBIZWhRa1BQQ2V4R2hlVmRKY2w1dWNEQVNpajBpTnRDeUVvbFpr?=
 =?utf-8?B?ckQ4dWh2QXU3R0NVTVVNOU1xZ0ZZREpEUkxldHJhL1FMdE9IOFJDQThsWTll?=
 =?utf-8?B?dmM5emtHL0ZLYzljMEsrZUxiRXJJMnNsMUVqWFdYTjR3SW80cTUrK0lvZUpL?=
 =?utf-8?B?TUErMDU2aFVpZ0tvWENkOXZlbEhMTXZMQ3ZpeUVJc3kycGc1bytrOW96cG1v?=
 =?utf-8?B?VytpVXEvZ0VkM1NnSXJQU1BEVW1mbGw5ZEowajZjRUZodE1FY2htSEhiMG9U?=
 =?utf-8?B?U3ZvNjUxUDY4b1hLT1Fhc3ZDTzBUdTZ6cUpRWldEZzdYeEpTZU52U1g3Zjhu?=
 =?utf-8?B?WlJNcjF3U3ozbEhMQTlkMG94Y3JSNWRnQ2FkVjJFME1Ddm94VEI1dEFNR0dp?=
 =?utf-8?B?azF2UFV2WGNyNTM2VVh2aE5aUlBxeVRxZXRvUWZ5MlBBUzlNc2RoRzg4N2Jr?=
 =?utf-8?B?K01vSENZc3RScVFOMlNvMnptM2F2SVZjNFE5eXlLbnZTeDFYUFp5MWNXUERM?=
 =?utf-8?B?REF5b2VpNFY5ZTNZZnYyWFNab0VyMHltVEh5b0JlUHdsRHQ4ay9DMVB6RXlu?=
 =?utf-8?B?NVR4RjhyNW53Sm9ndElzTHNyV1lZUmxOdEMwcHpWekR6V2xiQkszb2pRQThm?=
 =?utf-8?B?ZEZ4SVVJUGJxQ2VTclJNUXVCbHVUbXdNbU9jVmFtSlhNZGZtOXd1eGRSMVo1?=
 =?utf-8?B?MnJXalc4NzhwRlZDdVRRZWltVE1aUHBnamcrTWJCU25jQ1Q5bEtoUDZVQUt1?=
 =?utf-8?B?cVpEbTQ0MEtKMENrRVdzWVJUR25HbDNtc01sN0d0eEo2MUpRUzJIT290OGhK?=
 =?utf-8?B?RkIyNmozTGRJRUhkREc3N2hzSW5icUFlS1E2VzRWTEdpT1lZcHMwbW03b3do?=
 =?utf-8?B?bENnNWdVOHR6ekQ3b1p4LzljZUhGdEthQVY0M0ZESU5xL0dPTVNzS0hkTXlk?=
 =?utf-8?B?NzdhWndYYS8velN2R09RNU1nTjVGT3EyK3ZNSGpEZUVCcHpCZHFKQXJiaUlX?=
 =?utf-8?Q?LLkXQMcVAeGSScmA5jPcjd2PmT6yyc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb234d37-d8a5-4afd-0d62-08da0b1fbee3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 09:47:00.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tPl4YB7N5rXSTcMXzH5eMYEecy5t6e3L7KznfCAtvwoTTXHOhoTJ6Uy38lFkxDWBGll2A5ZsjeCk3ELytW32Suuo1sUrn0dhOoYr6tqkDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB3008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2022 15:21, Greg Kroah-Hartman wrote:
> On Mon, Mar 21, 2022 at 03:13:51PM +0700, Quan Nguyen wrote:
>> This commit adds driver support for accessing various information
>> reported by Ampere's SMpro co-processor such as Boot Progress and
>> other miscellaneous data.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> 
> No Documentation/ABI/ entries for your sysfs file?
> 

Thank you, Greg, for a very quick review.
I have put this file in other patch.

>> +static ssize_t boot_progress_show(struct device *dev, struct device_attribute *da, char *buf)
>> +{
>> +	struct smpro_misc *misc = dev_get_drvdata(dev);
>> +	u32 boot_progress;
>> +	u8 current_stage;
>> +	u8 boot_status;
>> +	u8 boot_stage;
>> +	u32 select;
>> +	u32 reg_lo;
>> +	u32 reg;
>> +	int ret;
>> +
>> +	/* Read current boot stage */
>> +	ret = regmap_read(misc->regmap, BOOTSTAGE_CUR_STAGE, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	current_stage = reg & 0xff;
>> +
>> +	/* Read the boot progress */
>> +	ret = regmap_read(misc->regmap, BOOTSTAGE_SELECT, &select);
>> +	if (ret)
>> +		return ret;
>> +
>> +	boot_stage = (select >> 8) & 0xff;
>> +	boot_status = select & 0xff;
>> +
>> +	if (boot_stage > current_stage)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_read(misc->regmap,	BOOTSTAGE_STATUS_LO, &reg_lo);
>> +	if (!ret)
>> +		ret = regmap_read(misc->regmap, BOOTSTAGE_STATUS_HI, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	boot_progress = swab16(reg) << 16 | swab16(reg_lo);
>> +
>> +	/* Tell firmware to provide next boot stage next time */
>> +	if (boot_stage < current_stage) {
>> +		ret = regmap_write(misc->regmap, BOOTSTAGE_SELECT, ((select & 0xff00) | 0x1));
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return snprintf(buf, PAGE_SIZE, "0x%02x 0x%02x 0x%08x\n",
>> +			boot_stage, boot_status, boot_progress);
> 
> sysfs_emit() please.
> 
Thanks, Greg.

Will switch to sysfs_emit() in my next version.

> Also, this is 3 different things, put all of these in different sysfs
> files.
> 
> thanks,
> 
> greg k-h

Actually, no. It is single value of boot stage.

Let me explain:
The boot progress consists of three things together: boot_stage, 
boot_status and boot_progress and they have no meaning if reported them 
as three separate values:
+ boot_stage is to indicate the boot stage
+ boot_status is to report the result of that boot_stage: started, 
complete or error.
+ boot_progress is to report more extra information for the stage other 
than the boot_stage/boot_status.

There is more information in the Documentation/ABI/testing sysfs patch.

- Quan
