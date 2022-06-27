Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A851C55D924
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiF0N0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiF0N0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:26:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BCB63FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66040B801BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AC6C3411D;
        Mon, 27 Jun 2022 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656336404;
        bh=7MsHUpxL3zsu4LKADachsIvoM5/0gKY0VcnodHp7Fuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJv1ybgj9PDuO4LIafSqlxRZza1F9s4ECfdY+BZ4swTQNUH3twQpw4rupAiV5KTPm
         /01V/j2gwWA0CKxmECK4I9adJ/P/Jwr7b//ij5pkRWltedk8TWV/aPmdEeKvTwggih
         9rXuOfmoYOnNVzAdX16w0LYF1D9LZmrOy22MA8Y0=
Date:   Mon, 27 Jun 2022 15:26:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     rafael@kernel.org, Jonathan.Cameron@huawei.com, kbusch@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] node: fix error handling in node_init_node_access
Message-ID: <YrmwEUSIrVxM8OSF@kroah.com>
References: <20220621171623.1959231-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621171623.1959231-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 01:16:23AM +0800, Zhi Song wrote:
> dev_set_name() allocates new space to dev->name if it allocates
> successfully. But if we failed to allocate space, there won't be any
> new space for dev->name. Therefore, there's no need for calling
> kfree_const(dev->kobj.name) in dev_set_name()'s error handling.

Can you actually trigger a failure in dev_set_name()?  I ask as we don't
seem to check this anywhere in the driver core, and we should either
just not care (as it really can not fail), or fix up all instances of
that failure.

> If we failed to calling device_register(dev), we just need to call
> put_device(dev) which will do access_node freeing, kobj.name freeing
> and other cleanup.

That is a separate issue, and should be a separate change, right?

thanks,

greg k-h
