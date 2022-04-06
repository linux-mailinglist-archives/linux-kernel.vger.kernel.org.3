Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E24F6454
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiDFQIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiDFQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:06:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99C1CEA65;
        Tue,  5 Apr 2022 21:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACvObXXyHcD7NP2Tyh7m/D5c2KbR7TogbmiHzbImmKjNJtX8+pI3WBXy1i083z87EsVvse270OBRnHcPhirdRo5gm+zFHT7Ry2p2fU4QgBd9H2T96jZb7Yk331F2KxRZmfhZytUBgA2zRiyuEEJsMdeXiaa5y+zGKir3ktp/n17EDgfM8fFbpK7MsmcEcI2AxIL6Ex3C0Lr4eLtlNPtf9yO+WnufKu80SsBHfcwfMYiyIt8ZFwGMMMgjPAupviOiLMtRC52ydeumV29Sz/NwZtFPw1TQnbQbF7mOCUOmRQIuU40oj0Al7rOmZM4/xj3WHsdKvH8DavE/KC9yZMR0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiKL76rhnZut/fnvnECnH1FBFDxXVqNiG7x+cCJGjI0=;
 b=UZH4GRAWOZ7pC26GmqfyUcTZTSSD9jykBz05DWqhS8nsnUX4ZZBiKrr/uS7tj4J9QQDXMhJcfyLt7n1umRdn5mpOe31mwj/qAVrYvvvd3bZgZLehVTUd/eqj5wQ/RHpWHx8JHNccM1jKS1sZczKm4NNoEVDKZY1tna+mgasarXatI/nk7/+M9NK0s1N2FVbzUeqkS9KwL9KBlnJt4WpKaiFw3CRXveFFebUX5TAN4CMHYV+FLDbXDIS4SpRBALT7w+rdxg9rErTGcmkOqHiRr96SV3NIUmRHvoZDLFyXaLBDd5pe8H7oue+bLPLktagNIRkQroz4Itbs/YReq5a+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiKL76rhnZut/fnvnECnH1FBFDxXVqNiG7x+cCJGjI0=;
 b=PAsG+9UoRjJI6dSN/w4T5KlSjTFbGlEHgRKf5UM93pGRgBDzW4HBRbBL7xD+z16wDxfVD0qDiMKqWcfKtP7ulGScFV4q/dppZH/bvZa9RI0MMhR4IguHuBxjouUCef9TbWNTRiP8guihJe8lGz0xOZNYkalvtoL/TsSk6ffr8Uff4Nd9RuL7qJRbDKjjQUenKBQBCxl1oc//qMKf38Ikhmm81u4gyjXZ5Mv2wm8strQpK8uxZb76isVNV3rooZodd/nZFTFD5Yo2yJR+GeAWSUHl/xUY98NHJhFTfyHcoQO+UGvYgDZIDgqkz7SjyWG0Jbb0OdSsJYVlp7hOcsoqQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 04:44:51 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::8c21:efba:52b7:270c]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::8c21:efba:52b7:270c%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 04:44:51 +0000
Message-ID: <7bcb653e-8c70-670a-92c1-2d0463d1d51f@nvidia.com>
Date:   Wed, 6 Apr 2022 10:14:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Mohan Kumar D <mkumard@nvidia.com>
Subject: Re: [PATCH] ALSA: hda/tegra: Fix hda Jack detection
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, thierry.reding@gmail.com,
        jonathanh@nvidia.com, spujar@nvidia.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220405032607.8489-1-mkumard@nvidia.com>
 <s5hfsms843u.wl-tiwai@suse.de>
 <a6964809-ad10-aca8-0776-011c9e6b318d@nvidia.com>
 <s5hee2c82fv.wl-tiwai@suse.de>
