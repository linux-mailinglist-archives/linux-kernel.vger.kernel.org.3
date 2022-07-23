Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8B57ECFE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbiGWJRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiGWJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:17:51 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4582229A;
        Sat, 23 Jul 2022 02:17:50 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id DD2801B00027;
        Sat, 23 Jul 2022 12:17:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1658567866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2qEYdxHYoqM2Wy3hrA5pd7ObUPMS76FKSQJ593cqE0=;
        b=eqxUETZsOWgzVFZeJ/P5TwPGKf9wIaHDdTvyEjpBKltDqGq+2+Q5HhvkihMssGyLn1gC1M
        0jbxsepf+on0ld8AX88IeLrqSo9NsoqEHdfZTWOuxMQLuvrIJV721xpBptPHalvEXuPX42
        yhf+7eLIwT6tko8Pjs4g45XNO07TzhHdkRiqWQaTARcjGQQfdMhAxl2daYr3sIzJIpV8NZ
        Vbi0apSGOJBRw0AJkeAb659hQx5eZBFFUvb5srXLEaq0PmMWJ1idYIdSpf3VIYUvjOhgIf
        tisSdhwvfW5DnpBbwGttfhb14Xpc2lGDP5Oi2KMO+NROLlw6JjvinDJiSQDMKg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 7A523634C95;
        Sat, 23 Jul 2022 12:17:45 +0300 (EEST)
Date:   Sat, 23 Jul 2022 12:17:45 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     dongchun.zhu@mediatek.com, zhengsq@rock-chips.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v0] media: i2c: fix the erroneous pointer initializer
Message-ID: <Ytu8uSFlWir2YDu+@valkosipuli.retiisi.eu>
References: <20220722022459.5030-1-linma@zju.edu.cn>
 <693a3b3e.519a0.18223e0575b.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693a3b3e.519a0.18223e0575b.Coremail.linma@zju.edu.cn>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1658567866; a=rsa-sha256;
        cv=none;
        b=Blnu2BnHkt9iPdrAtsbjIWXaquxiAFbzIE5ZKij7DhhLnMvsUlvrpE1c26QQC8wLDQHnRY
        HjtpA8X9YjsLyxsWrJt3mtbuT5++cEYUEyMspWx8D4DcVs+Ys15MoNoI3Gwjc4ZE3GAXex
        2PQBjl8GHylwribcmE3GCDz53OC9Py1PgaYhj/y/hUrFz/k1SQOfaJVghwgS6iZZjHMGuz
        Og0Hh3ck16MCNjEeytHrSG4mLhze5q1cnf7GY6B6j5UdCuUMpNFiLmVG9ZNPNLX5DhfLXI
        EwiAWnqJt73dcCX6iRKXZs1ocbvCTH0xJ7PlGh1F5X5aEKYYa8fBV4eynZyX5A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1658567866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2qEYdxHYoqM2Wy3hrA5pd7ObUPMS76FKSQJ593cqE0=;
        b=WvTQz2hJgsW1fNEi8YkWal12ypXIxs3xknBZ1PXIXJdKJgymPXQVi5DOUG4Ws00Mbc3Uq7
        ZGNywyOJEsbLGBnJPJG3QedT7uuTYl43KY72fh8lxKio/dCDfqNFdCaEWo47lrXdBfKyGW
        8pi1VmJXPe14jW4Ugv3LQ5KM1kH8ZEF14AOjnVdK2aFXjHnXv8ODf47E0c7BkDFX1yiIVU
        RDLAlwFasWqJs2Y8j769x6HYszvi2Ez91XEkfUNg2EdOnbhTJJCR9YBzCfVKlEvN1j9jEc
        L3yE+qdR8hMbOfsVPrvo+NqDxa8tcBAyquDXMlosMe6gu0bU4Wwp86IWnPvlLg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

On Fri, Jul 22, 2022 at 11:08:01AM +0800, Lin Ma wrote:
> Hello there,
> 
> 
> > 
> > There are obvious errors for the initializer of ov02a10_i2c_driver,
> > ov2682_i2c_driver, and ov5695_i2c_driver as the code intended to assign
> > "address of function pointer" to function pointer. This patch fixes them
> > by removing redundant & operators.
> > 
> > Signed-off-by: Lin Ma <linma@zju.edu.cn>
> 
> Sorry as this is a false alarm :(
> I just get confused by the function pointers and function addresses and
> the original code works fine.

Thanks for the patch.

The original code works fine but functions are always by reference, the
preference is without &.

First patch version is typically 1 and there's no need to denote that.

-- 
Regards,

Sakari Ailus
