Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8387A487356
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiAGHKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:10:41 -0500
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:31492
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232122AbiAGHKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:10:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTvGd7uqwpmE4OaQemLQTPNiWWfBBjv3jw/xb23Ka/U2hd6J15GOC18z8Sj0gNQ9oZAxlbP1YaHww+OFLq28hQAglgf0qaq39RwKb+995ZIscQehnS2qYNFJ1Jz9mOH+YCD9EMdqlNwTLKJwI+65JnylpvsaKZraCngzgo6Mfr6Qg+PLJ7ydStNzJib/TE3rVh6vWUtmvHKFRFCVsxfnAEX65b9b4RWuuerAPM66ka1wyldhJOpv894wOroThXF7yD3qGwQayNRl09XDs0nzN6NoVux/Qkgoo2V4oLH3ieWtTHG4SFazLF/Qn0JgaFAuQYt4NTKNPcIuSe9+nyn2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykp1kW54MwVCv4nIQCwds+Xcfm13zPbeKnYEJDRhChE=;
 b=KE9+BnSMx9pESEMS7ls5ygou07zI8CmBsKHvVpnVQByXu97LWyJwhHx7m0WUlp2zKTwTji0sXkPfKc9+19p40nxg1Awmwa1Zh/bthJQAdkgqdpDEZecFRTcPWMfv/HP4FrKkIyN2+IMaeKZhNI6Ppi5BrAVJ34d51Z3d9FEz7gKCksZnQO3Zkmtt8os1/UPdYRsr7hKd6tljToD2DgSLzZsOwuS6UCndq1JEQx3FnTCIK68+iUFnTrYNYg4KpzQ2BPvYRGKk8CLPWwY6hh90GBTQ00OPJpt8mYdHfTDYLCp/LAyGsUPhHroRTDLbKSOh3FPO9XmlimFcrbjcPIUtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykp1kW54MwVCv4nIQCwds+Xcfm13zPbeKnYEJDRhChE=;
 b=d5Ge8/J4gDhwBOuT9kUAs3txQJZrcP1nUcb8DhgLoVN75iSFew9fmUo9Dpyu11jT4SkXri1eealTKA9/SuAiMZrYrCKvoPwqfgzttWW28OAgc1ByQaixv1y82NVRw5QTSB2X5eUbMeMqVLOfQDqrMeU8hxOaFsrRI1RIWDquXOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3929.eurprd02.prod.outlook.com (2603:10a6:10:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 07:10:37 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:10:37 +0000
Message-ID: <08cf07a5-5aaf-586c-5745-c41df7091b54@axentia.se>
Date:   Fri, 7 Jan 2022 08:10:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/6] mux: add missing mux_state_get
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <90c40462-9672-949a-14cd-e13e440fe177@axentia.se>
 <YdLvGge5SbuhAi3N@kroah.com>
 <08a48424-a8e6-f08a-63d3-b00aa5cd33f2@axentia.se>
 <Ydb/lQMPxw3/IDIF@kroah.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <Ydb/lQMPxw3/IDIF@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0901CA0051.eurprd09.prod.outlook.com
 (2603:10a6:3:45::19) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baab41fa-6148-4f6d-cce3-08d9d1acce31
