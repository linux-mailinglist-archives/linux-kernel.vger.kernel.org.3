Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C575314B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiEWNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiEWNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:44:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43B54BF9;
        Mon, 23 May 2022 06:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNznDua+OWwUMDIEAuHJeoRISBw7qOm+tmGPG0RhT+2lxh8b5jKlKY4eEAxhs0iAeZ9ZY/hm8ur2qOtjMN/iydqHtYy3JsV6Bp1Mvod7p6Mar++VyQy9m2setbViCAkBgJMf6ipFtE+BrTuHyCgUjueo7iI2ESfKwpCK0UeyE/0DiRB8xDl/SI/K42WxQaQUkwmutqgeEQkn+raq+WmAKUyr3zuBrK6duIuf4l3o5V+YLMqBzhU/k6O2NixpZppng8VrdyiPzQ43YaSgCsdzWJnirTihLtK++fBoBG4kMzDZWmN0s6XsXY6cUCWXTqbrgkgB3PzOEFAP0a9NaZt8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77Lt8Vc49lQircK3bTkMF80w4b0dtPMzzUo7o7gdJ2E=;
 b=MID4OfYjkkIJLhNAzCqHyz+now9bA3uLBiWNwhOXNKl/b0CJAtDbc8f6ktTsqg7OPgKtkDoqioevYksd5SMGuaf0EnM8hilAx5sN3XdHDErimA3o4O3sCOQAhqu7tkkFgRXo41HrpqvhSBNvhsj4aiNm0yiHmBdVMs3/9bRbJuw6hLTcNFyJDdt0kFzbWpqKxfEQKnwbvJuZmJqif7Gh2w7TZEjb/7yqRhY3ZymDDlyvAX/J7Ol5oHQEAo4g1hhELbwLmNhz3pcr+p9P8cXNgm+lcfwNbnCjGellVoKH5jsbNBeFJH/JcQzLsOObjQs/zbtNzDWBcap92toQMc9r6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Lt8Vc49lQircK3bTkMF80w4b0dtPMzzUo7o7gdJ2E=;
 b=x/1Ltxg5DNBllw2V5IxFeMhs5WjAAqfASNvj18hw6LoSsbrg7bWhXswSLofkMIVyGzoTt5Sg9De5AvRuTQuf71AoycNy4nZLEsN0U3wa0gMdsOHTIpfC3qYs7X1I1F60K3TZ0Sc77EnegPHxfKiQE8IMegMzXY91c+D+wmKxaqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 13:44:55 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 13:44:55 +0000
