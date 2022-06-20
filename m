Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8255241C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbiFTSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbiFTSie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:38:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81862BC32
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:38:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fu3so22790962ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gy68BNl0x7CDDp2EHogXVg4xgL7xvnIGrRM8Vd3wExM=;
        b=LwNNHhBLLVDtr02cqaL7ilKF34nB4GbqqJSxJ075ClON6bb3hzrA78mpnxOIVRUK83
         xPRU1e7VUCsARi2ebSr96PFT7fKHuodE6mv22PHqwLKCXXmKTRBi5vrWaFR4V5oWIIzE
         wXwrXrvOZqMWUpvL7Y9315+QpuqzFUgKc6x89QJURjsHOLNZWvM5xJwCL93eBgWCmLdh
         BX+SFKudDjDfYoIpuUoi4rZR0o3T6HPINbniwQRI25apX/yIooiynRpt6ZTVJlVR3ah6
         TH1FKLxXud3MLnxECr+mrBB2ejyzox7EKejlFofFMJ0gZ2bVKrY7WB3+OgiD2Xd4vLVt
         ofUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gy68BNl0x7CDDp2EHogXVg4xgL7xvnIGrRM8Vd3wExM=;
        b=Kt6JiIgRbGQpr9UHVkeXwVg+Sw0URiVlgAqC4oCZBKxc9ym+rDQGpJDI8zR/5zQY99
         OqPATYDFwSsLzPWtE7AxXvwVaRasPoQ6uhlvyDxKNqEWIAVIaYQ4B8+4XUhMCPs/EmCe
         WFPRfq4LOrFEwbkE52p07uIX+QIfEX6KRElPNMDguE/M0pgYawb9oE0Q7FRa8xx3ahA9
         qY38SfSr4SLmWaD6kUKiJqj2/wCGXD4qJXJuZEHeDeNzzlvNcJUgmKpnFD+FlV62vBFB
         Oedozrog8222i87x1xbLIH7P57Tk5mfBbyWlfV7O+pdCRFkT5PZadjkIMEqm8s3OMMhP
         zBhQ==
X-Gm-Message-State: AJIora+yOzmlYsGMiRaIYc8nkIW073VeYyMKUF5qI9DfTIQociJl8g8L
        3zSkmLoowhd0nYFuQNHgfCXDEg==
X-Google-Smtp-Source: AGRyM1uiFV4GB0pnqPs9igkVC3/+a1NihiI/69f9Jhtrze9qPjPVW38mfDN5U78ZFoa8w/F3AJdUVw==
X-Received: by 2002:a17:907:c71b:b0:718:d0a2:a447 with SMTP id ty27-20020a170907c71b00b00718d0a2a447mr22421954ejc.157.1655750312126;
        Mon, 20 Jun 2022 11:38:32 -0700 (PDT)
Received: from [192.168.0.211] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id us12-20020a170906bfcc00b00709e786c7b2sm6428225ejb.213.2022.06.20.11.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:38:31 -0700 (PDT)
Message-ID: <ec29b0be-c388-dc3d-a169-acc719e8cefc@linaro.org>
Date:   Mon, 20 Jun 2022 20:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] soc: qcom: cmd-db: replace strncpy() with
 strscpy_pad()
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>
References: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 09:33, Krzysztof Kozlowski wrote:
> The use of strncpy() is considered deprecated for NUL-terminated
> strings[1].  Replace strncpy() with strscpy_pad(), to keep existing
> pad-behavior of strncpy.  This fixes W=1 warning:
> 
>   drivers/soc/qcom/cmd-db.c: In function ‘cmd_db_get_header.part.0’:
>   drivers/soc/qcom/cmd-db.c:151:9: warning: ‘strncpy’ specified bound 8 equals destination size [-Wstringop-truncation]
>     151 |         strncpy(query, id, sizeof(query));
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Any comments on the set?

Best regards,
Krzysztof
