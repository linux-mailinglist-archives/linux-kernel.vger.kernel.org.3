Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7576526879
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382987AbiEMR2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbiEMR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:28:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1DA6FD3E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:28:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w123so10929696oiw.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=k5JJPrfnhg19K34WoEjk1q6c1TmsC3uLOHh7jVtTQao=;
        b=fuxbVQhTtg32KnkOeISeR0DfO4wLcWwuwO5vVtcSkUcXFcvU2aVAuSS8sbFXqvvbCg
         vXdmdxAUnoFEKLdCO5V9870D/9u7FkKl8ca4+kfKDwB1u/CqNz+CH+KLKEowONDag9a8
         RI0mUUcwT5zDEmEciJYNG7WZzcGftyHbFWMziBFTzEDFhb9n4dUreAdbNedqFjC1XS+v
         qCEtnC/4qIg1n1EJ6dcuA02JqG7NhTWk5Xo6LHEap7I/yCXlWVwNFe/bJVi3GzYy57a0
         c2MNgua3Jkk/p+b7ynFLek8KnoOywID4JpdaGXCt+0ZMY0KkwW0msoaAfrdujLXOBNxZ
         hZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=k5JJPrfnhg19K34WoEjk1q6c1TmsC3uLOHh7jVtTQao=;
        b=cMuBxYkY3WMHc0/21mBWP6Es/oooYFhKdfRxL9rixXvbaj5bZYPnQiHlzxSNZ91DcW
         SsVe115Q/onre8WT8Ek2tNxwoF02i/Ulhah0ybaMibLkVBFnAavt/EqLzAsDgG6YS7uZ
         gerFArpPdWkH2HmhxSCTPAwhX+Yqg4viSv7+QZoPq7pmP5AD78U12g7biwpk+iowq8L2
         bnP5uEc1JkuI5AgtqpAzRzOPpCOn/x9Lfsyfwd8JPz4cF/s5w1qcd17VOuZHL3Ofn27k
         3s3Ldi4ZdaNBD6PnNqSB4c1/8clUmw+FvAIr90kAiQ9PYU5Oe0CjxV/2+dS7h3AaT81b
         RYWA==
X-Gm-Message-State: AOAM531IzWv+lqQDzgKJpHwqd+XKAANOdk1CE+AltVsamjsvdgKpe918
        Szk/N6aL7IiaJCiYh5+K9N4=
X-Google-Smtp-Source: ABdhPJw29k45v0ILaupL5ZGEkdEu2jxklnsLVibdTV9AwvujjOoIhf9oFE5+UzKQGikeBt4QNLlZDg==
X-Received: by 2002:a05:6808:218f:b0:326:3e31:bb12 with SMTP id be15-20020a056808218f00b003263e31bb12mr8106290oib.166.1652462898032;
        Fri, 13 May 2022 10:28:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l125-20020acabb83000000b00325cda1ffa8sm1242454oif.39.2022.05.13.10.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 10:28:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <586d2bea-1cb1-1f0d-e929-48f2c7159b73@roeck-us.net>
Date:   Fri, 13 May 2022 10:28:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] mapletree-vs-khugepaged
In-Reply-To: <yt9dk0apbicu.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 07:46, Sven Schnelle wrote:
[ ... ]
> 
> IS that issue supposed to be fixed? git bisect pointed me to
> 
> # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
>    'mm-everything' of
>    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> which isn't really helpful.
> 

sparc64 is still broken for me, as are several other platforms/
architectures. Summary for next-20220513:

Build results:
	total: 146 pass: 136 fail: 10
Qemu test results:
	total: 489 pass: 406 fail: 83

Failures are way too far spread for a single person to analyze.
Anyone interested may have a look at the 'next' column at
https://kerneltests.org/builders for details.

Guenter
