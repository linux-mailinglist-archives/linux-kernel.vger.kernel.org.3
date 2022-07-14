Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F65741FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiGNDl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGNDl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:41:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5322124D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF7661E19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5130DC341C6;
        Thu, 14 Jul 2022 03:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657770116;
        bh=eT9omIn4kKWdfUlUaQXR2a5ggi02sLElztkOMF5CfQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/svTuRMpeD2b+EYgWTK+toxwaKs0RsuIEf9qV2MoOBLZ/7VAyvqp1VtLYuN4R0AS
         lwWJG/YbXw9Ua9SdDXGGdp3zoDLqcrQJc8iOKQrw8h/azhSceACMEYuPLp5JiD1Y4M
         LbXH1PSugsDaiVbzinTvkOLa8xUFDMcD+muezCvBvh7Yb17OUHwefVBZDsWTiGZl/f
         mjN9oVONMzJoX8cPSC8J5CPO6ykjVz5ux/ROH8ihl86H4VwBeFpmwMROBqJ1vHXz6G
         K1JrrTXqeuG6CT8iuqeYlbemy0Z1FKJtAU4ZuomIgA7s0rZ3OG+24B7rHhNta7rJB1
         FBsHX5OZN9S6A==
Date:   Thu, 14 Jul 2022 03:41:53 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 09/11] platform/chrome: cros_ec_proto: return
 standard error codes for EC errors
Message-ID: <Ys+Qga+5B0150BwY@google.com>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
 <20220628024913.1755292-10-tzungbi@kernel.org>
 <CABXOdTeCFsXYdd6uVDYkOY-tGno_wW-ZyuMb44a63tFABic+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTeCFsXYdd6uVDYkOY-tGno_wW-ZyuMb44a63tFABic+NA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:23:58AM -0700, Guenter Roeck wrote:
> On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > cros_ec_wait_until_complete() checks `msg->result` for
> > EC_CMD_GET_COMMS_STATUS.  However, it doesn't return standard error codes
> > like most of others.
> 
> The callers of cros_ec_send_command() do the mapping. I am not sure if
> it is a good idea to change that; it may have undesired side effects
> (such as changing the userspace ABI) for callers of
> cros_ec_send_command() not expecting this change. It would also result
> in double mapping in some situations.

Agreed.  Let's drop the change.
