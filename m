Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B10542408
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiFHFNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiFHFNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:13:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B83BE108
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12C1DB823D2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3602C34114;
        Wed,  8 Jun 2022 02:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654654656;
        bh=JbX9uyByw0LnSxHvXxEqaqP/lr8AVeM95L2qB/4wUp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m97Lj18UPzw6bhgJ2Rskd450+GImKwwmJBkIC+Zqc7evsb4wVe/WL6Xnln7XHmsqd
         jCzV5/+bCtCSqjzFFI/AAla4sT4xjxF0G6+KQJmr+jovIX/IqTOUASVkVFXeu3pQyK
         IxMz7nxy+Y5yrIcdbCqvap2uKpiHdVg4Te/dE8JEUArADTkahQoPNMSmujiO/mbHC2
         LH8UsBnywNOm1bq5suQEZb73pN4hw1EMW+p9kO9WEm/0/tUODRNQn3DjR/kRBFgYZd
         vgwWm9KvqYJy7XVmFeCnhzLAFItjmEzcsW/NR0dkvYYpEfT3uqdXY7pX7nsWNeq4P0
         rt3N6tcZgpVxg==
Date:   Wed, 8 Jun 2022 02:17:33 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/15] platform/chrome: cros_ec_proto: return 0 on
 getting wake mask success
Message-ID: <YqAGvRpdUaFb6Vpx@google.com>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
 <20220607145639.2362750-16-tzungbi@kernel.org>
 <CABXOdTcYD6L6vnfNJwYROo1ynGqkabdbpm8JjvvosjtYGV1xow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTcYD6L6vnfNJwYROo1ynGqkabdbpm8JjvvosjtYGV1xow@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:12:25PM -0700, Guenter Roeck wrote:
> On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > cros_ec_get_host_event_wake_mask() used to return value from
> > send_command() which is number of bytes for input payload on success
> > (i.e. sizeof(struct ec_response_host_event_mask)).
> >
> > However, the callers don't need to know how many bytes are available.
> >
> > - Fix cros_ec_get_host_event_wake_mask() to return 0 on success;
> >   negative integers on error.
> >
> > - Add a Kunit test for guarding if send_command() returns 0 in
> >   get_host_event_wake_mask().
> >
> Please split into two patches.

Ack.
