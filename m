Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC04F6751
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiDFRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbiDFRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:37:41 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A571F3A6A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649259955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXGvgDFjDX/smLB1vEYOvAh6Bs7vrWBkVp/32iEFEuk=;
        b=RQ2ANzgLfqeMkFJyhx2tpdoy0lfjFAuYZCnaoaLl5OkoWeRboE+60TvKgrj/J+CydqMJP3
        T4nuTM8px/Ic3bBb6CTxZ79axTeAWawR0dOadr2Mxx0a7CdyMuamnjNqrVTlMRRoaZA1vU
        B9ltH1Yp/h8GNjgUSO415SaZ1X5Q5Iw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-uvIfD3jyO42kGG51YL4-0Q-1; Wed, 06 Apr 2022 17:45:49 +0200
X-MC-Unique: uvIfD3jyO42kGG51YL4-0Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+hKoTVeWGeXCsk4BZCJCFxetakixQfB5Bcp+UviwFUDg06AL9z+2VjA7M34o05JxERJHKsR1aMqUtLKmRyXG9vJFZabEEIhOhBcnck1BYJt9lor/U9YTrhjr7jqgAillXAb4bWka5+68Ho/BSFuqQeWhilDOHs+e5oYWoPGm+aRLWI5H9I5DenY6SI3bR5X2kZIV0Mkrxb1eYTkcVLSqS7Tew+qpGVZ741gIJtN3KtWhUxuz5AOozvX+k/itpe8UcZSgM6+IJQGXaCHsIye6MGeZru7t3j84xWMVie8R2tuLU4IEQ1xM5S12OayYUgo89lKMmMyS9+8XKp+XNjg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXGvgDFjDX/smLB1vEYOvAh6Bs7vrWBkVp/32iEFEuk=;
 b=iPNRitiXyi8LOkDIvzV+2jBEyYGBxM4VREyhJWNJVfHodFBfQNrRURBJA7FphUtgYXJyQPdMTm1wezQGsiufchlgQTdPfgHWQbOc3F13zcdZ3BN3X9W3cLi/w5JY1amet6t6Vn7ztn1npcRVXJw6qvXOZl8f3AQ7cTR5mq8/WPAFxIe/y9CmoCp0DzJVZ45m/llRn8o53qA9udRO7jncQUDDUa22dsH1vabQRKHRGl3K45yb2hu9cC8KsfAy7v3cNiYRRuuuA9vidU01ZafDb1cOX5hi86iUVGGoAczx3UisCE8Jr6JCr7udR7LqpPB8d30S9ygOEnJSm4YdO+3p/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 by VE1PR04MB6445.eurprd04.prod.outlook.com (2603:10a6:803:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:45:47 +0000
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::8d7a:5d52:e592:9227]) by DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::8d7a:5d52:e592:9227%9]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:45:47 +0000
Date:   Wed, 6 Apr 2022 23:45:33 +0800
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
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH 2/4] kexec, KEYS, arm64: Make use of platform keyring for
 signature verification
