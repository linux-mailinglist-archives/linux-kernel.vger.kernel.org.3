Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011525A9B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiIAO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiIAO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FAF83069
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C68261DEF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7666AC433C1;
        Thu,  1 Sep 2022 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662044371;
        bh=cwXudkcBfgOofXhOP04Ksqp/0Zgj9ETlnaXlX5SpIJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8tnSuUrBFqj6u/qHbWGyP832BF5++vnOE+bVFAtpF8ppKpJrYreI+6vKUQJaJEYZ
         C79MeXMsodT8EYwVEeF9YX63W2xm1PV5cMWbJnZ/F05kogymvqlBEDhbjDO7F3C7vn
         0PX0R3M3afy3HNOFCQhvoPbELZ2UQLVbXun222gk=
Date:   Thu, 1 Sep 2022 16:59:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/2] speakup-dummy: Add support for PUNCT variable
Message-ID: <YxDI0LWy/Gqwy1GT@kroah.com>
References: <20220823222501.483597563@ens-lyon.org>
 <20220823222514.929670068@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823222514.929670068@ens-lyon.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:25:02AM +0200, Samuel Thibault wrote:
> This allows to debug the update of the punctuation level.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Index: linux/drivers/accessibility/speakup/speakup_dummy.c
> ===================================================================
> --- linux.orig/drivers/accessibility/speakup/speakup_dummy.c
> +++ linux/drivers/accessibility/speakup/speakup_dummy.c
> @@ -27,6 +27,7 @@ static struct var_t vars[] = {
>  	{ INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
>  	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
>  	{ TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
> +	{ PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
>  	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
>  	V_LAST_VAR
>  };
> @@ -42,6 +43,8 @@ static struct kobj_attribute pitch_attri
>  	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
>  static struct kobj_attribute inflection_attribute =
>  	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
> +static struct kobj_attribute punct_attribute =
> +	__ATTR(punct, 0644, spk_var_show, spk_var_store);
>  static struct kobj_attribute rate_attribute =
>  	__ATTR(rate, 0644, spk_var_show, spk_var_store);
>  static struct kobj_attribute tone_attribute =
> @@ -69,6 +72,7 @@ static struct attribute *synth_attrs[] =
>  	&caps_stop_attribute.attr,
>  	&pitch_attribute.attr,
>  	&inflection_attribute.attr,
> +	&punct_attribute.attr,
>  	&rate_attribute.attr,
>  	&tone_attribute.attr,
>  	&vol_attribute.attr,
> 

Don't we also need a Documentation/ABI/ update for this new sysfs file?

Can you send that as a follow-on patch?

thanks,

greg k-h
