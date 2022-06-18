Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925BB550617
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiFRQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:20:42 -0400
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 09:20:41 PDT
Received: from er-systems.de (er-systems.de [IPv6:2a01:4f8:202:3214::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503AADF1D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 09:20:41 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id C1533D6006E;
        Sat, 18 Jun 2022 18:13:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id 9A85BD6006D;
        Sat, 18 Jun 2022 18:13:29 +0200 (CEST)
Date:   Sat, 18 Jun 2022 18:13:28 +0200 (CEST)
From:   Thomas Voegtle <tv@lio96.de>
To:     =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        amd-gfx@lists.freedesktop.org
cc:     linux-kernel@vger.kernel.org
Subject: Performance drop using deinterlace_vaapi on 5.19-rcX
Message-ID: <0249066a-2e95-c21d-d16a-fba08c633c0b@lio96.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-74181308-596245421-1655568809=:14383"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.6/26576/Sat Jun 18 10:07:50 2022 signatures .
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74181308-596245421-1655568809=:14383
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Hello,

I noticed a performance drop encoding a mpeg file to a h264 video using
the vaapi option deinterlace_vaapi on a Haswell i5-4570 with Linux
5.19-rc1.

A 10 minute long video takes normally 41s to convert, now with 5.19-rc1
it takes about 2m 36s.

My ffmpeg line is:
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128
-hwaccel_output_format vaapi -i test.vdr -vf 'deinterlace_vaapi' -c:v
h264_vaapi

Removing the option deinterlace_vaapi shows no difference in performance 
between 5.18 and 5.19-rcX.


I bisected this down to:

commit 047a1b877ed48098bed71fcfb1d4891e1b54441d
Author: Christian König <christian.koenig@amd.com>
Date:   Tue Nov 23 09:33:07 2021 +0100

     dma-buf & drm/amdgpu: remove dma_resv workaround


and wasn't able to revert this one on top of 5.19-rcX.

I tried the predecessor commit:

commit 73511edf8b196e6f1ccda0fdf294ff57aa2dc9db (HEAD)
Author: Christian König <christian.koenig@amd.com>
Date:   Tue Nov 9 11:08:18 2021 +0100

     dma-buf: specify usage while adding fences to dma_resv obj v7

which is fine.

Using ffmpeg 5.0.1 with libva 2.10.0 and intel vaapi driver 2.4.1


  Best regards,

     Thomas
---74181308-596245421-1655568809=:14383--

