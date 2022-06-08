Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F905542527
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiFHFOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiFHFNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF9A3BE139
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B58616AA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166ADC3411F;
        Wed,  8 Jun 2022 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654654647;
        bh=AzhrCIWg84o+mxvFW4ZCcksLht8pFT6BvEbsGS24Tr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lcJwW+H3Xpd31ezTP4c5X+za/nMkEeTyF6fZNBlFXbsjsiDHFcwazSab6Hu9sWP4j
         c20Z3TzwEMy5NxZUUHYMQPZ7qjgVOU0Drsj63zZyNOR6eHQgbgwwB8OIZkOxE5/UV6
         +hpjBvzilOoBsDtUWhwsp3qCnEzVDodlw8I7rTm0TqpHpQj+yJEmnkDJNI2vfoG3CN
         /u7dqLDNs7ZWAkZfdRszxsVWfvIToq8hHFSx2nJzCXVDNK5v06NHnv3G9YW9vdnesG
         FoC4VvjRTJ0/qJakOhMOm9y0s+G18C/uiGH1G/0ijmNasqT5BiqTeNyj3IG+EY/JWb
         KKD73eHWchMgA==
Date:   Wed, 8 Jun 2022 02:17:23 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] platform/chrome: cros_ec_proto: return 0 on
 getting version mask success
Message-ID: <YqAGsx6TTHTFeTNs@google.com>
References: <20220607145639.2362750-1-tzungbi@kernel.org>
 <20220607145639.2362750-15-tzungbi@kernel.org>
 <CABXOdTcBauEYxOokg3PHGwYfgjAHNPGzf9mHnNFTyhcucv+rzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTcBauEYxOokg3PHGwYfgjAHNPGzf9mHnNFTyhcucv+rzg@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:11:23PM -0700, Guenter Roeck wrote:
> On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > cros_ec_get_host_command_version_mask() used to return value from
> > send_command() which is number of bytes for input payload on success
> > (i.e. sizeof(struct ec_response_get_cmd_versions)).
> >
> > However, the callers don't need to know how many bytes are available.
> >
> > - Fix cros_ec_get_host_command_version_mask() to return 0 on success;
> >   negative integers on error.
> >
> > - Remove the unneeded `ver_mask` initialization as the callers should
> >   take it only if cros_ec_get_host_command_version_mask() returns 0.
> >
> > - Add a Kunit test: `ver_mask` has some garbage bytes from previous
> >   EC_CMD_GET_NEXT_EVENT but there is no host sleep to make sure the
> >   caller checks the return values correctly.
> >
> This should be separate patches.

Ack.  Will fix in next version.
