Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F464E3D92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiCVL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiCVL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC5F250E27
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647948487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+jhixLNd1tRMna7dh1+LfmeYG7qSf04xnYLrG1y2sk=;
        b=B+ZfJdpRkDfWIerxoDJy/8OAK+y0PTTku91uErRc3mv2WjdfY7HfAfhimJjldekvvy/Kfx
        AEfx0Be9LjucJnZzeqw9FVHH0OGmev+j66seUwt5vWsFgjXyFBYX4Wvwr56uojMjmVEHCt
        pdXsF8VboDjM0E6jwlHLwL6ZNqA/3sw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-F8pI9IjCOqO0JQQZ1exDMg-1; Tue, 22 Mar 2022 07:28:06 -0400
X-MC-Unique: F8pI9IjCOqO0JQQZ1exDMg-1
Received: by mail-ed1-f70.google.com with SMTP id x1-20020a50f181000000b00418f6d4bccbso8671331edl.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q+jhixLNd1tRMna7dh1+LfmeYG7qSf04xnYLrG1y2sk=;
        b=LqKQBhRf3MUj21wvtrHK/ys9qY6Bv2Hx9mXBwaDjbS8t+xYFNjH/g8Gjw53hHjx3oC
         jAFabtAizv188K8OGF+Hm6kg1nNBglw5ImGqIjZBYQIKRkAZQ1xmQFp6tLV/uucDZhC5
         koJikRiEdtVcpV3FSpsLqrYzztHAU9F3bG3XpG2BlZv7+dx5NFuDNCTlxJm/v0oMZUMN
         4Tw7MsaEK0hTHNNn9JJn+IxMpHP8nf2DBfPpG+7W6LqyhmN9ShSn2i0SLr7areYS5wo2
         5nzfW57dMTvkhajnwrR2oeduLZSGHTop22t5TKlKc51r41w0hnT7sJ+lHTU+iLY3uXC6
         xp6Q==
X-Gm-Message-State: AOAM532NxGh5OIi7hh3pGK1T8scTb9I4n/Bcm+qXAWVMONS/czKih36w
        Ox/nwVAXxY5459MMfSketCmy1WouJr+a6GHR6t2NIXHY/m58ivkM3fzCXr36KBkZUgre8T1deKT
        BJ5p5NmiaCYgNOLZdpgitw7ec
X-Received: by 2002:a17:907:d27:b0:6db:d928:a976 with SMTP id gn39-20020a1709070d2700b006dbd928a976mr25568345ejc.24.1647948485122;
        Tue, 22 Mar 2022 04:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2bepHW/hyW/QTus5y1cUM5hn6N7HT+obrJXolK8tngaQAWnUO5hZvqxvEUkQC1cLxQp5IsA==
X-Received: by 2002:a17:907:d27:b0:6db:d928:a976 with SMTP id gn39-20020a1709070d2700b006dbd928a976mr25568313ejc.24.1647948484720;
        Tue, 22 Mar 2022 04:28:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id og49-20020a1709071df100b006db0dcf673esm8324139ejc.27.2022.03.22.04.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 04:28:04 -0700 (PDT)
Message-ID: <f4b82d3d-5c8b-2973-4918-5308210e4431@redhat.com>
Date:   Tue, 22 Mar 2022 12:28:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] winmate-fm07-keys: Winmate FM07/FM07P buttons
Content-Language: en-US
To:     Daniel Beer <daniel.beer@tirotech.co.nz>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6237f057.1c69fb81.1689.fec7@mx.google.com>
 <2cf4e8b2-dfaa-dd7d-9c00-c7d58eeb367b@redhat.com>
 <20220321193258.GA31646@nyquist.nev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220321193258.GA31646@nyquist.nev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/21/22 20:32, Daniel Beer wrote:
> On Mon, Mar 21, 2022 at 11:22:40AM +0100, Hans de Goede wrote:
>> Do you have control of the firmware on this device?
>>
>> If yes then IMHO it would be better to implement this in ACPI
>> using the intel-hid fw API for this, see:
> 
> Hi Hans,
> 
> Unfortunately not. I don't work for Winmate and they haven't provided
> any documentation on this.

Ok, in that case please send a v2 addressing Barnabás' remarks.

I'll do a full review of v2 and then depending on what I find
merge it, or ask you to do a v3.

Regards,

Hans

