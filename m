Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08D474571
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhLNOoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhLNOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:44:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB5C061574;
        Tue, 14 Dec 2021 06:44:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FF9EB819E2;
        Tue, 14 Dec 2021 14:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951E5C34601;
        Tue, 14 Dec 2021 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639493054;
        bh=8kE25lHJX38zMYqV26wAuz0kRQbim0EKFMko/TuL3ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UrAA9n3JIlqfRx72ruF3mVgM9KP5nDEjQIBuPfresFgCEmarF5Fh4jk0icEhgErLY
         uufVVRt2+yXAd/FKLgYN1JwjjhkOOwkl8miq9pBznBh9aE2MHIvSA7hbeHbtqSSmF3
         7S63tDasO/FbzKIQkgNXJgCiDsgEO664LYvFOSk/ZaKeP4FT9QYgOPjrkvOqzaV+3x
         n2ozNvt5EYWJK/r7CQNNmZbkU/5OC8vcFsnsCxm/L2AIyrKyJtt5Gn5PC1ibvMu3pB
         DUyRfXU2trDc7hCV8hWeF1uZn/3obYcX7xAozSxGPSWePytP/WZfsCycrQ4wyo4KJJ
         qMXZn9nLXNW3g==
Date:   Tue, 14 Dec 2021 15:44:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Subject: Re: [PATCH v2 0/4] uvc: Restore old vdev name
Message-ID: <20211214154409.292c1173@coco.lan>
In-Reply-To: <20211207003840.1212374-1-ribalda@chromium.org>
References: <20211207003840.1212374-1-ribalda@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue,  7 Dec 2021 01:38:36 +0100
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> In order to have unique entity names, we decided to change the name of
> the video devices with their functionality.
> 
> This has resulted in some (all?) GUIs showing not useful names.
> 
> This patchset reverts the original patch and introduces a new one to
> allow having different entity and vdev names.
> 
> Since some distros have ported the reverted patch to their stable
> kernels, it would be great if we can get this sent asap, to avoid making
> more people angry ;).

Yeah, patch 1 of this series makes a lot sense. Reporting a camera
as "Video Capture" doesn't seem too nice, specially if multiple
UVC cameras are present.

Yet, I'm a little in doubt about patch 4/4, for a couple of reasons:

1. IMO, on *all* devices (not only uvc), it makes sense to add a "Metadata" 
   at the name string for the metadata devnodes.

   So, I would implement such logic at V4L2 core instead.

2. Such metadata string should be there not only for the entity name,
   but also for vdev->name;

3. I would, instead, set the device name as:

	vdev->name = "Meta: <foo>"

   for the meta devnodes, as the string size is limited.

4. As almost all devices have either video capture or video
   output, I can't see any value to unconditionally add
   "Video Capture"/"Video Output" strings. It would only make
   sense to have them on devices that report having both.

Regards,
Mauro

> 
> v2:
>  - Add Documentation
>  - Mark maybe unused variables as __maybe_unused
>  - Add Suggested-by
> 
> Ricardo Ribalda (4):
>   Revert "media: uvcvideo: Set unique vdev name based in type"
>   media: v4l2-dev.c: Allow driver-defined entity names
>   media: Documentation/driver-api: Document entity name
>   media: uvcvideo: Set unique entity name based in type
> 
>  Documentation/driver-api/media/v4l2-dev.rst |  4 ++++
>  drivers/media/usb/uvc/uvc_driver.c          | 14 +++++++++++---
>  drivers/media/v4l2-core/v4l2-dev.c          |  4 +++-
>  3 files changed, 18 insertions(+), 4 deletions(-

Thanks,
Mauro
