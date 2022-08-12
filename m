Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51906591280
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiHLOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:51:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51139F1B2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSYgzEUk4uy5VHnUWoWRbyjIdqUvkO1y5RSRcaqmjNu+YZaEo0/IHgi372DzQLaJ+HfY06z3vi5/gHxYrJ/gL0dbil8W3zE5KIx/MsTDFFjLJi5f48nfCU99GZPLYkePFMr6iQJTcTOi+PbcqgYHz8NodhftrWbBifEkfYq9PiwRUK+WHzq4wtyiQuOPyxl/4SNI7bQdsM9wlkt7Ndjm3M/GVDvi1KAcqq27PLjFFJcuCWfVdSU6NdtDieIZyshqrnzF3mB8WwpGNeJKuMPYlbD6yxiqvrNp1Mvb4VgHUPBm6WbKPoKSTHw5R3G5lvpW4kbMdvlUOFFX3N833VeZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH4R4fnpUMUR0tNj3uL4WTRL6FGD/vmAKkUQj+2sr0A=;
 b=LvuhceZ+IC2qXIbfzz8WLFCdw+IhzKgK4Sh5IocExoPWjhgsHUuGy7jmtQd66K2Xu2RMjOLeWpWGAWbbxflTDnDy1dtoFhDPNs8QpL7qT1rebZDabPjqcOqk/5G6aLic9cPhqn+CHexhWwWQZyygf80naRdaDhYrGIUIqzgCO2iS7W03CdGzaZRRAl7jzNj5bwILRMqdHviogpOpAd2Xb0/f0ha3BUgJV8YV0ALI+0fAhQ+izEX+QWU0A5AmDsDWvQQoRo6NJVdJKVe/0IqURM7SUOYIA/wgz8Vnptn4DJPrQ0jeFI8pQo62+kZKDbxHucA67J0+m0+ltqf3eqgx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH4R4fnpUMUR0tNj3uL4WTRL6FGD/vmAKkUQj+2sr0A=;
 b=C8Amb6Im0hKjzslDngAtmMW+qKGd17UM138UymbBM3zBfaP6BaFqBb2EjvH0o78zc0DiaCE51xll5trxoyl09xhQQOMJnYg7Abe9TQMRTuYQWrFNeFYlHQws3bAWHdsw9x87H/OH4j3YAkDpQhSV9WmYHwbFsvoDaWgzvsQicgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 14:51:43 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%6]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 14:51:43 +0000
Message-ID: <fc48ce75-7a4c-4804-92ce-71f63c2db5ea@amd.com>
Date:   Fri, 12 Aug 2022 09:51:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <YvZPoEm6PSeoflAz@zn.tnic> <6d9d433f-779d-7531-02b5-382796acceef@amd.com>
 <YvZkpYRfrgPLLoJV@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YvZkpYRfrgPLLoJV@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:806:d2::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86df1af8-77d4-417b-ab69-08da7c722c10
