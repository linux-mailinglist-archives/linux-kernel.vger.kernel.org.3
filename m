Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75D4573F66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiGMWHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiGMWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A07D45074
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657750038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GNtNspQ7ufX/7l3qNBxVep1F3AGBAOu1ulHpdR7LRfc=;
        b=eMH3fzrwLZvUtjEn+nUJCk5GQN3A2gsS2iZpt63Xlq3U2PqF70BeniCEWYGH1EAh0935j0
        hJvVpXQ81ENa58uHv6/MQddOzsACnKO8Q01rIZltsT/yON7Wvb9Y06THLdGWK9FgOgzK+T
        mF9fUnjqKSBstShar5GVHihUENM7q5U=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-6R_NDYMUNUOhDqWaPUWV9g-1; Wed, 13 Jul 2022 18:07:17 -0400
X-MC-Unique: 6R_NDYMUNUOhDqWaPUWV9g-1
Received: by mail-ot1-f70.google.com with SMTP id z4-20020a9d71c4000000b0061c59fd62e9so3306292otj.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GNtNspQ7ufX/7l3qNBxVep1F3AGBAOu1ulHpdR7LRfc=;
        b=Tq7hFT0+xzu22t2TD/p7QPK6xYEII6Y5QedOBNWcnuJwB7fQ5ptg/Z0/n5FeKgcxPG
         2ey0Q4WGVyHM9ICsFF+B2VliPd8r5YJkj/YWgW6SF6Mp6lS/mQbrnQ1p2Z64E2QLKL7b
         7sLWL6F5UQhS1LYkYUiLqNm8rmPlgjrbfQpcgCRBxcba1YJ6mhR4/4tnX/DsqXzjLpe9
         RqF/6o8jCzWOISqnqGwBaUS2r/B6BKX6+jaAFrYCELtUi0K/mZQmnOZlp3pS1TXltFZW
         pcMP/tRLmz2Fo5i3OaFo+YgRDPMvU0qgZuNug0jFFM4DTfUTR9tzNnEnjzDYd+M73nvA
         JIvw==
X-Gm-Message-State: AJIora/esmkIUNovvv13r82NDyywjFAulcZdqTaYWuUYCSG3OCl8Yt3W
        8pGp4SpJFvdQfh2f4FtfpZDuJFyNdLgBsScoWNEASgWEO6/ICDabeB5AKMiCtwBApVEm6LTX6tE
        7xF5rPykSm4nYiSTqOftLqwJ1
X-Received: by 2002:a05:6808:140d:b0:339:e00e:afb1 with SMTP id w13-20020a056808140d00b00339e00eafb1mr2825668oiv.81.1657750036213;
        Wed, 13 Jul 2022 15:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEvFxl9rP9NFV64gFM86/GXbJZARS8v3Lv8M/gTEDUsgw0YivueIDmJYq2iS+M92gnYHJu7A==
X-Received: by 2002:a05:6808:140d:b0:339:e00e:afb1 with SMTP id w13-20020a056808140d00b00339e00eafb1mr2825658oiv.81.1657750036026;
        Wed, 13 Jul 2022 15:07:16 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bu27-20020a0568300d1b00b0061b8653b0c9sm34031otb.22.2022.07.13.15.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 15:07:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org, corbet@lwn.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com
References: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
 <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8180679b-1d71-a527-74f2-d77460ea9902@redhat.com>
Date:   Wed, 13 Jul 2022 15:07:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220707150549.265621-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/22 8:05 AM, matthew.gerlach@linux.intel.com wrote:
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
>   Documentation/fpga/dfl.rst | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..5144775b860a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -507,6 +507,27 @@ ids application.
>   https://github.com/OPAE/dfl-feature-id
>   
>   
> +PCI Device Identification
> +================================
> +Since FPGA based PCI cards can be reconfigured to a perform a completely
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

This link looks good.

It may be good to be explicit and say which device(s) needs to be 
specified by the quadruple.

Reviewed-by: Tom Rix <trix@redhat.com>

> +
> +
>   Location of DFLs on a PCI Device
>   ================================
>   The original method for finding a DFL on a PCI device assumed the start of the

