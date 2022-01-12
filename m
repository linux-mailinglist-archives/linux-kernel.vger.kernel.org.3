Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85348C12C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352150AbiALJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:41:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58630 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349438AbiALJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:41:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 36D911F3C4;
        Wed, 12 Jan 2022 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641980489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YoRw8ggy0mLMs9zOLBgezjTbtwR68Vf2hdmnudznCFo=;
        b=Y+wQDdFnpperT5kokCaul7Mp/WVSB1KoTyFckCXPUkpl44Zh/jSjrdFfIB9/R/pJp50bwp
        V4UaEuyO3N9bQEptvDifXl7fEGej3IfCMyDisGtek0V+dmA3Ttcq140cOaXmx+Vf2ZJ4WM
        otRj15gTvaKBBsdQs/xL8XM/U0hHfUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641980489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YoRw8ggy0mLMs9zOLBgezjTbtwR68Vf2hdmnudznCFo=;
        b=gV6F1CQGTa4U9RlEUcZ0VQN3mfgmZCIYkxEgDKbCmyu+1UelwID78mWzqGxzpgCETzKsmW
        cz9zJfYVc8CeGQAw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 27D77A3B84;
        Wed, 12 Jan 2022 09:41:29 +0000 (UTC)
Date:   Wed, 12 Jan 2022 10:41:29 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     =?ISO-8859-15?Q?Martin_Li=A8ka?= <mliska@suse.cz>
cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com
Subject: Re: [PATCH] objtool: Fix -Wformat-truncation seen with GCC 12.
In-Reply-To: <5168172b-d6f2-a13b-5d43-175cd864ebe9@suse.cz>
Message-ID: <alpine.LSU.2.21.2201121039160.27851@pobox.suse.cz>
References: <5168172b-d6f2-a13b-5d43-175cd864ebe9@suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1678380546-953004748-1641980489=:27851"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678380546-953004748-1641980489=:27851
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 12 Jan 2022, Martin Liška wrote:

> The patch fixes the following warning that seems reasonable:
> 
> check.c:2836:58: error: '%d' directive output may be truncated writing between
> 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
> 2836 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/objtool/check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index a9a1f7259d62..9555f7ad57cd 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2852,7 +2852,7 @@ static inline bool func_uaccess_safe(struct symbol
> *func)
>  
>  static inline const char *call_dest_name(struct instruction *insn)
>  {
> -	static char pvname[16];
> +	static char pvname[20];
>  	struct reloc *rel;
>  	int idx;

a similar patch has already been posted (not merged yet though).

https://lore.kernel.org/all/20211223182707.42590-1-kilobyte@angband.pl/

Thanks

Miroslav
--1678380546-953004748-1641980489=:27851--
