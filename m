Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB3468A51
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 11:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhLEKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 05:25:46 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:11490 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhLEKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 05:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638699719;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=w29/FAlmYkr2r/ds8uAmjC9rizw3Oh2i6q43H5La4OI=;
    b=G+6prlYFUn/kyLrEcwnRIwoKT5Q/7dWCCECnoaayRVfVEmRM4dEx6ROxWBPF30tgrg
    jIRtSGQs/O1WQ0DkzmRSLJSLMiLLnI5TJbU+pN2x0kKjhivwxth+QVrTnOp8bNmn+Y5a
    Y+MBN+CGyf7kK9rcmvOHvPUIXU8gf0WYj/hNYXO/8T0UH0OnahSI3WYAwlEGloNMRGn+
    9REeXnoC/0SHdU7nrCpmtE/BTjBnqTQKuqt5hvMjiymhjB2AJiQEmOxHp8TbKTGSpumj
    Y3A8sPafErP7pILpdx+TlISK3kyVhukf3/m+GnpR+AOqOl3VTZGAfJe2TbYdOlVpqeku
    RS3A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJfSf8vUi"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xB5ALvu70
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 5 Dec 2021 11:21:57 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [security]  d3b04a4398: WARNING:at_crypto/kdf_sp800108.c:#crypto_kdf108_init
Date:   Sun, 05 Dec 2021 11:21:56 +0100
Message-ID: <3438006.aCxCBeP46V@positron.chronox.de>
In-Reply-To: <20211130080419.GC29514@xsang-OptiPlex-9020>
References: <20211130080419.GC29514@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. November 2021, 09:04:19 CET schrieb kernel test robot:

Hi,

...
> 
> 
> +------------------------------------------------------+------------+-------
> -----+
> |                                                      | d792134423 |
> |                                                      | d3b04a4398 |
> 
> +------------------------------------------------------+------------+-------
> -----+
> | boot_successes                                       | 14         | 0     
> |     | boot_failures                                        | 0          |
> | 16         | WARNING:at_crypto/kdf_sp800108.c:#crypto_kdf108_init | 0    
> |      | 16         | EIP:crypto_kdf108_init                              
> | | 0          | 16         |
> +------------------------------------------------------+------------+-------
> -----+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [ 18.648980][ T1] WARNING: CPU: 0 PID: 1 at crypto/kdf_sp800108.c:138
> crypto_kdf108_init (crypto/kdf_sp800108.c:136) [   18.649900][    T1]
> Modules linked in:

The issue is that the self-test fails for 16 out of 30 times, i.e. it is kind 
of random when it happens or not.

I am unable to reproduce it with i386 and clang-13. I can also not reproduce 
it with GCC.

Nor do I see an obvious issue in the code that points to either uninitizlized 
memory or otherwise could affect the test result.

I keep trying with Clang-14


Ciao
Stephan


