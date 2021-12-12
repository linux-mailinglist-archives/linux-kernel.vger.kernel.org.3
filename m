Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C6471898
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 06:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhLLFom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 00:44:42 -0500
Received: from relay029.a.hostedemail.com ([64.99.140.29]:18496 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229511AbhLLFol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 00:44:41 -0500
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 82E1A8016A;
        Sun, 12 Dec 2021 05:44:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id B09A130;
        Sun, 12 Dec 2021 05:44:32 +0000 (UTC)
Message-ID: <64e31a014f01755c618c9d126f006b01fbc66408.camel@perches.com>
Subject: Re: [PATCH] ALSA: jack: Check the return value of kstrdup()
From:   Joe Perches <joe@perches.com>
To:     xkernel <xkernel.wang@foxmail.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 21:44:33 -0800
In-Reply-To: <tencent_3D368E118A8AF018A5B1FF16904166B2DC07@qq.com>
References: <tencent_3D368E118A8AF018A5B1FF16904166B2DC07@qq.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.55
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B09A130
X-Stat-Signature: 7g8i1y1yo5fzdd8wmjqo7u4wc876jzdx
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/G2LPGuVsCJ0v43GNEqYpanGSjUVLemfs=
X-HE-Tag: 1639287872-849325
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-12-12 at 01:13 +0800, xkernel wrote:
> kstrdup() can return NULL, it is better to check the return value of it.
[]
> diff --git a/sound/core/jack.c b/sound/core/jack.c
[]
> @@ -509,6 +509,8 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
>  		return -ENOMEM;
>  
>  	jack->id = kstrdup(id, GFP_KERNEL);
> +	if (jack->id == NULL)
> +		return -ENOMEM;

jack should be freed too.

	if (!jack->id) {
		kfree(jack);
		return -ENOMEM;
	}

>  
>  	/* don't creat input device for phantom jack */
>  	if (!phantom_jack) {


