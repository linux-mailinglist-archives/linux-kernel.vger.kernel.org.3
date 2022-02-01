Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F84A5560
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 04:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiBAC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:58:53 -0500
Received: from zinan.dashjr.org ([192.3.11.21]:45044 "EHLO zinan.dashjr.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbiBAC6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:58:52 -0500
X-Greylist: delayed 1717 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2022 21:58:52 EST
Received: from ishibashi.lan (unknown [12.190.236.195])
        (Authenticated sender: luke-jr)
        by zinan.dashjr.org (Postfix) with ESMTPSA id CAA6738ACF8C;
        Tue,  1 Feb 2022 02:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dashjr.org; s=zinan;
        t=1643682613; bh=o3gtN/Vx2dLD0Uuszh1E05+YciwGrZmwzVe2XUNBr9o=;
        h=From:To:Subject:Date:Cc;
        b=Ye7eMxYq7XKPQSss2wi4UOVUH+xPtWuOVPyryzXJu2vkOvncNOIO1cHSBZEM98cMR
         N2istwtUdnZG2dy5W4S0jsD+gqbEYYoFmQlQqhlwPtGxOAtOpJw82Jms1QT01Z2tQy
         U4rYYzbGXBi8GySZo6p6JWbBA2nr25gDMq6yDMjc=
X-Hashcash: 1:25:220201:minchan@kernel.org::SIp/2hwevdeFI/wg:fQvo
X-Hashcash: 1:25:220201:ngupta@vflare.org::/D0dYl5Oml0l5GcH:brE7S
X-Hashcash: 1:25:220201:linux-kernel@vger.kernel.org::JHReup3bv3dE2UgU:bo6US
From:   Luke Dashjr <luke@dashjr.org>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: zram corruption
Date:   Tue, 1 Feb 2022 02:29:26 +0000
User-Agent: KMail/1.9.10
Cc:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202202010229.27088.luke@dashjr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I use ext4 on zram for my temp directories, and sometimes rarely, things get 
corrupted. Using ext4 on a normal disk works fine in the same scenarios.

I haven't managed to figure out what exactly is going on, but I do have a
157 GB strace log of it happening.

One scenario that fairly reliably reproduces it, is building 3 copies of 
binutils in parallel. About half the 
time, /var/tmp/portage/cross-i686-w64-mingw32/binutils-2.37_p1-r2/work/build/binutils/.deps/stabs.Po 
ends up truncated, and one of the builds fails.

The only other scenario I've seen it happen in (much less reproducible), is 
running Bitcoin functional tests. In this case, however, the ext4 structure 
itself got corrupted, and Linux was unable to recover (the directories 
affected became unusable until reboot).

I suspect it's probably a threading-related issue, but it's plausible it could 
be page size related (I *think* I'm using 64k pages) though in the latter 
case I would expect it to be much more common.

https://bugzilla.kernel.org/show_bug.cgi?id=215557
