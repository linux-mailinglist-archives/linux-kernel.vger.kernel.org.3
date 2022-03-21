Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05B4E33FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiCUXBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiCUW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:59:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FA368335
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BA2NX4x2iCbeURYzHQoS8utf2aV6LFcUCSHKo7/Ktoo=; b=m7yjYgVnAFqCSGLfM2SPG70zm5
        u5DoDzZUx8nWjrOtQjk2fvFgni5O4ThAfLoehlgngcUf+BHvdIAHFfJHn8Q26lzpqNKtHI90FIeKv
        o+rDgQFxTj1mhyRlgNI1+jg0cuI154X/6460cSFvv8jbTIOfzqW9HuR6yqUO92l2qx64SLY8qSmh1
        zOvusQZyRKhlj3bYU1RA9JQtEVFs3E47aNWi/oJH1GPCw7zoQ3PcLJGS1QF7WTYNC7Ew5d3ImQHJu
        3FhVAp1PZ9qs8b0QFV/l3rJsNRzZeiesIx/4N1SUiWgOa84VxfWzVgR2iYavxtDGTNt1h5lThZsst
        07SyPe9Q==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nWPLN-0000ww-GH; Mon, 21 Mar 2022 22:13:37 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     airlied@linux.ie, daniel@ffwll.ch, emma@anholt.net
Cc:     Rob Herring <robh@kernel.org>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/v3d: replace objs lookup steps with drm_gem_objects_lookup
Date:   Mon, 21 Mar 2022 20:13:14 -0100
Message-Id: <20220321211316.1423294-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch just prevents to iterate on a NULL job->bo array during
job cleanup. This situation can happen when v3d_lookup_bos() fails to
allocate memory for the job->bo array and job->bo_count was already set.
The second replace BOs lookup steps in v3d_lookup_bos() with the
common code in drm_gem_objects_lookup().

Melissa Wen (2):
  drm/v3d: cleanup BOs properly when lookup_bos fails
  drm/v3d: replace obj lookup steps with drm_gem_objects_lookup

 drivers/gpu/drm/v3d/v3d_gem.c | 55 ++++-------------------------------
 1 file changed, 6 insertions(+), 49 deletions(-)

-- 
2.35.1

