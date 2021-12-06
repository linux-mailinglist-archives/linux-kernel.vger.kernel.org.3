Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6BE46A8ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbhLFVBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349944AbhLFVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:01:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D056C0613F8;
        Mon,  6 Dec 2021 12:58:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i12so9141126wmq.4;
        Mon, 06 Dec 2021 12:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n1BPb/xYNq5uaSEPzD+4FghbzJv0Q/8If9Mqaicr6qI=;
        b=WZjBMyXZESGunyh9UbdimRNbU77++G6ojMueTs+jjMbXTl9bdOfuDRT2rXwFI4DBxC
         od0HjK2ICjreVMEu1LsL7xFOk4aE4V2mmOfnt3u0Fu1pHLpAkc3g0hUkmQBujsYEdTjq
         vzawGH2eCZhUm7Rwcne7LUWlWr1SbY/bMiX/Ax7FKjMF6RTb9EOqoE8wDjmqfIvbYouj
         cM6MUpvdmHqLIPxXrzCB9pfStlRcLfeLuGo/x0QbTqSHjz4l2DXCDZSvYBDdiqujhCSB
         xCycVui+MxZxOZyBtbTSF1LHbNsqb2/4cy7vwvpTOgvu04UY8FzXC8Im0B6tpFq646kc
         3oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n1BPb/xYNq5uaSEPzD+4FghbzJv0Q/8If9Mqaicr6qI=;
        b=XlV3Xg5WyN0VL7dl8tK19+fKcp24Yw/upEeruwmOxJcG71GKc22wBUbIhMRBcJBnSw
         TOjM+QA8HM82fqqR2cnGTiULjxw9cAf47niV9WUlYoklyLB2qIFEe3Zu3KpMQUrLCepL
         DVL8UHVx0Rbyhmg5KnB9zjR8nJFudfkH1TYujiHbmeIwbf51t58zdsdJoEQZQeSxT/7D
         1i0YVJHDx5bGOKqo0AFLBIy6PkX0hHXgYTGYVUUn2rj4Tk6S1310DWK7DDQbSolWnVvq
         QH82RhTQJFu5PwMhkPgTZuZe5M3rOtGCYeoFdWg4wnc3UZp0XySxBXtJYIy4pWEC4ToM
         nuAA==
X-Gm-Message-State: AOAM532AKyDrzESy13GT+r/cuMQ3V2tWka9tUh1UV4pDdCUiJAyQP5Il
        dZaI+RuSmnsf7f6wf+iq0CAaM7NtqwNLhA==
X-Google-Smtp-Source: ABdhPJwIwVkZi4QOIq6rIMRFZMYenWd2/mDUnEveInUHh+/OYBkw2bSkdY86H9qUkQTSFN80wvsWTQ==
X-Received: by 2002:a05:600c:1d91:: with SMTP id p17mr1196223wms.193.1638824280148;
        Mon, 06 Dec 2021 12:58:00 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06972f325cc5fe1c0146.dip0.t-ipconnect.de. [2003:c7:8f4e:697:2f32:5cc5:fe1c:146])
        by smtp.gmail.com with ESMTPSA id j40sm469413wms.19.2021.12.06.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:57:59 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:57:58 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v3 2/5] Docs: usb: update comment and code near decrement our
 usage count for the device
Message-ID: <ca8fd26ccff6521c7477a2035e703e099da56214.1638771720.git.philipp.g.hortmann@gmail.com>
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comment: decrement our usage count ..
and code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Corrected format of function name to skel_release()
V2 -> V3: Moved correction of the function name to an own patch in this
          patch series
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 1fd7bf1dbdb0..c336dfd82426 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -254,8 +254,8 @@ talk to the device, the release function in the driver is called. In
 this function we decrement our private usage count and wait for possible
 pending writes::
 
-    /* decrement our usage count for the device */
-    --skel->open_count;
+    /* decrement the count on our device */
+    kref_put(&dev->kref, skel_delete);
 
 
 One of the more difficult problems that USB drivers must be able to
-- 
2.25.1

