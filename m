Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923FC57CC05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGUNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGUNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:34:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9515E81C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:34:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u5so2310894wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=m9tu5kfLkLBgd8ubz/EUC+KagXbqcDn5HWzdWJeSb3Y=;
        b=6v6Hu/g3Zo0GWLuMb/6idFPyuTqciNcRwGDVx+n8h2Rqq65ZCYzPnMS6hb3+hpO23F
         8wEH+HIznFFlGbx8xvFvRSSV6krJRDxtCTbvWGXiTuIsk5Ab0S1+Wu9UG0kbhA7RaGb5
         cea6QvDNyrFOH2+4jTRq53uq/wOo/xiG/PQA0q8jj8jDWiTqn4LTpinsH6p9meJUhpc/
         R+E17VM4zjcQvngCUXrU91UwkqlvtXEzfIHOVaDG5TS6XLvyhD5kbZ7v5t45lo1e107K
         utNwAJI1DYsHvrguolIH1iwujd59CZEAOjkrTNQE2zvhMVUs+FN8UeMrU1ebDv40k3Se
         v8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=m9tu5kfLkLBgd8ubz/EUC+KagXbqcDn5HWzdWJeSb3Y=;
        b=BRFIG5/MUBpKK2lci3OqSn12TmC/pNd/2Xgky4nxd3z1T6GRRBOZC2nEgO1H1CffyV
         dabSFQn5ZDaOwkeVheCObCV9zb5qNHIfzVfXBTuWV23x/DUpTRVoD+kfSPbCAa99PwVO
         rEoCHsyp+r+lvQhlUlj3usC5NFpA8bHOYeYWqOoj5z9XLub/UHJoY8zSaWPf0GxfgiIx
         GFxjUYtUoJU8/QBhc0uLPBJQPTzVxxgkFapXW8S+sEnjYvqweU7A2ov0yn2nXT+XSsUx
         NygxFhYpaN30FZVR+JQKtEwAzcfoG7CetJUjLX5IcvBJF80oSILBQQNcKFiqxlcUMgFG
         VmDQ==
X-Gm-Message-State: AJIora/DpwRODZDlf16epqzQ3amt3HFJ7kiEx6N4pJd8s1Hak2G3U01A
        +2NZa5Q3Zu8n236qvK3VHz4Rqw==
X-Google-Smtp-Source: AGRyM1vFMRoTO4e+uNQGZXhzHMNWPBJJ+oaO5moEg5utkAab7eiYnQAw585oYLpHYefDneVsptGijA==
X-Received: by 2002:a5d:6848:0:b0:21e:5e37:b2e4 with SMTP id o8-20020a5d6848000000b0021e5e37b2e4mr11612wrw.530.1658410452448;
        Thu, 21 Jul 2022 06:34:12 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id p10-20020adff20a000000b0021baf5e590dsm1907554wro.71.2022.07.21.06.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:34:12 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/6] dt-bindings: mediatek,mt6779-keypad: add
 mediatek,double-keys
In-Reply-To: <c5e94d12-4f52-2e75-3b45-735afa0e987b@collabora.com>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-3-ef9fc29dbff4@baylibre.com>
 <c5e94d12-4f52-2e75-3b45-735afa0e987b@collabora.com>
Date:   Thu, 21 Jul 2022 15:34:11 +0200
Message-ID: <87o7xih9nw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:40, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 20/07/22 16:48, Mattijs Korpershoek ha scritto:
>> MediaTek keypad has 2 modes of detecting key events:
>> - single key: each (row, column) can detect one key
>> - double key: each (row, column) is a group of 2 keys
>> 
>> Currently, only single key detection is supported (by default)
>> Add an optional property, mediatek,double-keys to support double
>> key detection.
>> 
>> Double key support exists to minimize cost, since it reduces the number
>> of pins required for physical keys.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> 
>> diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
>> index ca8ae40a73f7..03c9555849e5 100644
>> --- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
>> +++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
>> @@ -49,6 +49,12 @@ properties:
>>       maximum: 256
>>       default: 16
>>   
>> +  mediatek,double-keys:
>> +    description: |
>> +      use double key matrix instead of single key
>> +      when set, each (row,column) is a group that can detect 2 keys
>
> We can make it shorter and (imo) easier to understand, like:
>
>    mediatek,double-keys:
>
>      description: Each (row, column) group has two keys
>
> ...also because, if we say that the group "can detect" two keys, it may be
> creating a misunderstandment such as "if I press one key, it gives me two
> different input events for two different keys.", which is something that
> wouldn't make a lot of sense, would it? :-)

Hi AngeloGioacchino,

Thank you for the suggestion. I like your description better as well :)
Will use it in v2.

>
>> +    type: boolean
>> +
>>   required:
>>     - compatible
>>     - reg
