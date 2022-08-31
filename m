Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708AE5A8103
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiHaPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00287E00A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661959008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0xifggWWVXyqkkAAWgCH5K33dRfapcSInzbE22dq0k=;
        b=R4f3+iOEzqadFqHa8cjyFa55pcu1S4/LvFe/afyP46K40OhwMk8sb8hyG20YRbAJoo7rl7
        eBXFWKpkUzdnOWqTH0aQu1cvnBzzrCLC0z/WwduWX85WdeUU/iauWq5MKIo3mDCb4Yj2oV
        eBNvsKlL6zWdOmONBjSoIoJoTTR1H7k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-nqhWktEAONeIwgEzRN5r0w-1; Wed, 31 Aug 2022 11:16:46 -0400
X-MC-Unique: nqhWktEAONeIwgEzRN5r0w-1
Received: by mail-ed1-f71.google.com with SMTP id r11-20020a05640251cb00b004484ec7e3a4so6911448edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=e0xifggWWVXyqkkAAWgCH5K33dRfapcSInzbE22dq0k=;
        b=3pYWqoDXBaiLRh/gl4z5FzgDyEUucDfZmG9GjBNJg1+hYlKSZDmZ8gWzVdYkqHSxeJ
         ZQN1r0OiIRtCCoxsnuArbvwchbmbN5pUBf6RCSuqHmRYMmh/T5NHCG29TmPxfRHUNymK
         mh6m1MtfFuXJvKAo9w1c8ZwMqGFX2cmPA3AbsArIDfSuHMN1OpMMxBX/+jT7A9bw9M3x
         7Kkvm899RqFQeGtR0p2v3xdkMB1wQpRODiy1fJ6p4Imr0ZhWSdG/YPUSP6EXbn7NguHH
         2c4HrraXTYoB1cUstR/+Pf4g7LVKYgSSV+Ch562YMFadqsv3QhzSKi7vxd/qy+DSerr0
         CANQ==
X-Gm-Message-State: ACgBeo1buqrfuYNQsDs/pqKl/W4UoWkCQM3sKmRMgNb2i9vVAucZrQVW
        eQvQxHYLbEUY/fAhhCyef2qImJn9PX/zdfTq3/f1+0OIkeTTEggY5zZJjx01576aEqbQZZBnp26
        U3U8oow1i+4bQ9CIEvC06CoOK
X-Received: by 2002:a17:907:968d:b0:741:5d55:e501 with SMTP id hd13-20020a170907968d00b007415d55e501mr13353104ejc.449.1661959005203;
        Wed, 31 Aug 2022 08:16:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6V+akHnnsYaO06t426lFF4ZrUc7b7phUa9GsHReHWCCzfJw8cqILu7eNd1LmGLN4cBIMbY9g==
X-Received: by 2002:a17:907:968d:b0:741:5d55:e501 with SMTP id hd13-20020a170907968d00b007415d55e501mr13353095ejc.449.1661959005024;
        Wed, 31 Aug 2022 08:16:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id rl26-20020a170907217a00b0073db043a6f7sm7206294ejb.210.2022.08.31.08.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 08:16:44 -0700 (PDT)
Message-ID: <8b4547ca-6859-20b8-595b-759830bbe54a@redhat.com>
Date:   Wed, 31 Aug 2022 17:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/1] platform/x86: intel_cht_int33fe: Fix comment
 according to the code flow
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20220824152115.88012-1-andriy.shevchenko@linux.intel.com>
 <Yw9tIAObVXvLcg+v@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yw9tIAObVXvLcg+v@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/22 16:16, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 06:21:15PM +0300, Andy Shevchenko wrote:
>> We don't use software_node_register_nodes() in the code, fix the comment.
> 
> Any comments?

No, I just have a bit of a patch backlog to process,
I'm trying to process the backlog in FIFO order and
I have not gotten around to this one yet.

Regards,

Hans

