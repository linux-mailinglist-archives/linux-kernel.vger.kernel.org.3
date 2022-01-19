Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F37493D79
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355875AbiASPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:43:49 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:47841
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355832AbiASPns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:43:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVeh9cYH9yq5yAIcqdfdo8qwU+qCU3TifzdXpNdk3czJsKXWqTiNE8av2SJOCgqMfNdAl4ycFPaQdtYtON4n8tZkeLyvDUL8EqrMH6jTAe3KmomQSv1SqeU4y+MdQKz7a8HkLiBKZ7jyB7hEIKIg/3lBUBg6llH5GkFF0kZaaztf5lldSuY7q96bP0/cjhPWVxGOngLWLej3ddq5ChGma4UCSmOzz6Ge5SS/+ZgqUBx8J6HdFK6A7FrxsAsJPV8WDh9nPp9zdbb8Jl9orrGBWbWimLPiVxrk0j/w3nForaTzBbCn1/3nCvdZWvAwMvf4jAVv3zoG1lRa2GqyLIP8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLsUN3jbSlB0nH0FpgXOcCYtONEwewxVUnjmp+NMdT8=;
 b=k9OUMb/JipvImS5OBJ0sNLrvqOmgRU+Gs3eGqXsPfnkAQp9BjIlvYpmZbxWWVBd/RQQh1wwCDwskUQ22o7x6EiFsJRKFZHNMRRZ63itnrEdn4StTNL4xKwCVuwJxbbRPAzrBT/qBRdhKBFNlMKKSu5hJ3q2lyyPe5IZuN7mpzJcaYpC+scOSGdK0ScyDhNAOU/arWuNouSB1j9F2/iXuM5m5gU5+CFaOv2fQ/TIVLQXjIZTbuB/uJVW9QsZNm5QghorRfm4UsI3PDaQ3IKC2J5oA/dYAfg6K+XzvZjQw2wv50sFotnVp6ClKwwUUP8VohBuZGltUx6yZ3R7DwHOSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLsUN3jbSlB0nH0FpgXOcCYtONEwewxVUnjmp+NMdT8=;
 b=X8Wxsr+JwHhNOdhU0cdd/7qs07peVWmCQSoOtQNJ20zTV49d/6gU91CE4kkSkDkVpK99e4rdLtoHdVVwtlD8cTxo2TrbLKrQdtQSvBkkng2YpwSkoYusVVIx5fsjQzmItFcPx/MWnNjy3iRRPdfalY2G8tKEylft9LKvivRiSkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by HE1PR04MB3114.eurprd04.prod.outlook.com (2603:10a6:7:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 15:43:45 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 15:43:44 +0000
Subject: Re: [PATCH v2 2/2] ASoC: SOF: compress: Implement get_caps and
 get_codec_caps
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        cezary.rojewski@intel.com, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, paul.olaru@nxp.com,
        sound-open-firmware@alsa-project.org
References: <20220118212732.281657-1-daniel.baluta@oss.nxp.com>
 <20220118212732.281657-3-daniel.baluta@oss.nxp.com>
 <41ae6093-8e27-01d4-e532-8a28fb1d9cf1@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <8786f0c4-e60c-92ac-ba07-8244c785f75a@nxp.com>
Date:   Wed, 19 Jan 2022 17:43:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <41ae6093-8e27-01d4-e532-8a28fb1d9cf1@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0077.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::30) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6712de5d-ca6d-4be5-ef79-08d9db627998
X-MS-TrafficTypeDiagnostic: HE1PR04MB3114:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB31143852F6DB2E2F835444D1F9599@HE1PR04MB3114.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KC2WDehVrC+5KOz40mg4WsLw4nhGfW/qiaXaJQi+EhDEFdtD2tcZ/GSjKiiNe1U5z2PORXoEgF9ZAYcUIVArNHwVHjffBN8IbjofbiPAk7Y/orjbEPohIC3w6A5m5S0RxYao7fRpKJnQWKfdLiGVGQxICin9RiDBaMQxc0PuZRsjU8g9dGnu9iNT2GJipsTXJtb3X8quDeTmJTRHEy7Q40HRwmojfV7ils5H/oCn56kzDBUDIpW/f1jPeeWHOM9ClWALesvBelGpWMCsQDB0EhRnS6PQpKTWn+Ht0gqa7zh9ajNoEfn59AXvogv+7fOIMXZ8Mxtjj4/+Jjjx+0XN5ByDBjmXgUvCbuCQxFHxojvAZAO2pt2FsNJ83ty6urKsoBT7RJeCaVhJd39Iuml5Dnmgd4aTCsE2u26yq8uvXbqMWOfTeYnf5uxN9kFf2tJNf1mk0u9q1FCvlUEP7Fsyn30BMU4i8/LCHoMQR9ObyYD0tXWtSkrEh3sQp1jQxKsRvHCd5mm+INNM4LvCq8hZLceaGDZJNBe4TRNyI+s3aLEwrAIhM3QBs3M8Glw84L8sCD5uws36YPH4lSfJxo7hPMaCDUhJxcaE35+0mYnDYi2kVR2afLr1YKCPAixyQ1EiurNm6NJoj7Bq4Jccbd53f+ABO8hANGHCCJl9gNZdiki0U+Pt7YB6wShzoQfCXjAAxYU4FIyU5AfpF71MmDeMvMLZ2qyN9jwohYlpPC5TQMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(31696002)(316002)(31686004)(44832011)(8936002)(6512007)(5660300002)(186003)(6666004)(36756003)(66476007)(6506007)(38100700002)(8676002)(86362001)(2906002)(66946007)(2616005)(52116002)(4326008)(508600001)(110136005)(53546011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXFqcGcyUVJLYkJIYmVuOW1vYVMrZGNSemZtVEpESmc2NUVRMG1GVFk4Tk1j?=
 =?utf-8?B?dVloVzROb2xIWmkrVnZtNGtKMGE1YmhNUHUyVFQ5bFk2eUVxQTc0U2JjZG5a?=
 =?utf-8?B?Zk5xNC8zSHoydU9Zd2JxTWI4MGxKeEROWUhhM1MwLzgrQlY2dStla1VpMXRN?=
 =?utf-8?B?QXBlWGEzV29JWElObExXYkJEK1h0NEhjSGdwNlo5U2lWUFV0OVRDd001ZERN?=
 =?utf-8?B?RUN6NG5MZ2lreWRGRmcwUmJMeTVIYmhXbTNDVjgvc0FXcmI3aUxHT1Ribi9U?=
 =?utf-8?B?aW5GT2V0akNiejA1SVJmaGhsWXdYYWZhV2liMmRpYUZCejhHT1ZwVUVvV2JH?=
 =?utf-8?B?OXlwNWpDYWpQcmJlZlVCc0JrbEpCeFBFMlQrdUNadDJzbVBrZ1dsanBLRTJ1?=
 =?utf-8?B?dGdBNTZJSlhKTmhlQzdvNmVFMndCNTlOM3h0cDVWeC9Pb0ljU3p1V0o5eEd0?=
 =?utf-8?B?ajYwUk03c0pZOFVZdHQ2QStURENiOW9UTVhlVDdvTFFpR2JaTlNqUWJlTW9u?=
 =?utf-8?B?SHVZemlrRTNDQXR6VFhxSFM2OFRKaE9pMzcrSXI3ZDNmRllFYTFZWUhmTWoy?=
 =?utf-8?B?eld1Z0h2dDV2MWJtb0V5TnJPUVNDSnVMYzF3VlZnM0hsVnJkdExJNmtqZ2pp?=
 =?utf-8?B?TE9hK2doV2NHdXNnaVlVdnV4TnlzbE5BdUFnVmpOSHExRU5iUUtuVktyeWZD?=
 =?utf-8?B?UHRwNERBWmlDd1VkUnAyaDliUWp5YVovQmQ2TWc3YmJYa1B4dnA4RS92dW5U?=
 =?utf-8?B?cld1QUZ4OXdRL2hlZTJsM2pENVpUUlFkTkYxMlN4eDNqaE9JK3pEMFh0RkpU?=
 =?utf-8?B?b05YVWhtRmhVQ0Y2VXFrZit4emppL3lMKy92WGhnSzdyZjBESmJwU2x1NkRm?=
 =?utf-8?B?Q0pKb1BUSnhNNE1XNDRDYmVRWDFXd2Jtc0ptMnBkK1drRFZpRTRwTTFZdGkz?=
 =?utf-8?B?MFB2a1hMcC9WTDVlU2NXcXlaMUlTZGFnaGxNNHNsRkpRRC9jd2ZZTWFyS0dL?=
 =?utf-8?B?dFRnV1ZBZHpEK1UxRUg3bkdtN0xlVFdVNkRlS2pVcDlkRFlSNXBHRVVqYlZv?=
 =?utf-8?B?aUxRTDZQZVp5UnA3QmJNS2tCZWpIanpqdkdueGc0YW1lcmV0MEs3cDZVM256?=
 =?utf-8?B?ejFuWVF0eWpYVm5xK3dOcUpKMDM1WFExV2dCbnRYZnV1R3dzYTBOVnE1R0h6?=
 =?utf-8?B?T1oxWHU0TEg5WkY5MWFxVTZaWE9oTSsyOFRZWE0xdFk2VHRMVEZrSWNndDdu?=
 =?utf-8?B?bktOdldTdEtsby9QUXNnMnRQdkJnc3g0c0Z3YndQK2RWcDVWUUZITENzdnNn?=
 =?utf-8?B?NFRzSExSR2tZOWZybkl2eE1hYUlJRUs2T3UrcUt2WkNjZ0ZIZGtFSW56Szhl?=
 =?utf-8?B?UDhIcnE5Ymx5QjI1aW5BUTRYMXhHSVJ3NUJVdXFDbUJZdVJIUWQ2a2tlSEpx?=
 =?utf-8?B?SUE0WTl5SHpaSnJMN2o1TW5hK1J6WEdDeTNYOW5wcVUwWHJWQkZKcVhsU1pN?=
 =?utf-8?B?Y0tPYUVsckFySzhMOHJOLzZ6dGM2bWNnYjlmYUIrN0tYMVQ1bVZOQTZmQWZE?=
 =?utf-8?B?S0ROQjN6NzQ2alVuMDRYbXdYRDQ4cGZNbE9kaC9ycjd3RXJmUXVIaGoxa3Bi?=
 =?utf-8?B?RGRnbDNwclp6eEV0bytHQ012NFNrS3p2aUNHOFU0MmNqUnMwakxPeXlEUVpv?=
 =?utf-8?B?clNaNkdLMUEvNUZGUGZKbEFGbldhbFhYaGZkbUR0Q1VmcmZSZEUwOEpzN3dH?=
 =?utf-8?B?MEMzYU5rd2w2Y0h1WHFFZXFkWnd2SWVySSs1YmIyWk9qUUZGVkZTL1hYOEh2?=
 =?utf-8?B?aC9KWEE3NFFCMnI4cmRWL0F2WCswcThHVStEclY5TGZRNloyc0hVNVB2UHc0?=
 =?utf-8?B?NkhDQlF5ajFSL2dQK21GTUF4K0JJa3d0Wmg0RE5QSkczanBkcktaWmhTNUM1?=
 =?utf-8?B?WkF6b1hOT25OcDJFYkVDZWdjMDg4MmFSUVo3SWRHczUvUGpvZHFtcWQ3eElt?=
 =?utf-8?B?RUVjcEREMGxiM0h6WGtXWXdzQTJhWlowK1ZoQjd4c01NSGJjL04vWHY1Z2wv?=
 =?utf-8?B?OVZEYzM0bHMzanZTcE5MY0trRjE0cWlkL3pmZ0t4RUJ4WGk3eVZhM3dwTVRs?=
 =?utf-8?B?dThrVklpRzVzSmZLWXZsaTFVR2Jvc25IZTI4aWpYc3NVcnRzNGp2M0Z4dWN5?=
 =?utf-8?B?VVdHekNSSnFDWUlrbzZTamg1UzQ5OWIxME9CNHZEM1BkakMreVlLUVk2S2NV?=
 =?utf-8?Q?8WIrMe7zVaul0PaeIAVd7L+/kltqY2LlsChWFtZm2U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712de5d-ca6d-4be5-ef79-08d9db627998
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 15:43:44.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q72OWJGAwfeqfFbeSYyYPU5maIfHEH5qK8Y9S43HSFKxVUx+DZ9Zzu5O9oVgDMjuEMcRm7WxE7UvYzY6NRGL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/22 3:00 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 1/18/22 3:27 PM, Daniel Baluta wrote:
>> From: Paul Olaru <paul.olaru@nxp.com>
>>
>> These functions are used by the userspace to determine what the firmware
>> supports and tools like cplay should use in terms of sample rate, bit
>> rate, buffer size and channel count.
>>
>> The current implementation uses i.MX8 tested scenarios!
>>
>> Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> ---
>>   sound/soc/sof/compress.c | 74 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
>> index 91a9c95929cd..e3f3f309f312 100644
>> --- a/sound/soc/sof/compress.c
>> +++ b/sound/soc/sof/compress.c
>> @@ -308,6 +308,78 @@ static int sof_compr_pointer(struct snd_soc_component *component,
>>   	return 0;
>>   }
>>   
>> +static int sof_compr_get_caps(struct snd_soc_component *component,
>> +			      struct snd_compr_stream *cstream,
>> +			      struct snd_compr_caps *caps)
>> +{
>> +	caps->num_codecs = 3;
>> +	caps->min_fragment_size = 3840;
>> +	caps->max_fragment_size = 3840;
>> +	caps->min_fragments = 2;
>> +	caps->max_fragments = 2;
>> +	caps->codecs[0] = SND_AUDIOCODEC_MP3;
>> +	caps->codecs[1] = SND_AUDIOCODEC_AAC;
>> +	caps->codecs[2] = SND_AUDIOCODEC_PCM;
> 
> I don't think you can add this unconditionally for all
> devices/platforms, clearly this wouldn't be true for Intel for now.
> 
> If the information is not part of a firmware manifest or topology, then
> it's likely we have to use an abstraction layer to add this for specific
> platforms.
> 
> it's really a bit odd to hard-code all of this at the kernel level, this
> was not really what I had in mind when we come up with the concept of
> querying capabilities. I understand though that for testing this is
> convenient, so maybe this can become a set of fall-back properties in
> case the firmware doesn't advertise anything.

I see your point. I think for the moment I will remove this patch
until I will come with a better solution.

One important thing is: where do we advertise the supported parameters:

1) topology.
2) codec component instance (codec adapter) inside FW.
3) Linux kernel side based on some info about the current running platform.

