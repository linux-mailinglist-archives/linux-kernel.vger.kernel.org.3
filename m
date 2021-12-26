Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6341647F70D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 15:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhLZOCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 09:02:30 -0500
Received: from relay038.a.hostedemail.com ([64.99.140.38]:36299 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230035AbhLZOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:02:29 -0500
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 1C1D221882;
        Sun, 26 Dec 2021 14:02:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id B753B2002F;
        Sun, 26 Dec 2021 14:02:20 +0000 (UTC)
Message-ID: <796577bb0052f4f08f58882dfc86734d72f2aa29.camel@perches.com>
Subject: Re: [PATCH] usb: raw-gadget: upgrade license identifier
From:   Joe Perches <joe@perches.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 26 Dec 2021 06:02:19 -0800
In-Reply-To: <CA+fCnZeC8PbDg_E3WWtqGBAwUs65Y7=b5DG=whN-CaOEs5uS7g@mail.gmail.com>
References: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
         <Ycgi7GiU2udbjF2f@kroah.com>
         <CA+fCnZeC8PbDg_E3WWtqGBAwUs65Y7=b5DG=whN-CaOEs5uS7g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ft5xce35ewnq54qgqq4oa1rx6php6xbt
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B753B2002F
X-Spam-Status: No, score=-0.97
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YVLRXQ1kWJwjA0dugZf74JpeaiVhG8e4=
X-HE-Tag: 1640527340-980293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-12-26 at 14:19 +0100, Andrey Konovalov wrote:
> I wonder if checkpatch could alert about considering GPL-2.0+ when
> adding new files.

No. Licensing is up to the author/submitter.

One nit checkpatch could warn about is the use of MODULE_LICENSE("GPL v2")
rather than MODULE_LICENSE("GPL") as that's an unnecessary distinction.

See: https://lore.kernel.org/all/alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de/

Given there are a several thousand existing uses of "GPL v2" in the
kernel, do this check only for new patches and not existing files.
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9dd..5b00f1f491aff 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7418,6 +7418,10 @@ sub process {
 				WARN("MODULE_LICENSE",
 				     "unknown module license " . $extracted_string . "\n" . $herecurr);
 			}
+			if (!$file && $extracted_string eq '"GPL v2"') {
+				WARN("MODULE_LICENSE",
+				     "Prefer \"GPL\" over \"GPL v2\" - see: https://lore.kernel.org/all/alpine.DEB.2.21.1901282105450.1669\@nanos.tec.linutronix.de/\n" . $herecurr);
+			}
 		}
 
 # check for sysctl duplicate constants


