Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848A4A32B2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353471AbiA2X7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 18:59:55 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42654
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353267AbiA2X7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 18:59:53 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C6A9940E57;
        Sat, 29 Jan 2022 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643500784;
        bh=MVZak3zbu1eAFTux4Sw6Mf40DF40XMJ5a+qfLFJumpc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uR9BM+uT9n5Xdcu07wH15WQfEAwRCnIzzlbxh8oIHnifLd3KxPbgHV2qWxT9gwFc6
         6IkXyjJOgKAsxZyDUrlu5LnopTTIiiUFkGhXFcWS4N/qVtc41EXlyss9Z93KoJQ7BU
         j/Yz3KzlBTstaJtEooG1QIglsv8xPvtXZLcj1icQKZxgyYN+SWkDHKaH+chSTJtz+o
         EIHcxf65ml1E8FhQMEHOsikd6+u7/o8qy7fYnjRE+8DuE+l6QccO1dlsbutGUCJKJJ
         kh6LOsT6amgfaA6FyVg8s74Yn/IvE7kaJwl2KE2x7BL3hvwzTR/DRrm9b0vtjruohu
         eqZiMs2EKKRbw==
Message-ID: <7441eef2-5d5d-8bfe-42bb-423d0d865a52@canonical.com>
Date:   Sat, 29 Jan 2022 15:59:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next 1/3] apparmor: Fix match_mnt_path_str() and
 match_mnt() kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, serge@hallyn.com
Cc:     jmorris@namei.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220129025101.38355-1-yang.lee@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220129025101.38355-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 18:50, Yang Li wrote:
> Fix a spelling problem and change @mntpath to @path to remove warnings
> found by running scripts/kernel-doc, which is caused by using 'make W=1'.
> 
> security/apparmor/mount.c:321: warning: Function parameter or member
> 'devname' not described in 'match_mnt_path_str'
> security/apparmor/mount.c:321: warning: Excess function parameter
> 'devnme' description in 'match_mnt_path_str'
> security/apparmor/mount.c:377: warning: Function parameter or member
> 'path' not described in 'match_mnt'
> security/apparmor/mount.c:377: warning: Excess function parameter
> 'mntpath' description in 'match_mnt'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>  security/apparmor/mount.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index 23aafe68d49a..5cc5de062fc8 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -304,7 +304,7 @@ static int path_flags(struct aa_profile *profile, const struct path *path)
>   * @profile: the confining profile
>   * @mntpath: for the mntpnt (NOT NULL)
>   * @buffer: buffer to be used to lookup mntpath
> - * @devnme: string for the devname/src_name (MAY BE NULL OR ERRPTR)
> + * @devname: string for the devname/src_name (MAY BE NULL OR ERRPTR)
>   * @type: string for the dev type (MAYBE NULL)
>   * @flags: mount flags to match
>   * @data: fs mount data (MAYBE NULL)
> @@ -359,7 +359,7 @@ static int match_mnt_path_str(struct aa_profile *profile,
>  /**
>   * match_mnt - handle path matching for mount
>   * @profile: the confining profile
> - * @mntpath: for the mntpnt (NOT NULL)
> + * @path: for the mntpnt (NOT NULL)
>   * @buffer: buffer to be used to lookup mntpath
>   * @devpath: path devname/src_name (MAYBE NULL)
>   * @devbuffer: buffer to be used to lookup devname/src_name

