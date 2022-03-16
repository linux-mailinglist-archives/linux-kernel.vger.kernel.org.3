Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82D4DADB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354955AbiCPJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354957AbiCPJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:47:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2098.outbound.protection.outlook.com [40.107.236.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB3654A0;
        Wed, 16 Mar 2022 02:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7/RT6ExWhC9Fk3j7Kq6gC0AYBqvwXCzg9vLdsp+sGRkZUuvFJODjYhYZ4ITpLn2pPLandd0XJqpbaXOyOBGXX4C43mDeuCHCL20E7My2aup09YTYmAUf8HWgFs7txrAzo6E/vvmnrtvcYBfMltcp17z4jommljoXj26AqnP392drO2CRnqel91tBJJMRlYc+WtHZAQ7m+1995fUiBRlTuHEBs5UW/5efOiYTmxKPG+s1ztuIWSaJtjLz9JZtNy2iRsomivnTr6QPzaM5rghoufBaGzoAcNeEaDr6USzyrGFL97YRr+LOP9WBZ78V8J5irVVKF8M2QE5pxlGCqMEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OghRy/ES1AdFHej/ll8v+y5J+wsWeIiBnNj2Yy5Mg/Y=;
 b=M9Mbzhigb5fDx2y5biSOKa05XGDKmmfGNDOpMVVKkxpGJVV/uCZkRv11o1NQUnio7jXwzd81itzxpf4pOsaZoaLjNW4ixFAjiVX42GYnVU6Rs8G6+UHh2i1z+XWunfWhKtm4OSGAkpmcmCjPKqZDTAlHivnpwndN0j+rwoI947lgMSLiY1qcYLAmDgWtnH+d93SqrgO/ESXvJ190tEdRHVjdbVibhjk38DVSjmrceh59/uLhfgmxaSr9R+SSqgDY8u2WVgvZen63HKT3/tKaYeKlk1GDY7rpAl8ROD1BUlwQCOvb0u/mD9eWFiQWOKo3liPOnWxNTArl+agRQomVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OghRy/ES1AdFHej/ll8v+y5J+wsWeIiBnNj2Yy5Mg/Y=;
 b=Cy5hbQPrq+uCTnupumvNMkl7El7arCJIDk7UQN/WnF2wbJQkmnU/X0cZUH9RZ0VZkfWTzIRq+prFlyBUotasoAr+wACL0YfjpKVZVkTHFs8iMH3Rwx+wRwXBBfd7FpWihaYfyP1gtY/j0aVwaSPZ8IQX8NUKSefPrhg11G+zkwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 09:46:05 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276%5]) with mapi id 15.20.5081.016; Wed, 16 Mar 2022
 09:46:05 +0000
Message-ID: <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
Date:   Wed, 16 Mar 2022 10:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in
 microcode update
