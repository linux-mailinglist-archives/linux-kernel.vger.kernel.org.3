Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32270487A09
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiAGQBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:01:08 -0500
Received: from foss.arm.com ([217.140.110.172]:41976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbiAGQBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:01:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E190D13D5;
        Fri,  7 Jan 2022 08:01:06 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A17663F66F;
        Fri,  7 Jan 2022 08:01:05 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: booting.rst: Clarify EL2 and cover v8-R64
Date:   Fri,  7 Jan 2022 16:00:54 +0000
Message-Id: <20220107160056.322141-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

clarify the wording of the ARM64 boot protocol requirements, to both
cater for the introduction of secure EL2 in Armv8.4, but also for the
addition of the Armv8-R64 architecture branch.
There is an ARM ARM supplement for v8-R64[1], and also a free model[2].

On top of those clarifications, there are at least two other issues to
consider for v8-R64 on Linux, I wonder if those should be documented
somewhere, although I doubt that booting.rst is the right place:
- Linux clears the NS/NSTable bit in the PTEs. In non-secure world those
  bits are ignored, but when in secure world this means "secure PA".
  That luckily matches the design here (secure-only), but we should avoid
  re-purposing those bits in the future (which would be technically
  possible when running only non-secure).
- The GIC needs to be implemented using a "single Security state" for
  the Linux GIC driver to work. The model mentioned above defaults to
  a security aware GIC, so needs to be told off using the command line.
  I wonder if this is should be explicitly mentioned somewhere, to avoid
  disappointment by implementors later.

I'd be grateful for any hint whether to state those things and where to
put them.

Cheers,
Andre

[1] https://developer.arm.com/documentation/ddi0600/latest/
[2] https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms/arm-ecosystem-models

Andre Przywara (2):
  arm64: booting.rst: Clarify on requiring non-secure EL2
  arm64: booting.rst: Cover Armv8-R64

 Documentation/arm64/booting.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.25.1

