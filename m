Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D858DAE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbiHIPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244779AbiHIPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:15:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6182C2DFB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nty756Dtj0uzrYGQAM8gRwxsyCSZdE4izDro+X8kO0z8bK/Rz9GSZyW/thz09qMl5CS0E28lAyIYzsgubicr+v70Gmd+kRiOH8ZN0nY5GTCV7Zg5LWSpvQ4oO7ZekHANfwooF9utM0+oWDixMKvGkzgg8KpIyLtLiTEXbDfCFhOc+gYpixs997pJI8i6dDR1dahUSy2aDYfP9HDLbuF849ckviAzxzTmzX51h+yEMR6IhVndsaRgUR39TuuNryjVnCuD28Bunuthqq94T4fMSGeO3j7W8hylHdA4lu1DkqcaAMuVlIj+zOyrczNIi/RfFPsutMTG2hra+vSkCqczUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXMYtzM1H31gYJj1jUfvS6pNEbaxhUUI+M5PX8MAlzM=;
 b=R5ljmB1ZRPu4uacZ55hjEX9kcSQO2fpXUkIKYIEdzBTeebhn7s7mnAWzoR3Jfsno0xHINoi2NVu0hQ6NsgVkJFMNAuxTE+TPNyUR8pAZfcehcfcsyskIwgSSLMBIUwasWruIJZy6+iOeoHG2lI8xKACTRfdP99QYloQ8fzzJ5LaKN807rq7iLY8nUfSyVvhL1SUeSjgoInSWoqHkTGFLYW84vbJyPar7JHPx6t8yeGxd1KVAQbXIk4d59D6YAfY5xbxsxJOd3yY+ZaVSxwQuzom2gyMrij5OtFDLUBu5j9HTHV2AZT3KYe1ZzC9Mioxp8UepsIUPh534vVP1q85r/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXMYtzM1H31gYJj1jUfvS6pNEbaxhUUI+M5PX8MAlzM=;
 b=ytz8iBp4vQ+3us6WyIZkm3oo1BczSyi7JOi5tqCqWpfC9799Fn0L3uNU9sPzA81RE8IWlRHjFS7pCH07bAxn712bMv5kZ5hLN9CuY/UBo6AaDYcieAwo9MkG4p8JbgLx5GgTok0Ws/oS8NXOB5eqM3ZHtsjlFgsZA/4uO3aBQB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.19; Tue, 9 Aug 2022 15:15:48 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::b44e:8a66:63eb:e8ee]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::b44e:8a66:63eb:e8ee%8]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 15:15:48 +0000
Message-ID: <b6e10f4a-6834-fccb-0cba-0990dda37a76@amd.com>
Date:   Tue, 9 Aug 2022 11:15:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] drm/dp_mst: add passthrough_aux to struct
 drm_dp_mst_port
