Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81674E842B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiCZU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCZU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:26:55 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865EF6556
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EpyjKKqNIRXrzYQY+o6UBoBbTJ4LcHleDtq3fEVCeEc=; b=pWSUnu9topVqu3bzkXVR9nQkUX
        33pXwHN+Z50EjhibNMzKiZt0RQytD1yecu7pmrN81jl2kKBItH4363YhxC8OUF0KvPvNgV3+Q7Rbz
        wwyHP/O1XXrkEHzmZvmhMoB5b/45VeI6iMzynGQ7MUs0W32OYEZ8PlorRXuECX0YgN/21Ym6sYwzd
        HiWdsfEdyIXFhcIEuC4DzYuJB/KV+axhgQZPfezJi+1SvLLjvA7cl5OFi35sSSay9rVbrKeFlVYJE
        yt5H4Vz3JvwtVJ/3gEm/69uYjdqe0TqrHyNpCLoai6kv7a4qlVT2p1I3+vIa2EQLuI59Ol7z26kFZ
        3IphbG/Q==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nYCy9-0007e9-DK; Sat, 26 Mar 2022 21:25:05 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org, airlied@linux.ie,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        daniel@ffwll.ch, harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
        sunpeng.li@amd.com, Xinhui.Pan@amd.com
Cc:     Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] remove DC_FP_* wrappers in dml files
Date:   Sat, 26 Mar 2022 19:24:46 -0100
Message-Id: <20220326202448.2046077-1-mwen@igalia.com>
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

From FPU documentation, developers must not use DC_FP_START/END in dml
files, but invoke it when calling FPU-associated functions (isolated in
dml folder). Therefore, the first patch renames dcn10_validate_bandwidth
in dml/calcs to dcn_ for generalization, declares dcn10_validate_bandwidth
in dcn10 - that calls dcn_validate_bandwidth and wraps with DC_FP_*
accordingly. The second patch removes invocations of DC_FP_* from dml
files and properly wraps FPU functions in dc code outside dml folder.

Melissa Wen (2):
  drm/amd/display: detach fpu operations from dcn10_validate_bandwidth
    in calcs
  drm/amd/display: remove DC_FP_* wrapper from dml folder

 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 10 ++++++++--
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 16 ++++++++++++++++
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  | 19 +------------------
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 --
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |  2 +-
 5 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.35.1

