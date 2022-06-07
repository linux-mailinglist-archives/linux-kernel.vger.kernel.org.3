Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69CD5401F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiFGPBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiFGPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:01:05 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9B36B60
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654614059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wCsJmrOz1PLJTFb2O10R8SS9O65xSSCD7VtyWUVzbcM=;
        b=enAD44a2pkaIcAaeChB2b4HettX0oX/PYFd4YmQKt9Zz6rNxuYIWqqLnlT4ufznINBiebz
        ikr8AFnj5Zg80EQ+gDQJcdyWL0m1u9iMEqm515BWeWnuFLIMzNMBpQCnD4X4eQB8hpZpf5
        m3e6ZpkUGcLpj7li1taDcWg2wjrZxo0=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-NR-fkCkMO2m88n6LfTuhRw-1; Tue, 07 Jun 2022 17:00:57 +0200
X-MC-Unique: NR-fkCkMO2m88n6LfTuhRw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZBEe13CbuVT615vW9JmlLf9mEh8Cq8aplYyHwKFcwirzSEZkPAstw196lQO3ooECjadfhEcsBCiO2xC1ul6X58gLbqU+5aQFb2ypbHG/ZlonJPtBuAJgFq3+nYcHwbfbmgjel4VC6v75rVVY4HN+ZkVk+t3fLbh/5zO74Gg0cdp3N7DkuKyauHPNR6pB824N7oiciPeYSfeLY9rBqC5sRfxXX0x0c2W/xlFpJnwJfOYzo5oYKx7YQwL5zSf35pkXBjSnfM3k8iM2OjT6KEX9POgmp8ssNY+cnuTQP5bZ8xOYmALSnXUo8b6UpZVoY6/CTWC6KU4hg3QllLa7AkeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCsJmrOz1PLJTFb2O10R8SS9O65xSSCD7VtyWUVzbcM=;
 b=Ew0zwf3UdCG+GEmd/bIudT9E78zGboO3rOl6ZqPhToBxI+BTBr85EcaJevSV5SYMQYe2WU9swf7qBbb6msPYk0Y9ihBepJ3tnVHbLxHePxhsjXUGwPvYGekQMme/rUS6EVy2TweDfM661SJGtNobCz5QJLA/shnyIQRRBaFg/43fhFXOMC+eOeLVJ/4XJOE+uHjb6gey8Iet6JGrlf6tbcarPna26Cwxk7yUTti7kh5+KPz6JFGmPF9MRGOKo1PrqLayNWXdkTKwYtx01JG2KBBTpNr2TjeeEMQliXMH/hIKaanpzOrYSd2lpf4aFWg/AWMpLJPsm5dfqTZ4/a9J7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCsJmrOz1PLJTFb2O10R8SS9O65xSSCD7VtyWUVzbcM=;
 b=EDGgyxxgkFcU05VH7bow19GpFlpxqMLoQOIYe3W0blAoELwG/xdoQ1bxsC2t+KO3E+JcYLzQZnlakUSufzbElVSnk4QxOIT1aw10KSSK+sdaKD9A7ULVnJ6tAoGG3SX85GzuVtv14eSBGWzdtwLYfVSEiTgj2ZpVsoDUByEqPUJr5OQX/6vZJGUQQ2ANFTMjMJnBojwBJdDv6AC0Q4jtKnG3z/Oeq42u3UWyqPTMSFK9MGw7h0CqzJoyGDybTv7cjpN7OlCWymzdr5lvjhpKuqk8lReCChSG2S3HjbYXF1VhaJ9FuYzTUzFmEiYJb6JTACLOAs0Aez2ae5aVbQ4jgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 15:00:55 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 15:00:55 +0000
