Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E14C7B69
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiB1VMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiB1VMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:12:10 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9405C642
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=x6PJ0OStsGSuT4SBe9w5lcOqToFTV+nwUQ86UsifhPk=; b=o/A3ngpsdDVHXa1bTj1PeYsV6D
        KtP6cL4mEKpfwhutiFyHtp58ktDyADJK4EJW25V8BIzEEQ1m5q7kGb07ArokBRZ6ZE4QRta2o2HtH
        0jEMJ90jEJH1GZqJ0hY5JuFWDd6qteQfdAEGV/iLq0eWvryKM2zlY2Q/qtH8S+esGFLXXBt+pOlKQ
        4PDj4z3es+WEtjYNNj9TfG8hdmpOuVEEmh0SfFp5jljTux43e9CRwx38O1NsBvtVpWdJhD7kJe/P2
        ksMrG//Y0XH9cVbdNZeOQu8Z85SKJc9e8UUSNeIJ2lJ/hp9IOkSGk/cA92dILK18YtgCABT/D2+7K
        V2N9Y2JQ==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nOnIf-000CFy-Fr; Mon, 28 Feb 2022 22:11:21 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com, daniel@ffwll.ch, harry.wentland@amd.com,
        Rodrigo.Siqueira@amd.com, sunpeng.li@amd.com, Xinhui.Pan@amd.com
Cc:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Melissa Wen <mwen@igalia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] isolate FPU code from dcn10 and dcn21 to dml folder
Date:   Mon, 28 Feb 2022 20:10:45 -0100
Message-Id: <20220228211047.3957945-1-mwen@igalia.com>
X-Mailer: git-send-email 2.34.1
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

Continuing the work of isolating FPU code from DCN drivers, this
patchset moves FPU-specific operations from dcn10 and dcn21 to dml
folder. I move FPU code from dcn21 to dml/dcn20_fpu since there is a
documentation in dcn20_fpu.c that states dcn20_fpu centralizes:
`all DCN20 and DCN2.1 (DCN2x) functions that require FPU access`

Also, there isn't a dcn10_fpu in dml/dcn10 folder, therefore, I create
related files to isolate FPU structs there.

This patchset depends on previous patch to isolate FPU code from dcn20
driver: https://patchwork.freedesktop.org/series/100487/   

Melissa Wen (2):
  drm/amd/display: move FPU operations from dcn21 to dml/dcn20 folder
  drm/amd/display: move FPU code from dcn10 to dml/dcn10 folder

 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  62 --
 .../drm/amd/display/dc/dcn10/dcn10_resource.h |   4 +
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |  25 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 566 +-----------------
 .../drm/amd/display/dc/dcn21/dcn21_resource.h |  11 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 124 ++++
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  30 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 538 ++++++++++++++++-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |   9 +
 10 files changed, 731 insertions(+), 640 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h

-- 
2.34.1

