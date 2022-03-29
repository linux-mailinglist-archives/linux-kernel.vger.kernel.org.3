Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B94EADAE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiC2Muc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiC2MtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:49:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A05227C5B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:46:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y6so14982483plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rxVMbNlsIDttgLsDQW9zlxLetSlVk0P6TXGtVI3cb6E=;
        b=PWILuP6rpZEDH4WXU2e7S+vFyN0Fd42Av4QSFBhoFmIXktyXkMalQjmfJgJCtM8Z8V
         wBmKN5HlT789q86wG5Ti6McqcFJAIm//30h6QDPaCxdL0FQhg34WUqwaTiOi9xuh38qF
         BvH3IqvHkHCT+ATftFblwjSqP28fmQ57WI+uLgVctAgpbYsIUOo8BjbrXfxGOOKVNUGH
         v7mU59TfKw6KEVVIlrsEvqgGZh+utDoUs1YtVukhXkCU+pjIGknph+lmuiH6B9gFMNLe
         i7EoRvF76t6zAAFg9hcbcPpapzur6bEU4wvTJrB4BTzru9Rdtu4jdZjpkcDmJSuA4acf
         7+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rxVMbNlsIDttgLsDQW9zlxLetSlVk0P6TXGtVI3cb6E=;
        b=u2wKTZJsLrj55qMm7hVp06uDbL4ykRaMXtBF+X7EOpVJ9XRr8w+WyRA5eE2UJqe6fd
         TrFKd911UFVs/erDOt0Lp2WZd496PlxBvfdHzj0Vx0D979hgaJFir67aEmAM3X51mh0z
         Z/ik7ETkx9kayUmc72C+Kp3Ijw7UBHa2JQTg7AYIP7AY+0t6V6vlv+h/46+JO351C7LX
         PfYqdLmMGQSgbU6ET5bhNWi5jIYVNQtxeCR88lq9dohk6bpq3BYIS3DeqoZtljdWsPHI
         Xf5f1VBKrSaEW/S/Jyzt+uwRslJpJqFo1IEG9/VBddJjxFEqneQkGQ82zv/ysmJEADe+
         GIWw==
X-Gm-Message-State: AOAM531R8fWNZ1d84erqJvdLV21FBzTnRiAlc2rU+poKoJXos8vWqsu0
        84NpfDaXTpxxLD5jtt5+L7ZyKg==
X-Google-Smtp-Source: ABdhPJwH1iXdVwT0nBUyiGXP5p/4Q0BR3MyTU6L9eyfTF2N9F7yM0gyokMxROV9mKgv2Fl8oSZnZ4w==
X-Received: by 2002:a17:90a:840a:b0:1c9:5c4f:5e83 with SMTP id j10-20020a17090a840a00b001c95c4f5e83mr4376177pjn.144.1648557997386;
        Tue, 29 Mar 2022 05:46:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b001c9ba103530sm3042535pjb.48.2022.03.29.05.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:46:36 -0700 (PDT)
Message-ID: <2b37ce73-83dd-e572-9578-7bb045f1040b@kernel.dk>
Date:   Tue, 29 Mar 2022 06:46:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220329094048.2107094-3-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 3:40 AM, Yu Kuai wrote:
> Currently, the splited bio is handled first, and then continue to split
> the original bio. This patch tries to split the original bio thoroughly,
> so that it can be known in advance how many tags will be needed.

This makes the bio almost 10% bigger in size, which is NOT something
that is just done casually and without strong reasoning.

So please provide that, your commit message is completely missing
justification for why this change is useful or necessary. A good
commit always explains WHY the change needs to be made, yours is
simply stating WHAT is being done. The latter can be gleaned from
the code change anyway.

-- 
Jens Axboe