Message-ID: <485c0c0b-a3a7-0b7c-5264-7d00c01de032@suse.com>
Date:   Tue, 7 Jun 2022 17:00:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86: drop bogus "cc" clobber from __try_cmpxchg_user_asm()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::12) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9edcdee9-a93e-441b-5047-08da48968590
X-MS-TrafficTypeDiagnostic: AS8PR04MB7878:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB7878F9D7D1B2C76705CD8779B3A59@AS8PR04MB7878.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HD/tYrm0crxHwrlJwCBm4tBJQi+dUbDied+/q+HTfv5zePZ1ddMJdGWWG7EhHxclg40zWtkzw/nkE+0RbZHDXarUKaSm8zI6WG5lhFs0853lsEioBTrLQi1dhgfly5LRurvQWf8stT+PPg4/NL3grXc4tL9nua2lFiUqHf5Df4Vo4IVLF4IpxHmje3ATOZIKWVC81ybuyqFFkCrlobF8l8UdxgMivTydMWkwLCDkNfkyXfuLOIp8GdScjl13aotuEu3sy6bar59sXCSqbNrdxuKUFuEZAUT3GOuzjgVkyfEV3XINECeh+Ozor1ePYXzlRLfN8p3wVY53t1v772hzqPiBCX9AL4IDzSvmGuOyLYG/1FQMMt8nmnGQC0euwT8DE00sJA99Rzo58ozRrEhpdoKN3yx8bhKn5mF5PDMdzy6QGysvIz9IxcSYbDLyTNm8B4XaLUGSfQCARbXQXo1+OSViY0kfPZV9Bm660n5QHubgaiocPBlLl07IDTX14KaTY74Y06W1i9XBbyHB2cZVwZ98nkjve4XKwF42cZdEDTtjAqvrlKpszxuSS+XJ0ubcBiV/o9mXsuFdrA9pjDj66UkHv2SHYnLvxKR7Fxfk7JjtDh010dfCttRD953rQaiWMYjeoWpvfDuKnrjbu69YiJEp2ZOEl0ljgrUuf1dv5bAf8sG9PZXRfc6dWG+tweS1zhNyDBzA64mmCpmf2asi8R1ohizTprRLnsxTXoZSckKQIYwcw9EqBng+G4lj7WbU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(83380400001)(4326008)(66946007)(8676002)(6506007)(4744005)(508600001)(6486002)(86362001)(186003)(2616005)(2906002)(36756003)(110136005)(54906003)(38100700002)(8936002)(31696002)(7416002)(26005)(31686004)(6512007)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVZIQ2U5NTdvQkQ1MGdJeStzZmxpN2ZQQWtIQXRnaGJxQk5QaDl0TER5UTlJ?=
 =?utf-8?B?TU5uaUVEdWpidjhqOThJbU9jdFd3d0VCaDhIY2YwRm5QRmZRcFJOUERqanJI?=
 =?utf-8?B?Ym54TVUxb3pYZ3JuQjByelpWdEN2dFp5VG9NYWJiUEhEL2gxSHdDT3g2RkIr?=
 =?utf-8?B?UjJYYVlITjRMelhoTlZkTmJuNlRGcktMOW93bU9LNXNFQVpkWFpJSmIrOWp5?=
 =?utf-8?B?N3NPN2hNeEpyYis0RHJNMmZqdE42OTZTSHdLR05TaHdodFp3QUpuTG55YXVU?=
 =?utf-8?B?L1JQTVZPSlZnU1R6c1JiTmtuN0JFamdtNFB0Wk5XbUFmM0cyRWRWOCtkZFV3?=
 =?utf-8?B?VmZvWmRlTmljc1NQTlFETzJMYWs3TVhDSmtsdjQ4OXJxN2syRUVCRy96TUNN?=
 =?utf-8?B?WmMxQlBHbEVSSk5kMVlSOWZhUHdFWDV3cEFCRHgxNmRCSkpQdUJZWk93b29Z?=
 =?utf-8?B?WWVCT1pEUVVFSnFLQStBVDBjVFNRWklrT3QzcGg3VThPa2FHMDlWR2JsYlVD?=
 =?utf-8?B?eW9jbEFXV3gxc3FHejIvamJOTjVUUkM3VkJYNnB2T2lmQ0NMRno5YTlKRDk2?=
 =?utf-8?B?dDQ1MnBUc0RMWXRRdDh6aE9WUDlpRjVDTFgzemdoVzlDclZIbFg5OUlrY1ly?=
 =?utf-8?B?ak5QeXloek4wZ1B6cDk2YXFHTi9iTWFvckZaL1hQMFkxcEU2azFWd09hbUZv?=
 =?utf-8?B?b3R5VG5RSitwRm81Y1VQcEtlSkFGNmd4cWVINUxsWHpNSGNlV2pzem1ldlZN?=
 =?utf-8?B?OHhHWktCeWJhOGl0YkxMMTZZYXhBWVNsbnpOS0VNTUsyN2ZTZ2xOK0JpZEN2?=
 =?utf-8?B?Z2RNUXp1NEVIbTZhQ3VnYVY2T1B4LzlJYWVOdkREQzVXZ3M3ZE9aa21UcUVM?=
 =?utf-8?B?eis4V1RQcnJoa0dnREc3RVJwdm1rcFc1K09pL3A1TFI1T0xibU02aWlTL1JD?=
 =?utf-8?B?Q2h3NERHbTg5VSsrQ3hIKzgvREdXYUM2Z1B1cTRkemlubFFHYzBsdWxuOTU4?=
 =?utf-8?B?em1ZT09TeEtzeFFVWGJ2UDN0cXBCTElwcHdHbnJWclBKQ1ZmZVNFRWg3TzZN?=
 =?utf-8?B?WWtSVGo2NTJpM09OM1h0WlczNWpKYTF0eEU1QW1PdlNicGQ2ai9GWXZKY2lP?=
 =?utf-8?B?STkvclliUnBXejdYV3RGOGZvZ0RzUElBc25ybVNkVVlWNTJ4LzVLVWd4UkVY?=
 =?utf-8?B?S2FyV1o4TFZ5eXlyRUJjZDVveHpOOEp0c1JPK202SUFRWWNFRGN0bEM4cGlQ?=
 =?utf-8?B?bHE2Z3VzditoQkRZejVSdzdjRUUxYUJEV1VaT0hUY21Ed1dJb0xoQlJrMXFY?=
 =?utf-8?B?RDZ2SDlxTlBqTlBaUCtITDNHUkROaG1La3RWVmpJUXo3UE9HSXVCTmxvSWhl?=
 =?utf-8?B?Q0JtNm0ySjM3VUhOalJLeUk0M0luNFBZZXdYNTkrOC9HckxoMVZwaDYxZzlh?=
 =?utf-8?B?SXM5eDBITWxtY2pYS1BmeExvdGdVbkpMWUsrelNtK1Z6S1pMZ1pjVk1XeFJ4?=
 =?utf-8?B?Sk1QLzFUekFOVGtOSzFVQi9PbVRxL2Nkd1JyTXVQczYzeUZ4TUZxVDJwenpB?=
 =?utf-8?B?OHhXVFNDbnpRUy92T0NrWGU5Y3FXU1Rjb3Z6V1E5UEliNTluTGN5ayt5T2tN?=
 =?utf-8?B?anhXSHhWVHdQRjFRSEREN3FKWEh6YUpNcDhORU1vdHVDcEE1aVBGaFJPKzJo?=
 =?utf-8?B?em1pYXgwOWlZRXpoSnczQUhmRGMxZ3k5SXNUS2dBS2gwL2pWM1pRR3NRWEtl?=
 =?utf-8?B?MWtYK2FFak8vMFJRdEk0ZzVLMjdLRC95SnBxTnRWN2tvbkQ0eHFjSHJUS0I3?=
 =?utf-8?B?Mk5uYzVQc3FtTmQxK3Y4dHdoMmMzMlJnV0U1andYYmEvZUFnR0tDek56VkdN?=
 =?utf-8?B?U1hHL0toSUhYUm01V05SbWp6dktNMHJidjJOL0ZXUkkzbCtLemtYdzZyZXE4?=
 =?utf-8?B?a3VlTW8wdGRGL1FrQ2luckNaMVI2enN5akNMbXhoaW0vM0ZFRVBrT3dqd2pG?=
 =?utf-8?B?R05IS1J5UmdaN00ySDZTZE4vaWVmUHpNZUVSYzhmSDNiMUZZQzltWmc2Tkhz?=
 =?utf-8?B?YkdaT2dUbTVTajQ1R1lKbitsSGIxUGRaeE92ZVVzTkVmenorSUh3WEpYSGRi?=
 =?utf-8?B?eVptZFpEQ2RoRW5sdFBld1JiM1B5RUtSZCsxTXRNSFM5VG95MHQ1endqYzlU?=
 =?utf-8?B?eVhrSXZ0MytKUXdqUmtGcHg1TWRCbHJWOVl0UXR2ZzRTYTQwU1lmNUl2aG12?=
 =?utf-8?B?TS85b3A0YmdqNXdWeHc0TG5mY2tMK2JnaEVzQXlDdWJNbmUwVWtWT2NFOWRO?=
 =?utf-8?B?ZEhGNnhlZU9Dd2NoRmhFck5wSlBrZHhFUm8rSG84c3R6cUJFR3NJdz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edcdee9-a93e-441b-5047-08da48968590
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 15:00:55.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boE7Njlf7ANfoRkOLu97UCtDwNzODKZxBGGxktq5035RfrSIP2HfB0DBOHeCbC2e5QB0UBVedrXxBPqvbHKZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted (and fixed) a couple of times in the past, "=@cc<cond>" outputs
and clobbering of "cc" don't work well together. The compiler appears to
mean to reject such, but doesn't - in its upstream form - quite manage
to yet for "cc". Furthermore two similar macros don't clobber "cc", and
clobbering "cc" is pointless in asm()-s for x86 anyway - the compiler
always assumes status flags to be clobbered there.

Fixes: 989b5db215a2 ("x86/uaccess: Implement macros for CMPXCHG on user addresses")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
The change I continue to carry locally actually allows specifying that
"cc" is _not_ clobbered; it only happens to improve detection of bad
situations like the one here.

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -439,7 +439,7 @@ do {									\
 		       [ptr] "+m" (*_ptr),				\
 		       [old] "+a" (__old)				\
 		     : [new] ltype (__new)				\
-		     : "memory", "cc");					\
+		     : "memory");					\
 	if (unlikely(__err))						\
 		goto label;						\
 	if (unlikely(!success))						\

