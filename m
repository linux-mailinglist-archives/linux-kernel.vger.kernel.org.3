Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7A4CE0E2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiCDXVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCDXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:21:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31BCF3A4;
        Fri,  4 Mar 2022 15:20:26 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224LgfXR027489;
        Fri, 4 Mar 2022 23:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WCYSt8KRidhL4NjdsV5ZjsM4ES0G/Mb3imPT1/Z1NME=;
 b=GM3RPUriKqkoAraxi1Ti0h6WRnBo4j1Xc739RhCFPF1GcuXhy1jU2kBNy+0BVZUJxsET
 pADnnoNMGphPdFhgir96oe4BWn9ZZuvvQhhivHNG4aPeY5eO5hbGs+zEN/UuBbVhh2So
 EMnZfrbxeD59wGPzNETl0fsxBQ/JjP9jG+5jNT145W0jRnREmtVHU0FA665jnfQMMsIC
 o+Cm/P8SPV1niiN0fDtFsOVzFTId79CHErduo8/hPLzO848JPiKTR5BgOTXAbDtYaRu6
 HalRcLb2PAD6leRRasdWz+d9Gv506eusFkuThSamEnncqe1R5N3XWPatz8EM5ClwcxYV HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ektx2sbeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 23:20:03 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224MuQkK000670;
        Fri, 4 Mar 2022 23:20:03 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ektx2sbe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 23:20:03 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224NHPSM031883;
        Fri, 4 Mar 2022 23:20:01 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 3ek4k9qyrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 23:20:01 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 224NK0dm24379686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 23:20:00 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 953F46A057;
        Fri,  4 Mar 2022 23:20:00 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F3786A051;
        Fri,  4 Mar 2022 23:19:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  4 Mar 2022 23:19:59 +0000 (GMT)
Message-ID: <59f08890-f3f9-43fe-e1cc-6648071e33e0@linux.ibm.com>
Date:   Fri, 4 Mar 2022 18:19:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] integrity: CA enforcement in machine keyring
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>, zohar@linux.ibm.com,
        jarkko@kernel.org, dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-5-eric.snowberg@oracle.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220301173651.3435350-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FFoQN9N1jdMMU59j4bVoavWi3cmld1m-
X-Proofpoint-GUID: S4tRvY4JhVV13QKqIFRBF79Lc8SxZ32e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/1/22 12:36, Eric Snowberg wrote:
> When INTEGRITY_MACHINE_KEYRING is set, all Machine Owner Keys (MOK)
> are loaded into the machine keyring.  Add a new
> INTEGRITY_MACHINE_KEYRING_CA_ENFORCED option where only MOK CA keys are
> added.
>
> Set the restriction check to restrict_link_by_ca.  This will only allow
> CA keys into the machine keyring. Unlike when INTEGRITY_MACHINE_KEYRING
> is enabled, IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY may
> also be enabled, allowing IMA to use keys in the machine keyring as
> another trust anchor.

I tried to test this but could only do it by disabling the 
MokListTrustedRT variable check and then also the check for secure boot. 
It did load the expected keys onto the .machine keyring, enforcing the 
x509 indicating a self-signed CA if the compile time option 
CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED=y was set, loading all keys 
in the case of CONFIG_INTEGRITY_MACHINE_KEYRING=y.

I tried with this branch here from mokutils 
https://github.com/esnowberg/mokutil/tree/trust-mok but this seems to 
create an EFI variable with a different name. I guess this is the wrong 
branch?

    Stefan

> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>   certs/system_keyring.c                        |  9 +++++---
>   include/keys/system_keyring.h                 |  3 ++-
>   security/integrity/Kconfig                    | 21 +++++++++++++++++++
>   security/integrity/Makefile                   |  1 +
>   security/integrity/digsig.c                   | 14 ++++++++++---
>   security/integrity/integrity.h                |  3 ++-
>   .../platform_certs/keyring_handler.c          |  4 +++-
>   7 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 05b66ce9d1c9..0811b44cf3bf 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -22,7 +22,8 @@ static struct key *builtin_trusted_keys;
>   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>   static struct key *secondary_trusted_keys;
>   #endif
> -#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
> +    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
>   static struct key *machine_trusted_keys;
>   #endif
>   #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> @@ -89,7 +90,8 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>   	if (!restriction)
>   		panic("Can't allocate secondary trusted keyring restriction\n");
>   
> -	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))
> +	if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) ||
> +	    IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED))
>   		restriction->check = restrict_link_by_builtin_secondary_and_machine;
>   	else
>   		restriction->check = restrict_link_by_builtin_and_secondary_trusted;
> @@ -97,7 +99,8 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>   	return restriction;
>   }
>   #endif
> -#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
> +    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
>   void __init set_machine_trusted_keys(struct key *keyring)
>   {
>   	machine_trusted_keys = keyring;
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 91e080efb918..e4a6574bbcb6 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -45,7 +45,8 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
>   #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
>   #endif
>   
> -#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
> +    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
>   extern int restrict_link_by_builtin_secondary_and_machine(
>   	struct key *dest_keyring,
>   	const struct key_type *type,
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 599429f99f99..14c927eea5ee 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -62,6 +62,14 @@ config INTEGRITY_PLATFORM_KEYRING
>            provided by the platform for verifying the kexec'ed kerned image
>            and, possibly, the initramfs signature.
>   
> +
> +choice
> +	prompt "Machine keyring"
> +	default INTEGRITY_MACHINE_NONE
> +
> +config INTEGRITY_MACHINE_NONE
> +	bool "Do not enable the Machine Owner Keyring"
> +
>   config INTEGRITY_MACHINE_KEYRING
>   	bool "Provide a keyring to which Machine Owner Keys may be added"
>   	depends on SECONDARY_TRUSTED_KEYRING
> @@ -75,6 +83,19 @@ config INTEGRITY_MACHINE_KEYRING
>   	 in the platform keyring, keys contained in the .machine keyring will
>   	 be trusted within the kernel.
>   
> +config INTEGRITY_MACHINE_KEYRING_CA_ENFORCED
> +	bool "Provide a keyring to which Machine Owner CA Keys may be added"
> +	depends on SECONDARY_TRUSTED_KEYRING
> +	depends on INTEGRITY_ASYMMETRIC_KEYS
> +	depends on SYSTEM_BLACKLIST_KEYRING
> +	depends on LOAD_UEFI_KEYS
> +	help
> +	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
> +	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
> +	 in the platform keyring, keys contained in the .machine keyring will
> +	 be trusted within the kernel.
> +endchoice
> +
>   config LOAD_UEFI_KEYS
>          depends on INTEGRITY_PLATFORM_KEYRING
>          depends on EFI
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index d0ffe37dc1d6..370ee63774c3 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -11,6 +11,7 @@ integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
>   integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
>   integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
>   integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
> +integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED) += platform_certs/machine_keyring.o
>   integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
>   				      platform_certs/load_uefi.o \
>   				      platform_certs/keyring_handler.o
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index c8c8a4a4e7a0..041edd9744db 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -34,7 +34,11 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
>   };
>   
>   #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> +#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED
> +#define restrict_link_to_ima restrict_link_by_builtin_secondary_and_machine
> +#else
>   #define restrict_link_to_ima restrict_link_by_builtin_and_secondary_trusted
> +#endif
>   #else
>   #define restrict_link_to_ima restrict_link_by_builtin_trusted
>   #endif
> @@ -130,19 +134,23 @@ int __init integrity_init_keyring(const unsigned int id)
>   		| KEY_USR_READ | KEY_USR_SEARCH;
>   
>   	if (id == INTEGRITY_KEYRING_PLATFORM ||
> -	    id == INTEGRITY_KEYRING_MACHINE) {
> +	   (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING))) {
>   		restriction = NULL;
>   		goto out;
>   	}
>   
> -	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
> +	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) &&
> +	    id != INTEGRITY_KEYRING_MACHINE)
>   		return 0;
>   
>   	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
>   	if (!restriction)
>   		return -ENOMEM;
>   
> -	restriction->check = restrict_link_to_ima;
> +	if (id == INTEGRITY_KEYRING_MACHINE)
> +		restriction->check = restrict_link_by_ca;
> +	else
> +		restriction->check = restrict_link_to_ima;
>   
>   	/*
>   	 * MOK keys can only be added through a read-only runtime services
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 2e214c761158..ca4d72fbd045 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -285,7 +285,8 @@ static inline void __init add_to_platform_keyring(const char *source,
>   }
>   #endif
>   
> -#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> +#if defined(CONFIG_INTEGRITY_MACHINE_KEYRING) || \
> +    defined(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)
>   void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
>   bool __init trust_moklist(void);
>   #else
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
> index a2464f3e66cc..9c456ad0ab67 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -61,7 +61,9 @@ __init efi_element_handler_t get_handler_for_db(const efi_guid_t *sig_type)
>   __init efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type)
>   {
>   	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0) {
> -		if (IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && trust_moklist())
> +		if ((IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) ||
> +		     IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING_CA_ENFORCED)) &&
> +		     trust_moklist())
>   			return add_to_machine_keyring;
>   		else
>   			return add_to_platform_keyring;
