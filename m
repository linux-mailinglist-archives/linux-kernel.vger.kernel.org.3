Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF75542B57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiFHJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiFHJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:18:05 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41AA212560
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:40:55 -0700 (PDT)
Received: from 104.47.12.53_.trendmicro.com (unknown [172.21.180.2])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id C18FE10006604;
        Wed,  8 Jun 2022 08:40:53 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1654677633.475000
X-TM-MAIL-UUID: 457a88f7-1222-446f-8c5a-bfea3490ee19
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.53])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 74370100021C5;
        Wed,  8 Jun 2022 08:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuDOuTrICRSm1jqnC+H2UwJUIwfaN4mvkQTWXdfLYsbkYJS8p1Eg0HoCosmNf6GGcLsMotIl189i4WuFFHuZ2MjLaWKgGSiXgdbsKtGZ711QiOP4MpYcTgXGEljyJY3Kn0zom0sDbwIzqWR/jLtZoTwHGD30LqSBkLKsX3L0oY/QQ2R85YGZWR5aMa2887/bEOow1vQjUO0FPyDCDLyIPOl9mDirKhmVoLYgG7dNWCcBn243H6EhpbhRQIy3FIW8r/j3I71tzuNazhbLbNpxRneo8a+lDL7Ibb74yNS1XiBipSBjw022BfTK4CyVB8436o2e7d5H70d9nLOG4swrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57yNba2BcPYzwQyHgho1jfg5DX67KOiX2S/XWnwQI3Q=;
 b=PJjsOE67RjT0AFDKQmgDFmL6pQxsmO0PGNBlJ+lsvnEaMsvv4xIjimMwG6/6DlgsUkkQzfm3YKJwIVpTubQnrovksgExrn8t24tZ3rT3ZkLPqQDuei/b8RVzZZQOCpvqGIk+ZDt10iraDJWpkX79ACELVeNwfxSZK2SuYWAe7Nruvq+EGkz/3zOTEy/9wvoZOUnRSQXGEnTliMP4GpDlvUmKDBcFaUdVXGSCfStxrxdqFWgR3jVLLzDn6ijzRl8VPmEYDh0S+8Nu7YcQYf+oULrbYVc2KB9aeQa6szDEbqEjlNUbZ+jLfZXFjJ86c+wVWgdDl9fmShibe77gc36LUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <3c4aa97e-f121-61d3-c1d9-1e5e1f7c0e6c@opensynergy.com>
Date:   Wed, 8 Jun 2022 10:40:30 +0200
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-16-cristian.marussi@arm.com>
 <d523569d-2470-3e01-c407-d6e723c7d0c1@opensynergy.com>
 <Yp24WY3xlQuUa59A@e120937-lin>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH 15/22] firmware: arm_scmi: Add SCMIv3.1
 SENSOR_AXIS_NAME_GET support
