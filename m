Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF74DD6CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiCRJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiCRJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:06:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2114.outbound.protection.outlook.com [40.107.93.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD69181158;
        Fri, 18 Mar 2022 02:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7A3LjIpaJURaGHTRMOoxgJ9FM4Tb1aVN6bbh/3XzdIThIpPkqRdrGtvgI+MhuJmRzWZ+R1OQKLteXbQIsWTv9F3Tr2eCFHtpKOiHS/kRiguOYr3iZvCR6Rll428cN+MmwLqqab3zUOJYMC40QkMGk0NBWsP2Gz9rKtM1WmlBuwk2T17JyBzE7hOAh6VprffUhsGMfjuP9At9NP8Y0GwFa1eFx717BxnXftnQ4aVG0jBbBEUspnv8qNpiSoNmtxKtSKcE+VZTosU+WmB02auqVTqGh85AsziesPOVCZCTRXdl2fbMHNDL/svxBejetRbeHGdJC5zId37kuwp0AdzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfbXt52lRBXKjCRkDqP7H98wvEmCSPT3J3qz2FNSSDI=;
 b=XkTK46CemSNoLMhTuZoqomf/qtirSKJYUf6VBX/icWd/UWE69jf46Z6MTWkx6NrJ+CzX/iA9V8i5alVHMC5Tv2TC/bOZhluittNSfIGvpXgfiBZPGarKGA+B0mdGr0/A9K4JSCgJonF2Q0Yx8qaPDAfWMsvhSCJEw8oai5ZrUmyWZ2VLjiM9L9QDmSYAfiMjvMiOgGxEBAnwbxXFIEZKywgx1P6MfcaFx2XDeX4gXOePOJJIu8lBVDilj/mJqA0wwQRehdff6azb9saogc0P+Bsj/ert49fYbtZWjkWpOUSjfI6o9KK0LQ0A9AK17YfI0IQI6ZmICzZSVULGZjdIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfbXt52lRBXKjCRkDqP7H98wvEmCSPT3J3qz2FNSSDI=;
 b=Wqnpqv+Y91gbOngFi5o3iqukwOTzPcFBewyb8BqRszWSv8R1Eh3aLQGlCSAYiZEDzBez3DjNwZq/NSAJ2isfGwmYzUI8gFRWbIsmL0DOOXarNHflj4EjGDN/xb1dYOc7u3uApvbiJf+rGxsm1teUvbM4+/ibpi8bxpEbiTzHZwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 09:04:43 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 09:04:43 +0000
Message-ID: <abe544be-46e9-15f6-98ca-808f3d22cca7@fortanix.com>
Date:   Fri, 18 Mar 2022 10:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in
 microcode update
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ashok.raj@intel.com
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-10-cathy.zhang@intel.com>
 <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
 <947c4872-df94-0091-ebbf-b733db4bd9d6@intel.com>
From:   Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <947c4872-df94-0091-ebbf-b733db4bd9d6@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010005040201080408040602"
X-ClientProxiedBy: AM4PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:200:42::22) To PH0PR11MB5626.namprd11.prod.outlook.com
 (2603:10b6:510:ee::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 774dfe50-ca01-4918-13a2-08da08be573f
X-MS-TrafficTypeDiagnostic: CH0PR11MB5426:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB54267D16F80FC635C57CBD4DAA139@CH0PR11MB5426.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHkSIdTYLCjY/ihf3Qh9SrIamzD7eC5RSdgQk9yMDVaI0ifcEBX+AY5sJlOFpurNPfIvk3VF5U7dZBEWNN/PA6BUnZIp338yhECWkS4DNaVGL85GqMmIGG+k/niJ/1SnxE3ldjix7p5BErmBoPMvy2/TkkE2bp9dPTs+W5aSQroBVunTQ1mddSjLtD2AQ4McoldLjFbuAChZMLY74j0SpiWcb3oeu5tTnM4o9VetdZY6slgCNwqF3TfB1DYsxRgsFmhcZpoVXCklLxQDjT/A56pnafPDAIkW23hwDZEvkxsUkgBd5X7Z8x0+8AW9eEGJmosDqFUFAwZV1G7iateseA12xaXzAO9TuXCYSW7VgDbSSBPhMVHK+G805wHxsLhi0GXYSoU7GN5ygBL1oXlWzG3lj/svnpN6JCWftbdhO1b91BiaC3h7Vn04aMC1mDbYzq/pRuobO3kGHu2+eGv0zTQ+hrfTm8vdbndouOyAruMborvfTZFHlYn5dv0yv8Sy3a9THkee6zuUlox2K7Hwe3/mcOjqrnguKcfc3/LkyIvlOcAjAilCeZYbQ046+Qf5zYD08bCeAZKDNuudH+3ZBfaxU2vhrRCrts6fersTt9MpWQaGhC/6XCDLpqVdz7S5tNohJhrfI6LL+Cr53aIKlD0cMnIAvaYlSx1e7llWyxH1I2sk6749Md7yfMsRM19J5FnkLWU0dyWVAdOpkv/psc3eNpKCgw6Ygp6GUmuCCNwZCOnAzhx32md6hLYjBlt9tHvLD7z+AkRQKF5srjcyig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(15650500001)(186003)(26005)(6506007)(33964004)(52116002)(53546011)(2616005)(6512007)(2906002)(83380400001)(66476007)(66556008)(66946007)(8676002)(31696002)(86362001)(110136005)(4326008)(8936002)(36756003)(316002)(31686004)(5660300002)(235185007)(508600001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHpYaGZVb1FYNFZKVy9Jbmx0SmlQcituYnVQZklGdmYxSE9RcUFGeFdCT0U2?=
 =?utf-8?B?TUEzYlFFR3FsYzRvdzRPN3JBZ2N4ZDUzbGhvdjJ5TmdKOHFDdGxVbTZVWWhx?=
 =?utf-8?B?ckNZVGhVMmpxZlhFSVVHVkRJNktMYjFqOStCai9FMGdkc3JwVjVGWWxteTJl?=
 =?utf-8?B?Y0pCOWdrWnlMblJGUmdVb2xjV0kycmt6a2JCR3J3Vk50aGR0cGo5N0NJOHJa?=
 =?utf-8?B?M3pZUWtHWWZhMk45akZsdXQwUUxEakc5K2lSR0dmUkRlS0JVSEtRNzArWjI2?=
 =?utf-8?B?bWRZTG5pNFhFc09NZ3dTWWU1R3lZbGxYY1hKVXFxYzVIU3BMK2ZYc1FpaXMx?=
 =?utf-8?B?NGhFUlVjZHRjZGpoZVpyNTVOUXY3M3hxaVJ1dU8wdVdsUWFwVFRqZjZ0TW5u?=
 =?utf-8?B?bitFSkFpZE8wYVpiRTgyT0VHUUdRU0t1bEM3QkhTS3pENS9LekRPS0x5UXov?=
 =?utf-8?B?ZjZObnc3OEhFWHVuQVJUUU45d0M4Yzh4Y1hsUDZKYW4vZlVLOEw4RWZLSE96?=
 =?utf-8?B?SHUvdWZLd2xDSmo0K2kwOWV1OWhwNVpCMVgycjFGOEVZUm15VlVtRnE3Wm5J?=
 =?utf-8?B?K3haRUxPeXlMRjZub3VHVU5NdzgxdDE4Qm5oL2NDdG9mWUc1bkV6NFNsWWcr?=
 =?utf-8?B?ZG5SZVlOaWRQejhqdCs4OGY4VjZYSFhJTHN0ZXRSa0RIbTZJSjVCSjlMRlRy?=
 =?utf-8?B?ZFE0Y0ZrMXJRRncxYjJ6UjRrMml2YTBnSTdaTDVaOXdyNXdIMmxVdlBrUTJZ?=
 =?utf-8?B?K293cHRVQnFycjlRdXhqN3pHcForUXNzc0J5eWduT1lpWUxjdkFlQ2FKOU1w?=
 =?utf-8?B?NzBDWDNNM2RXeWRETjdVQS9leUN5SjlJWEhSeElWK3ZPa1lTWXhqOWhLK3Rp?=
 =?utf-8?B?VkwxdTlBdDZtRzBtV0N2TWYyd25BRkZ4c0xudHBiL0ZRNTk0dmJ0L1doblNr?=
 =?utf-8?B?TW51ZjJSUWVFVXhEM2ZmTXNPbEZWVmpUMUFhVXdpS21zVUJVWXd1czZRQW1z?=
 =?utf-8?B?VjlvQkIvYkQ1c0xoekwzd3BNakdrMUpsZUhITDlXZ2dtbys5M2lwNFJHOE12?=
 =?utf-8?B?TG9NaEhxUk13bHVBN2x0QUJ1OHRqTEx3UDJkWlo0K0Z6SUlmLytaeVhGcWFa?=
 =?utf-8?B?cVdHb1U0VHBLamFIK01jamZKQnZpQzBvU09CMnI5ZVBta0IyRnI2UStYd0JG?=
 =?utf-8?B?YWRyU0QrUDYzVzF3NVlQUHNEUGxQdGk1YTRxUGkxUzB5dGJpTzRUK1c1SEJa?=
 =?utf-8?B?VHNzV1ZrWjhsYnlFeWZBcGEyTDNXNjljOG9OSjhXU1hqM3dEUGF0QzNtdTBN?=
 =?utf-8?B?bGx2U250THRBeTlaQXorTWpjaERTckppWlRONUZKdCt2MGlwS3MxeTlOdnZm?=
 =?utf-8?B?d1J1dWJTaW03SnVUUE5rSDlhcGplczhtQVRNcmo2bjhsWXdRT1VCdzBkMXIy?=
 =?utf-8?B?R0lCekpXTlFqTFJsNVJVakJmQkcvUXpVU2Z1UGEwV2pJTDE3eU9iZG4rbUwr?=
 =?utf-8?B?amtGYkxYTGdzQTFoMkFGYjJOcnUvZHRCMVZKckNodTM2cDkyT3BkckZaanZs?=
 =?utf-8?B?MXFuU0xNcG1hU3FnWGtwYjdscFQwTVFDQUp1RVg2eCt3Yno4WCtyajdWYXJy?=
 =?utf-8?B?YXNycVpxOWlmVCtOMXpQby84VGN4aU1LaDFpSjFLRG9TWmZ1bGQwdUh6bWNx?=
 =?utf-8?B?am85cVErNEhJS3lTNWQzemoxNC9YMUxUYUNsNmJ6S2V5MGZXRDA4YWpJQjg4?=
 =?utf-8?B?TzljdVlnUXpHaHVxWGRNQnF4TFU0c20xY2xLbDJjdHRkWFpPWlhoQ0hYRndu?=
 =?utf-8?B?enN2cUhrYVIweXpnRmV4d1lYVkliZkxXdzNPRUFGRVpHeHAvWlhLZE44aTlV?=
 =?utf-8?B?WlZ2MCtrTmtpN2tBV25NRm9yaS9UdDk2YzlmSzZ2Y2hRbnNFVm5PeUUyT25n?=
 =?utf-8?Q?N0ES1VPedxQhYfHyhdVWUEY1N1Xcv4QJ?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774dfe50-ca01-4918-13a2-08da08be573f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 09:04:42.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOuqwbyIpoXExrKSMrUfKkTZErPVE18AjZtIgCgyvbfXUNt7Joao78oMkNor5wuDmNAXcV7ZsY5Gil0/kChu1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms010005040201080408040602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2022-03-16 16:42, Dave Hansen wrote:
> On 3/16/22 02:46, Jethro Beekman wrote:
>>> +void update_cpusvn_intel(void) +{ +	sgx_lock_epc(); +	if
>>> (sgx_zap_pages())
>> Doing this automatically and unconditionally during a microcode
>> update seems undesirable. This requires the userland tooling that is
>> coordinating the microcode update to be aware of any SGX enclaves
>> that are running and possibly coordinate sequencing with the
>> processes containing those enclaves. This coupling does not exist
>> today.
> 
> "Today" in what?

In distros.

> If a microcode update changes SGX behavior and bumps CPUSVN, it's
> fundamentally incompatible with letting enclaves continue to run.  They
> might as well be killed.

It's not "fundamentally incompatible". It works fine today and will continue to work fine in CPUs that have EUPDATESVN support. Yes your enclaves are probably vulnerable to some attacks, but people run vulnerable software intentionally all the time.

> But, seriously, if you can't handle enclaves being killed every few
> months, don't use SGX.  The architecture doesn't allow data to be

I don't think anyone is making a claim that there are enclaves that wouldn't be able handle this? Being able to deal with something is not the same as wanting to deal with something. My laptop can handle running out of battery in the middle of writing some new code. That doesn't mean I want my laptop to arbitrarily turn off at uncontrollable times?

> persistent like normal x86.  It's fundamental to the architecture.  You
> can also think of this as a shiny new SGX *testing* feature: one that
> keeps enclave owners from becoming complacent and forgetting about what
> the SGX architecture provides.

Great idea, why not expand on this and just randomly call EREMOVE at timed intervals?

--
Jethro Beekman | Fortanix

--------------ms010005040201080408040602
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAo
rKRKpFwMN77KaahISgU8MA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjAzMTgwOTA0MzdaMC8GCSqGSIb3DQEJBDEiBCAZ
+dgaO2iNzPC2pbDwMdXw3wapG6I5GKFdzpAcll/muDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCECispEqkXAw3vsppqEhKBTwwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAorKRKpFwMN77KaahISgU8MA0G
CSqGSIb3DQEBAQUABIIBAE8qpDYUp7A7WuT4vi/um2uGNOIRWOqpuPBl+ZXqAkX+8vvbH1DA
iAxFK3i32v5IA6CeDmzZV+lm7Nt369CdwrwDUpsfWddtB3scT03YW7AYrHcCHsqRNZj1Mr1d
Z2SoK0Yg3TP4Tu9bEcIyYqyv/qqzyjGZrKeyYjoTpDdIEKj01e9v42z1cT/mnj7iPkP6Chlm
onNuDvVB0PzA572koUADiT0e83rMwjsc7X2UgYDDqlEratbbzZn0l0tWjZ1hqcfwLLXPZqHM
UgHprpiS+TSx9SfBwkcukuy4oDWHp7DMpz5hQDzbnW+lK2ro1vFZ3sgjzdxOCsshTZTLUD1l
OAoAAAAAAAA=

--------------ms010005040201080408040602--
