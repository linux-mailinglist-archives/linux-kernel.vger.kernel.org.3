Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9D5803C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiGYSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiGYSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:09:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC16DF1E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B78DEB810A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAC8C341C6;
        Mon, 25 Jul 2022 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658772564;
        bh=e7itVqVjwA+eZ0EqMCGIZYnb3yN+zl+pwcM1UzARAIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgS6TwMJQnYTdafIU4TN1pgn5ZzML0P93axloD2FTqZM7P9Wse6M9iIPBmcGSXz+w
         IWCXZFyxsQIKwcz3i9HszSY4ImSF+MaInaFnjaZQelgWZlDF9ZvdRjlpIvZYjEb0ef
         OWUruNXKQ9MyD8zWYLumNnjvLNYXsXFvgGI6mXp4=
Date:   Mon, 25 Jul 2022 20:09:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] component: try_module_get() to prevent unloading while
 in use
Message-ID: <Yt7cT66p0Bn+aXn5@kroah.com>
References: <20220725160859.1274472-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725160859.1274472-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 05:08:59PM +0100, Richard Fitzgerald wrote:
> Call try_module_get() on a component before attempting to call its
> bind() function, to ensure that a loadable module cannot be
> unloaded while we are executing its bind().

How can bind be called while the module is unloaded?

> If the bind is successful the module_put() is called only after it
> has been unbound. This ensures that the module cannot be unloaded
> while it is in use as an aggregate device.

That's almost never the correct thing to do, what problem is this
solving?

thanks,

greg k-h
