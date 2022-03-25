Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3444E6DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358372AbiCYGBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbiCYGBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D240C55BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB9761A5C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F7C340E9;
        Fri, 25 Mar 2022 05:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648187968;
        bh=JrQ5EjduRL0JWK0cXwjRN24G4d+ZfnDmuHtrvdsmKsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCtZtIVeaw2WNudwa2RLG6RIBXfqsvJPXuktAV3pAG3hNTaGNmpEtF4QN5YpJi+0E
         rMWVwi26NYDRVFznAEgveqQLpxa2HD4p799jGlpg/tdgoRygTxI+KQcoPsJkDEbbAh
         qz2uxG/HuY/Ln6xrGHa0Z8yh8hUwyAqnxykUy8N8=
Date:   Fri, 25 Mar 2022 06:59:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <Yj1aPdSjmTMAhTCo@kroah.com>
References: <20220324213445.3055538-1-tansuresh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324213445.3055538-1-tansuresh@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 02:34:45PM -0700, Tanjore Suresh wrote:
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -49,6 +49,14 @@ struct fwnode_handle;
>   *		will never get called until they do.
>   * @remove:	Called when a device removed from this bus.
>   * @shutdown:	Called at shut-down time to quiesce the device.
> + * @shutdown_pre:	Called at the shutdown-time to start the shutdown
> + *			process on the device. This entry point will be called
> + *			only when the bus driver has indicated it would like
> + *			to participate in asynchronous shutdown completion.
> + * @shutdown_post:	Called at shutdown-time  to complete the shutdown
> + *			process of the device. This entry point will be called
> + *			only when the bus drive has indicated it would like to
> + *			participate in the asynchronous shutdown completion.

Sorry, but no, this should not be needed expecially as you did not offer
any justification or reason to do so.

Nor did you send the remaining changes in the series to me, and why
would these be "trivial"?

Please work with others at Google who know how to submit changes to the
kernel first and get their review and signed-off-by on the changes
before sending them out again.

good luck!

greg k-h