Message-ID: <20220406154533.GM11641@linux-l9pv.suse>
References: <cover.1644953683.git.msuchanek@suse.de>
 <7581dcfe676024aa438beddecbf162e4ec81ccfc.1644953683.git.msuchanek@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7581dcfe676024aa438beddecbf162e4ec81ccfc.1644953683.git.msuchanek@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To DB8PR04MB7097.eurprd04.prod.outlook.com
 (2603:10a6:10:12a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7b6e3a-e13a-4bee-15da-08da17e48482
X-MS-TrafficTypeDiagnostic: VE1PR04MB6445:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB6445CD622E7CAE23D5FCF09EA3E79@VE1PR04MB6445.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xnb45HKxLWDwj0r2PFndQf+Zhe5Bonae/PKyZ9m0k175gEyxRH0Jm2prz+Pm+huydRFar80lZvprRAyVreZbZtct/T3JwTDrKKgzGbqqVO4ZJHhoQHcy8lYy9+ftAoFzZlpc2hf1h3d+37NxKrTxq2tusRJOV/mc+/Nk8y8yUcmR9UHciU8qBQRO18QEYNzF3bVEc62rZY4toh1XIrx1ZGdrGZ4WNMRleu8hAyg4q2xdImY9hPulHnvNrNFZPrsHlQf+TUsovXmu83qHMX++UIGPus3j+WbSVDWfSoTCfOvQPZq4NUr56M8rH8Bf0Rpy9DfLWUr+Hahef0tlRXeujszg2i1EkhQbIDew+otyU6Lwtsb9sFBH/nNUbVRi2rlpRJ6cMcsStAxAzOYA9ixwIe02q8xCwPPNy48hIx1LhTgG3tpkLswgUjTaQa27qvMmx0s8TRuun5g+NC0yMZNyTvJ2w5tDaL/sIkipGLTnmeuEPx8cc/a7wgiJ1CR0LT2zR5ElIkPVxQmwBpmqMb1xvpiBAfxTHn+jXordDtzcctesa5salwEPGG/o9/HwGrE90KMO1FXC6pR9isKJwrgK9J5kgFe+J4NS0JWeIVXXMuV8hf+GcHUahras9Rvjh6WiEu6LcHbKZdDa6Va5FE9c9CPjB0w/2bl8qY7WitUZhQWuUVP2ACh7ma/3K+BCWfUzemP5MOrhGo63YnOCUexvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7097.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(1076003)(186003)(9686003)(6666004)(6512007)(508600001)(26005)(6506007)(83380400001)(54906003)(7416002)(316002)(36756003)(2906002)(15650500001)(66946007)(6916009)(8936002)(4326008)(8676002)(66556008)(38100700002)(5660300002)(86362001)(33656002)(66476007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKVSGF0wMWKxQD2OWnPoeDR5FDbZzUcUFRnPg5Mmm5/SMqEOjMsUp2L5kQqf?=
 =?us-ascii?Q?5y25mNTB6Vo3UeRzU35rtwZc+y68hphs2tMOXQ5EL81gJ5BjNr9IIHK96YNG?=
 =?us-ascii?Q?38Dm/DKkCgI/XktHmFZ9aUikE8unQlexLVJsEGzjpCWSQ9SdOh9jij7RqjJA?=
 =?us-ascii?Q?HuZQGaBwk9p4c2WOwQhE4owRDQLxcmxIo995921ctR6nGWfKrjs2jQnXUQZD?=
 =?us-ascii?Q?aGM6Al/Z3aNHkCUEb/NFBMdPfh8WJvcW3Abzby0U3YMzMLOziXmz8t0t2K6D?=
 =?us-ascii?Q?lgPSE9crKNuZKp82jHmEbM1YNG+dGBGk5cEhuI3IadTF8kWNank0ljtpzdc7?=
 =?us-ascii?Q?LLQ4pFnAkhaTqtbF1d8A0jxT9FPsNesm6XOAa+tla0l4v0urFP0eet5deT0Q?=
 =?us-ascii?Q?MjW5iec+13ZsYp7UeZVqaip276AgJ3JGvvOvaUPFpn4eRcZw9R6jQajIWiKU?=
 =?us-ascii?Q?dFlbtd2dfKdM6/v7rWoSo6anlQHZfLpEMJk8bn+yFK1mrmD/rJRX1Nvc8iis?=
 =?us-ascii?Q?2p/pXu3Lg1cy3zgBO/H/bBLZ9ZhiMK+sMmIMme6l5lo24KIZuGvkC7aB0HCP?=
 =?us-ascii?Q?0sy1eStrdWVlqdfjVgOx3znpeE94uXI82ZRA92a+sjD2+VJ/thQJpuopsY54?=
 =?us-ascii?Q?krpbmIoWXQ+83Sy4UmqIdBo2MqE6zz+PoOVSqz+2Mk41WyfqzQMIppVB7Ik0?=
 =?us-ascii?Q?z6aEGPV3kbUXe0iM9Wz6w0vRCpn23t1n0hxy4ZTCMMdypy9Ckki3iNDa/QG5?=
 =?us-ascii?Q?uaJRDAyb6PapPvm5cThfqvB6/978bPFtpGp5cwZQrj3I2Fr7AyRYHgGMRFLK?=
 =?us-ascii?Q?jvRhluJFZRm8+usXgzR3+iZmEY4ASz7UUZH5KVdLkhk4uP5HCVAxTqcXz+4+?=
 =?us-ascii?Q?0UdHglQMnvCGwTmsNPIDb/Is/IsSotAhG+S2x+kjXRuTpSVPziaI4Xd08PXu?=
 =?us-ascii?Q?+bqKGokxQd5gTdEHZGmD5qj5qo3JgFZrKtloUl2MXDfo9u4BUROy7WFAyzBD?=
 =?us-ascii?Q?3GFpAVJWYSCQxewkqrnCIMogpm1JQ12ve33PbIv3BY6qF4DoMpdVyc11na2Q?=
 =?us-ascii?Q?Qx4GgWNYwnjWo9yczkgDGqMidPZvYUy5qagh6hYKrYFDl28L/x+bnslpx+ia?=
 =?us-ascii?Q?N1nvqP6/jN0Il2c1y8k/aoZm7GwuGv3GBDSL9flBep/z3h7c//7w/nvcDYgY?=
 =?us-ascii?Q?phPrSEwO2taTHYsswCqruTwkS0b77K82gah7xZ5/7ZmC2RO2BdYDSZwR+XIU?=
 =?us-ascii?Q?plR7NXRj4UgGc9yzlz/+SaA0d8Tx2AC+YdgXnPxgIyBWS0WJdAqwo7vgRb8V?=
 =?us-ascii?Q?6Yn3SAgwJNyqUEneeNt3Wwn0l6LJdxjukJirAaE0I4465+X2unu0rGEcEM/H?=
 =?us-ascii?Q?J0yxd5gDfZb7nRHYqA4j7y5Sr+4PiiVC7zQvRmq5g03yYMWu2Qx2YpJxYb+G?=
 =?us-ascii?Q?n8tacTp6uTN+i9dGxKCxZrb4EIRUf9G3VIzQy71EUMS0wPpD37J9jjhkA1WO?=
 =?us-ascii?Q?0lgVwqZ2IxIL80fFGd088zMT5/EGcmWmz1kA6BBcldrGHX6qXmXjL6ejqaql?=
 =?us-ascii?Q?sWKhEJtVhYnU8LyIsVeHnZUdDCsFOq+9TYoZAyOZcCVRLluoVMcVFKAz88QN?=
 =?us-ascii?Q?BDusdirtXpxcUJ6jw03xdDyXtcCt0LxbEFYlw6BgspWwp1u1o7/VduEzDqxo?=
 =?us-ascii?Q?MWM6YOazbntlCIi3lsBMfp4u710mrz+JrDu1A+pscrktZg17/smXAAqMH4cr?=
 =?us-ascii?Q?EdiPaSsEQw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7b6e3a-e13a-4bee-15da-08da17e48482
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7097.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:45:47.2258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCcM561pyQ2vjCPVKMV0aafQfITGDNEO0tVrCcNX03g1baNga7Pjca/A0P03EX+K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6445
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

On Tue, Feb 15, 2022 at 08:39:39PM +0100, Michal Suchanek wrote:
> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> adds platform keyring support on x86 kexec but not arm64.
> 
> Add platform keyring support on arm64 as well.
> 
> Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> Cc: kexec@lists.infradead.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

> ---
>  arch/arm64/kernel/kexec_image.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 1fbf2ee7c005..3dee7b2d8336 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -133,9 +133,17 @@ static void *image_load(struct kimage *image,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len,
> -				       VERIFY_USE_SECONDARY_KEYRING,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	int ret;
> +
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +				      VERIFY_USE_SECONDARY_KEYRING,
> +				      VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +					      VERIFY_USE_PLATFORM_KEYRING,
> +					      VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
>  }
>  #endif
>  
> -- 
> 2.31.1

