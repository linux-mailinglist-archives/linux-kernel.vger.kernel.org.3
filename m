Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25351D5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391070AbiEFKra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391058AbiEFKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:47:24 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAE88674E9
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651833820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMQXo3cnYgdSGZtZpKkyGl/T8WZO8ymEMiHkJONI6aE=;
        b=Ro6Iujz37aUyXGOMBBwhtCj8D+LOcqIZFQcmC5YpWz8A3me5fpn9nvRulawMly4hEokrt/
        mA1Q1hahZOJq3YnkjDsaIVdkj0yvlTmgcBFRUUCbfaYNCIMg5YzO525v/VgLDCbBWB3lkg
        qaeeTmuOClHpVbqpdvnCkqsUT+OytJU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-v-vsW5oaP_2hxUXRCZLbBw-1; Fri, 06 May 2022 06:43:39 -0400
X-MC-Unique: v-vsW5oaP_2hxUXRCZLbBw-1
Received: by mail-ed1-f70.google.com with SMTP id l24-20020a056402231800b00410f19a3103so3810525eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kMQXo3cnYgdSGZtZpKkyGl/T8WZO8ymEMiHkJONI6aE=;
        b=dZHDOl5fAd+IlgTBUst2lwbRdh6Lefoe0J7OegZar6dxYI+ehmtqWjerotpxHEnP4b
         3XeM7AaL5A5qUVIt0bQ53oAJjEobRQXshwgrFh9Hcs9wXK+CbDw+eyU9DBFewHCX+BHM
         DaWylWEdsR/tcqX52wTfNVI/krUD47Dz8+7uob4DOA2hJV4RlIjJMbKz2dM1nwyFqkju
         7tKJl9j4RyYqI9WV3/DDOdfNNRh1eeq8dij7BPRoBIH6fMK+L2TWY3+TBcEK5ejKghiZ
         10m5wX6VYe0kj1xHBBMz8AQU4xuRb2HgGIs+P4K9T3qEf9jeyTsjcTWTw6Yww1aHFNxJ
         7xqA==
X-Gm-Message-State: AOAM530EIMHxmqy1ETs/3DfuS5zJtEnQ4eKdFS1Jc9nITXQCTHB2T6kV
        6wam+vyAE49W6B9zQVbWySOK2IouKG4HOe1y/TpCLDtSe2+lFD2nsVAsjxXT0kEbpwW9b/rz8pE
        uKNSl4kGQswSKnC1kMHZ5YPwd
X-Received: by 2002:a05:6402:5286:b0:425:f0fb:5d23 with SMTP id en6-20020a056402528600b00425f0fb5d23mr2689865edb.243.1651833818608;
        Fri, 06 May 2022 03:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZTE0uRg4uU87MZ9mD5uG+ERThe0GHe4ZMXBFFDI5DcMXMQU/nUPpLZEa/sYlzlo2p0AVsAQ==
X-Received: by 2002:a05:6402:5286:b0:425:f0fb:5d23 with SMTP id en6-20020a056402528600b00425f0fb5d23mr2689854edb.243.1651833818449;
        Fri, 06 May 2022 03:43:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d25-20020a056402145900b0042617ba63b2sm2122401edx.60.2022.05.06.03.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 03:43:38 -0700 (PDT)
Message-ID: <f56a64f4-da3a-7b77-58f9-598e294772fd@redhat.com>
Date:   Fri, 6 May 2022 12:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/4] platform/x86: pmc_atom: dont export pmc_atom_read -
 no modular users
Content-Language: en-US
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <20220428062430.31010-4-paul.gortmaker@windriver.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220428062430.31010-4-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/28/22 08:24, Paul Gortmaker wrote:
> There is only one user of pmc_atom_read in tree, and that is in
> drivers/acpi/acpi_lpss.c -- which can't be anything but built-in.
> 
> As such there is no point in adding this function to the global symbol
> list exported to modules.
> 
> Note that there is no <linux/export.h> include removal since the code
> was getting that header implicitly.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/pmc_atom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index 31cf25d25d66..b8b1ed1406de 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -221,7 +221,6 @@ int pmc_atom_read(int offset, u32 *value)
>  	*value = pmc_reg_read(pmc, offset);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pmc_atom_read);
>  
>  static void pmc_power_off(void)
>  {