In-Reply-To: <Yp24WY3xlQuUa59A@e120937-lin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::27) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86bbc5ee-8ba7-4f06-e1ed-08da492a8c54
X-MS-TrafficTypeDiagnostic: DU2PR04MB8967:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB8967D97127B2A2B4B323610B8CA49@DU2PR04MB8967.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcmTVYWig8yeNJ8engKBJVx+iqBzlKoCDRxmzIzLU9tfLl5ieVqzELwCadHhhT6WytlDjcKPA5ZfRVQF3S/9hHAz2Hxzz7XQiHrY0BWtJ+GbgMQyVD9yvR8lUblHz8y0T4QmI5JpXWXA9W9kPnApKW2VP3Dt4yoXTxgUUKwaKPy/SujfDfgm6KuMatVmv4Vp9jS2pm5lk2XpMp9EgPI2VuciFQATFL9EplSHMUV2qKdl0tcaJ3LpmzGMbwO+OEFa09ApaTpIpPvk3O8GtWIC1ug0agI+TG1F5BG/e2L3oq3QaFoRHqwabg988wCLcQ1E9Ixp4p03snNCBFIOMAnkSWkAb9ANwHBMsCYQYyRXEvzqckzAzeoTT8LfsRMTGGJB+lZfAsiCENrx8OmFp3iv3b4yU47XRoOOpeY3L97GXVWW9GAMaeakm4QBwScxP3FajkmOxW7dDDFyEKEslIUGT3dlxk6+X3EtHcwcwvPQGpt4Cyr/giJ81wiyCxw5RhWuvmOJHwjZ1c1/rMWMOzpP2v8Ayjg5UrOr73f5GWB287+R8tSD+y4otJFrMd3h6iVJxBFGaVPNa4LGmzvkvIwNMrJ36D72SVrLTPJW4eHot/4Qbt+wOX7iBzydpOsDy+oC6Nouw/geR4anuSW+syGCgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(31686004)(66946007)(53546011)(36756003)(8676002)(66556008)(83380400001)(6916009)(508600001)(38100700002)(42186006)(4326008)(316002)(8936002)(31696002)(7416002)(44832011)(2906002)(186003)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVl0a3FtdDZhUXZxWFpWWG9EaWVpYlJnK04yd2EydlRHQ3dQbk1YeDJPbzZD?=
 =?utf-8?B?aGszVXpVN09hQ2FicUsvZEFoSmZPVU1aTTNxbGFJemZvOVhFek00eXgrdVUr?=
 =?utf-8?B?OVd5UzZqTUhRNm14WDltR2ljR1hTVGtpTFVHcnlqb0pRVk9QaTBGVXhyVCtz?=
 =?utf-8?B?MVJ6QVFTeURmTlJlNEJCLzRHd0dvQTcyVVNxS1BBZkFkSWZwVFNQdFN2SEUx?=
 =?utf-8?B?YnpDZmxxRFFpM1Fadjd0WHFia1VrNmIvdkJERXRMdm1IRkxpYzJ1SWVwVFls?=
 =?utf-8?B?bEhOd3l1bkFMeFRNK01CcXRWUHRWbXgrQkFIbWp0VkxIdVpLUU1QSDVZVTdZ?=
 =?utf-8?B?R2Q1bE44dFdQRVI5d05XSHJpbForZ3lxMEUycWJtMjFLekhXMlpMNW9YWUo3?=
 =?utf-8?B?K2YxK2x0V1ZVdVhETW92UlhDNEVONWs3UmRoeHJmRTVZVlpHVFJwaHR2Slgy?=
 =?utf-8?B?THcxeFdlSW5kK05LSEdWZ3NmeFptWnAwNjRJcENBWTJSSHJub1RwRGp6SXAz?=
 =?utf-8?B?a3dlTG5aL3JhdXR0RE4zMGlYY3pzQXFCWk1tZmU1c3A5ejVDY0JDa0M4ZDhn?=
 =?utf-8?B?VzNlOHhNaVY2VFNzUWhPZXN6aFJWTnVnWHFYd0pxeXN5WTJ1U3lJdGh5VkRr?=
 =?utf-8?B?RVJZMElKcmxhbmpQQXZoanlYOWtRV2pxOHlwamZDcm9TUGxON2pIMU1QUHF5?=
 =?utf-8?B?TmxJRVJnampqN0F1R0U5dEptaWl4bk81L2QrLzMzWlV3TFhDd1RWNUphKzdj?=
 =?utf-8?B?bngvcE9HbVVJdDl6ZzJPa0h3SUdBa3FQdmFWa1VRY1VpdjQ4bHlETkEvNGNJ?=
 =?utf-8?B?NHJyZzkxRlNXb3ViQzJUcThuTEM1NmEyZzZ0ZjdOaDkxZlZYcGZyWG11R1My?=
 =?utf-8?B?dDZxUWZlbVBON3ZIdGpEMU8vVTYvZTVET2puSFc0aDQ5MExwbWNhWW5pUWNq?=
 =?utf-8?B?dFZDOHdON3VxMldyek45SHJYb2k4bkRMczVUU2ZRNUJGeGVMWjl6MnhZWGM1?=
 =?utf-8?B?b3lwV2x6NFc3QUc2TUVqQTVqSDMyS0FSU0ZCRVJXbHFpZ3V0cGpLNGFGZERX?=
 =?utf-8?B?anZzTVNjNmpBa0c0cHVkUkNselIvU0FMZFMrdnBYYnpwWG01aU1JVXNWYkpw?=
 =?utf-8?B?RlVmdkNscHZoV3FqdUxkUVNiM25wbHM2a1BhbENmVVorSVZFbk1WZS92OUhB?=
 =?utf-8?B?dmM5cWFyZmdaNkNMWkdYdWJ2SjZqWmtZSkpudUFCZXR3MU96WlJYaWErcHdM?=
 =?utf-8?B?cFphRS9JcFJCZklLcHE2eXF1ZDF0Ymd3OFZuZkQ0Tnc5L3B3OGpYdTMraHRz?=
 =?utf-8?B?VTZieGNIV1ExeEZ5WXh5eUJ5Z01iMWk5TlBqSUVjQlF3bFJta2ZZM0R4bGRM?=
 =?utf-8?B?VUhNSFNjay8xbUl4MisxNlNxQVJoWFlrTS9GMHZWaHpFWWFtNi9oT0pqS0lR?=
 =?utf-8?B?RCtMNTNmRitRL1N3MDBPaDFXNW5McHlKZzhSZlhPTmgxdjY1RVpidWxvNGMv?=
 =?utf-8?B?R1dZNHNCQ3lpWHRLWE4vREUrbmJnRnhReUFDdWxXRGJiUFJJMUh2WGIrR2lP?=
 =?utf-8?B?aHZiU3B3SmZwb1pxdEVPMkE3RWNFT0pCOStZUXdYV0NyWEZQazdLbzdValkz?=
 =?utf-8?B?eHFMZy9lVmlKTkdBTUFsU1MyQU9WaE5yL1o4bGNUSC8raDFyZ1A2SkVGR2pk?=
 =?utf-8?B?dzloR3haenZrTzJ1b1g3N3E2cGtHOUU0S2EvSjkrRmUrZ2VSbmcxNUdMc3Y3?=
 =?utf-8?B?SHpPVThWUTJhdFc4bllwRXpJb1NLQVIra2Y5SHFJTm1JeTFqaTY2SlRnVVdm?=
 =?utf-8?B?eUIrSGJ6dGlGMjJSb05EUDF1R2wvM1VHVlg2TU1OakR4VEw4K0I4bXVJSE5J?=
 =?utf-8?B?dWF3a1NMMmxldHQ0V0FUZTMwblJaNUNhU3VrOWtNSkluL1cyQmhibERzU1NX?=
 =?utf-8?B?Z3I5aHhJNlcvRWJuMlFVbHpFclRIMURzWDFrUTVQN05YUzhlZU1BdU9TUnJ0?=
 =?utf-8?B?QnNFSEFwdTFxYzB0aXd0SERjSXVTRXNTelBYM1kvSUxyNXNWSks1d0JSc21q?=
 =?utf-8?B?dHJwWThCanZSd2xDRUJpd2w3QlFJVXdYa1oySFB5WTgwZ3V5dFA5Z1QxWTRX?=
 =?utf-8?B?cm1aT1A5Q1Z6Z2xrQXIrbzgyNFNYNkZXS09vNmpHV3RZOStuVXh5U1BYMUtr?=
 =?utf-8?B?NTF6MEhWbmF3MkdqSVNSbnJrZHVNU0c0NjAxUTFON3p4ZFdBTktPdjk1MXFU?=
 =?utf-8?B?MzFKdno3eG1CMXBVRllHaTJpeFZ0N05nc1h4aUE0Rk5UL2xybUpGbFVQRzY4?=
 =?utf-8?B?WEFPTkkzM0c1aWZsNDE0eHppbG5aNVhmUGRUTzM4R05jckw4c3pscnFYdnps?=
 =?utf-8?Q?tPhTN9HWcyW6a7fb8QgTLegWdUkytT6g1U02KfX02grcq?=
