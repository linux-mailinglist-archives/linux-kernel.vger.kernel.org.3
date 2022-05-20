Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E63752EE48
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbiETOee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiETOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:34:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E475DA36
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:34:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n8so7535036plh.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gNY/3AVbHNu09hERUfx0oPdssKWIVZqHzBoDv8banCY=;
        b=qHOzlvJ+z/BVRREh7Ra71FFppaeMOeQzKsb18Qv3l11S2rTZei13xD57YHJvdVLWpF
         7XkeaJ6A/ZtFwEhbO3JFSNyIsN/cG5GjDPuor7osKNQwv4wtXOk7XZerpQI09EwKDbJk
         9snLMnuWL1wYNMwduurukpHTbsS15BhOnEeuXAbjo1i8w/n7gJV0Cez2JUkSjwRKIZAq
         43aCPgDPJii9AnPvs0Ikw/8xwAV6RTK/RJour7vD34faKKVJrXGbdbHh/Io/hZ0axYrx
         sIZVHQsxdj5m2gxmnNjZx1D6k1jPbFk+W6e2sczW6iK0fpyvYoHFHvtGNFy82uup0vjF
         qb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gNY/3AVbHNu09hERUfx0oPdssKWIVZqHzBoDv8banCY=;
        b=ZS7II04J6fcJYWLSRuw5eNSHcwsDaYwHNgIxd6Y1Mi1z8Zbw7zrW7E3Hw3Pxj8dyIw
         4pI7RzmT/yoxiyMUp1yUYpva8fFFif7rvo1UmzaqjBakImJIxcsUNlVlj9eCtOKpcYOJ
         kA0VPWC8Efy+m9xsKMSI1QheyImEhc90pNombYL7kbnUCM4E4aAt5y7qhrfsBwOdfUx7
         ilNRNx939elk95PfgxjNf9wZ8EL+05yqofSlOh1Vcfr2442HHmH2X1G+lbl3mexgRf+J
         OHwAGsUPxcOUf63pfxfiWoL6AFMEET9byMzDC003dzhbzIBjMVvxEpyCqTx3M3xg+01d
         WKaw==
X-Gm-Message-State: AOAM532EwTza4ZXNF9KqlvJIOUh2eq7CABXHK17l+8d2lY/psLr/IFTE
        otdtMV028qbKHQvCTZJUmCDGYg==
X-Google-Smtp-Source: ABdhPJzwluIjV6EurcBVvKlETIs9IsuXQhq0Wdlfkue8UtyQ+jr1/6tDPXhZ/7GJIBRXyUL7cK3gdA==
X-Received: by 2002:a17:902:bd01:b0:161:ef0f:9da8 with SMTP id p1-20020a170902bd0100b00161ef0f9da8mr4738809pls.147.1653057267335;
        Fri, 20 May 2022 07:34:27 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x137-20020a62868f000000b0050dc76281b0sm1882011pfd.138.2022.05.20.07.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:34:26 -0700 (PDT)
Message-ID: <938111ca-d3c7-9888-24f8-0017a989002b@kernel.dk>
Date:   Fri, 20 May 2022 08:34:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] splice: allow direct splicing with chardevs
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     Jens Axboe <axboe@suse.de>
References: <20220520095747.123748-1-Jason@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220520095747.123748-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 3:57 AM, Jason A. Donenfeld wrote:
> The original direct splicing mechanism from Jens required the input to
> be a regular file because it was avoiding the special socket case. It
> also recognized blkdevs as being close enough to a regular file. But it
> forgot about chardevs, which behave the same way and work fine here.
> 
> This commit adds the missing S_ISCHR condition so that chardevs such as
> /dev/urandom can be directly spliced without strangely returning
> -EINVAL.

Should be fine to turn this on for char devices:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