X-MS-TrafficTypeDiagnostic: SA0PR12MB4480:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Rmlie1uLk5JHPRkSd+GibEjIJ5w0O1ntMsRMVyrs3ZYYasVKceNZ43e6exqXixfnCzHmprMAUSRvoLzAGVG1IFm9H6fg/UMmRUvpGdOI/Ug2LsbLbWn/LUAyQ8hbNb3ddPVExsPXQSfoHLEaHKa62Qi+GZ/eAFmeNxVYk8oWE8DVq1EC05wmNYdZmUM0imSCi3tjT4l6zOmvfAUgGikcHGB4eBarSHA92ZCqBWTiwm3po0jTYKa5+/P0JRKtzqjj35J409qBUUO29pjfKF+SNuB41akArkfFHydnT2HsI+hD4z83QCumEMsBvI1lngMpZOsLjkijl/L/YgZctTGdqXCDv7bj0J/tEXnTS1zQ3HWoOjjgoT/iHzL5BPbmInQFqdRq03ZnwciEm5/w711CYCYYMT4SzhNBM4nAjc/LV0OsRnrsxsL39uiusGUXT6uqMU6Xbptjw8MqlUh//Ht9ocMbV1uiQoZuwHXFI/4GxmSaekQzBj2+0SiAAlTdegfLi+Mfp0G2tSVkkrB3SLHjq4y3DcUXxChVleg/2xyTJ0r7Ghn2zhSArx9+IMPDa31Kh/KETKaQ25HAX12Q/gzleybJ/jfnAizhg+dSE9gMlyw/qI//yEOShxB99+UjJslo6rT6VD7YeCfaT1GAs3e/Rs6CIFZpxwTw/cWi+LMdHHzbSZmOINjxpqd30SafrzRe27vH3wpsOJACPFtjTAyn7qz4Puxc6Gj4QBbDrqNtCbK3lb3c3rxgMw01PW3H0xXkEf9sJU1rYqy4Hm92bKIvtQiioq7qQ3IulNqDF5IYb0BW2IbiITjiP5jxfntYL/P1p0oi3ErzMYGvAJ2Kn3aBF5hJ0m9evjNNtkOV7aKaZrTkyg+/URRn/+/wJ92LjeIZaeoEQNyDGXGAWd92wS/PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(31686004)(38100700002)(26005)(53546011)(6506007)(6512007)(186003)(2616005)(83380400001)(316002)(66476007)(66946007)(66556008)(4326008)(8676002)(41300700001)(54906003)(6916009)(478600001)(6486002)(966005)(86362001)(31696002)(7416002)(36756003)(8936002)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEkrOGNiRjNIaU9US3hCRWdrOEtjWDdLTzZGZmtQU3AreG1IbkVSOU1uYWls?=
 =?utf-8?B?UEY2RkFTampUT3Uvc090U01sWGtoUkw5VUxvL05odytKemtueFhnYm5SclNv?=
 =?utf-8?B?UjhlSWE2cTdFa1ljVWdRMjBQeG9HZER1Y2VzZDcxUndQSTM0K0RzcHBXMisv?=
 =?utf-8?B?azRpMnluRCtBTzdpZkpLYVRUQlVJemxnZVYyYS9BcDZjRjdNWSsweXk4Z1Ni?=
 =?utf-8?B?NmN1Q0lOc0FBa3NvY2pHZ3pDZjhiNjJSWkFWQWFGY3l2bGZhaDFoaEdrSEhx?=
 =?utf-8?B?Tk1sM2dicjVwdnNZVXpXU0NQZFpoQk9VR05iTTQrb2RvTUdMb0NDZHhXYUpK?=
 =?utf-8?B?SHhSNElBUFNhdjhnVEV4QzJXSkpQK3pqSFJNdWtOWldKc24ybGxVVWJHNDQ4?=
 =?utf-8?B?am1IMUhoVHZ6VXdncFBZZDQ1d0p0eVBZejZTMkYwMHpjL041WCtOUks2azN4?=
 =?utf-8?B?RVNnNi9kem83b2lwL1VvZ3ZTZkFoR1Bxbk9uWUlXdk9QWXN0bW9nN3lIYkhw?=
 =?utf-8?B?VTI2bDg4TkxubzFxOFNFakx6VTF2VzUwWFhaMEJ5cHNZa3llODZkbDRiNzRy?=
 =?utf-8?B?WkdXNnN2N2I5TVpXWURXbDFQMWp6U2tmeittcE41Vno0c1N0TU5Wb2JaOENp?=
 =?utf-8?B?ZjZ5aDZUU3lFbUlDM00xay9kYjJUc1hsTXFmRDkyUkRXRFBzNmNtenVMS01w?=
 =?utf-8?B?WkpyQ1JFdWlPSmZMZXNOL3g5RWNYZjFHQ21qdW5Hd1dDcm1iNjltRThxWlFX?=
 =?utf-8?B?M0o1S2FpeHJSZ3pXbUM1MHFnajljQlIzanVJci9DY3NqdjVVNm5vSHMxaXo0?=
 =?utf-8?B?ZjhXbUxrVlEyY1d6SGU5SmkwY0VNWnNxbTA0bk5BSFRUQnZKazAvOFM2VTBS?=
 =?utf-8?B?blI5dHNORXliRTBXeHFGdm9ld3hDd2JJZWN2N1krWnhwZWtvemRoZHYvM2VR?=
 =?utf-8?B?THVxT1ByamJNKzFSSkNRRWNpRjZCTWtnQkVGcis0M2EwV00rVkRhOHpJdldP?=
 =?utf-8?B?WERpUjFhREpDN1dXSXBOMnZWcGY3RzR3YTBFTnhURDFPVmdLeUVXL3Q2WkZk?=
 =?utf-8?B?eldUTzFNOUkvNFVKMmxnOGpMOTJTOGRGSHI5dkt6WWRGdHpNcWw3bHhoT1FJ?=
 =?utf-8?B?ZDJjTEpjUDJROUtRUWh3c0hTdzZETnNvMEpFM2N3eTNSN3FTRzNIQmM2bktt?=
 =?utf-8?B?NmZyUSsxdWE4cGtTVExlTXA5N3VKeHd6RGl0SG5nNTY2cUUzWWJQZDZHVmdP?=
 =?utf-8?B?TXRRemRHT0IybkZLN1hjeFp5WUJVZCtmOThpSkhhMHZyVml4dCt4cFVNYVhT?=
 =?utf-8?B?akRJaUI5YnIvSFpIL0U1c3BXa0lZd3Zrc0FtTFphZXBvMHJuRUgzYjJEWk05?=
 =?utf-8?B?T20xYTVGM1pwOWJ4TUkvVmUzay9TNm41eDFRUGJSMGhEUWd4eDlEa1pZUi85?=
 =?utf-8?B?cFVjWkwwMFJPc2NNbW5CdE1tbTRYUlRNOHlpTzVCTzVWUlQ5SGhXU1hVaUgx?=
 =?utf-8?B?c1BqWEZ6Q3o0UXlPZVRxS28reFRuOXJtMnh6YzNBdG1QYi9EenRwSmVMc3BQ?=
 =?utf-8?B?a2VOWVlMOUxwd2lscUF6WHlXVG52S0RWQTBHckV6UlVZcFA1bjY5YkFHWGpx?=
 =?utf-8?B?OXBRT1Z0WVllaHVBb2VQazhkc1QvemUwekl1NjhmY3puUEpZcFUxVHV4YStp?=
 =?utf-8?B?RGlVbmExdGxPdUNkVjltM2J2clV3WXRBVnZ5WGFoRjFnVHZjRXNNVW5uVHYy?=
 =?utf-8?B?ZWNHTmhYN3UvM2VPemFoTitkcjUrUEZVbDJQM0VQRkNuSlBZa2diaGlZMnFO?=
 =?utf-8?B?V1lESXdBMWJiTFRxMldvVnZGZWRLVDI0VXVxdk1wVFl6SkZZVGcxS0FsbU9X?=
 =?utf-8?B?NGs5MWhvTVBNdDBtek1ndDdjSUxCTHFDOG8ybVJLTnczU21hQVk2ZDh0UjNz?=
 =?utf-8?B?aDNSVXRqMEgvRkVQLytIb2xwUjlKTVZncWZJaVhyQm5ub0tjQVpDV2MzanpK?=
 =?utf-8?B?Mzd2Wnd5S1drUVdlQ05wcHhaeU9tMXZ4RzlqaVltOVlZdWRlQVVTWVcvaXF2?=
 =?utf-8?B?SEYvdWZ4UDIydS9qMHNuUDc2dThuY3M4bTRITUVKUnRNSWoraHRwTUhhVUs3?=
 =?utf-8?Q?B3OM5NSvnwnrmHJbKFU/6yak6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86df1af8-77d4-417b-ab69-08da7c722c10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 14:51:43.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72Qjhw5NUdX0jLuxsaffuX4/0ejqs9t2Wbyqn3oqOlOlOD8grFnlfLxrGJn9/aw4JqPku1aTDYEJrw5hcGltyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 09:33, Borislav Petkov wrote:
