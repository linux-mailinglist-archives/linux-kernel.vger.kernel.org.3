Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65A59E750
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiHWQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiHWQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:30:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B533F183B7;
        Tue, 23 Aug 2022 06:00:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42F3022AF8;
        Tue, 23 Aug 2022 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661259606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeCJBSVqOhAGWvX3rLkYeyZ0F7kVhjopz07El5TE35g=;
        b=dTe0UjB0yIX4nY3F+zS/45UC/LYnMpG/bzHrG777J0GXX56UWfZAqtaLxrKBZ2xZdAipyW
        OPwm+hEPTUlKGJUqf8a4in/v5bPEpPl8WUIIRUKXyB2b/2b788rVR/9rQjKNxYy5GEyoo4
        /qNFOoaTCBO3rgspBD74zkUFwuM71pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661259606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeCJBSVqOhAGWvX3rLkYeyZ0F7kVhjopz07El5TE35g=;
        b=1RnAL5TU+0iluQFJM11wgDO7i6gMipFzGf7G919num4t1EGMDljjFIXBOzonsjjpaw63iF
        z8jiEIzW0hE9SyAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5A2D13A89;
        Tue, 23 Aug 2022 13:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id upyNMlXPBGMBVgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 23 Aug 2022 13:00:05 +0000
Date:   Tue, 23 Aug 2022 15:00:03 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: Re: [PATCH v2] watchdog: wdat_wdt: Set the min and max timeout
 values properly
Message-ID: <20220823150003.6199b8fd@endymion.delvare>
In-Reply-To: <20220806081524.5636461a@endymion.delvare>
References: <20220806081524.5636461a@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, 6 Aug 2022 08:15:24 +0200, Jean Delvare wrote:
> The wdat_wdt driver is misusing the min_hw_heartbeat_ms field. This
> field should only be used when the hardware watchdog device should not
> be pinged more frequently than a specific period. The ACPI WDAT
> "Minimum Count" field, on the other hand, specifies the minimum
> timeout value that can be set. This corresponds to the min_timeout
> field in Linux's watchdog infrastructure.
> 
> Setting min_hw_heartbeat_ms instead can cause pings to the hardware
> to be delayed when there is no reason for that, eventually leading to
> unexpected firing of the watchdog timer (and thus unexpected reboot).
> (...)

This patch no longer applies as it conflicts with:

commit 6d72c7ac9fbe26a77800676507da980436b40b2f
Author: Liu Xinpeng
Date:   Tue Apr 26 22:53:28 2022 +0800

which made it into kernel v5.19.

Having reviewed the commit mentioned above, I must say I'm skeptical. I
can't see how setting min_timeout to 1 arbitrarily has been considered
a good thing. This allows setting timeout values lower than the ACPI
WDAT "Minimum Count" field, while presumably the hardware does not
support such short timeouts.

Furthermore, calling watchdog_timeout_invalid() to validate the timeout
value is a good idea in principle, however, given that min_timeout is
now 1 and max_hw_heartbeat_ms is defined, the function is no longer
checking much.

My understanding is that the original code was checking the right
limits (from the WDAT table's perspective) using the wrong fields (from
the watchdog core's perspective). This fix from Liu is not really fixing
the problem (min_hw_heartbeat_ms and max_hw_heartbeat_ms are still set,
which enables watchdog core facilities that the driver doesn't need
IMHO) and is adding a new problem (the timeout limits defined in the
ACPI WDAT table are no longer checked).

I will rebase my patch on top and address both problems.

-- 
Jean Delvare
SUSE L3 Support
