Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD648EE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiANQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243535AbiANQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:41:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F14C06173F;
        Fri, 14 Jan 2022 08:41:03 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so10655240otu.2;
        Fri, 14 Jan 2022 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J1UmNq+ppbWs7SoY4W/B9ZNYoHZxk1ZPFDGTpv499T0=;
        b=ogX3bmAtSD1H1xotF/dhn4f+3dQPEp2ja1Z5/m6qJHIiVkk+Qiwur9EtL7ZUsAvWxy
         0xFg0XWCMXa0YtzknYGzMlXzupTyZQJw4QmafQDkS0IZEdZuvIuTju/gISvtYWSqN3FN
         Li/CNXjqiVbYhmb7lwQQUbVix9EEWP8XcAMa+OKco3s0yQv8gsnNufC3KuJQ1ulHhhoc
         MVb3sFumTBKgvJlbm8sD7/9ofIu0EQXo1xQCptUSb40/f2pmcVcNRj2pcGuzUDXSR6k3
         TT1jM/UWWLOyIhsyPKeKGkkBi3pOWm7HgMpe+gcAkNtrNUpW5V47OhxmQqIlrcEI4Uio
         oSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J1UmNq+ppbWs7SoY4W/B9ZNYoHZxk1ZPFDGTpv499T0=;
        b=Fm98bIYOofPjgFQX+cCtCo6hh4rlAAOa86FOiFINATByKpFKNvNmaZnfzjmDUE6TYp
         wtMZw5fqxr2OYnKtDMPZnK1UM7YoOkPVIl4v1jeOjOOLNJuIlMqNUL4fOgB/VzYtK1wI
         YtPfuTJuTuJp8/j1DXJ/15wHdfKL+UgqYKtpkmljOBrasTdakLho35GBo/pn6Yz+mJgU
         cKN9Y3Sm3bhZwSLKbZXFtOVz8PjWhQSxeB/XLz0REHIf3TvK5jo38hoDL5UKUIZ0hrER
         61kZMg4YLj+ieYmUNFFiOBJ+bDhimuLUEXXCjT4LJrpkZAoW2DxaHByoVbyXgLjI140/
         /3DQ==
X-Gm-Message-State: AOAM531kyX3ehuHjg8CBUlR+R05Lvi3jrftx2qEhNlBm1WB2GDEicFNN
        8tF2hkPBngjd668dhnGe2SU=
X-Google-Smtp-Source: ABdhPJw+1p+KEEbcR0VhkRosaEjIU/CCI42cmD1knhH+f0UgrwtNxXJwLEh8udS6IHQmAvts4tOdDw==
X-Received: by 2002:a9d:7451:: with SMTP id p17mr7216739otk.159.1642178463336;
        Fri, 14 Jan 2022 08:41:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g7sm1493949otn.72.2022.01.14.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:41:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Jan 2022 08:41:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net
Subject: Re: [PATCH v3 1/2] ABI: hwmon: Document "label" sysfs attribute
Message-ID: <20220114164101.GA1270407@roeck-us.net>
References: <20220110182256.30763-1-paul@crapouillou.net>
 <20220110182256.30763-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110182256.30763-2-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 06:22:55PM +0000, Paul Cercueil wrote:
> Add the "label" sysfs attribute, which can contain a descriptive label
> that allows to uniquely identify a device within the system.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Notes:
>     v2: New patch
>     v3: No change
> 
>  Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
>  Documentation/hwmon/sysfs-interface.rst     | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
> index 1f20687def44..653d4c75eddb 100644
> --- a/Documentation/ABI/testing/sysfs-class-hwmon
> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
> @@ -9,6 +9,14 @@ Description:
>  
>  		RO
>  
> +What:		/sys/class/hwmon/hwmonX/label
> +Description:
> +		A descriptive label that allows to uniquely identify a
> +		device within the system.
> +		The contents of the label are free-form.
> +
> +		RO
> +
>  What:		/sys/class/hwmon/hwmonX/update_interval
>  Description:
>  		The interval at which the chip will update readings.
> diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
> index 85652a6aaa3e..209626fb2405 100644
> --- a/Documentation/hwmon/sysfs-interface.rst
> +++ b/Documentation/hwmon/sysfs-interface.rst
> @@ -99,6 +99,10 @@ Global attributes
>  `name`
>  		The chip name.
>  
> +`label`
> +		A descriptive label that allows to uniquely identify a device
> +		within the system.
> +
>  `update_interval`
>  		The interval at which the chip will update readings.
>  
