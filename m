Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A35779B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 05:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiGRDU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 23:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 23:20:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0810551
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 20:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BBDCB80860
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7AEC3411E;
        Mon, 18 Jul 2022 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658114450;
        bh=RcYWaF4+2Ao+VJQR+EOrodpthSRqlZ5w8sHpzG/tp4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8OOiTJag1aph8kvOB0LuctzbhAPOAyBznZgkHa6WO0tewEpT7CdmiPkXbOuw92fI
         RHRqoAUfZgbrhwMsnS80gdKhH8radqHHrdyADIIbsearvJ7Zr1e/T2S+Rw91xR+3qj
         gVzNh+R7m//h6v99+0LohFVEbCfxPgpI8dnAmeVkEspbpGuQoYjv8pN8FhCMR5evkY
         /WwG27cR8Eqlddytz+UfOVAmOXHPoRIbnTOnO5agPbz8sooP7ioR2KhyEJOoKwrCm+
         ZZbku/AqTxlAI9mwLc7dOR/nUT4PeOrkwPhYNqcCHeyuVm7oyH9mITLM9k7XY6JnTH
         PcuetesU+4TuQ==
Date:   Mon, 18 Jul 2022 03:20:47 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Patryk Duda <pdk@semihalf.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Update version on
 GET_NEXT_EVENT failure
Message-ID: <YtTRj2MF5/nd94Pe@google.com>
References: <20220714160951.9364-1-pdk@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714160951.9364-1-pdk@semihalf.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 06:09:51PM +0200, Patryk Duda wrote:
> @@ -750,6 +750,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
>  	u8 event_type;
>  	u32 host_event;
>  	int ret;
> +	u32 ver_mask = 0;

Drop the initialization.  Ideally, `ver_mask` wouldn't be touched if `ret` is
less than 0.