X-MS-Exchange-AntiSpam-MessageData-1: +rGYkURpXTz7Tw==
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bbc5ee-8ba7-4f06-e1ed-08da492a8c54
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 08:40:31.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIeFTMmU3N9S0zQBrb6pL33EqFv4QPstIoOUwIqD/J1OJrtwG8hI/qk+Ag7bWYXwPT9XvoetZs7qqeXNaDsVOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967
X-TM-AS-ERS: 104.47.12.53-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26942.005
X-TMASE-Result: 10--25.596600-4.000000
X-TMASE-MatchedRID: ZFzIhWOuIzv/9O/B1c/Qy3bspjK6JP6q9mojSc/N3QdlEv6AItKWF4nO
        /I/i7S2A31xh7JpF57xyuciK3rjhCrVQ6XPWwtdyEXjPIvKd74BMkOX0UoduuaY5ZGw7wyeHuxW
        P7AlD8NM/3QwynUylBzJPsGAQSaI9seY8I2CDJmS8coKUcaOOvZGAt645FF0SevFaYkHe0BjkWf
        pbP+POISRBEKKUOl+4PCYElDjr3sWVeUDoXrlJzXzmmMD/HXF+06KZJRgAyVkQRik6+J7XSfmgk
        AwQUdXXnC7F+qVaTtoYK7cmRLQmmO9c3cDddfNU5jpYq8oRllNHA3z4TI9B3siCh8yBqE+tPv6S
        9AgW7rIaCf8dbgyNOfMVfR6ftjhySm+h/UYRppMaiJGVIKHj9aVjgXyvS9c/mbc4hVJ/g/ltQPj
        8n1YvVTg7B1CFtpJb+5ASI96vB0BwhygZrustb+adXXcOleEbk45XNF39dU7/z5X0KzxdulYMJR
        3dIrh2HTLWCIpqMcKkiliG7DOEI7W23FWR+Sb2QQ5+hY6u+45KTvzkVGmdxZsoi2XrUn/JyeMtM
        D9QOgChMIDkR/KfwI2j49Ftap9EkGUtrowrXLg=
