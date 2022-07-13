Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA5573C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiGMSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiGMSQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E802E9E3;
        Wed, 13 Jul 2022 11:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0CE861CC4;
        Wed, 13 Jul 2022 18:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8812DC34114;
        Wed, 13 Jul 2022 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657736199;
        bh=C+dEVk+WY2th6pPe+z1y4n1Q4cLvYAUNYfWrDpjUD4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pf1liw+3Zhvb5IoIJVnWC/juTneqqYs4RSUcjEkpAu/BRnYh1hM2rljLxr39plwoM
         FkS1uk8zcPKnkRl2Ui/ID9V8OeOBcz5uJYTOf64cyuinuCs0nxWNC5L5lT7BzFC9Og
         0/QjjAfZT4YQKkg5m2z9Ciq1365b+3wQPg/kXckyY7FUNsA8CD30KeM+Q+nMmWDkRb
         IqtFsEShmroJ4hIyv9oC0c9TJINDulw8qcpZTt/T1WM/4nHtVMvpoolTyckC1JyYcq
         FFlXSCSTPVAKeiIOFJPJnPeFC/0x8pQlV12ozIabI6sGy8Uicq8/31JZfJQfNfpCNA
         0ysrpJKcGN2kQ==
Date:   Wed, 13 Jul 2022 11:16:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH 1/1] net: kcm: Use sk_psock size for kcm_psock_cache
Message-ID: <20220713111637.7eca089c@kernel.org>
In-Reply-To: <20220713063204.6294-2-khalid.masum.92@gmail.com>
References: <20220713063204.6294-1-khalid.masum.92@gmail.com>
        <20220713063204.6294-2-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 12:32:04 +0600 Khalid Masum wrote:
> `struct sock` has a member `sk_user_data`, which got its memory allocated
> in `kcm_attach` by `kcm_psock_cache` with the size of `kcm_psock`. Which
> is not enough when the member is used as `sk_psock` causing out of bound
> read.
> 
> Use `sk_psock` size to allocate memory instead for `sk_user_data`.
> 
> Reported-by: syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>

Odd CC list, it looks like a netdev problem but netdev@ is not copied.

We had an other parson looking at this on netdev. Is this happening
when legit kernel socket gets mixed with BPF sockmap?

Does this fix work?

https://lore.kernel.org/netdev/165030056960.5073.6664402939918720250.stgit@oracle-102.nfsv4.dev/
