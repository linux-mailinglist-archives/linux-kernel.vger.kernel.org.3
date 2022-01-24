Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF45B499C68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579297AbiAXWFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:05:16 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53874 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376896AbiAXVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:16:34 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 7CF74200230;
        Mon, 24 Jan 2022 21:16:25 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 49054809C2; Mon, 24 Jan 2022 22:15:21 +0100 (CET)
Date:   Mon, 24 Jan 2022 22:15:21 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     andrew.shadura@collabora.co.uk
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: hid-u2fzero.c - hw_random quality set to 1?
Message-ID: <Ye8W6bOh85JILMrp@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there any specific rationale why the quality of the hid-u2fzero.c hw
rng is set to 1, meaning that only 1 bit of entrop is added per 1024 bits
of input (see drivers/char/hw_random/core.c)? That actually means that
currently no entropy is credited at all, as this driver will return not
more than 64 bytes (= rc), and then

	rc * current_quality * 8 >> 10

evaluates to 0. While this is addressed by a patch I just submitted,[*]
I'd like to know whether this low quality setting is correct.

Thanks,
	Dominik

[*] https://lore.kernel.org/linux-crypto/20220124202951.28579-6-linux@dominikbrodowski.net/
