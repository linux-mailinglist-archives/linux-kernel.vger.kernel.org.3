Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1489E4C8CFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiCANy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiCANyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DA1749245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646142821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JsXxZXKDv01U5dexgfLVycNQs0qxk14GoYCt24oUx4=;
        b=T28Rpcv/G1dSWgbt4p9ses2M07dvJovW/f0pQnLFt9+kp8ZKtqcMK8k+g4HWJ0hzWys7At
        9C4SBvkjYSkxb92pv6GTPpYTwHppbXb+8r73lr70bRnh3h1K7Kf8mKGIsIbsLAsmubuNRX
        MTFF0ZhuBUHNp3Egm4PT8g/c7RNEHh8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-44n_TOBZN_SIrwq7CxodWQ-1; Tue, 01 Mar 2022 08:53:40 -0500
X-MC-Unique: 44n_TOBZN_SIrwq7CxodWQ-1
Received: by mail-ed1-f70.google.com with SMTP id o5-20020a50c905000000b00410effbf65dso7810148edh.17
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4JsXxZXKDv01U5dexgfLVycNQs0qxk14GoYCt24oUx4=;
        b=OCKjOBeWZhdJKvmAC9dVuWoxElCta67pDWMXZB17mcX7dGTmQGE+Tfv3XNz1lNKpPs
         G/LGVfN8OCnb197mgcJcoB4RDFXGKtKX1Pw6Jjfj3FddrQ9+qcShINm25BXD3Hff6GsC
         tTGxWmIGj3l+oJUeJD34UozedtiBhhImvpJI0XTY7035h+mTp1XFMTVbdoOPWJ29djf4
         sg4kz9Q4+WXiTfrUQxM2IieMhuehRvJuQWSYmAqf58tlkF1ZRrtF3ZfvmeHE1Yt1kyY/
         lGzwBBQ+qqLDxe4NHMaO3nij07x+o9E6RgbbbluWVH7aoxgMgoZZ5Pk/XM2Y+wj9qDsN
         mrYw==
X-Gm-Message-State: AOAM533c6tbJfnrz0aqlj44v6ofqyIh6aOEJnmRUVpYYBZAa1kBTGP09
        mj9IeY5scdubO5RmRNk2N/wMidF0qDV3WbxRxBabneb4NeSl+tY4snpzzwrtDKlBQ6C8dJbamTU
        OPC5BY7yPiRRuxONtWcmLAaQM
X-Received: by 2002:a17:907:1b15:b0:6d7:13bd:dd62 with SMTP id mp21-20020a1709071b1500b006d713bddd62mr631336ejc.673.1646142818916;
        Tue, 01 Mar 2022 05:53:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+7wwJDt0CZeqOsW2bZF2PxPiMWCe/whI0NQtaPVGhtQYydLl6dJs7AE0aMKqnDeiJeORgmw==
X-Received: by 2002:a17:907:1b15:b0:6d7:13bd:dd62 with SMTP id mp21-20020a1709071b1500b006d713bddd62mr631324ejc.673.1646142818749;
        Tue, 01 Mar 2022 05:53:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id ho12-20020a1709070e8c00b006ce3f158e87sm5329989ejc.2.2022.03.01.05.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 05:53:38 -0800 (PST)
Message-ID: <e5c6c5ad-ea72-2653-7d4a-8d31f8154543@redhat.com>
Date:   Tue, 1 Mar 2022 14:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220301201659.45ac94cd@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220301201659.45ac94cd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/22 10:16, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drivers-x86 tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   2546c6000430 ("platform/x86: Add Intel Software Defined Silicon driver")

Thank you for the report.

So I just did:

touch Documentation/ABI/testing/sysfs-driver-intel_sdsi
make htmldocs &> log

In a repo with drivers-x86/for-next checked out and checked the generated log files.
But I'm not seeing these WARNINGs.

Also 'find Documentation/output/ -name "*sdsi*"' does not output anything,
is there anything special (maybe some extra utilities?) which I need to also enable
building of htmldocs for the files in Documentation/ABI ?

Regards,

Hans

