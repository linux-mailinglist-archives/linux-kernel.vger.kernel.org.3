Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB84C89A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiCAKtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiCAKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:49:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E0B117056
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646131744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3CH13mEtx+s7zAd9pvAc4Ds+9mZl1I9pkrvG59eNagk=;
        b=O9u40rl4NOurFbK7TZfxUsf7kDED+GFii2NR7xawEhUwalIA7ffdeYuRsbnbsmJOoMfMl/
        BoctC0i50Babt6HOwrHdu2uJP1aN45A3w2iQbtQIRLpburZ0DRXH1Rtjy+i8fJtx1F4UdA
        vIifcoEcOV5ETmOaUT905njOixrUetg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-t4YIcg3cODKaeCYknm1-Yg-1; Tue, 01 Mar 2022 05:49:03 -0500
X-MC-Unique: t4YIcg3cODKaeCYknm1-Yg-1
Received: by mail-ed1-f69.google.com with SMTP id e10-20020a056402190a00b00410f20467abso7565771edz.14
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3CH13mEtx+s7zAd9pvAc4Ds+9mZl1I9pkrvG59eNagk=;
        b=lm+s3I2mnhc/FFR09VJPuWdnZmLF8D1sFrFSxbI2K5kj3uKqhFuhh6/L6qj7DfV7rm
         Wh8MU49eaLjbOMDp2oCanpErUVpSnZNFoIZM7X9DX84DJ+97bA4cHNz+gjsQXuDj2XIF
         1kB/NYUVodAdNhuJkJvju3YsvzTkwzR0vHWY9QTvWaXP5e6dDXeCtnt/u2sLiWx4dL1b
         vqx10zwsn81afRyGCN0xLs7Te13R+Re5O6EjhruRWVZ22Ox02FrwEg7xzmqawUHylrjW
         oo4UAcveDt0+C4VsYgA5qWfRx+s1w5jr7bbVD+CsqFMZNwRa3aN9k79rz/WEVoUXBhor
         SR9g==
X-Gm-Message-State: AOAM530802jDO5OXsMxCPYf9OmMZyTpCYtuA4J3n1S8oL9ipioIv1mkq
        EsGv6HKHk+KpX8GRV7MURvwjgYpCceqzzM3V01FOYc51owe2OcAh22h+v5Nc5qt2HqX5rYbfL2V
        lzUiBKQ3knR0hdtYKDiGtgkUn
X-Received: by 2002:a05:6402:d51:b0:415:527d:efbd with SMTP id ec17-20020a0564020d5100b00415527defbdmr1546332edb.47.1646131742077;
        Tue, 01 Mar 2022 02:49:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+DbqfYyrIqIrT07aUu8KS4lAvUflv4og7L/arcDucj61lms2SYxNAFpuQcFAvrsfd0ZEYDA==
X-Received: by 2002:a05:6402:d51:b0:415:527d:efbd with SMTP id ec17-20020a0564020d5100b00415527defbdmr1546315edb.47.1646131741927;
        Tue, 01 Mar 2022 02:49:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm7183510edj.49.2022.03.01.02.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:49:01 -0800 (PST)
Message-ID: <63303f21-1f8c-396e-7e67-28e477d30244@redhat.com>
Date:   Tue, 1 Mar 2022 11:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <e9bfc654-5504-29ff-5a5a-b73f24691600@redhat.com>
 <CAHmME9oa4VQm7M0xsqCcy_0zaruhZarwodTyJEw0rtJnBskM=Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHmME9oa4VQm7M0xsqCcy_0zaruhZarwodTyJEw0rtJnBskM=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/22 11:38, Jason A. Donenfeld wrote:
> Hi Hans,
> 
> On Tue, Mar 1, 2022 at 11:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Thanks for the Ack. I still need Rafael's Ack to take this through my
> random.git tree, right?

Right.

> Or are you two one in the same when it comes
> to that? Trying not to step on toes if possible.

No, I'm the drivers/platform/x86 subsys maintainer and as such do a lot
with ACPI too, but Rafael is the ACPI subsys maintainer.

Regards,

Hans


