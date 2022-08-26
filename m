Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD995A2EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbiHZShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbiHZSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:35:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6AE869B;
        Fri, 26 Aug 2022 11:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeAU2qgK2rdN9Ev1nDMM1+6Qom8txw8xm1vHnRLqd6Uf6z0h11n01/8DlqthmE4LnkiF2r8HTSin1YUXmPGc2M8ofPm+nKoCJVqcVpjhNia9cCPZXTev8FH29kSGY6JNoBB+ZWeaNmBv4I8JNLXj9CJZGq+7P1jtaWCq6p2NBXm7Z1i5Emv0IY0pzxZXa7/5SxRJpQdkQzUoI8zIYTCwt6Nq/nnuIeUWKnXJNay8hjRfqCzfHwBNXiFv92fE80Xf3cmlg5YX7l/G7TD4E7l8lZMXTYjUCFkoSeWtKA9hPuSNbismGlXKba2VG2kxEV9tQTTTkCnm6+a1fPjK57QEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meNlZwpOja0jnC4YMRJQZwNXTPt2UYWGOJ/Xqoeu4rc=;
 b=Zlb5ZVK02rznv0CowCeEw3dHN7MdhtmynzXFmDschX2Jtsi+GUDgz4CuMcglaL5sYHwY+lEfS6REBbC8InuBrDKrj6BWQ++RRFYQ5v6HQurvFFJT/ihVZWNWOrCvfNJ05M7hd6iJtd0n3VDU2yL2oKT57fMMoyhdJsVdFVQDQOLkzWI7hbypVoUF+ozR3/tKbIV7Rv8S+xZEiO0W9/LEeFwL7uCU75ssEc6U7emCU7JpEW6y35NWzrz99CvXwba1BVSSev1eWj4YaoYELy4yT5d9Q3Gpj0Pn/VsCpDz+0nGayyZW+kLXQrGVABRl9lszEAOPKthXMBiJurm5gppwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meNlZwpOja0jnC4YMRJQZwNXTPt2UYWGOJ/Xqoeu4rc=;
 b=s69jD9SSbPsz3awTcqir4AVOz80WKhwfQMs4g8FFuyROF5ye6v/nJUteNLFMNwvBqDZtRXfSv3S1yX6jUUiY8PKkRG/fLIl5JY/dW9TTzplzGLKoDyKoLi0CfxZFJSZUDowjY496WJRpwDXR88lx1XnLu3B9+gojLMw9c/JsPX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Fri, 26 Aug
 2022 18:34:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:34:23 +0000
