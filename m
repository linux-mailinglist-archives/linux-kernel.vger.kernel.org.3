Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06959539018
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiEaLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343857AbiEaLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:52:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A8237E2;
        Tue, 31 May 2022 04:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71677B80FB3;
        Tue, 31 May 2022 11:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A355CC385A9;
        Tue, 31 May 2022 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653997963;
        bh=JyxucCjkoZNhcMCXNIn5UdCEtgh6qNYKfKiKUEPOZ8M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H8j4hXEwmJMlZ50Xx7VW2Xg9SyzQeA4GuSFmI1TLkgQ0xGLhKJ7PgKoZEozYqVDf5
         jgOr7Ihh+CqajBbCLBM393vMFm/Uw+9G+ZnyKi/3YMGu03YGS5v0ahJF2S8CkhhZl1
         Ne/Fa8ay4UNpdSTTBSwNmR5qtvpq4GzkyvgIs6OXj6FodlWrL6WtxoCyC2/7wrVwA1
         SYpvDXBMfvGO+dFF3SAvL/HeTczrmCf29bsWxddFiDnlkzVxVgYtR3mJRH/uLaKbEz
         //O7+w+W6ZUfO7RFvbAY+ouuzs5r1AS+2zZ/lAYKXfeameJzJyok/HUBV2jcJ/VuUK
         Ghhv7unJGXf0Q==
Message-ID: <3ad915ec2e8d4a924f61479757b2163ec4b987c5.camel@kernel.org>
Subject: Re: [PATCH] ceph:use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
From:   Jeff Layton <jlayton@kernel.org>
To:     Tan Zhongjun <tanzhongjun@coolpad.com>, xiubli@redhat.com,
        idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 May 2022 07:52:40 -0400
In-Reply-To: <20220531113903.51880-1-tanzhongjun@coolpad.com>
References: <20220531113903.51880-1-tanzhongjun@coolpad.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-31 at 19:39 +0800, Tan Zhongjun wrote:
> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define
> debugfs file operation rather than DEFINE_SIMPLE_ATTRIBUTE.
>=20
> Signed-off-by: Tan Zhongjun=20
> ---
> =A0fs/ceph/debugfs.c | 2 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index bec3c4549c07..05d15a0bbd9b 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -386,7 +386,7 @@ static int congestion_kb_get(void *data, u64 *val)
> =A0return 0;
> =A0}
> =A0
> -DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> +DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> =A0congestion_kb_set, "%llu\n");
> =A0
> =A0

You're now the 5th person to propose this patch.

Here are the first three postings. I'm too lazy to look up the 4th, but
it was just a few months ago.
  =20
https://lore.kernel.org/ceph-devel/1577111958-100981-1-git-send-email-chenw=
andun@huawei.com/
  =20
https://lore.kernel.org/ceph-devel/1612165930-110076-1-git-send-email-jiape=
ng.chong@linux.alibaba.com/
  =20
https://lore.kernel.org/ceph-devel/20211221143614.480385-1-deng.changcheng@=
zte.com.cn/

It's not as simple as doing a 1:1 conversion like this. Please look at
the threads above and offer a revised patch or let us know whether you
want us to drop this one.
--=20
Jeff Layton <jlayton@kernel.org>
