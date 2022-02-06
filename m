Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3D4AAEF9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiBFLUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBFLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:20:35 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD1C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 03:20:34 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 37C993F1D9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644146433;
        bh=i9EmgtpGx11cIwj9ugumfjV3EWt5zkLMtmnd8R60n7Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=OHCBK+38VgZXKF5G6HYcbeW6H7MaOuapXe2nwJJZEmwow0vTHHn+oyITmUhtDIBXT
         ghZhmqUXE/41HR1BRlGWQ+FsAh25UClC+lr6dpduT83t9Oxl0wWlnB2Cs8DRB11Qx3
         1vqPaCXJi0a5pFkzwYNCTZEYAF/cmQhozrtw3Cn0atT+mnitWJFuV4NkHwjgoBOWfm
         UfudiiR10FVKDH2/dQTF0Q4e0pmEXMxxhDUeW1BVACwgMwOkpZgAH0S7u6IJCtV6XW
         4R+7cdp9w0PEjhAjTaLdd4qr4rJp0CooGbns8nrOO1RIRXUdH8gzRNTB/NNa6wGbAn
         +UHf7+xx7a7jQ==
Received: by mail-ed1-f69.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso5937180edr.21
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 03:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i9EmgtpGx11cIwj9ugumfjV3EWt5zkLMtmnd8R60n7Y=;
        b=HrqxhaNigt0AgyXzWgQdhfQ5QYnSPPbjPnR1Z6FWRlVlSy3a5HlpylyHEXf/R2fLT9
         gXQZK66qGNb3YHLzkfHXmvtzRpFswUgq6+tX9OdnlFPE9d8kELUuyEi3M/PFTEkyO+Q0
         6e4RHTNr7W6O1aqlKBS8FLpJDj6yE2zeUyDnqUelIcCfMfsiy77MMYluF2uAnKT5WiYF
         DhG0BAdEmZsEvqauPKJo3G8MICzoISWW7wHThOkj/DIpp4FpZR9g1cueDO6qQCHVIxsj
         3MhnUQObbxYXDeosa880fOVvgQ4mSdQtd5Tn2EN+JVj0VmtU1KfqvxWh5kch+PZQIW88
         V7Jw==
X-Gm-Message-State: AOAM533zbMeJIDAgYjG96es80Gui6UvNGYgYYdZF4cozMJ3PIqdUlQhW
        Dv+tM75tFFHwpmjC/FkEbQwdoZBN7G3cVxrr/G6rkn2gI5XFuVVHMZfRFtcxB+hCS9hNW0sOEze
        j6swW4NoguFaF+GZpqlKgIUgtUXh6Z3P6riyap3Zq0w==
X-Received: by 2002:a05:6402:1348:: with SMTP id y8mr8346017edw.280.1644146432933;
        Sun, 06 Feb 2022 03:20:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyM2MpDLbrWLUvev/UnRu1x/U4jhDAWB4t25fgpTsPk+WChLF/e6D7bPJYyfCy/mfRoie7AXg==
X-Received: by 2002:a05:6402:1348:: with SMTP id y8mr8346009edw.280.1644146432830;
        Sun, 06 Feb 2022 03:20:32 -0800 (PST)
Received: from [192.168.0.83] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id q5sm237027eds.82.2022.02.06.03.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 03:20:31 -0800 (PST)
Message-ID: <a5bbf115-21a2-7d63-6744-72487b9e756a@canonical.com>
Date:   Sun, 6 Feb 2022 12:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/5] dt-bindings: memory: lpddr3-timings: convert to
 dtschema
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
 <20220205120043.8337-5-krzysztof.kozlowski@canonical.com>
 <a204a4eb-6615-26db-facf-ad284c1732d7@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <a204a4eb-6615-26db-facf-ad284c1732d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2022 19:50, Dmitry Osipenko wrote:
> 05.02.2022 15:00, Krzysztof Kozlowski пишет:
>> +  reg:
>> +    maxItems: 1
>> +    description: |
>> +      Maximum DDR clock frequency for the speed-bin, in Hz.
> 
> Why max-freq is specified as a register? At minimum this is inconsistent
> with the lpddr2 binding.

First of all, this is a conversion, so the bindings already specified
max-freq that way.
Second, I don't know. I think this was some Lukasz's workaround for
device node without unit address, but I don't see the reason now why it
was needed.

We could unify it with DDR2 by deprecating 'reg' and introducing
'max-freq', in separate commit. But you know, existing bindings are
already there...

Best regards,
Krzysztof
