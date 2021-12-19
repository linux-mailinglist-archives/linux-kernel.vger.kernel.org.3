Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970AD47A145
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhLSQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:12:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42186 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhLSQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:12:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43BECB80D33
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 16:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DE2C36AE8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639930357;
        bh=0XUEXga0QjpLC3Qez3+e7Vr/cfe724y1IwvOj5kc70Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tlte6GGCDuFKmvhvkCNO+3u3TTmAll0JO99BBW3h/LD/mo2xc6Rp3Q7WQeK+LB16w
         qkckoge1G3iEZ8UySjWFPjRdJgLsG+vtjtuOaUmrHgc/OK/1YRrkjR1K4+ZUWvQ83P
         ExnDhJdg9I3nT3CJCdY2vxGxsspDLFQRcU2fB3CmeZNdkedT8BNKCukabTi1x56DRk
         /zuBPYxhxkr9tJA1oZzZ+S56OFUjG97RRcm4LJARiR1uE9+qnlZG+Pkb/gE0lkPdeV
         6xQS5LgCOGmPGV/auCEXwXhTy2PjDHtnY53TWCFBUFFirJBMx9pVkb6gQ2D9i0YqjK
         BRVz+h8gMRAoQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs: replace some -ENOTTY with -EINVAL
Date:   Sun, 19 Dec 2021 18:12:30 +0200
Message-Id: <20211219161230.2674012-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211219161230.2674012-1-ogabbay@kernel.org>
References: <20211219161230.2674012-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-ENOTTY is returned in case of error in the ioctl arguments themselves,
such as function that doesn't exists.

In all other cases, where the error is in the arguments of the custom
data structures that we define that are passed in the various ioctls,
we need to return -EINVAL.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c   | 2 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 4 ++--
 drivers/misc/habanalabs/common/memory.c           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index d4eb9fb9ea12..e7534b5129fa 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -475,7 +475,7 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	default:
-		rc = -ENOTTY;
+		rc = -EINVAL;
 		break;
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index f571641c19ae..7ddf70a0ca8a 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -693,7 +693,7 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
-		rc = -ENOTTY;
+		rc = -EINVAL;
 		break;
 	}
 
@@ -748,7 +748,7 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	default:
 		dev_err(hdev->dev, "Invalid request %d\n", args->op);
-		rc = -ENOTTY;
+		rc = -EINVAL;
 		break;
 	}
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e5f7b23cbf94..b8596846f3dc 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2031,7 +2031,7 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 
 	default:
 		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
-		rc = -ENOTTY;
+		rc = -EINVAL;
 		break;
 	}
 
@@ -2156,7 +2156,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	default:
 		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
-		rc = -ENOTTY;
+		rc = -EINVAL;
 		break;
 	}
 
-- 
2.25.1

