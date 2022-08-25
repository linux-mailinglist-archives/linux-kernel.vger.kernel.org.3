Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902105A1A83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiHYUod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiHYUo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:44:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6499D100;
        Thu, 25 Aug 2022 13:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzryGE2bHOmonePjhhcNUeamJfaB8uIpcKRYKr1Bx6Kxk/Mlr/TC8USLfchtKJcCI4lzd14WaZCeZMImHYPy0YMZWZT1dMq4QXqdDS95aNkAAqC2a9wd9gEh6GdYoWjWI8tN54A3KTMVLQSIGZc4jfoWHt9umA6ZLSt8+ob8Sg6aGIH96tQsL54Qvw5q6iSZb3Uw/FF8drMz8ADkFshgY7sadNTBRse7hEpxa+RwsWRRSb0sK0XsiTRVuzYg4nmj9NyTmvDsYKdWCD2oIUzjW3ZrxSKoyQAVIIWTLQ4/jO9SxR8lw5HVgQx4Mu+/hzRWsNnGO+tsjFBo+WajQHku4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWi2rHYWZpTlt/b7CGFUTCYlSvR68vUq75td2uh+soo=;
 b=ToIb7szp4/anImiXwHosnFG6vltC98CftbgjU7PodEIh+Lke7luDiBT1XmYNda5KOQXBNMJdXj/0RqntoLNmKT7XrARJH0W0Ff1rtXNlpiFACtPAYAQxZYpX7JVb4Fl4r++hpwLXtJu3uwts4ThXBEnNzVXAEf3tKKXDNFiSca0rpIk6RGjKmAoMTk7HaO/hC9uts6T8kJfK4ZjkdH9FCxIZ555YVaN/Ag73IuGiv8e50Vfm+iDhB4dJytjpq3kLcu7r33qmTYYHoEv95pERDBTd1qgCdTeUqRk2Pr5z+iJlvdvZicTcJnMY1YpRZQPi7gwyPaCyDwe04GYs8aDbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWi2rHYWZpTlt/b7CGFUTCYlSvR68vUq75td2uh+soo=;
 b=i1o24OqwpAhbnRj63M1/284UkPduB1p7AjYI7IZYNp2NP6gGMAhWU9yB7vcmln18NwbT47bLkGfHuCdglHVSt/R1w713QJcDjqUMEMiDf/Ka0inCotECcsDEKhftokjtIFZO/Pc088oVW6z7JVCYn1ou++gUaF+Zw7eGuB5XfEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 20:44:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 20:44:24 +0000
