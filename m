Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B114FBF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbiDKOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245412AbiDKOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E3C6C03
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649687918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JK8TKPeiyxEXuySdlAaQF1ZMqCXVr2+cAzKpkD5p+PE=;
        b=OZhLcUJEXUM0dsdhDNgWobz9AabKcfVqBHPX80IolCJY6e0ugsEc5AHDyfNlYSpVe5R8vK
        eYlcHMOFoc/AnYdxjR2D8QQrf0/MfTkNMdWUhgM+0nzo0dclVNupY0j1r85BXAX9SECaKQ
        PaE53S4hkLKazCDSoP52MXKwpAZ/IBM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-93fGb9BMMLKCHmTr0v5_1w-1; Mon, 11 Apr 2022 10:38:36 -0400
X-MC-Unique: 93fGb9BMMLKCHmTr0v5_1w-1
Received: by mail-ed1-f69.google.com with SMTP id cn27-20020a0564020cbb00b0041b5b91adb5so9179571edb.15
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JK8TKPeiyxEXuySdlAaQF1ZMqCXVr2+cAzKpkD5p+PE=;
        b=LH8oLfxpyHs1g75ISS/KaXYqBlav+Z8u3gAf7N4CZz1iojP/LfyY7cVLdzlnUnrUdQ
         iXAMZjlyILDmzviWaIYhBSXVEQuitxxwQ9oLSwuyJVZo7A4ho0wPr38mlrdYWKN8htBA
         NJ53Fe27wUzN3nDrxtyjmBTq8uqTJxA5qzDlXsBJulJubWYdaDIvdHtD1YPZRC9KHIMo
         IvNz123pBnbGCF+LKV9REwNSWBxwwzYp7KOAVyt/gx+4ypNyfiVruJkpxJtMy57KiDGH
         19a0nR5MzNBM3fehCJgRLmofSJHJsnJzeV0j6X8dwzHvSCHLwYmCwwV55PPUc0ptj6RN
         Yt6w==
X-Gm-Message-State: AOAM532bK4vnNa1C0r7JnFp/5AQzOsexDLKhmDB+KbyA2FvTYHJ1PYVq
        OtskYG9V/zOt2VzF5e2ki5rPmVjri8qPFP7GxPv2Brc2N+jFWUL3IKpWz2mxMesvB/Ea4bcTzzf
        YWdV6v3InNwPrIfG/QyBvNgiv
X-Received: by 2002:a17:906:1c0d:b0:6e8:94a5:c5d6 with SMTP id k13-20020a1709061c0d00b006e894a5c5d6mr3955157ejg.134.1649687915166;
        Mon, 11 Apr 2022 07:38:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLuvc5BS9rb+kgcbCN++QKhhBHdOIePF/MfbCeD2ZyVqKeiu79VBWOfFyf8VZTBybMX2u2Og==
X-Received: by 2002:a17:906:1c0d:b0:6e8:94a5:c5d6 with SMTP id k13-20020a1709061c0d00b006e894a5c5d6mr3955140ejg.134.1649687914988;
        Mon, 11 Apr 2022 07:38:34 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id gv9-20020a170906f10900b006d7128b2e6fsm12056991ejb.162.2022.04.11.07.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:38:34 -0700 (PDT)
Message-ID: <47d06f45-c1b5-2c8f-d937-3abacbf10321@redhat.com>
Date:   Mon, 11 Apr 2022 16:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 5/6] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
 <054b22e81e88379a5a8459c19e89a335531c1bdd.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
 <8308a830-3096-3f94-4f12-5fd2c290524e@redhat.com>
 <aece84e1-2c90-2c18-993a-96f8fed7bb46@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <aece84e1-2c90-2c18-993a-96f8fed7bb46@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/4/22 21:56, Sathyanarayanan Kuppuswamy wrote:
> Hi Hans,
> 
> On 4/4/22 3:07 AM, Hans de Goede wrote:
>>> +static int __init tdx_attest_init(void)
>>> +{
>>> +    dma_addr_t handle;
>>> +    long ret = 0;
>>> +
>>> +    mutex_lock(&attestation_lock);
>>> +
>>> +    ret = misc_register(&tdx_attest_device);
>>> +    if (ret) {
>>> +        pr_err("misc device registration failed\n");
>>> +        mutex_unlock(&attestation_lock);
>>> +        return ret;
>>> +    }
>> Why not do this as the last thing of the probe?
> 
> We need misc device reference in dma_alloc_coherent() and
> dma_set_coherent_mask() calls. This is the reason for keeping
> misc_register() at the beginining of the init function.

Erm, you are supposed to pass an actual device-device as
parameter to dma_alloc_coherent(), so that it can see
what bus/dma-domain the device is connected to and if
an ioMMU might be involved...

>> That will avoid the need to unregister this again in all
>> the error-exit paths and also fixes a possible deadlock.
>>
> 
> Agree. But, unless we create another device locally, I don't
> think we can avoid this. Do you prefer this approach?

Yes, passing the "struct device" which is embedded inside
a miscdevice as device to dma_alloc_coherent() is just
wrong. Please make your module_init function register
a platform_device using platform_device_register_simple()
(on systems with TDX support) and then turn your code/driver
into a standard platform_driver using the platform_device
which the driver binds to as parameter to dma_alloc_coherent().

See: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=c4d2ff35d350428eca2ae1a1e2119e4c6297811d

for a simple (completely unrelated) driver which uses this
method to have a device to bind to for talking to a secondary
function of the embedded-controller on some platforms.

Regards,

Hans