Content-Language: en-US
To:     Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-10-cathy.zhang@intel.com>
From:   Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <20220315010300.10199-10-cathy.zhang@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000903000909070506060406"
X-ClientProxiedBy: AM0PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:208:122::18) To PH0PR11MB5626.namprd11.prod.outlook.com
 (2603:10b6:510:ee::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7f48acc-92d0-4c3e-1fe5-08da0731ca06
X-MS-TrafficTypeDiagnostic: CH0PR11MB5473:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB5473991BD719F35618354BE3AA119@CH0PR11MB5473.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tt4u8SU+SNBrTht4zfR0zYwaVf0psfhGfrNLlo349Kc+te0oSGyaS87WW8qJijhoOVzeOpd2SYDleCRs084i17Zz9F+2kmqebXBQFpBPAYIlmWKfmSF7q5kiJTOoMUk4qNvtKIdS0mX0U+o0GCgjCfAotvBVcdACtU8ZLVrMfvx0vR942mz6nSR7g+4RXWBxi69rRX2AWgaw1MvY2YKkVf0v7K8uOgrMsdcc/NVsHTcm9uGTY1FIlvMA0sKNaWbsQH2lz8aB0lMmuJ7p1frn577xotWRFWB3upueNtqDMafgAdx/KrQHU7k6cQpVVdGlpccSCEbboOVyMcdOUA2KjoopatZRGZqSDBGO6iyj4RumuWSgha8/OBspQXYC6muuLWzSVy9HBiFH1rv+GdrbXlLMD20zqb4iLRWrXlOCSA4gaMYj9D7eDjnH41R+shaxI6niCFkCXKOMD0oS2blqNV3gLadylQRe1ifdZ3GLQ6gOFQPm45PFihk/VKQ9uKY8XbfTpx8+0mfAsfoBCD/yh6OOhx2itkiLVuS3kBvf1oVCY16E4ua2hJU23DScBBx/Nj0j9uiL1LYSHfCx4FZn/eORw2SGkIBZDSazlMqCv1G3WxWla6/Mps7i8+lYagIWpAT0o+5V9HPPl7GSLU8eecMNmoJULHRetWr0emNHZgFpEPYzPZb2Qmh7mA/BY1rtt71WXAR2aneNpR9hQ5pypojucahuEcy2rF93dz3N6VNpCCUBYczED3JewhAF26YD2rQACtildG9nAL5HVlN8FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(6666004)(31686004)(36756003)(6486002)(6506007)(53546011)(33964004)(52116002)(26005)(186003)(2616005)(83380400001)(316002)(66476007)(66556008)(8676002)(4326008)(66946007)(2906002)(15650500001)(5660300002)(235185007)(8936002)(31696002)(38350700002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUE5TlU4MWhBalRBWXpLMDVUKzBPQVRLOE42eDVZb0VjaElpNmtJeXd2WDJl?=
 =?utf-8?B?REhueXNOTFhXVGlibmNDQmhNcXVQQ1NHV1dvckFlYlVMNTdvSDEwS3ZDaW9M?=
 =?utf-8?B?K29Ib0FCd3podEkyVVdHRDVWSXF2QmcvSnVWRmtJaGlQNHFOUjZqSDZKMkx3?=
 =?utf-8?B?RTVyUHBxVmYwZElrZTd4QkhFQkZRMnBKUnN5QXBHdmNKcjB6UEVJTUxHbE9F?=
 =?utf-8?B?M1ZsZUQ5c2grWndoYWhQVUo3QWlXL25GUFZ4akRjUlovMU1RMnErTWs0TlBw?=
 =?utf-8?B?QnBjN21uNE9XdWwwN2Y2a2lkMHRtdWI5N2FaSHMwd0YxbS9xTWtmZHVBRkVK?=
 =?utf-8?B?UmJabUFidjVYNW1jbkJwU2lEanJRWnlvTkV4L21KRWcrZGt4WUkvcTJzWUdC?=
 =?utf-8?B?dS9Mb3hRamo1b2lvbGNxanlRRUdVbUxacHJ6dC8reFYrSnFlL2dFRmlUYWo5?=
 =?utf-8?B?RThrS0Q3d2h6cmkxbGxMOUFHRTdtdGl1dmJBeGg1QlpHY1Fjd1dwSTYySU9R?=
 =?utf-8?B?cFFLZVlGU0Rlb2R0cWp5aElSUGRqbkxhbGdxaE1ZVzk2eXpYQ1JiQVNmUXZw?=
 =?utf-8?B?SjRicEdvbUFmcU5jVXdlMDJDTVV4VVdFS0tnUk5UT0QzUklVZjdReHBPY2M5?=
 =?utf-8?B?MTMzM1dSaGIxbmN0TzMyQi9aWFRQam03RjdaZFBWd0VJbWd6WjNCamJBTHNN?=
 =?utf-8?B?dnY4OWdMbmo5bkJPbnJjUXhVSk02TGdEb1cxNEpxV1FFaURwR3BtcXpWRlBv?=
 =?utf-8?B?QTdrU2lQZllBTUdpZFdkMnI5RnY3ZUZNeWl6STV6SFhHeGxaVXA0Mnkxd2w5?=
 =?utf-8?B?SHkvbkZLVkx6dllneTd6QmVqbWI1bEk1OHY4VG1PaGZHTkh4djNDV0hvK3pz?=
 =?utf-8?B?YjBmcE00eWxZSUdvd29nc1RqajNhd3ZpMWphR1JSZHlmOXgrNTUvbG9EVWh3?=
 =?utf-8?B?NGhMZ1lJcEF2cGRPeldWeHdabk11V1A3QjM0QVJZck56R000WnU1dUIzZStV?=
 =?utf-8?B?cGdlTDFNaVp0MFp2L1kySzFSWXdyenlrZUpJY1FWS0VLY0p2YitPeWZBWkNQ?=
 =?utf-8?B?c3Z4ZExIb2JIQ2RLYXFKZHl1Q2JmVnpNUVZ0R2pERFVaSEN0V2tOL0lEYzZ4?=
 =?utf-8?B?ZWhoOG4zc0dFa0Jjb0pSdDJoV1hIMXB1N2k2T3VlSHBpL1BNNU94R2NPcEZW?=
 =?utf-8?B?K0w1UmxvdDJUZHA1MGtSR1R1bHhWVkpxV2kvNlhpOXcwM3c3a2taNEwrMTc0?=
 =?utf-8?B?RWZxWW1GNXlacmZkeHhLMG9BamlTRlk4amNqb0ZMQ1pNVm1uQmJGN09RenNJ?=
 =?utf-8?B?bEtsamRqeVkvb1JubFAvZ3FrYTJYb2hFalhsNldRbk9UdHZQTFFwY010T0py?=
 =?utf-8?B?K3ZscU1QT3VjSHRoUlNqdG5PbThvN3VOeW9rL2pZa1F0NzF6U1RlQWlFMGZ0?=
 =?utf-8?B?ZlVQMlA2VFBLYXhzWGwxOHZDRDRKeUh4UXVTWDVTdE11dXFYc3dZek1yZWJW?=
 =?utf-8?B?OXNPMUlaK1E2NzMzWVAzTEcxbVFkQU5LNmRiWGZQU2xKQU1peG4vdmdDd3dw?=
 =?utf-8?B?bnJvVFF4MTg5YTVKUHpQa2dTSVRybitlS1RBUjRZYndDVWQrRVVEdjVOemZm?=
 =?utf-8?B?NTk2Y2NaemVXckZBclg0WXJyRVVIbVMva2haWWsxMXRRTm1LQ05jNEljRWgx?=
 =?utf-8?B?SUpKN3prWDlNVEFaSlRkRldOMnJRK3l2Wml5bjFraHJ1YVVObVltbngvVmk2?=
 =?utf-8?B?emFGdm0xRVNOL3pVLzF6UXlzaXU2OURoU3JIeXZkbW00cG9DNDY1TURsSGln?=
 =?utf-8?B?ZXo4STkzOW83bFFyemdMQWpleFhZM2MwZUdDeEJBa2ZGNXAyc2hZdWlLMTVz?=
 =?utf-8?B?VEdBZnRMUFpocWJjNW43M0lFVHdvVGdMbWlBNmVLNDMxeEFPdlJkTnZDczhx?=
 =?utf-8?B?QjkrU3NtYXd2aFRvMU1jMloxVEJMdTdwc0lzdGVLRXdtOVdsdy9YcFkwcUlm?=
 =?utf-8?B?V3JHeis0VFN3PT0=?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f48acc-92d0-4c3e-1fe5-08da0731ca06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:46:05.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W+nB00U3YTZuAxruf8W/b92wgXOZ5pyFIGi7ctqZ2MgHzGwv4EfNbpQXuL7m3zRPncNTmyxJYPCRjHRRWEU7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms000903000909070506060406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2022-03-15 02:02, Cathy Zhang wrote:
> EUPDATESVN is the SGX instruction which allows enclave attestation
> to include information about updated microcode without a reboot.
> 
> Microcode updates which affect SGX require two phases:
> 
> 1. Do the main microcode update
> 2. Make the new CPUSVN available for enclave attestation via
>    EUPDATESVN.
> 
> Before a EUPDATESVN can succeed, all enclave pages (EPC) must be
> marked as unused in the SGX metadata (EPCM). This operation destroys
> all preexisting SGX enclave data and metadata. This is by design and
> mitigates the impact of vulnerabilities that may have compromised
> enclaves or the SGX hardware itself prior to the update.
> 
> Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
> 
> ---
> Changes since v1:
>  - Remove the sysfs file svnupdate. (Thomas Gleixner, Dave Hansen)
>  - Let late microcode load path call ENCLS[EUPDATESVN] procedure
>    directly. (Borislav Petkov)
>  - Redefine update_cpusvn_intel() to return void instead of int.
> ---
>  arch/x86/include/asm/microcode.h |  5 +++++
>  arch/x86/include/asm/sgx.h       |  5 +++++
>  arch/x86/kernel/cpu/common.c     |  9 +++++++++
>  arch/x86/kernel/cpu/sgx/main.c   | 12 ++++++++++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
> index d6bfdfb0f0af..1ba66b9fe198 100644
> --- a/arch/x86/include/asm/microcode.h
> +++ b/arch/x86/include/asm/microcode.h
> @@ -3,6 +3,7 @@
>  #define _ASM_X86_MICROCODE_H
>  
>  #include <asm/cpu.h>
> +#include <asm/sgx.h>
>  #include <linux/earlycpio.h>
>  #include <linux/initrd.h>
>  
> @@ -137,4 +138,8 @@ static inline void load_ucode_ap(void)				{ }
>  static inline void reload_early_microcode(void)			{ }
>  #endif
>  
> +#ifndef update_cpusvn_intel
> +static inline void update_cpusvn_intel(void) {}
> +#endif
> +
>  #endif /* _ASM_X86_MICROCODE_H */
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index d5942d0848ec..d0f2832a57b3 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -412,4 +412,9 @@ int sgx_virt_einit(void __user *sigstruct, void __user *token,
>  int sgx_set_attribute(unsigned long *allowed_attributes,
>  		      unsigned int attribute_fd);
>  
> +#ifdef CONFIG_X86_SGX
> +void update_cpusvn_intel(void);
> +#define update_cpusvn_intel update_cpusvn_intel
> +#endif
> +
>  #endif /* _ASM_X86_SGX_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 64deb7727d00..514e621f04c3 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -59,6 +59,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/uv/uv.h>
>  #include <asm/sigframe.h>
> +#include <asm/sgx.h>
>  
>  #include "cpu.h"
>  
> @@ -2165,6 +2166,14 @@ void microcode_check(void)
>  
>  	perf_check_microcode();
>  
> +	/*
> +	 * SGX related microcode update requires EUPDATESVN to update CPUSVN, which
> +	 * will destroy all enclaves to ensure EPC is not in use. If SGX is configured
> +	 * and EUPDATESVN is supported, call the EUPDATESVN procecure.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_SGX) && (cpuid_eax(SGX_CPUID) & SGX_CPUID_EUPDATESVN))
> +		update_cpusvn_intel();
> +
>  	/* Reload CPUID max function as it might've changed. */
>  	info.cpuid_level = cpuid_eax(0);
>  
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 123818fa2386..d86745d8cc7d 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -1380,3 +1380,15 @@ static int sgx_updatesvn(void)
>  
>  	return ret;
>  }
> +
> +void update_cpusvn_intel(void)
> +{
> +	sgx_lock_epc();
> +	if (sgx_zap_pages())

Doing this automatically and unconditionally during a microcode update seems undesirable. This requires the userland tooling that is coordinating the microcode update to be aware of any SGX enclaves that are running and possibly coordinate sequencing with the processes containing those enclaves. This coupling does not exist today.

--
Jethro Beekman | Fortanix

> +		goto out;
> +
> +	sgx_updatesvn();
> +
> +out:
> +	sgx_unlock_epc();
> +}

--------------ms000903000909070506060406
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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjAzMTYwOTQ2MDBaMC8GCSqGSIb3DQEJBDEiBCBj
yqw7rO/I5mA6/EHrreG6Bq6T2GpCLA6uT0THhpwNwzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCECispEqkXAw3vsppqEhKBTwwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAorKRKpFwMN77KaahISgU8MA0G
CSqGSIb3DQEBAQUABIIBAFqVFtpiQTyKBQnLaxRdo2TqmN+3vYrtt0rGk9wcoW1C8RNLqADl
j+R6FdOueKI0dhgG2kBC2VALF+N3u2nI/CjkX5fXSJczpG4ek6iAEOfgx+nyQi7/9xykJSfI
cshFPB74OkE6nFuwD8QgkVibUWndmVmxra0ZOT1WtbNhZiYsyjUisoa78TEZEf66otWFOvf5
mtv/iyLeFDveJelwAJ2ohbdAMrC3T/UEYSroRvFgtv6nMABDWkDeSf4gBGDADAXknrDsRrhs
OPcdha4r8jGoJVTjySbHAsXiyntYvSzUO++dI5XpXrjJV9QbACIOGgadlu8849zYWHYAneEA
8j4AAAAAAAA=

--------------ms000903000909070506060406--
