Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980E059705F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiHQODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbiHQOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A361E2A416
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB7161470
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6A5C433D6;
        Wed, 17 Aug 2022 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660744915;
        bh=onQBAQrTvzBoSaPRMgU2il8XbYjBkQYd+3ol/wEvy0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVy+DezmuGi0ohxLLFKmRwvCSDaeFvJ7vRlwGl//Us2Eq5lmyX+JP+tiHR3WKgWxb
         orkcYkHpcMgFe1Tjztvn+TbD9/qn8wGfuMnXAhUKg/rhSIn6+dFJdYeA+qhISSpeUG
         9ccL5S+aO1sPN/829esQh580bmnKefQhgF9EYIkJMQRBXlPamxVmcRApxE4rov4tDp
         Dg173h/1OsJL36hWX03NENX4qKZilaH65gGEMMxeHdJ6rhsu/vbKyklIGm/LoEV0VS
         G+fT1+5ZqDzxyK///z96gFGTPp/L+57KEZevj+WC+A66zS3DVuX3gpNrL4lpAUNZ/t
         VZ0gevN2OWGlA==
Date:   Wed, 17 Aug 2022 16:01:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binderfs: rework superblock destruction
Message-ID: <20220817140149.pfakskeyxkqcot54@wittgenstein>
References: <YvzUS/7bd1mm6c/V@kroah.com>
 <20220817130306.96978-1-brauner@kernel.org>
 <Yvz0JkdxXwY8uDyT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yvz0JkdxXwY8uDyT@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:59:02PM +0100, Al Viro wrote:
> On Wed, Aug 17, 2022 at 03:03:06PM +0200, Christian Brauner wrote:
> 
> > +static void binderfs_kill_super(struct super_block *sb)
> > +{
> > +	struct binderfs_info *info = sb->s_fs_info;
> > +
> > +	if (info && info->ipc_ns)
> > +		put_ipc_ns(info->ipc_ns);
> > +
> > +	kfree(info);
> > +	kill_litter_super(sb);
> > +}
> 
> Other way round, please - shut the superblock down, *then*
> free the objects it'd been using.  IOW,

I wondered about that but a lot of places do it the other way around.
So maybe the expected order should be documented somewhere.
