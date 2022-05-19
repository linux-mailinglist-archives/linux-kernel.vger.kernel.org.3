Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9B52D7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiESPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiESPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE42ED8E4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9788061B44
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A592FC34100;
        Thu, 19 May 2022 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652974644;
        bh=o9NYOVKlhQksuLmmbPu2xa1Ccb8CCOjP4CsJ1ZrRfRI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p10lRkwJV+KspvEkQcNa60FZkcXO5s8xGQ7zHDIsLKhu4WZUn9fx11xoP88CgO4NF
         S44rjCOWj0W0wSMEpXGqcP9KN4ZtN5We7z/Sl/T3tFBAPmjC57cVY17f5L6HAHK7KD
         mekbUO4xoAhFTAVRhDcDs6+JOlnxouazetEOsIKSU8vVTgVd3cy8aYrNQl/4LBzkYt
         ZUE23eGed55oJJfKwOm0C8tWtdVDE1y0yd9buLyxcvQZG/VHvIu2rfOKXNUk8J8Zly
         r5c67pHkZaDeGMJqMQDXv3eUsVW5UEJ5M419rdj9hDyGwuTK3BkxZfgfUl0AQ07uSD
         XF+C/0QKLBViA==
Message-ID: <dabd25e5bc80be5cd2f7d04d6c119b644e706f47.camel@kernel.org>
Subject: Re: [PATCH 2/2] netfs: Export netfs_put_subrequest()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 11:37:22 -0400
In-Reply-To: <165296980976.3595490.4887936702439978407.stgit@warthog.procyon.org.uk>
References: <165296980082.3595490.3561111064004493810.stgit@warthog.procyon.org.uk>
         <165296980976.3595490.4887936702439978407.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 15:16 +0100, David Howells wrote:
> Export netfs_put_subrequest() and a couple of tracepoints.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> ---
>=20
>  fs/netfs/main.c    |    3 +++
>  fs/netfs/objects.c |    1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/fs/netfs/main.c b/fs/netfs/main.c
> index 068568702957..3d0283f8d0b9 100644
> --- a/fs/netfs/main.c
> +++ b/fs/netfs/main.c
> @@ -15,6 +15,9 @@ MODULE_DESCRIPTION("Network fs support");
>  MODULE_AUTHOR("Red Hat, Inc.");
>  MODULE_LICENSE("GPL");
> =20
> +EXPORT_TRACEPOINT_SYMBOL(netfs_rreq);
> +EXPORT_TRACEPOINT_SYMBOL(netfs_sreq);
> +
>  unsigned netfs_debug;
>  module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
>  MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index d6b8c0cbeb7c..cbc40d052b46 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -160,3 +160,4 @@ void netfs_put_subrequest(struct netfs_io_subrequest =
*subreq, bool was_async,
>  	if (dead)
>  		netfs_free_subrequest(subreq, was_async);
>  }
> +EXPORT_SYMBOL(netfs_put_subrequest);
>=20
>=20

I don't see any callers of this outside of netfs. What's the rationale
for exporting it?
--=20
Jeff Layton <jlayton@kernel.org>
