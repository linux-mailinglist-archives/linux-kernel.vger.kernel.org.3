Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B722B58299E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiG0P1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiG0P1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:27:50 -0400
Received: from neo-zeon.de (neo-zeon.de [70.229.12.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F027743321
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:27:49 -0700 (PDT)
Received: from neo-zeon.de (localhost [::1])
        by neo-zeon.de (OpenSMTPD) with ESMTP id e4ac80df;
        Wed, 27 Jul 2022 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=neo-zeon.de; h=message-id
        :date:mime-version:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding; s=1; bh=jU9eOwxiUx1k+ij
        VHwdTw9e3iV0=; b=Z5H8bCbe141mHiQFbax3H26XSHFxkYf1kcmyWLUtEoGAdUP
        iwE3V9eetfzQdEC+E47ugf+mF41dRqpanGwu0B6ofzm6s0QpyuvmVzFPHU7zmnK3
        hrfiyln68xyxPP8kUBO9gVIAySam9kSEoVBeNj0pdo3gYY/WTgYxsWIiaNYk=
Received: by neo-zeon.de (OpenSMTPD) with ESMTPSA id 244ac74f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 27 Jul 2022 08:27:49 -0700 (PDT)
Message-ID: <cba8bbfe-f17b-f745-a98e-4aa735f0da34@neo-zeon.de>
Date:   Wed, 27 Jul 2022 08:27:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/4] Add support for CLSA0101
Content-Language: en-US
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
From:   Cameron Berkenpas <cam@neo-zeon.de>
In-Reply-To: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sound works as expected with this patch.

Sound fails after resume from sleep & hibernate, but as mentioned by 
Lucas in another email, this is currently expected, and will be fixed in 
a patch for a separate issue.

This is arguably better than the old behavior where we only saw right 
channel sound from the left speaker. I say merge it.

Thanks, Lucas!

-Cameron

On 7/27/22 02:59, Lucas Tanure wrote:
> Add Support for the CLSA0101 laptop, an Intel version of CLSA0100.
> This patch has been tested using the CLSA0100, ensuring it
> doesn't break the sound for it.
> We appreciate it if someone with CLSA0101 could verify that this
> the patch works for them.
>
> Changes from V1:
>   - Add CLSA0101 id into scan.c, serial-multi-instantiate.c
>   and cs35l41_hda_i2c.c
>
> Lucas Tanure (4):
>    ALSA: hda: cs35l41: Use the CS35L41 HDA internal define
>    ALSA: hda: cs35l41: Support CLSA0101
>    ACPI: scan: Add CLSA0101 Laptop Support
>    platform/x86: serial-multi-instantiate: Add CLSA0101 Laptop
>
>   drivers/acpi/scan.c                           |  1 +
>   .../platform/x86/serial-multi-instantiate.c   |  1 +
>   sound/pci/hda/cs35l41_hda.c                   | 67 ++++++++++++-------
>   sound/pci/hda/cs35l41_hda_i2c.c               |  3 +
>   sound/pci/hda/patch_realtek.c                 | 12 ++++
>   5 files changed, 58 insertions(+), 26 deletions(-)
>

