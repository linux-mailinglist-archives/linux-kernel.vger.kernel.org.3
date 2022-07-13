Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12304573DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiGMUR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiGMUR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:17:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8F22BC6;
        Wed, 13 Jul 2022 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9Wcc0tnUWuhMwDtUJfA83M3JEIXXsxqrnG5T3WeXGlI=; b=ylKR751Nlw5SlX6sIj0I6X5ioI
        HNzukDDjfTlW7DjWoeCNySJzXeK0nV7aZAiZfHQUnr1auhkjIKy5fab+SNBYaFJAEOxKuz9cI033Q
        UW1aYpm/bd+/ne1o1tRnHhIGhZ8KlaIjgbUjg6/P4Oi5pAaRFdw+epCfa61JccCV4Wbrw4kEc/6lk
        Hn0hax/5fx0xEHLUdl/MOUkOxf1bzYwe0DVOIqKCKK0RRi+HuRKwJ18VPgcuOtXYgUs8V2kwIeLAa
        /PnApMjXzu6AnJaRoUzfC4wJ4AQ8FTssC6U++sfoF3D4FDKOcpzKBTVAgeZml5O04ID6cvtRm9sF4
        pwfgBL1g==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBina-007cpf-Sq; Wed, 13 Jul 2022 20:17:30 +0000
Message-ID: <e6232bb4-a8e5-8f33-e80e-06b1356565b7@infradead.org>
Date:   Wed, 13 Jul 2022 13:17:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/4] pseries/mobility: set NMI watchdog factor during
 an LPM
Content-Language: en-US
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        wim@linux-watchdog.org, linux@roeck-us.net, nathanl@linux.ibm.com
Cc:     haren@linux.vnet.ibm.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220713154729.80789-1-ldufour@linux.ibm.com>
 <20220713154729.80789-5-ldufour@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220713154729.80789-5-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 7/13/22 08:47, Laurent Dufour wrote:
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ddccd1077462..d73faa619c15 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -592,6 +592,18 @@ to the guest kernel command line (see
>  Documentation/admin-guide/kernel-parameters.rst).
>  
>  
> +nmi_wd_lpm_factor (PPC only)
> +============================
> +
> +Factor apply to the NMI watchdog timeout (only when ``nmi_watchdog`` is

   Factor to apply to

> +set to 1). This factor represents the percentage added to
> +``watchdog_thresh`` when calculating the NMI watchdog timeout during an
> +LPM. The soft lockup timeout is not impacted.
> +
> +A value of 0 means no change. The default value is 200 meaning the NMI
> +watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).

-- 
~Randy
