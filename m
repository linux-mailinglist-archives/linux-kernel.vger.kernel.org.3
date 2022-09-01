Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9555A9D95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiIAQ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiIAQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:56:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7DD7F0AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:56:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m2so17632314pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=31hDz1wQLt+YntFJu/iwPZ+2Y+WLUY8hYvk6RHOqfkQ=;
        b=tCaJBpnUz9MZYiS32xcpOLm9VGZyva66yQX1HGhuLouAuUqIirVMmRY0paGq5F8dC8
         znI70Eoo+q/gja0vfIm2bjJx79MKCSowJpdUDyAWHhy/R094oiemq5QF/UQYIEAB0NXX
         Ix34uh7J4MO9Ii4dbsLkMBVrfmu6CUSWCtqRwu56MADdIZFyFv+6153GruikPvW0NcFa
         tn9CayfMZdHokaKIstBEmc2ldbcRAN9zaJh/8xhe6FajG/CG1Ms81J51eEN7Qfo91XOU
         Sx4vFJPEOKm/7Tm0Ds6s/OzVg6SRB+43hpf9KxMhJR4so2OlbPvMjAef+NbWkOFcrgxK
         yugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=31hDz1wQLt+YntFJu/iwPZ+2Y+WLUY8hYvk6RHOqfkQ=;
        b=yvJdsgTYC8L+TgLpKuZQ4sGRrCzXD5HuxxfjjtP0CurANF67OOqtH6GQkjOy3uadjE
         BJ1X0HEC3bWchgDk1a87+SAnlsIQ9ot3SrdxQfGnPweltDeVKdnoYJx3zY/0qIqDNeeY
         DFp+G9r+/OuXx/umvJAtLNvXtD90APiW2MBHiLbyQ5UD+LUyG9W7LaJlicE6BlV+NTeq
         UX2hlhF5Y72VrCJjnFUPdm4NqKi/WPY7GTeOEySXKwhg0B78lL34jKT1UU5rskMtzCh1
         5OWeIMcOB3+OlFZf5kmOUpYgc/PPgwb8Ckqu6hx9wadB6+CSDMur7D6hcknORZWqxh+H
         +nLA==
X-Gm-Message-State: ACgBeo0h/quAqEMlJ0wEZmnXZTclxouWuzp1NYsfUtNuLV3drWiqcYIY
        +G/nAAKpxcafYS75yDj4rjFzLg==
X-Google-Smtp-Source: AA6agR4Fk9iNXNhICWxfWVGM9V2kKsXJa1qpp7jqqYWi+NLWro46FzQaNb9DkxQnCd9hKUuszDWVFQ==
X-Received: by 2002:a17:902:bcc9:b0:16e:fde3:172f with SMTP id o9-20020a170902bcc900b0016efde3172fmr32356752pls.36.1662051364446;
        Thu, 01 Sep 2022 09:56:04 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b0016c9e5f290esm5998243plg.10.2022.09.01.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:56:04 -0700 (PDT)
Date:   Thu, 1 Sep 2022 09:56:02 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        stable <stable@kernel.org>, Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH] driver core: fix driver_set_override() issue with empty
 strings
Message-ID: <20220901095602.4684970b@hermes.local>
In-Reply-To: <20220901163734.3583106-1-gregkh@linuxfoundation.org>
References: <20220901163734.3583106-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Sep 2022 18:37:34 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Python likes to send an empty string for some sysfs files, including the
> driver_override field.  When commit 23d99baf9d72 ("PCI: Use
> driver_set_override() instead of open-coding") moved the PCI core to use
> the driver core function instead of hand-rolling their own handler, this
> showed up as a regression from some userspace tools, like DPDK.
> 
> Fix this up by actually looking at the length of the string first
> instead of trusting that userspace got it correct.
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: 23d99baf9d72 ("PCI: Use driver_set_override() instead of open-coding")
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: stable <stable@kernel.org>
> Tested-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 15a75afe6b84..676b6275d5b5 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -63,6 +63,12 @@ int driver_set_override(struct device *dev, const char **override,
>  	if (len >= (PAGE_SIZE - 1))
>  		return -EINVAL;
>  
> +	/*
> +	 * Compute the real length of the string in case userspace sends us a
> +	 * bunch of \0 characters like python likes to do.
> +	 */
> +	len = strlen(s);
> +
>  	if (!len) {
>  		/* Empty string passed - clear override */
>  		device_lock(dev);

Thanks for addressing this.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