Message-ID: <d970a472-1da3-19d2-bacc-05f4ed02992b@amd.com>
Date:   Thu, 25 Aug 2022 15:44:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 06/10] x86/resctrl: Introduce mon_configurable to
 detect Bandwidth Monitoring Event Configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com,
        "Luck, Tony" <tony.luck@intel.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117582698.6695.3458866624522799072.stgit@bmoger-ubuntu>
 <575bf1d7-8780-8c54-851c-e9849d1815f8@intel.com>
 <5d650c6c-2f17-6013-f63f-49a182961494@amd.com>
 <93d1a26f-559f-63f7-d2b1-e8831a9df62c@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <93d1a26f-559f-63f7-d2b1-e8831a9df62c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:610:b1::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da548586-c31e-4398-3301-08da86da9870
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqtE3NPFmbQeMRQk/gxGRuYCsfsvVFU5N9sk10ciWAvExSpnhsn72igEoE2Zp+UR3lvENX9M9p6gtk+seRdvVBawLfhVdmdoIhD92c2C4SNhLmQ8EFIDi1FBM7aZccqP/7upTbQFvithYmHz76PhGsq+Cd+5by4WRB7Y7tRmnLco6a6+rVQmA8ynsdRgvNm7yzB94AUG8DbuR9pkfZ9BejEYXs02htL24tW9xBm15emnKVDDzzSWGc9vG1qE1KoB6qSt3yiuL438HAIafONEi1aWN24M025BsdEPVFVLVUOFPysPdZjspjEmDNDdmajWKt52Y1YBC0T2lO1ar+HzOFduEeFYGsgG64Wff9l3LKO+LoivMN9h5KqW7HxwqguyN2hJ3CbPRztmh26awVp9u85N8iEwM3kacijXK8UpbxJWRzhZcxBg8QEEfmb08Ot/x5VOt3S0vqnjmGU3XpT3tjuoV3xNFMmM4T5cRIoX8ts1opAOGnQlz26r85tSah4+ofe+khJB0fLZSq1OMzzGK/bBFXa77ZnjaRdnE0dBkUFybjJPbKDfveNwAzpPKhsEWftZs/6/Fxu5blKV8ok1X3cwV2FrrIepI+fAIseIEMq09/AYYK0kv36OX6u1sBSiIu9Mo2UZ8VszwBFQ7qO1idgJww3GTLTF6iuyuNHDx566D7eHAaES6ldk3lefA1F8ykajlC2sS/kxStp3oh3nSzd/0wCs1Y2GFDgQ5329Yoz3fhlofDu9soeRRZstLNPZZA9G3QljaaN7KIF3y7mSVz0luhI97ffsVXkLpS70Ev8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(2906002)(31696002)(66476007)(5660300002)(66556008)(4326008)(66946007)(8676002)(36756003)(8936002)(7416002)(83380400001)(316002)(38100700002)(31686004)(478600001)(41300700001)(6512007)(6506007)(2616005)(6666004)(6486002)(26005)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9kMERIL2JRcTRWaXpPb2dicjFTZHlIbkRMYldMZGs0aVNhUTV6UmV4Ty9p?=
 =?utf-8?B?aDRWazJRZlJIZ2s0RGZxekVaa0oyampoTCtuVitLWkg4Qy84cXhIMkk2VVAv?=
 =?utf-8?B?TU1YYkZZaHh4UWNMWGNrL0w2VS9OOFUyL3BTYjdaVlRlMEF6R3h0eFV1K2g4?=
 =?utf-8?B?SVJIeTBRQmNWN3NORHdJdTM3WVUyUmQ2OFM0OGM0VGUvU0k3alFjSTVlTFBR?=
 =?utf-8?B?TEdra3B3cklKcGhRdDI0TWtCRHF2YUtVVUpiRmsxK1ZpME1MY1B4MmRsOCtW?=
 =?utf-8?B?OHBOZkk3SE9kMmdxb0Z4TG9oaDlPeFBlTnFnZWp3UGVnQjVsd1NBQ081Z3JB?=
 =?utf-8?B?WTI4N2grVStFUm1iRjJnRXJqbENaSFpSbWgzSTNwdXo0RnI4NlhsMjhVbHFQ?=
 =?utf-8?B?M0R5bU1mVGdURVcxK3N2YmtUb3ZwTE1zKzlRenQ3OHRia2FvNlJQYkNQSVM4?=
 =?utf-8?B?c0xISkVNOTRiZGxWT1cvU2VaMzlvWitsWmt3SlVDdlZ6Lyt1OWZTdElLK3BO?=
 =?utf-8?B?MFNxTWlvQjQ0RW42TUxNZ3hKdmY2K09QVWs1dXVvRU11S1lZZU1XQzVLSmx6?=
 =?utf-8?B?ZEFiOW1rYU1aSGdpRlZvc2FIYVh1SkRxbHZoVUNDZ2trZW5HS2hFcmtHRVVK?=
 =?utf-8?B?MEc0VXJXcmEzN2k3UDk2R255MkNlWVE5ekV6MUp3TjF4eFB0OEkweHd0NjBz?=
 =?utf-8?B?MFNMOFNYalFXbHE0azZ4SElPRnJaVTZ1TDZ0MXRIMkhpdDN5ak1FdVFPZHBi?=
 =?utf-8?B?OC9YMG5iTEQvbDRaeEFwNmwvbzN0RC9BcTFKMUNQa0lIYzdxK3EwR2NyUi9D?=
 =?utf-8?B?MnQzV05EdE9JalFXanZxbktTTitLVG1XVVlIaEYwek1OWEhveU1rZ2wwTkN5?=
 =?utf-8?B?ZElNbllsNks2SUxUQitnTHlNZTRuNmxrOEE3YXM5VG1tN2F0T2NKd0xubHVx?=
 =?utf-8?B?VTJBa1dtaHNKTldKVjdDVEJwQUJ6SVZJdHNKVG83STJBblNFYU1NWDFkbVZj?=
 =?utf-8?B?Y1c4SnZ6U2N3bit3SG9aQjNvdmVYYmRuQTRkR3dieXplRXpnam9hd0kxanZM?=
 =?utf-8?B?TG1wSXN1MjFvNlRPa1VzQ25EUkNIaHRpN2Y5MXlYcy80cHJYYnZBL0FOTjU3?=
 =?utf-8?B?Sk9IcFhHMlN6WEtHMlZjVXlPc09tRlpSMkVqL3FFVC9Jd3RvQ0xmR1d2ak9G?=
 =?utf-8?B?TUl3dTlSdDBpTVRQdVkramVrTlFGY0UwMkRSTFdlS0JLK3VNelhRVlBEUmpX?=
 =?utf-8?B?UTBhTmx4QUd1QW5oMXpKQXlBajlsSTZGdSt5N25WRkIvZEZyZVlNR0pPbHFh?=
 =?utf-8?B?cUF3eGw3ZHJBd1d1VFhOT0hlZDV1SjRtQy9xUmRQcVdZYk11UEZGSjNYUTd3?=
 =?utf-8?B?ay9YUUJvZmtjTHFIb25jeGkvcDBGUnM4R2FYY2lsc3JKeFR5ZXdCeEtrbk9w?=
 =?utf-8?B?bzNwNzQ5MmYzT2x0VzdwaDBock0zU3JJUEQzK2tPTXI2SmpwYW9WY3N1bnVR?=
 =?utf-8?B?aFhua0RFckw4RmFxcVJJZGJKSHU2d1VqNGZURUlaSitaQkYwaytYZWdGSGg3?=
 =?utf-8?B?S01tcWNCbWlhZkczdWtNRWtQMTdicHFtc2pmb1NOa2YwQlFUQ01MVFhqY2xG?=
 =?utf-8?B?V3ZsVFcvUFQxbTRuOVNhVkhNS3h3aVgyREVWVEwzdEJ4bmZqNThTTTNzS3Q2?=
 =?utf-8?B?bEtjRlZydFFsSTUrNzVKNjl0MDZuYlNsaVhncUFoY1hsYVI2TXRCbGQrTG53?=
 =?utf-8?B?WUYxM0Y5NHpVL2h0NWNDMzdiMWp5eDZiTVhId0NmVW5zbW5RNWNTM1MxUUxv?=
 =?utf-8?B?RFoyNE5BREQ0bFFQalZGai9WMUNtb0N3SitNWnB1TzhBSUQzVlN4N3dHbkky?=
 =?utf-8?B?VE1FR3Q0ZGR6VG1nUmJHSExsdWoxS0pzdTZMZHp1eUFTZ3hVeUNaVDZ3L2k3?=
 =?utf-8?B?ekEzWWRKUjRLMm9raHQxbUdIQnk5U1RpUmVZSmlGOWhpaUc2dzNpMHJabXVz?=
 =?utf-8?B?aCtPcXIvZjZFSkFXQ3RpYkdmZG1Rejh3ZWhKVVZYRnZnNE9iWVE1QTBBTnZt?=
 =?utf-8?B?anZncHVLckRVckZEK3ZrNzU3cWZmM3UrdjNtTlBsc0hhSm81MHZwdlZDazJN?=
 =?utf-8?Q?iOuc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da548586-c31e-4398-3301-08da86da9870
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 20:44:24.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TB8rp5gxHxMroS/mWMsiB5cGfGQUataUE5YhDYQDDc9rTgi68WBHbuPcNOWzdCEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/25/2022 10:56 AM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/25/2022 8:11 AM, Moger, Babu wrote:
>> On 8/24/22 16:15, Reinette Chatre wrote:
>>> On 8/22/2022 6:43 AM, Babu Moger wrote:
>>>> Newer AMD processors support the new feature Bandwidth Monitoring Event
>>>> Configuration (BMEC). The events mbm_total_bytes and mbm_local_bytes
>>>> are configurable when this feature is present.
>>>>
>>>> Set mon_configurable if the feature is available.
>>>>
> ...
>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index fc5286067201..855483b297a8 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -995,6 +995,16 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
>>>>   	return 0;
>>>>   }
>>>>   
>>>> +static int rdt_mon_configurable_show(struct kernfs_open_file *of,
>>>> +				     struct seq_file *seq, void *v)
>>>> +{
>>>> +	struct rdt_resource *r = of->kn->parent->priv;
>>>> +
>>>> +	seq_printf(seq, "%d\n", r->mon_configurable);
>>> Why is this file needed? It seems that the next patches also introduce
>>> files in support of this new feature that will make the actual configuration
>>> data accessible - those files are only created if this feature is supported.
>>> Would those files not be sufficient for user space to learn about the feature
>>> support?
>> This is part of /sys/fs/resctrl/info/L3_MON# directory which basically has
>> the information about all the monitoring features. As this is one of the
>> mon features, I have added it there. Also, this can be used from the
>> utility(like pqos or rdtset) to check if the configuring the monitor is
>> supported without looking at individual files. It makes things easier.
> I understand the motivation. My concern is that this is a resource wide
> file that will display a binary value that, if true, currently means two
> events are configurable. We need to consider how things can change in the
> future. We should consider that this is only the beginning of monitoring
> configuration and need this interface to be ready for future changes. For
> example, what if all of the monitoring events are configurable? Let's say,
> for example, in future AMD hardware the "llc_occupancy" event also becomes
> configurable, how should info/L3_MON/configurable be interpreted? On some
> machines it would thus mean that mbm_total_bytes and mbm_local_bytes are
> configurable and on some machines it would mean that mbm_total_bytes,
> mbm_local_bytes, and llc_occupancy are configurable. This does not make
> it easy for utilities.
>
> So, in this series the info directory on a system that supports BMEC
> would look like:
>
> info/L3_MON/mon_features:llc_occupancy
> info/L3_MON/mon_features:mbm_total_bytes
> info/L3_MON/mon_features:mbm_local_bytes
> info/L3_MON/configurable:1
>
> Would information like below not be more specific?
> info/L3_MON/mon_features:llc_occupancy
> info/L3_MON/mon_features:mbm_total_bytes
> info/L3_MON/mon_features:mbm_local_bytes
> info/L3_MON/mon_features:mbm_total_config
> info/L3_MON/mon_features:mbm_local_config

Hi Reinette,

  Yes. That is more specific.

So, basically your idea is to print the information from mon_evt 
structure if mon_configarable is set in the resource structure.

Some thing like ..

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 83c8780726ff..46c6bf3f08e3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1194,8 +1194,11 @@ static int rdt_mon_features_show(struct 
kernfs_open_file *of,
         struct rdt_resource *r = of->kn->parent->priv;
         struct mon_evt *mevt;

-       list_for_each_entry(mevt, &r->evt_list, list)
+       list_for_each_entry(mevt, &r->evt_list, list) {
                 seq_printf(seq, "%s\n", mevt->name);
+               if (r->mon_configurable)
+                       seq_printf(seq, "%s\n", mevt->config);
+       }

         return 0;
  }

Is that the idea?

Thanks
Babu

