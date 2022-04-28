Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B5513EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353060AbiD1Wzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353054AbiD1Wzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:55:32 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A19418C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:52:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f16645872fso68707677b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQSHZFFqhGqguDQeUrlptfLxAJDHurEMXXQM/r/YNSQ=;
        b=K8LxjAyNdmlx+j/JFYhP5xn+d2TBYZuQfYbT4W9wrwV1KjF0cgCv0pLnSTXUwT0RrQ
         s5//4tVmbHa/DX8wkSQvqzfYGp/mIzP1bR0cW2nKNPesHO73BT0UNy1AsrJb2z1cvGMZ
         eYlTehXFEX5AErk4IIcRFcV0ibH6OQp+FTbBpE28KIq1xY09zOvKHUhrDMjoEHLwZCjT
         O8Nt+yYAZ6bPWW/fi3WFI0HoysWb7Mdz4Rxy+WyrPOhGvr7vqNRBWvm4d/x3r+izMvdN
         9G8eFDC4xliZuz/wHY4BXIsdEI3kyCWMuoLBY9PiXgOmfPH/6kUwBimsqaHmxzlLO3+q
         LSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQSHZFFqhGqguDQeUrlptfLxAJDHurEMXXQM/r/YNSQ=;
        b=suW9zq/2VqfcTsfLn52zh3ICAUeXm7regGXa1fHH2VAK/yYLNp4IYDTggvavyO1RVc
         yIaef7igR/BSPLzT8atCq/kbXegkDI2dVYHmduteA8/4hHY6ZBQPT1vDSMem+uMr9JSs
         NVpDWBUIckurlczgX77A0xery65pPueT+uAuYBQtKnwIGDM/muwDK/o9Gm4p82jrsIKu
         L6Ien+BSGIa1ruDkrq7VbSzDbJYswDDYfN1S2mjMMLLdvqip53RLkrUyoRAaGSdQ5CMh
         cfk61dlZGIsZ7M/oFxxTHkEijuC/lDUfmvNkb7HzSRTxIqxFO4KvZ58OE2qZ81vKAtuU
         3HRQ==
X-Gm-Message-State: AOAM530yYeCSgZ/pvqDP9jPWWJ8l+8wMDoALS7w6Tp8HhJXkIMdJPzZw
        /i1jMVuXjoFIDQY/j/E8b9w3xIyzUv/qLkXPJBfIyw==
X-Google-Smtp-Source: ABdhPJxeLmDpTaMNXY7Wqn0ZY0oHf2i3kitPQek08DWmM8V77lMeD1uVkcuL3axOpiMHKUg2pGTgK4SigJXtFUWHXtQ=
X-Received: by 2002:a81:2154:0:b0:2f4:d79e:35dc with SMTP id
 h81-20020a812154000000b002f4d79e35dcmr35566381ywh.126.1651186335816; Thu, 28
 Apr 2022 15:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220423094142.33013-1-krzysztof.kozlowski@linaro.org> <20220423094142.33013-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220423094142.33013-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:52:04 +0200
Message-ID: <CACRpkdY8LJ5xMW0eDsL-ycrqV8io2zXJrT6RfZj=KxaE9rvcvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: nuvoton: Fix irq_of_parse_and_map()
 return value
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:41 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
>
> Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Changes since v1:
> 1. Correct the return value passed further.

This doesn't apply to my tree neither for fixes or devel, can you rebase it?
I'd like to queue it on devel for non-urgent fixes.

Yours,
Linus Walleij
