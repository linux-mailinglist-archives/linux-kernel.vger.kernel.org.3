Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360745359F8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346499AbiE0HKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244974AbiE0HJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CD3FC4F1;
        Fri, 27 May 2022 00:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2205B61A4E;
        Fri, 27 May 2022 07:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227F5C385A9;
        Fri, 27 May 2022 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653635262;
        bh=IUjHTZg8XW3nb4CgLtI/7dZRQzTsTt0OL0lA1dn38Ks=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=u4YwSzyIoiKB1al1FWHnHUO4bdYgCahbKfw4d2m+Gu3WxV8gE+a7TrCEf+qJdBb2p
         Wdy5nTtMgw4yQ8xJ9rlNVx4SbGJ/DDkxTgQ4PsTuvgsHJe5rG9T1qfXIeyRNEd62En
         H7HniVWONh1cF6KuKhgyu7EEg0BcrJLOLFKUJZX0Cu/e60Fy7NLbjU3xsmfNsVpUOm
         SEQQu+90NOP6EsbYoS8XPwDt/ntfN5nilJNw9fgOvdMm171I3ldjBrc+3wImODMwrP
         Q6gQpFmYhn0dWT8e7aQ2G5FhQkDzy6uzAHZfkfJmC9rqlZzyfP73gl1C6G39z3+c+g
         HtRni/NuN1ckQ==
Date:   Fri, 27 May 2022 09:07:38 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     basavaraj.natikar@amd.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Chang <David.Chang@amd.com>
Subject: Re: [PATCH v2] HID: amd_sfh: Don't show client init failed as error
 when discovery fails
In-Reply-To: <20220512181848.27347-1-mario.limonciello@amd.com>
Message-ID: <nycvar.YFH.7.76.2205270907320.10851@cbobk.fhfr.pm>
References: <20220512181848.27347-1-mario.limonciello@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022, Mario Limonciello wrote:

> When sensor discovery fails, this means that the system doesn't have
> any sensors connected and a user should only be notified at most one time.
> A message is already displayed at WARN level of "failed to discover,
> sensors not enabled".  It's pointless to show that the client init failed
> at ERR level for the same condition.
> 
> Check the return code and don't display this message in those conditions.
> 
> Fixes: b5d7f43e97da ("HID: amd_sfh: Add support for sensor discovery")
> Reported-by: David Chang <David.Chang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * fix some fat finger typos in commit message
> 
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index dadc491bbf6b..1441787a154a 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -327,7 +327,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  	rc = amd_sfh_hid_client_init(privdata);
>  	if (rc) {
>  		amd_sfh_clear_intr(privdata);
> -		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
> +		if (rc != -EOPNOTSUPP)
> +			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
>  		return rc;

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

