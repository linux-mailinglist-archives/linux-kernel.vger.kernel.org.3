Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78E476D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhLPJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:44:48 -0500
Received: from relay038.a.hostedemail.com ([64.99.140.38]:61890 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232987AbhLPJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:44:47 -0500
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 9AB54809C7;
        Thu, 16 Dec 2021 09:44:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 2848120030;
        Thu, 16 Dec 2021 09:44:44 +0000 (UTC)
Message-ID: <c0adb7fef6d51691e864fdaef5595a9014b12f1e.camel@perches.com>
Subject: Re: [PATCH v2] drm/tilcdc: add const to of_device_id
From:   Joe Perches <joe@perches.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>, jyri.sarha@iki.fi
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 01:44:43 -0800
In-Reply-To: <20211216092652.33414-1-wangxiang@cdjrlc.com>
References: <20211216092652.33414-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2848120030
X-Spam-Status: No, score=-1.79
X-Stat-Signature: 1ejh8eydgrzx5rpem8djar6wyzg5mp6s
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX185wlLD3hW15ItyHxqsUmsy66CD1KCd2q0=
X-HE-Tag: 1639647884-52255
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-16 at 17:26 +0800, Xiang wangx wrote:
> struct of_device_id should normally be const.
[]
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
[]
> @@ -60,7 +60,7 @@ void tilcdc_module_cleanup(struct tilcdc_module *mod)
>  	list_del(&mod->list);
>  }
>  
> -static struct of_device_id tilcdc_of_match[];
> +static const struct of_device_id tilcdc_of_match[];

This line could likely be removed instead.

$ git grep -w -n tilcdc_of_match
drivers/gpu/drm/tilcdc/tilcdc_drv.c:63:static struct of_device_id tilcdc_of_match[];
drivers/gpu/drm/tilcdc/tilcdc_drv.c:590:static struct of_device_id tilcdc_of_match[] = {
drivers/gpu/drm/tilcdc/tilcdc_drv.c:595:MODULE_DEVICE_TABLE(of, tilcdc_of_match);
drivers/gpu/drm/tilcdc/tilcdc_drv.c:603:                .of_match_table = tilcdc_of_match,

> @@ -587,7 +587,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct of_device_id tilcdc_of_match[] = {
> +static const struct of_device_id tilcdc_of_match[] = {
>  		{ .compatible = "ti,am33xx-tilcdc", },
>  		{ .compatible = "ti,da850-tilcdc", },
>  		{ },