Message-ID: <106dbe1e-3e2f-09f3-7787-61500626a4a9@amd.com>
Date:   Mon, 23 May 2022 19:14:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 2/5] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-3-ravi.bangoria@amd.com> <YotOJL0dJmKUQnlI@krava>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <YotOJL0dJmKUQnlI@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3084eb4a-0918-43ce-3de8-08da3cc26b30
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4163D0D486BC7C902CD6856FE0D49@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crOrTsvzBYW227dYTbVZW7C5juY/0svYOFu5j5OO6eh6Gs1ERgkyq5Tn92KGqr2U3AgeT0+f8IJCYjzLypgU4DNEYu/5BbTS/8BiMbkti2PM/SxCTSPVtZtqws1TZYYKXqdBkVS8WsDjWhkf6/Xe9Rjbfdg/POROCTNkf7i1qYvqm6LMfyEpmbqYQ2eVjcXVYx+8CuvukM0msr12iq24/I6p09ia82lRGPZgPldmPilYjAOrG4OT1nHYsMntmP5z9arfAqOqT0TFQGlWEtgwUGZ6EzlKdtm5UrYhaoEFPGsBqdfuB8x8zV8e24enBSXYm0rC47Ox8TSJqKI6lk5EprAx5Snry1rEQzAwfG52PS2YaFVz89Ug6qM7USlLtRTJ3SRdExSmMFmZw1rdjiTTEG7LwDMlTf2UnDknubgPyvJ4cjZVoR7X2xJpXyQSwWd2QgI4nXfhmCb4ED1jmM0ZWxQbHIqbPstyQk5wfbu2ofzGYlCxACToPCZvD1BN6VcQHBF90ylADiPwv6gzoNew0g8uPeaWkR6lsC1NBEd0nsz3APXWrQ5DpnifdVAbHwrQAlXN8OIHGjIZFwzH0/XkCh25799LtcFrkUKMfwe3l9oWSGJbExCiP75orfOURDgxo8WiTHsCKSbDHyLZI7cTesz8zM9t4zBUUJxXfPkyOCNnBxuULntZ9VNeqVClEeSMm7rzlABh3BQHi/QcO2LkQ0hdsRFFvYjDfRgB0GxBudCJvcRagy3JC6fH6P0v9zUL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(6916009)(8676002)(4326008)(86362001)(2616005)(66946007)(66556008)(66476007)(31696002)(186003)(6486002)(508600001)(26005)(6512007)(6506007)(53546011)(6666004)(8936002)(7416002)(31686004)(44832011)(2906002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDl6SXZMdi9wTnVhWElDUDJWZEFheWxQd3pCQ3l0YS9pMnpnUTI3eVQvVGxp?=
 =?utf-8?B?d1VndDdEazF3THMrT3JXRFNvR1l5b2xXUGQrWitoQlpRS0tieHdvTTRLOUNr?=
 =?utf-8?B?UVRaYWRuemZhREtFUVg3ek5sNUY3dEQxbHc2alpUVmtUUGZUY0lhcldldjdI?=
 =?utf-8?B?cE5VMVhvbFZ0cDd6Q1lQRWxMc3RZaHBrTFBqNkEzLzJLRXZvdXZRcDJWcGZk?=
 =?utf-8?B?cHgwUy9TTE5ENGM4TGlPQVoyaTRwSHovQzJMN1pGZXJZSERNYTM1Q09GRUdK?=
 =?utf-8?B?TTlxa09qd0xab1ZqUXIwMjBjb2hNZ1ZMVzFwZE53WjJFTkhGZHBGMHd0NTFr?=
 =?utf-8?B?cFJMbjF1UEVadU84aHFScGtxVzcyZHoyczVmajBnZmhsSWxUKzRNRUREUWtv?=
 =?utf-8?B?dmxoV0QyV09FZVBYaS9rbkFZTVp3eTUxWFBJUjRMM0c1QW5ERHRKOGt6dGNM?=
 =?utf-8?B?Y2ZjR1l2aHUxYVpiaWNFelJURkZRZldlL0Y2aFQ4QzZ4NitxcExNNWtlTGx3?=
 =?utf-8?B?ZEYzTDFwWEJOUUprL1NjaEZwVGFmeVBIZ3VybXhKSzNGOExzTDA3VFNhalVT?=
 =?utf-8?B?c2ZjVjVZcWtLeWJ3WEcrV0FFenhiaENIYzVzbno1em4xVmdzWjJWWk54cy9E?=
 =?utf-8?B?emxuS0wzZWRLOXpWOTh4OXR0YU8xL3RVY25kVFJSWmoxRDFPNzg4ZnM0c0Uw?=
 =?utf-8?B?eHBldDliYk5BSG55VmkyeGJVYjJNNk1ldmx6TVhSaWljeVBjOVFPTk9ocGdR?=
 =?utf-8?B?a3ZVZ3hIbHBRQmIrdjN5aisvSzFwZGRqTzZIbGt4a0hpOFF4dkJjSUZxUjM2?=
 =?utf-8?B?WVZzVlVhOGZ6eWI4ZC9WOUl4bmVuUlVBd1VUYUJKNFJncUVISUxVTlNGVnpH?=
 =?utf-8?B?NFZSeGRKdytoMS9VREhtdk5vdmFCRmNtVWxKVzJIOTFYODFVcnhVcnZWbnU3?=
 =?utf-8?B?UUlPOVdDblRzQmZrVGs2QmJlQ2J3TStYRXdtOSs2MzE3NGNpTmpkeENjdTFF?=
 =?utf-8?B?R0lqd1YxS0xsTTFhUzhtdncyYXJDb1hvem9XSy9LNW45SitrYWlzV2cxR3ZV?=
 =?utf-8?B?S28xdjV5dHdTbC83eUt1Vkl2NkpSc0dZZEtKVld1S2VSYkZ0d2FpOTVmSjc4?=
 =?utf-8?B?NWlwYWxJdmt2QXk5QWhKeUFTaE1OQlhWcTBwclhiYnJzcGxBRk1DcTRpY3NK?=
 =?utf-8?B?REdZbGFkdXBsM1NxclRJaUZLS2d3OU1XVEpKNFVGelpMWTFoVGRMS1RnMFIy?=
 =?utf-8?B?eDZHaWplaGZFclAzc0svdmhOV2VqcDg1N0FsZ3FiQzZxU1dqenNNL2NwMUZB?=
 =?utf-8?B?Q3lBdFBMa3J2SC91RlBwOVhwZXZTQ1RBWkJVUGVaeEV1ZFBpcytmb1BIN1Zy?=
 =?utf-8?B?b2ZoRG9BU1FaUFViNkZkNEpBTDU0Y1d1Vlh6VklrL3JILzN5ZUQydWNVd0xl?=
 =?utf-8?B?a0ZGUDR1NmE3U0ZrRkpScE5YZGxwTVJUSVhYMngvSXBkaXJ4Ni9rWGdDeVhP?=
 =?utf-8?B?VDhCZXg3OFRWT2ZNa1cwbGpsbWl6UDRNbVoycjZGTWdDQjB3Z0pzTUY1ODgw?=
 =?utf-8?B?aTcyQVc0U3BPaFFITXpPNjBVVjk0ZG0yMlFyR0V4SmNpeTJjMTFLbWJaR1Y3?=
 =?utf-8?B?U1JNZTMydTl4VUZ1RktkeFhJeWllcmFycTlYSFJFSUlsNFhTK3JZV3FkMngx?=
 =?utf-8?B?c2pYNU01NldqWTNoK1F5T2JKazQreGRBQnZ2Q0pQZVkrai9PczZaM2Y2SW85?=
 =?utf-8?B?eStoYVVCOHFRMFU5N1hEbERSby9QN3FVN0Fsb2N3d1NRMDJjYVc4U0VYcFlY?=
 =?utf-8?B?SzZ6azliMnBRSlc1L2d5SHAyUG9KV1pzUGlKRGtreTZtZ2p0Q3pTUElQbXZt?=
 =?utf-8?B?c1ZzVUVIdVg2ZTNqaXVqOUtSUXVEMTMwTWdsN0g0V1owaS96SFlKVVNZdnJG?=
 =?utf-8?B?OXltUlpzWG8vT1pNdVI3S2VhOUMweVAwL0tWQks1cUVGeEVnZTVnTmhGNEdO?=
 =?utf-8?B?UTdQdlROWkp1WDc2ZGIwSU5CY0JhZ002cjBYaU4wVWpoVWZZam8zNnRaaDBU?=
 =?utf-8?B?TGVCWjN1Z2R0ODBYZ0tJb3pzZm03Mm1SMDBZYktsRUFWdjZTTEtSU3FKVUtw?=
 =?utf-8?B?U011U1lkandIUWMzNkxFWjJvSk9pcjZpcGtHeEFlNTc0dGVWbGFqVW5Ydi9i?=
 =?utf-8?B?L1d3QTZLdExPY0VLUWFPVm9DQy9xUC9zbmR4VU41cTBWRlVjM3JERUszT2JG?=
 =?utf-8?B?Tk1zUVFOYkREenRKT2xXQkc2MTJzMVhPM3gybmxoYU9iTThUeS9Eek04WlZw?=
 =?utf-8?B?bXZ3TE1KVnUwTS9zUng0M3BWajExNzVQa1FBVEwybmRybUMyd04vZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3084eb4a-0918-43ce-3de8-08da3cc26b30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:44:54.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npk1PO95JggU/SM3TUwc2773UW6y0zbU8tlMGl1IKcjLK7GPvDSmmmNeEaBeVWbS7yu37v3eOKzsvFzoqDPJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-May-22 2:34 PM, Jiri Olsa wrote:
> On Mon, May 23, 2022 at 09:09:42AM +0530, Ravi Bangoria wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index a27132e5a5ef..b4505dbb9f4a 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1580,6 +1580,67 @@ static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * File format:
>> + *
>> + * struct {
>> + *	u32 nr_pmus;
>> + *	struct {
>> + *		char pmu_name[];
>> + *		u32 nr_caps;
>> + *		struct {
>> + *			char name[];
>> + *			char value[];
>> + *		} [nr_caps];
>> + *	} [nr_pmus];
>> + * };
>> + */
>> +static int write_pmu_caps(struct feat_fd *ff, struct evlist *evlist __maybe_unused)
>> +{
>> +	struct perf_pmu_caps *caps = NULL;
>> +	struct perf_pmu *pmu = NULL;
>> +	u32 nr_pmus = 0;
>> +	int ret;
>> +
>> +	while ((pmu = perf_pmu__scan(pmu))) {
>> +		if (!pmu->name || !strncmp(pmu->name, "cpu", 3) ||
> 
> should we check for the hybrid names as well?
> there's a helper perf_pmu__is_hybrid,
> aybe you can use that

Yup. Will include those.

Thanks,
Ravi