Message-ID: <5e5318f7-43ba-0634-038c-3b689e8402f9@amd.com>
Date:   Fri, 26 Aug 2022 13:34:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
 <654433c3-2980-41a0-503f-f888d60310e8@intel.com>
 <d6f5affa-1f7d-7944-70a3-6d2c99863fad@amd.com>
 <a89ed748-7e30-bf94-a8b6-6e9a63991657@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a89ed748-7e30-bf94-a8b6-6e9a63991657@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:610:4e::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 138c39fe-06b8-4439-5e8e-08da87919939
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5DrOeR61U3ljYdXK1NeIGgUvwMwdXlzE5F8geuuvertamuTcdUNyZ/EaRFDM1/1A8+wjI8D5PPPm53iO80BdU5fMY5m0FZZ1CSLQtMEIfe3l1veQcQSci7XvfFdUFFvhPlEnAMbfaOijyWS2+IatMuQKhZgTvBLFkVUs93NI+fRZYq2vdcxcSH9j5ooK0Amx34givuDTmwiij7foOMQeTpHR8srgS0XkH3V3+wiuAFmfGrOMlFB6vdt4FLLCd3FJiHRO9UksGPdwyH8OlLvC++zGFuw6x3h6ictbvHoWSaLBU3Pj0nyudGw9A+SChsHRqnw53u2BKIgS2DAzm1dpkpUij+x+FtkHCmEBk1FFnQPrMz4frS/wVm+/ke+YbC3wsKPsSKReX4gpXwPgQ5u/g1PtCdvLLtgLZlJNjUDEqElNEOCs3Uc7sKjfbYeC8hoUfHkHHMRSvFT9mhtqxRWVUMEfN9JlzsbHIwFO1532qBuGT+3ofocG6uVLYnVl0XmfwVQbcgakVhuUXbqEU85rMQYYgWHRjgbZ4k4XZYFWNFPDc1bmGSgLo6Ljpa3ewxuiQ2tMnzv9Mr2p12HrtMcZcLV6KzzuDp0ilNdTtnlb/TOLNpsCkT0LU/n2cRBPycj+yUAj4k0pnnHv3Th3bCzo/Wf+jccJLME8wseCKxa/hkT6op4r3oeYEek35AlTloGYWfmHuSakgbcoVVevFLZNyH12otRwUteBCL9MuusvwIxUnzjTWtAZDUfWNMnOLzikJuZaaLe+mWfr5zol6Y20zuRV6w2fY6adIVAXSwZugk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(66476007)(86362001)(38100700002)(4326008)(8676002)(66946007)(36756003)(31696002)(66556008)(31686004)(83380400001)(26005)(6506007)(6486002)(41300700001)(316002)(6512007)(186003)(7416002)(478600001)(53546011)(3450700001)(2906002)(2616005)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTc4ai90aHZvTkpNTWd5Y0tiWlZPNGpvV3FBdXFJWjRtcVcxMVRmc1J4Qzgr?=
 =?utf-8?B?N0FITnErdzNCYUdlK3JFTGxPczB2bE1SQnRrR1ZUdTc5WHR6bFNWdE4xQk1m?=
 =?utf-8?B?VzFUSGp4YllMUjdWaXpPRVM3MGxYZFJXaG94Mjd3R3NNNWh5Z2I3aVIrS0N0?=
 =?utf-8?B?Z2E1ZUd5WEw3bDBHWnp1cmxQTHFZUlJ6TE44R09za1JMZytSQWdQTDhCM3kr?=
 =?utf-8?B?OUo1NkRaY0w3emo3WUJaUVRaYWVoMGVGTDRVTDN5ajZCOUVHSHowMGMvVTJp?=
 =?utf-8?B?RTd3bmxneERIdFV1ZUhsNlkxMlZ1RUk1ekxMWHJBWE1yUXNabGhjUkNZaFZ0?=
 =?utf-8?B?S3FhNjJGV2JxMDRxaDFBS3dxRWdoSXlGZzRFcjMrWXByVGNUdHhiZEVOcnAw?=
 =?utf-8?B?UEVNWndVamR6Z2RWcmF1K0liT2pzSllJaUdHS0lNV1Fxd1paTm83UnNubnVa?=
 =?utf-8?B?ZEh6cnMvSzBSblV3RnBRSkR0WGNBNW91L3F6Z1AwNW9Ud0pDY2Rrb0VmdW9w?=
 =?utf-8?B?Q2gyRXM5U0ZpOWU4eUt2SFUyQ1ZmQktYUGVkZElzdVBRWjJvK0U4OW1GM3dr?=
 =?utf-8?B?SlI3a1V6WjhtZEhieGs0bzVXdjdsZDVoNHZodmVSY0FJUGs1U3J5VW5jdERV?=
 =?utf-8?B?SnVtZngra2czNE9lZDRCK2JwRll2L2R4QnMzZ3N5YWhudTZzU1dsYjhFMjUz?=
 =?utf-8?B?MWcrUjdTcnU1NkNTbE5ubkNqL2dneDdBQ1d1V0pOdEZPcytRZmMyeVJNUmEz?=
 =?utf-8?B?RHUvcWFwcFJ6K1dlamZZL0Z6VTlKWnowSTlxRkVDbnU4U3ZYME9WWEp3WHpT?=
 =?utf-8?B?TGFBWnpIQVk1dXdrdFp2TFNUWXhadUpLRjZOTVd4NGZqa0VocDk3UzhBbWtW?=
 =?utf-8?B?bFBjZ0RDcmwxUlJrdHhDSEpUcVNJaFA3RmNBYXBHaWE1cDA5MVZLYUVLZzlp?=
 =?utf-8?B?a2FrQk9iNFJZM0dZTUp1TVhQb1Zmd3lQU3lUTHJMSHRFUXJDcGtzankyL0FT?=
 =?utf-8?B?c3Erc3hpTXZYK3hQakRKN3NTYmN6YURyYVBQNTdsa0NTQ2ZpUzVsMXB2WTJ4?=
 =?utf-8?B?WURXcWNmaFA1bnF3V3NXdWNwYVprcmtxN3VBUUFyMWFoZUkrb29BSGJnVEtE?=
 =?utf-8?B?SkhkVm0yOWdUWENUNzNVUGMzNWk5NUpzNDRGbm9ndFRKQ1JGTUd0SDlDUGlq?=
 =?utf-8?B?V1NUQkk0aE9FamNHVFI4dkRaaFRFS1BseEU4cFdaSFJpQktkN1dpQ3pDSDFI?=
 =?utf-8?B?MGpaTjFuQzZIdXd2MEpRK0dFRWFBZ2QyNC9zZmRLMm10UXM3QzN5VkZvVFE4?=
 =?utf-8?B?a2RFMitQTFhJeUc4bEJ5by82bVVyOWI1bFg1dVUwOXVlY3d6MG41WTJMUWV2?=
 =?utf-8?B?ckJoTnJ3U2xXbTBROXI0eHZEdnB1azFjR2gzekdXVmV1OGdWa2J0U1BEbXBo?=
 =?utf-8?B?VDE4L21YM0ZIRDZMWCsxeDF5VVRyU3pieFlpN3dVdlhYZmpwVnFqd1BFMzM5?=
 =?utf-8?B?blVyQlFnODF0OGtXdjNWOEVxc1d3b2FjbnlqTHdEdldqRWREek5ZaGhsZUVj?=
 =?utf-8?B?T2NGSFI4T2lRdzV6OXlLVnJYZVVMSC9HYVV6Y0xpMTloUkptRk5SWVVIYVZU?=
 =?utf-8?B?V29yR25EdGhNVmhZQVhDNFVIMHVoSlhGcUZPVkYwbE1EM2gzTzhCdnprT3J6?=
 =?utf-8?B?ZjVPTlBnZDlLNkZGMHhsaVQ5NEk2REV0UWw4UFc1dXNFZmgybWp6TjMxSTdQ?=
 =?utf-8?B?eFNqNmZlSlNjN0hpYzRJTmtxUjVzRnYrT0g0UDBoQllPb2JqT3FZb3h1Y2ZR?=
 =?utf-8?B?SXNDTFByWWJzMDc4MTA5c0h5cWxlSHNsanMxbGp5bVR3Z0JJRlpaZTdEU1JI?=
 =?utf-8?B?bHJ1NUVreVdUR2pFUTRSWDc1bXdNOEZJQVFDTlAyV2FnWnhrTEF4aUFYNjJQ?=
 =?utf-8?B?eUVUV2FybEJYbEdWeUtXM0VOOVBjVDlyeVhiYmF3eXkza28vTXR6elFHNnFo?=
 =?utf-8?B?RzRaSjdFRmtmWGJYejVFZGczRm9lV2ZLVXFLZWNZRHY5WnNtWmpiUlBWYU5I?=
 =?utf-8?B?cHhzdG1zV3F3M0Z1NExleVFuTjMzU3kwS3lsRWJWdTFFSTM5d3RlUFp6SUpK?=
 =?utf-8?Q?AgJjOJv5gonepXeDMu3qgkE2N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138c39fe-06b8-4439-5e8e-08da87919939
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:34:23.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UX7ryoF4bNpvWvNz1sWUml9MMo3bYL3KUEUKEwrHPZ1TXfq8mQFoNGC6Px1ytBKU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/26/22 12:34, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/26/2022 9:49 AM, Moger, Babu wrote:
>> On 8/24/22 16:16, Reinette Chatre wrote:
>>> On 8/22/2022 6:44 AM, Babu Moger wrote:
> ...
>
>>>> +#define READS_TO_REMOTE_S_MEM		BIT(5)
>>>> +
>>>> +/* Dirty Victims to All Types of Memory */
>>>> +#define  DIRTY_VICTIS_TO_ALL_MEM	BIT(6)
>>> Is this intended to be "DIRTY_VICTIMS_TO_ALL_MEM" ?
>> Yes. that is what spec says.
> You did notice the typo, right?

