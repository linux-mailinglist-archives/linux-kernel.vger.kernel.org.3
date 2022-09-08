Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B925B1B55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiIHLZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiIHLZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:25:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20B333A10;
        Thu,  8 Sep 2022 04:24:58 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2889lXvI001698;
        Thu, 8 Sep 2022 11:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AlvwoiXcWmTt4XPcR/9fgVZLjS0MEKff4YeJmUQI89o=;
 b=l0B1FT+tPd3eq0awvMDZowmZ0/6WaQ+a/my7wgS9FYfsTc6W4BmuYTLaww9M2WsNOyut
 3c+41syPeeL9eXRCViUkDZ8s5YRGP94y3aZamk/f8K3FDrbL5cyU+wV8LBedR3pKE3+6
 n+IKqWLIKBRVC/3ARZTFRZN4kcwoK1dJSaIEin1VGZABVzTQ9OKbvt8vNJz6mTevuUBP
 owb4WYddLj0bXE1+QFzdhaEaxYGtYU4j9fe7hmQ6Uhye2p7i+G8PwzYQOW4W55IXtjPi
 Ar55Xz+i1HyFtT/380gXsDmMa3zToIfOjzko7/qtQJ/3zflmVGeEAZlRfICZunZO2Vot RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfe2vudpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 11:24:25 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 288AsKj0007600;
        Thu, 8 Sep 2022 11:24:24 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfe2vudnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 11:24:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 288BMVQr024019;
        Thu, 8 Sep 2022 11:24:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3jbx6hpgwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 11:24:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 288BOJPo35258858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 11:24:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A30E24C044;
        Thu,  8 Sep 2022 11:24:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF9BC4C040;
        Thu,  8 Sep 2022 11:24:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.44.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Sep 2022 11:24:17 +0000 (GMT)
Date:   Thu, 8 Sep 2022 14:24:15 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: Kconfig: make config SECRETMEM visible with
 EXPERT
Message-ID: <YxnQ3+0BfbmUbBnH@linux.ibm.com>
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
 <20220908104337.11940-6-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908104337.11940-6-lukas.bulwahn@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uIjwroCFkW0oicsSGIESTem3oxG1McVV
X-Proofpoint-ORIG-GUID: pk9wGSrUqEXg-ItWBg8TagzjQ1laFaY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 12:43:36PM +0200, Lukas Bulwahn wrote:
> Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
> introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
> and just gives that intent a much better name. That has been clearly a good
> and long overdue renaming, and it is clearly an improvement to the kernel
> build configuration that has shown to help managing the kernel build
> configuration in the last decade.
> 
> However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
> this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
> open for future contributors to implement that intended semantics:
> 
>     A new CONFIG_EMBEDDED option is added that automatically selects
>     CONFIG_EXPERT when enabled and can be used in the future to isolate
>     options that should only be considered for embedded systems (RISC
>     architectures, SLOB, etc).
> 
> Since then, this CONFIG_EMBEDDED implicitly had two purposes:
> 
>   - It can make even more options visible beyond what CONFIG_EXPERT makes
>     visible. In other words, it may introduce another level of enabling the
>     visibility of configuration options: always visible, visible with
>     CONFIG_EXPERT and visible with CONFIG_EMBEDDED.
> 
>   - Set certain default values of some configurations differently,
>     following the assumption that configuring a kernel build for an
>     embedded system generally starts with a different set of default values
>     compared to kernel builds for all other kind of systems.
> 
> Considering the second purpose, note that already probably arguing that a
> kernel build for an embedded system would choose some values differently is
> already tricky: the set of embedded systems with Linux kernels is already
> quite diverse. Many embedded system have powerful CPUs and it would not be
> clear that all embedded systems just optimize towards one specific aspect,
> e.g., a smaller kernel image size. So, it is unclear if starting with "one
> set of default configuration" that is induced by CONFIG_EMBEDDED is a good
> offer for developers configuring their kernels.
> 
> Also, the differences of needed user-space features in an embedded system
> compared to a non-embedded system are probably difficult or even impossible
> to name in some generic way.
> 
> So it is not surprising that in the last decade hardly anyone has
> contributed changes to make something default differently in case of
> CONFIG_EMBEDDED=y.
> 
> Currently, in v6.0-rc4, SECRETMEM is the only config switched off if
> CONFIG_EMBEDDED=y.
> 
> As long as that is actually the only option that currently is selected or
> deselected, it is better to just make SECRETMEM configurable at build time
> by experts using menuconfig instead.
> 
> Make SECRETMEM configurable when EXPERT is set and otherwise default to
> yes. Further, SECRETMEM needs ARCH_HAS_SET_DIRECT_MAP.
> 
> This allows us to remove CONFIG_EMBEDDED in the close future.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ceec438c0741..aa154c20b129 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1068,7 +1068,13 @@ config IO_MAPPING
>  	bool
>  
>  config SECRETMEM
> -	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
> +	default y
> +	bool "Enable memfd_secret() system call" if EXPERT
> +	depends on ARCH_HAS_SET_DIRECT_MAP
> +	help
> +	  Enable the memfd_secret() system call with the ability to create
> +	  memory areas visible only in the context of the owning process and
> +	  not mapped to other processes and other kernel page tables.
>  
>  config ANON_VMA_NAME
>  	bool "Anonymous VMA name support"
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
