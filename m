Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B75552E06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348586AbiFUJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiFUJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D112610
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0963F6158A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B25C3411C;
        Tue, 21 Jun 2022 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655802842;
        bh=pL3F/GzW42CiWS3Yg7kxKAhUPHN0SvH5MN8TC9Ak5Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxZR/FXJDErptEmSt8w5bbP3lzcw8Pa0UN3pNctXJj6XoJvXKNRHYLFmLeAHT8Hne
         Y/vk8BjMpi+WlbfYL86H4bdjt/F9w7JUoAOri+UriPenbf4hAsVTB25nDTGDumShI+
         2DOqbBwF8z3abaBH9vr9PjQooQ9aP9RMYdHd/D665Ga/nlAcNu9J9eJByO1OMXIhuu
         QaKhvfvg1Redd8RR4HPWUrNv2A9PrayetJotZPEAAad7nos1kPNyw4xuii2mXg3fYc
         iO80v43tNR84DXygZxj7AFi7P2p7y6NDh8HLFA/OWa13KKl2rZ1RXWvZH6BAa1x3tp
         r7C2oCfMU6Arg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3ZxL-0001jL-LK; Tue, 21 Jun 2022 11:13:56 +0200
Date:   Tue, 21 Jun 2022 11:13:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     keliu <liuke94@huawei.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, elder@kernel.org,
        gregkh@linuxfoundation.org, vireshk@kernel.org,
        pure.logic@nexus-software.ie, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Directly use
 ida_alloc()/free()
Message-ID: <YrGL0zLpdzGbcWE4@hovoldconsulting.com>
References: <20220527063528.2356712-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527063528.2356712-1-liuke94@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 06:35:28AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Is "keliu" really your full legal name?

> ---
>  drivers/staging/greybus/audio_manager.c  |  8 ++++----
>  drivers/staging/greybus/authentication.c |  4 ++--
>  drivers/staging/greybus/fw-download.c    |  4 ++--
>  drivers/staging/greybus/fw-management.c  | 12 ++++++------
>  drivers/staging/greybus/gbphy.c          |  4 ++--
>  drivers/staging/greybus/loopback.c       |  6 +++---
>  drivers/staging/greybus/raw.c            |  6 +++---
>  drivers/staging/greybus/vibrator.c       |  6 +++---
>  8 files changed, 25 insertions(+), 25 deletions(-)
 
> diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
> index 297e69f011c7..01dd1cd958ea 100644
> --- a/drivers/staging/greybus/authentication.c
> +++ b/drivers/staging/greybus/authentication.c
> @@ -348,7 +348,7 @@ int gb_cap_connection_init(struct gb_connection *connection)
>  err_del_cdev:
>  	cdev_del(&cap->cdev);
>  err_remove_ida:
> -	ida_simple_remove(&cap_minors_map, minor);
> +	ida_free(&cap_minors_map, minor);
>  err_connection_disable:
>  	gb_connection_disable(connection);
>  err_list_del:
> @@ -372,7 +372,7 @@ void gb_cap_connection_exit(struct gb_connection *connection)
>  
>  	device_destroy(cap_class, cap->dev_num);
>  	cdev_del(&cap->cdev);
> -	ida_simple_remove(&cap_minors_map, MINOR(cap->dev_num));
> +	ida_free(&cap_minors_map, MINOR(cap->dev_num));
>  
>  	/*
>  	 * Disallow any new ioctl operations on the char device and wait for

The above looks incomplete since you do not change the ida_simple_get()
in gb_cap_connection_init().

Please check for any similar mistakes throughout.

Johan
