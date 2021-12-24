Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5283447EC73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351727AbhLXHHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:07:08 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:56806 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351716AbhLXHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:07:07 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0efJn3FOo65jH0efJnacG6; Fri, 24 Dec 2021 08:07:06 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 24 Dec 2021 08:07:06 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] scsi: lpfc: Cleanup some bitmap handling.
Date:   Fri, 24 Dec 2021 08:06:56 +0100
Message-Id: <cover.1640328930.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1st patch of this serie uses bitmap_zalloc() to simplify code.
The 2nd patch makes sure that the whole bitmap is cleared, should it need more
than 1 long.

However, this 'fcf_rr_bmask' is small (LPFC_SLI4_FCF_TBL_INDX_MAX = 32 bits), so
another option could be to use DECLARE_BITMAP instead of dynamic allocation.

This would simplify code (no more allocation and associated error handling) and
be slighly more efficient (1 less indirection when accessing the bitmap).
In the case the 2nd patch could also be removed (using bitmap_zero() would still
be cleaner (IMHO), but the actual memset+sizeof would work as expected)

Let me know if I should send a v2 with this other approach.

Christophe JAILLET (2):
  scsi: lpfc: Use bitmap_zalloc() when applicable
  scsi: lpfc: Make sure to completely clear some bitmaps

 drivers/scsi/lpfc/lpfc_hbadisc.c |  7 ++++---
 drivers/scsi/lpfc/lpfc_init.c    | 10 ++++------
 drivers/scsi/lpfc/lpfc_sli.c     |  3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

-- 
2.32.0

