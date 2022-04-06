Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803814F678A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbiDFRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbiDFRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:38:20 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF334B90C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649260020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kc8CRbZjWWFNq3yUrHt8iTG6oax4BgdV/OMmdCABUtw=;
        b=N3ZryaTrnrrHGUWxB9rouoHHdYDFAfEIzQTPE+SUI81mUMl07rVjPSW4BkRv7b62zheMl/
        5ewvzaeP2XwEccHmhMUpUNr0slVWi7tbIfGPljE1KuhKAQBeIUsezQPOV58SL1EQtUBDDN
        lU+NtxzdWCIlVOQxiyW1PO6yenorQ8w=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-dD9XrEghMiKpNWbNYZ2PLA-1; Wed, 06 Apr 2022 17:46:57 +0200
X-MC-Unique: dD9XrEghMiKpNWbNYZ2PLA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPh55zBV0oFyL5pfau4fhHAcnoVi4lqmUDVSWUVnrqQaWFKWISYOXpSHUXBzB4jOFIeLCcjy1bc/rVIbb13XXdxDv2HhqRBDTMdMy6GZjBX5BxJj4qsYnyfUuPjvhCtUm5v37D791dVyDcBtXZElNrdSsUiDR2/YjJV9iajb3Ot5kvZIIiwT9paaApkhluIhIYqXMmdMqR7Dyd0bPdtbDrcFMZyn7Tk6BYtFN6sRvCmoCrIG5Isjxq26kXfe6tLUkJgjfpQKMIF5K71bRcmZfIJ0urFb/VDxYISFAx/sbfkyoAF7GrSokJziaxRFnLR1PZ9Fkuui70rOxTK9pMb82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc8CRbZjWWFNq3yUrHt8iTG6oax4BgdV/OMmdCABUtw=;
 b=A2l7Gy5I8uioAE9wPCxs8axaNmmHTcSPxM+PTQFudvG7QzpanP1zN94WTPAE/raM7BXQJt2f5o8a6iJr8kev6Czg0uUnZGshJsHRIGROVLoZEEBGlz/C0GXo73LjbMC50jPYa5bn2TrfwXbp2bzn7feTAe1zlJyg25X5+5ewfljRwE4uxnMx1Mrhloulj2s4petSsQ6KP1c4DRmT77KvJiiQHmDRHEKfV6Od5L01TR4UTi8F+X1WfWM+Bk0oPk2wKnm2KeXNlr3YLcZi0XN02BYgWwYhzR+Q47reB8KynsRlEBnqomuwvPpLojVBZ08v/yhGZaH0XULdhq3IXMKGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 by AM6PR04MB4070.eurprd04.prod.outlook.com (2603:10a6:209:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:46:55 +0000
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::8d7a:5d52:e592:9227]) by DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::8d7a:5d52:e592:9227%9]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:46:54 +0000
Date:   Wed, 6 Apr 2022 23:46:38 +0800
From:   joeyli <jlee@suse.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        kexec@lists.infradead.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 3/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
Message-ID: <20220406154623.GN11641@linux-l9pv.suse>
References: <cover.1644953683.git.msuchanek@suse.de>
 <9f8b71f368843568d7dd6764f8c8a68b1f3a9bbc.1644953683.git.msuchanek@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8b71f368843568d7dd6764f8c8a68b1f3a9bbc.1644953683.git.msuchanek@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To DB8PR04MB7097.eurprd04.prod.outlook.com
 (2603:10a6:10:12a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d418655b-d94b-40da-3613-08da17e4acd6
X-MS-TrafficTypeDiagnostic: AM6PR04MB4070:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4070D47A2310D3DCE87BDDACA3E79@AM6PR04MB4070.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3oE5NtWLJA5d7LHL69odBtux0PpOeNK7KBNPmFqDLYk8U8vg57/CPANNDcc0KaOhi1dWPyqb1ZFpfp5E0VVYVs2joZlMSv/RPpnf3EVeNhD7JyXKlheQldVyBsUBOhGKuoY9Xnixbd2CYpPvfifCeq/BGPqrs1I252nvKzSkMvkky/m1Mkv52amy0lNviMrurDSEzfqym/99an2t1nJ5123uq6nyhKXUwXftriul3+wQkWmyzXiRjgvNxuAcNySm1ZI3HpZzNV+vDUnz5B4QXUitHQUwaF1Tm+BzbhaoH5Irocd4zLOl/1r/iT+K8NPsPox9aCV8dbbaSGfBAyObzSfv45tLAkkqwa9aMLMSFkMm6uzI229uSTU8yt0SErU23LO408qHhqvRHYD96lTEP+owQtWN/5KdW0e+x39htL4gNmz8K3TwDisvyod9hGTMTPLoGWe7pawyptQe5HkT8iGdKnYPH72R6DG/xf+56KjtcnLEFpR/Aod1aZiylYiw37JkGLScYVnPpuS+I4oeOWJmLmFwn2fOUP2TAf9Is5iOcdVIJgk1GILF82dZdjU5zhv5asRoKleLbPCKQ3JZ0JzaJQZtyf6y8J3plp3H5ZM/5zz8AUikteIj9lQkAq1HCXx1u2dJ6Qe4PaNOrNaPjttH9TQRsJA714rApZGSxhXbuP3FgAdvd0+oRAwWDP7m1I2EwvSU/og4NTKb59cEDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7097.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(36756003)(83380400001)(33656002)(1076003)(2906002)(186003)(15650500001)(66476007)(7416002)(508600001)(6666004)(5660300002)(8936002)(6916009)(6486002)(6512007)(54906003)(9686003)(4326008)(316002)(86362001)(6506007)(66556008)(8676002)(38100700002)(66946007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?molW7i6Yc2b/xuiNoCt/+4aXhvGAjEAM6PlvFs/9uIMZKoGKYRc9t2GrjY/J?=
 =?us-ascii?Q?Os1OvpGc3RCHyxBeGkJf0EAa8gcEhZcTUZ2x83Ao5pgFMp9pJgYAUQXGFnaj?=
 =?us-ascii?Q?oTXjtoUgfDISuBi3BiAAO5f1LbeZOQ+k7C8N0ln7JY2uLgK8taynFvqTqmc5?=
 =?us-ascii?Q?glK5fFbvu/p/XF7/0RDatNRIDrLYhzt2AucOmfH4aQdu3yE6FTZtb1uVJm41?=
 =?us-ascii?Q?j7jhIHiH6qIOdAi+hQ2XCDE9pKjOwuaFYfyB6mAVxuDsinXDxqMzMytsNKV2?=
 =?us-ascii?Q?+V/7HvrAIiOW/cDe56Mu+hxceyBXaP8a8p2hTpLD2359ekeaFoIe8jAja6iU?=
 =?us-ascii?Q?KrX+Jund1iTDThWt2mgV2OHa7KZvPoZJz8ulVid+vzwFgQhj65l0O1flO/jr?=
 =?us-ascii?Q?Iz5YSmnmhBkdfDMDNciCmChg9yMMDuKL/3u9vM6ZCxfTA7ql+5MvasvVdRhN?=
 =?us-ascii?Q?jgWFNCj1w5OIWfHKCAphiU3fDYgDN4/wFr15qCTCfeS8MSzDn4TXrP9zGlUH?=
 =?us-ascii?Q?hrgi3nyWm+4ItD6swtdHpLy1s9kFix9bCpebL6hLYqWFcaFqxh+blwom5h1G?=
 =?us-ascii?Q?bj3b1rf98OyzkEQmQdBEwvdYKJG/SI0F35TPsocCtIfg8TIdu8ilGmeLSCKs?=
 =?us-ascii?Q?x+sY35ELqZDsIdH8ewnmvsHrjeP5jVzqZjgavuvk0G/fQ8o9FJhlsOAgr5kE?=
 =?us-ascii?Q?B/VJphYyWDs/0dS5SWqqDpwGLSeil/FntSUacL0iUtGJ5HdnCSn8toVkOFSC?=
 =?us-ascii?Q?vlXjac1NTgitPy+v5NPlEgCuDWWyVjjvXiJPPDsdeVwqc5/ITlkPJDKCeXlc?=
 =?us-ascii?Q?TATSYfOsJP2npFWcHBwP2pSJNwEj1hXeLxYfahYps6PfGG5cB3Wkmjz3IPsE?=
 =?us-ascii?Q?o/3LvfIhBfXXpTNEndxWG8DqgoUTt1gBswHwWKMwn1pV65IXaYlZ6UO+YN+2?=
 =?us-ascii?Q?wIYnEkcTyvqrZ7QVZ7X20LsWQVZ58CPbbWQiEFi4IRxQ8MeMvgciWMEi4cDR?=
 =?us-ascii?Q?Bz+o2pvU9wUFROvLUM7k5M6EH4+VDyn4FO2jahNl/pGqaOOKWLaA31mLDXdJ?=
 =?us-ascii?Q?skRB+qH+9YQpwEt6dJbwk7IHT1mNuQf5/AD6JWYI3fJDKjOVtvQuvrjtQ5Tw?=
 =?us-ascii?Q?pT0+lFvoZ6CYXtwTOxSn17+zursritgq2CKkjqEBEBDsq33iwaCyhF2prf9v?=
 =?us-ascii?Q?FDsYHEiesEz9a1RhWXdVKn8VMR5GzHnT/4bG0AEcWkvleqrLni/JrfEHPdna?=
 =?us-ascii?Q?4yfyK4sGJZcI7Dudn0m1zWZ1tJAQIbpQUbI4X/vvFbx4Srr+XyrcGvS8flSO?=
 =?us-ascii?Q?2+E6OIHVN0maUuMpaLaOUF0K4xl54RzJqk4qb1MVyoTxRiO2RUhI1ROyzrm1?=
 =?us-ascii?Q?ktYZ3E6alPX0mltRetUn177UCUcDt3YvOerNKVXlH99B2W5W2FWFT2v7jzEm?=
 =?us-ascii?Q?t2Jd7aRaFZhmOBRfo7uggNWJHGrlY4hjpvbZT1cmIS8jzBmoX61JsIxtlain?=
 =?us-ascii?Q?IFZe9PyCKi7ezxuC11Oz9HEIFdassb0oOdhWQUQtVf2gz0VC7SBuxNfgO7W3?=
 =?us-ascii?Q?KxTWtvbHYQXt9lqIS45hgsUzX9/4ieu8MyhbQ+CYEZSghxpipFqFDEHPdPNq?=
 =?us-ascii?Q?220UQixBjZQ2dteaep/R537xDS+1UlMxYlpMK7GQUPHHleOjinHuF8peFLG7?=
 =?us-ascii?Q?ohPdnMcnfFBFOY1SbS9ZhsNmdND8O8NoSD+82uMcY8ihPxIfIc2buYF8XD56?=
 =?us-ascii?Q?sz+dtDCbPw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d418655b-d94b-40da-3613-08da17e4acd6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7097.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:46:54.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJ3baT0gVQR7UQUTVkMOB4IF2SJERARr/3wgeeelnU056DyPCMAi8xaMjUhetMiw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:39:40PM +0100, Michal Suchanek wrote:
> commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> adds support for KEXEC_SIG verification with keys from platform keyring
> but the built-in keys and secondary keyring are not used.
> 
> Add support for the built-in keys and secondary keyring as x86 does.
> 
> Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

> ---
>  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8f43575a4dd3..fc6d5f58debe 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
>  	struct module_signature *ms;
>  	unsigned long sig_len;
> +	int ret;
>  
>  	/* Skip signature verification when not secure IPLed. */
>  	if (!ipl_secure_flag)
> @@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  		return -EBADMSG;
>  	}
>  
> -	return verify_pkcs7_signature(kernel, kernel_len,
> -				      kernel + kernel_len, sig_len,
> -				      VERIFY_USE_PLATFORM_KEYRING,
> -				      VERIFYING_MODULE_SIGNATURE,
> -				      NULL, NULL);
> +	ret = verify_pkcs7_signature(kernel, kernel_len,
> +				     kernel + kernel_len, sig_len,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_MODULE_SIGNATURE,
> +				     NULL, NULL);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
> +		ret = verify_pkcs7_signature(kernel, kernel_len,
> +					     kernel + kernel_len, sig_len,
> +					     VERIFY_USE_PLATFORM_KEYRING,
> +					     VERIFYING_MODULE_SIGNATURE,
> +					     NULL, NULL);
> +	return ret;
>  }
>  #endif /* CONFIG_KEXEC_SIG */
>  
> -- 
> 2.31.1

