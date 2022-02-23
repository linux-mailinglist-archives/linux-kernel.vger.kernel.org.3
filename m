Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4081D4C0E07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiBWIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbiBWIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:08:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BF7443D7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:07:51 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 055BB3F1D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645603670;
        bh=cJAoPDc8aKVGCYTCguUnHYj9Um4T6R7Mz/nddrCfS+U=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=elRfv0XOwQN9oqOyVKTk8afva8A1ztDl/s6oV/KFC0k0RIAFW8HzVPFJ0q6R7eTPb
         N0r+qqqBWpux65Xjw/T1U8wXQmpEU9mFp0Yxda58Tie1d5WGaOoZCrwp3LM6vFSMSW
         305oiif8eYPNlnMj/pYa+LIs51UK3FT3olhCpFS7wJ0wyE/Ydmkxak+0z5TOTflv89
         V77DEeqKS5Hm6y1tCY+UCCTRhajenqKIvzLsirORnMnzr8qFoMW+C0gmMmQZ4/bjcT
         Zwxpn7JTaa/VzN+6+ZIpqH6OzWAVkY91kWyYNImUa6EZw0kfd4AgmbGOEPfT/FdCpk
         GdDZW0IGu3buA==
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso13214659edh.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cJAoPDc8aKVGCYTCguUnHYj9Um4T6R7Mz/nddrCfS+U=;
        b=YTdcv7jSylmd1hllF7pNMGz4ChI8/5wI5zn2SyL9BmLh77KU/Inx5z/yvqqAjH9VRT
         cEOhaPcvWfsXwLfniBS0RUz7a9UZeB8tHVPB6pzNTO8zv0W09HxY3dsZJC9Q1f9LZgPM
         OoH8uhbK+M/hiPgin+y3H3xBWZ1NJScMrluXVLkRNcmmzn4dqBFgGoDC8YqNsmX0+CVt
         oYl1VqKZeGOTq2Wx8DBqe5naw6+UU9rosoLurRKamcLuXkRKLuF8ARRv+l0lad2v+Yt5
         E6wTGmtKhrKfNwzF7PQMl5SUkMbc2U0GMkuYz1guT2jugD3GXP1qSGS64ID8GTNjMHLr
         Z11A==
X-Gm-Message-State: AOAM531xmQ1VSxOMIzzNvibetE2GaybEoNyF/3iHMi5ZNsjB9yNDAfdk
        S437p4gc3+/a1CAmLCZHg/76ylTaAU91V7TGs1Iw+Cbk2JpUT4+PaWOfv661Dx4PRb1g9o9Tk/2
        Bq3ZnPhN1g6KV3ECywxyppFBG2sUur7KP66WKb4AThw==
X-Received: by 2002:a17:906:3b4b:b0:6d3:4b9f:1764 with SMTP id h11-20020a1709063b4b00b006d34b9f1764mr3782778ejf.345.1645603669462;
        Wed, 23 Feb 2022 00:07:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+sAsvC2YVaWkNxMY27IgSZbd57gDhRWf6CFP5QRb8O1Ze/Oy2J3V8J8SGl8x0BiwMVeVhGA==
X-Received: by 2002:a17:906:3b4b:b0:6d3:4b9f:1764 with SMTP id h11-20020a1709063b4b00b006d34b9f1764mr3782763ejf.345.1645603669271;
        Wed, 23 Feb 2022 00:07:49 -0800 (PST)
Received: from [192.168.0.124] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id h8sm11129654edk.14.2022.02.23.00.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 00:07:48 -0800 (PST)
Message-ID: <566af033-352c-ad04-53dd-219cda3f78a0@canonical.com>
Date:   Wed, 23 Feb 2022 09:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] dt-bindings: input/touchscreen: bindings for
 Imagis
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <20220222203414.8656-1-markuss.broks@gmail.com>
 <20220222203414.8656-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220222203414.8656-2-markuss.broks@gmail.com>
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

On 22/02/2022 21:34, Markuss Broks wrote:
> This patch adds device-tree bindings for the Imagis
> IST3038C touch screen IC.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

No need for blank line between tags. I guess this can be fixed when
applied, but if there is a resend - please correct it.


Best regards,
Krzysztof
