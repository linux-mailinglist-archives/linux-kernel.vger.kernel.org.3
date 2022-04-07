Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD04F7B25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbiDGJN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbiDGJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65AE837019
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649322660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgXF00+JuF+RWxEt+WQf0O5z5H+vsdEWkFDyAJB6Ijw=;
        b=EBrCONSAvrZjOwBm14YibYdRTzHFlb5iTPCKJzKrJuoPGz352LSiY7CWr7wLCZ+vetHHp1
        FIIAEIzhtDjmpl5trQDvTz2t4eg9SkfUHYhPl2boxc4ZaKRYFgkHjHYJK/aLuQnI8Xy6GT
        72BD35KpL8vGfC5Gmrz0U/6HIwlnf+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-K86I0Us4N_C5Y11LHpoanA-1; Thu, 07 Apr 2022 05:10:58 -0400
X-MC-Unique: K86I0Us4N_C5Y11LHpoanA-1
Received: by mail-wr1-f71.google.com with SMTP id l22-20020adfa396000000b0020612097035so1061884wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FgXF00+JuF+RWxEt+WQf0O5z5H+vsdEWkFDyAJB6Ijw=;
        b=H6jkxB0RKcPrCstwmnIq4IiuYN5FsPGnp8spsmrf2HVglQAgFu4c1/4lWvtL0NxEVb
         HFqy27Mm8AodCW3oWTESkOnK9VVksbXpe8X57S+CNwCevi8p49YBWL6lWo3x0lwXuS1X
         WLb1CZnYHMgu53UG8qVh3godBWkLmzljMjyW06Dwp/pJWmbTPbQUj5sj7t7hR4fI0av+
         Xzpz4+EiYNALGJI+kCEbZY7RR1KYQ13ICiVBONRVEpOTBoI4Ev6AVd/PmvVFL3AqGg0g
         aZ4BlxPr1fnQiHRSCK+74sfkK3XIMBlgtcrA2v6CuXakHTSrdjAyDomHLekBpkJb4uDp
         LlJg==
X-Gm-Message-State: AOAM53266Kh6hKcul8U20c13D9gRN1flYsBdNHEw7gpwgG4sxrI8fnsC
        gRBapacIGG6DbBM+SMA3ud/YgiKssPOAkULbKf7eTWrHMRhITo706tx9D9g+WEUnQ9Am6JX7DHV
        wCVLGMnIXPmkKbSW5davSELVRLFrQZSZSkdNrAMhdFpxq9jwQNIzEK0cotA3hjdteatyENVkcw9
        g=
X-Received: by 2002:a7b:c382:0:b0:388:2e76:49ed with SMTP id s2-20020a7bc382000000b003882e7649edmr11521064wmj.195.1649322657174;
        Thu, 07 Apr 2022 02:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw26/RKx41KOWBhiaIeMjzf0jMWUg3ym+Vw/w0y8Kg/lKx4S5ltqf5t2m1WmWmgCTWCtfXB+Q==
X-Received: by 2002:a7b:c382:0:b0:388:2e76:49ed with SMTP id s2-20020a7bc382000000b003882e7649edmr11521042wmj.195.1649322656937;
        Thu, 07 Apr 2022 02:10:56 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm18903341wrs.73.2022.04.07.02.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:10:56 -0700 (PDT)
Message-ID: <a3cb05a6-20c7-47af-3cca-ae225f56be85@redhat.com>
Date:   Thu, 7 Apr 2022 11:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND RFC PATCH 2/5] firmware: sysfb: Add helpers to unregister
 a pdev and disable registration
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220406213919.600294-1-javierm@redhat.com>
 <20220406213919.600294-3-javierm@redhat.com>
 <Yk6plGLa+uOb0ZyJ@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yk6plGLa+uOb0ZyJ@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 11:06, Daniel Vetter wrote:
> On Wed, Apr 06, 2022 at 11:39:16PM +0200, Javier Martinez Canillas wrote:

[snip]

>> +}
>> +EXPORT_SYMBOL_GPL(sysfb_try_unregister);
> 
> Kerneldoc for these plus adding that to
> Documentation/firmware/other_interfaces.rst would be really neat.
> 
> With that added Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>

I will, thanks for pointing this out.
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

