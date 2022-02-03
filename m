Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25E4A8C19
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353632AbiBCTAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiBCTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:00:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A45C061714;
        Thu,  3 Feb 2022 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OX4FoFwge+kg5TJRm0dYZgCT8Xpq4pM9n0EVmYcAT3Y=;
        t=1643914823; x=1645124423; b=Sht9bQq8A0eaWO23tUbDBLoPX1npIW3gL+6LIbnbnVPqHvH
        OpeHJhm7hTySGQe2ZWpA4U7AZiFmI1NPj0KUjTxgKfFz41rRVW76Mu9iP/c7BPI3/MC6CIJiEhOiY
        Ho1BVQrjaArJOk32l4NU1BSVpnB9/cFDhMsNgu8PHyRWPBLxhSwmWhJTvtLAT0puaBxRO8LtemCQO
        qk+uTZfhvycLH2d4A8O6dU7/1yheyt2Cq5P5bAKAStr2/chVOC0QJEzAeYSoztIFRrCI5zYBLDrYD
        sTsHUj6muPNjFGHP5/rq5ZRCgoDAei50BXXQivB9cll8jpyNRMjlA25sQxvoMu6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFhL7-00E6Qj-DW;
        Thu, 03 Feb 2022 20:00:17 +0100
Message-ID: <19ea449a9f772f12058785be873c7ea5504a0eb8.camel@sipsolutions.net>
Subject: Re: AX200 cards broken after firmware cc-a0-67
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gabriel C <nix.or.die@googlemail.com>,
        linux-wireless@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-firmware@vger.kernel.org
Date:   Thu, 03 Feb 2022 20:00:16 +0100
In-Reply-To: <CAEJqkgiV1_jXhoxoxVG4EwV7t=cA=j1F+T-LCEuajJN8x25mtQ@mail.gmail.com>
References: <CAEJqkgiV1_jXhoxoxVG4EwV7t=cA=j1F+T-LCEuajJN8x25mtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-03 at 18:58 +0100, Gabriel C wrote:
> Hello,
> 
> I own 3 boxes with AX200 cards, one is a Killer AX1650x, the other two
> AX200 [8086:2723] (rev 1a).
> 
> After commit 4474519a1fd4e7167afae7c5ca2c1b93e17b4d8a in
> linux-firmware tree, which updates
> the firmware to cc-a0-67.ucode, all cards are crashing with microcode
> errors. Firmware  cc-a0-66.ucode
> is still fine. The kernel doesn't seem to matter, as soon I update the
> firmware to >=67 ( I tested 68 too ),
> everything crashes in an endless loop.
> 
> I'll attach a dmesg, from 5.17.0-rc2, the same crash happens with 5.16* etc.
> 

> [   18.453176] iwlwifi 0000:03:00.0: 0x00001062 | ADVANCED_SYSASSERT 

So I think this is broadcast filtering again, discussed previously on
the list. Turn off CONFIG_IWLWIFI_BCAST_FILTERING for now, a fix is in
the works.

johannes