Content-Language: en-US
To:     Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        hersenxs.wu@amd.com, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Claudio Suarez <cssk@net-c.es>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, Ian Chen <ian.chen@amd.com>,
        Colin Ian King <colin.king@intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        David Zhang <dingchen.zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
 <8db8a726d1aac25b3590497db9cbdcc3fe161227.camel@redhat.com>
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <8db8a726d1aac25b3590497db9cbdcc3fe161227.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:208:32d::12) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71017d50-40c4-4ff1-2bf8-08da7a1a0a14
X-MS-TrafficTypeDiagnostic: DS7PR12MB6024:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzm7yjvWfLjke6Hr06S5V5UdaBB8Ckx7NKPQ67s4vqxuo0+v8ZjbpooOq/H9sTOx2R8gxoLXnP60J+ywDuhbqpfs/3hPTkFVmyeymd/gAL/wnFfHrgFp2uz+4FJbmt6/zRLzCEn/irEMyq8WVFBJcYOxRimsjY1/3mEUZkMOcHjFYsZCSTqaSNOVhdAz3RzDM9ttYaH+cdAok2xupkTDgPgNJay0KpXUUCk3o6BItlX7aHlhuPpM3fHMOlHQZ8XlF0SrObeeG2Pkr2eFQOsbPYwIn3NvASEEhlyg7YFriCVoeR0o7uc6QsZ7JxnYljP3Nu2KA8hrRMcyKcGgJOwGrL2dGXjgLfIA4ysVqaQ+S0UxLPdVnAuhXJj0Ez9k8XLZWWcMLXtOwYWRbinzv+/5Jsu56O9HovPgAQWsewe0F/92O4E3pv4/aj9RMNucEH0jDlj3m1p9nCXClsXhOajxpnL23ASEOVeKaIEQblKeNVb5rXaUAp2YFvjOWm0gJVARs8KySPdfJprbXdlAyN3Hw4K0vcrod8LczdA6vTVhOJ81tF43nY/SBeyWqNYB3f4/FYvwv2v8nXH1NJUJrX7ftC59MV7ErT6s+J6UHYBF89APDaIP6pUQ6wOcHt6fv+wcOSllzquuM56QmYAS1dxRlkG46iM8dtk7dCrLeOMjVmgmoDATStesiqx2/Nd1JUYuJ1NU///z2RA7Jy2M+KE5q52MCDkZKbkEjTy6uPdejpZS5dxrMmszuxHN96URpsbVvxtcyAvWcQNhjn78akOU46hX+zOUO5anPk0fMWT+sSnWWDB0u4xuulXYzoDk/K/hk8AccTp8unj8znuFBFJUcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(41300700001)(36756003)(31686004)(2616005)(6506007)(6666004)(8676002)(186003)(2906002)(26005)(6512007)(83380400001)(53546011)(44832011)(66476007)(54906003)(38100700002)(6486002)(478600001)(8936002)(316002)(7416002)(5660300002)(66556008)(86362001)(31696002)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVRHZExKRzNsbUxrRGdxbjRNV1Rub0dHc25uTW9GY3k5T0tXWDUzSVZ6MUh0?=
 =?utf-8?B?R25ndlh6S01iZUM1VGNLaW1zdnRSSm1OWk43dnl0Z1R4NWcrTTk2SW85NlA4?=
 =?utf-8?B?dTZFY2VGd05icU50UmxMdUM2U3BkbHNMYmk3ck95dXkycFI3NVBEQWdlSkdj?=
 =?utf-8?B?aHRJWjVsK2o4ZW1DSlpQU01KUEdHaDFERGxNYThSUExjR3RUSTRXVS9OZ0c5?=
 =?utf-8?B?ZlRlMDdJakp0WkZlbjhCbXoyM2QybWp6WDQ4b3NpOUIvWWRJdFBMSnUyQjQz?=
 =?utf-8?B?Zkk0YmhPRVp1cit4cVZhWG1vK2xoTExmVjJIbnk3cURINDNXYU9vQVltbVRB?=
 =?utf-8?B?MUVROUJKQnpoREJGOW9wUlBvK2lOQWVFS3BlRmE2a3AvZm9mdzFoa3Z6Mnoz?=
 =?utf-8?B?d3J4RXlFN1lEbnl2SzBjTll1TG9QdVZKUTlQeStQSWRyNWs0K1A0Qm9lZm9O?=
 =?utf-8?B?cU0zdlRCVjhqNFdPbDM5dys0UXNKYytCN1VGMVVYTmZ0K24rVnZyN3lrYjhZ?=
 =?utf-8?B?TGR5K1BvWXU0OHErY2Z5TFlJQzFYNW1tYmxHVU1HdkUyZ0xYKy96OWdFSXhZ?=
 =?utf-8?B?VDJsZGJIN1dESUovOEZYMUJTTTNuUU9ZRGtYOGtkV2VUSnl0b1Q4QWE2UEJR?=
 =?utf-8?B?NGQxQW85ckFsM1dLOVZ4K1VLYXZjYUZJQzZkRTNDTEdQMW1yQTN1TmN4bCtI?=
 =?utf-8?B?SysvR3BFbTlucWx4dUZ2a2wxb1NwUUt0aWROQ2xCcTNvNG4wS2g5SERPWVlR?=
 =?utf-8?B?Mkh2NE9CZVJwR3lsNjRzem96RFdxNjFqQ3RQS0VodlJ1elJ6YmdwM3AyV0Uw?=
 =?utf-8?B?b2RRTU4zTUl0dnU0bkkrd1dmM2psWmFHWCtsVHBmYUJwd1RBbXhqWkpxUzhX?=
 =?utf-8?B?a3hxWTVvWlRMU3JCSmhOcDFOWmpzSEl6RGptYW5wZWFBTTlnNjhiK0gwZnYz?=
 =?utf-8?B?TTdkZ0kvVGlseW9jbE5ONHovLzcyeWx2cUhhd2hmVURyNEFVWURiRUJzYWRF?=
 =?utf-8?B?eFpObkxOM2RPY0lGWjBzcFZaNlcrdWtDUytVTWFOL1pRVWZIbWRGRlFaSUts?=
 =?utf-8?B?M1dYSmJBZUVIczdMQndmWjcrcGFDTm82UURNaUxqbm1yb0k5V3YzQkhITmQv?=
 =?utf-8?B?OTdEbzNnb0dJZDMxSzhYd2NXaDNXK3RyKzlBUDRVZ1lNMm1YVjZXdU5yOVVn?=
 =?utf-8?B?d1ExSjQzQmVtRDBOR3BqbEVTMlRaMk0xaWNKRUFNd1RjS0lzN3B2bUpQaG1h?=
 =?utf-8?B?ZU5hTno1NW1wWWQxWk1iZGNlRDVsb1NjSy8yWUJZUWRwWkhZN2REK1hNKzVy?=
 =?utf-8?B?KzNOVUpUdlJHdktSNCtFOEFMQzRwVkd5Yk1veW5rY05nK2ZCVU9JTzRLUGh6?=
 =?utf-8?B?TEZYUEplL0tGUm1GbUxQWEd5TXExMG9JOVc1U2RtcGgwS0Faa1NKSEdHakhQ?=
 =?utf-8?B?NDJka05OdlFDWjd6M2VEdDZXQmxwK1dEU2gwZVZsTElVMmxUWGNscTJUOE41?=
 =?utf-8?B?VEdLbE9GdUdMcTdRVE9ON0Y3a3huLzlhTHVoTmFHYjA5R3U1NmM4SG9PUkJx?=
 =?utf-8?B?eXJybU1KWmxJdXBwR1F0eGhzNzRpdU1iYWg2VUliYndiYW44dFZydXNQaFB2?=
 =?utf-8?B?amtWTFExZFhnQlpwUjk4cnQyMXhXWG5DbUQramxCVndOMldpdnhxd3RONmhF?=
 =?utf-8?B?cVpmRGVxTDJ3ZU1VTVpjb3IzcVh5bTROZ0wxbklZN0ZjMEQxUGE5RmplaDV5?=
 =?utf-8?B?cFM3dUc3WmYzb3p0Z3JScE91bmZhOVNtU1h6dDNhSi83UGQvWlZVSHpIbXVu?=
 =?utf-8?B?Smlua0dub0FoWTllSHEvRFowYjNNd1J0Yk5kVjRGM0VmZnJ6Y01qRzh6bXlY?=
 =?utf-8?B?NlBQL0JueGVLeS9pbmJiUHJpL0V2MXVNUnZ4RVNDd04vS1lsc1ZBTlVRdTBC?=
 =?utf-8?B?Z3k1VXVjZ2NMN0tpOXlxcWM2Uml2cVZxM0tNQ1ZzZ1dpYVpOOWFkL25VeHRl?=
 =?utf-8?B?WEVKTm1LZnJpUURzVE9Ha0cyTWoweTEveWI4YjA1SktQUmR4a21nRUNZV1pm?=
 =?utf-8?B?UHNCdlFhak1ZcHdqc3M2WUxhSGl6QjJMYTNKV1V6NXVuR2ZMRXlSdEVZbmV6?=
 =?utf-8?Q?Yclhjt0o2AI2okW3WPEqro4O5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71017d50-40c4-4ff1-2bf8-08da7a1a0a14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:15:48.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0wsoNqAjSi83Y7KEJE6IYPrloBj+DnrI3xXRvQn8y5TIdSd4rTEOBGmE9bBhli7PqU8t7SHLSZqAY/5MRU8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lyude,

