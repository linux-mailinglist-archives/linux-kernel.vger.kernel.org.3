Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8C5A0740
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiHYCaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiHYCaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:30:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F26140D1;
        Wed, 24 Aug 2022 19:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdkEQSkVcXI7IXfTtDMUvJGzf+oyuPfHKnV0NMxtwhV/ogQeJ3b3Mb5kMLlqCSorK011Rz/DsCMoIL7l0BUL7Alf9tG+ypmyFtrrErbCECfMSTToh2OcCwZJnyh0ikSGdtrWuz2uPqmw32/xNR4l4h9tBic4UrGPSjn6o24QjzxVlQu/Q+6MnMYOOp1agd3WB1qHo8l6EMO9SMUtRvcXmVsaULluVCcb65xM1uOfyMTec1xGawksoPYm7CbVxeYEnwZyO4eOEwkX+atae/5UlwAJypbgYv21VNpHbpPax6LFHbdsfvWSsr3MXV+Hg4NJotKIIIX6t9J4qoG9XYB/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+eGOJLXLh3pX+jpmbmx9AQD/OgviItOI+ovnuIc5cA=;
 b=Ent9rkeeISUX+gS81UdgAgokPmQMGg/yFwWfK813YoED1zOTLOLKroa0bUxPFTPX908X2ECQyTMY3hRXbnLqT926fcAbhsAL9bfgsS1Ui/TCnsyVFfzZMwgfDcxOlp1ffVhTKtltgLY56Qj4HMXDZyc6Gg4Sjw1lrteSKeSrhBtmk7GqHejW6pbZ/jnsXB0deGxp88zFUbSo7NwO59hq6FwQmqvoe2JXf6SZlXLNU1Xn4v9OVQRtn9U8QN3KW6IiyR66AlV7RO3Ks3bWZZBNLU2JVSVD2+1LNQ9mVdQkpbPzDchbGfE//MGhcRz253FH72AIlAhvKsiwn5z9h/fQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+eGOJLXLh3pX+jpmbmx9AQD/OgviItOI+ovnuIc5cA=;
 b=cyWQ7PCtIeNDNoxs0r2l3vLHHxTlZ5z+4zNlSRrpBaF8ksDgv59WYVXXc4ulCAgoaYtFnfCdcpQOcfNF2cHevMy7/QroyiizVC2UdfysbrVDiNv4SaMkhMbjPPcjkgZnePRP4AVs1YWXz3SgwX4JqYhnMLEIsdUc7djrs4JP0tHFnJ+HWSQRGlhCrsGCN+UW9qFagnccO1kehuPqAAKVuAZIyUa56CjJJ2Ranbw/TLiQ7A9j8QjhFOOcBH18kRRFvkGUIg5D45XEsAu/TXshK9ven4EtTD1XqO0HXcO2L4aDequialrpZvOAdglLM2sQFUZMFUPrUtdgsfob3/6SwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 02:30:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.014; Thu, 25 Aug 2022
 02:30:07 +0000