Unfortunately, most of the existing users of this interface really do 
hardcode supported params:

e.g

intel/atom/sst/sst_drv_interface.c
qcom/qdsp6/q6asm-dai.c
uniphier/aio-compress.c

But that's because I think they only support one single platform family 
which has same capabilities.


> 
>> +
>> +	return 0;
>> +}
>> +
>> +static struct snd_compr_codec_caps caps_pcm = {
>> +	.num_descriptors = 1,
>> +	.descriptor[0].max_ch = 2,
>> +	.descriptor[0].sample_rates[0] = 48000,
>> +	.descriptor[0].num_sample_rates = 1,
>> +	.descriptor[0].bit_rate = {1536, 3072},
>> +	.descriptor[0].num_bitrates = 2,
>> +	.descriptor[0].profiles = SND_AUDIOPROFILE_PCM,
>> +	.descriptor[0].modes = 0,
>> +	.descriptor[0].formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
>> +};
>> +
>> +static struct snd_compr_codec_caps caps_mp3 = {
>> +	.num_descriptors = 1,
>> +	.descriptor[0].max_ch = 2,
>> +	.descriptor[0].sample_rates[0] = 48000,
>> +	.descriptor[0].num_sample_rates = 1,
>> +	.descriptor[0].bit_rate = {32, 40, 48, 56, 64, 80, 96, 112, 224, 256, 320},
>> +	.descriptor[0].num_bitrates = 11,
>> +	.descriptor[0].profiles = 0,
>> +	.descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO,
>> +	.descriptor[0].formats = 0,
>> +};
>> +
>> +static struct snd_compr_codec_caps caps_aac = {
>> +	.num_descriptors = 1,
>> +	.descriptor[0].max_ch = 2,
>> +	.descriptor[0].sample_rates[0] = 48000,
>> +	.descriptor[0].num_sample_rates = 1,
>> +	.descriptor[0].bit_rate = {128, 192},
>> +	.descriptor[0].num_bitrates = 2,
>> +	.descriptor[0].profiles = 0,
>> +	.descriptor[0].modes = 0,
>> +	.descriptor[0].formats = SND_AUDIOSTREAMFORMAT_MP4ADTS | SND_AUDIOSTREAMFORMAT_MP2ADTS,
>> +};
>> +
>> +static int sof_compr_get_codec_caps(struct snd_soc_component *component,
>> +				    struct snd_compr_stream *cstream,
>> +				    struct snd_compr_codec_caps *codec)
>> +{
>> +	switch (codec->codec) {
>> +	case SND_AUDIOCODEC_MP3:
>> +		*codec = caps_mp3;
>> +		break;
>> +	case SND_AUDIOCODEC_AAC:
>> +		*codec = caps_aac;
>> +		break;
>> +	case SND_AUDIOCODEC_PCM:
>> +		*codec = caps_pcm;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>>   struct snd_compress_ops sof_compressed_ops = {
>>   	.open		= sof_compr_open,
>>   	.free		= sof_compr_free,
>> @@ -316,5 +388,7 @@ struct snd_compress_ops sof_compressed_ops = {
>>   	.trigger	= sof_compr_trigger,
>>   	.pointer	= sof_compr_pointer,
>>   	.copy		= sof_compr_copy,
>> +	.get_caps	= sof_compr_get_caps,
>> +	.get_codec_caps	= sof_compr_get_codec_caps,
>>   };
>>   EXPORT_SYMBOL(sof_compressed_ops);
>>
