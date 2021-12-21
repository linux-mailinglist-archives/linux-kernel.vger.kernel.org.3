Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9186247BF26
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhLULwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:52:49 -0500
Received: from meesny.iki.fi ([195.140.195.201]:39874 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhLULws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:52:48 -0500
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id DCE3C203BD;
        Tue, 21 Dec 2021 13:52:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1640087563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDILul4DPdQ7u3FrvLmLVHQqmpPqTky0C1q7FxA7Zwk=;
        b=jrzjLJBNlwnrwNALeYy1MAzhHCzyNfWA/BAjzdIv1Ozf70rSOdacq5lJwsOrIrvKF4V9Ys
        4oxnC138JFkIt64jgElA/XR72JwqNi87/DwEr3o8huqD/4Nr5TMcGrpA0hQ6ZMQKrJNdc4
        uGDvfJjzZUSgFhjdvPKiI969weSNwBw=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 4B1CC634C90;
        Tue, 21 Dec 2021 13:52:42 +0200 (EET)
Date:   Tue, 21 Dec 2021 13:52:42 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
Message-ID: <YcHACtgpYcAWU68K@valkosipuli.retiisi.eu>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220210533.3578678-1-clement.leger@bootlin.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1640087563; a=rsa-sha256; cv=none;
        b=GTd8soqhhyq8Z/EwJxdFeK47O0j/aa1YgUAsF0iyauE4goHnvcS+vVwO1CrihvYoF6r4Dm
        6W5icmoJ8tPOSCckwk1D0zbPFWwdyog3qbfU9F3Chh3Gg0qlvrG+pRGWpoGKKO9ICSotBB
        HhnbGxWzIC16VG3HwU2tYcIM3VR9uek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1640087563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDILul4DPdQ7u3FrvLmLVHQqmpPqTky0C1q7FxA7Zwk=;
        b=MBwFYykErRw41yoNr2MNTqGy+jZxMnYFtrGzF5T+AfpoKn1l23Vt7DULSU5Tj070aJ0aOB
        T8vnLxJoH/nIkWTQ4V4HFou5OqtIuJfi9zO/ar1684GCDfcuA7o1l0Zjx69hOlp/xmD4wm
        Eowj+q8uWN4BF4AwoFVSRXr7zQhbZ3I=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:05:33PM +0100, Clément Léger wrote:
> nargs_prop refers to a property located in the reference that is found
> within the nargs property. Use the correct reference node in call to
> property_entry_read_int_array() to retrieve the correct nargs value.
> 
> Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

Thank you (and thanks to Andy for cc'ing me).

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/base/swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 4debcea4fb12..0a482212c7e8 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  		return -ENOENT;
>  
>  	if (nargs_prop) {
> -		error = property_entry_read_int_array(swnode->node->properties,
> +		error = property_entry_read_int_array(ref->node->properties,
>  						      nargs_prop, sizeof(u32),
>  						      &nargs_prop_val, 1);
>  		if (error)

-- 
Sakari Ailus