Message-ID: <3f7baf05-dc74-33c5-2f66-caf34648a4a1@nvidia.com>
Date:   Wed, 24 Aug 2022 19:30:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC 0/2] coding-style.rst: document BUG() and WARN() rules
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220824163100.224449-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6aa5ca8-9a0e-42ef-f616-08da8641b996
X-MS-TrafficTypeDiagnostic: PH8PR12MB6793:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHv34QMPu+tQK7kPQi3itn8pGWPVI+fajAmhIMhhwMwUgCXzphO/6Yz9fW5Em/D+MCtVTFy772ULyMVVC5TPgYNbsDS/w+HXzH2366jFiLb2UfGmLmw8hB1UuhUJ3kzEsB+VKF/4ubDErvCki7n+LUaBqfG0bjB2onabwIQk9UUfWUhyyX3TtnypqRNWnJdGsdU/mq394qMoYs782JuDJTTq3chYYbemNoBHCCa6RHN05iLa1YDRxXI/PJKrEVxqRufc8bB93J65uq2BOEpwZPADWu90uguUocDsqaEJ1Y4cWlTceg38fkuiWvZehyNkHJY1zTeAuj8ymAQUl4DzmI20wjwP/nhcuE0DJJaDb/aD6XBk6qekqobF8GcxCe9HAKlNeOdYE9UKXu2I5xfLv4H4k6BSNU8JKQdxhUw6s7w+pHId6Ym7EJtaLj0tqxdcHHIqFFzm8VaZXfKw0hP59DgrwVpZVA6yBR2H9SOMVmmFItBzkfDIWtkMKi9U4ly3ZK4+Hst2CL/YKOvnJZQjfLdzIG8zUiHOtpjYCbGBOH8zPihmVn9ez5U8JY+ebVnOjZ0lUkj3zLQsfiV4tAnh9rQqMksqLCMRJNmg6LRkzl8GmOEQCcO+twQMwzBf3R5D7yNwGNHDVHqRKXfjBldppYD/9GC/OQObcDsABUuTejMdUxqPYwy0LVKEwfkU5rJNIaQ4vtuFuJueWxp/Dnyo1poMAWJqMK6/SnowWemPbq+fWiTtHFQFIlvcUirXDaBBSzGFtHGhjRoJY0s513vEgDXxu/PXKYYH7s005IADQmt71HEX3SzlrU5BaXlC8oNNkheRgxhNvI0HX1Bw4NeOn0FcXKZnNjDFyEuE92DhOuoPnm0dRqqyPK9WirT8E62Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(316002)(31686004)(38100700002)(54906003)(36756003)(6506007)(66476007)(66946007)(2906002)(6486002)(8676002)(26005)(6512007)(5660300002)(53546011)(6666004)(7416002)(66556008)(4326008)(8936002)(966005)(2616005)(86362001)(41300700001)(83380400001)(186003)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHVmdUFZcU5FUXVtekZXM1NLMWZjK1FkYks4YkI4alpiM3JkbnVsdEt3RmdV?=
 =?utf-8?B?bzc5TmxvOUMyRnJRMytxbWY1UTAxaFZNOG1aMG9sdXNRcmhDYi9vVUxnSVFY?=
 =?utf-8?B?QUVHUHg4dVFpbW4vWlMzSWhNVTMvM3lIcW81dFpQTlhqampCaEl0NDI5RDdT?=
 =?utf-8?B?RVgycTVwT2t0eW9iMk9GQllEREc1RnduZ1NxVk94WTg4VTZXdWlLM2lReVVG?=
 =?utf-8?B?MGZOVmx5eDRkU1NjV2M3eURaTjYyc3BxZWVCRittdk4wdDVOWnFwbWVreFQv?=
 =?utf-8?B?OG1wSCtZa2VXNFJVSGFFMUtGbDZTaHN4cVBsVWV0dklYUkxyNmprUEdYdklK?=
 =?utf-8?B?N1lMR2RNRHBYQ2FuWUc5YmRmRGtHWmhFeFBVb1pZbEFEVW90L1loSWMwNk5k?=
 =?utf-8?B?V3VtcTFkNVZvNjExZ0UzQnl4UDRrcitjTTFqRU0xZU9ydFdpMW5yK3RBTDMr?=
 =?utf-8?B?bS9hb3hLdFk0MjI0Mnd5RGt0aXBVUzM1alBuVlNNR1paNTdCUzZTRGRjeHcy?=
 =?utf-8?B?T0FzYjJOLzN5MkZaQUFoS2NjOXRha254YWw5ck55KzVlc2o2ZnVvVjJHTFhp?=
 =?utf-8?B?emhlV3cwbU1QODYyWXdZYzhxSS9sS3ZMQXZmMGVnSnBlbVV4dWJGMWJ5RWRF?=
 =?utf-8?B?TnhRNFBxS254ZS9DR1ZOTXVoOVZDU25HbGNyQWFzeG8wRXVLdnBuRHZZazhp?=
 =?utf-8?B?c2JIT1pmZ3dsVCtDU1lXVHhzelBTRVpWSWNkalpCTHNEMTZ4ZjJ6REJMOVpr?=
 =?utf-8?B?Q25RSU1ic2Iva0ZzNFdZM29KaGRiREE2WFFvWTBpbFlpWXRZRUsxNnBXbnVu?=
 =?utf-8?B?ZjY3K3duT05FZVRjR3V2eFlQbXVVbFpmM3ZPdEFYQ2tYdytlL29Bc1YxRmFw?=
 =?utf-8?B?UndQMWhTbHdjTmdtalJFRCtzODljSkNhbnRQRUU2TTVzMTNGSmNJTnRhdlRv?=
 =?utf-8?B?dXFlZ0RoZ09HMnZZZ2NMM2NIN3RPYThySldZRUF2Wkt3RVNDZUhrNEhKeFlW?=
 =?utf-8?B?a1N3Y3hJNTJCNm95UTFzYVN0VEZ6YmUrSE1VRkpGRlcydEU3b041cldOZkEr?=
 =?utf-8?B?ajVNNkN4dnk2b1ZrbmVDTk9ITXdPWlRmak0wcjdaNitOL3pqTEpjSlpWTDln?=
 =?utf-8?B?YkxKT1RaUjVyYWRXRTdxZG5BdGJFNFFkMzVxZ3duejdXbU5xcWtRcnJBYkZO?=
 =?utf-8?B?Rm1rNDdTUDBUQ3oxb2tXTHRxVVhhaklJamhHOEp2bXI0Z3pNMVE5T0MzY1Yx?=
 =?utf-8?B?TzlOMmQ4SGdyTzJpRjBBcHZ1YVJTanJLMklQMjhwb2kyYkFjUU5laWwvYkFH?=
 =?utf-8?B?M1J5cHZtcTJHc3VKYmNuYTg1Vm5FbDNPKzdod2kwaHRtUVEveFhJRG5XZjRj?=
 =?utf-8?B?REc4c3FtR2ZwZ3JlcmFUL251QWJGL1NJMzlBUzl2dVZZSlZYelV2T1htN1lP?=
 =?utf-8?B?czZGaFB4d1BQbGppZmpDMk9JcmNvTzhBZXhNSFVDSEVGbCtYZ1A1ZGU2NUdU?=
 =?utf-8?B?VnVseVFybksyZXh1VHcxRWNNSGt0MklQMzR3bjQvSWVoUzg1WlVycXltaXRt?=
 =?utf-8?B?citLNWZkdm52L3lrNnVsTkZXQ2RCRURTRFZnLzRuM2xhWkJjRUg1akRnMjhs?=
 =?utf-8?B?bmVuWVhzVFBFVVBvOGdoY2VkalRTKzlxK2pmd0h2K1BHTUkrSStlMGNST3Jr?=
 =?utf-8?B?b29HL1lYS0ZFY2hCbzl1MXJWbkhVejQvQmJOT3ZzR2RRWmJDUVBkUjAyRkdI?=
 =?utf-8?B?UHdJbzdzbDNzdkE1MEd6R1ArNWN1WjhVVTRWOEVueHpYeE5FWGp2cnFuQ3RB?=
 =?utf-8?B?TytiQW9HclBXSUNleVdINklxV3VNT1B6dy8wV3l3QmpSeEpCL1JBWkdCWWJp?=
 =?utf-8?B?bkhEZWI2V0s4eVNkK3ZYR2o1OGZ6K1I1VWQxb05jOHVzN0lONTAzSW9pM24z?=
 =?utf-8?B?cWhLai8rUkRXSWluR2l4SWExMUJJNmVVcEhlUG5rRXdvWWU1Nk5obUIrSWpX?=
 =?utf-8?B?SHRmalpKZkxDMld5ZjcvRFp5Ulpqc3dFd0tHNXYxUFhreC9sZjBSSlNjcnJq?=
 =?utf-8?B?TlVEc2RFWXNzbTdHMVhXMHgzWXMzNEFKODF6bWNFc1NJenZteVBPZSswOC9o?=
 =?utf-8?Q?66K+Liknppo2YYQXpy8NK5o40?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aa5ca8-9a0e-42ef-f616-08da8641b996
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 02:30:07.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3A7+tVOyyhLPm31fvstgfwd0NwliN2SRpgKGETzWPNZqXcdf0slTPzk7WMtA4VgNTnaiWtzzlnuCf2GkP0DgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 09:30, David Hildenbrand wrote:
...
> So one idea would be to have some kind of "panic_on_warn_with_kdump" mode.
> But then, we'd actually crash+kdump even on the most harmless WARN_ON()
> conditions, because they all look alike. To compensate, we would need
> some kind of "severity" levels of a warning -- at least some kind of
> "this is harmless and we can easily recover, but please tell the
> developers" vs. "this is real bad and unexpected, capture a dump
> immediately instead of trying to recover and eventually failing miserably".
> 
> But then, maybe we really want something like BUG_ON() -- let's call it
> CBUG_ON() for simplicity -- but be able to make it be usable in
> conditionals (to implement recovery code if easily possible) and make the
> runtime behavior configurable.
> 
> if (CBUG_ON(whatever))
> 	try_to_recover()
> 
> Whereby, for example, "panic_on_cbug" and "panic_on_cbug_with_kdump"
> could control the runtime behavior.
> 
> But this is just a braindump and I assume people reading along have other,
> better ideas. Especially, a better name for CBUG.
> 

If this direction is pursued (as opposed to just recommending the
panic_on_warn approach, which is probably viable as well, btw), then I'd
suggest this name:

    PANIC_ON()

It's different than BUG_ON(), because it calls panic() instead of
immediately halting on a undefined instruction exception (yes, that's
x86-centric, I know). So at least in the better behaved cases, there is
a backtrace and a reboot, rather than a mysterious hard lockup.

As Mel points out [1], it's not always that much better. But in my
experience, this is usually a *lot* better.

It's only intended for a few very special cases. Not intended as any
sort of assert (which BUG sometimes was used for).

This forces a panic(), which is what David is looking for.

[1] https://lore.kernel.org/all/20220816094056.x4ldzednboaln3ag@suse.de/


thanks,

-- 
John Hubbard
NVIDIA
