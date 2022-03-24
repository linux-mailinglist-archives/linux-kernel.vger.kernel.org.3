Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26D4E65BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbiCXO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347268AbiCXO44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:56:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA77EA1C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:55:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r7-20020a1c4407000000b0038ccb70e239so39471wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ugHrK80HET8DZ+f74WXVZ6NolmaYIO5eOQX+LhNJahg=;
        b=AJCj/zXjgICiAM6Sf8VVdd5x8Xm4KQgPnUhD7Eq/Kg/cYJh9gjSoxdFjIVApiwnMSn
         XyYmCURT4GW6P6ew6BgF2ylK/+uhwjIlgN6aaZ7Pzdp0bt2lPvKzFb+rX47jhI0XTlwB
         W3SaOfQHkaOHHCIpsqQqG57jkWC1Dl52pB5PGpcR0Sau6xYefwskTmXNuH8CXCX9MK+A
         41nITgNnzJ0xoAkWgatllGKlTgUZI9H6nd5dI5jxvSQfj56scXisDkBUeiwuxHXvhwrW
         MaNE0KrJEMS2P/09t2E/ng0jgLuV/TraAlOF2HIu96aGvw228Aylx+sMHjnXJ/lfOYHK
         mLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugHrK80HET8DZ+f74WXVZ6NolmaYIO5eOQX+LhNJahg=;
        b=53iSi8xZkf+34AWwr1eAeqVVWYW5h5/mLUcntp6kwpfdLeeMYOsr1JVFdLm7pBy31e
         wFmu4HRWgjRW+hwHprQ5YM8U/kBjwnB6LiIVUAYgFGEnNUZuLOZQDi4b4saUzSiW2suX
         gIvVf3B2r8mJ6amezyejJyU3iysmrav3EhJ8NGVbQuaGjI6l/Ma5oH/FGBVc3hwauy0/
         /VA4ObvCD2rNzycLBcHh3TVyhRAdRaWmX7FTACzvVFXZuNqj1Q0M6BjYyYYfE7BBoKc1
         qtllY69pXp2M/wCfCsjz3lLjpHC7MmB49dojVFad/Ho4huKIV7D0oWMIq8CWJsdghRWe
         EF7A==
X-Gm-Message-State: AOAM5334v9aUpblBCz6d+mtga89LkDLaoEH3K0OUz6g4YqqsKfzwiZjA
        9bCceWxk0DI91+cBFF4mjPV7aQ==
X-Google-Smtp-Source: ABdhPJzlGM7+aVhd+ESPeY+mOcfoNjBXue9ITUmk62M2qek0XavekfwVYbwwMPo/YwS+kAvuUXPAqA==
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr15024216wmj.98.1648133722411;
        Thu, 24 Mar 2022 07:55:22 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f7-20020a1cc907000000b0038c756fe683sm6202357wmb.43.2022.03.24.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:55:21 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:55:19 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] backlight: replace usage of found with dedicated list
 iterator variable
Message-ID: <20220324145519.lcalgtmw3ih4y4li@maple.lan>
References: <20220324070608.57057-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324070608.57057-1-jakobkoschel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:06:08AM +0100, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
