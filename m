Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A56B4FB28C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiDKENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiDKEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:13:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30CB273E;
        Sun, 10 Apr 2022 21:10:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ke15so12317365qvb.11;
        Sun, 10 Apr 2022 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=O84u4g0rEMhiEbnfnW6weOWFhugAjRvAb7liky1i+SU=;
        b=DneHJtvUWQgzhOZMeRyv/pSo0pxe+UFtg/MsQ1rVH5VYF1UxmxumkfkI9sbO0pO3YW
         mLqbiQOwBibN4dPwSUNoqxw9l40OCyYRn6kSRLXm+OZPkLL19xfXYcgtR83ICfbZdoI8
         dTbYZY4xMkBLKnCQSI5z8nUdu+w4FtqAqVpsPmmXR73HV5GdiXBqmsPscwvwi1VR0/jj
         cQ2X3sh67++uXNGhhADPVGdCCQH33h+5AnIzpWxXNJqrYdkm7dKLn9aqyiD1RPZUpZi4
         FyAHQWguvtperffgP7ByO/yxwLwYtv5CEpHYp6mYgvuRNGTPlXlU8SsXUFLN7nhyrWid
         B21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=O84u4g0rEMhiEbnfnW6weOWFhugAjRvAb7liky1i+SU=;
        b=e0Erzy59O3DdJfPmGwfQpmKimH+3MFYwBHSWPWpObbEadl6brNHYYAM/yyr5M0f9K8
         iiI7SnZpfse3UhPN74bqqg3Pv3/WN/rDITKqewV73fR5djKY2gczsdA+ATEV9cJ4bQqS
         CHGq4g8F6WFX5V9tjKIFjDWq046SjQh3w7ZjD0oQoMn66ZalGDqxrOrJCUIoO+iNHCmM
         ml8a8Bhde/kr1vo7O8vg/DrRzwvOnoB0kg0E6mB9b6D3Q5zWt7amLx7ikcVHgX2CiQQ8
         wQgBi2Vm56MbHkUomm2rM+ztHK8k6Nm1P8dFV/nMKz7sRtMJmTqFTfNrjwak86K4kEle
         ppJA==
X-Gm-Message-State: AOAM5323uuDHXMX0BGu3zDPusoCAmyIdASobdCsdysGlLzTpADsy6/Uz
        Flda+IJoiNrzQ9gM4Yq+MWo=
X-Google-Smtp-Source: ABdhPJyz74QJW/R9APqpj6K9iL73Bp/NOoaWsAIgDb75ZRuEOyrAfpMzSLQTmgJpnfw0D72vdp5ufw==
X-Received: by 2002:a0c:ea52:0:b0:444:330a:2f19 with SMTP id u18-20020a0cea52000000b00444330a2f19mr7304876qvp.32.1649650249725;
        Sun, 10 Apr 2022 21:10:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:91e2:dfcf:c904:aebc? ([2600:1700:2442:6db0:91e2:dfcf:c904:aebc])
        by smtp.gmail.com with ESMTPSA id x138-20020a376390000000b0069bf27a8d26sm4568598qkb.47.2022.04.10.21.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 21:10:49 -0700 (PDT)
Message-ID: <a2679425-3486-2823-01f7-6b208d296564@gmail.com>
Date:   Sun, 10 Apr 2022 23:10:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] of: overlay: rework overlay apply and remove
 kfree()s
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20220410210833.441504-1-frowand.list@gmail.com>
In-Reply-To: <20220410210833.441504-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adding cc: Jan Kiszka <jan.kiszka@siemens.com>

On 4/10/22 16:08, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Fix various kfree() issues related to of_overlay_apply().
> 
> The fixes revealed inconsist variable names for the same variable
> across functions, resulting in difficulty understanding the code
> that was being modified.  Doing both variable renaming and the
> fixes results in a hard to review patch, so split into two patches.
> 
> The first patch in the series contains only variable renaming.
> The second patch contains the kfree() related fixes.
> 
> Frank Rowand (2):
>   of: overlay: rename variables to be consistent
>   of: overlay: rework overlay apply and remove kfree()s
> 
>  Documentation/devicetree/overlay-notes.rst |  23 ++-
>  drivers/of/overlay.c                       | 175 +++++++++++----------
>  2 files changed, 115 insertions(+), 83 deletions(-)
> 

