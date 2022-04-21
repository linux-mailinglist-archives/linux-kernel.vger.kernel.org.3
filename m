Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A8509F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347647AbiDUL4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiDUL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:56:28 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700152E690
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:53:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x12so3009544qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PT4LXQBfLiBOJRTfBJYUYM3WIFjfmxtBkNM0mqiYix8=;
        b=YzRMCim8hi+BV5bLrRa6UuBuCUpXby6fe49piTZ/rxGtlpkUfvJ355BuHU/hHqBXLk
         FpuyFzc5G5cST+1cCxTyFWGqOkXkuO5w6V8MI/itLH1es3N0fsKi/hAs++h6lGPdC1HL
         9i6BJJ5f9BGT7ZovIAjdIVbT1qORO6dM67dpEmUaSvOOi+c2NKQ8doUJ9sAyB+MKMWnS
         cgqUYMKYLy30WdsI+NbgW29mbNRY4YQrqW9gVL4uPoJRjMk/Xsg+H3x4mKbrIWb8wvBT
         xOH2+xs7SMOShskwzd3Ev1bIXou/gY7DK7CU3chZGp8BO/aQPzJEGJomE4sQUzrOAK/k
         mNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=PT4LXQBfLiBOJRTfBJYUYM3WIFjfmxtBkNM0mqiYix8=;
        b=qUPfuxX0MfzhBdwuQSfT4gaCwwnb7ioOLIn/UFk57NqUAl2ZpZnaF+m9aXWtV95zU1
         zy0sOEyhyF++0evPOIiPyWeSNOWO3XM7ez73+vpiHBDhX+rMwvKvPMLC6wVeUqU1VyvN
         pzeqcRem/LZecPVDG8iVPBRlDZujCuAKxU4YCUJfTzZxJMAo4WSNz1mBSoGPMFzuEC0m
         SWLrKUeuMVRY1OP4oENa8vXZq42pR1gV9CT8pGTpkXfpMzDWNgg618DMrwQQCzs+QUh9
         LVaO2DpvvL/xvYOk4MrkvX9uoKsVRhwVgqsiplHA3NUGKq/XwgAlV3PSBH8y1mXQEuse
         JRWQ==
X-Gm-Message-State: AOAM533lBB0vCTH3un2R09SZhvasHe1m2JLRNqrghIZXtKlT/Ibdta6F
        uuCWRTIhdopefj74j2XyJp4AuC2X2y5n
X-Google-Smtp-Source: ABdhPJyD1deq/S91ZjUCxXT/nCjxV0i6aTWnkq7PKitz0Nn3z+sEmfKUTSRdqkNno0xncz1o0dMLhA==
X-Received: by 2002:ac8:7d90:0:b0:2f3:4446:303f with SMTP id c16-20020ac87d90000000b002f34446303fmr4027883qtd.218.1650542015460;
        Thu, 21 Apr 2022 04:53:35 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id k2-20020a37ba02000000b0067dc1b0104asm2780044qkf.124.2022.04.21.04.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 04:53:35 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:a578:422:b82d:51be])
        by serve.minyard.net (Postfix) with ESMTPSA id 18B6B1800BB;
        Thu, 21 Apr 2022 11:53:34 +0000 (UTC)
Date:   Thu, 21 Apr 2022 06:53:32 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ipmi: ipmi_ipmb: Fix null-ptr-deref in
 ipmi_unregister_smi()
Message-ID: <20220421115332.GZ426325@minyard.net>
Reply-To: minyard@acm.org
References: <20220421100835.1942677-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421100835.1942677-1-weiyongjun1@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:08:35AM +0000, Wei Yongjun wrote:
> KASAN report null-ptr-deref as follows:
> 
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:ipmi_unregister_smi+0x7d/0xd50 drivers/char/ipmi/ipmi_msghandler.c:3680
> Call Trace:
>  ipmi_ipmb_remove+0x138/0x1a0 drivers/char/ipmi/ipmi_ipmb.c:443
>  ipmi_ipmb_probe+0x409/0xda1 drivers/char/ipmi/ipmi_ipmb.c:548
>  i2c_device_probe+0x959/0xac0 drivers/i2c/i2c-core-base.c:563
>  really_probe+0x3f3/0xa70 drivers/base/dd.c:541
> 
> In ipmi_ipmb_probe(), 'iidev->intf' is not set before ipmi_register_smi() success.
> And in the error handling case, ipmi_ipmb_remove() is called to release resources,
> ipmi_unregister_smi() is called without check 'iidev->intf', this will cause KASAN
> null-ptr-deref issue.
> 
> Fix by adding NULL check prior to calling ipmi_unregister_smi().

This bug is valid, but I'd like to fix it another way.  General kernel
style is to allow NULL to be passed into these sorts of things and just
return if it's NULL.  So I've fixed it that way.  Fix is in linux-next.

Thanks,

-corey

> 
> Fixes: 57c9e3c9a374 ("ipmi:ipmi_ipmb: Unregister the SMI on remove")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_ipmb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> index b81b862532fb..ea8fdb5ecfc9 100644
> --- a/drivers/char/ipmi/ipmi_ipmb.c
> +++ b/drivers/char/ipmi/ipmi_ipmb.c
> @@ -437,7 +437,8 @@ static int ipmi_ipmb_remove(struct i2c_client *client)
>  	iidev->client = NULL;
>  	ipmi_ipmb_stop_thread(iidev);
>  
> -	ipmi_unregister_smi(iidev->intf);
> +	if (iidev->intf)
> +		ipmi_unregister_smi(iidev->intf);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
