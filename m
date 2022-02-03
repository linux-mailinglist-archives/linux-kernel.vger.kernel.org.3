Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2F4A9010
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354102AbiBCVjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230422AbiBCVji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643924378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aX6flYCGlec8MUmzayK91nF9NO+GezhygAiZUc4qds=;
        b=XDdmpiKbXyceFjFUG9OEyj4QKgjEh2jzCK94RUP+xTl15s2QxgrSXKeagBmd/jgT5xywfW
        wQb3jnsaMiL9PqA61K63rC1j5nlArHUc4LM96eV/rOZ3VsNxLprmmaJDcoQeuUucrbH6Pr
        s2PKujrDKuCO60SquntVEpfplTHFF0I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-hrEpxLcuO3CKJXlV6-jxNQ-1; Thu, 03 Feb 2022 16:39:37 -0500
X-MC-Unique: hrEpxLcuO3CKJXlV6-jxNQ-1
Received: by mail-qv1-f72.google.com with SMTP id gg10-20020a056214252a00b0041eeb1c2684so3620215qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+aX6flYCGlec8MUmzayK91nF9NO+GezhygAiZUc4qds=;
        b=4eNrKnjIRTbzNm3qi7L6AyR3vOGWqFOFZGhLjanTNDEXA1eMecK8L0BKPwubnKhivH
         1IDelS5qczwzFCTq6agN7dwv7x2unrQlMpHnsn611Gs49ouoFuY+eGOcTMLB/SKBTW1k
         bh3ylhdi2N0dCZyym3uVx9gYe8BYkRw3LksYpxQ6x2Ijxlm2Bt0UWPees2m/nUKr9DEJ
         Ieg1b6t3g0xdIzmYAkBS/M7xEh8X7uPFGPz8lj+9P8mWY0oW2FA4VuB3h828eYjY27dO
         X27+S2G5LR/Jzv1qwF34J7FTNWJyRolhYo95e8lr0voMQtFDbzmRMkztNQjeIohrmUT2
         y0VQ==
X-Gm-Message-State: AOAM533HV54ZQM0Ze6kdhxScy0NxxE74a5g+1isDdQIZi9vl9zPX5avi
        aCtZIbPa0EqojGeELt7N9Ah2fA8P5+SYQshyHgpJaJMzVV4wwd7IEGbuxhKy4lOYsKW9UOtqaav
        PBH6LHRdWExrgj3mHHchrpHeF
X-Received: by 2002:a05:622a:1aa0:: with SMTP id s32mr86330qtc.145.1643924377050;
        Thu, 03 Feb 2022 13:39:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuJzUTTqRgkam6YpJQj0YsDVjx8yNmuoFMgpLG51XVIvp7iv7xlN6IdGc1fnZzDvFnEuKkIA==
X-Received: by 2002:a05:622a:1aa0:: with SMTP id s32mr86319qtc.145.1643924376896;
        Thu, 03 Feb 2022 13:39:36 -0800 (PST)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id u17sm22096qkp.90.2022.02.03.13.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:39:36 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:39:34 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] serial: 8250_bcm2835aux: Add ACPI support
Message-ID: <YfxLlkQsHEb2qbjW@fedora>
References: <20220201185001.926338-1-athierry@redhat.com>
 <412a456d-7294-a124-8a01-f052915348b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412a456d-7294-a124-8a01-f052915348b4@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Florian for your feedback! I have submitted a v2 with the changes
you required.

Adrien

