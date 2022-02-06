Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0FB4AB0FB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbiBFRgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbiBFRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:36:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB982C043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:36:28 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 731F54003F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644168987;
        bh=gU40D18zy+yYQC0btlcmtDWK+66i5c8aQLed2HqI8k0=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
         In-Reply-To:Content-Type;
        b=dPdENRwEPg5X8ATFzs6qXQdO8LdS4GVZHG9JiNu0Wuve8GtVvFxoWPIgK42e7n8GN
         1CFP6ZwuYC08l98ddupe94Crl0VAG+Zf/fIZcXR9ccYOZeSJrEfdpSbFwlu54fZMc/
         U7abTuhkzyWxuRnC/a3MU1bTbR0a3RrCF33dDXPuLw8qToYfF/3Eb2z/xW302jqsYx
         hs00La1FWSOsXBb3LyzaDgRBDOjiX35lvzCLuYyGnqfykTkIONUvhRU4sxd2i4ts7j
         R1qE/LEGriWBiJ7tS6lEL1BPm3X1cnb3RliMD9OI4Mo5SS79fqV+7Z7KoREfnaOFEl
         209OimDzMfAzA==
Received: by mail-wm1-f69.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso4489781wmb.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 09:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=gU40D18zy+yYQC0btlcmtDWK+66i5c8aQLed2HqI8k0=;
        b=s3b1CqUSCfLgBhJCAUzlV4EH1Y1yN2iGAUQim7BCVGRmQZ8evihn+Beg/NfeQHD+R2
         zfYerWpvYHq8c7jyN/8IZcNP7lGnXyl2M/v/eDGqHQ4MEw8e7D7D5beQVFdtJJMNysd1
         mI6byONiJUfW9eOECHLFwpCZBQcggucqXROqKlPReVMe/7CH7FsR3/7DlkIqd7KrzA7T
         yyNxrAHWKDi6RAY1RD6XXsmJjDxeFb8gQCl1OQQlVsLVMxJU9Doq13SKxl5/xGTfNiXN
         yTe9XkPXVkydhci0kVOJWJx32oNvt76aMtjaW3JDJX6dcdoM5zJgDfMSEue8x7jS9UOY
         Fr/g==
X-Gm-Message-State: AOAM531zMRON7VBo4SJE6i2XapzIYrnvBFJ8QrJkwqk8DRbPxz4yl4IC
        rRxSeejiZdSGs2/pVhfdtVTgCKu6YKbJUW4S8xGzHanD+W8ycJtXjiocKaxtHRFnqLSIQ7ZGDvV
        w3HHs2+GTFSxGAOvmmuroX9xKzcHXBKHGCViavG/0YA==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr6925258wrt.193.1644168986943;
        Sun, 06 Feb 2022 09:36:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+OyXalnsQiFHkVAkYfKnSTAkoix3otIqV8BBL6nkmNQ5dNSo9+3+pwnw83UMpdPXnKSWFNA==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr6925247wrt.193.1644168986805;
        Sun, 06 Feb 2022 09:36:26 -0800 (PST)
Received: from [192.168.0.86] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n26sm7038162wms.13.2022.02.06.09.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 09:36:26 -0800 (PST)
Message-ID: <63255060-8df8-660d-52bf-198d77c884d5@canonical.com>
Date:   Sun, 6 Feb 2022 18:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] leds/power/regulator/mfd: dt-bindings:
 maxim,max77693: convert to dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 18:50, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1
> ================
> 1. MFD: Use absolute path to schemas, add additionalProperties=false.
> 2. Regulator: mention all allowed properties,
>    additionalProperties=false, add min/max values for voltages and
>    current, don't use patternProperties when not needed.
> 
> Dependencies
> ============
> The final patch - MFD maxim,max77693 bindings conversion - depends on
> all previous. Therefore this could go via Rob's or Lee's trees.
> 

Dear Lee,

This patchset was reviewed and there are no outstanding issues. Could
you pick up entire set via MFD tree?

Best regards,
Krzysztof