X-MS-TrafficTypeDiagnostic: DB7PR02MB3929:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB39295E0CBE2FC15A82C0A225BC4D9@DB7PR02MB3929.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: av7CkjVJoHEk2lLte3z1j01TkSQ5PWd7k14PhZfTxla/6Tu8DSPgmJbcg2fhAUMbFHVtF4EuHfII+POnj+WzPUuQVtiIayL5tkac1n1gSlHAz9jFgEjvyuwRM/ORPN4vnw79jTLYAm2b8bsISnIZg6CF6siawC9Q9p1QUAWLYpFbWuslLzStJj4ARWDeHmDN2kz1W/iwMqCqxDCO1broTmXBRmgWBRCKi+otXG48gDRzXZz6jonvHtvAq9zjnDAhqeo1PKM6ti5chd7PmM7KZAxKI81uM+cVFLzkaCTA1okpFI4cl0YfoZeIp7kE0Jf3zqurCdYXrTFkE1RKRYFXXXErp0F2pzfVQZrEJ9Yd8Q2IwlTS0q5FIrJCIsgVxdC0G2TxpdMKFLj2GyABPCW+Mop6/N/Gv81N5iWMkzPbYET5Qxlq08jqqjyX4glE58f2aOGneJW8Lv+Yvlr+d8ZrH7/rm+Ugn7/4dFqHi4nhqE+DB2CO8Hd+l9ncDJC26F3DkqFe2zeNnfPfiTvcZC5sd/L14ljJQoBdO0l5tI3dUM0xp4r57+4KOXPZiElmEr0f11kkfMEXeYYzFvAqRjSDLFJzD0C8o65Tdn0vqZF032/rWZkYtNUQe/WTfN7U/cAo7yOdf4Z7lwc8iwYjRScaR/AaELhoy4z6YqOMaOqLBxgou9G7yfd2PQlpwWSHf9/kgpk4Syqj+dhJ+GUAknIeRoRAW8k03a46yGYD2DPbgi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(136003)(376002)(346002)(366004)(66946007)(5660300002)(4326008)(36916002)(66556008)(6486002)(66476007)(2616005)(36756003)(26005)(8676002)(316002)(6512007)(186003)(53546011)(6506007)(6666004)(54906003)(8936002)(31686004)(6916009)(83380400001)(31696002)(2906002)(508600001)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnRzdStkbm93SmJoR2hpWVJYSGJtc2ZwR3dZNnhCaHFNeThMMTFnZC9YVHBH?=
 =?utf-8?B?SHN0Y3BLMmhFMU9VcU9GQWxSQ1pwYjZGbjJpTEZDeFVzWWE5K0duamhOUDBF?=
 =?utf-8?B?MTZpcjBPc0ZNNVV4c3U1T3VWM1Z1WmQ5OFRpRG00N3FvZEZPMEtlc2pHUjJH?=
 =?utf-8?B?WnF5VUpTNk05VkxoWWxYaEd0NWpvU0Mzb2J4Zmw0WVlqeS9rZHZkdTUyc0Fv?=
 =?utf-8?B?ald0djVjMVZiK3c1eEVERzd1QitSOHFqZzhHS2RQR2VIa3dndVJYOGlXdkIw?=
 =?utf-8?B?WlgyYkUyeGFVSEhqUzF1YklkSitnREhSc2JCSlNvSGkxaXBXdFNhSnNwMDBt?=
 =?utf-8?B?Nzg3T2FraXZybEFqTmhNQ3U5Ty9RL0cyTTVzT0pldDlVUTVzRVFhNXpPdUEw?=
 =?utf-8?B?OTJFeTNFWUlPdTZYWDVpcjJibWVpMXJ6Vmd4WXdRNE9hK2hDZkhZWFVCeklZ?=
 =?utf-8?B?ekhnbUd2VlZtMmtBaWQxRXhLL2d5L1ViMTdWTkRmbmF6eisyS0NMT0RLY1ov?=
 =?utf-8?B?N2xWUDRaMVlrbE5XNVRLWWtmelE5VnZML0VxbUdXOWJOM2tBQ3FYS1FpUEg1?=
 =?utf-8?B?bmdTZzVFSnVmSUlCNCsyVXJ2dkJSbGpZQVZiUlRlM1pZT1h6Sis1ajZuT0o4?=
 =?utf-8?B?UUtleG1OMW1hK1d2VzVsQVprcDdvNlB0ZENjVEt4RjZhMGhOMTZtUzdBZnN2?=
 =?utf-8?B?TW1wNUZPSklIOTlXYUk4U0Q3a1pHTzlIMVV5NGFWeEZyUXcvb0l1SEdLMWVu?=
 =?utf-8?B?aENVYjZQaEM0WEpyMlp0MnlMVnN3dUxRRFZxU0grRE1HL1dWb2FDamRGN0Fm?=
 =?utf-8?B?VXdENTc4bkN1d215Y1ZPbGZGSFZpU0c1L3kzVnZYVjU2QWtENTIvMDVFTFdV?=
 =?utf-8?B?SXVGYVNHRVU5MzRuZUVFODZXNGgySnVNMkFUYzMxakhLNG1KRkhodjkzNG1W?=
 =?utf-8?B?UEtKbEM0TXFzckRYTEhHNWNhVmYrVVRxNFYwam5qWmNjU1VPS0c4TFFtcDRt?=
 =?utf-8?B?N0I2NnRGM0xHRXdQbXk5cWlHVUVUbkJsK25MVXk5Z002Z2ZBVGhqbkFOblRi?=
 =?utf-8?B?N21GZ2w3T3ZZbGU1OE1oWEJtR2N0MGg4Q1NMRVQvVXZlR2pkbGVtTE1HM3pE?=
 =?utf-8?B?amU2UE1lZUpzQmZ2cEE4NHJVKzFmdWo5YjhrL0NSKzlLVDl6VFZIRk5vTG5r?=
 =?utf-8?B?bldYRHg3OFdOblJ6MVFyQ3VnMkE4VWNxTitaV2dZWG5BWTNSOGdzQ09Zek5s?=
 =?utf-8?B?N1V0TytGS2ozWmVPcTRvUW5KY1pmWm1wN0NUMTRFUk9COWp0WU5RZmtvdUh3?=
 =?utf-8?B?WVJtYzhva2x4QmFFcEJhekg4OWwwYzVCWWRTL1BKV1l2QUtkQTRUSXZaQ1Vy?=
 =?utf-8?B?LzkzS2Ixd3NJZHZTMDB4V1I1UFhaa1RZRlZtbEJ2WTZuWmZ2QTdleUVPU3ds?=
 =?utf-8?B?b2NEMVNLWVpTblQwbDZkb2gxWnFlWW1aeE4zSUdLdkkvMzdsOFpKV2MwWDdU?=
 =?utf-8?B?ZzFwMVRnaGxUVkRCZG95ZmNyVDBKbGZPVisva2RLTTBRc2lhbTlBdG1VeXIz?=
 =?utf-8?B?aHZKRHRVV2RMK0pkREdwTnFLdWkzUjlVV2NWalFoVmF0cWFsVzI3ZGRMMkhi?=
 =?utf-8?B?N3RBazZsa1RSWjliSG9DekpidzhtZWZHeWREaVZpUFNUZzhGeHBRMzloRjRp?=
 =?utf-8?B?c2dEUFNKMXQxOFFEUzFxTnhlRThNMUpVODhaMTd6enNycEhZMXpRWGRJTldG?=
 =?utf-8?B?cW1zSTBjbTNFaHFUd3I5MzVDdUhxMVQzaXVwQVp1ZUdXTmIraFNUb1lkUU9t?=
 =?utf-8?B?alFpUEdhNmlIZGxjdXY2ZXpVWFJIS1paa016Qk0xdnQvU0JTRnloUG5POUtr?=
 =?utf-8?B?U3VSVStvK1grTWtaQ0xKaVNHdUtjcEFpaDhtbnBOeG1kTkNEZFh2Q0pjM2Fr?=
 =?utf-8?B?ZDNDRzhYa2E4TjBqdDhUc1VVSk1QTXlWaFQwUkhXRG5rOXAraHBjbEgzbmU5?=
 =?utf-8?B?Tlk5UmRGOFJNTSt6NVZteTN0aUp2aEJFTG90TGVCSlFqRk9OM04xTWV2b2Ux?=
 =?utf-8?B?dXJxVWsrN29sRHZhbnZqaTJCUkxFOWlaLzR1NnBzY3NoTDVXMDZSMWJENE9T?=
 =?utf-8?Q?LF48=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: baab41fa-6148-4f6d-cce3-08d9d1acce31
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:10:37.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kp2TqDZlTC1NtHHKElKbBnh+udNfwIUzjCDdOGTmjG+vdx9GmTrB1kdSkbP+q6QE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3929
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-01-06 15:41, Greg Kroah-Hartman wrote:
> On Mon, Jan 03, 2022 at 06:26:21PM +0100, Peter Rosin wrote:
>> Hi!
>>
>> On 2022-01-03 13:42, Greg Kroah-Hartman wrote:
>>> On Sun, Jan 02, 2022 at 11:38:36PM +0100, Peter Rosin wrote:
>>>> From: Peter Rosin <peda@axentia.se>
>>>>
>>>> And implement devm_mux_state_get in terms of the new function.
>>>>
>>>> Tested-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/mux/core.c           | 41 ++++++++++++++++++++++++++----------
>>>>  include/linux/mux/consumer.h |  1 +
>>>>  2 files changed, 31 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>>> index 7d38e7c0c02e..90073ce01539 100644
>>>> --- a/drivers/mux/core.c
>>>> +++ b/drivers/mux/core.c
>>>> @@ -673,6 +673,33 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>>>>  
>>>> +/**
>>>> + * mux_state_get() - Get the mux-state for a device.
>>>> + * @dev: The device that needs a mux-state.
>>>> + * @mux_name: The name identifying the mux-state.
>>>> + *
>>>> + * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
>>>> + */
>>>> +struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
>>>> +{
>>>> +	struct mux_state *mstate;
>>>> +
>>>> +	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
>>>> +	if (!mstate)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	mstate->mux = mux_get(dev, mux_name, &mstate->state);
>>>
>>> will this build?  I haven't applied it but mux_get() in my tree right
>>> now is defined as:
>>> 	static inline void mux_get(struct gsm_mux *gsm)
>>
>> Yes it builds. As mentioned in the cover letter, the patches have been
>> in -next for a couple of weeks. The static definition you are pointing
>> at is from n_gsm.c (which does not seem to be #included by any other
>> file). This definition of mux_get is again static and in a .c file
>> (which is not #included by anything). Surely not a conflict?
> 
> If it's static, no, it's fine, but I don't see it in this commit either?
> 
> I'm confused now, 

Apparently :-)

The static drivers/mux/core.c:mux_get() is not in your tree because it was
introduced in patch 3/6. That patch refactored the existing mux_control_get()
into a new static helper function mux_get() with two wrappers -- the old
mux_control_get() that preserves the preexisting interface and the new
devm_mux_state_get(). mux_control_get() was always in turn wrapped by
devm_mux_control_get(), while patch 3/6 failed to add a similar double
wrapping with an intermediate mux_state_get(). Instead it wrapped mux_get()
directly.

I didn't notice that mux_state_get() was missing until after a couple of
rounds of review with Aswath, and didn't want go for another round when it
was me who had made a mistake, and instead just fixed it with a commit of
my own.

Maybe you thought "the new function" that this commit message speaks about
was mux_get() (which was new in 3/6, but no longer "new" here in 4/6), when
in fact it refers to mux_state_get()?

>                    can you resend the remaining changes and I will review
> them again?

On it.

Cheers,
Peter
