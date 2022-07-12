Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4B57219A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiGLROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiGLROk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 972C92E9E1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657646078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LWoZxmGBMuZPprfyc1QWNTPJ/dMjvswUT54ENVWGNc=;
        b=Bi2rTNHbySZcDTCswOUGJxjC49OrPBRVzOme6oGWlNaqTeOH9rxPpusfNlbsThEgIqdRn5
        KFMzbHBNjb7KDXw9edPyOr/IdBA8v4UlpqEjqCVjphqGOCNrsOQGepUw//djP4ZU7Bp0BH
        YQ7Gl8Ehv+bB6fGKxRc6lIeaPz92THw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-uJ0PfusUMdeTmIeMkywMXw-1; Tue, 12 Jul 2022 13:14:35 -0400
X-MC-Unique: uJ0PfusUMdeTmIeMkywMXw-1
Received: by mail-wm1-f71.google.com with SMTP id r186-20020a1c44c3000000b003a2daf644f9so6664232wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=6LWoZxmGBMuZPprfyc1QWNTPJ/dMjvswUT54ENVWGNc=;
        b=OJQbC3pQpLljhJn9zoUr8ul9Zj1FTo1pjtZE5rura5D5B40jPDFGp34rhIaj8cpuxY
         R9Ft4hUGvKlr2VgWT7T6fnIWYcfss2p/CH/b3ZcO7wQ2rM6s2D4OrzGgj76xlaelQYPL
         h85HvXvK5KQhKLQkGskMrZy0cQ0ZEuoxN2aSwcang8IMgmvZyG4UQx6k4yuQtZRKEqjP
         wzRElYQ4Yr+HCkSKS7beofiqnMJZeaGZhV6kcM7yMrJYkRxlAu7+AJkDVB4A6BBStd8l
         We3DmCVQ0Sp2oR7EqJ1ekxgvGmshvdFLR6XqhVgl2FcxgppM8Cg2/sJnR6X7R9dKDedL
         Ol6g==
X-Gm-Message-State: AJIora+HdFRpYR9pZ5tmsidVDHYWvapGVCZQSWfHReqbceKD1tHiSCqW
        jgJw+An9v/S92w878LzNEM5c7JkfhC/VPpiz0s5Q8I4A73BqTm7Gsp89WZYKL+5vgxyceocSddE
        jqRpBDWijXo1ejBYuS7Ojwn0=
X-Received: by 2002:a5d:6d0e:0:b0:21d:6d4c:e0e4 with SMTP id e14-20020a5d6d0e000000b0021d6d4ce0e4mr24192055wrq.355.1657646074497;
        Tue, 12 Jul 2022 10:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v2F0cZX1TI83MjeQF5zCeIy2jw6sxxjhgQt61Lv57WOfETN0CAXdHA7iZyl7plmECX4COjcA==
X-Received: by 2002:a5d:6d0e:0:b0:21d:6d4c:e0e4 with SMTP id e14-20020a5d6d0e000000b0021d6d4ce0e4mr24192032wrq.355.1657646074266;
        Tue, 12 Jul 2022 10:14:34 -0700 (PDT)
Received: from [192.168.9.27] (net-2-34-30-100.cust.vodafonedsl.it. [2.34.30.100])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe786000000b0021b9504cc83sm8788767wrm.31.2022.07.12.10.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 10:14:33 -0700 (PDT)
Message-ID: <1aec7d55-24d5-e9bc-9052-728335ec7d9d@redhat.com>
Date:   Tue, 12 Jul 2022 19:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     matthew.gerlach@linux.intel.com
Cc:     basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        hao.wu@intel.com, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
References: <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-07 17:05, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add documentation on identifying FPGA based PCI cards prompted
> by discussion on the linux-fpga@vger.kernel.org mailing list.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3: Add url to page tracking PCI ID information for DFL based cards.
> 
> v2: Introduced in v2.
> ---
>  Documentation/fpga/dfl.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..5144775b860a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -507,6 +507,27 @@ ids application.
>  https://github.com/OPAE/dfl-feature-id
>  
>  
> +PCI Device Identification
> +================================
> +Since FPGA based PCI cards can be reconfigured to a perform a completely

There's a small typo: "to a perform" --> "to perform"

> +new function at runtime, properly identifying such cards and binding the
> +correct driver can be challenging. In many use cases, deployed FPGA based
> +PCI cards are essentially static and the PCI Product ID and Vendor ID pair
> +is sufficient to identify the card.  The DFL framework helps with the
> +dynamic case of deployed FPGA cards changing at run time by providing
> +more detailed information about card discoverable at runtime.
> +
> +At one level, the DFL on a PCI card describes the function of the card.
> +However, the same DFL could be instantiated on different physical cards.
> +Conversely, different DFLs could be instantiated on the same physical card.
> +Practical management of a cloud containing a heterogeneous set of such cards
> +requires a PCI level of card identification. While the PCI Product ID and
> +Vendor ID may be sufficient to bind the dfl-pci driver, it is expected
> +that FPGA PCI cards would advertise suitable Subsystem ID and Subsystem
> +Vendor ID values. Further PCI Product, Vendor, and Subsystem id tracking
> +can be found at https://github.com/OPAE/dfl-feature-id/blob/main/dfl-pci-ids.rst.
> +
> +
>  Location of DFLs on a PCI Device
>  ================================
>  The original method for finding a DFL on a PCI device assumed the start of the

Marco

