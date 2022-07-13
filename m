Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E6A572E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiGMGhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiGMGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DFCCA6E0;
        Tue, 12 Jul 2022 23:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FE361C3C;
        Wed, 13 Jul 2022 06:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE27C34114;
        Wed, 13 Jul 2022 06:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657694237;
        bh=Pw1I724OC/j5jlM0PCtT/WmkZp+NkEnzCWrfGr+EzVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrkiyJKL4LZ8Ull6nLdOM6zNZRpI27n7U3K5sErFqSQgtTrC/wXzx5+V67pB7Pv1B
         7DhE7DbRzjgMrjfy7JXV2Sodkh8EjbO6Wt9l7u39tSLvSNDJfk1HA5HMIZxINOTaRM
         yfE1PPjd2yttQVx+FHZm31Kl6eeBrx0pnpstymrg=
Date:   Wed, 13 Jul 2022 08:37:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <Ys5oGuh2WCgEG5Js@kroah.com>
References: <20220713063204.6294-1-khalid.masum.92@gmail.com>
 <20220713063204.6294-2-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713063204.6294-2-khalid.masum.92@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:32:04PM +0600, Khalid Masum wrote:
> `struct sock` has a member `sk_user_data`, which got its memory allocated
> in `kcm_attach` by `kcm_psock_cache` with the size of `kcm_psock`. Which
> is not enough when the member is used as `sk_psock` causing out of bound
> read.
> 
> Use `sk_psock` size to allocate memory instead for `sk_user_data`.
> 
> Reported-by: syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
>  net/kcm/kcmsock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
