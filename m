Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10D48A101
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiAJUii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:38:38 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36779 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiAJUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:38:36 -0500
Received: by mail-oi1-f171.google.com with SMTP id w200so4974197oiw.3;
        Mon, 10 Jan 2022 12:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Zoh6wMeFyB1q/b0sOtK3LGYITSgUJ3C/NH6A9juBU8=;
        b=2/TCz1a8gFj7Hl+VKEAk3+ygA3OijGgxweVW6WEtL+fRCH+dZtm/6KQjLDQGZBpKS0
         PFZGYVoQxb4ahs9XQyik1r2q23fYByytwD7sKrVupA5w+yVw+//y07oZQlG4b6ulU3YR
         oT09G7PuiTm4kKXkks2WlxnQH/RmSxbDbRr553RGVbMtHTE49gh+3/0P305fuuYPHq6j
         zFh2UfuhVhjp7m7EtMfct8x9wiG+HPYUkRcdj5EmfQBZUdYzcocYgBD6LbUqPnPEwQaU
         +4Hsx6mq9jgnpPl0zgQ77ZWc0FGpnQo1765DPp/vH7oazuah9lJhOAoGB2JgqmCoebNp
         enFw==
X-Gm-Message-State: AOAM532FgBeiqkv3Zx/cPQ5bo+Eh/tIzW6PjRhUos4W8q8rs8PFmInoX
        CemVCaexwojOr7U6kNm3qhPFrsasuQ==
X-Google-Smtp-Source: ABdhPJyULNftbUFRzV9LVVc0fFSefRzoxas66hryFyp7dRXGYLZwHT9vmZdYKwCbidU/QHSgGmAcQQ==
X-Received: by 2002:a05:6808:f04:: with SMTP id m4mr15738041oiw.123.1641847116040;
        Mon, 10 Jan 2022 12:38:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l1sm1648514oti.51.2022.01.10.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:38:35 -0800 (PST)
Received: (nullmailer pid 1464106 invoked by uid 1000);
        Mon, 10 Jan 2022 20:38:34 -0000
Date:   Mon, 10 Jan 2022 14:38:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/3] dt-bindings: power: reset: gpio-restart: Add
 -ms suffix to delays
Message-ID: <YdyZSu4eoYuKQvx1@robh.at.kernel.org>
References: <cover.1640887456.git.sander@svanheule.net>
 <35e4da34fb7e18ea7e3af2405db4c5a2a7ba2dfe.1640887456.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e4da34fb7e18ea7e3af2405db4c5a2a7ba2dfe.1640887456.git.sander@svanheule.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 07:06:02PM +0100, Sander Vanheule wrote:
> The delay properties are expressed in milliseconds, so the property
> names should have a -ms suffix. Add the suffix, and deprecate the
> original properties.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../bindings/power/reset/gpio-restart.yaml    | 27 ++++++++++++-------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> index 6a1f4aeebf49..13827fe7b395 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> @@ -62,17 +62,26 @@ properties:
>              restart handlers
>  
>    active-delay:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: Delay (default 100) to wait after driving gpio active [ms]
> +    $ref: '#/properties/active-delay-ms'

While 'active-delay-ms' has a type because '.*-ms' has a type, you just 
removed the type for this property. Now 'active-delay = "foo"' is valid.

While it would be nice to change this, we're pretty much stuck with it 
forever. I don't think supporting both versions in the kernel is worth 
it.

Rob
