Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3604C59EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 08:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiB0Hsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 02:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiB0Hsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 02:48:33 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3107F5006C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 23:47:54 -0800 (PST)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 74D81220DE;
        Sun, 27 Feb 2022 07:47:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 173C72F;
        Sun, 27 Feb 2022 07:47:31 +0000 (UTC)
Message-ID: <5aae43769bced6d5c17f143332004285af6d1c4d.camel@perches.com>
Subject: Re: [PATCH 1/2] ALSA: core: remove initialise static variables to 0
From:   Joe Perches <joe@perches.com>
To:     Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sat, 26 Feb 2022 23:47:51 -0800
In-Reply-To: <20220227071253.28193-1-tangmeng@uniontech.com>
References: <20220227071253.28193-1-tangmeng@uniontech.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: 8xnixydnu3zmz4hwsd8h1xfo3msdj6f6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 173C72F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+2xEQu8yUXGYkYqv//dyUnZLZR68nqb9I=
X-HE-Tag: 1645948051-399840
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-02-27 at 15:12 +0800, Meng Tang wrote:
> Initializing the static variable to 0 causes the following error
> when exec checkpatch:
> 
> ERROR: do not initialise statics to 0
> FILE: sound/sound_core.c:142:
> static int preclaim_oss = 0;
> 
> Static variable does not need to be initialised to 0, because
> compiler will initialise all uninitialised statics to 0. Thus,
> remove the unneeded initializations.
[]
> diff --git a/sound/sound_core.c b/sound/sound_core.c
[]
> @@ -139,7 +139,7 @@ struct sound_unit
>  #ifdef CONFIG_SOUND_OSS_CORE_PRECLAIM
>  static int preclaim_oss = 1;
>  #else
> -static int preclaim_oss = 0;
> +static int preclaim_oss;
>  #endif

Probably better without the #ifdef / #else / #endif as

static int preclaim_oss = IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM);