> On Fri, Aug 12, 2022 at 09:11:25AM -0500, Tom Lendacky wrote:
>> There was a whole discussion on this
> 
> Pointer to it?

It starts here: 
https://lore.kernel.org/lkml/658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com/

> 
>> and I would prefer to keep the ability to parallelize PSC without
>> locking.
> 
> So smaller, on-stack PSC but lockless is still better than a bigger one
> but with synchronized accesses to it?
> 
>> Well when we don't know which GHCB is in use, using that reserved area in
>> the GHCB doesn't help.
> 
> What do you mean?
> 
> The one which you read with
> 
> 	data = this_cpu_read(runtime_data);

Memory acceptance is called before the per-CPU GHCBs have been allocated
and so you would be actually be using early boot GHCB. And that is decided
based on the #VC handler that is invoked - but in this case we're not
coming through the #VC handler to accept memory.

> 
> in snp_register_per_cpu_ghcb() is the one you register.
> 
>> Also, I don't want to update the GHCB specification for a single bit
>> that is only required because of the way Linux went about establishing
>> the GHCB usage.
> 
> Linux?
> 
> You mean, you did it this way: 885689e47dfa1499b756a07237eb645234d93cf9
> 
> :-)

Well Joerg re-worked all that quite a bit. And with the SNP support, the
added requirement of registering the GHCB changed which GHCB could be
used. So even when the per-CPU GHCB is allocated, it can't be used until
it is registered, which depends on when the #VC handler is changed from
the boot #VC handler to the runtime #VC handler.

> 
> "The runtime handler needs one GHCB per-CPU. Set them up and map them
> unencrypted."
> 
> Why does that handler need one GHCB per CPU?

Each vCPU can be handling a #VC and you don't want to be serializing on a
single GHCB.

Thanks,
Tom

> 
> As to the field, I was thinking along the lines of
> 
> 	struct ghcb.vendor_flags
> 
> field which each virt vendor can use however they like.
> 
> It might be overkill but a random bool ain't pretty either. Especially
> if those things start getting added for all kinds of other things.
> 
> If anything, you could make this a single u64 sev_flags which can at
> least collect all that gunk in one variable ... at least...
> 
> Thx.
> 