Content-Language: en-US
In-Reply-To: <s5hee2c82fv.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::11) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67e08ea2-b789-47d3-c2a8-08da17882ffa
X-MS-TrafficTypeDiagnostic: CH2PR12MB4280:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4280C21C4486C08E7AA1F465C1E79@CH2PR12MB4280.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcJ8FzBAdH6Hr8iaFcGxFEFYnSwGZsBa/oVcmF6rre5lFwX9t2ThnIfhtkoXwilF1fwh0tuVecfXOTjcLmovyppyF7kDgSV7Vzp45gIJOSYRvWgwnv0eXx9WDlVCtKdu/Cvx9JTp6E+ux0YQ56Rfou/rsmS781zVFi2lsWRxUoefmHu/xescznfVCSyBbknKvM5z4YwHgHJZmxUNZXWXbl8edigo14l1znb45GF/+/M+rN8uU+lzDqBWncuaMKHjU2nv+0MJeIrP+1Mp59Y4TAH/5dk5Vjs9b7JBBn9PDg3+ZFyJ8sAkytyWfkdrBNalsnjzkWO58GBXPKdS6Lx44ik/yQQt66xRnVtKpVD66uBPcBNRMzIvIJt461FayO/BfLVIkyJEomABCPnXYXgVeJdLmi89fA595N4M/ZS/ZhBUoYAiwEMh8IBlTcy2WH1y7TpJs8C5DG/c/F19Xn/UlHRqNO4eLrFAIvzHDBlA/592Sa3+ZSY7zWwgWy+MWGYTXPeHqbIg/vcjNGd4juWioxSwxcLXo1Ulv6oNPSTv8wKumpx2LOnmXJxcTmQkuJC9403pIfmFgPVsiBmvYOa9912JTquqnIljti87KS2lYBFIVPr5E0yTG6/IXSKQspiE6CdwtjgKcU34P+XQxaA9vcUI3u8Cm0sBngRnzN5cHO9N82DD0uxZEykZbH+WoeB87TZuSIzJqKzHsvWow0Td/H/Jo3eAXWwX0F7h7kd5Jmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(31686004)(8936002)(31696002)(36756003)(5660300002)(86362001)(186003)(4326008)(66476007)(66946007)(316002)(2616005)(6666004)(38100700002)(6506007)(6512007)(53546011)(6916009)(83380400001)(508600001)(6486002)(26005)(66556008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJVcGMyaUZwSm1NU1UwUDVKZ0p4K1VMYmZkYXlzUWxoYVNaV0JtR2JVNjB4?=
 =?utf-8?B?NnEzQjBDaTJma1hlYWhKdlRTRWNnd1U3em9qTEtuSzl6R2RNTy9ydVd6TXNa?=
 =?utf-8?B?MVdSTnVGeDZ0V3doakhIOElBV0U2ekRjbDdEcTE1UVJFNTdNY0FsbUF0U1Ex?=
 =?utf-8?B?eERtNHdTMDFjK1cvSGFnMkYvYjFMUGd0YkNhcC9XbGpScTcrd1k3eitERTVk?=
 =?utf-8?B?em9wYXg0OS92S2Jvd1JEV1Y0ck5YcVBHckRnRTFhVFgvR1RVNUxTcEhEWHh2?=
 =?utf-8?B?Rmh4dVU1bko5Q1l6dE0rZTRLNFRHU08wUzV3RFlpdGFJUmlIa2FtNVZzdWZp?=
 =?utf-8?B?L0VPazlaRVlUcFRNdm5jZVBUcUtrVkhrWXpNUEp5S2k1WDVlMjN3dlpDZ3ZS?=
 =?utf-8?B?em1VM0oyWDdya2c1dmZVVnZBTm5MT0pqek9PVHE2L0tUbi9VY3Fwc3A2eDhl?=
 =?utf-8?B?Q1JtcmNUWnNTRjhUa3EraHczelFWdkhmdDEweWc4QWVFNytTbHkxRkU1OTU1?=
 =?utf-8?B?Zjl0T2YvSW9uQmFJNlR3WkhHTmR1MEtJV21mOStPdE9LdTRvU0dTUXk4ZFht?=
 =?utf-8?B?bDU4UXdhaFFZUkc0Tk51dEpzN2o3MkdQdHM5V3lsWEgweDhNSGhQUm1Wa0NR?=
 =?utf-8?B?TlRVY3RDZ0NwMW92d1ExSjBjTHpLWDZkeFNQbHNNYktkTnZ5ajE0cEsxcThK?=
 =?utf-8?B?OXJtOFRVdG5weWJDNFZ5UDVaMGtTWm5BdSsrZzFPall4cjJ4aGtFYlY5T1B6?=
 =?utf-8?B?bGNaY0tJUUFiQ2J4VlFQRmR3dmxjcHNtYVhobk5nbmZnN0Z6T1ROMHNubmxt?=
 =?utf-8?B?ZmE5elNoZWJEM0dSZERETUpVOXBMcUJMR25EbkxUd2xRMjc1em51cEE5NVp2?=
 =?utf-8?B?WTQyQk9RY29Tb0czTFdOeHBldmFUYXp6a2VzU0FkSXl4VjEwUWQzRGMvaXB4?=
 =?utf-8?B?K0pJWnBXbnlJeitjRzdhK1VTbTlFTGJZSzUzK1Q0eXR1ZnM1R0ZKbUZoSTli?=
 =?utf-8?B?MVJJS1haN3R1S0JqQ2owWm1EQjEzTjQwWVRIV202ZW93T0FWQThseVVwelR6?=
 =?utf-8?B?ZWZtNmFKZ1RTRndET1pWVDZBQTR6b2o2L2k1bk9qdXMzYzEraHgzbWp1cEpz?=
 =?utf-8?B?ZURDYjNiOTN2TlA0NWtvTjFacmdtTFp4SkZLQlgySU5VS0RVd0gxRGdFLzAr?=
 =?utf-8?B?aDJTOHZLaHhoRkpTSU5idllrcjRiOUl2QnRhNUtqaWhWMTFtbTRxUVNWZ1R2?=
 =?utf-8?B?T2QxQkNSeUtTdlZYRkVJdkhONlBpckxUOHZGa0o3T3M1ZnRWYUltVmphWk5R?=
 =?utf-8?B?cVFCdEg3VzFqTTJSb2hBanVicHFxWXdaU0xmb25xalRKMlN2MTN0RnJ3bDR6?=
 =?utf-8?B?bjhFbVcydUFJRmtwNDYrc0dONXAyd3g0Y3YzSjVaQTNWaU50UXgwZGhZMFdP?=
 =?utf-8?B?cHhKdTFmeXdFREFFZG9vRFVYa1JrNFExVGU0Q3J5cFVKYTJZMlBHRkxSZkFG?=
 =?utf-8?B?clN1K2gwZ1lJdUZDdHJXWjYwaGtpQXgrcnArTEh3cENvS09Gc0Nrck9jcjlh?=
 =?utf-8?B?dGcwQ0xHVnI0N2d1bURVeVkrRU1UK3BXZ0g5bnkvcWttZVcwYzRDUzRrRmZi?=
 =?utf-8?B?NTk1L0VLYjM5UGxrUDlvd3hvZVlvNVFHTWwzNFNUWWVLanJUT0Y0cjgzN0l2?=
 =?utf-8?B?c1pvcGlxNDUxSENFYmVsby9rNnc5amlzZHhkeEdESytkcTNqTUlDMXFMaCtV?=
 =?utf-8?B?RzFFVU9MN08xeTF2dlNlM1JuajJUdm9xay9jUjN0TmFCOWx5blI3U0YvWmpR?=
 =?utf-8?B?Z0NPM2xQQVZ2RGNhV2s4N1FiYlROUlNaeWQ0OS9rUEM2WU9hb2tacXFWaHox?=
 =?utf-8?B?VkV0NUVzL1BGWlVrM2hVQkhNVHd0SzVUcUZZVDM0N3g2K0pTL2dvSmFiUWJD?=
 =?utf-8?B?RVkvUDl2Z1BWck9LTnFzRXRHZ0xYQ3pDdEU3eG9xK0lqMW9mZ1VNSzYxVnVP?=
 =?utf-8?B?WDkzdlhSUlIyNmZoU1hDdm1QQk5BWFVpdFp5MExUSktLRXAvM0dCUEdtM0Z2?=
 =?utf-8?B?Y2hpbFA5Z2hOU1BTZzUyL21VclhwNDBaRHBldno4SFVrRkZaUWcwTzJYZCtO?=
 =?utf-8?B?RHdKT3hQTjlzUk5GcHlxZVR4aDZyR3hVbDJiZG5HaXRnQUNzRXpYb3ErUUsv?=
 =?utf-8?B?Ymx2a1FGMzA3L2FEUXlCNjVTcXpJVXRDbVUwWGl2amNXMnlTUGV3Sll0TWl5?=
 =?utf-8?B?dWw0NVRGYWF4d2NqdXdsZEtqM242dVl0VjcxSHBRSnp6ZzhOaGhSeE9OeEFy?=
 =?utf-8?B?cW1iOGdCcklHRGpWMi9VcFFoL1A0WHFJaXdEN25vRUc3UDJBODh6QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e08ea2-b789-47d3-c2a8-08da17882ffa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 04:44:51.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU9aRvGzw6jVQ1bpI6pNv4b3Y/jAOkejCjqZhep5Lty7syZhbf24ij2V3trT22WfcNhNHOC66bfu5O8MZvp/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2022 12:03 PM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 05 Apr 2022 08:05:03 +0200,
> Mohan Kumar D wrote:
>> On 4/5/2022 11:27 AM, Takashi Iwai wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, 05 Apr 2022 05:26:07 +0200,
>>> Mohan Kumar wrote:
>>>> Tegra HDA Jack detection logic doesn't work when the HDACODEC
>>>> in runtime suspended state as unsol event won't be triggered
>>>> during D3 state. As pulseaudio server in userspace rely on the
>>>> jack mixer control status to show the audio devices in gui and
>>>> any display sink device hotplug event during D3 state will never
>>>> updates the jack status which will result in no audio device option
>>>> available in userspace settings.
>>>>
>>>> The possible option available to resolve this issue for multiple
>>>> tegra platforms is to use Jack polling method for every 5 seconds.
>>>> Also to make Jack detection work seamlessly the Jack worker thread
>>>> needs to run continuously after HDA sound card registered
>>>> irrespective of whether HDMI sink device connected or not, but the
>>>> Jack state update call happens only when Codec is not powered on.
>>>>
>>>> Signed-off-by: Mohan Kumar<mkumard@nvidia.com>
>>> Hmm, any reason not to use the standard jackpoll stuff that is already
>>> implemented in HD-audio controller side?  That is, doesn't the
>>> following oneliner work instead?
>> The reason is, the Jack poll thread implemented in hda_codec.c runs
>> only when HDACODEC is in runtime resume state. But the problem trying
>> resolve here is something opposite, bcaz when hdacodec is in runtime
>> resume state unsol event would work but not during suspend state. So
>> either need to make some changes on hda_codec.c specific to tegra or
>> make it on tegra specific driver. So I went with second option.
> Well, the current behavior of jackpoll is intentional, so that it
> avoids the unnecessary power up at the runtime PM suspend.  And your
> requirement is rather opposite, and it's not Tegra-specific at all --
> you just prefer the jack notification over the power saving.
>
> So, implementing the feature in HD-audio core side would make more
> sense (and it's simpler), something like below.
>
> BTW, which codec needs this?  If it's about HDMI, doesn't the audio
> component work?  At least nouveau has it, and I thought Nvidia binary
> driver does poke the driver at hotplug by opening the proc file or
> such.
Thanks for the feedback. Will implement the next patch in HD-audio core 
side as suggested below.
Yes, it is about HDMI.
> Takashi
>
> -- 8< --
> --- a/include/sound/hda_codec.h
> +++ b/include/sound/hda_codec.h
> @@ -59,6 +59,7 @@ struct hda_bus {
>          unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
>          unsigned int bus_probing :1;    /* during probing process */
>          unsigned int keep_power:1;      /* keep power up for notification */
> +       unsigned int jackpoll_in_suspend:1; /* keep jack polling during runtime suspend */
>
>          int primary_dig_out_type;       /* primary digital out PCM type */
>          unsigned int mixer_assigned;    /* codec addr for mixer name */
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -2935,7 +2935,9 @@ static int hda_codec_runtime_suspend(struct device *dev)
>          if (!codec->card)
>                  return 0;
>
> -       cancel_delayed_work_sync(&codec->jackpoll_work);
> +       if (!codec->bus->jackpoll_in_suspend &&
> +           dev->power.power_state != PMSG_ON)
> +               cancel_delayed_work_sync(&codec->jackpoll_work);
>          state = hda_call_codec_suspend(codec);
>          if (codec->link_down_at_suspend ||
>              (codec_has_clkstop(codec) && codec_has_epss(codec) &&
> --- a/sound/pci/hda/hda_tegra.c
> +++ b/sound/pci/hda/hda_tegra.c
> @@ -421,6 +421,8 @@ static int hda_tegra_create(struct snd_card *card,
>          chip->driver_type = driver_caps & 0xff;
>          chip->dev_index = 0;
>          INIT_LIST_HEAD(&chip->pcm_list);
> +       chip->jackpoll_interval = msecs_to_jiffies(5000);
> +       chip->jackpoll_in_resume = 1;
>
>          chip->codec_probe_mask = -1;
>
