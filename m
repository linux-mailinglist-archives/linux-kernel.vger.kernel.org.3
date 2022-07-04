Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E23564DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiGDGcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGDGcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80448115E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BACC614B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA70FC3411E;
        Mon,  4 Jul 2022 06:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656916327;
        bh=2ekcqSvi0Fjef1pZ1Us6IGyplCXV15YiS06ugPQfX+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbXRCLY1XXcSeCZqEwDGc2X7gG35ngn9tD7yoWYulO9Uwxd8RXLbl8eIrosJ2cZCt
         Sg4sCgChSHTq422xx5RpdVNB1BP+EFmbweY+PyqnvErCeoBmGj13fIe64mJhK9Lzf1
         vfAe1PrnqLuHjXQgIzwTLcouctZqxH4oZPruo8Fhx5f9apmvPVKFgNLkBhEILaFRd2
         wIdsQU6Fe3PC62peOOABGlGtkpEQh05ucoMea8vInZ8bFz3ZvQzqiseJf8OSH7U01M
         jvjECuZPE7JOacF3cSbDgr2c1O/WFYHYFSAN2Um3p0jfrex0eJGZxvQfTyJmjMOBeX
         S4lt5tSigkuIw==
Date:   Mon, 4 Jul 2022 06:32:04 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 05/11] platform/chrome: cros_ec_proto: separate
 cros_ec_wait_until_complete()
Message-ID: <YsKJZKfmpe5NyNJO@google.com>
References: <20220628024913.1755292-1-tzungbi@kernel.org>
 <20220628024913.1755292-6-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628024913.1755292-6-tzungbi@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:49:07AM +0000, Tzung-Bi Shih wrote:
> EC returns EC_RES_IN_PROGRESS if the host command needs more time to
> complete.  Whenever receives the return code, cros_ec_send_command()
> sends EC_CMD_GET_COMMS_STATUS to query the command status.
> 
> Separate cros_ec_wait_until_complete() from cros_ec_send_command().
> It sends EC_CMD_GET_COMMS_STATUS and waits until the previous command
> was completed, or encountered error, or timed out.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Could someone on the list help to review the remaining patches in the series?