oh. yea. Thanks


>
>>>> +	}
>>>> +
>>>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, h);
>>>> +}
>>>> +
>>>> +void mondata_config_read(struct rdt_domain *d, union mon_data_bits *md)
>>>> +{
>>>> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, md, 1);
>>>> +}
>>>> +
>>>> +int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>>>> +{
>>>> +	struct kernfs_open_file *of = m->private;
>>>> +	struct rdt_hw_resource *hw_res;
>>>> +	u32 resid, evtid, domid;
>>>> +	struct rdtgroup *rdtgrp;
>>>> +	struct rdt_resource *r;
>>>> +	union mon_data_bits md;
>>>> +	struct rdt_domain *d;
>>>> +	int ret = 0;
>>>> +
>>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>> +	if (!rdtgrp) {
>>>> +		ret = -ENOENT;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	md.priv = of->kn->priv;
>>>> +	resid = md.u.rid;
>>>> +	domid = md.u.domid;
>>>> +	evtid = md.u.evtid;
>>>> +
>>>> +	hw_res = &rdt_resources_all[resid];
>>>> +	r = &hw_res->r_resctrl;
>>>> +
>>>> +	d = rdt_find_domain(r, domid, NULL);
>>>> +	if (IS_ERR_OR_NULL(d)) {
>>>> +		ret = -ENOENT;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	mondata_config_read(d, &md);
>>>> +
>>>> +	seq_printf(m, "0x%x\n", md.u.mon_config);
>>> Looking at this patch and the next, the sysfs files are introduced to read
>>> from and write to the configuration register. From what I can tell the
>>> data is never used internally (what did I miss?). Why is the value of the
>>> configuration register stored? 
>> You didn't miss anything. We don't need to store it.  But we need it as
>> part of mon_data_bits structure because, it need to be passed to
>> mon_event_config_read and rdtgroup_mondata_config_write.
> These functions are introduced here ... so it is only needed because
> the demand is created here also. This can be changed, no? 

I think we can change that.


>
>> In these functions we need evtid and also config value (mon_config).
>>
> I see no need to pass evtid so deep - it can be checked right in
> rdtgroup_mondata_config_show() and then an appropriate wrapper
> can be called to just return the config value. Even if had to also
> pass evtid through many layers you could create a temporary structure
> to do so and not unnecessarily  increase the size of a long lived
> system structure to satisfy this temporary need.

Yea. I think we can do that. Let me try that.

Thanks

Babu

>
> Reinette

-- 
Thanks
Babu Moger

