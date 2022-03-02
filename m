Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9DB4CACBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiCBSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbiCBSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:00:28 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF46CA719;
        Wed,  2 Mar 2022 09:59:44 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id j8-20020a056830014800b005ad00ef6d5dso2389272otp.0;
        Wed, 02 Mar 2022 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tg2DpkLmWcTAEoAVGEjFVecdFbv2TznFTc3gGSZrmsU=;
        b=NgjbQrIwjDVHkMXXx+sL9NdZFs6XHZkQus1Y0WnjrEJeoN2Tf+25DSe53tJM2fFdnt
         2sOVOPCkipyJG8shFTp3L9kphIAaSHL5+FJC9zulko68oTHmIywWmIwASbWJEAJ3DSNW
         Cgu7Q47xFh+rrXxO54XKzJSAwIhjVj4zqLPyNN1H7NjeJMfFY6Z8tuGBjARmMqmeS81/
         5+38rlChyKxXEEJHimE5PCwygJU//Z/yjzOIyJfX9FLNyvQ6x0mRJvYQsG/Pd/XSXv1j
         Y8Ie/nszvS8QRS+unVS1DkaX5asq1SFjHkQ3/Z6LrtDgHgzo0iJBfvbCZbzc4hA0y55F
         lpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tg2DpkLmWcTAEoAVGEjFVecdFbv2TznFTc3gGSZrmsU=;
        b=Jc3a5fKq92rnloxaCumTzSRQfzu2Zec9Ovp4tdiMbqWrswWG4bLuNnGn7nverA+iwX
         o8YVV9qrN/8u41lan0h3Pkl3Ft3XfTEjn/MMunDprJLlymMilzIQM+/lPQD0duIQDXc4
         Pj0+kGgSZBWj3W73U8ng0TwK+Oi5APknhDpq6kT7expFEqcZeNwNd33Q9as69qDwk5/A
         pZf/zXADhrVSnzg5hwpxrsm/oPq6SlUMKAoMTCLvixYAeU4/6k7Zhn13Yc9CUciNvEr6
         u9c0kCu/3VoGoVdrVpSN/Zda7c0F8TdlVe2p5CE/JaVe3K42wY952doT6EmBmRiwMx4r
         GFyA==
X-Gm-Message-State: AOAM531i7rFhkRf02nEsDgGamvMnUxdROsqigihz0c2/YPWHvfQkqKHu
        UOb7MzbFSlqVU1mQ+5qS7zSCiJBSSgQ=
X-Google-Smtp-Source: ABdhPJzAZUjPhkE2aJPw853yaMimgdIP9QL6xCcVgf+voglpl/AynjbgLXaZ6e0zK1YvZLYzdGtrLQ==
X-Received: by 2002:a05:6830:1db8:b0:5af:374b:81c2 with SMTP id z24-20020a0568301db800b005af374b81c2mr16390535oti.185.1646243983840;
        Wed, 02 Mar 2022 09:59:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y19-20020a056830209300b005afb1e59e0fsm7967415otq.55.2022.03.02.09.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:59:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Mar 2022 09:59:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464
 and TMP468
Message-ID: <20220302175941.GA2523098@roeck-us.net>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222223610.23098-2-linux@roeck-us.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:36:10PM -0800, Guenter Roeck wrote:
> Add support for Texas Instruments TMP464 and TMP468 temperature sensor
> ICs.
> 
> TI's TMP464 is an I2C temperature sensor chip. This chip is similar
> to TI's TMP421 chip, but with 16bit-wide registers (instead of
> 8bit-wide registers). The chip has one local sensor and four remote
> sensors. TMP468 is similar to TMP464 but has one local and eight
> remote sensors.
> 
> Originally-from: Agathe Porte <agathe.porte@nokia.com>
> Cc: Agathe Porte <agathe.porte@nokia.com>
> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Any review / test feedback on this patch ? I would like to apply it
before the commit window opens, but the time is getting short.

Thanks,
Guenter