On 2022-08-05 17:17, Lyude Paul wrote:
> lgtm!
> 

Any chance you can apply this to drm-misc-next?

> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> On Fri, 2022-08-05 at 17:13 -0400, Hamza Mahfooz wrote:
>> Currently, there is no way to identify if DSC pass-through can be
>> enabled and what aux DSC pass-through requests ought to be sent to. So,
>> add a variable to struct drm_dp_mst_port that keeps track of the
>> aforementioned information.
>>
>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> ---
>> v2: define DP_DSC_PASSTHROUGH_IS_SUPPORTED
>> ---
>>   drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
>>   include/drm/display/drm_dp.h                  | 1 +
>>   include/drm/display/drm_dp_mst_helper.h       | 3 +++
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> index 67b3b9697da7..71915afd9892 100644
>> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> @@ -5921,8 +5921,10 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
>>   		/* Enpoint decompression with DP-to-DP peer device */
>>   		if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
>>   		    (endpoint_fec & DP_FEC_CAPABLE) &&
>> -		    (upstream_dsc & 0x2) /* DSC passthrough */)
>> +		    (upstream_dsc & DP_DSC_PASSTHROUGH_IS_SUPPORTED)) {
>> +			port->passthrough_aux = &immediate_upstream_port->aux;
>>   			return &port->aux;
>> +		}
>>   
>>   		/* Virtual DPCD decompression with DP-to-DP peer device */
>>   		return &immediate_upstream_port->aux;
>> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
>> index 9e3aff7e68bb..4d0abe4c7ea9 100644
>> --- a/include/drm/display/drm_dp.h
>> +++ b/include/drm/display/drm_dp.h
>> @@ -239,6 +239,7 @@
>>   
>>   #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
>>   # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
>> +# define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
>>   
>>   #define DP_DSC_REV                          0x061
>>   # define DP_DSC_MAJOR_MASK                  (0xf << 0)
>> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
>> index 10adec068b7f..4a39c95f8afd 100644
>> --- a/include/drm/display/drm_dp_mst_helper.h
>> +++ b/include/drm/display/drm_dp_mst_helper.h
>> @@ -86,6 +86,8 @@ struct drm_dp_vcpi {
>>    * @next: link to next port on this branch device
>>    * @aux: i2c aux transport to talk to device connected to this port, protected
>>    * by &drm_dp_mst_topology_mgr.base.lock.
>> + * @passthrough_aux: parent aux to which DSC pass-through requests should be
>> + * sent, only set if DSC pass-through is possible.
>>    * @parent: branch device parent of this port
>>    * @vcpi: Virtual Channel Payload info for this port.
>>    * @connector: DRM connector this port is connected to. Protected by
>> @@ -140,6 +142,7 @@ struct drm_dp_mst_port {
>>   	 */
>>   	struct drm_dp_mst_branch *mstb;
>>   	struct drm_dp_aux aux; /* i2c bus for this port? */
>> +	struct drm_dp_aux *passthrough_aux;
>>   	struct drm_dp_mst_branch *parent;
>>   
>>   	struct drm_dp_vcpi vcpi;
> 

-- 
Hamza