X-TMASE-XGENCLOUD: 4cb33448-c36b-44c6-992c-938a24a009e5-0-0-200-0
X-TM-Deliver-Signature: 693859F1394E019611D869E64FEE191C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1654677653;
        bh=ez6buLAhz4/l7WBhAxmrKhYXiWA9OKF89dIj69YAL9Y=; l=6237;
        h=Date:To:From;
        b=cfB12NJrUekf7t54sOI68hnnUmQcwG2SH2J9oZlzewsVXNfRzi+ijv/J1HcGHht39
         wLUpQa7BjQ5V3xK7bOqGyhnP9RwjXLsBNX2H4QLHQce8Xg4unlmZV2GUWUlMJW/LRm
         vEpdxSlRVn0UfsaGkn6zItGrCalNahRlVlnRlRy8WhhUmHUFilLrASmLpQVRpwMILl
         F9HTym07y3O/lawez8DufqpjPluo1SHNW359CrYF7La7fhMK2pS7pzGRazxFEBlOO/
         odoxBd/CtDcoI0cwPzijYdtmgsO/T8Qoi7fJ6n/rCP1hjPV8RXkv5jxF/gx71hz1k6
         ovoAdonv51+5g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.22 10:18, Cristian Marussi wrote:
> On Thu, Jun 02, 2022 at 04:25:45PM +0200, Peter Hilber wrote:
>> On 30.03.22 17:05, Cristian Marussi wrote:
>>> Add support for SCMIv3.1 SENSOR_AXIS_NAME_GET multi-part command using the
>>> common iterator protocol helpers.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>  drivers/firmware/arm_scmi/sensors.c | 82 ++++++++++++++++++++++++++---
>>>  1 file changed, 76 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
>>> index e1a94463d7d8..21e0ce89b153 100644
>>> --- a/drivers/firmware/arm_scmi/sensors.c
>>> +++ b/drivers/firmware/arm_scmi/sensors.c
>>> @@ -28,6 +28,7 @@ enum scmi_sensor_protocol_cmd {
>>>  	SENSOR_CONFIG_SET = 0xA,
>>>  	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
>>>  	SENSOR_NAME_GET = 0xC,
>>> +	SENSOR_AXIS_NAME_GET = 0xD,
>>>  };
>>>  
>>>  struct scmi_msg_resp_sensor_attributes {
>>> @@ -117,13 +118,22 @@ struct scmi_msg_resp_sensor_axis_description {
>>>  	struct scmi_axis_descriptor {
>>>  		__le32 id;
>>>  		__le32 attributes_low;
>>> +#define SUPPORTS_EXTENDED_AXIS_NAMES(x)	FIELD_GET(BIT(9), (x))
>>
>> Hi Cristian,
>>
>> I saw this patch is probably going into v5.19 already, so I'm a bit late, but I
>> wanted to point out a compatibility issue, and a small error handling issue.
>>
>> Please see below.
>>
> 
> Hi Peter,
> 
> thanks for having a look, your feedback is always appreciated.
> 
> Plese see my answers inline.
> 
[snip]
>>>  static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>>> -					struct scmi_sensor_info *s)
>>> +					struct scmi_sensor_info *s,
>>> +					u32 version)
>>>  {
>>> +	int ret;
>>>  	void *iter;
>>>  	struct scmi_msg_sensor_axis_description_get *msg;
>>>  	struct scmi_iterator_ops ops = {
>>> @@ -436,7 +499,14 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>>>  	if (IS_ERR(iter))
>>>  		return PTR_ERR(iter);
>>>  
>>> -	return ph->hops->iter_response_run(iter);
>>> +	ret = ph->hops->iter_response_run(iter);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (PROTOCOL_REV_MAJOR(version) >= 0x3)
>>> +		ret = scmi_sensor_axis_extended_names_get(ph, s);
>>
>> From the SCMI v3.1 spec, I understood that the reading of the extended axis
>> name should be conditional on the bit checked by SUPPORTS_EXTENDED_AXIS_NAMES()
>> (the `Extended axis name' bit). Yet, the implementation doesn't use the macro,
>> and instead decides whether to issue SENSOR_AXIS_NAME_GET depending on the
>> (sensor management) protocol version being at least v3.0. But, per the spec, it
>> would be permissible for a v3.0 protocol to not support SENSOR_AXIS_NAME_GET at
>> all. Is my understanding correct?
>>
> 
> Yes, indeed this behaviour was deliberate so as to keep this code
> simpler while addressing some tricky definitions in the spec.
> (not so short explanation follows :P)
> 
> SENSOR_AXIS_DESCRIPTION_GET is a command that, issued against a specific
> sensor, return a list of axes descriptors for that sensor and such
> descriptors in turn also include the flag you're mentioning that states
> if a specific ax does support an extended name or not that will have to
> be fetched with SENSOR_AXIS_GET_NAME.
> 
> BUT the SENSOR_AXIS_GET_NAME command is a multi-part command issued
> against a specific sensor to retrieve the list of all the axes extended
> names for that sensor, NOT to retrieve a single ax extended name, so I
> cannot really check each ax extended name support before issuing the
> commmand and, even though weird, the axes could have different support
> with some of them supporting the extended name while some other don't:
> as a consequence my take about this was that the platform would reply
> anyway but only with the list of axes having an extended name (possibly
> a subset of all the axes).
> 
> What could be missing in this context it's the handling of the case in
> which all axes does NOT support extended names where probably the platform
> won't even answer my request. (unsupported even if PROTO > 3.0)
> 
> Moreover even tracking this per-ax support while iterating the replies
> would have made more complex some of the logic with anyway at the same
> time hitting all the limitations explained above.
> 
> In this context, it seemed to me simpler (and a good trade-off) to issue
> anyway the command while checking only for the protocol version and
> accepting thatSENSOR_AXIS_GET_NAME could fail because unsupported
> by all the axes, with the result of leaving the ax->name string content
> filled with the short name previously retrieved.
> 
> Assuming that my blabbing above is acceptable, what IS indeed wrong
> (reviewig this patch) is that the any 'acceptable' failure as depicted
> above is not properly ignored in fact. I'll post a fix on top like:
> 
> --->8----
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 50502c530b2f..788b566f634b 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -472,7 +472,9 @@ scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
>         if (IS_ERR(iter))
>                 return PTR_ERR(iter);
>  
> -       return ph->hops->iter_response_run(iter);
> +       ph->hops->iter_response_run(iter);
> +
> +       return 0;
>  }
>  
>  static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
> ----
> 
> Moreover even the parsing logic for the SENSOR_AXIS_GET_NAME command has to
> be sligthly reviewed to address the fact that the list of returned axes
> extended names is incomplete so the returned axes won't necessarily be
> returned in order (i.e. I'll have to check 'axis_d' in the SENSOR_AXIS_NAME_GET
> replies to look up the proper ax descriptor.).
> I'll post this as a distinct fix.
> 
> Does all of this make sense/seems reasonable ?
> 
> Thanks for the review again,
> Cristian
> 

Hi Cristian,

thanks for your quick reply, this does all make sense to me.

Best regards,

Peter
