Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA7498553
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbiAXQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:55:22 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56250
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243450AbiAXQzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:55:19 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 741CE3F1B7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643043318;
        bh=9EEQLll5JWPzYvRo5e7XU5syPg3MM9rervJCQ5j61PE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Zp914u3J397Qo0bMnjW6Vb28iFCOkvPinzNOAVPhvEVjfPQKvp6I/mDx0k+T4BjCn
         BMcBkc4l8IXio05eqnqQzZMwEiI1BzPSZJf5IrWDGqLACmhdGlMV8d9EU+v36dGiQe
         a8WhxBTiQ0MxkQwAY9Yvmq8Izf/bccI9Z63FqVL8Mq0BngOc6OTry8i744HZ1mWnUj
         5FaHnHfx5Lt2omYuWwPUuJWeU++PdmtEWFMHjk3thK7rlsZx/UcPXWGw/iUJvAY/KZ
         vGC7i7j/38cTNtVZ1TgX1uvKlC63SiQgc0+vlP9gATZ/ttdGpkihdoIfl5ZjXneMpV
         tMXhs29HykTrw==
Received: by mail-ej1-f72.google.com with SMTP id rl11-20020a170907216b00b006b73a611c1aso1638739ejb.22
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EEQLll5JWPzYvRo5e7XU5syPg3MM9rervJCQ5j61PE=;
        b=EwkB6Oqe16Na/VAeTSJVbgX4xSSGuC7WybUyyaSpIPdEVfoYn/fUBxhEtKVUWsmL5t
         EqQj4LSKBzsYuJ+u/myUxSr3XZaDblmeEoxQa0ncF2T/EjvlNWawlLNakVOh4l/vK7F1
         NunlvCN1Pn11HJdeR4+8xMdXmPjtvVKlRcOQ4Dd5893j4/A85WXuk+MXGyMuWjWKgQEJ
         grPns8WmOJLDY744A3B+qwXd+qok7+w95N0D4RlDTlGCoEJicqO6iQXDDACWhM2/Ds22
         anWGoVHlG7g2RoitjjNGRjuLbQOUx9ziG2JsKsJHJ3dcN37i2Kei1O63CN6WiPJCz2yv
         CkuQ==
X-Gm-Message-State: AOAM532UT/7FZt5WsPKzFs4BvAv86L9b9knV+cQZHggpoWDY1jGt3mPZ
        MhTLBs8IQZXxDvAI8Qg6lNmQ1nM3dmAR3Dfkcfb8U2z8lY+yxwICP4sCshBl+9dveNlZ+6Qt5hw
        IfvSQ6Xa8MGCGxCmHfneaqY/EZ07pG0NW3WlTdZ3QIuZNH/ACX3DCveXEqg==
X-Received: by 2002:a50:9549:: with SMTP id v9mr16834031eda.335.1643043318208;
        Mon, 24 Jan 2022 08:55:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCcCQ2xn7I2rwOCmf8P8fmxvKeYvey/cJWwAqZ0tDzbf4isWUQwXV1mSERsEcSSLZDF6CZzpYhZ/4G59YeUgI=
X-Received: by 2002:a50:9549:: with SMTP id v9mr16834016eda.335.1643043317988;
 Mon, 24 Jan 2022 08:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20220119015038.2433585-1-robh@kernel.org>
In-Reply-To: <20220119015038.2433585-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Mon, 24 Jan 2022 17:55:06 +0100
Message-ID: <CA+Eumj4HjM8SPoOUo7_eLBOHFYXTPPPgmx_YDYdEXDyaT67Rrg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Improve phandle-array schemas
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 02:50, Rob Herring <robh@kernel.org> wrote:
>
> The 'phandle-array' type is a bit ambiguous. It can be either just an
> array of phandles or an array of phandles plus args. Many schemas for
> phandle-array properties aren't clear in the schema which case applies
> though the description usually describes it.
>

Hi Rob,

I have few questions below.

(...)

> diff --git a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
> index 095775c598fa..3a4df2ce1728 100644
> --- a/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
> +++ b/Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
> @@ -21,8 +21,7 @@ properties:
>      type: object
>      properties:
>        sound-dai:
> -        $ref: /schemas/types.yaml#/definitions/phandle-array
> -        maxItems: 1
> +        $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the I2S controller
>      required:
>        - sound-dai

This passes the example only because the example was simplified to
hide dtschema errors.

The cpu dai node is like:
cpu {
    sound-dai = <&i2s0 0>;
};

and this fails with errors missing phandle tag in 0.

I am converting rest of Samsung audio bindings to dtschema and have
trouble expressing this. How schema should express such cpu node?

Best regards,
Krzysztof
