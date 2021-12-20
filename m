Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9732647B245
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhLTRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:42:17 -0500
Received: from foss.arm.com ([217.140.110.172]:60378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233373AbhLTRmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:42:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4992A6D;
        Mon, 20 Dec 2021 09:42:16 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5E4D3F774;
        Mon, 20 Dec 2021 09:42:14 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, f.fainelli@gmail.com,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH 0/2] Sensor readings fixes
Date:   Mon, 20 Dec 2021 17:41:53 +0000
Message-Id: <20211220174155.40239-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this was supposed to be an easy fix on how sensor readings are handled
across different FW versions while maintaining backward compatibility,
but the solution raised for me more questions than the issue itself...
...so I posted as an RFC.

In a nutshell, since SCMI FWv3.0 spec, sensors SCMI_READING_GET command
can report axis and timestamps too, beside readings, so a brand new
scmi_reading_get_timestamped protocol operation was exposed (used by IIO)
while the old scmi_reading_get was kept as it was, already used by HWMON
subsystem for other classes of sensors.

Unfortunately, also the flavour of reported values changed from unsigned
to signed with v3.0, so if you end-up on a system running against an SCMI
v3.0 FW platform you could end up reading a negative value and interpreting
it as a big positive since scmi_reading_get reports only u64.

01/02 simply takes care, when a FW >= 3.0 is detected, to return an error
to any scmi_reading_get request if that would result in tryinh to carry
a negative value into an u64.

So this should rectify the API exposed by SCMI sensor and make it
consistent in general, in such a way that a user calling it won't risk to
receive a false big-positive which was indeed a 2-complement negative from
the perpective of the SCMI fw.
	
So far so good...sort of...since, to make things more dire, the HWMON
interface, which is the only current upstream user of scmi_reading_get
DOES allow indeed to report to the HWMON core negative values, so it was
just that we were silently interpreting u64 as s64 :P ...

...as a consequence the fix above to the SCMI API will potentially break
this undocumented behaviour of our only scmi_reading_get user.

Additionally, while looking at this, I realized that for similar reasons
even on systems running the current SCMI stack API and an old FW <=2.0
the current HWMON read is potentially broken, since when the FW reports
a very big and real positive number we'll report it as a signed long to
the HWMON core, so turning it wrongly into a negative report: for this
reason 02/02 adds a check inside scmi-hwmon to filter out, reporting
errors, any result reported by scmi_reading_get so big as to be considered
a negative in 2-complement...

...and this will probably break even more the undocumented behaviours...

Any feedback welcome !

Thanks,
Cristian

Cristian Marussi (2):
  firmware: arm_scmi: Filter out negative results on scmi_reading_get
  hwmon: (scmi) Filter out results wrongly interpreted as negatives

 drivers/firmware/arm_scmi/sensors.c |  8 ++++++++
 drivers/hwmon/scmi-hwmon.c          | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.17.1

