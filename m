Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3650D2EC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiDXPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiDXPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:39:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404121725C2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5499B80E50
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 15:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FB0C385A9;
        Sun, 24 Apr 2022 15:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650814503;
        bh=2zZcNJ/V9he4AYeJWvmnYEtlaFqoMqeDVCmkTBy3qQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5PAkG2XTBVt3rZdMrLrcV4xbItPaMAoSvpDrHg7YWZRELGf9WrlIdRTKMqy/RdrK
         wZN9HGTW8fz3AB5YnO62nBVtKLt3ANnOT7dt02b9YeliioNhRD4AixHIPMFr5qG0yI
         qyK3QaunRD86SAKU4OcjDq2fCs3sPr+v+CYcJaBY=
Date:   Sun, 24 Apr 2022 17:35:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wujunwen <wudaemon@163.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE micro to
 simplify misc proc_fops
Message-ID: <YmVuJd/ngwjbK+8T@kroah.com>
References: <20220331151557.3946-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331151557.3946-1-wudaemon@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:15:57PM +0000, wujunwen wrote:
> @@ -266,9 +249,11 @@ static char *misc_devnode(struct device *dev, umode_t *mode)
>  static int __init misc_init(void)
>  {
>  	int err;
> +#ifdef CONFIG_PROC_FS

We do not like putting #ifdefs in .c files.  Please remove these, they
should not be needed.

thanks,

greg k-h
